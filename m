Return-Path: <SRS0=ne2O=7T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF25C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 07:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C27B207DF
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 07:30:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="RGZAKkqO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728620AbgFFHau (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jun 2020 03:30:50 -0400
Received: from mout.web.de ([212.227.15.3]:50991 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728135AbgFFHat (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jun 2020 03:30:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1591428639;
        bh=l8w3MJRuKfT5a3/310Ltd3vufAdJhbojIeIwIevJwZI=;
        h=X-UI-Sender-Class:Cc:Subject:To:From:Date;
        b=RGZAKkqOGNeozTQh2gTA30oQjnqCIM7nJAoJLnz8dC3doHQHjV7snL59Tn4C0JXeZ
         tORHJjFUFs9UUKl8mCx8JTSdr7h9GA9wghTCf4TTtT9e/7jidxp3eHvsgTR1+VqY7W
         ZaAg6AMZZ5D/zimw+p5HJ0Hvx9oaC0QTkPVfwLLg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.40.239]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LvB2o-1iz1gK44Sg-010OPA; Sat, 06
 Jun 2020 09:30:39 +0200
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] coccinelle: api: add kvfree script
To:     Denis Efremov <efremov@linux.com>,
        Coccinelle <cocci@systeme.lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 mQINBFg2+xABEADBJW2hoUoFXVFWTeKbqqif8VjszdMkriilx90WB5c0ddWQX14h6w5bT/A8
 +v43YoGpDNyhgA0w9CEhuwfZrE91GocMtjLO67TAc2i2nxMc/FJRDI0OemO4VJ9RwID6ltwt
 mpVJgXGKkNJ1ey+QOXouzlErVvE2fRh+KXXN1Q7fSmTJlAW9XJYHS3BDHb0uRpymRSX3O+E2
 lA87C7R8qAigPDZi6Z7UmwIA83ZMKXQ5stA0lhPyYgQcM7fh7V4ZYhnR0I5/qkUoxKpqaYLp
 YHBczVP+Zx/zHOM0KQphOMbU7X3c1pmMruoe6ti9uZzqZSLsF+NKXFEPBS665tQr66HJvZvY
 GMDlntZFAZ6xQvCC1r3MGoxEC1tuEa24vPCC9RZ9wk2sY5Csbva0WwYv3WKRZZBv8eIhGMxs
 rcpeGShRFyZ/0BYO53wZAPV1pEhGLLxd8eLN/nEWjJE0ejakPC1H/mt5F+yQBJAzz9JzbToU
 5jKLu0SugNI18MspJut8AiA1M44CIWrNHXvWsQ+nnBKHDHHYZu7MoXlOmB32ndsfPthR3GSv
 jN7YD4Ad724H8fhRijmC1+RpuSce7w2JLj5cYj4MlccmNb8YUxsE8brY2WkXQYS8Ivse39MX
 BE66MQN0r5DQ6oqgoJ4gHIVBUv/ZwgcmUNS5gQkNCFA0dWXznQARAQABtCZNYXJrdXMgRWxm
 cmluZyA8TWFya3VzLkVsZnJpbmdAd2ViLmRlPokCVAQTAQgAPhYhBHDP0hzibeXjwQ/ITuU9
 Figxg9azBQJYNvsQAhsjBQkJZgGABQsJCAcCBhUICQoLAgQWAgMBAh4BAheAAAoJEOU9Figx
 g9azcyMP/iVihZkZ4VyH3/wlV3nRiXvSreqg+pGPI3c8J6DjP9zvz7QHN35zWM++1yNek7Ar
 OVXwuKBo18ASlYzZPTFJZwQQdkZSV+atwIzG3US50ZZ4p7VyUuDuQQVVqFlaf6qZOkwHSnk+
 CeGxlDz1POSHY17VbJG2CzPuqMfgBtqIU1dODFLpFq4oIAwEOG6fxRa59qbsTLXxyw+PzRaR
 LIjVOit28raM83Efk07JKow8URb4u1n7k9RGAcnsM5/WMLRbDYjWTx0lJ2WO9zYwPgRykhn2
 sOyJVXk9xVESGTwEPbTtfHM+4x0n0gC6GzfTMvwvZ9G6xoM0S4/+lgbaaa9t5tT/PrsvJiob
 kfqDrPbmSwr2G5mHnSM9M7B+w8odjmQFOwAjfcxoVIHxC4Cl/GAAKsX3KNKTspCHR0Yag78w
 i8duH/eEd4tB8twcqCi3aCgWoIrhjNS0myusmuA89kAWFFW5z26qNCOefovCx8drdMXQfMYv
 g5lRk821ZCNBosfRUvcMXoY6lTwHLIDrEfkJQtjxfdTlWQdwr0mM5ye7vd83AManSQwutgpI
 q+wE8CNY2VN9xAlE7OhcmWXlnAw3MJLW863SXdGlnkA3N+U4BoKQSIToGuXARQ14IMNvfeKX
 NphLPpUUnUNdfxAHu/S3tPTc/E/oePbHo794dnEm57LuuQINBFg2+xABEADZg/T+4o5qj4cw
 nd0G5pFy7ACxk28mSrLuva9tyzqPgRZ2bdPiwNXJUvBg1es2u81urekeUvGvnERB/TKekp25
 4wU3I2lEhIXj5NVdLc6eU5czZQs4YEZbu1U5iqhhZmKhlLrhLlZv2whLOXRlLwi4jAzXIZAu
 76mT813jbczl2dwxFxcT8XRzk9+dwzNTdOg75683uinMgskiiul+dzd6sumdOhRZR7YBT+xC
 wzfykOgBKnzfFscMwKR0iuHNB+VdEnZw80XGZi4N1ku81DHxmo2HG3icg7CwO1ih2jx8ik0r
 riIyMhJrTXgR1hF6kQnX7p2mXe6K0s8tQFK0ZZmYpZuGYYsV05OvU8yqrRVL/GYvy4Xgplm3
 DuMuC7/A9/BfmxZVEPAS1gW6QQ8vSO4zf60zREKoSNYeiv+tURM2KOEj8tCMZN3k3sNASfoG
 fMvTvOjT0yzMbJsI1jwLwy5uA2JVdSLoWzBD8awZ2X/eCU9YDZeGuWmxzIHvkuMj8FfX8cK/
 2m437UA877eqmcgiEy/3B7XeHUipOL83gjfq4ETzVmxVswkVvZvR6j2blQVr+MhCZPq83Ota
 xNB7QptPxJuNRZ49gtT6uQkyGI+2daXqkj/Mot5tKxNKtM1Vbr/3b+AEMA7qLz7QjhgGJcie
 qp4b0gELjY1Oe9dBAXMiDwARAQABiQI8BBgBCAAmFiEEcM/SHOJt5ePBD8hO5T0WKDGD1rMF
 Alg2+xACGwwFCQlmAYAACgkQ5T0WKDGD1rOYSw/+P6fYSZjTJDAl9XNfXRjRRyJSfaw6N1pA
 Ahuu0MIa3djFRuFCrAHUaaFZf5V2iW5xhGnrhDwE1Ksf7tlstSne/G0a+Ef7vhUyeTn6U/0m
 +/BrsCsBUXhqeNuraGUtaleatQijXfuemUwgB+mE3B0SobE601XLo6MYIhPh8MG32MKO5kOY
 hB5jzyor7WoN3ETVNQoGgMzPVWIRElwpcXr+yGoTLAOpG7nkAUBBj9n9TPpSdt/npfok9ZfL
 /Q+ranrxb2Cy4tvOPxeVfR58XveX85ICrW9VHPVq9sJf/a24bMm6+qEg1V/G7u/AM3fM8U2m
 tdrTqOrfxklZ7beppGKzC1/WLrcr072vrdiN0icyOHQlfWmaPv0pUnW3AwtiMYngT96BevfA
 qlwaymjPTvH+cTXScnbydfOQW8220JQwykUe+sHRZfAF5TS2YCkQvsyf7vIpSqo/ttDk4+xc
 Z/wsLiWTgKlih2QYULvW61XU+mWsK8+ZlYUrRMpkauN4CJ5yTpvp+Orcz5KixHQmc5tbkLWf
 x0n1QFc1xxJhbzN+r9djSGGN/5IBDfUqSANC8cWzHpWaHmSuU3JSAMB/N+yQjIad2ztTckZY
 pwT6oxng29LzZspTYUEzMz3wK2jQHw+U66qBFk8whA7B2uAU1QdGyPgahLYSOa4XAEGb6wbI FEE=
