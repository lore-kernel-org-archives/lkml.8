Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DBA4C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 01:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1097B20714
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 01:07:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CozEn1aI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbgCZBHS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 21:07:18 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:35751 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727539AbgCZBHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 21:07:17 -0400
Received: by mail-qk1-f193.google.com with SMTP id k13so4871003qki.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 18:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=Z3DRv1LbJKsu5QnAvVeRAna8E9OdvLwBSsN4EhmOw9c=;
        b=CozEn1aIAvFY4NdMaDQtx0dKvQqOZMqlyEcIBkvkjGNgv8cN3N0ZNGXAr96an7nobk
         Q7Mv1rsgGEtwJ8D35fF54BbT205t2B80K9zXD3HfNgjWx+THMTCK7YIMjlUtDcRgILFZ
         0W7f7s3hRQw+Hp9N9tVe6L0LK/axle+dzmjVD0VFvHoOSEc/WsuVeBXUTUDnr1snCy54
         A1dw/JYZKzR7fagPcKl7U4mJd1lXCNPlZAeMXfyX7TCklEf6k6SwQAicYsjATWHqIYre
         MZPF57Ow5CPOb6xvmKvn0G7ELISViBzRhxfNELJz7XdZUJMTROhFMLonbdWB5/DwveXL
         BmjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=Z3DRv1LbJKsu5QnAvVeRAna8E9OdvLwBSsN4EhmOw9c=;
        b=MWTo0Zn6AcaM1B6XJcMZ8P2PSLP6ssJ6Vs0XSlSE6Dr81H952SrXntMbOyd1GwNE5c
         vUI6he1i1IdQZ95ryMzY0mCrejg438xSpJDkEyO4PNwS935hDKlowi0KLFJbzXiHz/ve
         dJ/YFGbNbd3z3mu9iV+V9qTXNp7OwwTGB7oMt7mx0opqIzpSclvZnONQ/65g0qz6BCXI
         iT8PjppZyjoeTahmc9CuTqlwCb6cPasqUZk6/G60mFy/LK31UCutTogPFgyNeHuu8btg
         VgExdTvbg6SoiE7bQgqAomSlZnKhETZ5hnzKeqOkG6YEgyO3uQtYu6Y8SXDWKUZ7Fx28
         kzzw==
X-Gm-Message-State: ANhLgQ0imZgBLKFtxXGpAJhPpVNMsFXW/V8Nkzrl6cfrU9lgME75eYIr
        DukQyTVHW155vXM8Kia+z1U=
X-Google-Smtp-Source: ADFU+vtnnpjUkyfbRLSHObeZYgjQMxqqyTlgTu8EP9dvSqFKx6khu8fUx7ig1c0rm6Mzkwwsk0Eqag==
X-Received: by 2002:a37:bd6:: with SMTP id 205mr5518136qkl.159.1585184834502;
        Wed, 25 Mar 2020 18:07:14 -0700 (PDT)
Received: from [192.168.86.185] ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id y17sm531560qth.59.2020.03.25.18.07.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Mar 2020 18:07:13 -0700 (PDT)
Date:   Wed, 25 Mar 2020 22:06:02 -0300
User-Agent: K-9 Mail for Android
In-Reply-To: <CAGn10uXpBUnSx8fsL79oMzX5bRLyhqckvxXTLg5JxDARsjFpDw@mail.gmail.com>
References: <1581618066-187262-1-git-send-email-zhe.he@windriver.com> <20200216222148.GA161771@krava> <8cc46abf-208d-4aa4-8d0d-4922106bee6e@windriver.com> <20200325133012.GC14102@kernel.org> <CAGn10uVQdP32PNqyBm_dCxvRisj5tw4GU1f8j6Rq=Q6bmjmaAw@mail.gmail.com> <20200325192640.GI14102@kernel.org> <CAGn10uXpBUnSx8fsL79oMzX5bRLyhqckvxXTLg5JxDARsjFpDw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/2] perf: Be compatible with all python versions when fetching ldflags
To:     Sam Lunt <samueljlunt@gmail.com>
CC:     He Zhe <zhe.he@windriver.com>, Jiri Olsa <jolsa@redhat.com>,
        peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org
From:   Arnaldo Melo <arnaldo.melo@gmail.com>
Message-ID: <D0DBFE8F-632A-446E-941A-980A511C26FD@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On March 25, 2020 5:31:15 PM GMT-03:00, Sam Lunt <samueljlunt@gmail=2Ecom>=
 wrote:
