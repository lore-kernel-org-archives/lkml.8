Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37E65C33C9E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 07:30:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E79132077C
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 07:30:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="JpAnfsTj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728555AbgAKHaw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 02:30:52 -0500
Received: from mout.web.de ([212.227.17.11]:44807 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728517AbgAKHav (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 02:30:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1578727828;
        bh=6Eq5J+hAXx9XXxlnxrfRXHh/HAz/bQl2TOjlEN45Elk=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=JpAnfsTj52a8mekfq3zgUnoSVJtE2Z1Lmg6XFo2DA2ctUSW/2sl5Gt6/NghNGpzbS
         OcETdhXI0FHO8e0iEl802r+D3UjDE/xq8H3ciCyHX3fj7hzuV7/hjt1Eg9pOXo/Mzu
         72Vk9rmjJ6cRGMcnzwdZdJjboLMN54q/ZRQD4hLY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.100.149]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MD8Fc-1itQM41PG0-00GcLT; Sat, 11
 Jan 2020 08:30:28 +0100
Subject: Re: [v3] coccinelle: semantic patch to check for inappropriate
 do_div() calls
To:     Wen Yang <wenyang@linux.alibaba.com>, cocci@systeme.lip6.fr,
        kernel-janitors@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        =?UTF-8?Q?Matthias_M=c3=a4nnich?= <maennich@google.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20200110131526.60180-1-wenyang@linux.alibaba.com>
 <91abb141-57b8-7659-25ec-8080e290d846@web.de>
 <c4ada2f2-19b0-91ef-ddf3-a1999f4209ea@linux.alibaba.com>
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
Message-ID: <5a9f1ad1-3881-2004-2a7b-d61f1d201cf9@web.de>
Date:   Sat, 11 Jan 2020 08:30:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <c4ada2f2-19b0-91ef-ddf3-a1999f4209ea@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cEmH2Bt3J3aClGJ0ZcUOZi7Unb9EtVQy5vxv468r8yQXi1SNcBM
 L55Xv2QHTKUc2uWbs+n+KUS2qOhTtiJG7qBILH1B5FNELrCbOrmJmGTTNyuiEnuV5aIXQAA
 lQpgKQPr9oZTZnbKHy4IBGkhS9WHP+zB5CdYrELPe69Gvkik1lbrJWNJdvDaztGjzSnko9Q
 1f9rHwv7fRKM63WPG99rQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NuLxLJDJoH8=:0Q6ALifB8ghzjkzRIyqjTL
 CU+Koqo8853URtyTMUHulfRttcZ+fyF4JC6jOO8PjJ4ycPt+3GeS68Lip2Ow8St9HF0xkLk53
 LErkpNxiWsSKBrTZMKwMdV1HT3lCUdaxsfpPGR5GJ8SttrDX8BHHJ3mJA4TF5+dw4UvTUGPlC
 /YHwxuF8cF3KTt+QZc/PJ+7DkzWrhPqU6fgbQw71G3nXj4BJT9JcZrTDrjuS3D0VbGYnYizo2
 e2Fgp5k7f1INTxETEfPs61xIddYcvTijxdn60REZirqtzLuOZZ5wrjS0I9TbszU+M+vrF5Amt
 R1A6wLvx4++muUjje1Z/UIYyM1rdV2o8aUTVhsZx/V2bNqaaGih2L9ZDMCbRp6Az+v8sM3O9z
 V4HePSy8qMKJ9MmJQlFpwbmAADEWc32klCcCABAUO+Pf1gq51JZ4nPlxYboGK8ubPL4CGJ2a4
 U9yksbuplPfRJmh3Pd691TZs2QoQN1QJuFTk6ymgslroqA5/tShEXcP73S1IUf8g6//cnKnhW
 I6SJjdOefa95QFz5UOoHIinuqYCjK9P46ZXbwp8qIMUqYsZ504r0Ve5eu/BhFNpYaDtXwKuAY
 s5B9pky/CVZZj6cxJbZGU5Hoz13GzwH4fUlX8IOKdVbwd7A2oK9XOcVd+wFf5BPiGDHzNCvGr
 U7ha+jh5lhzjudOaa53gQYKbEJx+j/0nFPYWvREF4n00loR7lH1uwg+cwYRPuA8yr65YldEUG
 7IX4omPbenkft1f2SNqhRq1e9WpwIwdo/CtuVVZOsYDu1V8GhvoFw4Y7ooJaCF2ssLwl8d5Fw
 s/qgm5haABCMa1L3f0yNZ2NIJ8vm1IKVsZWCRxRtsB3V/MTKusQmahxQEuIWjdBnNysP75tdu
 jw5rX0xxERw1+IiCiiu3UVduDknP8wQXuQHKCFgpN6evTuvZpV2HMj3UjDsxucBmy7EOITbaG
 pB11oGNSuq04Ngoja5agnu5A2l1ZVBb8ff18ebbEFAgtMYtucBlxuyUc4br9uai/6FLKX9p/b
 m1aLDliBJhZdcReXHNL9NkhNcCAh+8c7en6fDnu6/P8nfMc3G1wLU8lfKPkKxm0N0Gkr6o1Xl
 k85m6XMnR2zBn+l+kbBKQTh/Kf42zK77V9mSWywvL7v3EvYvMFquv/NZarDJx7MV0me9PKT3J
 11Wxj+AN1vUjzGSLtWTfOBlC/qNR/I7cUC94FbyFfYGydcStX9TlOv9qc6e6GmiVKtNCDb/0f
 UAjoEoqwyFdChw23gK2j1xUnV/DFKS3bbplwr/52fIQ/o2id6CSclSoz+f7M=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> * I suggest once more to adjust the dependency specifications for the u=
sage
>> =C2=A0 of these functions by SmPL rules.
>
> Most of the functions here are for all operation modes.

I got an other understanding for this software.

You added the information =E2=80=9Calso filter out safe consts for context=
 mode=E2=80=9D
to the patch change log.


>> * Can the local variable =E2=80=9Cmsg=E2=80=9D be omitted?

I would appreciate another fine-tuning also at this place.


>>> +coccilib.org.print_todo(p[0], construct_warnings("div64_ul"))
>>
>> I suggest again to move the prefix =E2=80=9Cdiv64_=E2=80=9D into the st=
ring literal
>> of the function implementation.
>
> =E2=80=9Cdiv64_ul=E2=80=9D indicates the function name we recommend.

The intention can be fine.


> If we delete the prefix "div64_",

I suggest to use the text at an other place.


> it may reduce readability.

I find an other code variant also readable good enough.


> +*do_div(f, \( l \| ul \| ul64 \| sl64 \) );
>
> We agree with Julia:
> I don't se any point to this.

Can the avoidance of duplicate source code (according to SmPL disjunctions=
)
trigger positive effects on run time characteristics and software maintena=
nce?

Regards,
Markus
