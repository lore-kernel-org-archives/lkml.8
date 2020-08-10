Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4036C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 19:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BCD1207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 19:39:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="fUXOloVb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728394AbgHJTjZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 15:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728253AbgHJTjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 15:39:25 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2663C061787
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 12:39:24 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id h4so4411003ioe.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 12:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KG7HkPdgfYza0KKOehXlJf0mICZpLgyaJzR9GuUofuc=;
        b=fUXOloVbCXuF+NPnW17bzh2jLA3H8qu/dOC7TPKOL2QUos/sBzQ5CRoxtQJFb8g3G2
         AYIyYbs0ZfZ6aDIaEoKZNgRRcvbTvgMlsOjLIYpmuy/J3SQhbHXV5dM/VhBeVH8XellB
         6N4elr0PMDoF7N56qBjJa5HD3724dVmbT1YCW1KovZJp2EVcKcAZIlSRmBQ0dOMRG8NV
         gxciGLPqMXMCMBAt0FPiDJwhSVy/LDGoZp0gSnby2PTGC0UM1mVSjd/0MuGwflaH95zs
         j03sj8mSaBzXWRfQq5lyPgMhXF45BsJug4i9aO4ErNTiuPZEXVroBiDBsJAczCMY7u9e
         vg2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KG7HkPdgfYza0KKOehXlJf0mICZpLgyaJzR9GuUofuc=;
        b=jXHjEsOgTz+S7YEPkdW6rpDTsfl5uGtMlEcePU+94QaYO+/kjT8qzA9NQBptXNxdBJ
         DnW/7EJzFzQHiAHjTv/jI71eDNUWtvR9c1QzYwZ9UvOvO/4iEfibEZnd+EOwEG9Zm/Ef
         07nI3u/Lu97q+78oiVX+Fe9QmD6aF2Y4hHvOZxMoyCn9OroTKjqF8YNdPUBL7jYEHT7L
         ey63AvITTTgBWRajwPQV4Sfb1E5jJTJ5Vw2Z0noi2TmNCclSAzupbK0J417bzGlcL6EC
         qKapdV1UhKv9MHr+ckSl0htQJwcdUVIm+bd20chA32FWda+c5M0UK0TiL4MbYhkBUxz3
         b77Q==
X-Gm-Message-State: AOAM533c9/Npz7gJqqlIuAyjx3f1cQRQyq58w3K+Wbacy2M4Vr2o0/n1
        /DH4sb9D7yR8GcOkUHWICyotfmvcX1WBz35MwaiqpL5k
X-Google-Smtp-Source: ABdhPJyNCjBD+ApAm5EKXSFXpNtiLnuZQXUEji/Nk9r66AH8XDVZRUMie+STAQO5PpX/pDgrcUhz8sHf1IdT/5swGmI=
X-Received: by 2002:a6b:5c17:: with SMTP id z23mr18928874ioh.67.1597088363879;
 Mon, 10 Aug 2020 12:39:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a2PK_bC5=3wcWm43=y5xk-Dq5-fGPExJMnOrNfGfB1m1A@mail.gmail.com>
 <20200805172629.GA1040@bug> <CAMuHMdV20tZSu5gGsjf8h334+0xr1f=N9NvOoxHQGq42GYsj4g@mail.gmail.com>
 <20200805193001.nebwdutcek53pnit@duo.ucw.cz>
In-Reply-To: <20200805193001.nebwdutcek53pnit@duo.ucw.cz>
From:   Olof Johansson <olof@lixom.net>
Date:   Mon, 10 Aug 2020 12:39:12 -0700
Message-ID: <CAOesGMjaJ=jcdBp7b-DfetUKKF+cC6NcJdHavBXyP49b9Bztwg@mail.gmail.com>
Subject: Re: [Ksummit-discuss] [TECH TOPIC] Planning code obsolescence
To:     Pavel Machek <pavel@denx.de>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        ksummit <ksummit-discuss@lists.linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 5, 2020 at 12:30 PM Pavel Machek <pavel@denx.de> wrote:
>
> On Wed 2020-08-05 20:50:43, Geert Uytterhoeven wrote:
> > Hi Pavel,
> >
> > On Wed, Aug 5, 2020 at 7:26 PM Pavel Machek <pavel@ucw.cz> wrote:
> > > > I have submitted the below as a topic for the linux/arch/* MC that Mike
> > > > and I run, but I suppose it also makes sense to discuss it on the
> > > > ksummit-discuss mailing list (cross-posted to linux-arch and lkml) as well
> > > > even if we don't discuss it at the main ksummit track.
> > >
> > > > * Latest kernel in which it was known to have worked
> > >
> > > For some old hardware, I started collecting kernel version, .config and dmesg from
> > > successful boots. github.com/pavelmachek, click on "missy".
> >
> > You mean your complete hardware collection doesn't boot v5.8? ;-)
>
> I need to do some pushing, and yes, maybe some more testing.
>
> But I was wondering if someone sees this as useful and wants to
> contribute more devices? :-).

There's in my opinion a big difference between "the last user of this
device sent it to Pavel and now it will be supported forever in spite
of no users" and "there's a whole group of people using mainline on
these old devices and Pavel makes sure it keeps booting for them".


-Olof
