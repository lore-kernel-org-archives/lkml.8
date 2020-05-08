Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F41E2C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 15:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C189C2173E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 15:05:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbgEHPFX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 11:05:23 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:49983 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbgEHPFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 11:05:22 -0400
Received: from mail-lf1-f43.google.com ([209.85.167.43]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1N3KkM-1j7GGw2wni-010Pd1 for <linux-kernel@vger.kernel.org>; Fri, 08 May
 2020 17:05:20 +0200
Received: by mail-lf1-f43.google.com with SMTP id j14so1672456lfg.9
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 08:05:20 -0700 (PDT)
X-Gm-Message-State: AOAM530sEhG2LhQKs8fqpX1K2ATP784L5UcjJOYW2aFiehG6Ev7OHENH
        fqGyJyr7VOA5gHVbGUTWpDKZI/nC9egQQ2vpyxo=
X-Google-Smtp-Source: ABdhPJyBltViryv41vDy3Je/p+d9AY37nsBBCYK0KZkRu7fGETBmMjCRR1El62fP+c+cIE40ko0QZEWIDYVXanRJ3Wk=
X-Received: by 2002:ac2:5df9:: with SMTP id z25mr2260623lfq.125.1588950320229;
 Fri, 08 May 2020 08:05:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200508144017.3501418-1-arnd@arndb.de> <20200508144017.3501418-2-arnd@arndb.de>
 <20200508150041.GI19158@mellanox.com>
In-Reply-To: <20200508150041.GI19158@mellanox.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 8 May 2020 17:05:03 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1vCx=XibDdoDqG9obpCFx0JCibAvcKFh6E7_NR_hJ03A@mail.gmail.com>
Message-ID: <CAK8P3a1vCx=XibDdoDqG9obpCFx0JCibAvcKFh6E7_NR_hJ03A@mail.gmail.com>
Subject: Re: [PATCH 2/2] nouveau: fix dependencies for DEVICE_PRIVATE
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Ben Skeggs <bskeggs@redhat.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        ML nouveau <nouveau@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:Ss6tzcoeShesaaSVWhQ0NQZpwEzMrufJtto17TdKkCDBo+bRHBj
 2Q91UaWpd7UdI4GMI9V994WXHziGoixY0EOUN9mbDt4uuC24jg9KDVv31r+y27v2A8eWu8l
 xnbWpbEONoM70SY4N0S+ccGYR+yXEp/sLFlL7zJ40leWfY/MY0hpZc/rB8EUBKKCy7ewTHq
 svH2EccWhMEXNGnwkKlSw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hDXebroNOXk=:UDhJfvKSYsY7yNhTnBzQj3
 VwiqA2qIi5c2OCakxnDZkPM3JyCbErdDiQz7aoLWyRt1E+j/FqIXPwl96hU3aT5EQS7Rme7P2
 N4YYGyYH2sZ233e1Wfn7p5VokwfnXs3E5qO/Gav0tlV3pK2w7zKCPrzweIzM6WefwQ8P/64ub
 z417nUrs5wfIdrpXzDIBoVHhQjLhfOr/Ju/xS5IBsYu3bO+tWQEkrE6CPC2HxAsySB7zL9xjy
 AZtek4MFHt9InMjgKyNZCN+H+9eZW3d71HkAq6sESh7XZCvT5JemUTakpCoxkHrirduoN9QZp
 Vt+u1icb87QA+tasGbSXmPtg4ZnOnQJhnsGMObzKxBbPQM2ooJRyjvtpovLTdE6NUOB81FjPH
 llk8O/FCUYkASMhFAtDbMT5VLKz2nHrdTIDaPZtYz+t5tey+ppoTXjvH7+nUwbtupao3XzcCd
 dw6C7iI9qGU0DbFkV9JB77FvY0cUtBOcS1yuAoWl4ANLwPdL1a10r5NyEd9Mi5LnhS4qcXCuC
 5hLsfIAleCw/7mBQ1TpGtuZ31FCHunnsEQcMWwFFn2B+WY3U1KpqdfBSXeZlYrAJUDe4q1Yr8
 wg3FdBuioxkV/vDza67AK13fUiu171fWodmzMDgtEXw/uRlSw+SUEN07cHaOEuxunCV2cdHKj
 6HnBOTESgNOgytKs7TJ01rV7Rn2FA8jXV+Mzz44RaJdErH6qpPXlIxJ/cJ5rDiKsbsMaI/FF3
 djkhYEYkRguWZ5Czg2ME/yX6OOp9KEYb6Hek4JiLgqwQLX82Tb/vVf/wHYwr4rFhNMCb0ZLaT
 sIDfGQPYLvsXqlLMZXAjmRQrhXvoxbPsToj39DFilhtlgwTjCE=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 8, 2020 at 5:00 PM Jason Gunthorpe <jgg@mellanox.com> wrote:
>
> On Fri, May 08, 2020 at 04:40:09PM +0200, Arnd Bergmann wrote:
> > CONFIG_DEVICE_PRIVATE cannot be selected in configurations
> > without ZONE_DEVICE:
>
> It is kind of unfortunate to lift dependencies from DEVICE_PRIVATE
> into the users, is this really how kconfig is supposed to work or is
> something else wrong here?

Usually the problem is trying to use 'select' for something that can
be done with 'depends on'. I have actually no idea what
CONFIG_DEVICE_PRIVATE does, as it lacks a help text
and is a rather generic term.

Would it be possible to decouple DEVICE_PRIVATE from ZONE_DEVICE?
It sounds like the first is related to the device model, while
the second is for memory management, so maybe the dependency
is not necessary.

       Arnd
