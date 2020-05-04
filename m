Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B738C47258
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 16:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41D7C20721
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 16:16:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="lyh772Tg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729553AbgEDQQG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 12:16:06 -0400
Received: from mout.web.de ([212.227.17.11]:55749 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729253AbgEDQQE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 12:16:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1588608949;
        bh=DQ2nnjZEA8s4f3e4nypJA7Djufr+5weaQyav93E3Oso=;
        h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
        b=lyh772TgdBb6MLT0ZJZ2riRi3nvnhxRjy/UD3s5yXQIEALNk+EpgNIeuB1E6nOAJd
         XDKwCVIh6XOKeMx6f+/uxhvnYUTvVF08ifKtTqsKNcrCGLixZfwJh37n5KrKEcJHLm
         exGCX5KqYsXodl/Xst42Ngvhm7UuvqqNzy/ofsfI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.152.69]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MT8bi-1jg7M31zUs-00S3b7; Mon, 04
 May 2020 18:15:49 +0200
To:     Jia-Ju Bai <baijiaju1990@gmail.com>,
        jfs-discussion@lists.sourceforge.net
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Dave Kleikamp <shaggy@kernel.org>
Subject: Re: [PATCH] fs: jfs: fix a possible data race in txBegin()
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
Message-ID: <5ef374a5-0e2e-5c74-a827-0148c384f6e3@web.de>
Date:   Mon, 4 May 2020 18:15:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8/af1Ha9nzjc2lhZ5r//wz9hohzEA2pfMMozzIES8IlmQdG9k1y
 BKeq18KyyjcU61EVm7XNPp4CtjUHkYKPFVDMMHJ/RNxc4syj33nSr+vVhQt3mCce2gMp5dI
 EN09JEFU8qaIncDi4YTbj7Fq1T5z1YmY4pySdhWxCQo0Nc6eSxY1/YVtR4XXcFNo2KB9trT
 nZNH/YD2V1eKirZfeMePw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ArymooPZTeg=:Dmrghxo4++2SROSRIDzjLs
 KUlKg1b382hJrekSx8GrThMoLNhDaH5QLV0YfUDoKGNPPdGcFtxTsfjy18Lbjvnp57aGna+FK
 Jf0AqGDtF4QFONPIXcdrTYIXGdR4/L32GOjM9XBAc3FAlFNN12YavBRDEIC41eMeJKQ9teHiK
 D7vOY7RZoYK6wqg98jNJ+97qntaRK/D6i3UqwE04MmbIy124VxrWnHWcKcJVtjUXY//NlNNdN
 uZrUfFObTDg0tiwo9DswTYU0aU6rWvSd/pvXoSDVUeC3fxWcjH6mx8JHvqQEmnNL4lshl6bks
 NPHskXYMY2JVGMwbJcwOKss6YM7fOjvGI6+oj2QxhdfGF+uMfjhAGmanvpyCGd9145uP61vtn
 wzpkoyoHRr4aRgulr3LWTBigFEfZWvqcxPzbFSMw9X3bvoyrFinFPXEgCyNp4LB1B3MG6KvRy
 r3kHxPew2Dyne8HgrLo/3RNiH3GHTt9+MGurpptPCHIJaLW519VUv8QzgtS/eXItBqT8SQDIA
 kRY8tsPjx6HsIScW7FNza6Sfu18XnjB9NPYNi/rJIWT0UBid/qESlGZHnK91Fy91NlpnpHEum
 oyViDeD5vkSvMoR71kn6J2Wxx5TGk+BXOXz3N2Bb2Tw7deep5P/cxq6Q68XvX1O9UhlVf2PQU
 GuKibhy7whZcdrRZD7mdp5eJV4kWtb6hGKddtayhTRNpZwWkvcu3HSm1PoeQpzAzK1slrdwfk
 qIfcG4kyjEtuaIjIOalmymsRX2FOujh/+7hteZy1poWavA58zRZ48SIb+P5WPuFXB2eIZKRTt
 KrLhvn8z/yIE+ZFDzTJrneG/SQZvs++mgGEjRtMGalosadISLUGY7QKj7w4kyd3CIor0fslFU
 bMuj4WjJXxLeAReYSZCvqIKGf6bX22SVkAMzePLTiiQGlyH/DZB+wSXnNSFOA7Llp9Yjg1nmj
 hBWdeOcLe8RlMWE8N4RsSSEPc+nbGUugO9MFj8lA2CM4jgEeeBeo+iKlXe2xWMZmBp7/gNn9f
 apLo76LXr84JwQr6E4YfhpA1Z5Xm//Q17UxXfetgA+I89m3O1nQPMar5REX14mkw3y7XUiu2N
 frujy6IW7UipGGbHPZRi20B5WhP2sjvIaw1N8zh7Y3Qzmv0CeQ2mzKWYWJ0fCYHb+8b8Y9MXc
 azl95sxk2K5ZTGRXXR1pUUAWfNLn5Uh/nY3rLKYXMV3U2IcH+VMxCYH40NqkC3G4cndrsku+z
 sgybEMRZCeh6hawSq
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Thus, a data race can occur for tblk->flag.
>
> To fix this data race, the spinlock log->gclock is used in
> txBegin().
>
> This data race is found by our concurrency fuzzer.

How do you think about a wording variant like the following?

   Change description:
   A data race can occur for the data structure member =E2=80=9Cflag=E2=80=
=9D.
   This data race was found by our concurrency fuzzer.

   Thus use the spin lock =E2=80=9Cgclock=E2=80=9D for the resetting of fi=
ve
   data structure members in this function implementation.


Would you like to add the tag =E2=80=9CFixes=E2=80=9D to the commit messag=
e?

Regards,
Markus
