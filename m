Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 480C1C2BB85
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 11:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 290A921D91
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 11:54:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="b3eUhw5B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634209AbgDPLyE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 07:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2506634AbgDPLwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 07:52:33 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95DDAC061A0F
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 04:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=0tB8fwAECH9DTdmotSb06Thr66Emzkcwh377O0NwzJ4=; b=b3eUhw5BTRjg92BI6M0gYt1zTx
        PRvWk7ZQ187dalXP040GwQh0EZi53VzRbjRK15igKl9jNrv3SpBQFrmT4bl6Wu5E9P7fSVlYHBUET
        qJga+g/+ZaO4wZGOxtB3Vt1LFY7xfkzRaD6yDBLriM6EWwH3Ne4V57xmWFN4MIT/chCHj2FmBnu+G
        ZD85Hqx3dxGTu3BrNDkWkLa421FLWnNaVtC8UdZi+F3cQu3obDlyZZ9tpcFj92R9pYdkU1KCTI4G3
        sftACTIyBg3nk1NXsiO85bLmoHp820KJaMFxPCHxOEjv/Wyvfml+j107nJOodLEPGRJDYVEh63hMC
        Uoed8LJg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jP34D-0004s1-W9; Thu, 16 Apr 2020 11:52:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 58FEE3073F0;
        Thu, 16 Apr 2020 13:52:24 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 318C82B0DE4C5; Thu, 16 Apr 2020 13:52:24 +0200 (CEST)
Message-Id: <20200416115118.867411350@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 16 Apr 2020 13:47:12 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, jpoimboe@redhat.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, peterz@infradead.org,
        mhiramat@kernel.org, mbenes@suse.cz, jthierry@redhat.com,
        alexandre.chartre@oracle.com
Subject: [PATCH v5 06/17] x86,ftrace: Shrink ftrace_regs_caller() by one byte
References: <20200416114706.625340212@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'Optimize' ftrace_regs_caller. Instead of comparing against an
immediate, the more natural way to test for zero on x86 is: 'test
%r,%r'.

  48 83 f8 00             cmp    $0x0,%rax
  74 49                   je     226 <ftrace_regs_call+0xa3>

  48 85 c0                test   %rax,%rax
  74 49                   je     225 <ftrace_regs_call+0xa2>

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/ftrace_64.S |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/x86/kernel/ftrace_64.S
+++ b/arch/x86/kernel/ftrace_64.S
@@ -240,8 +240,8 @@ SYM_INNER_LABEL(ftrace_regs_call, SYM_L_
 	 * See arch_ftrace_set_direct_caller().
 	 */
 	movq ORIG_RAX(%rsp), %rax
-	cmpq	$0, %rax
-	je	1f
+	testq	%rax, %rax
+	jz	1f
 
 	/* Swap the flags with orig_rax */
 	movq MCOUNT_REG_SIZE(%rsp), %rdi