>On Wed, Mar 25, 2020 at 2:26 PM Arnaldo Carvalho de Melo
><arnaldo=2Emelo@gmail=2Ecom> wrote:
>>
>> Em Wed, Mar 25, 2020 at 09:40:34AM -0500, Sam Lunt escreveu:
>> > On Wed, Mar 25, 2020 at 8:30 AM Arnaldo Carvalho de Melo
>> > <arnaldo=2Emelo@gmail=2Ecom> wrote:
>> > >
>> > > Em Mon, Feb 17, 2020 at 10:24:27AM +0800, He Zhe escreveu:
>> > > >
>> > > >
>> > > > On 2/17/20 6:22 AM, Jiri Olsa wrote:
>> > > > > On Fri, Feb 14, 2020 at 02:21:05AM +0800,
>zhe=2Ehe@windriver=2Ecom wrote:
>> > > > >> From: He Zhe <zhe=2Ehe@windriver=2Ecom>
>> > > > >>
>> > > > >> Since Python v3=2E8=2E0, with the following commit
>> > > > >> 0a8e57248b91 ("bpo-36721: Add --embed option to
>python-config (GH-13500)"),
>> > > > > we got similar change recently=2E=2E might have not been picked
>up yet
>> > > > >
>> > > > > =20
>https://lore=2Ekernel=2Eorg/lkml/20200131181123=2Etmamivhq4b7uqasr@gmail=
=2Ecom/
>> > > >
>> > > > Thanks for pointing out=2E
>> > >
>> > > So, just with your patch:
>> > >
>> > > [acme@five perf]$ rm -rf /tmp/build/perf ; mkdir -p
>/tmp/build/perf
>> > > [acme@five perf]$ make PYTHON=3Dpython3 -C tools/perf
>O=3D/tmp/build/perf install-bin |& grep python
>> > > =2E=2E=2E                     libpython: [ OFF ]
>> > > Makefile=2Econfig:750: No 'Python=2Eh' (for Python 2=2Ex support) w=
as
>found: disables Python support - please install python-devel/python-dev
>> > >   CC       /tmp/build/perf/tests/python-use=2Eo
>> > > [acme@five perf]$
>> > >
>> > > [acme@five perf]$ rpm -q python2-devel python3-devel python-devel
>> > > package python2-devel is not installed
>> > > python3-devel-3=2E7=2E6-2=2Efc31=2Ex86_64
>> > > package python-devel is not installed
>> > > [acme@five perf]$
>> > >
>> > > [acme@five perf]$ cat
>/tmp/build/perf/feature/test-libpython=2Emake=2Eoutput
>> > > /bin/sh: --configdir: command not found
>> > > [acme@five perf]$ cat /tmp/build/perf/feature/test-libpython
>> > > test-libpython=2Emake=2Eoutput        =20
>test-libpython-version=2Emake=2Eoutput
>> > > [acme@five perf]$ cat
>/tmp/build/perf/feature/test-libpython-version=2Emake=2Eoutput
>> > > /bin/sh: --configdir: command not found
>> > > [acme@five perf]$
>> > >
>> > >
>> > > Without your patch:
>> > >
>> > > [acme@five perf]$ rm -rf /tmp/build/perf ; mkdir -p
>/tmp/build/perf
>> > > [acme@five perf]$ make PYTHON=3Dpython3 -C tools/perf
>O=3D/tmp/build/perf install-bin |& grep python
>> > > =2E=2E=2E                     libpython: [ on  ]
>> > >   GEN      /tmp/build/perf/python/perf=2Eso
>> > >   MKDIR    /tmp/build/perf/scripts/python/Perf-Trace-Util/
>> > >   CC     =20
>/tmp/build/perf/scripts/python/Perf-Trace-Util/Context=2Eo
>> > >   LD     =20
>/tmp/build/perf/scripts/python/Perf-Trace-Util/perf-in=2Eo
>> > >   CC       /tmp/build/perf/tests/python-use=2Eo
>> > >   CC     =20
>/tmp/build/perf/util/scripting-engines/trace-event-python=2Eo
>> > >   INSTALL  python-scripts
>> > > [acme@five perf]$
>> > >
>> > > [acme@five perf]$ ldd /tmp/build/perf/perf |& grep python
>> > >         libpython3=2E7m=2Eso=2E1=2E0 =3D> /lib64/libpython3=2E7m=2E=
so=2E1=2E0
>(0x00007f11dd1ee000)
>> > > [acme@five perf]$ perf -vv |& grep -i python
>> > >              libpython: [ on  ]  # HAVE_LIBPYTHON_SUPPORT
>> > > [acme@five perf]$
>> > >
>> > > What am I missing?
>> >
>> > It looks like you are using python3=2E7, but the change in behavior
>for
>> > python-config happened in version 3=2E8
>>
>> Humm, but shouldn't this continue to work with python3=2E7?
>
>Oh, my mistake, I didn't read the output carefully=2E It should
>obviously still work with old versions, yes=2E I actually submitted a
>similar patch, and it seemed to work when I used python 3=2E7=2E I wonder
>if the issue is the "||" operator in the subshell=2E
>
>https://lore=2Ekernel=2Eorg/lkml/20200131181123=2Etmamivhq4b7uqasr@gmail=
=2Ecom/


I'm aware of your path, even for confused by your comment here, will it tr=
y it tomorrow

>
>
>> - Arnaldo
>>
>> > > [acme@five perf]$ cat /etc/redhat-release
>> > > Fedora release 31 (Thirty One)
>> > > [acme@five perf]$
>> > >
>> > > - Arnaldo
>>
>> --
>>
>> - Arnaldo

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
