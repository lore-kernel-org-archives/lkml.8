Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FAE3C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 09:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 050F22065F
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 09:30:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="nFXZBesY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728856AbgGUJaT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 05:30:19 -0400
Received: from mout.web.de ([212.227.15.3]:33553 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725984AbgGUJaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 05:30:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1595323810;
        bh=YT/kR3ZwU/kDqcSn7U0C5sueJMSYdbgcta+v4KPqJwE=;
        h=X-UI-Sender-Class:Cc:Subject:From:To:Date;
        b=nFXZBesYzq06NTvb38i+7S7UrbFuylGIp+Azia7AvL419qCtnNn0diJWNMAH8Cxid
         H0ZTknB4vnmoEySsAbOgUQVScN/KSXJfScwTkom90ewDgvIAc+sDv1AkYqvF4tEITR
         Lp346rNkInUiEM0aigjNzSG7LltbG7O1GNReBJyA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.170.58]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MTLwF-1kMrzS3zZH-00SRQt; Tue, 21
 Jul 2020 11:30:10 +0200
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v3 2/3] coccinelle: api: extend memdup_user rule with
 vmemdup_user()
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
To:     Denis Efremov <efremov@linux.com>,
        Coccinelle <cocci@systeme.lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Julia Lawall <julia.lawall@inria.fr>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>
Message-ID: <e3d2ffb9-2a47-3d77-0501-9d48845435bd@web.de>
Date:   Tue, 21 Jul 2020 11:30:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:90Dg+huUi5ryecQD1NR33pt51+e+8Ixq3SqR+/uv+RtglJ/pXuv
 OzDZb/ErJy3dULRt1msKQzHMveip1g45iFSBPbA8ZdSJA46vL3Ocl7lou9lqMNUY9Ygf0sp
 tnxE4KBSmdXJjwhjNTpezmiSEaxmyN4wVuWBOrN0JYFGA1mtys2NQMHdoiBta91dqOubVfv
 OV8IQdZpn2DgGsyzbS3zw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wZQQnrefZwg=:wMvnXS1SHgPYg2hGKStBqL
 7Y8YFQHzAZS7wnPJgAXHEwm6TuRqxNHC60I/9CC23HSPKq9mcjzBiVF0nUEx3ipUPmWso9KsQ
 t6k8Mo3H5Mdj6LoAYoG3y1yayAyflQajMnwqYYzXFGxvlksXntF+q5k1gJdw+ygpVDq/gdb7B
 0cR/cE48MdHOABtycuqJxG3YECEIpIAMc233jKWkPvJKlF2EZafTJazBpdSRD6Te6JJqzH/Up
 iJjEk/+bvWXWcPnEg7Fid2y5WwFdVLpH+Z2+wa81Kbu2M99BkFZmHWn0fgELbWX08Eju0X0lq
 ze0zuGDdtYmqsigOUojj6vRwQfHPHHW4/FTJ1zx9/ygvwXnE9jxRB03fqFaBKEDwQEodUWogN
 uOqnjZG6xnG53LOihX8KF7P33poQlJxEYtMEf7X1vZQkUuIUtIu8aGDn07/dhIfj3KtM48MZi
 6oRgrolM3eo9rmU2xArQ/MfvpWrqMMCpcg21J2X2XeDnpRSLNOnzK1SsJEz/XyAUGEgSbtMxq
 JwtPGUh72EoXwRZ1MbN39Nl5DCGD5z7c6EaBpWo0sxgEDipJJakMeQ+nx8lefDyw6LzEm4X5O
 BJrxEJqGKqUykmjlV1eGz0ebS7L8IcQikEQ6PQ5EBDoCt7etNBmrL/lZcZnWM1gVOdHrTbZm/
 BGXro02cnBIV3Vt/ugeBEx686h1THIJH9OpueMhQ6F+lHHpVhGgRh7hD1IJyBEyvn/hUIPXwk
 5VzapdPHCGSr+iMYtpSXJsiIj4y43v7s6MfW2yZaZpI+UGT0UamU26CklHzLstKydLQ7rRTcl
 XTzmM8QIBIZhkJI1EvXxx/80wss3v74QgByNBG1EyHxJyx6pMIyHo/DqKQq0wLEI8JhxqtwSA
 mKbmn9VlHd4iQKiL0wZIQsRty64Aadg+brN5Aal73z7X9oOLRHmLnYWMmgTPPZYa9xxndCbfy
 hiBmarTsZxPMXb1COp0EQFYh8JoVU5QZEYLd5Zlteck9QZh0fhNcPSif/QHb0ybdZY630nipE
 k56NIeIeJ536FYSpOWKRE2zZdSFOsAoPzWvu3QDXUFtGSdZwHEcZtL0ZYPrBEkCyy7W4OUlD6
 r1ZUam1Tsi7bB0hL7SgFhU2PhEBfHiFtmkxe9/9ezWE20aK7v1SkjCfKADG6D2HSypKMGM6y9
 pM62Npqeke8aZP4qmUoiHZlbznJHVDYS3ExdH3ym5a1mC7dkOdhckOtzb18p0zgZOPFPqRwG8
 2y0AcRbfYZDoxqeGFwWcZLiuK/OGHCEMZNORgQw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E2=80=A6
> +++ b/scripts/coccinelle/api/memdup_user.cocci
> @@ -39,6 +39,28 @@ =E2=80=A6
=E2=80=A6
> +@depends on patch@
> +expression from,to,size;
> +identifier l1,l2;
> +@@
> +
> +-  to =3D \(kvmalloc\|kvzalloc\)(size,\(GFP_KERNEL\|GFP_USER\));
> ++  to =3D vmemdup_user(from,size);

I propose to combine the desired adjustment with the previous SmPL rule
by using another disjunction.


> +@rv depends on !patch@
> +expression from,to,size;
> +position p;
> +statement S1,S2;
> +@@
> +
> +*  to =3D \(kvmalloc@p\|kvzalloc@p\)(size,\(GFP_KERNEL\|GFP_USER\));
> +   if (to=3D=3DNULL || ...) S1
> +   if (copy_from_user(to, from, size) !=3D 0)
> +   S2

* Can it be helpful to omit the SmPL asterisk functionality from
  the operation modes =E2=80=9Corg=E2=80=9D and =E2=80=9Creport=E2=80=9D?

* Should the operation mode =E2=80=9Ccontext=E2=80=9D work without an extr=
a position metavariable?

Regards,
Markus
