Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FEEAC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 10:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10C602067B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 10:16:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="Vvu0MyIu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbgFEKP7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 06:15:59 -0400
Received: from mout.web.de ([212.227.15.4]:38527 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725926AbgFEKP6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 06:15:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1591352135;
        bh=yywBzy7IlBWWqUGaVS7rm8tbU8bXI8UdPAJ+F0kmUj4=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Vvu0MyIu6xVTOYAe9zDtUv+kec47dbOdiXep7f6LIpmGNTONfLEUBZLtkZ/yAFbCx
         OH12vfyMef45sVDuIPcZV/dtrnqJOf/jNswCSefsQq6z80+L4jqU99hkl+bSRd7A1A
         O6iaJfHctkj4G2yBbubPfswIL620GH/jOKdX/vwI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.102.114]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MQ6KJ-1jcSI93dlj-005JbL; Fri, 05
 Jun 2020 12:15:35 +0200
Subject: Re: ARM: imx6: add missing put_device() call in imx6q_suspend_init()
To:     Yu Kuai <yukuai3@huawei.com>, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com
Cc:     Anson Huang <Anson.Huang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Yi Zhang <yi.zhang@huawei.com>,
        kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
References: <cf810c93-297c-c02c-9bba-8c3d097b8e31@web.de>
 <2ab2cc9f-c720-75ca-e20c-0e4236ff45fd@huawei.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <1542979d-f7f6-bcf1-53c3-22b7c076ddc7@web.de>
Date:   Fri, 5 Jun 2020 12:15:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <2ab2cc9f-c720-75ca-e20c-0e4236ff45fd@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0FVJtvCytfg6Zx3l+WMfAdoOjp+2WiI53dYtZZSuTjDfkVgvGI4
 f16OD0Rbg5e4QGrXvwyxZOksKyvXRxLGebS4sB223RpVz/IM5SZGbr242LpeX1dQYoQxNsq
 ldsHC5egVY+Q7Su+J17N2OZERoj9eLOJu0KeY1YuijVKDWA/XczIU+3s4PtmKVI81ZD92ip
 xgLI24aShTvvJpgcmrmwQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gWzO+9+zM+4=:5ZtYMkGn6cTqu4NEjAigx4
 IQALEt6wTL5Mxz/Pe2SgLW3S1E5boEY5R7ji7YfeJlOyYBzOwZsRwULAf0EWPuvQXY+5QErSd
 1FbJ/EvJKsdQ57Pz0eHu6MyerGB2lgQNLpZGyhMWbEwPb970Lj/W8hNAzXqi9kegYJURxuwPi
 6xzQ/Tu12l9JmIoUyk/xhuAliXZaYObVp3jur+/BwEjwR3Y9TSv9MTv70OJWAXXMT0bTawjsQ
 0YgJgL3Sf9qVPjz+LgXn3h/7Y/km7oEElbxo0FxsvgBM8m5lwC0OEeC7d3ruhd3rpkt4YFVOu
 czjKdmnSinemmP5vqcppklpzYJQWkxuql1EOne8yk1jFvtSNgn7+PG7xWdMAg4GNrPppuqmkr
 i8u9PRCeH7vh9ihm3uJYvs25EauneuMIUzv7qJMxvHOkaqILm4Gg5EGbHOBDou3OnbTEpWMi4
 YXaYhpTfih/exSVKRlaCD23tV4yiLvD8BxFC8tDM1BBKgt0QgpCm2jppwpxKyKIAV3o0ccuw/
 LSVtHIqBdux5BxpZ7BUsPd8POr7CbE0UQgQOZECi289FNi9/p10YyQOQE02DJP67dC8jnxco8
 1lgf4rTZygu0DNiNe9Mu4G3U16P0kkXjEqVTi1cZCSh9Q3dyrsgIHVvp2p06yo27K5Ow5fEl0
 YJf3P2uhvABCoK6tQdCHSNL8Nj+1pBd9NthikLtVZF6wZRTfGYMmfdFGbK1Y91nZ6OSLYoiTV
 Iu8nZeSJdyiTupQsQ/Iop08ToOGRi1bWrob57unM0qkqsDGZcI809R4fI2/Ot5H++HdNeGyaO
 3WyJxMOmbMpwpglwIzWnXM0ZOLBazGGK386cEMa9X8tvi9GFHNw+bcOpH4Sqe0qvUAGRMFicI
 WkrvBR8hnm+1K/yol1PFY+N7sU4dMOvW6MPI4cQEmSWt/e0wQpaInYClvvh6p2OZ3VISbFnTZ
 ukLptyZDk8wL/impQAQPiIwgrr9lIldhLMnIwmCsNyqeCc/GNjHECxXXhMWKQlFOMYm8Tzdf5
 KITVoYcyrp8z6+y6DOJvHrON8dMdtJsCVY17iQlVB0/sCJCRKUIteTFSlCe6zRtNLfK29Lw/R
 /l4GKwmhqO1Hb/zQh0JLdneRvs+pGLL4k3idJ9XAFf3pjH3yufp4VkZjhUxt1WXDRDec0Qwjz
 0ReCFNFuMFmE1YCw6Gk7J3TH9Y3FOhJQIGSLCjIFzAG8/gfmII2YTNnw3H2ubUdvkZJpZCLXu
 nVsBQ1d2agAzE57Yl
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> Do you find a previous update suggestion useful?
>>
>> ARM: imx6: Add missing put_device() call in imx6q_suspend_init()
>> https://lore.kernel.org/linux-arm-kernel/5acd7308-f6e1-4b1e-c744-bb2e5f=
dca1be@web.de/
>> https://lore.kernel.org/patchwork/patch/1151158/
>> https://lkml.org/lkml/2019/11/9/125
=E2=80=A6
> It is useful indeed.

Thanks for your positive feedback.


> Although I didn't run cocci script, since it can produce too many false =
result
> which is hard to filter out.

Would you like to clarify any corresponding software analysis options?


> BTW, I see you haver done the work already, I guess I won't send any pat=
ches
> related to 'missing put_device after of_find_device_by_node()'.

You may continue also with contributions in such a direction.
I would like to point out that other developers occasionally got into the =
mood
to improve implementation details in similar ways already.


> Any idea why these pathes didn't get applied ?

I can make assumptions about the reasons for the possibly questionable han=
dling
of such patches.

Regards,
Markus
