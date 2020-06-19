Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50639C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 12:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C96E21532
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 12:16:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="Yecaf6gj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732879AbgFSMP7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 08:15:59 -0400
Received: from mout.web.de ([212.227.15.4]:37479 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731561AbgFSMPv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 08:15:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1592568935;
        bh=45UgeJv4t65eu4zPCmJvNpVnUo7ZfpKmm0k9LndJsks=;
        h=X-UI-Sender-Class:Cc:Subject:From:To:Date;
        b=Yecaf6gj4cR2Pksp9Js8UeVO+MNjZbWGmDnsnuhS3sHsSWrInRQI3/qsmEJ18sBHj
         rhpx+N4EJ8qCvTB9d/JIl7U1uFetrGORYRz1R+hvcNFP5qF9vpgTlKP+5Zzc6mrEl9
         T3U/K54jm3PqYM0gZ5Ya6X0wZrgDKFmw4K+IIes4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.139.231]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LecN4-1j5kAj0xig-00qRCG; Fri, 19
 Jun 2020 14:15:35 +0200
Cc:     opensource.kernel@vivo.com, Aditya Pakki <pakki001@umn.edu>,
        Kangjie Lu <kjlu@umn.edu>, Navid Emamdoost <emamd001@umn.edu>,
        Qiushi Wu <wu000273@umn.edu>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        =?UTF-8?Q?Felix_K=c3=bchling?= <Felix.Kuehling@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>
Subject: Re: [PATCH] drm/amdkfd: Fix memory leaks according to error branches
From:   Markus Elfring <Markus.Elfring@web.de>
To:     Bernard Zhao <bernard@vivo.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <c966b91e-765f-c36c-2563-4e348fd1daf6@web.de>
Date:   Fri, 19 Jun 2020 14:15:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bW/jlvnVLAJqZr8DAAisjb74aEUzKSMI3tkulAuAkBcRr7D/Ac8
 Js053pNH47f7md+XQThFTIy3GMK4avN5YSs0NxDfhGprk5wAJ2isK/4Aar5h1wCJ3wv5e5D
 9Kz1RLx7jf8jLjWWtD3SdqykCQfwkJjPd1yrbVdbQJ/PcrVGh6cTWGQzBRWaRI4UMHx9TzY
 Vq8D3r3AEo4v+R0v3GJsw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NNc4CFBbVQw=:aBMbY0JcBtV/ZHsxAV/gBT
 8lGmEqt61nXy2U2c/Kk3x37uN/RhQHlIskwB1kwAsjKipFcTTv1uUOc4QoquWWKcn3SeH5/Zn
 JOSX4uoZKjhp0b52BmlLC6k9iXMzof65X7S1hmtBKLsHiuL7tghnbNxqBT5erMGjBwZ4mDG8d
 Jwd1vRfrbvPo3IFFeYhxgtOY1JJldNCgiz0RG5QVKNW/UzYzi4wsmTZVW06fHLHBz7Ib5j4di
 de4jCwh0qBPSpaAyUPop7ujZ+spuiFKgElUeo98PCY5ys6fA6WghMot0hePPb2EjpVo+ZCjgH
 AilZInQO7QtQo7AxZbYLVICdzehvI6j0FKQrLVveFSonIGpn/Z4vz1AuaazrW9dzLkjk7Y24k
 KrHscqcR7iS2wtpLRgUKg5zRyM7AQFiijR8Y8KCuUHWoUKn+YvbDmefZ/5EEj9+wyVbDByorg
 6tC5sXC3EhKpKhgy/dIVE5ouoK4hWVXddtU51B6+Q2elxXIILJMrWxWcyZWZOSSDD69UZmwfv
 Jvr+sayG7hhYuL7pTEwmMs6IWOI3Wo4mJvLxffVp52UXVl2BSzGQIDaP30Qq0NMOORSOZNxGT
 lCObH0pH6iv5dzDZHh9F7cZclfJ4SQ8rdPSCm0pyBVzogCCuHCsTuGQXZaUlSKSFE8j8Jai0J
 3/qTPwMQ+zxfoW5LC1uWDpg4K1+gSEa3eyFF7Oj5wd5ArIOg6zwu/TvhISlxhWi7BWFN02uZk
 5Jqm8JYu4jbVwHrI8xn2X4OimKf2mI4wt3H8S+C/Xn75rLncuBplavNHGnHilvIKFOEBeFBTZ
 ubLA+KatpfW3qjmstpvp1yIqHAuRcrDOFUMB9U+r9XRdg0zjmfbGzcfizberKPZQlKgv4YjP5
 gVMaKk2Yb2x6FmnLbr0A8bhlcDWuS5SRhpMiWS0Tc0JeAt+C815s3Zxp1/zXnkTtq0NR90RKw
 rBsQ1gYI95VhsU6vur8XdP9+yV+cuR2pLZaJSZ5f5uy1aTDFbx+5WibMpPY2gFNj6iAAI6Gdg
 TZrTfoSD90/bDxcip5aOBYJuAdn21gu4WffcT7ZuqKMZxjdzsm3KfM5rrVG+jSoyAC1iC21Y0
 UKoWc1ZCcRrYElPYt6yQ47BX2J4Vd+hHkeZJOAAKnQcdnYWnvOaKLJLB+fGdtMiz5wft9cKmE
 hzOSV6GCh29oQr0g8xgyfs2K1H9GPCFD1BcenayOKAyndHsjcOwdnxIOziUe3lDaQhWsNioDJ
 Mp5EPu0irg/USbzU2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The function kobject_init_and_add alloc memory like:
> kobject_init_and_add->kobject_add_varg->kobject_set_name_vargs
> ->kvasprintf_const->kstrdup_const->kstrdup->kmalloc_track_caller
> ->kmalloc_slab, in err branch this memory not free. If use
> kmemleak, this path maybe catched.
> These changes are to add kobject_put in kobject_init_and_add
> failed branch, fix potential memleak.

I suggest to improve this change description.

* Can an other wording variant be nicer?

* Will the tag =E2=80=9CFixes=E2=80=9D become helpful?

Regards,
Markus
