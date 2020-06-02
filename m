Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 605BAC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 18:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38CB620734
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 18:29:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbgFBS3B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 14:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbgFBS3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 14:29:01 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4084C08C5C0
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 11:29:00 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jgBee-0001VA-3H; Tue, 02 Jun 2020 20:28:52 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 826EE100F18; Tue,  2 Jun 2020 20:28:50 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ingo Molnar <mingo@kernel.org>,
        Balbir Singh <sblbir@amazon.com>
Cc:     torvalds@linux-foundation.org, a.p.zijlstra@chello.nl,
        akpm@linux-foundation.org, bp@alien8.de,
        linux-kernel@vger.kernel.org, luto@kernel.org
Subject: Re: [GIT PULL] x86/mm changes for v5.8
In-Reply-To: <b159ba4c53fcf04cc4eb747c45e1d4d2d83310a3.camel@kernel.crashing.org>
References: <20200601170102.GA1346815@gmail.com> <CAHk-=wgXf_wQ9zrJKv2Hy4EpEbLuqty-Cjbs2u00gm7XcYHBfw@mail.gmail.com> <20200602073350.GA481221@gmail.com> <b159ba4c53fcf04cc4eb747c45e1d4d2d83310a3.camel@kernel.crashing.org>
Date:   Tue, 02 Jun 2020 20:28:50 +0200
Message-ID: <871rmxgw4d.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
> On Tue, 2020-06-02 at 09:33 +0200, Ingo Molnar wrote:
>> Or rather, we should ask a higher level question as well, maybe we 
>> should not do this feature at all?
>
> Well, it does solve a real issue in some circumstances and there was a
> reasonable discussion about this on the list that lead to it being
> merged with Kees and Thomas (and others) agreeing :)
>
> But yes, it is pointless with SMT and yes maybe we should make it
> explicitly do nothing on SMT, but let's not throw the baby out with the
> bath water shall we ?

It's trivial enough to fix. We have a static key already which is
telling us whether SMT scheduling is active.

Thanks,

        tglx
---
 arch/x86/mm/tlb.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -8,6 +8,7 @@
 #include <linux/export.h>
 #include <linux/cpu.h>
 #include <linux/debugfs.h>
+#include <linux/sched/smt.h>
 
 #include <asm/tlbflush.h>
 #include <asm/mmu_context.h>
@@ -457,7 +458,7 @@ static void cond_mitigation(struct task_
 			indirect_branch_prediction_barrier();
 	}
 
-	if (prev_mm & LAST_USER_MM_L1D_FLUSH) {
+	if (!sched_smt_active() && prev_mm & LAST_USER_MM_L1D_FLUSH) {
 		/*
 		 * Don't populate the TLB for the software fallback flush.
 		 * Populate TLB is not needed for this use case.
