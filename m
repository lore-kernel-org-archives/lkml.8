Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F113C35641
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 04:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 396FC206CC
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 04:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582519092;
	bh=xzr4rdT4DOxZEMdDFx+GsLE9DoOnZ8roy+V7sxRJ5qU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QrzPfw+TJ+sbtUElofgujND32zvcr6q3YTEQRJKS2M3s96idz4hNW9NgizukdTZSs
	 8cs7zRMdm7HU3MQn5cQCOC2nvKe3d34JLrAZq2AArJu48R131vcdx0+V/g5iOEXoRS
	 9lFZEBJQN2q54rarhSLwwEXFEe+uils+wRm+1jcY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbgBXEiK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 23:38:10 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39424 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727186AbgBXEiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 23:38:09 -0500
Received: by mail-pl1-f196.google.com with SMTP id g6so3520300plp.6;
        Sun, 23 Feb 2020 20:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k/myKO8kL0XhzDWRLWvxRkpW+ss7p8A3sGzkmB3MqI8=;
        b=QOk1wnG5nAzLY0+lWyTk2Uvs7akm8R4UL/XV9rjQXtX+PWxEz+vOE2+ZrIckPJbh1W
         3mOTJuHxz4Rc6XJvI+YXKSq2adDGyn81bOcQdqGmOD9oISujnFY+1BSvSKuIOgV+D7PB
         C1TYL3zCRmbg05YFa4CFWkPcOr+UL8k/hsPOE/3rVwAS0IjdBu2LIiFk88Ew5CYduvUL
         BZiQ8fqfLzyuSedRXtT/H8A6sw9nwm7uA95iJ5c5sQDUvOqwJfsKreWPv3UsX75TMZnH
         YIPuG6+CbQFfl0CB7WeCwgVPJ05aUQJeDN2K7wUQIoH5lL5tMH7YFgXFbRgLAwebM0l3
         piuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=k/myKO8kL0XhzDWRLWvxRkpW+ss7p8A3sGzkmB3MqI8=;
        b=iGvSMmdKPkjhtuH35ivejmvY+nEBfB6KDumX68DiRRO4vy2vVxYICaNiOefEua2pGQ
         TBcX9xveqL7XgZhEUEebweDALtTNucatZ2UHfJE0XDGbRVCdsCXWZKVcn7HHXtmi5CmC
         uZryjeKgbybfowM69s8uYEult1QR64e6fPaKwFxTUTLLn8F6RSEAoAZRsoWzrj5mkUr7
         lqaNuzY6DJejfFh3qdZMI7SwScLimgkOxjoWBluMmF6g+ywWGC+LTfq15a8MjkslsqBR
         D3pQfuK6pxIPYQcjvDFqGha2JXkG/Qc6A0Xq96R/etdW70oom4HIIdH4iBI949SuLIz6
         JmSw==
X-Gm-Message-State: APjAAAUCGo5HxSfLb7feXw+DUy8FD5v9vkV0B4w7RosyE/bpwgX4OnRc
        gEJMWTkzeJlOjzFVG2H5KeA=
X-Google-Smtp-Source: APXvYqy9ntQaergv8LkfLzx9PuwrUdwzjn0UGDSpjcW4YGzd0yxTzQg4wfbMYt+oCvXajq8013R8fg==
X-Received: by 2002:a17:902:9889:: with SMTP id s9mr44402141plp.252.1582519087637;
        Sun, 23 Feb 2020 20:38:07 -0800 (PST)
Received: from gaurie.seo.corp.google.com ([2401:fa00:d:1:4eb0:a5ef:3975:7440])
        by smtp.gmail.com with ESMTPSA id g16sm10914060pgb.54.2020.02.23.20.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2020 20:38:07 -0800 (PST)
From:   Namhyung Kim <namhyung@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: [PATCH 02/10] perf/core: Add PERF_SAMPLE_CGROUP feature
Date:   Mon, 24 Feb 2020 13:37:41 +0900
Message-Id: <20200224043749.69466-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
In-Reply-To: <20200224043749.69466-1-namhyung@kernel.org>
References: <20200224043749.69466-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PERF_SAMPLE_CGROUP bit is to save (perf_event) cgroup information
in the sample.  It will add a 64-bit id to identify current cgroup and
it's the file handle in the cgroup file system.  Userspace should use
this information with PERF_RECORD_CGROUP event to match which cgroup
it belongs.

I put it before PERF_SAMPLE_AUX for simplicity since it just needs a
64-bit word.  But if we want bigger samples, I can work on that
direction too.

Cc: Tejun Heo <tj@kernel.org>
Cc: Li Zefan <lizefan@huawei.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 include/linux/perf_event.h      |  1 +
 include/uapi/linux/perf_event.h |  3 ++-
 init/Kconfig                    |  3 ++-
 kernel/events/core.c            | 22 ++++++++++++++++++++++
 4 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 6d4c22aee384..17b5bff045a6 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1001,6 +1001,7 @@ struct perf_sample_data {
 	u64				stack_user_size;
 
 	u64				phys_addr;
+	u64				cgroup;
 } ____cacheline_aligned;
 
 /* default value for data source */
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index de2ab87ca92c..3a81e9806cb1 100644
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
index a34064a031a5..403ed2448b22 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1026,7 +1026,8 @@ config CGROUP_PERF
 	help
 	  This option extends the perf per-cpu mode to restrict monitoring
 	  to threads which belong to the cgroup specified and run on the
-	  designated cpu.
+	  designated cpu.  Or this can be used to have cgroup ID in samples
+	  so that it can monitor performance events among cgroups.
 
 	  Say N if unsure.
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index b4ddfb26b5e9..68c5177e4492 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1754,6 +1754,9 @@ static void __perf_event_header_size(struct perf_event *event, u64 sample_type)
 	if (sample_type & PERF_SAMPLE_PHYS_ADDR)
 		size += sizeof(data->phys_addr);
 
+	if (sample_type & PERF_SAMPLE_CGROUP)
+		size += sizeof(data->cgroup);
+
 	event->header_size = size;
 }
 
@@ -6699,6 +6702,9 @@ void perf_output_sample(struct perf_output_handle *handle,
 	if (sample_type & PERF_SAMPLE_PHYS_ADDR)
 		perf_output_put(handle, data->phys_addr);
 
+	if (sample_type & PERF_SAMPLE_CGROUP)
+		perf_output_put(handle, data->cgroup);
+
 	if (sample_type & PERF_SAMPLE_AUX) {
 		perf_output_put(handle, data->aux_size);
 
@@ -6895,6 +6901,16 @@ void perf_prepare_sample(struct perf_event_header *header,
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
 
@@ -11090,6 +11106,12 @@ static int perf_copy_attr(struct perf_event_attr __user *uattr,
 
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
2.25.0.265.gbab2e86ba0-goog

