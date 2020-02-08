Return-Path: <SRS0=BhYR=34=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C203AC352A1
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 17:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6C8621775
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 17:01:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbgBHRBC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Feb 2020 12:01:02 -0500
Received: from mga06.intel.com ([134.134.136.31]:14586 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727377AbgBHRA5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Feb 2020 12:00:57 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Feb 2020 09:00:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,418,1574150400"; 
   d="scan'208";a="232687538"
Received: from spandruv-desk.jf.intel.com ([10.54.75.21])
  by orsmga003.jf.intel.com with ESMTP; 08 Feb 2020 09:00:56 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     dvhart@infradead.org, andy@infradead.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@linux.intel.com,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH 1/2] platform/x86/intel-uncore-freq: Fix static checker issue and potential race condition
Date:   Sat,  8 Feb 2020 09:00:51 -0800
Message-Id: <20200208170052.57712-2-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200208170052.57712-1-srinivas.pandruvada@linux.intel.com>
References: <20200208170052.57712-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a possible race condition when:
All CPUs in a package is offlined and just before the last CPU offline,
user tries to read sysfs entry and read happens while offline callback
is about to delete the sysfs entry.

Although not reproduced but this is possible scenerio and can be
reproduced by adding a msleep() in the show_min_max_freq_khz() before
mutex_lock() and read min_freq attribute from user space. Before
msleep() finishes, force every CPUs in a package offline.

This will cause deadlock, with offline and sysfs read/write operation
because of mutex_lock. The uncore_remove_die_entry() will not release
mutex till read/write callback returns because of kobject_put() and
read/write callback waiting on mutex.

We don't have to remove the sysfs folder when the package is offline.
While there is no CPU present, we can fail the read/write calls by
returning ENXIO error. So remove the kobject_put() call in offline path.

This also address the warning from static checker, as there is no
access to "data" variable after kobject_put:
"The patch 49a474c7ba51: "platform/x86: Add support for Uncore
frequency control" from Jan 13, 2020, leads to the following static
checker warning:

        drivers/platform/x86/intel-uncore-frequency.c:285 uncore_remove_die_entry()
        error: dereferencing freed memory 'data'
"

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/platform/x86/intel-uncore-frequency.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/x86/intel-uncore-frequency.c b/drivers/platform/x86/intel-uncore-frequency.c
index 2b1a0734c3f8..c83ec95e8f3e 100644
--- a/drivers/platform/x86/intel-uncore-frequency.c
+++ b/drivers/platform/x86/intel-uncore-frequency.c
@@ -97,6 +97,9 @@ static int uncore_read_ratio(struct uncore_data *data, unsigned int *min,
 	u64 cap;
 	int ret;
 
+	if (data->control_cpu < 0)
+		return -ENXIO;
+
 	ret = rdmsrl_on_cpu(data->control_cpu, MSR_UNCORE_RATIO_LIMIT, &cap);
 	if (ret)
 		return ret;
@@ -116,6 +119,11 @@ static int uncore_write_ratio(struct uncore_data *data, unsigned int input,
 
 	mutex_lock(&uncore_lock);
 
+	if (data->control_cpu < 0) {
+		ret = -ENXIO;
+		goto finish_write;
+	}
+
 	input /= UNCORE_FREQ_KHZ_MULTIPLIER;
 	if (!input || input > 0x7F) {
 		ret = -EINVAL;
@@ -273,18 +281,15 @@ static void uncore_add_die_entry(int cpu)
 	mutex_unlock(&uncore_lock);
 }
 
-/* Last CPU in this die is offline, so remove sysfs entries */
+/* Last CPU in this die is offline, make control cpu invalid */
 static void uncore_remove_die_entry(int cpu)
 {
 	struct uncore_data *data;
 
 	mutex_lock(&uncore_lock);
 	data = uncore_get_instance(cpu);
-	if (data) {
-		kobject_put(&data->kobj);
+	if (data)
 		data->control_cpu = -1;
-		data->valid = false;
-	}
 	mutex_unlock(&uncore_lock);
 }
 
-- 
2.20.1

