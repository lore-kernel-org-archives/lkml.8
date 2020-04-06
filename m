Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D87C2BA80
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 22:16:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77BAF2078A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 22:16:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZpSXuzk/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbgDFWQY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 18:16:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41639 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726112AbgDFWQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 18:16:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586211383;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i13t3l6p+DYX/XFr7w4SHbnbJlldKq1YsS0C2pumidA=;
        b=ZpSXuzk/a6EWXkziQHfgfN6/GEf+RzJw6d9ZxY+JkwhHw2RFONMU6W3Q6tCVKd94W0ZjIy
        eeuw8WnSVW7TSYrXIi91XUQPe3WciY2+wNrf6kvYdA0P8eki41EUK4R4cCTIQcul/Oz7Gz
        E70cZPJNLRnQ3qEgCzX+DqOr/pgcn5E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-457-CNFbPuPwPYOwPJGqVE967Q-1; Mon, 06 Apr 2020 18:16:18 -0400
X-MC-Unique: CNFbPuPwPYOwPJGqVE967Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 940D118A8C80;
        Mon,  6 Apr 2020 22:16:17 +0000 (UTC)
Received: from treble (ovpn-116-24.rdu2.redhat.com [10.10.116.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BEB36CDBE2;
        Mon,  6 Apr 2020 22:16:16 +0000 (UTC)
Date:   Mon, 6 Apr 2020 17:16:14 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: libelf-0.175 breaks objtool
Message-ID: <20200406221614.ac2kl3vlagiaj5jf@treble>
References: <20190205133821.1a243836@gandalf.local.home>
 <20190206021611.2nsqomt6a7wuaket@treble>
 <20190206121638.3d2230c1@gandalf.local.home>
 <CAK8P3a1hsca02=jPQmBG68RTUAt-jDR-qo=UFwf13nZ0k-nDgA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK8P3a1hsca02=jPQmBG68RTUAt-jDR-qo=UFwf13nZ0k-nDgA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 06, 2020 at 11:07:15PM +0200, Arnd Bergmann wrote:
> On Wed, Feb 6, 2019 at 7:32 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> > On Tue, 5 Feb 2019 20:16:11 -0600 Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> >
> > > On Tue, Feb 05, 2019 at 01:38:21PM -0500, Steven Rostedt wrote:
> > > > Just a FYI.
> > > >
> > > > After a recent upgrade in debian testing, I was not able to build the
> > > > kernel. I have a custom build of gcc, so I thought it was strange that
> > > > I was getting something like this (took this from the web, as I don't
> > > > have the error anymore with the work around, and currently doing a full
> > > > build):
> > > >
> > > > objdump: kernel/.tmp_signal.o: unable to initialize decompress status for section .debug_info
> > > > objdump: kernel/.tmp_signal.o: unable to initialize decompress status for section .debug_info
> > > > objdump: kernel/.tmp_signal.o: file format not recognized
> > > >   CC      arch/x86/kernel/platform-quirks.o
> > > > objdump: arch/x86/kernel/.tmp_ebda.o: unable to initialize decompress status for section .debug_info
> > > > objdump: arch/x86/kernel/.tmp_ebda.o: unable to initialize decompress status for section .debug_info
> > > > objdump: arch/x86/kernel/.tmp_ebda.o: file format not recognized
> > > > objdump: mm/.tmp_swap_slots.o: unable to initialize decompress status for section .debug_info
> > > > objdump: mm/.tmp_swap_slots.o: unable to initialize decompress status for section .debug_info
> > > > objdump: mm/.tmp_swap_slots.o: file format not recognized
> > >
> > > I installed debian testing on a VM, which has libelf 0.175-2, but I
> >
> > Hmm, I only have libelf-0.175 (no -2)
> >
> > > can't recreate.  Can you share your config?
> > >
> >
> > It's just a distro config. Ah, I think it's because I'm compiling my
> > own home built gcc. There seems to be an incompatibility with the
> > binutils that I used and with libelf-0.175. If I build with just the
> > distro gcc, it works.
> >
> > Bah, this means I need to recreate my gcc that I use to build my
> > kernels with :-p As I like to control which gcc I use.
> 
> I now see the same problem that you reported using the gcc-9
> toolchain I provide on https://kernel.org/pub/tools/crosstool/.
> 
> Do you have any other information that might help me fix it?

This sounds like an issue I saw before where the toolchain wants to
compress debuginfo (DWARF debug_info sections).  The "fix" was to add
'-gz=none' to KCFLAGS.

But if it's a desired feature then we could probably teach objtool to
deal with it.  It ignores DWARF anyway.

-- 
Josh

