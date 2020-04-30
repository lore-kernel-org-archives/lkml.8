Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA43BC47247
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 21:11:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 947A6207DD
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 21:11:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iDju1l5Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbgD3VK7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 17:10:59 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:39827 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725844AbgD3VK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 17:10:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588281058;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YlN0br96igCeHtuNA7c7W45XZBUGLRWFSGtgdohoRbI=;
        b=iDju1l5YaTrSqtSeVUytp8tLxhyThSalTh9qQX+uai0x6LYM4KDW0c//t8lWQXH0R2s2/E
        bPGYvrOz63iTWGHoQVPG1UFgRMG5RMKTQY4UnPLTBfkCrD1fS1HDhg5Q30ELxdCeT5R2fl
        yr47LDKtDXGHWJ+EA+6Ncw4qiBkDAoI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-442-mGgVJOl-Os2BSYCF13HzSg-1; Thu, 30 Apr 2020 17:10:54 -0400
X-MC-Unique: mGgVJOl-Os2BSYCF13HzSg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B1ED21005510;
        Thu, 30 Apr 2020 21:10:52 +0000 (UTC)
Received: from treble (ovpn-113-19.rdu2.redhat.com [10.10.113.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E8CA8512E6;
        Thu, 30 Apr 2020 21:10:51 +0000 (UTC)
Date:   Thu, 30 Apr 2020 16:10:49 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: Remaining randconfig objtool warnings, linux-next-20200428
Message-ID: <20200430211049.76f5qhsfvw2c4gql@treble>
References: <CAK8P3a2qLJkokMGt48JRky=WUeAbJRuNmoD1oqfWdrGSC6y1LA@mail.gmail.com>
 <20200428161044.caamvx67t2z4t6vd@treble>
 <20200429185536.5xshpcwtn4be4llh@treble>
 <CAK8P3a0M9qh2-_5VKx89ZsTfy5S1zhfWwnO7rN4xYhDwBBvPjw@mail.gmail.com>
 <20200429231115.z2mo5bsmrmj4oark@treble>
 <20200429232835.yw6ajtjyleob3lmz@treble>
 <CAK8P3a07P49-AdHForem=V0_cfiTFSLLhHCEQk6-UDBOg3-Q_g@mail.gmail.com>
 <20200430143350.qezebqmx2xwdxqxq@treble>
 <20200430194630.jkwysx6eftkaf6bu@treble>
 <CAK8P3a3rPDzv4PfOArvkQ6=6b+rWX=ppnJjUaVCWMgF9dntWsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK8P3a3rPDzv4PfOArvkQ6=6b+rWX=ppnJjUaVCWMgF9dntWsA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 30, 2020 at 10:59:44PM +0200, Arnd Bergmann wrote:
> On Thu, Apr 30, 2020 at 9:46 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> > On Thu, Apr 30, 2020 at 09:33:50AM -0500, Josh Poimboeuf wrote:
> 
> >
> > So there's an easy fix below, just define an x86-specific SYSCALL_ALIAS.
> > It also requries moving the syscall alias macros to syscalls.h, but
> > that's probably where they belong anyway.
> >
> > But the objtool .cold parent alias function detection is a little
> > smelly, so I might end up cleaning that up instead if I can figure out a
> > good way to do it.
> >
> > diff --git a/arch/x86/include/asm/syscall_wrapper.h b/arch/x86/include/asm/syscall_wrapper.h
> > index a84333adeef2..abe6e633f8dc 100644
> > --- a/arch/x86/include/asm/syscall_wrapper.h
> > +++ b/arch/x86/include/asm/syscall_wrapper.h
> > @@ -79,6 +79,8 @@ extern long __ia32_sys_ni_syscall(const struct pt_regs *regs);
> >                 return __se_##name(__VA_ARGS__);                        \
> >         }
> >
> > +#define SYSCALL_ALIAS(alias, name) __alias(name) typeof(name) alias
> > +
> 
> Right, this should work in principle, though I suspect it needs to be
> changed to include the ABI name for x86, as there are separate
> entry points for 32 and 64 bit.

As far as I can tell it should actually work, because of the
x86-specific SYS_NI macro.

-- 
Josh

