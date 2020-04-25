Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD93AC55186
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 09:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 941582071E
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 09:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587806365;
	bh=Cbs2sfjzFf0whXl6aS+b7R1Cw3yZ5kSUjNnnH35tplY=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=aDzWR3rRqsOmE5/M6iBt+/4/PgUGgblFiV4zXTUTyY2BbTFNpuAqbT5GH9G0oXy9a
	 b18rtcAy0sZ9xMbfxHVmwzlFgUOwOBatfoMKj+ZXgpEgEGb/3xUwccin0ld7K+iKvq
	 cJZP/U3cthA5nCyyCvjPauKYFghl6PIMhMZZnbsA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbgDYJTY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 05:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbgDYJTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 05:19:23 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D331C09B04A
        for <linux-kernel@vger.kernel.org>; Sat, 25 Apr 2020 02:19:22 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id x25so13823023wmc.0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Apr 2020 02:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=O6x1cvaQLd8ckRK68aDlfGMV1iBl0OtCDBXcWbTpoD4=;
        b=LfSHnMZeiIlzfpZGv6smeEXdC3H089BzlT+cEYBu5o2KJcVYg7RVWSKhJI4cPotet3
         TOVbewLKGqm2vqyF9Hur9e7vwhM+Sw81baf8FAOo6MzMh15xkQUmJGDF8wZo5OUP1Zgh
         HF+Vm9qgq3LusXC9Z4d5TI8XnjamsjClxvPAThAQ7JG4x2nhxjGkHbvg24MT+a5AXxGz
         JiNtkQrBHh2qs5Vmeeb1L502ioCPbH4vlUzQ0aLFT1viT6WxUito1lHZCOX0LRcawz1j
         VbmiqhzUnqkEmlPsg82k9ZGpJHc1bS1x7ilKDf0NYmW92aouPC+0Yq2jl+ZOVMQ/vS/Y
         GkPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=O6x1cvaQLd8ckRK68aDlfGMV1iBl0OtCDBXcWbTpoD4=;
        b=A1Qdg6yGK+WbpK2b+He4t/H1XMkrQIiKjWKwG51OMYP9MaBG4fsFp0m0D/YibhEbRp
         XHR3TEfOZCb2jCMUCD/Od65b6A0SsXG0ieuplkgYICzVQusiNJRMT5/yZ/eOcrWzPV6q
         ns+NE6tUSJwRkQ33BojXdhuoANJTaqR1oROSjD4ANNiBm5O62CuSzg7qngeNYVU1nliB
         odgu1fXDFKqxLAwsB+cVmdvM26Ia/X8fLRRREKmiBVqDKcECaFJ51ssQWg0l1RkchCC4
         kzQXFzmnkVMuUE8KiiS6nzeRnpaQ8bldHGe2pFFHO0skjAEGOm5RaAbXFmNhLQ7eLVQT
         owGg==
X-Gm-Message-State: AGi0PuaB7ih3nH6Axh5xOddQU3nwxxj+uwl/pYbcdnNcu4oWvuJUodU3
        U3ZJswvKyn1VhHP/9+GHOiM=
X-Google-Smtp-Source: APiQypI93DDgfvt/YALqAU5gYiVo7OVY6ZR8ePkbv6iY7HlusAS1HY8kQIMM1sElq164uA7KDQqeYQ==
X-Received: by 2002:a7b:c20f:: with SMTP id x15mr14417068wmi.2.1587806361260;
        Sat, 25 Apr 2020 02:19:21 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id d7sm11544517wrn.78.2020.04.25.02.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2020 02:19:20 -0700 (PDT)
Date:   Sat, 25 Apr 2020 11:19:18 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] perf fixes
Message-ID: <20200425091918.GA21990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest perf/urgent git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2020-04-25

   # HEAD: f3bed55e850926614b9898fe982f66d2541a36a5 perf/core: fix parent pid/tid in task exit events

Two changes:

 - fix exit event records
 - extend x86 PMU driver enumeration to add Intel Jasper Lake CPU support.

 Thanks,

	Ingo

------------------>
Harry Pan (1):
      perf/x86/cstate: Add Jasper Lake CPU support

Ian Rogers (1):
      perf/core: fix parent pid/tid in task exit events


 arch/x86/events/intel/cstate.c |  1 +
 kernel/events/core.c           | 13 ++++++++++---
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
index e4aa20c0426f..442e1ed4acd4 100644
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -643,6 +643,7 @@ static const struct x86_cpu_id intel_cstates_match[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT_PLUS,	&glm_cstates),
 	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_D,	&glm_cstates),
 	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT,	&glm_cstates),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_L,	&glm_cstates),
 
 	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_L,		&icl_cstates),
 	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE,		&icl_cstates),
diff --git a/kernel/events/core.c b/kernel/events/core.c
index bc9b98a9af9a..633b4ae72ed5 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7491,10 +7491,17 @@ static void perf_event_task_output(struct perf_event *event,
 		goto out;
 
 	task_event->event_id.pid = perf_event_pid(event, task);
-	task_event->event_id.ppid = perf_event_pid(event, current);
-
 	task_event->event_id.tid = perf_event_tid(event, task);
-	task_event->event_id.ptid = perf_event_tid(event, current);
+
+	if (task_event->event_id.header.type == PERF_RECORD_EXIT) {
+		task_event->event_id.ppid = perf_event_pid(event,
+							task->real_parent);
+		task_event->event_id.ptid = perf_event_pid(event,
+							task->real_parent);
+	} else {  /* PERF_RECORD_FORK */
+		task_event->event_id.ppid = perf_event_pid(event, current);
+		task_event->event_id.ptid = perf_event_tid(event, current);
+	}
 
 	task_event->event_id.time = perf_event_clock(event);
 
