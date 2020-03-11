Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B7EBC0044D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 21:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D44EF206B1
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 21:06:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DU3ilcmf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729310AbgCKVGM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 17:06:12 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41131 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbgCKVGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 17:06:12 -0400
Received: by mail-wr1-f66.google.com with SMTP id s14so4542076wrt.8
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 14:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=cbllDlkzkFL575haOotAoXD3bI1Ek80WA29nBWikMdA=;
        b=DU3ilcmfups5VC2Z9PcVv//2ubpy+I8X+kzIHojcN1MKe01MDVq9SexUMXSjlANIxM
         U74eFhYGIHc7iMRkMixUMCMTrvQAU4M2G3j27h/xprRU8lbgcLPAVit9R0PSSMbKVmgs
         hP2dN71v4IrUjx+Hh8H/ADf9moSaSXVtBZqeltGZ4aw0NeJJzV+JeVcwQccNDxr+W/CC
         gEw+tKx/O03wTH16WVcozY8ZKN5ovRvlo4uGNzVdheaxGeH51PUA3UpiXYFCxklmwmI3
         prcyaUWvdqoZGhw39OLwExb+bHQdGH3AtH0rIqNHEAyskDBU8SMEgH5V0IaJf2+DGcNe
         Jlrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=cbllDlkzkFL575haOotAoXD3bI1Ek80WA29nBWikMdA=;
        b=AFvwlwt6u37rW0CQ2bigMkyyBGd9rOHAStpTEyetqnhiIpKJR5krp25HA4t3Y1M7jS
         ZRLNgmfrC+adzuW8OX4QHfwIORCnkXNmjfHtN+PXG+BdivQ1PMhcjSwPPGne/oNqL1nr
         SPUhIwBRnW18T/c+uvPZ/hKdr3w6HOH7g+W1gVbAXt4qHLQFoxiCkydzMsGD8nFvVJiL
         3nG6VsSdrY7Np0VGvbTnO1c8s69/xASc5qQ7zz/dRoLKQUC0XBcmWyIcqhwzk07HyqrB
         LbGTtJNGVNBRx63AYC0lQj/Cqppo2MtV3xbTLYNIHGnMLuqU/Ix9G6QBtcH+TQvzIZMW
         0CXQ==
X-Gm-Message-State: ANhLgQ08WaES+fGUAdAZCOXNSMpDYl9E6MDS5bq1TBvxHDXI5WGNrhj+
        x3SRSJClOeSUas2qKJ/SMQ==
X-Google-Smtp-Source: ADFU+vub3tKY58Vqfb86AajngZcx+Kt+kUb10x29J2/efgzGhtTu6cWF3/z1k8i9v1e3d5UFQFoBiw==
X-Received: by 2002:a5d:4c8e:: with SMTP id z14mr4371381wrs.259.1583960771292;
        Wed, 11 Mar 2020 14:06:11 -0700 (PDT)
Received: from avx2 ([46.53.249.42])
        by smtp.gmail.com with ESMTPSA id c4sm9906003wml.7.2020.03.11.14.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 14:06:10 -0700 (PDT)
Date:   Thu, 12 Mar 2020 00:06:08 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     mingo@redhat.com, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] sched: make nr_running() return "unsigned int"
Message-ID: <20200311210608.GA4517@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I don't anyone have been crazy enough to spawn 2^32 threads.
It'd require absurd amounts of physical memory.

Meanwhile save few bits on REX prefixes.

And remove "extern" from prototypes while I'm at it.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/proc/loadavg.c          |    2 +-
 fs/proc/stat.c             |    2 +-
 include/linux/sched/stat.h |    2 +-
 kernel/sched/core.c        |    4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)

--- a/fs/proc/loadavg.c
+++ b/fs/proc/loadavg.c
@@ -16,7 +16,7 @@ static int loadavg_proc_show(struct seq_file *m, void *v)
 
 	get_avenrun(avnrun, FIXED_1/200, 0);
 
-	seq_printf(m, "%lu.%02lu %lu.%02lu %lu.%02lu %ld/%d %d\n",
+	seq_printf(m, "%lu.%02lu %lu.%02lu %lu.%02lu %u/%d %d\n",
 		LOAD_INT(avnrun[0]), LOAD_FRAC(avnrun[0]),
 		LOAD_INT(avnrun[1]), LOAD_FRAC(avnrun[1]),
 		LOAD_INT(avnrun[2]), LOAD_FRAC(avnrun[2]),
--- a/fs/proc/stat.c
+++ b/fs/proc/stat.c
@@ -197,7 +197,7 @@ static int show_stat(struct seq_file *p, void *v)
 		"\nctxt %llu\n"
 		"btime %llu\n"
 		"processes %lu\n"
-		"procs_running %lu\n"
+		"procs_running %u\n"
 		"procs_blocked %lu\n",
 		nr_context_switches(),
 		(unsigned long long)boottime.tv_sec,
--- a/include/linux/sched/stat.h
+++ b/include/linux/sched/stat.h
@@ -16,7 +16,7 @@ extern unsigned long total_forks;
 extern int nr_threads;
 DECLARE_PER_CPU(unsigned long, process_counts);
 extern int nr_processes(void);
-extern unsigned long nr_running(void);
+unsigned int nr_running(void);
 extern bool single_task_running(void);
 extern unsigned long nr_iowait(void);
 extern unsigned long nr_iowait_cpu(int cpu);
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3389,9 +3389,9 @@ context_switch(struct rq *rq, struct task_struct *prev,
  * externally visible scheduler statistics: current number of runnable
  * threads, total number of context switches performed since bootup.
  */
-unsigned long nr_running(void)
+unsigned int nr_running(void)
 {
-	unsigned long i, sum = 0;
+	unsigned int i, sum = 0;
 
 	for_each_online_cpu(i)
 		sum += cpu_rq(i)->nr_running;
