Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF453C47254
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 22:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95B97218AC
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 22:18:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbgEHWSR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 18:18:17 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:60543 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727774AbgEHWSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 18:18:16 -0400
Received: from mail-qk1-f179.google.com ([209.85.222.179]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MbTCr-1izlNf3xZx-00bolG; Sat, 09 May 2020 00:18:15 +0200
Received: by mail-qk1-f179.google.com with SMTP id n14so3438855qke.8;
        Fri, 08 May 2020 15:18:14 -0700 (PDT)
X-Gm-Message-State: AGi0PuZXXrcnFE5WxGCjnL2UKzVhIPlSHopk1YMFK2xLFfMAHsTrwN7c
        gL06v4YjBetgZj0UhlZuyr57xtwKtwIxeZL28Y4=
X-Google-Smtp-Source: APiQypJrR0dMcIrORsz+mb0P5jMKjcH41Y5dSQnIphjwVkSDjNgvO+SuEE4oe+M/6LHNn7ZHN8PzaYAriS9TiHos0+0=
X-Received: by 2002:a37:c96:: with SMTP id 144mr3233352qkm.138.1588976293715;
 Fri, 08 May 2020 15:18:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200508100100.20740-1-grygorii.strashko@ti.com> <20200508100100.20740-3-grygorii.strashko@ti.com>
In-Reply-To: <20200508100100.20740-3-grygorii.strashko@ti.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 9 May 2020 00:17:57 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0vewSiFc4rXu43_bs_A85EYx12_YuyBaU3PYJ1HszE=w@mail.gmail.com>
Message-ID: <CAK8P3a0vewSiFc4rXu43_bs_A85EYx12_YuyBaU3PYJ1HszE=w@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] soc: ti: add k3 platforms chipid module driver
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     Santosh Shilimkar <ssantosh@kernel.org>,
        Tero Kristo <t-kristo@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        DTML <devicetree@vger.kernel.org>,
        Dave Gerlach <d-gerlach@ti.com>, Sekhar Nori <nsekhar@ti.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:wqHunh3wqcmINbNGb9nGV583lJCWKGaCaaiJyxPNcLJ0Bg5xQTd
 PgIz2Lq6iSdl0tMUEDHlQYZHIKc2kFEH+m8epA2+fzEhKx5p7oDSFnCuVYqmD69n0qjxidr
 oDtIuJU2IX8Mjh6EyQUh5/cmEdRI/VKHuQa4kc8dnWTPoTIjlNG6JRJRR8oFJQR7rG58xhA
 Mpqn37pSkw3514eJBku/A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:T8bxtkkUkuo=:gJrTbxq7w3Hmd7gn2RVXtu
 j/AswyJoEclCsiwUrYqNb9o/PKV9cO6sIOyuHFDapkcEzl5zcxDgEUMTCqXzMMMp6L4isbXYu
 +qzeqTql0MbMliL7TmOa/UDjx4hBPju31wxHJ4fUfQWcYrAZNSXB7Ww5uK8D9V4tthP5gS7Cw
 cmX1sRc0W2bMI1ljlNbEVxK/4fRcPYv0QwD0B2FcVSBHlaqSdwjTowyUXvvZHYrGwqJ1vy4eX
 awkpX9WlbMsUarBN9x6UaKHzLqXQNvMU2h1bgEFNEiH3+YlBiCILCZQ04tJetTBPrXViWZr0R
 3jcP6PWNCWt0+vrgcONsRtChSqVecW+axNjAsgTFAGSYt1kCaMY2T30Vc9T61UEs9aQWWXmJ8
 q0BLzvIWy/Q5dySxBCOmnSd3aBRv5I5YsEui9zyU603HFYDx0qg57MXKeq+7GxTuZUm6TbX2r
 fuw5zNEWULmMvafXvU9FySe9KxQ+aGUIO7mWJhKXReDiLyWG83j94VK1bQxxDMF0Bwn0s09Fh
 vpN3/kV8n2cTU0LHK2jyXIxqvHT9A7hOlMTrF4S/j+1zvANAGmNIuFZ2uwHR8CU29EYFsrfQk
 J+3CeTl6ffcXPx5YrDqAzjzRSkC7L7002lAyQQqM8IoYCAk88LwM+8gY2QK+rMgIJ6SKmlEzu
 TMhcM+/nrC21FkhGIdxodpRLM19IWuE+ji+qtjO2HawFGkJJTmuLGukXj+Iq8x7+grzDMZAsk
 7pwqEi81rqvs+HLklm96tYgmLqVltKxzbUyM/H0MvU+vs1+zLEjvhew+uybeVmomuSf4w+4lr
 K58dyHpamWjKpRxuPhUNkk2GrRGNtoHPkZgzIUn/DiwvaBJv2U=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 8, 2020 at 12:01 PM Grygorii Strashko
<grygorii.strashko@ti.com> wrote:

> +static int __init k3_chipinfo_init(void)
> +{
> +       struct soc_device_attribute *soc_dev_attr;
> +       struct soc_device *soc_dev;
> +       struct device_node *node;
> +       struct regmap *regmap;
> +       u32 partno_id;
> +       u32 variant;
> +       u32 jtag_id;
> +       u32 mfg;
> +       int ret;
> +
> +       node = of_find_compatible_node(NULL, NULL, "ti,am654-chipid");
> +       if (!node)
> +               return -ENODEV;

This will fail the initcall and print a warning when the kernel runs on any
other SoC. Would it be possible to just make this a platform_driver?

If not, I think you should silently return success when the device
node is absent.

       Arnd
