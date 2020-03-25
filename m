Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7838DC2D0E5
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 19:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E9F020719
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 19:26:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FN0H2enO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbgCYT0p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 15:26:45 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:35473 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727174AbgCYT0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 15:26:44 -0400
Received: by mail-qk1-f196.google.com with SMTP id k13so3909092qki.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 12:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vsO2FYfYVi+PH9UeJM3VQ8uylR9mfG2fsjehGqz9OJQ=;
        b=FN0H2enO8L7bLyWKTjAhlsawoiZNUC299o3u/dt0jE6VJ+iZ7Dn4cEqcpotjYHx0A7
         aj4o1W/Hrr2AWFvxx+STQSZhashXMcjH+joq/JYGqM+FHOqAHsPDn9v1FX4qLshP9RC+
         wRgWhWhG7aDXm2pSgtwCvjyBNBLM3EVIwLVBarJIx3bC4AaT9HoPnbS/RTNtVJSdIi65
         tGP16J8PV2YMzVaeN0emaY7OQLJyEMqX11D+YUplUMgRoUnEgMjSaomFoL9tKvAILQ2Z
         GOnBNCAbrmtbsmequmWJFIZkKgjM11HZYu8FmK9Cw4QW38StGVqgGfnsyCCy1tOnvCdd
         4EZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vsO2FYfYVi+PH9UeJM3VQ8uylR9mfG2fsjehGqz9OJQ=;
        b=hXu3UwA+E66qrWIYFUodm+dTaudMK2w0syjXcUXwCJYYz1Dm8OTwiBLtPidD4BFKyI
         3vwqzl5Lo4HqqCLUFmdsBu9z9ZfuyE8CgtDlSDpy+FKbqTWiibBQIQ/xC8veZasaSVNT
         W0tMOIG3ZJR8Ya1uVDnKqTnML4M1ge92b8MRbfjMZlM1QXtG9D84zaHmId0ZM7GFBoky
         rjUv3lrFaJJa/2TWLLbKtb1WsboqWScZ969JYb1ukM7QEB21SQkHRq0ihme1KsUAf/Td
         UtR0kf5bxRztw/5nRkHnX6ZKWEJMp2AsGYTz0WGfbwT/a5AUmL2ICx9jVEGhHyMOUaGM
         xSkA==
X-Gm-Message-State: ANhLgQ3zhMp1GEjXogRFAABwmBwxnZIvdtA/qiBqjSAWVJ6t+KugwHWT
        6Owocjjj2f1co4pOEcYUTBM=
X-Google-Smtp-Source: ADFU+vuu+NzzmCcbJuPKC8in3CDjCDJRHx/brd9imacULSbBjUT2P9h2Y/AouoHbg6q+CLNQD53aFQ==
X-Received: by 2002:a37:a213:: with SMTP id l19mr4341375qke.377.1585164403176;
        Wed, 25 Mar 2020 12:26:43 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id u123sm15975906qkf.77.2020.03.25.12.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 12:26:42 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 63A3440F77; Wed, 25 Mar 2020 16:26:40 -0300 (-03)
Date:   Wed, 25 Mar 2020 16:26:40 -0300
To:     Sam Lunt <samueljlunt@gmail.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        He Zhe <zhe.he@windriver.com>, Jiri Olsa <jolsa@redhat.com>,
        peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] perf: Be compatible with all python versions when
 fetching ldflags
Message-ID: <20200325192640.GI14102@kernel.org>
References: <1581618066-187262-1-git-send-email-zhe.he@windriver.com>
 <20200216222148.GA161771@krava>
 <8cc46abf-208d-4aa4-8d0d-4922106bee6e@windriver.com>
 <20200325133012.GC14102@kernel.org>
 <CAGn10uVQdP32PNqyBm_dCxvRisj5tw4GU1f8j6Rq=Q6bmjmaAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGn10uVQdP32PNqyBm_dCxvRisj5tw4GU1f8j6Rq=Q6bmjmaAw@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Mar 25, 2020 at 09:40:34AM -0500, Sam Lunt escreveu:
