Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE35C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 03:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 663922072D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 03:40:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rRAYu5sO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391360AbgDPDkX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 23:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2391128AbgDPDkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 23:40:16 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C190BC061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 20:40:15 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id d1so1067814pfh.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 20:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=m5hy4xiunR5mbPaXPcryFldNP/am+ULUKmnq7qSCn+g=;
        b=rRAYu5sOSvLYPzxWffYX0ycmRMPHrLZ5lHiPZ9pcq5k+rdLLWRssm+fW56CIpLszLi
         ayhJb3kkkobrDJL0gj6BQPMIiUGgAOTvKuc/H73Fz+snsiIfonSV/OXB0V8U9sk6QOkv
         /p12BI4vz2UqPIWf3UqKSnzcw0Y8mGgWolafGDKFe+XkKlPjfDhny1gjuF/sersF5lU0
         DjbA3gq2I32tbz+foeXF+ngk7hNDyaCWA5JBNteUCMc8e/t6Sk5Qs7uKsf5jfTyyDNk8
         DAoMkWhh+s+58/1IdngL+qSc07/UWMLfgxDOuWUtxu5DylkOHQb8LZQi4qAmBtx5TrYE
         9zjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=m5hy4xiunR5mbPaXPcryFldNP/am+ULUKmnq7qSCn+g=;
        b=etMvg32iA/VRQ0RcNweAGO8eRAGA2AnQtGroIsKXnw3489YMHGK9Glevc2bPisFQf/
         AEs09HFZZfKEdH0DYcfpESHv6wqRLJHBbpHLrWlpmEvDTaqMneVLmjZVg/TlrBEIhB5o
         I+sU8VqC5qPKLDgBSoXo40cf45VWESeQ0lbgwLfru2X39bIJLXoF2oWQKdZuaPPZrGvY
         yiQqpN6w5/ZG4tHyxJ3wLET+niaU2FYq3Q2PNQd7DLUB+I9GwFLejPkj58guWLM5vhmo
         NVUy/HN6oOiD1OZRZJvGjHyZYntYb03LQax0Ljtb08aRCNOQdj5gwUXFpS5w6bRnEjo3
         SHCg==
X-Gm-Message-State: AGi0PubZVDtYnIN+Ur1RUeloK+0xPGJReovNEj65dqDQnnAFXI+ASVoS
        p4I1Ps0g5exdkLvuBaevA4k=
X-Google-Smtp-Source: APiQypKv+vtsM7+NyjKz3c0seHkYPKBdICKpdkWDHg5Z7D0tsjZ8vYtQ5VJgYitMbR8fsvzVNwgHoQ==
X-Received: by 2002:a63:4526:: with SMTP id s38mr6778872pga.410.1587008415303;
        Wed, 15 Apr 2020 20:40:15 -0700 (PDT)
Received: from HP-G1 ([45.135.186.26])
        by smtp.gmail.com with ESMTPSA id a12sm8840158pfr.28.2020.04.15.20.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 20:40:14 -0700 (PDT)
Date:   Thu, 16 Apr 2020 11:39:05 +0800
From:   Chen Yu <yu.chen.surf@gmail.com>
To:     vpillai <vpillai@digitalocean.com>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, fweisbec@gmail.com,
        keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>, aubrey.li@linux.intel.com,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joel Fernandes <joelaf@google.com>, joel@joelfernandes.org,
        Aaron Lu <aaron.lu@linux.alibaba.com>,
        Long Cui <long.cui@intel.com>
Subject: Re: [RFC PATCH 07/13] sched: Add core wide task selection and
 scheduling.
Message-ID: <20200416033804.GA5712@HP-G1>
References: <cover.1583332764.git.vpillai@digitalocean.com>
 <e942da7fd881977923463f19648085c1bfaa37f8.1583332765.git.vpillai@digitalocean.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e942da7fd881977923463f19648085c1bfaa37f8.1583332765.git.vpillai@digitalocean.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 04, 2020 at 04:59:57PM +0000, vpillai wrote:
