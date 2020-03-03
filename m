Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C1C8C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 10:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D828214DB
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 10:10:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="fuCUH+v+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728379AbgCCKKy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 05:10:54 -0500
Received: from mout.web.de ([212.227.15.3]:49481 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727412AbgCCKKy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 05:10:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1583230213;
        bh=esNkyqvUaFfoWxy9BFQXUz+KsiFILrlqXB5tZdWkD/U=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=fuCUH+v+qUw9jrKn0Z+zG8FjcraBXDUf8/RasyNGlCq0o2bx1FUn8Hb9XXzLcEX7F
         QK7PloEunPLUdirlbwyeCex5idiHqsk6ImrnBW4ivNCSSE5OJNUXngBL8rOkfY29mL
         TFcr0nRpcUgygoVcY0FDRuMbIFAG/sQ1AaeCrjpI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.62.7]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M1nsQ-1jO7aB2QtW-00tgdH; Tue, 03
 Mar 2020 11:10:13 +0100
Subject: Re: [PATCH v4] Documentation: bootconfig: Update boot configuration
 documentation
To:     Masami Hiramatsu <mhiramat@kernel.org>, linux-doc@vger.kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org
References: <158322634266.31847.8245359938993378502.stgit@devnote2>
 <158322635301.31847.15011454479023637649.stgit@devnote2>
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
Message-ID: <1955fee0-e803-a6de-c865-8831aefcb2f7@web.de>
Date:   Tue, 3 Mar 2020 11:10:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <158322635301.31847.15011454479023637649.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eE0HsnGyNRu4MZyVwPlFu5p1bO8rAO6AJaVBLjRiGyi9QUj9nJc
 lJPbZGeBAJRvLVODk9aSkt+KBe8RJdRou0KSQgJBqjz8KnJ4egcU6YFlSiDXSc6GyNTldGk
 bjd3X+C18T2LmGL6kCwrGrzFWgJPd1lNXSv3OQxPsrtT/ZCqJqWaXNXuEMK9V8YTMdQ9sSE
 A67ScWl3fsIAmG0n2VcQw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Wr1E6urGR80=:vOuCnK8XKOXfNuzP5Pu7Yk
 ceOpQ2W7LTTYBjkpGUokKhFmMiZa9/70nqYvy1IFFx8Ynvx2jRFaLBkvEtjF37A7Y5ctlnhfX
 EDbGLMFmpqY442LgQw5O7mfxnOmAWnWaLe5Vf1e79vxkecS3EKO2gfzMEshlDIyGc+lcWbPQ4
 S9IIwPhzMhQTGpepzNifXcyt1HRKNz7m1YhWuvCAx3eKLCk8FnqlRdCXxW81RkL0a+cXL+NrT
 phi/D4wcI7KcOlIbug2/j57Nr456kxV2uxFQwYMAjNLBuOdBC4gpqRRcQDyl88FUIJOeDHvWM
 oZzb0+rN5R6EcqlCwFxXogRprAhFJa76FmwOt9RwPe1pUyDbkLyFj977Nz62PUfan78cuOCKH
 0ZVnjbgVtKpffl5L7dn4iL+daFdoIPEMsPFaVm0OmRNq1VDGLxcVl0RLzteHQ4ev0AO68je+i
 YS1+V0B5UOvSzOQth8q6HBo9ayIeSv2CG6n9W8F+jsS0HRPgI4DwBijT6XruTftQuA5fjRHZV
 6EB+SVogk8y12xhb/ArdXgHmCZoLyTBHuzx1zvCZCDOzvWklpBDelzPyFK8me6OFAkHqNC/ZM
 mNJJAq8wMCXG6cOPJ6fzHidKQvvoufwDrEtapI3XuBCJ9l1zGzb2V1J1N/wjl8D+/Po6L8U5U
 zp404bjhR1lDMDWY4180SQCJE+ZqD99Qj52lGfQhVblGyRqCFs6VSwKOvewF9WQOl4hO16cOX
 PpylxhyGFLbCODOCRkUBPWGu4ZPbUlKM97EySu7ghDOAsp4uU/dvXPdrRi6J485G8GZ1IqUAG
 pPcRt8SGENRK6EDIYuxWMqeKS9+tExyjX1qkLhpDyDAL8JSmGEPtGmlnOG8kQcJUkEBl8MNnQ
 GIBAhTP3qY2R9rJTeDwf/eyTs/Q1/oW4y9icDukhcCdoErxNz8UsvEkJNAxdb0eBLERV18vFr
 EY8S1YDF/PHvrymmELxEPsU8kAQXOvgeSh8YVA2Yh4UpLDgBLr0vbHAl1b1Tv+EACZkZK8iRp
 B7e6IOilPz+Qe/+oN3QivMupoJtC7GzOORCrQo7HSCIto5YWZX43Gqy4MxQq7N268lOLxWjyi
 HiI3RgaX5Mb5NokuP2EIcwEQm0ADarJiLQe1oNVWhMzBrGc7sZcJ7zKZKK/OQrheQwaCzcjzC
 YkzvaaFVdHw3s9AdYnebYe6Y3hX79yRLAKhTt2uICnNHEM2a6/14UqXgHjbsRpiYEGEZvVU+C
 9dpEaqd5sEnVPKGrn
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Changes in v4:
>  - Remove O=3D option from examples.

Will any more constructive responses follow according to previous review c=
omments?


=E2=80=A6
> +++ b/Documentation/admin-guide/bootconfig.rst
=E2=80=A6
> +=E2=80=A6 If keys contains 3

Wording correction =E2=80=9C=E2=80=A6 keys contain =E2=80=A6=E2=80=9D?


Would you like to improve the provided information at any more places
(besides typos)?

Regards,
Markus
