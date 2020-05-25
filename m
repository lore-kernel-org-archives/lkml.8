Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C5EC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 10:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91D8D20787
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 10:40:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="OL+67yHV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389871AbgEYKkk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 06:40:40 -0400
Received: from mout.web.de ([212.227.15.3]:45873 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389720AbgEYKkj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 06:40:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1590403230;
        bh=UAAySmjAxYuqZUoP+efpAcdgXj4UW8nezo8B+rRuNAA=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=OL+67yHV6Qz0iKD5yee8iW9W0gC+pYjR31ID31t7TyQuKaTdVp3V2RQfdDgDUFmTu
         lJ66wJ5soukyendWEg4eE52SS3vmvlgjFxTf1s2qr0DSytAdIt2nO8E3WG20U/h1kg
         PQBUAIZn++5fgrNrg+3KReWRJ7K0zEzj+fiYv8Lc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.186.124]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MoNZM-1jEp8g1JEG-00opIO; Mon, 25
 May 2020 12:40:30 +0200
Subject: Re: [v2] workqueue: Fix double kfree for rescuer
To:     Zhang Qiang <qiang.zhang@windriver.com>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20200525075901.12699-1-qiang.zhang@windriver.com>
 <7d19381c-2c51-deb4-f82f-d54bc56c6ecf@web.de>
 <bee86d19-6c14-1fd9-eead-24e63af6cf8e@windriver.com>
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
Message-ID: <8b67c327-e70c-1e96-6a99-a5fd2667f666@web.de>
Date:   Mon, 25 May 2020 12:40:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <bee86d19-6c14-1fd9-eead-24e63af6cf8e@windriver.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6441JMEiROh6sK8+BnPqqw3WrEthd5XUr+Kzdk6pmE+X9TQqB6A
 nPZqGV1WuN8t0Ug83lwopTfwhOLXgYMl0A1FBQTTL40z/En0u1vkxBK6o/EH5qe4ps+TE0t
 i9yzoQVL3n6/LX73+lFHsIocNLlluvTQzD8Ct+0WD1vJFYhmIPqbLTuEhAMKW/43+hA+S9O
 upkbkVVJzBnSGJiQqFggA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CCEENFUN3qw=:rhvh2m/C3Fq4w+hI58PLWZ
 W5RSOY0fHFNsFcRUHBR4HFGEMfQc89vrEmslrx4br1hbVL/xe897o9mi9yK9UZiIF0LMEWpXl
 dY9hSWKfpVws1bFSdVSS0RKSRkZ+ov6Vi3TNAfv7cIhxqxikt7yarfokGAsW+SISAab1P3ofb
 IAjZJt7zaVR25cgrqFNSJo4N79qWpGOud1OIzqdSbI1LRYL2HXyioyWKFyQXG0Amby3bFKNnz
 QDRU9p3J+cods9WHD+dPfAzRYLIYDVu4lOiSvcjKbyz91TxCk+y1sqO77Rc3n50fLGVegNju5
 oB1pLec6ZG47yXyVQOeAVFXLsoiIdrOJs8rSTkCANS9mhgK2Dse1SVI9dvcdcEbwCl3TPdLmd
 7O5uL1JaTHWjRr0mn87r0QobMCwZc6pDlumyBLVkykEpledNhmKGS0LU/edLxY5nGLY6/tNQ4
 YzDRmqkUI6xr7o7DLxWGdySikmCGE47dfNBTIOrVBz6ktKMXWAJlti96lvHYmWbmHtEQeBAao
 dlmKr5ydrMXzSbqu8kERYxn59LLNjMohzNDXthFoQPMagBgfh10dv4y2Ov1+kcr8HlNhp+PAY
 zPz4qg5ayxdlrfalPd/gc11IwhhDhud69di7F0Nrp4QjFQAxvSp9tgUc6G2u/uLqs8nPz3MtK
 B1pwTD9LyWIxX4xinCHqzMYh8EI1aAIb0tfXNUZASRPi0Vzv7xCnjpIJhGdqUrarFvOA89tc1
 bXYG5k/Z0XQvxb+H+s8wqDolGzXmMjIN4uGOM9MEgzHTEKyIwjmfaji+35Yw8MBCHt5lXGelR
 +9hESTrydfhrvRBp797EUTkFaJFCicN5TrFTuIr/ygAmn7D+dYubBMDFDFqLw6as94NyK3S35
 t3FHtOyjEhMko3aYSP6ruGM0B65ie4bR7l3RrQVV238gt0eSy/+r4eAoLjhmX9vUHxOvxKbeY
 OoCIw8hI7I/puvXoLk/KaHtnXwQ0P1BfMTu2z+VUgQ2/TgW5+skp8Bl4TIexVGVXKz45jzqxA
 aSTpLTv4JqHXlRBHxz1SkSeKw+HMWn66m9lTF/jI2Ck1KmI790jF3WjO66O3OZfI1Abb4eGw4
 CbMl0StdAa2CpMhmmLVlbYS2Rq9KaMsXzfIqSMTB0TxnyVrZ7qPoihtQK5G6cP5g3Kh7Er29y
 5Hz/R0Tf31y9q3U3fQ57PZby7GG/GVJKHX+xV3/QZgB0Tj6lUCPJucxGlOhRUBbIVfhyuDiqW
 pV3dO5wSRt+olYd8U
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I see, kfree does nothing with null pointers and direct return.
> but again kfree is not a good suggestion.

I have got the impression that the implementation detail is important here
if non-null pointers (according to valid rescuer objects) are occasionally
passed by the corresponding data structure member for the callback
function =E2=80=9Crcu_free_wq=E2=80=9D.
Can another clarification attempt reduce unwanted confusion for this patch=
 review?

Regards,
Markus
