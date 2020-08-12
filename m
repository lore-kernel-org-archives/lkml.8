Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6FF4C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 15:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C43902080C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 15:13:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="VndYFHLs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbgHLPNa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 11:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbgHLPN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 11:13:27 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B92FAC061383
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 08:13:26 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id t15so1772954edq.13
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 08:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VN6ir83bMjgYQIdeAbdj93K7AbOe8f4BRPi3nEgO7zE=;
        b=VndYFHLsjboSueemTm/gTWyU/6d+bUbeH7HKxWM99Yng+XUQUYNG/AbXbblBZBH/An
         /D674H4Y7QIjzxINCgZkEWjRdtLus6PyQhylX/IDuaUQ2j/48lydT4RO0vFLUPvqjs0i
         laNjZmgU04BRpDmsumDv8mvr+p3mwHETI4Oyo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VN6ir83bMjgYQIdeAbdj93K7AbOe8f4BRPi3nEgO7zE=;
        b=sa4wGV6kxBUxidRXAtRWgl/PtaKTwyxr/lfrZlLYfoJmWhk/SXd/IVUo4ZT1u8pAMl
         5G5Kate+xZ//07yUzyitFP9/bdwoo0zq3cgDqA0bH4XD1PXw/nVeHdare0b3Hz62Im8n
         5BJlwgIUpbLUJhS/GyD69w+L52TZYz2nCqClfLvvresX1HmDVJ9lNhluoOmsErD+FO5P
         MePVASCivw2xMUDQ/K9biWx9KOjU/l6wysfERg7+kvWwmL6yBBHD4CYifN5M0zerEpfA
         YjcABJ49U8CzbJC95UHD1k/7/hZn9M5YZdowcuP3UJLOO0S74lBs/mMLKcLWkZ+ckoOi
         3rVA==
X-Gm-Message-State: AOAM533NWxMINTLEpUqxz7D1ct3dQvW8+brG3/0qfRq+rC/llakyeQvM
        lG6oe/vyEV5n0Jnq/Wx1Bb9rE25pyLuOlCaIFG/AnQ==
X-Google-Smtp-Source: ABdhPJx4u1q1FLW556zPlIsLcP302q5ujVZaE+rGeWv7TC31XhI4j+ua8W7rg17I4ZmHnOSV4oPmxDB/frsEThGPkcc=
X-Received: by 2002:a05:6402:13d4:: with SMTP id a20mr368514edx.161.1597245205349;
 Wed, 12 Aug 2020 08:13:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjzLmMRf=QG-n+1HnxWCx4KTQn9+OhVvUSJ=ZCQd6Y1WA@mail.gmail.com>
 <5C8E0FA8-274E-4B56-9B5A-88E768D01F3A@amacapital.net> <a6cd01ed-918a-0ed7-aa87-0585db7b6852@schaufler-ca.com>
 <CAJfpegvUBpb+C2Ab=CLAwWffOaeCedr-b7ZZKZnKvF4ph1nJrw@mail.gmail.com>
 <CAG48ez3Li+HjJ6-wJwN-A84WT2MFE131Dt+6YiU96s+7NO5wkQ@mail.gmail.com>
 <CAJfpeguh5VaDBdVkV3FJtRsMAvXHWUcBfEpQrYPEuX9wYzg9dA@mail.gmail.com>
 <CAHk-=whE42mFLi8CfNcdB6Jc40tXsG3sR+ThWAFihhBwfUbczA@mail.gmail.com>
 <CAJfpegtXtj2Q1wsR-3eUNA0S=_skzHF0CEmcK_Krd8dtKkWkGA@mail.gmail.com>
 <20200812143957.GQ1236603@ZenIV.linux.org.uk> <CAJfpegvFBdp3v9VcCp-wNDjZnQF3q6cufb-8PJieaGDz14sbBg@mail.gmail.com>
 <20200812150807.GR1236603@ZenIV.linux.org.uk>
In-Reply-To: <20200812150807.GR1236603@ZenIV.linux.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 12 Aug 2020 17:13:14 +0200
Message-ID: <CAJfpegsQF1aN4XJ_8j977rnQESxc=Kcn7Z2C+LnVDWXo4PKhTQ@mail.gmail.com>
Subject: Re: file metadata via fs API (was: [GIT PULL] Filesystem Information)
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jann Horn <jannh@google.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Andy Lutomirski <luto@amacapital.net>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Karel Zak <kzak@redhat.com>, Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Christian Brauner <christian@brauner.io>,
        Lennart Poettering <lennart@poettering.net>,
        Linux API <linux-api@vger.kernel.org>,
        Ian Kent <raven@themaw.net>,
        LSM <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 12, 2020 at 5:08 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Wed, Aug 12, 2020 at 04:46:20PM +0200, Miklos Szeredi wrote:
>
> > > "Can those suckers be passed to
> > > ...at() as starting points?
> >
> > No.
>
> Lovely.  And what of fchdir() to those?

Not allowed.

> Are they all non-directories?
> Because the starting point of ...at() can be simulated that way...
>
> > >  Can they be bound in namespace?
> >
> > No.
> >
> > > Can something be bound *on* them?
> >
> > No.
> >
> > >  What do they have for inodes
> > > and what maintains their inumbers (and st_dev, while we are at
> > > it)?
> >
> > Irrelevant.  Can be some anon dev + shared inode.
> >
> > The only attribute of an attribute that I can think of that makes
> > sense would be st_size, but even that is probably unimportant.
> >
> > >  Can _they_ have secondaries like that (sensu Swift)?
> >
> > Reference?
>
> http://www.online-literature.com/swift/3515/
>         So, naturalists observe, a flea
>         Has smaller fleas that on him prey;
>         And these have smaller still to bite 'em,
>         And so proceed ad infinitum.
> of course ;-)
> IOW, can the things in those trees have secondary trees on them, etc.?
> Not "will they have it in your originally intended use?" - "do we need
> the architecture of the entire thing to be capable to deal with that?"

No.

>
> > > Is that a flat space, or can they be directories?"
> >
> > Yes it has a directory tree.   But you can't mkdir, rename, link,
> > symlink, etc on anything in there.
>
> That kills the "shared inode" part - you'll get deadlocks from
> hell that way.

No.  The shared inode is not for lookup, just for the open file.

>  "Can't mkdir" doesn't save you from that.  BTW,
> what of unlink()?  If the tree shape is not a hardwired constant,
> you get to decide how it's initially populated...
>
> Next: what will that tree be attached to?  As in, "what's the parent
> of its root"?  And while we are at it, what will be the struct mount
> used with those - same as the original file, something different
> attached to it, something created on the fly for each pathwalk and
> lazy-umounted?  And see above re fchdir() - if they can be directories,
> it's very much in the game.

Why does it have to have a struct mount?  It does not have to use
dentry/mount based path lookup.

Thanks,
Miklos
