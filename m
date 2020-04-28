Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF6DEC83004
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 20:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B64E62085B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 20:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZxryyFHs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbgD1UjD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 16:39:03 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:47464 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726291AbgD1UjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 16:39:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588106341;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AbPHY1AYpcEsQGK31HfahH54k0ELDBfLbhr3/3je0ok=;
        b=ZxryyFHsKgeAGkiGQVVB1cZ2ANsrVC4B5MiEIsFtcUpFfOFUMm8+DqVbvAJ5F4KwI7oLLR
        F3C3hE87mJQeRMJAu/g8c+5vKc44seRxAHOgwtPrT+vuNZXir1DKuPBVN6MpAc/N4cBac+
        fEVstAvU1v1fyzVtzkZoBfilFQ/4dzg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-420-fWpzP96SOdKWRtcRNLDKPw-1; Tue, 28 Apr 2020 16:38:59 -0400
X-MC-Unique: fWpzP96SOdKWRtcRNLDKPw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E6E47800685;
        Tue, 28 Apr 2020 20:38:57 +0000 (UTC)
Received: from treble (ovpn-112-209.rdu2.redhat.com [10.10.112.209])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 358365D710;
        Tue, 28 Apr 2020 20:38:57 +0000 (UTC)
Date:   Tue, 28 Apr 2020 15:38:55 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: Remaining randconfig objtool warnings, linux-next-20200428
Message-ID: <20200428203855.zapf6jhcp6mbft7i@treble>
References: <CAK8P3a2qLJkokMGt48JRky=WUeAbJRuNmoD1oqfWdrGSC6y1LA@mail.gmail.com>
 <20200428161044.caamvx67t2z4t6vd@treble>
 <CAK8P3a0X4kMW1BQU6x9A2oo6i3-CMxi1h=0PhQgEbBtYWbJa9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK8P3a0X4kMW1BQU6x9A2oo6i3-CMxi1h=0PhQgEbBtYWbJa9A@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 28, 2020 at 10:19:46PM +0200, Arnd Bergmann wrote:
> On Tue, Apr 28, 2020 at 6:10 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> > On Tue, Apr 28, 2020 at 04:49:15PM +0200, Arnd Bergmann wrote:
> > > ==> build/x86/0xFD7B7323_defconfig/log <==
> > > arch/x86/entry/entry_64.o: warning: objtool: .entry.text+0x991: unreachable instruction
> >
> > This warning looks correct, did you make a change to entry_64.S?
> 
> I bisected my local patches and found that I had a local hack that turned
> off CONFIG_RETPOLINE for testing something unrelated. I can reproduce
> it on linux-next with this patch:
> 
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -447,8 +447,7 @@ config GOLDFISH
>         depends on X86_GOLDFISH
> 
>  config RETPOLINE
> -       bool "Avoid speculative indirect branches in kernel"
> -       default y
> +       def_bool n
>         select STACK_VALIDATION if HAVE_STACK_VALIDATION
>         help
>           Compile kernel with the retpoline compiler options to guard against

Thanks, that worked.

This one makes no sense to me.  It looks like the assembler is inserting
a jump as part of the alignment padding???  WTH.

0000000000000980 <common_spurious>:
     980:	48 83 04 24 80       	addq   $0xffffffffffffff80,(%rsp)
     985:	e8 00 00 00 00       	callq  98a <common_spurious+0xa>
			986: R_X86_64_PLT32	interrupt_entry-0x4
     98a:	e8 00 00 00 00       	callq  98f <common_spurious+0xf>
			98b: R_X86_64_PLT32	smp_spurious_interrupt-0x4
     98f:	eb 7e                	jmp    a0f <ret_from_intr>
     991:	eb 6d                	jmp    a00 <common_interrupt>
     993:	66 66 2e 0f 1f 84 00 	data16 nopw %cs:0x0(%rax,%rax,1)
     99a:	00 00 00 00 
     99e:	66 66 2e 0f 1f 84 00 	data16 nopw %cs:0x0(%rax,%rax,1)
     9a5:	00 00 00 00 
     9a9:	66 66 2e 0f 1f 84 00 	data16 nopw %cs:0x0(%rax,%rax,1)
     9b0:	00 00 00 00 
     9b4:	66 66 2e 0f 1f 84 00 	data16 nopw %cs:0x0(%rax,%rax,1)
     9bb:	00 00 00 00 
     9bf:	66 66 2e 0f 1f 84 00 	data16 nopw %cs:0x0(%rax,%rax,1)
     9c6:	00 00 00 00 
     9ca:	66 66 2e 0f 1f 84 00 	data16 nopw %cs:0x0(%rax,%rax,1)
     9d1:	00 00 00 00 
     9d5:	66 66 2e 0f 1f 84 00 	data16 nopw %cs:0x0(%rax,%rax,1)
     9dc:	00 00 00 00 
     9e0:	66 66 2e 0f 1f 84 00 	data16 nopw %cs:0x0(%rax,%rax,1)
     9e7:	00 00 00 00 
     9eb:	66 66 2e 0f 1f 84 00 	data16 nopw %cs:0x0(%rax,%rax,1)
     9f2:	00 00 00 00 
     9f6:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
     9fd:	00 00 00 

0000000000000a00 <common_interrupt>:
     a00:	48 83 04 24 80       	addq   $0xffffffffffffff80,(%rsp)

-- 
Josh

