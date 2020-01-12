Return-Path: <SRS0=/A4t=3B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F21C3C32771
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 08:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA46921744
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 08:49:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="rAgB3ZOv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732491AbgALItd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jan 2020 03:49:33 -0500
Received: from mout.web.de ([212.227.17.11]:40621 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732455AbgALItd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jan 2020 03:49:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1578818954;
        bh=f1QBqnYPuaIKVAY7RjaM0dJz++/NWxiHFOmYiFZYFkw=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=rAgB3ZOvhJONFH+oxsqdk/kMhxSv/DT9ghv+wYCY7fpsQ+dvpei5OOIQhyK2UnBTN
         VU+jFjMLpDiyvZZxOJyhoeZ05Yuqs15IpQCa+mtjLd+mWujWfbj/HMJxAmcs9LOFK2
         QPyC6XahKHhs2hDDSo645UKX95Y4hPH9ep6zH0kw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.29.244]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LkhFg-1jQiZ41Pbo-00aWdd; Sun, 12
 Jan 2020 09:49:14 +0100
Subject: Re: [v3] coccinelle: semantic patch to check for inappropriate
 do_div() calls
To:     Julia Lawall <julia.lawall@inria.fr>,
        Wen Yang <wenyang@linux.alibaba.com>, cocci@systeme.lip6.fr
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        =?UTF-8?Q?Matthias_M=c3=a4nnich?= <maennich@google.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20200110131526.60180-1-wenyang@linux.alibaba.com>
 <6cc0c851-7a32-d82a-1c0c-51a08538b445@web.de>
 <alpine.DEB.2.21.2001120941270.2552@hadrien>
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
Message-ID: <e9adf168-0833-730d-485e-354562e13f8f@web.de>
Date:   Sun, 12 Jan 2020 09:49:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2001120941270.2552@hadrien>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Provags-ID: V03:K1:zRxj0U26jIzyDN70pEizIO+Xchc+YgYNVofsKWwlcGhNwYGcE7n
 4afbHru5IOHWnXTEyP21B8qd0+FmhB2RwaGaexhTUv0bfdo3EqeOE0akxCe+FWzTbxZbz9a
 lsN91pDPaiLdj8TTgNELRygqa+HUl7bi0F4vUVkezJ9EiH28nXOQsJ2GlLB6SFnt//4r2TS
 Ut7zvzF53r5oIo7hNmmRw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JRd4nyrYGZQ=:OCGx5uogC6tlYhroOb2kmz
 2EP0Et5EdzXh627zGkOcdGq8FyX/7aIU/Ww4upKRrDHTKDXSgNPR1kbfBAdyuiO6UyvXZFkUZ
 GEPUQZzhSwNcT1aeMD8omJxs162+qjLYuremvr1ZsChzox3+VK+yACPaw9vwzbnhbZ1zurf98
 pCnUsk5DxEt6O2D+zxkJxfkpBzAIetENFClgwJZfzidOAIn9wEYqLC1RHYIXWKsferM+SKlis
 LrmqPuZrW/ZQfRrZB1+xd70l1IeWsy46VP7Dbsdwi2gSAeXsXLcRVh++dMcMMGHVlQ4dFVscJ
 lURYKXsQ5iOa64Zqg89kYuGTIy6dLi6eCaZOP9a+GJgOn9Ly9RKDZQq6TWJrThjg9eQAyySNP
 i5GyacphZenhsfCPJhcSt/PlD+1rGGdRguL0rTNb5HNvEoeJdhdyszQO90kYCGAosVBeceCnw
 QKSkVUwVvB+k4RDmv+aeNxVglvqSW3nlIRSPxjqs4Vk23j44dq/v9ha4emnhxZiSo9QvZwa58
 wkFqEt7nfARRRjqwVpBBbNTGoeG5rc7RjvyPV4sAnyPABGv9BPR9E8HPvoxVpFMTGduLGvhI4
 vdCNaNYC4RjWAvdDPqIxmZ6GePrnocjY/VZm6DPiZDnpwKQVTBjVMB+gDkumhH0vzBFzqEeA0
 B4UbppPzteQgU4zgPIr18qqn5O+CTxnpVk4BANFe0ovE5tVUfPrgdUk1IDseX4jM6milLGbo2
 bV4IWeG+JGXuWTpAQLvCLmEItyOzIKJupUAyoaVfKPmWY01m4J7s6VOqdFVT5mgnqoHh+JdTl
 82zaTxWXtkpMDDxLuvMUGH03yIOhVRTT1qt+xVIQZ1VdA349xrgnIS3WpNOSc6K/6CGZQxdCi
 LDfT3Q1A0rTXy7KtHykjnKgdcVW46W4voWDnbnd5o4NysWROzz2S2PJNSnxLKjgHiP9F3Qecj
 EMrw494LmANqB9lzOyv0VrsCbOoLzcoY3VO5FAcdUreaJgMwIRKPOT2grmdgkd8a61ruO16jD
 a5i618UvRfwFsVv7PqN+vd4e9dmqIQlS5mtXkNEKDiQPVtkNRm+ogqctYQ+cCq2ULOXFfS47m
 xNRB1imWhG8fX7/akToU02yUMsR29w3PZky1BPmJ64Ulh/OnYpb0vtkwXMXbESYLlB6SzA6OU
 fuTu//d8MvBeIrHeZ5Kqtr5kfoPZgzzajN9FedasiqbzDDIEQQJeIMs/h8I/SmLdCjzkMqKfx
 ba32yiWo3xu0U5/lNqnWcy/5IW4NsbSzYVJnCPkLmTRvWQC17OOYj8FHGpwM=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I see no reason why such a wording would imply such a thing.

Thus I suggest once more to improve the distinction between patching
and the description of source code searches in the commit message.

Regards,
Markus
