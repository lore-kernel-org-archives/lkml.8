Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27090C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 21:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 006872071A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 21:37:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jOExmlg7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbgE2VhM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 17:37:12 -0400
Received: from merlin.infradead.org ([205.233.59.134]:54856 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbgE2VhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 17:37:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=p70/99mmP3SDVYVlvGxJrUvoHN7Vr2ZWTYCIpYpV3uY=; b=jOExmlg7jRAidT1TL3466YWaeG
        C/14stX//mhuF9VxYEtNpeMHpGNg6KYjTnaCaeC+ytfvYXSSkMGzeGaqRlE9FxvD/DCa2HhAU3pc3
        KmJmiVu9/4FUPOZok4HFwJeBsVVFaYNthhYI7ccHvB1fpcW6grlz0wi0JnU7s26tcw2fK+Pn6HXXQ
        wyDylxkLJf1LbBBVw3m+5VWd4EmzYciM2Pf87z+RK4M9lKQqj5vmeo0E0cq9o6EdfMnO73Xs7OE/k
        Dzx2anhr8x9be20x1P+fYbU9Vjkf8mBHrk7umvd8ptND7l48tOX80Ubh0JW32EQgUrYKyKtPXqxv3
        A5ZJUk2Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jemeP-0007Iy-UM; Fri, 29 May 2020 21:34:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F2A27307479;
        Fri, 29 May 2020 23:34:41 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 2E88720FF0A0C; Fri, 29 May 2020 23:34:41 +0200 (CEST)
Message-ID: <20200529213321.131187767@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 29 May 2020 23:27:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, luto@amacapital.net, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        sean.j.christopherson@intel.com, andrew.cooper3@citrix.com,
        daniel.thompson@linaro.org, a.darwish@linutronix.de,
        rostedt@goodmis.org, bigeasy@linutronix.de
Subject: [PATCH 07/14] x86/entry, mce: Disallow #DB during #MC
References: <20200529212728.795169701@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#MC is fragile as heck, don't tempt fate.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/cpu/mce/core.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1936,22 +1936,34 @@ static __always_inline void exc_machine_
 /* MCE hit kernel mode */
 DEFINE_IDTENTRY_MCE(exc_machine_check)
 {
+	unsigned long dr7;
+
+	dr7 = local_db_save();
 	exc_machine_check_kernel(regs);
+	local_db_restore(dr7);
 }
 
 /* The user mode variant. */
 DEFINE_IDTENTRY_MCE_USER(exc_machine_check)
 {
+	unsigned long dr7;
+
+	dr7 = local_db_save();
 	exc_machine_check_user(regs);
+	local_db_restore(dr7);
 }
 #else
 /* 32bit unified entry point */
 DEFINE_IDTENTRY_MCE(exc_machine_check)
 {
+	unsigned long dr7;
+
+	dr7 = local_db_save();
 	if (user_mode(regs))
 		exc_machine_check_user(regs);
 	else
 		exc_machine_check_kernel(regs);
+	local_db_restore(dr7);
 }
 #endif
 


