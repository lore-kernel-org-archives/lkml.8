Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D795C83004
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 22:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B1F7206F0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 22:33:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Nv8yf/Sk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbgD1Wdv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 18:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725934AbgD1Wdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 18:33:50 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7976AC03C1AC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 15:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0HhYxuPpvTMfnTjhs6+jawNoSPMXkys6rgqCjV3Lnvs=; b=Nv8yf/Skx7sDnmMOLdUlv8ZEK2
        FwCXcfTB9/+EN4E+n5HS9BLZvOaH8ZLu7ASy2EtosDk3Tx8mLs4x77hQb5Sae292iCx3kjlH2ZrAE
        ciKb3Sq7oy5yiPIe/dQf4UASuocUTuWucM4Tf+fD9BxK2AcqTUptYr0NArROGKmL8eNx0crjWm1BZ
        ErrdXvlV1yWxMFhnNm/kxnPZ/f7vOSjgnkwkepX7MuryK7sOHwO2o9r4fzBiNqmQB8sxNdIFye/NF
        xpky/zdLvYAk3ca2rEyoFbCj9HX4m5pcU68mcZMGREN8W4bIgWDMf5bA02oXGDbaxB7oKipDisayg
        PYZXTKSQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jTYnA-00040N-VG; Tue, 28 Apr 2020 22:33:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5612F304121;
        Wed, 29 Apr 2020 00:33:27 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3C135286F1E28; Wed, 29 Apr 2020 00:33:27 +0200 (CEST)
Date:   Wed, 29 Apr 2020 00:33:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: Remaining randconfig objtool warnings, linux-next-20200428
Message-ID: <20200428223327.GC16027@hirez.programming.kicks-ass.net>
References: <CAK8P3a2qLJkokMGt48JRky=WUeAbJRuNmoD1oqfWdrGSC6y1LA@mail.gmail.com>
 <20200428161044.caamvx67t2z4t6vd@treble>
 <CAK8P3a0X4kMW1BQU6x9A2oo6i3-CMxi1h=0PhQgEbBtYWbJa9A@mail.gmail.com>
 <20200428203855.zapf6jhcp6mbft7i@treble>
 <20200428215554.GA16027@hirez.programming.kicks-ass.net>
 <20200428220353.uepo455bj76sym4k@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428220353.uepo455bj76sym4k@treble>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 28, 2020 at 05:03:53PM -0500, Josh Poimboeuf wrote:
> On Tue, Apr 28, 2020 at 11:55:54PM +0200, Peter Zijlstra wrote:

> > binutils.git/gas/configure/tc-i386.c:i386_generate_nops
> > 
> > When there's too many NOPs (as here) it generates a JMP across the NOPS.
> > It makes some sort of sense, at some point executing NOPs is going to be
> > more expensive than a branch.. But shees..
> 
> Urgh.  Even if I tell it specifically to pad with NOPs, it still does
> this "trick".  I have no idea how to deal with this in objtool.

This is horrible... but it _might_ just work.

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 0e9504fabe52..545f50f5de56 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -599,7 +599,18 @@ SYM_CODE_END(common_spurious)
 _ASM_NOKPROBE(common_spurious)
 
 /* common_interrupt is a hotpath. Align it */
+SYM_FUNC_START_LOCAL_NOALIGN(__ignore_me)
 	.p2align CONFIG_X86_L1_CACHE_SHIFT
+SYM_FUNC_END(__ignore_me)
+
+.pushsection .discard.func_stack_frame_non_standard
+        .align 8
+        .type   __func_stack_frame_non_standard___ignore_me, @object
+        .size   __func_stack_frame_non_standard___ignore_me, 8
+__func_stack_frame_non_standard___ignore_me:
+        .quad   __ignore_me
+.popsection
+
 SYM_CODE_START_LOCAL(common_interrupt)
 	addq	$-0x80, (%rsp)			/* Adjust vector to [-256, -1] range */
 	call	interrupt_entry
