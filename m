Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38211C1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 12:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03C4520775
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 12:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585140357;
	bh=x9MTYF3+GVku9lTah/5TvWYiwIZAclO4Cc+gJdFG2B0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=l3eqz3Doxex9nEzx4mNoli+X7aCjW/WVrfb8dYC2Ree2c2v9GzBHA/HhZlRWaHGJT
	 cqA8bFRCyRST3kJC8tWCjGEbAuQ0u3N8C0U51Wpp2+DzJSHrfMqdUbBFbNYhDcD8og
	 oYNK33TTE/9cCkMNLG7kRsxAp6rpAtkbLUWQYyP0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbgCYMpz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 08:45:55 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35785 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbgCYMpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 08:45:55 -0400
Received: by mail-pf1-f195.google.com with SMTP id u68so1003497pfb.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 05:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+h0UL50c8tr5ghP+fHT934nVpaqBe534TeVJP+T1OdM=;
        b=fnNkIOqupVHu2+ZQX20Dq8gcm4uB1kUr7Dr2tVpkPUiyBpUPxlsnbB8c8GG5SZr3qb
         uulu9UKEP8ZnQ1kDcijYFgd0vao/n2j71Iv+FGvl/u8Hsx+wC6JKH5PLupYryB7ySUQy
         ruV+6NFdHY0EAKAWcFuTW/606GC7sJuKhp9N/PTgIFSqPkK4b6JGx/YRwFHJGw0SNni2
         UMoudTXX9qMGlOL1hZYE/MEh2cAjVj51lapnISzlwFLelIyKRc+6b/Xqq77/ujioK8Q0
         ty5waoaWoeeZLkWK2ccKp7IE8rESWjAgq7sTFbrF47NCeKyGkdzmW5vZrAMJr/82W/f4
         YZlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=+h0UL50c8tr5ghP+fHT934nVpaqBe534TeVJP+T1OdM=;
        b=EhvkGWHYeF0/xV3zha5jDNy/Rd/aZHOzhaulAr/ssYMWZSAIHpjo9M6mB59D9vgHXo
         aUPNNLLPm3QvHRrXXrmNXPjfaPzYg2LH1JrjNy8ehfDf7Z84mpqetqR0tEvk7uIWFC4V
         zI5Zcemc3TXgh69THve0auILcJcyCayc+rd9Y3bTtPXOO9FKh7cPxulzZKTjiOoisr4t
         Co3Vlmvjo/3HaK3CkIUxAEB0pV8AjI+CceMFqZLekJYtYnDxLldlchSz7cUisheIPrJH
         Dc5a1fmZOhk0rV/KZC2/zo4dv/ZWrhomrl50zL+B84G1lqH0qipkQGz2JlwyS/1tdrF7
         Ylpg==
X-Gm-Message-State: ANhLgQ0RMvD4n3IK/ohYEDYOXAwVE+xbyHPQKuXnqOsalTB05g+0Tj1n
        1vRaXpIfO1Ix2cWfl4jStwi1e+E+
X-Google-Smtp-Source: ADFU+vuFal3oz98smpqwmEeJByVvD+Egkxbjgm2EravFbcyBis1sCT+Y3drDQiEiKdf4c/9YPR6o/w==
X-Received: by 2002:aa7:87c1:: with SMTP id i1mr3175060pfo.44.1585140353352;
        Wed, 25 Mar 2020 05:45:53 -0700 (PDT)
Received: from gaurie.seo.corp.google.com ([2401:fa00:d:1:4eb0:a5ef:3975:7440])
        by smtp.gmail.com with ESMTPSA id h15sm18244648pfq.10.2020.03.25.05.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 05:45:52 -0700 (PDT)
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 2/9] perf/core: Add PERF_SAMPLE_CGROUP feature
Date:   Wed, 25 Mar 2020 21:45:29 +0900
Message-Id: <20200325124536.2800725-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
In-Reply-To: <20200325124536.2800725-1-namhyung@kernel.org>
References: <20200325124536.2800725-1-namhyung@kernel.org>
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

Cc: Li Zefan <lizefan@huawei.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Tejun Heo <tj@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
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
2.25.1.696.g5e7596f4ac-goog

