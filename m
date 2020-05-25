Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D89C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 08:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 036C42070A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 08:19:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731366AbgEYITS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 04:19:18 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:38239 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbgEYITR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 04:19:17 -0400
Received: from mail-qk1-f174.google.com ([209.85.222.174]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1M7bND-1jg7wN4B4P-0084lZ for <linux-kernel@vger.kernel.org>; Mon, 25 May
 2020 10:19:15 +0200
Received: by mail-qk1-f174.google.com with SMTP id b27so6852908qka.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 01:19:14 -0700 (PDT)
X-Gm-Message-State: AOAM5330FHJ65E864Uy9PdjB1j/nXklrLlLN09XthkgpbSzpqBQVNymR
        pEmGrjSmczFMR10G4+sRraiuBVDkVhd9Jj5oPaQ=
X-Google-Smtp-Source: ABdhPJwKO32R6aIYdvF13dZLsilOlIgnBoz3vIhhAFr8IfhE0l/E3BCjF95+XybNgXflUiFmVpPJcStTWugm4ZLDjfM=
X-Received: by 2002:ae9:ed95:: with SMTP id c143mr25887000qkg.394.1590394753855;
 Mon, 25 May 2020 01:19:13 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1587485099.git.daniele.alessandrelli@intel.com>
 <13ca92165fab2827b6d439661e75f5b91ef083c2.1587485099.git.daniele.alessandrelli@intel.com>
 <20200501081002.GA1055721@kroah.com> <f60aece195cd0700728fc38b0398949a82b72fc3.camel@linux.intel.com>
 <20200524212851.GG1192@bug>
In-Reply-To: <20200524212851.GG1192@bug>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 25 May 2020 10:18:57 +0200
X-Gmail-Original-Message-ID: <CAK8P3a225pqBfzQ19e6Gt0s_tYBp29xLb8EG==hhz=1wc7aVCA@mail.gmail.com>
Message-ID: <CAK8P3a225pqBfzQ19e6Gt0s_tYBp29xLb8EG==hhz=1wc7aVCA@mail.gmail.com>
Subject: Re: [PATCH 1/1] soc: keembay: Add Keem Bay IMR driver
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Daniele Alessandrelli <daniele.alessandrelli@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Paul J Murphy <paul.j.murphy@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:WiNxxppgdEJhgmh5hhbfBD6nr7U7AKeXVea0DoVDrqTqt0urZAO
 DRIvubja31iejXFV6+Bu+OJjC+8shXh8DXY2lPuGXZxnSmZKw1s8rFxuXFYw38Xym0qxxow
 48L+jh7Q3SP8tk/Nyj3pm8a5jCgWjqgS2B10iN5f4iCdKnwVSPF+WSu0297d+cUjys8wW0X
 13yiHtqQfQR2lRzW+uiSQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:70fIc9WmDW8=:Dt7eKSTl4qJxTkwLxhnWZq
 VT9GbdNzB9oOB+LptmjEdtAxSr25U7OAil3Nvrh+5jDBhQl4F0h88u6d9ZRbZ5sEswgZSARNw
 1dmg7KR6ODNyPDjhAAuc/bG4OBn8dfnW8wdTUoMj6st4w47dkdA49PkancohUSVXvYF5Y0g1A
 1COCp2YsaifufZ95/g5Nds5WVkm0nINx3BDe5xjEIyXq5eCpxaUthlfBTjJwWjY2i0InYKhwV
 wWFaoAWKXKVpX8FH3RYAakxLBPxyrA2CWswqO4LRIDY9nEbAXbqeiGqjoOyOyThwmhTk5byPt
 TztTxNFXFlq0xa/Lls1ba7XV7HjH0Ki1NUFt9IzTKSeZr0BLtmPFNMaF6J0arPq0c4aiTOw1t
 ry+SKboyKGHv10xhLcGBhPqbgDjJmn6Qhbc7eraQc2VqXw7XGPx/OGHXJMYVVwumrkPk7Qlsg
 8CTQ7OtaMkW3132oNG5/nb13T6B1A1tulZP9nbTa5kXcJpkC8uYkj/HIM+VRzzp9RcOjskJit
 21/W00NmRWEhiLu2QLVwqOre5eqQGjCw+X7Yt1qiZriLpO0/9bdPsdTw1aoLwXuxvnloVSwKx
 aOw0ciklM0abMiXWBcu/QrhkVPW2ZIhqK6yEa0/nsCUjQvbyL8Y6cDQEHmY0r7KrH3E7DKWvR
 oFZmTsrxXWxQtXdhkxoa79TPfWmK1XDhK73spzB0nHalQ82I5gojSWtWtdVrqaQhZ8oXCNjWb
 EHpD3BBzKtB6ifnyNTU1/7m+Arn1Y3iLqB/2nFdnaNmwO6scuJ4IiJJu5JiTWRt9GD5lG3jP/
 MQ+2stJA5bTzmX+9S+IGWoBQNiNv919Qt1oOj4FYq+AURlSvF4=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 24, 2020 at 11:28 PM Pavel Machek <pavel@ucw.cz> wrote:
>
> Hi!
>
> > > Like I said above, you just broke multi-system kernels by always
> > > trying
> > > to do this.  Trigger off of a hardware device that only your platform
> > > has in order to properly load and run.  As-is, you don't want to do
> > > this.
> >
> > My bad, I didn't consider the issue of multi-platform ARM kernels.
> >
> > The problem is that I need this code to be run early at boot, so I
> > don't think I can make this a module.
>
> How early is early enough?
>
> What bootloader are you using?
>
> I believe you should simply fix your bootloader not to pass locked memory to the kernel.
>
> Alternatively, take that memory off the "memory available" maps, and only re-add it once
> it is usable.
>
> Anything else is dangerous.

Agreed, this sounds like an incompatible extension of the boot protocol
that we should otherwise not merge.

However, there is also a lot of missing information here, and it is always
possible they are trying to something for a good reason. As long as the
problem that the bootloader is trying to solve is explained well enough
in the changelog, we can discuss it to see how it should be done properly.

       Arnd
