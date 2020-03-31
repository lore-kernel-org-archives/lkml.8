Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74240C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 19:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CD262072E
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 19:40:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QVvuXjA6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730902AbgCaTk4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 15:40:56 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34810 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730642AbgCaTkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 15:40:55 -0400
Received: by mail-pf1-f196.google.com with SMTP id 23so10854342pfj.1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 12:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1k2Wmff8smQkle9ahxWlMJVScKrQOt29svFTAK1Lhr8=;
        b=QVvuXjA67ZcCCqygGJUKSlPMfyHK0xdJ6Rw61Gqsg30dzIu5NMOUp/9yY3nEfYRnj8
         AdLJ9oB9xMb2+2aB63EtqF14AeDIKJjjAbnw4MVEUfWAd8dfT7QzGqvvFe+BJQfEmwph
         Ok0JFzTKfoHgmRGub5+uaQNh55Cu+xLH/U8++emKAIMo9KN9XvIE4fO7i9bK17XWIPY8
         hFtRzu7sQQ9xgW4BgM+QEYPmw3DLgpVtCwS/W5a851N6aU+llEAUPUqNZa7OHvhB8MVr
         arVj9aP0vGpmgJbyLdDL9zDat6PKlEA59Zg3j7NQELuQn6/xulzwTuRwN1nLkED3CvAC
         Zw3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1k2Wmff8smQkle9ahxWlMJVScKrQOt29svFTAK1Lhr8=;
        b=SDJArZK88lJzA+eoVmnWf0+WwUQ5PqG2xBxGJEggNZFSya/81J0EVPMfUH6JqjUa4G
         apiF+Ciqa1HOxOBs6jVGJVH26kjncPndt11hDZoJP4MFcotOsGYQWWoM8fz9K7s+hjdM
         ye9VeMv0umcqEHF3ri1mm/ZNHcm4xwmQFSEjLxETl8QucgjLxbIJuB2ouxyZKPpHKc/8
         t/ESwZX8HIH/ZlEtENzxPT2xwoYEqkdPcAcvbRqS9xijuzYZ3272o28GSXT29KD6bHS6
         ijwjmTLHuxR6fTaf2Zdb17mw63l0/dO6OQlzi6yxCrrm9mjBPOoNrL2A/6LK58Z/biAq
         E+tw==
X-Gm-Message-State: ANhLgQ02O4+ckC0L8KX/0JIXrOcUe4tayeZIRXY3ZzU7ZmFFHAHff7jZ
        0hD6F14cH3GowhRfFkLaa0gipau/+4c8IKqmDO2WQw==
X-Google-Smtp-Source: ADFU+vvmC7Wvr2s2YSmUeaO3tF2LUvcQXFiCa14tYL5/nWsE4n65TMY9KMQcIRj1rXRAe7KJRoZ0BUAqlxhBkXYwsJU=
X-Received: by 2002:a05:6a00:42:: with SMTP id i2mr19631475pfk.108.1585683653136;
 Tue, 31 Mar 2020 12:40:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200317202404.GA20746@ubuntu-m2-xlarge-x86> <20200317215515.226917-1-ndesaulniers@google.com>
 <20200327224246.GA12350@ubuntu-m2-xlarge-x86> <CAK7LNAShb1gWuZyycLAGWm19EWn17zeNcmdPyqu1o=K9XrfJbg@mail.gmail.com>
 <CAK7LNAQ3=jUu4aa=JQB8wErUGDd-Vr=cX_yZSdP_uAP6kWZ=pw@mail.gmail.com>
 <CAKwvOd=5AG1ARw6JUXmkuiftuShuYHKLk0ZnueuLhvOdMr5dOA@mail.gmail.com>
 <20200330190312.GA32257@ubuntu-m2-xlarge-x86> <CAK7LNAT1HoV5wUZRdeU0+P1nYAm2xQ4tpOG+7UtT4947QByakg@mail.gmail.com>
 <CAKwvOd==U6NvvYz8aUz8fUNdvz27pKrn8X5205rFadpGXzRC-Q@mail.gmail.com> <20200331193544.GA55810@ubuntu-m2-xlarge-x86>
In-Reply-To: <20200331193544.GA55810@ubuntu-m2-xlarge-x86>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 31 Mar 2020 12:40:42 -0700
Message-ID: <CAKwvOdnY64uo=73P2qkJkMbFxPTX8v7gC0cfxFndpaqsQ_c-CQ@mail.gmail.com>
Subject: Re: [PATCH v2] Makefile.llvm: simplify LLVM build
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sandeep Patil <sspatil@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 31, 2020 at 12:35 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> On Tue, Mar 31, 2020 at 11:39:27AM -0700, Nick Desaulniers wrote:
> > On Mon, Mar 30, 2020 at 11:25 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> > >
> > > In fact, the debian provides multiple versions of GCC.
> > > For example, my machine has
> > >
> > > masahiro@pug:~$ ls -1 /usr/bin/gcc-*
> > > /usr/bin/gcc-4.8
> > > /usr/bin/gcc-5
> > > /usr/bin/gcc-7
> > > /usr/bin/gcc-ar
> > > /usr/bin/gcc-ar-4.8
> > > /usr/bin/gcc-ar-5
> > > /usr/bin/gcc-ar-7
> > > /usr/bin/gcc-nm
> > > /usr/bin/gcc-nm-4.8
> > > /usr/bin/gcc-nm-5
> > > /usr/bin/gcc-nm-7
> > > /usr/bin/gcc-ranlib
> > > /usr/bin/gcc-ranlib-4.8
> > > /usr/bin/gcc-ranlib-5
> > > /usr/bin/gcc-ranlib-7
> > >
> > > But, nobody has suggested GCC_SUFFIX.
> > >
> > > So, I guess CROSS_COMPILE was enough to
> > > choose a specific tool version.
> >
> > Or no one was testing specific versions of gcc with more than one
> > installed.  I can ask the KernelCI folks next week if this is an issue
> > they face or have faced.
>
> Well gcc is just one tool, so specified CC=gcc-5 is not that
> complicated; it would get a lot more gnarly if one had different
> versions of binutils as well.

Have you had to test different releases of binutils yet? I have, and
it was not fun.  I don't even remember what I did but I recall it
being painful trying to get it to work.  (I think I finally solved it
via temporary symlink).  Speaking of, I should get back to those
dwarf-5 patches I started, now that binutils devs implemented every
missing feature I could find.
-- 
Thanks,
~Nick Desaulniers
