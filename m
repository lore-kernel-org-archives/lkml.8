Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73637C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 08:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5685A2073E
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 08:44:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbgFQIoC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 04:44:02 -0400
Received: from mga01.intel.com ([192.55.52.88]:14792 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725964AbgFQIoB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 04:44:01 -0400
IronPort-SDR: dwPjoBtto7WtiiBkYvMWCOnm53/iyzjzZyPmTLrxJ4J/L7uCF0qpsj4DYImY1CRfkBtAcVSH5T
 iVjBpGf8G2Jg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2020 01:44:01 -0700
IronPort-SDR: imZFkMgZf4XO7Xp6u4cI+1sICIQdqwaFEbBoAjbA2/fV2H2D8d0hEMPaKeJfYVByMYeIkiXVrV
 UfkeM9rLomuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,522,1583222400"; 
   d="scan'208";a="317471914"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Jun 2020 01:44:01 -0700
Received: from [10.249.225.191] (abudanko-mobl.ccr.corp.intel.com [10.249.225.191])
        by linux.intel.com (Postfix) with ESMTP id 56DAB58026B;
        Wed, 17 Jun 2020 01:43:59 -0700 (PDT)
Subject: [PATCH v8 12/13] perf record: implement control commands handling
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <0781a077-aa82-5b4a-273e-c17372a72b93@linux.intel.com>
Organization: Intel Corp.
Message-ID: <f48c5f58-96ea-b1f0-a7e6-55315a292bce@linux.intel.com>
Date:   Wed, 17 Jun 2020 11:43:58 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <0781a077-aa82-5b4a-273e-c17372a72b93@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Implement handling of 'enable' and 'disable' control commands
coming from control file descriptor.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 tools/perf/builtin-record.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index d0b29a1070a0..0394e068dde8 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1527,6 +1527,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 	bool disabled = false, draining = false;
 	int fd;
 	float ratio = 0;
+	enum evlist_ctl_cmd cmd = EVLIST_CTL_CMD_UNSUPPORTED;
 
 	atexit(record__sig_exit);
 	signal(SIGCHLD, sig_handler);
@@ -1830,6 +1831,21 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 				alarm(rec->switch_output.time);
 		}
 
+		if (evlist__ctlfd_process(rec->evlist, &cmd) > 0) {
+			switch (cmd) {
+			case EVLIST_CTL_CMD_ENABLE:
+				pr_info(EVLIST_ENABLED_MSG);
+				break;
+			case EVLIST_CTL_CMD_DISABLE:
+				pr_info(EVLIST_DISABLED_MSG);
+				break;
+			case EVLIST_CTL_CMD_ACK:
+			case EVLIST_CTL_CMD_UNSUPPORTED:
+			default:
+				break;
+			}
+		}
+
 		if (hits == rec->samples) {
 			if (done || draining)
 				break;
-- 
2.24.1