Message-ID: <99ed463c-b7ba-0400-7cf7-5bcc1992baef@web.de>
Date:   Sat, 6 Jun 2020 09:30:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:X/kkZ06rZlFudE0r7jf+z2dqyNagehQu4UReRu9kWQ93tX5M4/9
 4u6rRbi5VKMBa1w+pv3VJg0uk2VDfj4Tqpgt5ljTeKmqcwZOUp+oORk9Zb6zdkehxSq0TyN
 Q0vJIAc7CJEw6/bQRnOMP+YVLk26i9gTA0JHDy15gEWiw0CU+EkquC625Tt0k/NDsLZrhQv
 iqYKaTL93bHhweaTAbHWg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8DXUGpkGegA=:rCnfwWiWh5Vd72NjfdR7m9
 R8wxZ1DAtuMVAhbYXMtXEJrsUZlAdnQUoFdnDgxFASl3Lub+FsmJsFMKqGUVvWcpjL06XaXKn
 +pbx65owYcCgGLWr5rJzuKpKcJ7rUs77FlRariSy+OYR01Uo+6Bt6ikDN+2YLL11MzQBGkCos
 q/33J1vnBs1GamfVESckUM3fSftKh8byPTJMiTAtlHHz1jUffNdRKbD8eowff8qSO7EVf27ll
 KhZBxMCMuCkZdRb7znJnEnoRhVN3QFY0Ku2mH5zPJhRNFnBYxXgba1mYVhIKRQaGteOuXsP2J
 Yj4RCBGHTJF2oG9HxQTiYeitIg7UhOoJLxMkSt3kctFK0jCUR4P6ysazNOHz91DveQcHDqXC/
 JULnsJLhEe6M1bGYmtbIw5ISIeCIaSKcl7uSJrBZjnSIZ5ZEwrU9YQkBMj2Z6d+BgnS1lbGsq
 ITGu385cPxWSVmGSHve9Diko6YEqxjX3i37bed6ZppBnnFtoN+31bKkDsAuPlKpYGxFI4R/9T
 Njr23kO8RzdodmIv4D5j6/+el/VvUN8g7FYRgsze8jj+nXfGKIdiv+/r7g95Ac+3WHl+5dMdx
 A0AKgj4WdCOamKjCrtm430DI+hl3fZVlLaU5xzixJLkO6dK7PzqCtQOdP2mnwcXwIbzXXk++8
 QgSGT+u6MZjW9zNbxRCEsBRo4xETCGbsc9Hxd7TgTXTJYartHdiWRPvNUJzmh0/jEkuvotn+N
 MPnWnbU7EXf1WQxPydyWBopTVe85j3toUCimV1/AaFpjOTlgeEEI5Idk4p57VjTbfUS7XjtCF
 XU2YZXL0e5oihQhHvEcuBTC2YKGxv2fgDv3YNyYvT+QX8aUbIjop7G676w2fzr8q9A3+k4JIX
 f7bISIvNDFiDNy7vXC8LzRydxDnqfYk6Fhd2s5AjtINpPW5hYxOO3IsqOCDHFYXshvdWavgLK
 sYbbbWLsmX2y0mix0UUYkWdvRZVwznlqk72OOsVtwDi0lVXRgvvs6X7UJW0xJPP5hc4ezlwYf
 QD4p/aG5fBKmc5XgVurx5JUnSI6Y3acg5ZD/XjgCOEyU9HKr0VPcD2Bkgr8LObN7Yg6ykgpnh
 QQxdfmqWvW0v0RDalNBG7TNE62WDc78fmefiuadc6JmZh3Y8B2ohFNVQ7wXA+ig+xVIAtnIqG
 mTEYLXptd7elkrn0lOb2pPQRxLVAutxmFaANkWDXO0A+zU7f3HA9kw/I3fd38SHfxtnk9BYVy
 dY1DJy8bRSRq8rO++
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Check that alloc and free types of functions match each other.

