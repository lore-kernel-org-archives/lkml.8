Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF43CC2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 15:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C465022464
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 15:11:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vQchanyu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728982AbgATPLN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 10:11:13 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:44343 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbgATPLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 10:11:12 -0500
Received: by mail-oi1-f194.google.com with SMTP id d62so28706790oia.11
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 07:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TQoSylkDTjGNW+otOWNEut12k2291qZWwUfCl+hYpEQ=;
        b=vQchanyuO70Z5EGQnoMxx1gScqFQzlQR4A5b+1yUyTm5zGPm9br/FIVu4v9HRD57H7
         7Z2uFgqE6uNowRlgQDT87nV2pFknhrlTNSZB3/gQcc872TfzH+7KraS6DjWAXeAa0i/V
         QJojrBCtgsGr1GHDAu8O/Tbj3LOBpHBltF19yQNeIzKc1+9Wc85AsqSGZBDholF1//W1
         rqmBKMJo8kxtKbIfAIP9O0jOrShRo9ET/nTs00X6u8QnFWjK/ySQQb/5Pv3h9EyiWUxD
         9bme+MpIHHhE09cnW3tQHBCplvmqD++2jibFLjF4lSr/sfjClXQZ6ZAkKU9Zfxu2EZ29
         MDYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TQoSylkDTjGNW+otOWNEut12k2291qZWwUfCl+hYpEQ=;
        b=BV8cOWeRSeuArDWcgWZFaEC7ZuBWIjdmpi2DTxvGsQ72NVviotl0SAhXLDItJWhVM+
         G7R+vhKwIoZPg1USDmpK4IbKDbfW+7gg9lL3U4B3hy88Y8GZYy9g1IqY/ZsNmaJQVync
         0Kn0dJeifVCVHxbP4yGf0gS+ZlOEVvpr1c1XwTV6gzaFldlNIQEDn6/jGPzFLcFra2Zz
         eNXhwcMAzsP2N6TksIpLXrfY0WI3rB/paPI95ayfaogJajmJK914cu3WwybjHmoKD9OL
         iyJR3tTkUuNwidgrq2zZ6sYclyuDPh2YUri4QTVJi9e7Y/qh4bVnTGXM5gz5myKJAcva
         c80g==
X-Gm-Message-State: APjAAAXEGIJwMYQsuMV1QnAM3SQBG1RlQfTcmKq2xjWV69Z+vKnjWEiT
        E/KjIVKMfSkxyz14P/E6uTaEccB4Huwf4Sn9PfArKg==
X-Google-Smtp-Source: APXvYqxHNO8Wy7YfP0r/9CRFT9lGPPzl6fsdi0/lWx6CKOX9WuFobiss3VFcGTw8q94N0XUMCb44V0VVtEP60Snw5Ag=
X-Received: by 2002:aca:d4c1:: with SMTP id l184mr13228717oig.172.1579533071637;
 Mon, 20 Jan 2020 07:11:11 -0800 (PST)
MIME-Version: 1.0
References: <20200115165749.145649-1-elver@google.com> <CAK8P3a3b=SviUkQw7ZXZF85gS1JO8kzh2HOns5zXoEJGz-+JiQ@mail.gmail.com>
 <CANpmjNOpTYnF3ssqrE_s+=UA-2MpfzzdrXoyaifb3A55_mc0uA@mail.gmail.com>
 <CAK8P3a3WywSsahH2vtZ_EOYTWE44YdN+Pj6G8nt_zrL3sckdwQ@mail.gmail.com>
 <CANpmjNMk2HbuvmN1RaZ=8OV+tx9qZwKyRySONDRQar6RCGM1SA@mail.gmail.com>
 <CAK8P3a066Knr-KC2v4M8Dr1phr0Gbb2KeZZLQ7Ana0fkrgPDPg@mail.gmail.com>
 <CANpmjNO395-atZXu_yEArZqAQ+ib3Ack-miEhA9msJ6_eJsh4g@mail.gmail.com>
 <CANpmjNOH1h=txXnd1aCXTN8THStLTaREcQpzd5QvoXz_3r=8+A@mail.gmail.com> <CAK8P3a0p9Y8080T-RR2pp-p2_A0FBae7zB-kSq09sMZ_X7AOhw@mail.gmail.com>
In-Reply-To: <CAK8P3a0p9Y8080T-RR2pp-p2_A0FBae7zB-kSq09sMZ_X7AOhw@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 20 Jan 2020 16:11:00 +0100
Message-ID: <CANpmjNOUTed6FT8X0bUSc1tGBh3jrEJ0DRpQwBfoPF5ah8Wrhw@mail.gmail.com>
Subject: Re: [PATCH -rcu] asm-generic, kcsan: Add KCSAN instrumentation for bitops
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        christophe leroy <christophe.leroy@c-s.fr>,
        Daniel Axtens <dja@axtens.net>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Jan 2020 at 15:40, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Mon, Jan 20, 2020 at 3:23 PM Marco Elver <elver@google.com> wrote:
> > On Fri, 17 Jan 2020 at 14:14, Marco Elver <elver@google.com> wrote:
> > > On Fri, 17 Jan 2020 at 13:25, Arnd Bergmann <arnd@arndb.de> wrote:
> > > > On Wed, Jan 15, 2020 at 9:50 PM Marco Elver <elver@google.com> wrote:
>
> > > > If you can't find any, I would prefer having the simpler interface
> > > > with just one set of annotations.
> > >
> > > That's fair enough. I'll prepare a v2 series that first introduces the
> > > new header, and then applies it to the locations that seem obvious
> > > candidates for having both checks.
> >
> > I've sent a new patch series which introduces instrumented.h:
> >    http://lkml.kernel.org/r/20200120141927.114373-1-elver@google.com
>
> Looks good to me, feel free to add
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
>
> if you are merging this through your own tree or someone else's,
> or let me know if I should put it into the asm-generic git tree.

Thank you!  It seems there is still some debate around the user-copy
instrumentation.

The main question we have right now is if we should add pre/post hooks
for them. Although in the version above I added KCSAN checks after the
user-copies, it seems maybe we want it before. I personally don't have
a strong preference, and wanted to err on the side of being more
conservative.

If I send a v2, and it now turns out we do all the instrumentation
before the user-copies for KASAN and KCSAN, then we have a bunch of
empty hooks. However, for KMSAN we need the post-hook, at least for
copy_from_user. Do you mind a bunch of empty functions to provide
pre/post hooks for user-copies? Could the post-hooks be generally
useful for something else?

Thanks,
-- Marco
