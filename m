Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F364BC83000
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 14:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0FD82072A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 14:34:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cnvp7g4N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728261AbgD3OeJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 10:34:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34022 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726853AbgD3OeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 10:34:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588257247;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ebnA/kggdT/1EKvLjwgkRzOpbw07q2x9PwmhkvHewqk=;
        b=cnvp7g4NWyOMcShq1uHrp6LERimclGs8dwzW+9u60T0ePTvvDCG62Jv87CcEhc4cb8YiYD
        aEmxg3Sq0OoPuSjkHibe8ZWAVOpYh1MwjuE6V0PSgJA6xjXHuAtuKzN2W3yleZAPoKct5A
        piB9Jjl/ZVwk0XW+hqjF7NseynyxxjM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-TTY7TU5fOTORuPc4zxHzqQ-1; Thu, 30 Apr 2020 10:34:05 -0400
X-MC-Unique: TTY7TU5fOTORuPc4zxHzqQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8AA72835BC1;
        Thu, 30 Apr 2020 14:33:53 +0000 (UTC)
Received: from treble (ovpn-113-19.rdu2.redhat.com [10.10.113.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C919A38A;
        Thu, 30 Apr 2020 14:33:52 +0000 (UTC)
Date:   Thu, 30 Apr 2020 09:33:50 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: Remaining randconfig objtool warnings, linux-next-20200428
Message-ID: <20200430143350.qezebqmx2xwdxqxq@treble>
References: <CAK8P3a2qLJkokMGt48JRky=WUeAbJRuNmoD1oqfWdrGSC6y1LA@mail.gmail.com>
 <20200428161044.caamvx67t2z4t6vd@treble>
 <20200429185536.5xshpcwtn4be4llh@treble>
 <CAK8P3a0M9qh2-_5VKx89ZsTfy5S1zhfWwnO7rN4xYhDwBBvPjw@mail.gmail.com>
 <20200429231115.z2mo5bsmrmj4oark@treble>
 <20200429232835.yw6ajtjyleob3lmz@treble>
 <CAK8P3a07P49-AdHForem=V0_cfiTFSLLhHCEQk6-UDBOg3-Q_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK8P3a07P49-AdHForem=V0_cfiTFSLLhHCEQk6-UDBOg3-Q_g@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 30, 2020 at 03:41:56PM +0200, Arnd Bergmann wrote:
> On Thu, Apr 30, 2020 at 1:28 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> >
> > On Wed, Apr 29, 2020 at 06:11:15PM -0500, Josh Poimboeuf wrote:
> > > > We can probably move those SYS_NI() instances to kernel/sys_ni.c,
> > > > which does not include the header, but it's still a bit ugly. I'll try
> > > > that tomorrow
> > > > unless you come up with a better suggestion first.
> > >
> > > Oh I guess arm32 doesn't have SYS_NI defined.  All this syscall aliasing
> > > stuff is a total mystery to me.
> >
> > Another idea would be to split up syscalls.h into two files: one for
> > SYSCALL_* macros and one for sys_*() function prototypes.  It sounds
> > like the latter aren't needed by most header files anyway.
> >
> >  * Please note that these prototypes here are only provided for information
> >  * purposes, for static analysis, and for linking from the syscall table.
> >  * These functions should not be called elsewhere from kernel code.
> 
> To me the main purpose of the header is to ensure the calling conventions
> are sane, so I'd definitely want to see the declarations included whenever
> a syscall is defined. I would also expect to see a warnig from sparse, or
> from gcc with "make W=1" when an extern function is defined with no
> prior declaration.

Yup, makes sense.  I think I've been getting confused by the syscall
wrappers.

> How hard would it be to change objtool instead of changing the sources?

It might be a little tricky, but I can look into it.

-- 
Josh

