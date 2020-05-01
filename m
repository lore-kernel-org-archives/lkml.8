Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C215C47254
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 07:20:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD620208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 07:20:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="LKDifLjD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728339AbgEAHU3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 03:20:29 -0400
Received: from mout.web.de ([212.227.15.3]:56609 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726452AbgEAHU2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 03:20:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1588317624;
        bh=EogFK9mFXseM1EoaAWr9HYeF9I61NVg6mcQkG25CP1g=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=LKDifLjDpw9h5M5lPNlm/gD7rDyqjPS5+7cN2AVR9AnmywQL1ZYlOdF5lVmCd6yLj
         PMPW8KidtwGPsnSkBWNOvUocE7gAOoLIps9JLaTkxHiCpu68ZxcI6LPhOvN5HYXSHA
         TfWVGLL4Hnt98AjwuMgvxIuj60Q21FrX515/o4Dw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.136.146]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MQc7J-1jbnIj0K4b-00U5Bl; Fri, 01
 May 2020 09:20:24 +0200
Subject: Re: Improving documentation for programming interfaces
To:     "Theodore Y. Ts'o" <tytso@mit.edu>, linux-doc@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <350cd156-9080-24fe-c49e-96e758d3ca45@web.de>
 <20191220151945.GD59959@mit.edu>
 <17931ddd-76ec-d342-912c-faed6084e863@metux.net>
 <748b8572-a3b3-c084-e8e3-de420f53e468@web.de>
 <20200108161428.GA263696@mit.edu>
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
Message-ID: <5185a8a7-1fdd-a9b9-eeef-f5952485e1c0@web.de>
Date:   Fri, 1 May 2020 09:20:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200108161428.GA263696@mit.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:98nnpJot3ONhAS0PiXP7RR9WvWuB2e6rhfRQQ2fXopta8obkrWA
 tL4ovlnMzJA66ouyhqv0tl9S70UhZWWcxp1L3YxvxevRYuarwVk5UIqLSgMl4pZyG7bYukr
 lyFex4nlygfvhJ35s0q+SIKy6tmQvD9iUyce4D1XRRxAVxG0q2wRJSRjNi6OEjOkUTHooI6
 j00XnWTuooCL43LqU/BWA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+UJ4aKKsfa4=:GIoLbEqqfRxN0rdKCQUv4X
 tIixMC5ttPC11fXXuI5RwdWlF6W98hRUWcD05DRd9N1oXDgM+OJFFh0H5sqpyRV5K6a0WqSx9
 +WwDLbiUfBVbAODTszCYNqRgkc088knYeI1JQroZx4xMLoIrhfQPcp6rMmQV0MpUp9VKKRIVI
 IwoWF7acZXNMG27iBhPM8CGp9QHjwRUNEu7kVAkBdLlspV/LY0uedRc+8sUMbm6hVQWiga7a6
 ba+ihUaOlUkR4VpEqCVGQrRb6WiEIoyvbogbiShL1bDNZ+YBS8FaRdO5AasiIFVuk2dwx/OXC
 PqeETQjH9rH8nxIjwC3AEp4ehDejYL9XfQrIHNa6B1qDS/s3RaPbcujJOgLPb52O804LCdy3d
 ZJ7Qha3lXvW9hCE78/a9s+kP31zkkufd+Xb5FQnlCkK2cFVu6p9UcW9YHu04cR9qDytMbwf56
 wsIA3yVGS+jPUwcWlbrKIbbIJ5K4v/A64qYSsLLwtvkVdeeFOOEV44IU26n9U/klLM4DbZuVz
 EbxBTtWLdqw5i+JwTFecpUHRQe2ycJp0Q7TrYRak+zqbcf3Nq09/8/uOpn71E3y3FDe3aLKQQ
 vf5U0E5P1qE8GwIkVbUfxIXNPYi6LD9Uakx+P4P/tOtiZcmVcFO9ftiSVv30yKC22jhIC59P/
 kG2hMpAjwK676shL6nLKBIi0nQUkKC5dcH125LGOUqAKI6lhBmZH1OdHLb1pCZYn1dUnjmCTa
 tgl8+EXN78WwDzZk/g2GVdog6lCktBrbl4rsgJic6Hs9OXOogrpkShBSfjZe/s8SOHnaSP5mv
 P/kIRlk8fHGMOeGEbCsbwS+ZBgee4ociX53wFwSuKCRpQx2Zw1dPc8dZB2ME4zUijdZsR7XFg
 bRmKv78KXeVVwfMMXQgEZxdz2SmP7kDDGj5Jj8sqnBrjiYipobVvLgT6EQTlqEy+OluRbeSV9
 FZSmrH1YCdQRI/PHsXKsxDgzCSrdqUiTsbupXzdSGbByqBn80+k5OrxG1CDLnML4lnavST3XM
 7mWuGthR0vP4DVPCnO09fPOaDHXnhYOJjMf3TKjNe3Ue3odhAjpN/wXD+tsLK4Nq2gUBx3m76
 I7WfKjWKC+zJgMs2YcKiTLv7PboJ2nnO34KT3kom3rlOA50Q6McSCaEPMNVguIjAcOu/+TkGn
 C6JXEXClhbyDKfu110ijK9tpZs4SZhVU0V3qtdsKFmpz5lRklCKO4QqHnLQRjz7jfFWRhXQ7T
 sS/oWkmQqbpaDecqq
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> I propose to encode helpful information into macro calls as needed
>> for the C programming language.
=E2=80=A6
> On the "benefits" side of the equation, is there are ways in which it
> will directly benefit the kernel developers who will need to review
> the patches and review the annotations, that can be demonstrated
> immediately?  Not in some abstract way, or "when I my research work is
> completed", but a very concrete way that will be obvious to those of
> us who are still not completely convinced?

Would any contributors like to clarify further possibilities around
the application of source code annotation languages?

Regards,
Markus
