Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69692C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 23:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3555020656
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 23:08:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cEutBZJn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgD1XIX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 19:08:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34859 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726044AbgD1XIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 19:08:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588115301;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c7gIZHf2Nb5me8fPcM+0PdqWtp5tOUxZuSE03m8gQIY=;
        b=cEutBZJn1qKEviammIaLWvuz6DXm9UiubIvHzuS9YGgkSTHu0yeD3sMTKajx/1+sG5+R5c
        Yv4oblCIIL4FvmuohW3d8B6OiP1yOOLBtgiNjmGl/kle+55HchFM8Ii3mTq0prvrISF1K+
        7sco8OSwW4MCTFYjg+iBnNzF37pA0gs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-77-P6nrJuiCOhamUP79dYYBpg-1; Tue, 28 Apr 2020 19:08:19 -0400
X-MC-Unique: P6nrJuiCOhamUP79dYYBpg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8C730107ACF2;
        Tue, 28 Apr 2020 23:08:18 +0000 (UTC)
Received: from treble (ovpn-112-209.rdu2.redhat.com [10.10.112.209])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E0D665D750;
        Tue, 28 Apr 2020 23:08:17 +0000 (UTC)
Date:   Tue, 28 Apr 2020 18:08:15 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: Remaining randconfig objtool warnings, linux-next-20200428
Message-ID: <20200428230815.mychv6vgwgjnskjl@treble>
References: <CAK8P3a2qLJkokMGt48JRky=WUeAbJRuNmoD1oqfWdrGSC6y1LA@mail.gmail.com>
 <20200428161044.caamvx67t2z4t6vd@treble>
 <CAK8P3a0X4kMW1BQU6x9A2oo6i3-CMxi1h=0PhQgEbBtYWbJa9A@mail.gmail.com>
 <20200428203855.zapf6jhcp6mbft7i@treble>
 <20200428215554.GA16027@hirez.programming.kicks-ass.net>
 <20200428220353.uepo455bj76sym4k@treble>
 <20200428223327.GC16027@hirez.programming.kicks-ass.net>
 <20200428224838.k4ttccrtoug5otan@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200428224838.k4ttccrtoug5otan@treble>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 28, 2020 at 05:48:38PM -0500, Josh Poimboeuf wrote:
> On Wed, Apr 29, 2020 at 12:33:27AM +0200, Peter Zijlstra wrote:
> > On Tue, Apr 28, 2020 at 05:03:53PM -0500, Josh Poimboeuf wrote:
> > > On Tue, Apr 28, 2020 at 11:55:54PM +0200, Peter Zijlstra wrote:
> > 
> > > > binutils.git/gas/configure/tc-i386.c:i386_generate_nops
> > > > 
> > > > When there's too many NOPs (as here) it generates a JMP across the NOPS.
> > > > It makes some sort of sense, at some point executing NOPs is going to be
> > > > more expensive than a branch.. But shees..
> > > 
> > > Urgh.  Even if I tell it specifically to pad with NOPs, it still does
> > > this "trick".  I have no idea how to deal with this in objtool.
> > 
> > This is horrible... but it _might_ just work.
> 
> HAHA, nice.
> 
> This seems to work:

More sophisticated version:

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 3063aa9090f9..f9082673f84c 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -597,8 +597,22 @@ SYM_CODE_START_LOCAL(common_spurious)
 SYM_CODE_END(common_spurious)
 _ASM_NOKPROBE(common_spurious)
 
+/*
+ * For .p2align NOP padding with shift >= 7, if the gap is big enough, the GNU
+ * assembler decides to insert a JMP in the padding, which makes objtool sad.
+ * Force it to NOPs only, by splitting it into smaller alignments if necessary.
+ */
+.macro P2ALIGN shift
+	tmp=6
+	.rept \shift-6
+		.p2align tmp
+		tmp=tmp+1
+	.endr
+	.p2align \shift
+.endm
+
 /* common_interrupt is a hotpath. Align it */
-	.p2align CONFIG_X86_L1_CACHE_SHIFT
+P2ALIGN shift=CONFIG_X86_L1_CACHE_SHIFT
 SYM_CODE_START_LOCAL(common_interrupt)
 	addq	$-0x80, (%rsp)			/* Adjust vector to [-256, -1] range */
 	call	interrupt_entry