Further software development challenges are interesting also for such an u=
se case.


> +/// Check that kvmalloc'ed memory is freed by kfree functions,
> +/// vmalloc'ed by vfree functions and kvmalloc'ed by kvfree
> +/// functions.

* How do you think about to offer a wording suggestion for subjects of
  generated patches?

* Will the presented case distinction trigger further improvements for
  the desired matching?

* Would you like to generalise the safe handling of allocations
  and corresponding release of system resources?


> +// Confidence: High

I suggest to reconsider this information once more.


> +virtual patch
> +virtual report
> +virtual org
> +virtual context

+virtual patch, report, org, context

Is such a SmPL code variant more succinct?


> +@choice@

* Can it be that this SmPL rule is not relevant for all operation modes?

* Will additional dependencies matter?


> +    E =3D \(kmalloc@kok\|kzalloc@kok\|krealloc@kok\|kcalloc@kok\|kmallo=
c_node@kok\|kzalloc_node@kok\|kmalloc_array@kok\|kmalloc_array_node@kok\|k=
calloc_node@kok\)(...)

I would prefer an other coding style here.

* Items for such SmPL disjunctions can be specified also on multiple lines=
.

* The semantic patch language supports further means to handle function na=
me lists
  in more convenient ways.
  Would you like to work with customised constraints?


> +msg =3D "WARNING: kmalloc is used to allocate this memory at line %s" %=
 (k[0].line)
> +coccilib.report.print_report(p[0], msg)

* I propose once more omit the extra variable =E2=80=9Cmsg=E2=80=9D at sim=
ilar places.
  The desired message object can be directly passed as a function paramete=
r.

* I find the diagnostic text insufficient.

* Can the corresponding function category be dynamically determined?


Are you looking for opportunities to avoid unwanted code duplication?

Regards,
Markus
