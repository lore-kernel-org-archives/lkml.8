Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3EBDC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 12:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE8B4206A5
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 12:00:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="kz1Az3or"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732564AbgFWMAg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 08:00:36 -0400
Received: from mout.web.de ([212.227.15.3]:36901 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732439AbgFWMAf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 08:00:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1592913614;
        bh=gLJ54gf5FX1kd/A/ZRTjkc9o6WemwIW+qh34e+0LKRw=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=kz1Az3orKlWNMWEMMU+5X2yAtJoqN5N4EZ5flWi3Tw3RJSl3s+OoIwfLFWQK8IfJm
         MRSOnUNxcM7dCHgPTsdgP/xAFYB2PypT/c+ULqSjUoTh6tq0nq44UFxmZVolit/RVW
         klNRURxVb2WfsvUTLm2YJYoy7LhX1qow5IepNsBw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.105.198]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mf3ug-1jCit22gzy-00gZZD; Tue, 23
 Jun 2020 14:00:14 +0200
Subject: Re: ARM: imx6: add missing put_device() call in imx6q_suspend_init()
To:     Shawn Guo <shawnguo@kernel.org>, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com
Cc:     Yu Kuai <yukuai3@huawei.com>, Anson Huang <Anson.Huang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Yi Zhang <yi.zhang@huawei.com>,
        kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
References: <cf810c93-297c-c02c-9bba-8c3d097b8e31@web.de>
 <2ab2cc9f-c720-75ca-e20c-0e4236ff45fd@huawei.com>
 <1542979d-f7f6-bcf1-53c3-22b7c076ddc7@web.de> <20200623073220.GV30139@dragon>
 <5300cb30-2243-9bfe-125c-96e720cd1f29@web.de> <20200623110222.GX30139@dragon>
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
Message-ID: <9f429c51-0fa9-16dc-4d62-d456551c5376@web.de>
Date:   Tue, 23 Jun 2020 14:00:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200623110222.GX30139@dragon>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TLCauyD9QkWl4e3WP0XjnoMchGAelOblB0xtckW6z6sNsdFvnNX
 O3lDxwXaeCjfianLHVtw4ogXOrkMAmX1shqZlsiTmYqKk3uryLUx5OEwnj417AtlEm9DHNs
 0FnXArj0aN1LMuqx/1sBT10ODm3en/LHp6CIyW1xRgYl2WAqusjhs8Gey+bFxmpjeG3EQen
 xBKgn720YPRt/k3zdT/Xg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:iNEYmNb4nqk=:RiTJboBvyRp4IwIkR+Yg5Z
 5cRf0QGaKBf+HVBzIFQojDIHgF76CeSS+w2exJe6l4Q4AwhlRsrT4I1Ua6+HDk2tjwCMeibXJ
 INprz8xIcdypJ8M8eAdo82UylxXrzJwflf+pIjHwkqd58kNTDkHsqj6ug8mQHfz5NsDArUc/a
 +Bjrci4Cya87Vssm8QUjbB6UhSV/EeEwl3j+6plvizrcS+oIlNAtNm+1GyQqGX5oGCDOGrKyo
 gwFEdF7ATQ4ToWjuFr8RJRWIoHs7DfBqbQOoO32e6tTAA/kB4e7mMvZpLN59BKFGpdIWO+tDr
 Tf9mwC6ml5vAq/p824h48XPJZjlTY/EuUWl7hkvxokaDa1ErWDzdg8aRtknB8YdgCtlA0N4M5
 RTVyQevcAmUcAlRKQkLEf6UxZaPrSLAIZYfRCX9BesQmt1U5WlsY2ErkjLzCJwpQ0LVl7knH4
 6W//5QGElYw4pAMq6oO2Vs3XockmpJWUN1Na8Hjje22sTE1MpZPrbVrFnfzHuq8byvZH5WbTj
 rrlqF0HIGZ78v1gVnH/yu6coYSQrYLxuEpbkXDaUBC6Sdq605Kx015SZghkZkXCjEGwD90fxv
 /6t9bVWfzgPpWNZgaYRIDo2g65q6tIG4XM/vVuNwHvrxVq8n3K3bl2XsgwiHJWt0HcwctEiTz
 aVudYCWv6pTH7qKcdx32tT+kdEjYWy6ox67UC8FGVSh8qTPqK+FmfGpVepyoZOeG3nrGKBEiD
 XTz53iv7lKF+f44LOHw9lQPN9bqwrpbh4UN9RktTQ9vM1HoNokY1SfHgX/Ncer3qRuM+EomlA
 OpUWvfqwlLdvqgBSnRvNeDA+9UjbBhjsx591adBOf01QcrUUCbnLkOwTSBruP95FgL9shX7Rl
 HsdN4zpNF0w7urlB96c3cSGLfDXmnNMZuKnkBA8DBRqBIpUSY+W8WCl6Sy604V8J6dsgbdZHO
 K01DNb+TQmLVxrFMTMCRLbNYiNSJxM6NRmp0ToNriz8Rpy0UP5LbrCdK8o2JSnnpqmxtIZlDE
 aPkMwME1Dah3OZBgfoBJ1BOdWJc+DAc0rEoTZfZVOFtYO8o7WObAYc2rjNCXEza/OwlBkii7+
 PcIBP5mL18/GfonLoKwUtjRc0NJPRw0rLXFQEbOC61RCHe5yYF0JTy6GYxclPKRAvlia5fvHE
 J5vCLpz/SbpTn6XrPtC7xAYIbULKhRIqNLm77x72znvZYIH1ZqxB3xMC+MWiG/29giVUG1Qos
 fclLYslCgAzJJY7xv
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>>> Do you find a previous update suggestion useful?
>>>>>>
>>>>>> ARM: imx6: Add missing put_device() call in imx6q_suspend_init()
>>>>>> https://lore.kernel.org/linux-arm-kernel/5acd7308-f6e1-4b1e-c744-bb=
2e5fdca1be@web.de/
>>>>>> https://lore.kernel.org/patchwork/patch/1151158/
>>>>>> https://lkml.org/lkml/2019/11/9/125
=E2=80=A6
>> You can get relevant information from the referenced message archive in=
terfaces,
>> can't you?
>
> Well, I'm asking you to resend to make sure the following:
>
>  - Use correct maintainer mailbox address.

Were the selected message recipients appropriate at 2019-11-09?


>  - You still care about the patch.

Partly, yes.


>  - The patch applies to v5.8-rc.

Would you like to try it out if my proposal is still valid?

Does the change approach by Yu Kuai supersede it?

Regards,
Markus
