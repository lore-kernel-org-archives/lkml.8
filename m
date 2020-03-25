Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48741C1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 14:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19840215A4
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 14:40:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qE5Fv4Ps"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727710AbgCYOks (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 10:40:48 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:33753 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727585AbgCYOks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 10:40:48 -0400
Received: by mail-io1-f68.google.com with SMTP id o127so2483033iof.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 07:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h+jKt9bsyXdUzaMhUnmlr3KTPbgwiELllBZem+05Lcg=;
        b=qE5Fv4PsuReML5rCkHpkMV03/oHuox48bMzvj8H7upRrKpooGWaFB/moRyV0qbqESR
         bLsREZaKxPJgaeB7ZJHlu6ZPlQruZ3a0tPwFG0ybn0rod7LFvqXhNCdQSO5/uvgeW78i
         jKGltVScyifWBmaWO/8vCSAhrnSqwt6XupU6zM6Iznx5+4661kTN2D9JZ03h5G2QJmXN
         vsH3JYhbKqgOCqInaAr//FNRb59I2PTqxNsBdydqO58U+I0V6Lbz+oS4VjkusPqUMrTb
         6uZfyZ+9j/6fD7EGPq2FPH2EL1lvUycHX6CJnPYbxsWOcNpMbhHr+vlmCA7NmS5xatwu
         Ui5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h+jKt9bsyXdUzaMhUnmlr3KTPbgwiELllBZem+05Lcg=;
        b=RUjvNIofUK54W4WbOg8DAsAJallbw8HQKKx8CxKDEAVqBz2ZoHT+yPYPy710j/YrZc
         mYYN20nDttc+yCPz9twyCtKBl8VKETOYwgf5SVHgvYgl2FuhwN8wIJoWiNhfWPAAms3j
         M3CwVGp16TQy4i1B6ncBkTvPfVhN2NqHdi9ydEH8nL7706yyBbW4P4Bd42yQ+a6GwWQg
         5SejDTQiX6nvWA0TRloNGAYZ1l5CMQATc07ufCV1dYrEep40lMPXEpMt4qiTIu9DC1Oc
         jDXCvlPlryEZn7zFYlh//dYA4KH/zUw/SAG179iuddKisAXH65DSEcwsTTaVn9mdxT72
         e17g==
X-Gm-Message-State: ANhLgQ0SyPFKuBQSmP7HJWg5x/meB412RHFM5J+UdaEIbrE501SiXDn6
        TaMHCw11u0c/hvfXuFHw1sfgWbZKt0dF7mJq1JA=
X-Google-Smtp-Source: ADFU+vvd8qcv8B2LbtS+gcC8Re1VhNmCOzEmMj2XvA/byKKBzxNd2jyvfiHcMtrxlYzuTI16fLDxcKoCeOfDQs29Ads=
X-Received: by 2002:a05:6638:c:: with SMTP id z12mr3167464jao.117.1585147245883;
 Wed, 25 Mar 2020 07:40:45 -0700 (PDT)
MIME-Version: 1.0
References: <1581618066-187262-1-git-send-email-zhe.he@windriver.com>
 <20200216222148.GA161771@krava> <8cc46abf-208d-4aa4-8d0d-4922106bee6e@windriver.com>
 <20200325133012.GC14102@kernel.org>
In-Reply-To: <20200325133012.GC14102@kernel.org>
From:   Sam Lunt <samueljlunt@gmail.com>
Date:   Wed, 25 Mar 2020 09:40:34 -0500
Message-ID: <CAGn10uVQdP32PNqyBm_dCxvRisj5tw4GU1f8j6Rq=Q6bmjmaAw@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf: Be compatible with all python versions when
 fetching ldflags
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     He Zhe <zhe.he@windriver.com>, Jiri Olsa <jolsa@redhat.com>,
        peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 25, 2020 at 8:30 AM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Em Mon, Feb 17, 2020 at 10:24:27AM +0800, He Zhe escreveu:
> >
> >
> > On 2/17/20 6:22 AM, Jiri Olsa wrote:
> > > On Fri, Feb 14, 2020 at 02:21:05AM +0800, zhe.he@windriver.com wrote:
> > >> From: He Zhe <zhe.he@windriver.com>
> > >>
> > >> Since Python v3.8.0, with the following commit
> > >> 0a8e57248b91 ("bpo-36721: Add --embed option to python-config (GH-13500)"),
> > > we got similar change recently.. might have not been picked up yet
> > >
> > >   https://lore.kernel.org/lkml/20200131181123.tmamivhq4b7uqasr@gmail.com/
> >
> > Thanks for pointing out.
>
> So, just with your patch:
>
> [acme@five perf]$ rm -rf /tmp/build/perf ; mkdir -p /tmp/build/perf
> [acme@five perf]$ make PYTHON=python3 -C tools/perf O=/tmp/build/perf install-bin |& grep python
> ...                     libpython: [ OFF ]
> Makefile.config:750: No 'Python.h' (for Python 2.x support) was found: disables Python support - please install python-devel/python-dev
>   CC       /tmp/build/perf/tests/python-use.o
> [acme@five perf]$
>
> [acme@five perf]$ rpm -q python2-devel python3-devel python-devel
> package python2-devel is not installed
> python3-devel-3.7.6-2.fc31.x86_64
> package python-devel is not installed
> [acme@five perf]$
>
> [acme@five perf]$ cat /tmp/build/perf/feature/test-libpython.make.output
> /bin/sh: --configdir: command not found
> [acme@five perf]$ cat /tmp/build/perf/feature/test-libpython
> test-libpython.make.output          test-libpython-version.make.output
> [acme@five perf]$ cat /tmp/build/perf/feature/test-libpython-version.make.output
> /bin/sh: --configdir: command not found
> [acme@five perf]$
>
>
> Without your patch:
>
> [acme@five perf]$ rm -rf /tmp/build/perf ; mkdir -p /tmp/build/perf
> [acme@five perf]$ make PYTHON=python3 -C tools/perf O=/tmp/build/perf install-bin |& grep python
> ...                     libpython: [ on  ]
>   GEN      /tmp/build/perf/python/perf.so
>   MKDIR    /tmp/build/perf/scripts/python/Perf-Trace-Util/
>   CC       /tmp/build/perf/scripts/python/Perf-Trace-Util/Context.o
>   LD       /tmp/build/perf/scripts/python/Perf-Trace-Util/perf-in.o
>   CC       /tmp/build/perf/tests/python-use.o
>   CC       /tmp/build/perf/util/scripting-engines/trace-event-python.o
>   INSTALL  python-scripts
> [acme@five perf]$
>
> [acme@five perf]$ ldd /tmp/build/perf/perf |& grep python
>         libpython3.7m.so.1.0 => /lib64/libpython3.7m.so.1.0 (0x00007f11dd1ee000)
> [acme@five perf]$ perf -vv |& grep -i python
>              libpython: [ on  ]  # HAVE_LIBPYTHON_SUPPORT
> [acme@five perf]$
>
> What am I missing?

It looks like you are using python3.7, but the change in behavior for
python-config happened in version 3.8

> [acme@five perf]$ cat /etc/redhat-release
> Fedora release 31 (Thirty One)
> [acme@five perf]$
>
> - Arnaldo
