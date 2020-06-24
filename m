Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5138C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 14:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF92A2072E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 14:27:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="cYrRGeN4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391218AbgFXO1H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 10:27:07 -0400
Received: from mout.web.de ([212.227.17.12]:44549 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390354AbgFXO1F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 10:27:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1593008806;
        bh=+397ZodF22IJ1lX0UUU+QUdgNBlkxA27jR0G02LjR8E=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=cYrRGeN4v6RbI1QG/gRvMDNr8rmDVZuXPfD/XOt1n9TD1Y1MBhyj/0UnhfeSemQ3d
         O2fTgPO7F9WjoGfStJ5N1Kdy2wlmQJZIdfSp3O1BtFgaJ63HkTr9Y6f1h8dN+a+cXD
         8XujKUvVCEGX+hGQOXWrPaKqqiZ0YV5jCynNPU0M=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.175.204]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MlsKH-1j5Nfp2rvH-00izOm; Wed, 24
 Jun 2020 16:26:46 +0200
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
 <9f429c51-0fa9-16dc-4d62-d456551c5376@web.de> <20200623120919.GE30139@dragon>
 <66038b6c-6691-eda2-af15-f315270d4bee@web.de>
 <CAJBJ56J9NfYPxnqtLfbeCHkRy2-xPEUJq7r3RvM8yi434AQF2Q@mail.gmail.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <770ba40a-920a-19c6-10bf-74c8a9739596@web.de>
Date:   Wed, 24 Jun 2020 16:26:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAJBJ56J9NfYPxnqtLfbeCHkRy2-xPEUJq7r3RvM8yi434AQF2Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XOu8O0fpQr9G6QZtu2pezJQOj6uZ6obszTrGI2zNv0rgYzIURgb
 TmVn8SwGiCoX5xd/au2DZqG7m8SlsMjkOQRP1K5kHcTtevUT306zxCg89tujgVp5elDUpZ4
 /pkKu5DDLMJ9cWKrowfAgVUAgMnZX/F+3Sh9DdYjhKaYSmRBBDw8YOwb3RysNn56Eee4gov
 Le9OUUTaSzSyYAD5mGfGg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2X4ZSdEPDYE=:sIYr4G2hRFc+LVH3NxAqCe
 aEFNnsSem2KWTcDvr2pS800Ks8PGqQQP3yy5JHJ90AtL0STWFtOQiD2WbOT+k5V2/ZQDWHvtB
 LQYGq3D78ktFZwr+g3nreICSixHgoQGqSAcuhLztzRf5NAGjuc95HkO/maOjFuq6shc70o3+5
 Oy7js/Eyy6cGMUuNGJxcv1K0ZIcDIxnALkq58cVnAcFP2wOJrmwYJeMDMsOex0PJ1TBXh7y5I
 gJA0w/fpxJYA08vOT8XNVbMRhFMKkfLXtoJqcwMqSX8GX6jOjHuNF5ygBAEE8WDMptc5jyKE7
 QJlJtmaWwdZyyYIAW17+Puu+oxDBPT9Pa/Zy8yd5ynaqTjilJbw6FgaiXXeMQAn3at8PiCFpw
 4q+EVIqDp6e7uNzQ6yixv9/F10HjECZzejHKFTDy2z5G4Wub871jJ2mbnoT9LCWALp/OJx2gX
 BCZ15Tg328YK/3y4jmboS4bNEwG/+FPSS/14aNEMNDHaTnedS3txkIJAqVz+NFGcGzXDB3RD3
 3vmXMF89Yg6wD8i406Jdi/EEceAQsVkqEBNlRLE1EZUY8DxDZFew9QP0A4Gs7QzZIGs0fxEcW
 qCccI5najdPpt2bpFEwTLFvoXvSUayEsSV3Mrau4ahEosIxysUW233HxKWyU3iM6GLxH5uI2U
 /bC+/5PEsn+/Au9Eh0xsR7Xt88YYIwUUxV47OLfbb0b/sGYwBdsZO7sfWh949pXl+voiU3ke4
 wuOqplDLOiOrLWQRXmHlxmeQNqZ4NG2QByeOfzMLrJn1LkUPfwv86W6fMcqB8+O4tCugehxQn
 dDMB5Jl30HBMO2EgbBLbukhaFrPr5H8WEA1Xi7FDlSgVDJgQsoO7oBt0+YSNekSH4AYdwtmQm
 7VRc2aTFpcUPZbr3UWIHGg54ym0whMAbqbQjJC91IMdnHjNtEWQNCrVf479bH1IS+CDCmW1gL
 gO+nXY3rK/sesNMxF0WNbQ/6Wcn47hs+zeowhAhdtsECOo7MYldirq+X9u40hGkejZrriCa9L
 xS9BBk1qeCsgvg9hLsoI+641PcpPpGWo6ak6AxuriiCvY8sevF8QAtCg9V1gFVPb2ELXk973x
 wN+oQ7jhHoXRHpZb0B2Gp8EbJRsJ+qsIbCvOGfk0viysTPpPYgvEAi79e9v5CjgacQ5XtS7Fq
 4dHeYHMa4zTV5l7iLdCEX6ATF1xzgvVYPhEvLKWAjOkYGpMJXllIjOp/j/oCb0Gi6ObgLRGer
 2j36MLn5i4WkFKZcX
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> Are you going to compare the published patches any further?
=E2=80=A6
>> Which patch variant will be integrated finally?
>
> Just picked up Yu Kuai's patch.

Is it interesting anyhow that you committed a change description
which contained a typo (on 2020-06-23 20:11:30 +0800)?
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit=
/arch/arm/mach-imx/pm-imx6.c?id=3D0f92519843a05e97b58c6076edb23d747e8be262

Would it have been helpful to add the tag =E2=80=9CFixes=E2=80=9D?

Regards,
Markus
