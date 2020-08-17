Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02688C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 03:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D83342078E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 03:23:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgHRDXa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 23:23:30 -0400
Received: from mga03.intel.com ([134.134.136.65]:63987 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726647AbgHRDXZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 23:23:25 -0400
IronPort-SDR: XoWU+suYVC6g+Xyg+3kXGCZ3CCb5YejIpb8SCNX3UQB6G0ddzh3MjEDyAJCjEUBeHA6MYlkYmI
 WVoc64s6aiHg==
X-IronPort-AV: E=McAfee;i="6000,8403,9716"; a="154806474"
X-IronPort-AV: E=Sophos;i="5.76,325,1592895600"; 
   d="scan'208";a="154806474"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2020 20:23:24 -0700
IronPort-SDR: IUKUFnI+VfHvI/oK/YYda08gAN/iI3qK4UOrhlxMWdHsQQfh/5zBbmT2Q+XrBhVdSEpxnIf4un
 C82uTajiXHCQ==
X-IronPort-AV: E=Sophos;i="5.76,325,1592895600"; 
   d="scan'208";a="441084559"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2020 20:23:21 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        mengdong.lin@intel.com, bard.liao@intel.com
Subject: [PATCH v2 03/12] soundwire: intel: fix race condition on system resume
Date:   Mon, 17 Aug 2020 23:29:14 +0800
Message-Id: <20200817152923.3259-4-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200817152923.3259-1-yung-chuan.liao@linux.intel.com>
References: <20200817152923.3259-1-yung-chuan.liao@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Previous patches took care of the case where the master device is
pm_runtime 'suspended' when a system suspend occurs.

In the case where the master device was not suspended, e.g. if suspend
occurred while streaming audio, Intel validation noticed a race
condition: the pm_runtime suspend may conflict with the enumeration
started by the system resume.

This can be simply fixed by updating the status before exiting system
resume.

GitHub issue: https://github.com/thesofproject/linux/issues/1482
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 0e21bae3cd19..00c5de1250ec 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -1528,6 +1528,18 @@ static int intel_resume(struct device *dev)
 		return ret;
 	}
 
+	/*
+	 * after system resume, the pm_runtime suspend() may kick in
+	 * during the enumeration, before any children device force the
+	 * master device to remain active.  Using pm_runtime_get()
+	 * routines is not really possible, since it'd prevent the
+	 * master from suspending.
+	 * A reasonable compromise is to update the pm_runtime
+	 * counters and delay the pm_runtime suspend by several
+	 * seconds, by when all enumeration should be complete.
+	 */
+	pm_runtime_mark_last_busy(dev);
+
 	return ret;
 }
 
-- 
2.17.1

