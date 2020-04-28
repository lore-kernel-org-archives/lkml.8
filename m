Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C52C83008
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 21:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C6222072A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 21:56:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gSBx0TPl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbgD1V4X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 17:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726793AbgD1V4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 17:56:19 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D998C03C1AC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 14:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YTDcY2zuu3Qu48Kjzg7QUwQDDLkrS24FinA0K9b7j+8=; b=gSBx0TPlCqRAhL8G/xtPMTOVmy
        AObYUkcVspwEi6TPO6vzhDhMM3ds7fBlIFLYvEhl8DQv5Xek9hPJhO5MGE+6aamjxRrvH/3w3jsg0
        G/21ZUXyacp6pItmsE6qighxVO6an4NzQ5s2tohOLk9L2GOyXuWN9LHNpcAA3Nvu8QLL8pOk5cjen
        Y6BwQoKuwNZWPBEiwWjsJ/gi8qvquu+oGQfU3ptb9W0LvahPzI8hBEYcp21bRcKCeWOKWzmcZklys
        PPEXwCtmcxlFoqwgsjJa+Ed/s7K0mPS+zctrtSxTghr8KKVo8HZkzZL4bCu+rQOCvPViL2h5PQC6k
        +fxjwsLw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jTYCr-0003Cv-8n; Tue, 28 Apr 2020 21:55:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 82F0A304C22;
        Tue, 28 Apr 2020 23:55:54 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7323028569EF3; Tue, 28 Apr 2020 23:55:54 +0200 (CEST)
Date:   Tue, 28 Apr 2020 23:55:54 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: Remaining randconfig objtool warnings, linux-next-20200428
Message-ID: <20200428215554.GA16027@hirez.programming.kicks-ass.net>
References: <CAK8P3a2qLJkokMGt48JRky=WUeAbJRuNmoD1oqfWdrGSC6y1LA@mail.gmail.com>
 <20200428161044.caamvx67t2z4t6vd@treble>
 <CAK8P3a0X4kMW1BQU6x9A2oo6i3-CMxi1h=0PhQgEbBtYWbJa9A@mail.gmail.com>
 <20200428203855.zapf6jhcp6mbft7i@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428203855.zapf6jhcp6mbft7i@treble>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 28, 2020 at 03:38:55PM -0500, Josh Poimboeuf wrote:
> This one makes no sense to me.  It looks like the assembler is inserting
> a jump as part of the alignment padding???  WTH.
> 
> 0000000000000980 <common_spurious>:
>      980:	48 83 04 24 80       	addq   $0xffffffffffffff80,(%rsp)
>      985:	e8 00 00 00 00       	callq  98a <common_spurious+0xa>
> 			986: R_X86_64_PLT32	interrupt_entry-0x4
>      98a:	e8 00 00 00 00       	callq  98f <common_spurious+0xf>
> 			98b: R_X86_64_PLT32	smp_spurious_interrupt-0x4
>      98f:	eb 7e                	jmp    a0f <ret_from_intr>
>      991:	eb 6d                	jmp    a00 <common_interrupt>
>      993:	66 66 2e 0f 1f 84 00 	data16 nopw %cs:0x0(%rax,%rax,1)
>      99a:	00 00 00 00 
>      99e:	66 66 2e 0f 1f 84 00 	data16 nopw %cs:0x0(%rax,%rax,1)
>      9a5:	00 00 00 00 
>      9a9:	66 66 2e 0f 1f 84 00 	data16 nopw %cs:0x0(%rax,%rax,1)
>      9b0:	00 00 00 00 
>      9b4:	66 66 2e 0f 1f 84 00 	data16 nopw %cs:0x0(%rax,%rax,1)
>      9bb:	00 00 00 00 
>      9bf:	66 66 2e 0f 1f 84 00 	data16 nopw %cs:0x0(%rax,%rax,1)
>      9c6:	00 00 00 00 
>      9ca:	66 66 2e 0f 1f 84 00 	data16 nopw %cs:0x0(%rax,%rax,1)
>      9d1:	00 00 00 00 
>      9d5:	66 66 2e 0f 1f 84 00 	data16 nopw %cs:0x0(%rax,%rax,1)
>      9dc:	00 00 00 00 
>      9e0:	66 66 2e 0f 1f 84 00 	data16 nopw %cs:0x0(%rax,%rax,1)
>      9e7:	00 00 00 00 
>      9eb:	66 66 2e 0f 1f 84 00 	data16 nopw %cs:0x0(%rax,%rax,1)
>      9f2:	00 00 00 00 
>      9f6:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
>      9fd:	00 00 00 

binutils.git/gas/configure/tc-i386.c:i386_generate_nops

When there's too many NOPs (as here) it generates a JMP across the NOPS.
It makes some sort of sense, at some point executing NOPs is going to be
more expensive than a branch.. But shees..
