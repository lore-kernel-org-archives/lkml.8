Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B994C3F2D4
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 08:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22502246A1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 08:34:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="I3rgxrHr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbgCBIeY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 03:34:24 -0500
Received: from mout.web.de ([212.227.17.12]:40211 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727103AbgCBIeX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 03:34:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1583138027;
        bh=sNuTtTRgid97y9KJf3LKxvOS2DrmVQecTFQXgfpkGTk=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=I3rgxrHrBVwMrzmsMm+zDRYwxh4SysFWydQyen7A1dZoxiljMvAkqok9IYyuLMkSj
         Xbkh+ctvm8ecpZEYWCutc8iI7XHI4FMrlYBRGlB9KE8gCNzsUXlZ84hdWg42uDY3ch
         qniZDs0GPfw7/nirrzn5b/hEb4PTgH+BUKYAEKs8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.91.182]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MOzwh-1j41gy1XyJ-006P90; Mon, 02
 Mar 2020 09:33:47 +0100
Subject: Re: [v3 0/1] Documentation: bootconfig: Documentation updates
To:     Masami Hiramatsu <mhiramat@kernel.org>, linux-doc@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org
References: <158313621831.3082.9886161529613724376.stgit@devnote2>
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
Message-ID: <98580aa5-e28a-085e-238a-9e9046b1e32e@web.de>
Date:   Mon, 2 Mar 2020 09:33:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <158313621831.3082.9886161529613724376.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Provags-ID: V03:K1:f1jpeUa3a9Vov5UttgPR7jtCBkBeIUKs464OtpldBKtWqhHA+om
 FMCtC80MfagcPZirDKtOvinj+AFR+594J937UZ/bWYTg9gVIcq3dawFER4ZOE+sBq1rTHXS
 TFTmKHIKSYE+fhhJ4bXMPSC1wpnl7skX+ikRfGqQqfDx0SgHAdQjB3UMzLDOmasuYbNGHPI
 ujLJrxnpCyiXgCRffLU2Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SnShIVpZTDc=:wFFEJbvdmsxLHi/DN9bQ1X
 6Hae69SUuQ7l2PPJShDph/OXUfmVrzlenF4oVGDKS3tAllVrnzaAdZUSQwq/KPF2mjPjDCdYa
 APz8i+PiKZrApbnEr5M6QnuDrVZMvhDZiYpAgafpgFGivjwDtYOVRjBP4EhcPTh88R5Z5Dxb2
 vo41N0VZYUOiohuryuOnQ4Bo4wxjqDASXB3pOKZZejC/SVRXGUEPvqM3tpxPT7gq4NKyIAXc0
 sKhSmpj0uEdVfOx+H/bt4F5qkaDyRC/Zs864PGZ168vXZdd0YQAXI0e3vxuKnsrS/HzoU/AT1
 +1XSw2Fk1K9mVtw+q3kpfMBgpvj89P9qtKTCEm3Un6NY6E0tI2Q4xbP775jDZ0HtgWmc657QJ
 ErZxOhn1Xg5Z3jo8lzZPxyxFx9X19dIP5nhs9ihuXh9QrrBlvnYwzPlJBbkEWB/bLkX77VN92
 ZKSKuloIkwjvLlf5b7VbiyJGD+iqXXecYLeGV1pXNW1toU/PwqcGDmSd6Rn83+YM/IP4A6xBp
 HXT/BLdpmA5rf9U9XhXgyevpI/u8JQfAnJCWk12KfzLVwgTQqVgcmOpj0CV7yGxfb79rOn4HE
 gU3A5g6cSXJa7FRQFOlvR7xHBmeiSW7jfDlurhKu+GzEcqHmjDTtApgBmjb5ukXJ/NmGgnJb2
 ld+2uBL1MtkrAq12hgYL6uzT3Tjm7lJSEewM906Tdk1qCXuUNw9R+nzMt6E5Akh4er19GNErF
 6mLN4pMpZ/o6CF42Nxxh3EiErPY7Q85qLh8u8lx2rXoOe064LrXcAJWvVetRCB0kYwq5b7k0C
 Wmr5wW3aWcay/Uemiqdeenjkn9mp2+xSGqcBpqtg9u2kR/eWDeBHvLNTB0IZPdu9y/OA6XfQV
 bdK1c03Lqt955tHbB9df6c3l8XD3PdRAy+q1u0B+a2A3awGdxg0ooEDmbt2WILtEJ6SXu081H
 OeNsnwpuPT1anmar8gLEo0XcGkqraq2KfgNiJv8sPWDmhaGe4kD1d4OXEuk4Fd43HSLw4O2Mb
 wh0dzwnH3y2uVIZSYjj0+YBQGY+PZXgQa/9sHGDpi2UvVQhOhGzRkqP78TlvdZl1yzbVF73lY
 oYlPKKiZrjKLAZugf+xkE/0W0jZAqoIjwgBn7SBkA1Jnfsz88q6vx9G19Z+DSag7YxCiGDEYt
 XFbix2RHHxOTJD7JGUeLGFG8cO9fb/irwn4BAK0SiOveauZT1MXQr2I6Sr8M99SyvPCLirM6r
 NE6MCWaC2rbpS248S
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Here is the 3rd version of the documentation update.

I suggest to omit a cover letter for such information
(according to a single patch).
The repetition of a typo would be also avoided then.

Regards,
Markus
