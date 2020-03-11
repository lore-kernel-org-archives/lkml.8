Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D6AC0044D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 21:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B6912074E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 21:08:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xq0cGzUz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729297AbgCKVIf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 17:08:35 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35802 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgCKVIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 17:08:35 -0400
Received: by mail-wr1-f68.google.com with SMTP id d5so4197270wrc.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 14:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GbBMD+bpB/qvF3w7FgA9Od2ROhEbBf3Jq7tXXVT9z8M=;
        b=Xq0cGzUzmYcaPk2YpEIiAt+1Qr6G0U+8pgUDJG8EtjsRsDCeQUEqOw1G4gXa8VjKp+
         OFuzcp+/l/scb38QFcheNxvuHtwRn7/WymCI/bqQFiLJOpPiSpXt+FBUW41yGGwd9hFl
         gQxPxnZLSr7uLoyk06M4zrzxloYgylbRc7xjpPq8QEhrwJeOdy30/RxetJk8N2JY6bhd
         tes3w0b0IvvEjQTtnOcqmlLQCcUC8D1F3YwPW3lcUEb9nC7oBxZrtkuAnBWqyppej+sF
         zfrB8vnE26ymEBwdjMQPg4YV8tv98d0cb+5XS6eIadl0jxVuhnjgbAixkiTTVQ8v9vLK
         udfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GbBMD+bpB/qvF3w7FgA9Od2ROhEbBf3Jq7tXXVT9z8M=;
        b=oHqPPKAtzkHGMkshsHEes0Hh+iAV2UXzwF0tKR9uruoXfTKylFFu50GqtmlDI6/UWv
         ZW8OSbm24c0sXAywdCrCzW0E5dIAR8v4gfakkULT8U1b2X4b+7WrIiHStz7T5zvqYdmD
         J8qE8Sf9dZo+d8HmpBFGkcjl+WRjnhpX3edu2zV/JKZYVGsBRSFJs2MZIOptKBBNFaKC
         5LeLRA/ZySEYbhM0Zl4mb3vHFVKoCJY1LFqG+pg22Am/V/XGa8pT2cNDgwGbLgtwr29K
         P9hNFymRne3Tn2e+FBU70GHkaL8GBE2jTkx8PmVt78mogvtVuiPpjCqDuLVUBr+5F99a
         nBgA==
X-Gm-Message-State: ANhLgQ0yWeuCrzUF4AXGfhSIpARLR79AMx7gA1CYxogcExcIfTPjIl6S
        UUQHcrSQyOy8S230s+cQ1Q==
X-Google-Smtp-Source: ADFU+vs7oioMqTDzWZlJRnARcVxdT/y0+C57ft/btzv6ps8isAsGwu7cKpNNrRzM2Wny3iCq8H9LMA==
X-Received: by 2002:adf:c449:: with SMTP id a9mr6335224wrg.366.1583960913566;
        Wed, 11 Mar 2020 14:08:33 -0700 (PDT)
Received: from avx2 ([46.53.249.42])
        by smtp.gmail.com with ESMTPSA id s1sm943921wrp.41.2020.03.11.14.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 14:08:33 -0700 (PDT)
Date:   Thu, 12 Mar 2020 00:08:31 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     mingo@redhat.com, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] sched: make nr_iowait_cpu() return "unsigned int"
Message-ID: <20200311210831.GB4517@avx2>
References: <20200311210608.GA4517@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200311210608.GA4517@avx2>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Same logic: 2^32 threads stuck waiting in runqueue implies
2^32+ processes total which is absurd.

Per-runqueue ->nr_iowait member being 32-bit hints that it is
correct change!

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/proc/stat.c             |    2 +-
 include/linux/sched/stat.h |    4 ++--
 kernel/sched/core.c        |    6 +++---
 3 files changed, 6 insertions(+), 6 deletions(-)

--- a/fs/proc/stat.c
+++ b/fs/proc/stat.c
@@ -198,7 +198,7 @@ static int show_stat(struct seq_file *p, void *v)
 		"btime %llu\n"
 		"processes %lu\n"
 		"procs_running %u\n"
-		"procs_blocked %lu\n",
+		"procs_blocked %u\n",
 		nr_context_switches(),
 		(unsigned long long)boottime.tv_sec,
 		total_forks,
--- a/include/linux/sched/stat.h
+++ b/include/linux/sched/stat.h
@@ -18,8 +18,8 @@ DECLARE_PER_CPU(unsigned long, process_counts);
 extern int nr_processes(void);
 unsigned int nr_running(void);
 extern bool single_task_running(void);
-extern unsigned long nr_iowait(void);
-extern unsigned long nr_iowait_cpu(int cpu);
+unsigned int nr_iowait(void);
+unsigned int nr_iowait_cpu(int cpu);
 
 static inline int sched_info_on(void)
 {
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3436,7 +3436,7 @@ unsigned long long nr_context_switches(void)
  * it does become runnable.
  */
 
-unsigned long nr_iowait_cpu(int cpu)
+unsigned int nr_iowait_cpu(int cpu)
 {
 	return atomic_read(&cpu_rq(cpu)->nr_iowait);
 }
@@ -3471,9 +3471,9 @@ unsigned long nr_iowait_cpu(int cpu)
  * Task CPU affinities can make all that even more 'interesting'.
  */
 
-unsigned long nr_iowait(void)
+unsigned int nr_iowait(void)
 {
-	unsigned long i, sum = 0;
+	unsigned int i, sum = 0;
 
 	for_each_possible_cpu(i)
 		sum += nr_iowait_cpu(i);
