Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E172C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 20:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BFCB2072D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 20:27:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="O1FCE4Cd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407258AbgE1U1D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 16:27:03 -0400
Received: from merlin.infradead.org ([205.233.59.134]:36694 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407072AbgE1U0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 16:26:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=k3Mbxlp1+H5DgdG9uWBmILKu8uyCSkCfmikx/X5pBLQ=; b=O1FCE4CdUNIB4tEqLYyIf65rgZ
        S9xZEdZVxMp/VIT63OdyLeYPbu1Ny/WIC890DdVpd+2ensDYVfZpfiB47X0mltinDhu3McZ94MvRW
        GDR9EH6YxFDKu+im2FCvGArX0kZRBWgExFEqlHJeYKIvpKvTvoT6F8ModCho2BeTWoO3PZHuductr
        yvdo0pyuTcjZojs2qLB7/cWUXmLmk+shmCh07i8YcCP3luEZ9eNCmuElqUjejEeQF+tjR3b9QctaW
        +J3RuOxUK3+yP7IFgrL0D42+uHd7XnWKhKxRhS2/7haKdSww36E2tkmnMDve6sBvahGS6r3jiVYbW
        dLcH9AAg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jeP4m-0003gc-Sy; Thu, 28 May 2020 20:24:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E9CEC304BDF;
        Thu, 28 May 2020 22:24:22 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id D39092BA01B17; Thu, 28 May 2020 22:24:22 +0200 (CEST)
Message-ID: <20200528202328.531466167@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 28 May 2020 22:19:40 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, luto@amacapital.net, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        sean.j.christopherson@intel.com, andrew.cooper3@citrix.com,
        daniel.thompson@linaro.org
Subject: [PATCH 3/6] x86/entry, mce: Disallow #DB during #MC
References: <20200528201937.038455891@infradead.org>
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
@@ -1943,22 +1943,34 @@ static __always_inline void exc_machine_
 /* MCE hit kernel mode */
 DEFINE_IDTENTRY_MCE(exc_machine_check)
 {
+	unsigned long dr7;
+
+	local_db_save(&dr7);
 	exc_machine_check_kernel(regs);
+	local_db_restore(dr7);
 }
 
 /* The user mode variant. */
 DEFINE_IDTENTRY_MCE_USER(exc_machine_check)
 {
+	unsigned long dr7;
+
+	local_db_save(&dr7);
 	exc_machine_check_user(regs);
+	local_db_restore(dr7);
 }
 #else
 /* 32bit unified entry point */
 DEFINE_IDTENTRY_MCE(exc_machine_check)
 {
+	unsigned long dr7;
+
+	local_db_save(&dr7);
 	if (user_mode(regs))
 		exc_machine_check_user(regs);
 	else
 		exc_machine_check_kernel(regs);
+	local_db_restore(dr7);
 }
 #endif
 


