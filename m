Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A66EC2BA1A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 16:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A0BE2072A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 16:33:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EnklouZ2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbgDGQdI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 12:33:08 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:47768 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726883AbgDGQdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 12:33:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586277187;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dWYmPOF17U+sC21sG3I3LCOo8bkjHtTnGXVgw8ZhdZQ=;
        b=EnklouZ2Bdyfe1DzbmIj4DihfiGIpHwTZPgaAx6hA7iF7BIpOV6T9TusKu2mo9m3I4I68j
        a82cl2WApD4Cm09aNy0bCP13pfptWoQb/EdddN5mwxuVrgu7k7Bdzc3zFFf5tZn1pLEvTm
        v/CdyXokqF+QeImpdeb3UOaLAIWrXGc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-229-WdoSPLGTNWu2V2CFdCXRzA-1; Tue, 07 Apr 2020 12:32:58 -0400
X-MC-Unique: WdoSPLGTNWu2V2CFdCXRzA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E4923DB67;
        Tue,  7 Apr 2020 16:32:56 +0000 (UTC)
Received: from treble (ovpn-116-24.rdu2.redhat.com [10.10.116.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 345B519488;
        Tue,  7 Apr 2020 16:32:56 +0000 (UTC)
Date:   Tue, 7 Apr 2020 11:32:53 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: libelf-0.175 breaks objtool
Message-ID: <20200407163253.mji2z465ixaotnkh@treble>
References: <20190205133821.1a243836@gandalf.local.home>
 <20190206021611.2nsqomt6a7wuaket@treble>
 <20190206121638.3d2230c1@gandalf.local.home>
 <CAK8P3a1hsca02=jPQmBG68RTUAt-jDR-qo=UFwf13nZ0k-nDgA@mail.gmail.com>
 <20200406221614.ac2kl3vlagiaj5jf@treble>
 <CAK8P3a3QntCOJUeUfNmqogO51yh29i4NQCu=NBF4H1+h_m_Pug@mail.gmail.com>
 <CAK8P3a2Bvebrvj7XGBtCwV969g0WhmGr_xFNfSRsZ7WX1J308g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK8P3a2Bvebrvj7XGBtCwV969g0WhmGr_xFNfSRsZ7WX1J308g@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 07, 2020 at 05:46:23PM +0200, Arnd Bergmann wrote:
> On Tue, Apr 7, 2020 at 12:31 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > On Tue, Apr 7, 2020 at 12:16 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> >
> > It's also odd that I only see the problem in two specific files:
> > arch/x86/realmode/rm/trampoline_64.o (in half of the randconfig builds)
> > and fs/xfs/xfs_trace.o  (in only one configuration so far).
> >
> > With this patch I can avoid the first one, which is unconditionally
> > built with -g (why?):
> >
> > --- a/arch/x86/realmode/rm/Makefile
> > +++ b/arch/x86/realmode/rm/Makefile
> > @@ -69,7 +69,7 @@ $(obj)/realmode.relocs: $(obj)/realmode.elf FORCE
> >  # ---------------------------------------------------------------------------
> >
> >  KBUILD_CFLAGS  := $(REALMODE_CFLAGS) -D_SETUP -D_WAKEUP \
> > -                  -I$(srctree)/arch/x86/boot
> > +                  -I$(srctree)/arch/x86/boot -gz=none
> >  KBUILD_AFLAGS  := $(KBUILD_CFLAGS) -D__ASSEMBLY__
> >  KBUILD_CFLAGS  += -fno-asynchronous-unwind-tables
> >  GCOV_PROFILE := n
> >
> > I'll look at the other one tomorrow.
> 
> I found where -g gets added in both cases, and adding -gz=none
> seems to address all randconfigs with CONFIG_DEBUG_INFO=n:
> 
> --- a/fs/xfs/Makefile
> +++ b/fs/xfs/Makefile
> @@ -7,7 +7,7 @@
>  ccflags-y += -I $(srctree)/$(src)              # needed for trace events
>  ccflags-y += -I $(srctree)/$(src)/libxfs
> 
> -ccflags-$(CONFIG_XFS_DEBUG) += -g
> +ccflags-$(CONFIG_XFS_DEBUG) += -g $(call cc-option,-gz=none)

Maybe they shouldn't have -g in the first place?

-- 
Josh