> From: Peter Zijlstra <peterz@infradead.org>
> 
> Instead of only selecting a local task, select a task for all SMT
> siblings for every reschedule on the core (irrespective which logical
> CPU does the reschedule).
> 
> There could be races in core scheduler where a CPU is trying to pick
> a task for its sibling in core scheduler, when that CPU has just been
> offlined.  We should not schedule any tasks on the CPU in this case.
> Return an idle task in pick_next_task for this situation.
> 
> NOTE: there is still potential for siblings rivalry.
> NOTE: this is far too complicated; but thus far I've failed to
>       simplify it further.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Julien Desfossez <jdesfossez@digitalocean.com>
> Signed-off-by: Vineeth Remanan Pillai <vpillai@digitalocean.com>
> Signed-off-by: Aaron Lu <aaron.lu@linux.alibaba.com>
> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
> ---
[cut]

Hi Vineeth,
An NULL pointer exception was found when testing V5 on top of stable
v5.6.2. And we tried the patch Peter suggested, the NULL pointer
was not found so far. We don't know if this change would help mitigate
the symptom, but it should do no harm to test with this fix applied.

Thanks,
Chenyu

From 6828eaf4611eeb3e1bad3b9a0d4ec53c6fa01fe3 Mon Sep 17 00:00:00 2001
From: Chen Yu <yu.c.chen@intel.com>
Date: Thu, 16 Apr 2020 10:51:07 +0800
Subject: [PATCH] sched: Fix pick_next_task() race condition in core scheduling

As Perter mentioned that Commit 6e2df0581f56 ("sched: Fix pick_next_task()
vs 'change' pattern race") has fixed a race condition due to rq->lock
improperly released after put_prev_task(), backport this fix to core
scheduling's pick_next_task() as well.

Without this fix, Aubrey, Long and I found an NULL exception point
triggered within one hour when running RDT MBA(Intel Resource Directory
Technolodge Memory Bandwidth Allocation) benchmarks on a 36 Core(72 HTs)
platform, which tries to dereference a NULL sched_entity:

[ 3618.429053] BUG: kernel NULL pointer dereference, address: 0000000000000160
[ 3618.429039] RIP: 0010:pick_task_fair+0x2e/0xa0
[ 3618.429042] RSP: 0018:ffffc90000317da8 EFLAGS: 00010046
[ 3618.429044] RAX: 0000000000000000 RBX: ffff88afdf4ad100 RCX: 0000000000000001
[ 3618.429045] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88afdf4ad100
[ 3618.429045] RBP: ffffc90000317dc0 R08: 0000000000000048 R09: 0100000000100000
[ 3618.429046] R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
[ 3618.429047] R13: 000000000002d080 R14: ffff88afdf4ad080 R15: 0000000000000014
[ 3618.429048]  ? pick_task_fair+0x48/0xa0
[ 3618.429048]  pick_next_task+0x34c/0x7e0
[ 3618.429049]  ? tick_program_event+0x44/0x70
[ 3618.429049]  __schedule+0xee/0x5d0
[ 3618.429050]  schedule_idle+0x2c/0x40
[ 3618.429051]  do_idle+0x175/0x280
[ 3618.429051]  cpu_startup_entry+0x1d/0x30
[ 3618.429052]  start_secondary+0x169/0x1c0
[ 3618.429052]  secondary_startup_64+0xa4/0xb0

While with this patch applied, no NULL pointer exception was found within
14 hours for now. Although there's no direct evidence this fix would solve
the issue, it does fix a potential race condition.

Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 kernel/sched/core.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 02495d44870f..ef101a3ef583 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4477,9 +4477,14 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 		return next;
 	}
 
-	prev->sched_class->put_prev_task(rq, prev);
-	if (!rq->nr_running)
-		newidle_balance(rq, rf);
+
+#ifdef CONFIG_SMP
+	for_class_range(class, prev->sched_class, &idle_sched_class) {
+		if (class->balance(rq, prev, rf))
+			break;
+	}
+#endif
+	put_prev_task(rq, prev);
 
 	smt_mask = cpu_smt_mask(cpu);
 
-- 
2.20.1

