Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB38CC83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 23:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 952D8206D9
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 23:02:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g6t6nBy7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbgD2XCA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 19:02:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52391 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726164AbgD2XCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 19:02:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588201318;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LQCERU/9iXx7CQKWJX8dwWkirucEUyXFBwmWE+sf5Ok=;
        b=g6t6nBy7FL6i9AqB8uTZIEib75NKjL+RakxNTze2de6WL18QdXfDenJU4K5XDSmNcGT+kX
        tRFsL1SaBTrdJdjpsfvC/pNc0Hh9rK/iNahG7dwXnwWTVMo6SL4Dwb+4CP6Yv17CvUWGAJ
        Tk+sVK56vIyXpcX/i6m03VXwDiAnUp0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-490-V6jqXKJkOcGR13YkXNSZGw-1; Wed, 29 Apr 2020 19:01:56 -0400
X-MC-Unique: V6jqXKJkOcGR13YkXNSZGw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2488480B70B;
        Wed, 29 Apr 2020 23:01:55 +0000 (UTC)
Received: from treble (ovpn-113-19.rdu2.redhat.com [10.10.113.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6158C196AE;
        Wed, 29 Apr 2020 23:01:54 +0000 (UTC)
Date:   Wed, 29 Apr 2020 18:01:52 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: Remaining randconfig objtool warnings, linux-next-20200428
Message-ID: <20200429230152.gpb45k2od6rx3q7g@treble>
References: <CAK8P3a2qLJkokMGt48JRky=WUeAbJRuNmoD1oqfWdrGSC6y1LA@mail.gmail.com>
 <20200428161044.caamvx67t2z4t6vd@treble>
 <20200429185536.5xshpcwtn4be4llh@treble>
 <CAK8P3a0M9qh2-_5VKx89ZsTfy5S1zhfWwnO7rN4xYhDwBBvPjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK8P3a0M9qh2-_5VKx89ZsTfy5S1zhfWwnO7rN4xYhDwBBvPjw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 30, 2020 at 12:46:57AM +0200, Arnd Bergmann wrote:
> On Wed, Apr 29, 2020 at 8:55 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> >
> > On Tue, Apr 28, 2020 at 11:10:44AM -0500, Josh Poimboeuf wrote:
> > > > ==> build/x86/0xE0F2ACFF_defconfig/log <==
> > > > kernel/time/posix-stubs.o: warning: objtool: __x64_sys_timer_create()+0x23: sibling call from callable instruction with modified stack frame
> >
> > This one is fixed with the following cleanup:
> >
> > From: Josh Poimboeuf <jpoimboe@redhat.com>
> > Subject: [PATCH] linkage: Convert syscall alias macros to C
> >
> > There's no need to use inline asm to create ELF alias symbols.
> > Annotated C function declarations can be used instead.
> >
> > This also makes the ordering of the ELF symbol table more logical, with
> > the real function now always coming before the aliases.  This makes it
> > easier for objtool, objdump and other tools to differentiate them.
> >
> > This fixes the following warning:
> >
> >   kernel/time/posix-stubs.o: warning: objtool: __x64_sys_timer_create()+0x23: sibling call from callable instruction with modified stack frame
> >
> > Reported-by: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> > ---
> >  include/linux/linkage.h | 14 ++++----------
> >  1 file changed, 4 insertions(+), 10 deletions(-)
> 
> Unfortunately, this patch leads to new warnings when
> CONFIG_POSIX_TIMERS is disabled:

Hm, at least on x86 it seems to build fine without CONFIG_POSIX_TIMERS.
Must be some syscall quirk differences between the arches.

> In file included from /git/arm-soc/kernel/time/posix-stubs.c:9:
> /git/arm-soc/kernel/time/posix-stubs.c:35:37: error: conflicting types
> for 'sys_timer_create'
>    35 | #define SYS_NI(name)  SYSCALL_ALIAS(sys_##name, sys_ni_posix_timers)
>       |                                     ^~~~
> /git/arm-soc/include/linux/linkage.h:26:63: note: in definition of
> macro 'SYSCALL_ALIAS'
>    26 | #define SYSCALL_ALIAS(alias, name) __alias(name) typeof(name) alias
>       |                                                               ^~~~~
> /git/arm-soc/kernel/time/posix-stubs.c:42:1: note: in expansion of
> macro 'SYS_NI'
>    42 | SYS_NI(timer_create);
>       | ^~~~~~
> In file included from /git/arm-soc/kernel/time/posix-stubs.c:13:
> /git/arm-soc/include/linux/syscalls.h:616:17: note: previous
> declaration of 'sys_timer_create' was here
>   616 | asmlinkage long sys_timer_create(clockid_t which_clock,
>       |                 ^~~~~~~~~~~~~~~~
> 
> We can probably move those SYS_NI() instances to kernel/sys_ni.c,
> which does not include the header, but it's still a bit ugly. I'll try
> that tomorrow
> unless you come up with a better suggestion first.
> 
>         Arnd
> 

-- 
Josh

