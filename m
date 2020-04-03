Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C744DC2BA12
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 14:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84DDF206F5
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 14:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585925731;
	bh=JsPp7Hzk55yQAjqlH03LLJWupVqaFbp5tI//OKXbyQo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=drBKCAdpDEgFYPUuz/8Foy3gp+Gw7WS1Ja6fg+NbviUQtWsJIEM7STZ78TokfWK1f
	 FVvIrIIr2kLjYgSHJfqMNIDFNBANeN67FNvde+XbETiF4Jfgz8lI8QhuNbsAFwO8f/
	 DL/gd6f3w641sWNx92X1GpXHy6/8yWJu6ig5CSsw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404108AbgDCOza (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 10:55:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:60436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404068AbgDCOz2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 10:55:28 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DF0D2078C;
        Fri,  3 Apr 2020 14:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585925728;
        bh=JsPp7Hzk55yQAjqlH03LLJWupVqaFbp5tI//OKXbyQo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ADln7111qLeot57IzmYNVtjoOH1ZVcj1CjtBlRdLl+QhKKc/ZPo350BPsFKUcBKOc
         BO6np1kRaqFDADhdFp6ngNoD3aCdwCl4d557Ct/ZvQQUxA3lDErU1cXfqQ7HlrGR0c
         9uRJzrQ4v9TxgdBPsRx+sTDWIlgtnbdUP5nfxXIQ=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Zefan Li <lizefan@huawei.com>
Subject: [PATCH 08/31] perf/core: Add PERF_SAMPLE_CGROUP feature
Date:   Fri,  3 Apr 2020 11:54:20 -0300
Message-Id: <20200403145443.24774-9-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200403145443.24774-1-acme@kernel.org>
References: <20200403145443.24774-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Namhyung Kim <namhyung@kernel.org>

The PERF_SAMPLE_CGROUP bit is to save (perf_event) cgroup information in
the sample.  It will add a 64-bit id to identify current cgroup and it's
the file handle in the cgroup file system.  Userspace should use this
information with PERF_RECORD_CGROUP event to match which cgroup it
belongs.

I put it before PERF_SAMPLE_AUX for simplicity since it just needs a
64-bit word.  But if we want bigger samples, I can work on that
direction too.

Committer testing:

  $ pahole perf_sample_data | grep -w cgroup -B5 -A5
  	/* --- cacheline 4 boundary (256 bytes) was 56 bytes ago --- */
  	struct perf_regs           regs_intr;            /*   312    16 */
  	/* --- cacheline 5 boundary (320 bytes) was 8 bytes ago --- */
  	u64                        stack_user_size;      /*   328     8 */
  	u64                        phys_addr;            /*   336     8 */
  	u64                        cgroup;               /*   344     8 */

  	/* size: 384, cachelines: 6, members: 22 */
  	/* padding: 32 */
  };
  $

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Tejun Heo <tj@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Zefan Li <lizefan@huawei.com>
Link: http://lore.kernel.org/lkml/20200325124536.2800725-3-namhyung@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 include/linux/perf_event.h      |  1 +
 include/uapi/linux/perf_event.h |  3 ++-
 init/Kconfig                    |  3 ++-
 kernel/events/core.c            | 22 ++++++++++++++++++++++
 4 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 8768a39b5258..9c3e7619c929 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1020,6 +1020,7 @@ struct perf_sample_data {
 	u64				stack_user_size;
 
 	u64				phys_addr;
+	u64				cgroup;
 } ____cacheline_aligned;
 
 /* default value for data source */
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index de95f6c7b273..7b2d6fc9e6ed 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -142,8 +142,9 @@ enum perf_event_sample_format {
 	PERF_SAMPLE_REGS_INTR			= 1U << 18,
 	PERF_SAMPLE_PHYS_ADDR			= 1U << 19,
 	PERF_SAMPLE_AUX				= 1U << 20,
+	PERF_SAMPLE_CGROUP			= 1U << 21,
 
-	PERF_SAMPLE_MAX = 1U << 21,		/* non-ABI */
+	PERF_SAMPLE_MAX = 1U << 22,		/* non-ABI */
 
 	__PERF_SAMPLE_CALLCHAIN_EARLY		= 1ULL << 63, /* non-ABI; internal use */
 };
diff --git a/init/Kconfig b/init/Kconfig
index 20a6ac33761c..7766b06a0038 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1027,7 +1027,8 @@ config CGROUP_PERF
 	help
 	  This option extends the perf per-cpu mode to restrict monitoring
 	  to threads which belong to the cgroup specified and run on the
-	  designated cpu.
+	  designated cpu.  Or this can be used to have cgroup ID in samples
+	  so that it can monitor performance events among cgroups.
 
 	  Say N if unsure.
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 994932d5e474..1569979c8912 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1862,6 +1862,9 @@ static void __perf_event_header_size(struct perf_event *event, u64 sample_type)
 	if (sample_type & PERF_SAMPLE_PHYS_ADDR)
 		size += sizeof(data->phys_addr);
 
+	if (sample_type & PERF_SAMPLE_CGROUP)
+		size += sizeof(data->cgroup);
+
 	event->header_size = size;
 }
 
@@ -6867,6 +6870,9 @@ void perf_output_sample(struct perf_output_handle *handle,
 	if (sample_type & PERF_SAMPLE_PHYS_ADDR)
 		perf_output_put(handle, data->phys_addr);
 
+	if (sample_type & PERF_SAMPLE_CGROUP)
+		perf_output_put(handle, data->cgroup);
+
 	if (sample_type & PERF_SAMPLE_AUX) {
 		perf_output_put(handle, data->aux_size);
 
@@ -7066,6 +7072,16 @@ void perf_prepare_sample(struct perf_event_header *header,
 	if (sample_type & PERF_SAMPLE_PHYS_ADDR)
 		data->phys_addr = perf_virt_to_phys(data->addr);
 
+#ifdef CONFIG_CGROUP_PERF
+	if (sample_type & PERF_SAMPLE_CGROUP) {
+		struct cgroup *cgrp;
+
+		/* protected by RCU */
+		cgrp = task_css_check(current, perf_event_cgrp_id, 1)->cgroup;
+		data->cgroup = cgroup_id(cgrp);
+	}
+#endif
+
 	if (sample_type & PERF_SAMPLE_AUX) {
 		u64 size;
 
@@ -11264,6 +11280,12 @@ static int perf_copy_attr(struct perf_event_attr __user *uattr,
 
 	if (attr->sample_type & PERF_SAMPLE_REGS_INTR)
 		ret = perf_reg_validate(attr->sample_regs_intr);
+
+#ifndef CONFIG_CGROUP_PERF
+	if (attr->sample_type & PERF_SAMPLE_CGROUP)
+		return -EINVAL;
+#endif
+
 out:
 	return ret;
 
-- 
2.21.1

