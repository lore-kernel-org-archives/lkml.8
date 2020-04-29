Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4108BC83004
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 09:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 181482082E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 09:50:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="VelulpLl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgD2Jul (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 05:50:41 -0400
Received: from mout.web.de ([217.72.192.78]:36767 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726366AbgD2Juk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 05:50:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1588153826;
        bh=a6CbGMAGc+Vf6EJfelPcPqhdFFMCY+kGb2T4Bz4GxtU=;
        h=X-UI-Sender-Class:Cc:Subject:From:To:Date;
        b=VelulpLlP8zHSfojwMkwmaqS50/BZyljvAayacWyrjgHWHQWMw/H7WrPbRdd8UxiZ
         oD6KcOihY745j9BOXy+6/N8rFh1OsOo5fSmXI14+ZBGtp3qsed/I5XUwTWFTp6o9Tl
         v+j/AjiZvtrsiIQhu5xV65bnZAhmb8q9Af+7G6sk=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.72.72]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MeUc2-1ivlWI3OgG-00aLYe; Wed, 29
 Apr 2020 11:50:26 +0200
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alan Tull <atull@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Moritz Fischer <mdf@kernel.org>
Subject: Re: [PATCH 1/4 v2] firmware: stratix10-svc: Fix genpool creation
 error handling
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
To:     Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
        Richard Gong <richard.gong@linux.intel.com>
Message-ID: <eb56faac-657a-e977-3be1-5f0a78ca509c@web.de>
Date:   Wed, 29 Apr 2020 11:50:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
X-Provags-ID: V03:K1:g5j7V+WDBUjIV43oP3Ln6D6tZUjNkYCSa8S0Cj1cueG45mkkKtj
 gW2aHESCy/tI63pOaSEqj403YIZzN7sBZuaISpQgdKKCHCoaHFVbKTEmZBCtZCpM4AZOFbX
 aYiChl7lwt6CcTGAp5EBGW3Nt0UsM+hF15TOpDOyV19Z4+yBHlpLOsgDQ62c4NwVy3hjU9d
 RzZNnxKcTTJQWBsmMNYWA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:r5lcZnkRrhY=:ig1bowPbN0zhGW2wizbQ84
 MjHwxJRs6HRLCjK3BGODd762QDfUCDwYmskOOqClqR0HduAmwibAs5fUNDT2gMYdZh5TMAhHN
 jrlmSAA0hb8C9lWiXWbIl4eJoYY+yuSet+21hnldc84bYnyUA72+jBhOZuROefALsz8cWEB8m
 QBlfCHanxnLFwp0RO+OCjqHrURyUV06xSfQeNoPGq/lKAbgKFyHaVm9PUl1Z5U+0x9mzTtNT+
 PLPaPK24g7ufvg9ERJJjnhB7SSDm6L3knElwXUiuiOHw9pGo0ovzRgopoTOjUKrcm693N6QlW
 YrFOoCQfqkIx7b2FGa7KMJtphBp9wXp+LcLHpWaq5vJFSttPUNREdWaTzYPAWHV1R9AYg1HEp
 lKprYgkyFX5MjnWX9kKZLFWJFWRUU0kyXCeT8LXJyGBdgA0eQhTXSF8LhcdqCYTuJUbcSWIdh
 RjveYaWNmPmGDqwVlFuMjbjMc6rUJtOETdLiMIbvdD4QmJBJ/ozA1L+egWkKmlOjmFZ+lze3o
 DSjYJBPmqHTD6Px2LmwrQTzjPeq8dq5BqzD4F4SZ1rYI3LayOy+Ozd3sdtSCE3E3VT01t1XzY
 NeZyJNGf387wp3uoQf9EglDpfEBnb08S0V6HJz+XHrZSMS6KnZmrYalWuto6wrcDBBCycA56+
 xcP7qwGtcqrWKGWAf6/9UdG5c7l+cScqf9GCLuFnRu7Lt+oDqwrDIn/4/83QZtEekiCLGYi5l
 7ohNqTsWfm88AGxOutR7ZRpHbf5kBSW3J2xm75Q6cSYrLIx4jqXmVGHRnmk8jqDWayUhIK9Hj
 l2MYfEr1aMZpfz5McPGk2tdQcMLbtYCJOd5IDlosl3T8KNe5UCilOH6JiC+7jlVm9p4Uzf8uI
 UObhNPeno9M5khrHxjwt8EAPApNHcj+8c21rgrisRFsWOmgQur5hsm7luss15AcYl7thWO8b+
 XS7X2DxHKOPVk4JeBmsACKT9gltrxOUWPLr9qsOX89Meb7oHr/a7G5pOSp55q1lAXUK0jSuht
 ASiI6GE4+qJslOFk2WeTSYW2MKllSc0KkdbTxkefATEXIj85SK8DQnenqABE4h5DvShYf2l5N
 Z4Qg+5WWOnqa3hVWZt9JIIvrlT4msYnkFzzoXlHUoZqELrNcuV09p31aYVlVZUUPON1asNnDj
 hDwxTCd1HBVsuZJdaDViUH9VpIiV7gYbkekikBkqivi3mZv1IEb5I1UzyLOBRrzeqhk6+E/nz
 6XvYqvjX5eBzY//Oz
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 'svc_create_memory_pool()' returns an error pointer on error, not NULL.

Such information is helpful.


> Fix the corresponding test and return value accordingly.
>
> Move the genpool allocation after a few devm_kzalloc in order to ease
> error handling.

How do you think about a wording variant like the following?

   Change description:
   * Use a check of the failure predicate which is documented for
     the svc_create_memory_pool() function in the same source file.

   * Move the genpool allocation behind a few devm_kzalloc() calls
     in order to ease exception handling.

Regards,
Markus
