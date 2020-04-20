Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE23C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 15:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37A692082E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 15:36:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbgDTPgI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 11:36:08 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:50087 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbgDTPgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 11:36:07 -0400
Received: from mail-lj1-f170.google.com ([209.85.208.170]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MPoPd-1jdyic3HwR-00MxKe for <linux-kernel@vger.kernel.org>; Mon, 20 Apr
 2020 17:36:05 +0200
Received: by mail-lj1-f170.google.com with SMTP id m8so10486563lji.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 08:36:05 -0700 (PDT)
X-Gm-Message-State: AGi0PubEBGpWrewN010Om9AjfxL/pIeiMiGW7oBQer8JKqWLudVIlZik
        ueFYew1305ZcL1WHaZPDVhTP6cv7yWg8nFbecbM=
X-Google-Smtp-Source: APiQypKHtqOOvjsZa8biIU2eZzzlTbGupmSKlmIDGVOzZJB48xQdS/SqpDK9pJJySIskbTfb/xnWOaBlZxC2oY7Y12w=
X-Received: by 2002:a05:651c:107a:: with SMTP id y26mr5000070ljm.80.1587396965221;
 Mon, 20 Apr 2020 08:36:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200419171157.672999-1-lkundrak@v3.sk>
In-Reply-To: <20200419171157.672999-1-lkundrak@v3.sk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 20 Apr 2020 17:35:48 +0200
X-Gmail-Original-Message-ID: <CAK8P3a17JFOD_SqF+ub+VEM_ABLzLYWFE6zj0eBXVjP3nn0g2Q@mail.gmail.com>
Message-ID: <CAK8P3a17JFOD_SqF+ub+VEM_ABLzLYWFE6zj0eBXVjP3nn0g2Q@mail.gmail.com>
Subject: Re: [PATCH 00/15] ARM: dts: Marvell SoC Device Tree updates (for 5.8)
To:     Lubomir Rintel <lkundrak@v3.sk>
List-Id: <soc.lore.kernel.org>
Cc:     SoC Team <soc@kernel.org>, Olof Johansson <olof@lixom.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:zcMXKCe+bjRcKlstEchcHYfjqzNT2Vf9aeoor/+CCTENfxQW+Lg
 a10SmO5/1EbEuMs8CJEKyBeEzb2Rc8B1h317ziBBV8x2ZSjBnrJBYeCR3Xygk/tXtmfC1uC
 e8eocWAbLlfVfb9aSc8tKnjSqSlUZpV6ZfufdanCsXhpr47LMY0Xl5r95RJENHpTE9jSS3a
 iPerg96WBXoFBmNXLjLFQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9ynneOdz8Rg=:1wNaooW1A4J1vZTHjUhijg
 mYnMfIoud1JEYCIi9oQx7uSJL/nYQ3L/vvz2kkGHGNk6BCfEQOaFeFLzsMZgodDlGiINlHLam
 gkZFbzsOgKWA6OfxvV5WzA2TWdsaOfKRh9NzYrWJiUlEqWpcm1XfvJHCY7YSoYTwzUA9cen8m
 2M3vln/AKt0GuISfCTpwn644LStuR3XU/ipWN8FEIzCXH+TGYrZDtCjC9DwkQPrQBCCQ5CaLJ
 jOUAVjrSv2YMVz+Nhi+ctzYdpr3tW6EqwlvsdmF9ybWdsjbJi10tZpLDtLCt+DrCztI3FfDRL
 BSPTYpv9WH7NGB27aOrjWdda+LhEv2m9no72vFj7SR7bDPyi6xMaHxeWc/GnIKs1KePnq1jIh
 3ZRDyvUbm0hUPhFHM06j3S1SY5rBdrZBPz/8QZTZKAqPMA5vSDCq7GFNrH/26EZNWb+eacTUL
 Tj3vCSiwGcjUFthItXuvHRB/xdqNB8aUDU2DWCM77NziirnNvGcbSDczzJpis5VkbwiiPGojM
 rAhQJnMkQBK33oOPGLlbbm7NRxhDSK+lszJCsNV0qfT96BfBpCfKP5bqhNOestgG2+2BIzpNm
 rK87ycAO/hp0zFhJxjuAk/mPKzukdSzelWvJ6ZdRLXvKmUROaj5tYXVa8VIZ3XkSVHBCe0Eg9
 JYY+Kb7mKPo5yJNjXNfv/0eiiseOHiUxNMFCz4kfvfRqPYdO1f74e6IFaWmgqTa2+v4wQ9cjZ
 xDiV9lvJGogKeezSDG13J5IVa+ceKp9VB7u+Is58O0Kf7UVspBA/EsWrPgFNyHMayirasFLR5
 98SPugg7ZAuWOzuY6btuaul6+lLl3rnWDSn4lZviHLzfF0gLLA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 19, 2020 at 7:12 PM Lubomir Rintel <lkundrak@v3.sk> wrote:
>
> Hi,
>
> please consider applying the patches chained to this message to arm/dt.
>
> I've sent about the same patch set before, but there were some issues
> and it was way too close to 5.7-rc1. Sorry for that. I decided not to
> hurry it, because none of the fixes is really all that important.
>
> Majority of the patches just deal with reducing DT validation noise once
> more schemas are converted to JSON-schema. Those that actually fix
> things relevant to older released kernels have been Cc'd to stable@.

Can you check again which ones should perhaps be part of v5.7?
I assume that at least anything that has a stable tag should also be
included in the release, but I'd prefer to have you confirm that.

     Arnd
