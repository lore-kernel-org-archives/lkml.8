Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B16C83007
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 11:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B4782073E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 11:51:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="rAgS1+H0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbgD2LvP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 07:51:15 -0400
Received: from mout.web.de ([217.72.192.78]:43245 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726511AbgD2LvK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 07:51:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1588161061;
        bh=YpG1Yk8wmgaxNXrdr0JLTCB7c7Q4uVrpM9UhSdIBYOs=;
        h=X-UI-Sender-Class:Cc:Subject:From:To:Date;
        b=rAgS1+H0wd1XqkisItHDnCIAe+A6HN7f+tJb1OlAhT8aXYr6sBt8M4X9Z2uGGJoZm
         zfK60EWDrq8/VpeE1vF7/7ksRox6uFg6+pun2s4r+FouwJlqmgh/8w9C8zrugaLGik
         SbQJjRbOSNnLfrD0znoccBLyXLWD1eU2PXAxcKo8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.72.72]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MKM5t-1jkSeA2Krv-00LyCD; Wed, 29
 Apr 2020 13:51:01 +0200
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alan Tull <atull@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Moritz Fischer <mdf@kernel.org>
Subject: Re: [PATCH 3/4 v2] firmware: stratix10-svc: Fix some error handling
 paths in stratix10_svc_drv_probe()
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
Message-ID: <767eb869-d9c1-757b-77a6-79927728ddcd@web.de>
Date:   Wed, 29 Apr 2020 13:51:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:R438sIDxeezX+deWXb3VHlaMCT5XQYYNt1edkyHRb0Aa41E25XI
 Fp16ZddXsuacSbwMdOkv1+tz1w76mMhNc3DUmQVq7GRfW1nVyYhbXLvYUgkWzjpP71xAI1E
 fM4KxzxDKvbsxTrAx8KnJhgB2Q4QBJMPlDOw5yfH3T3vEZQKbR7M03CqV6L0MD6cHfM4HCv
 mik3Ota2s+XdmMdSvwHOw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:X3yf3c0YaFo=:zvBU3T/SXtDugAATfcBv7X
 ZSRcj04b6C1uwPSIyJIhAdOLjXCoCwglZlpYcW9JyMC82WDoAuuUyAjSg/rXSchqjfqaxvNwc
 ISu2QXlv2AL5qO4oN+7k5Fmacmrmo4lW++xCwBuKTVITyeRI5hRhQOFjDngz6KmthIW3Nf+zn
 wvGkOdnOoZX2h2utFSNuXhtRxnhklL+shm+oByiCLsLBBAFsiI3vdnj6Zxm31Mu9OnSzi1tCK
 JbYCZJD1Mr+dq8++2HSHpd43X3R9zj3eOO79QE9JTTLWlIVSFA/gVI42l1/UNRY3Co4hErrzc
 bTRnbH//DjYB4DlCNpxv6omnuA51YoxbUGCHiCbdUSCSUjkUNCz9KUCklzRFUjUC16aVfBp56
 0feDUovAnKzezQsLeSLlGQoqu/nEsc2Jvf/86ZgY7zp7QZAFl96NtaBxwP8TqNpnwHPeFkWQU
 5roIDKhTi9RRoifDgowMZQwGox3fB3rGpe3nPYjK/FLMyg4WrN55HabE6gS9wNiu0TqeRn6l6
 DCw/uSsLEo4f4tzMYdrON7u1ea1tc31dKph5Q31LnEYkNIyevEZBxcevdIMxaF12z6fojUSuF
 W0uQ8+RBQQuQAnU0NPhBzKOl8izm8+wYyelOJVLaJ80LW/LxArNU6/Z56gDwh39aNbBZ7jCX8
 eeFxms68zFHkKp6Cd4HYR7c1vUTlko/wJpeQBd9/7YW+8ve9uqodShke4hVF8spD/gnNd81A4
 dnkTmzL5ncOlUi3TGsElxIBmoS9qlrygHKxNedMosdnY0WSebAFFrt8/btMJnLEnNJpR0W8Nq
 IAS8AcIO9hawTjRpWsZJRW14rPTknnSLqlXCC0jE2XHyPh0NfG3adBAAR51jvSs+RGXaBdfF6
 lRwNxTf8++GSJ6ZX8kOyxCcnx44So/wl9nzCy6VPpC83lhmK8FwQI4D/mwfL27l3C4kmSPCrn
 DCwsJpdA+fw6Hn2gplN70/zPFHlmMkyQes1bcU0G0WfmDvTZRaoacvZvPAccifVN2AlUDUuWZ
 Qita64llx6n+YpE66CmfYmVDAve8NKb7gh5t0mi1rGYIScM74cga3E9Gs9BjZ4MY/Ec4J3pO3
 Cy4FuaDfoQbQ94i/wlGbvdlvfK5PyCPFZGWIuzUJIFJ0tvtW/t1+J5AWp2/gi8FfqzK42MsM8
 V0E5GVqzVOZ2TrFPf0pmzaJd5Px+53x0M2HzY/Hrp48fn6VL7P38PrPcXMO1RpeWK7zbFe8jT
 R7kDXj/F9ncnLE4kh
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> While at it, also move a 'platform_device_put()' call to the error handl=
ing path.

How do you think about to use the message =E2=80=9CComplete exception hand=
ling
in stratix10_svc_drv_probe()=E2=80=9D in the final commit subject?


=E2=80=A6
> +++ b/drivers/firmware/stratix10-svc.c
=E2=80=A6
> @@ -1043,24 +1043,34 @@  static int stratix10_svc_drv_probe(struct platf=
orm_device *pdev)
=E2=80=A6
> +	return 0;
> +
> +put_platform:
> +	platform_device_put(svc->stratix10_svc_rsu);
> +err_free_kfifo:
=E2=80=A6
>  	return ret;
>  }


Can the label =E2=80=9Cerr_put_device=E2=80=9D be more appropriate for the=
 improved
function implementation?
(Or: Would you like to omit the prefix =E2=80=9Cerr_=E2=80=9D for these ju=
mp targets?)

Regards,
Markus