> On Wed, Mar 25, 2020 at 8:30 AM Arnaldo Carvalho de Melo
> <arnaldo.melo@gmail.com> wrote:
> >
> > Em Mon, Feb 17, 2020 at 10:24:27AM +0800, He Zhe escreveu:
> > >
> > >
> > > On 2/17/20 6:22 AM, Jiri Olsa wrote:
> > > > On Fri, Feb 14, 2020 at 02:21:05AM +0800, zhe.he@windriver.com wrote:
> > > >> From: He Zhe <zhe.he@windriver.com>
> > > >>
> > > >> Since Python v3.8.0, with the following commit
> > > >> 0a8e57248b91 ("bpo-36721: Add --embed option to python-config (GH-13500)"),
> > > > we got similar change recently.. might have not been picked up yet
> > > >
> > > >   https://lore.kernel.org/lkml/20200131181123.tmamivhq4b7uqasr@gmail.com/
> > >
> > > Thanks for pointing out.
> >
> > So, just with your patch:
> >
> > [acme@five perf]$ rm -rf /tmp/build/perf ; mkdir -p /tmp/build/perf
> > [acme@five perf]$ make PYTHON=python3 -C tools/perf O=/tmp/build/perf install-bin |& grep python
> > ...                     libpython: [ OFF ]
> > Makefile.config:750: No 'Python.h' (for Python 2.x support) was found: disables Python support - please install python-devel/python-dev
> >   CC       /tmp/build/perf/tests/python-use.o
> > [acme@five perf]$
> >
> > [acme@five perf]$ rpm -q python2-devel python3-devel python-devel
> > package python2-devel is not installed
> > python3-devel-3.7.6-2.fc31.x86_64
> > package python-devel is not installed
> > [acme@five perf]$
> >
> > [acme@five perf]$ cat /tmp/build/perf/feature/test-libpython.make.output
> > /bin/sh: --configdir: command not found
> > [acme@five perf]$ cat /tmp/build/perf/feature/test-libpython
> > test-libpython.make.output          test-libpython-version.make.output
> > [acme@five perf]$ cat /tmp/build/perf/feature/test-libpython-version.make.output
> > /bin/sh: --configdir: command not found
> > [acme@five perf]$
> >
> >
> > Without your patch:
> >
> > [acme@five perf]$ rm -rf /tmp/build/perf ; mkdir -p /tmp/build/perf
> > [acme@five perf]$ make PYTHON=python3 -C tools/perf O=/tmp/build/perf install-bin |& grep python
> > ...                     libpython: [ on  ]
> >   GEN      /tmp/build/perf/python/perf.so
> >   MKDIR    /tmp/build/perf/scripts/python/Perf-Trace-Util/
> >   CC       /tmp/build/perf/scripts/python/Perf-Trace-Util/Context.o
> >   LD       /tmp/build/perf/scripts/python/Perf-Trace-Util/perf-in.o
> >   CC       /tmp/build/perf/tests/python-use.o
> >   CC       /tmp/build/perf/util/scripting-engines/trace-event-python.o
> >   INSTALL  python-scripts
> > [acme@five perf]$
> >
> > [acme@five perf]$ ldd /tmp/build/perf/perf |& grep python
> >         libpython3.7m.so.1.0 => /lib64/libpython3.7m.so.1.0 (0x00007f11dd1ee000)
> > [acme@five perf]$ perf -vv |& grep -i python
> >              libpython: [ on  ]  # HAVE_LIBPYTHON_SUPPORT
> > [acme@five perf]$
> >
> > What am I missing?
> 
> It looks like you are using python3.7, but the change in behavior for
> python-config happened in version 3.8

Humm, but shouldn't this continue to work with python3.7?

- Arnaldo
 
> > [acme@five perf]$ cat /etc/redhat-release
> > Fedora release 31 (Thirty One)
> > [acme@five perf]$
> >
> > - Arnaldo

-- 

- Arnaldo
