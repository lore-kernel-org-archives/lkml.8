Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E517C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 22:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 699BE206D6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 22:04:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IJgFgIeV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbgD1WEB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 18:04:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60622 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725934AbgD1WEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 18:04:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588111439;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=x7LIuqG5wLPYGYdsv6WIaKm1b4GjVIP8EBSVqTIOO84=;
        b=IJgFgIeVxUocrbnUM2JiXj5IidZsWXhZrs29u/cwSIs88Dy+bJzJKBagOEVoPqbRf4QGD9
        AobWRtB9CGfGitGanKy+qGXaoLLjLru9jcpFNDp6e/izQ7ZfPLXsdFr5LM8pk4EsJtjiPG
        iumLlpUYG36orOqrpuiEVAMo6+71Ds8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-506-wirY215KMxSdU-8uPhbOsg-1; Tue, 28 Apr 2020 18:03:57 -0400
X-MC-Unique: wirY215KMxSdU-8uPhbOsg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 570FB1858E2D;
        Tue, 28 Apr 2020 22:03:56 +0000 (UTC)
Received: from treble (ovpn-112-209.rdu2.redhat.com [10.10.112.209])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A65BA1002396;
        Tue, 28 Apr 2020 22:03:55 +0000 (UTC)
Date:   Tue, 28 Apr 2020 17:03:53 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: Remaining randconfig objtool warnings, linux-next-20200428
Message-ID: <20200428220353.uepo455bj76sym4k@treble>
References: <CAK8P3a2qLJkokMGt48JRky=WUeAbJRuNmoD1oqfWdrGSC6y1LA@mail.gmail.com>
 <20200428161044.caamvx67t2z4t6vd@treble>
 <CAK8P3a0X4kMW1BQU6x9A2oo6i3-CMxi1h=0PhQgEbBtYWbJa9A@mail.gmail.com>
 <20200428203855.zapf6jhcp6mbft7i@treble>
 <20200428215554.GA16027@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200428215554.GA16027@hirez.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 28, 2020 at 11:55:54PM +0200, Peter Zijlstra wrote:
> On Tue, Apr 28, 2020 at 03:38:55PM -0500, Josh Poimboeuf wrote:
> > This one makes no sense to me.  It looks like the assembler is inserting
> > a jump as part of the alignment padding???  WTH.
> > 
> > 0000000000000980 <common_spurious>:
> >      980:	48 83 04 24 80       	addq   $0xffffffffffffff80,(%rsp)
> >      985:	e8 00 00 00 00       	callq  98a <common_spurious+0xa>
> > 			986: R_X86_64_PLT32	interrupt_entry-0x4
> >      98a:	e8 00 00 00 00       	callq  98f <common_spurious+0xf>
> > 			98b: R_X86_64_PLT32	smp_spurious_interrupt-0x4
> >      98f:	eb 7e                	jmp    a0f <ret_from_intr>
> >      991:	eb 6d                	jmp    a00 <common_interrupt>
> >      993:	66 66 2e 0f 1f 84 00 	data16 nopw %cs:0x0(%rax,%rax,1)
> >      99a:	00 00 00 00 
> >      99e:	66 66 2e 0f 1f 84 00 	data16 nopw %cs:0x0(%rax,%rax,1)
> >      9a5:	00 00 00 00 
> >      9a9:	66 66 2e 0f 1f 84 00 	data16 nopw %cs:0x0(%rax,%rax,1)
> >      9b0:	00 00 00 00 
> >      9b4:	66 66 2e 0f 1f 84 00 	data16 nopw %cs:0x0(%rax,%rax,1)
> >      9bb:	00 00 00 00 
> >      9bf:	66 66 2e 0f 1f 84 00 	data16 nopw %cs:0x0(%rax,%rax,1)
> >      9c6:	00 00 00 00 
> >      9ca:	66 66 2e 0f 1f 84 00 	data16 nopw %cs:0x0(%rax,%rax,1)
> >      9d1:	00 00 00 00 
> >      9d5:	66 66 2e 0f 1f 84 00 	data16 nopw %cs:0x0(%rax,%rax,1)
> >      9dc:	00 00 00 00 
> >      9e0:	66 66 2e 0f 1f 84 00 	data16 nopw %cs:0x0(%rax,%rax,1)
> >      9e7:	00 00 00 00 
> >      9eb:	66 66 2e 0f 1f 84 00 	data16 nopw %cs:0x0(%rax,%rax,1)
> >      9f2:	00 00 00 00 
> >      9f6:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
> >      9fd:	00 00 00 
> 
> binutils.git/gas/configure/tc-i386.c:i386_generate_nops
> 
> When there's too many NOPs (as here) it generates a JMP across the NOPS.
> It makes some sort of sense, at some point executing NOPs is going to be
> more expensive than a branch.. But shees..

Urgh.  Even if I tell it specifically to pad with NOPs, it still does
this "trick".  I have no idea how to deal with this in objtool.

-- 
Josh

