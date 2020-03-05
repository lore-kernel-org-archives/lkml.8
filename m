Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06590C3F2D7
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 19:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC17A207FD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 19:35:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="BAlRDlol"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbgCETfN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 14:35:13 -0500
Received: from mout.web.de ([217.72.192.78]:59997 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725938AbgCETfM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 14:35:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1583436873;
        bh=Y+cw23oU5ju8MgwfJmBY9T+pEhQ6rykcyk09wwd+ZC8=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=BAlRDlolqJyVm9Y87oocY4Z36g3WBmwAY6FxYTP65ZMRQX/xji/U/j1NLRKpzhfpH
         ag8f1UZ/hCjHxYV5s/awOgRDWcOE4yydJaepk9f0rN1l0LY7kqpIh4tVTlWq/3jAac
         GGppCn+7HSxDA2FKlihzoJUnCTSe8gu62nofhnow=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.16.47]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LvSLn-1jJ7Uo2TUx-010ZLZ; Thu, 05
 Mar 2020 20:34:33 +0100
Subject: Re: [v5] Documentation: bootconfig: Update boot configuration
 documentation
To:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org
References: <158339065180.26602.26457588086834858.stgit@devnote2>
 <158339066140.26602.7533299987467005089.stgit@devnote2>
 <ef820445-25c5-a312-57d4-25ff3b4d08cf@infradead.org>
 <3fb124a6-07d2-7a40-8981-07561aeb3c1e@web.de>
 <f823204d-dcd1-2159-a525-02f15562e1af@infradead.org>
 <29c599ef-991d-a253-9f27-5999fb55b228@web.de>
 <997f73af-dc6c-bc8b-12ba-69270ee4b95d@infradead.org>
 <dbef7b77-945a-585e-12fe-b5e30eb1a6bc@web.de>
 <e20f52a0-e522-c2cf-17a4-384a1f3308bc@infradead.org>
 <ecaffba3-fccd-32ee-763a-a2ec84a65148@web.de>
 <a6a216ce-8e41-ca35-bd65-25bcacde1d28@infradead.org>
 <ac1c953b-fa5d-818d-5232-19a28f52f556@web.de>
 <32047314-c91e-0405-bcfe-43d515128231@infradead.org>
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
Message-ID: <fbc90906-d682-bc04-dd69-1e146ea4d922@web.de>
Date:   Thu, 5 Mar 2020 20:34:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <32047314-c91e-0405-bcfe-43d515128231@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:k34OZIlM4vwSXM7KtmMTah5M3wjWYfF4uOmhIdSvnNAmnvxZNxo
 4pCW+WGwnmM/3ARQoSA/kJ4qhRSwbywYckrbb4Ly5RwjiBaxTKRpxFkbD314iW++IxfggOY
 F9NoB+jW3BE0zlCQj9fMamKeqn8ekkvGKlGfMN/Jt0Pgbr9Kf2fvZj1T/1BaW3vZSY0v1fZ
 2G8fHqZ3xUsgLquQbwy2Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BzeDpvRqatg=:7ujYq07QRKbcNMAHXZQW07
 VsSC4QoSrFvrVlTmdsLGLY1F0khftOCA0p6rt018oS/U0mbyWO712XSiV64mRLBtyneohrREU
 yCtNAgQHZl+6NvOzYGMFUBtY806mWxFdhxJU9aHoWYEi8ln3JJVCtE1RM193YUQYkGUmejt4v
 qYsSSnKtykE+b2j2eO7PD4oYTP+eOmxkAlR4V312UmN5xWFq2nVaatYk2XUvzZovSjyfKin6f
 m1l2Jj4g4pb/WiEFUhAs/kjgftC4/G8kHY3/AedtK1SJBFsxiosioFK1UaPRWKV/JniyxN0cm
 t47XNF7XB2FXvZEZI4pvRlYFra7vjQr/gcASCLUMif6My3w+0b009JNlj1q+Mnj/bN3a0F2W3
 aC8NuHRBEh1fzbWIl/WR3uFwxBsW2DOqgeutHw82vlUhVGtXz0etzJ6wif5YC+c4Vpoda6kgP
 74QKnj8dSJvSQL6n3u7ST5hdYuF4tGYh091c/cANZmAPYUTv1eK+oKPRJUq3sUAzfIwQH5KOx
 adG7SZCu6clP9XXL2rlot9L1QeApDN5jvioVaPnJ7YCEhgPjG7lflei15AjX1bmGrpP+sP7Xd
 xRq1ta9QAb0eZjh7sgFVI5LxzEq3324/sXfYVh2kfqKvfzuBazMqEOctxTE9HVDxtcJYbDUji
 v0EzfqQS4/AGpPkJWdIXmgni4vM3Wm/ETcUq7ULMryAXK/TMK6Py15u64x4FYMf84hxyo0yp9
 mhJQjUScp+3bde+7t2xIrqTDi9Y9APh+Hk6VsUDNl47URvGyJ9JsVANTj6xlCxBSFpuSfPipB
 68v9kuxEhCkZ+mr9TpGyXCspgFeXCCE1+KyaLnLwuLWXJhKxJOq6oVMVWZ3fyp7vrWOBmHcNA
 7EtE81XDfqioMSY+iFcp9MKkIFTEUG7RtKQtQGvu+vIkbMNCCYyPKHCv4ZVhl59ezKlDiKif6
 c+0CF/zuNb3NpjSkYeYLgj1QJ7C1gO5SsNNTeOCoZOhhfn4rrYoowMSi4JYtlNuFx0JQuHU1j
 Aj3H+jn24AVv167eJSAG/3MzCrqZYJ/i1OokurbX+1fmKtlJ4paK4vlXlxF9oCnkWR4e+hVO7
 VOwhdREvbRJASfltvY67D9kt8rdH0I5XX5gxWx9noPUSsQ8HRhMibtr48n02lmFZdNX0llJyr
 5Z7Dhpz8nPXJujMOsQQ7Ay8St1XVJrLnHcm8SCrjj+gq7Yi0E6uj916haaBV8KZWuVUkSVWKO
 go2r+WSOgFTn7Iob+
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> The involved contributors show different response delays, don't they?
>
> That's always the case, in any of the Linux subsystems that I have
> been involved with.

Some delays are usual.

But I can occasionally get the concern that specific constructive feedback
would be overlooked or intentionally ignored.
Such a view would be unfortunate if I would like to achieve further improv=
ements
also around this software.

Regards,
Markus
