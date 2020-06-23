Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2360C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 12:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBF6B2078A
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 12:29:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="UeQTNy5F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732578AbgFWM3G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 08:29:06 -0400
Received: from mout.web.de ([212.227.15.14]:58801 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732439AbgFWM3F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 08:29:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1592915317;
        bh=pf17BNJe1KZRs8kCWby1n88PkWar9NN4f2i7eVBPuhY=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=UeQTNy5FjtBHRkdrornC0NqV34h3CtL5HNpao11/8vNAlEDhbfAsqPKyvgGniiASS
         IKa3h8tIKPy/fZM/uPrsDsGSDZv6/VFmcHV7/GkoloviWZHfOVOcYfEYvejzHKe0Tp
         aRduBazShWm4TRa49jjm3a7eNsSfzjSVmIF2Y7Y4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.105.198]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LxfMB-1ilwMh40wF-017A72; Tue, 23
 Jun 2020 14:28:37 +0200
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
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <66038b6c-6691-eda2-af15-f315270d4bee@web.de>
Date:   Tue, 23 Jun 2020 14:28:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200623120919.GE30139@dragon>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jMfjx0OrVHUcFyvGT1xpqOpSfzKGr+2mdH4Rnc0vbMS9ioYCdHK
 l9lDzgsqVxHLPwc50beo22oBdbVFJ4BcVvyTtV5VGxGu4Pw9j8N6sF7ow7hp72u3ReVD+kA
 XpZ5vw8Vp/kYosGzK083jV6AuxitvLpdoPdaXrJQk24qBhByu7kgigZ2Bp34KpOXbNefXyt
 bPwkvw34r3PnGcGICOuAg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pVgOBwNJUbY=:+0IxEXbOKf/2g2N52AqwlU
 UrGQGHo9sFgTedJARXajm14a3O/xavguFvbd3SHp4HD3Z3nYULiqVJbb92ftbF24PIOmI5dH3
 0L4prF6kEmuf1ARx3ZUbJmFIign8e58EKOM7ykFApPzsB0xu8u4wPrEM4gdz6YuGs523R76+/
 q/ayBCnDi2/qUw6J/l2kArQp6SzFLvqW6sybxkQtIzPBr2oDog7aEnvL6uED27d9b8PJNuVWZ
 qI5cjy/VtI8j085bqM6Muy6XzG+UeGout5P4H2PvDRIq0ABXUB2MEfXG8uUiLMLD9njJfR2GL
 GR3aLzHDs62oe5LSSHbHzMgHkFQz83tyb4AAOe1kREQ3hNxoZ8Ul+DSJ9dQYkDvf5QSYGUM7Q
 vcDpgzpgEjsK+oyxtaClzSNrb6A2GeRblHTOXAhrPMCbLvTm5jkeIBz1Al/pq62nVDYUwzqYx
 e5QY+r8REAR+epkjPMlZcbbhhUh1bwZw0dD/f/H4Ca9oAwNOtBYLuvfP72UC3HJ1Cdxn2MmOK
 gqCwKhuOYcDCFL2CaRvQRytuK2w6V9tIxv2nxFmnx8b5/2jZtoWRpFTBrtbOczcLVl6KFSzVj
 SGLxdLI5X5cEMXaDNZu+EK1TFx403OipAjiPEIFSaylfvQmBJr79HT6q+/6VWIl+M7vIH3IbY
 RA0RVSBqp3EnZAg5SXspNB3+tgtDKBJs8Fpf6n0XUF8/K4TZykHIHJQkgfIQNZ7iRra90TDeq
 pW8csJF4n9tp2voDYjUfQK6z1wqs9GLZ28qz68YM/s5h5or999XWf2BsFedHhB8GP2jNLf9wf
 HW1rHDXqCYPFQtM2VxUs1Za1xr8WfyCg9WbvLNLr/FgX4o8VC2qI6nnPi3u3EEyFj8+8UoeWP
 JN3V1aZIY+0hDEpmHq773w7irur9xQ4efqbjPX0aXL9luooYn6+2yhqbO1o+j2azHOWWJjeqF
 QQ32F+K4ovHQ5SdfRp75mfGLiVFmrNiNYeoSOU51j0M7eh6rszQrq3ud2ZqM8wU/jw/eav2l8
 vW8aZLUzkxqViMXTBIsUDaoqzSGP1oFO5tmswe17ep+pC4wHvzHPZUOq9Q1UoWlhjC2EKOuxR
 1/wB+3SgNkxO758k1pJF1DvkO+862MhDtKHEMFLosiUvT+DDmBeg27QdpVVEyMr2ldTu9TmP5
 h+hkT2R1r8ChbLUg52DbqPjpIHKN6uB1zmzXUceUAlyCyFEY0HDjkdT7vvk8gie6sCpGdxKw8
 Vuks7q/a9G3ALjiw8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>>>>> ARM: imx6: Add missing put_device() call in imx6q_suspend_init()
>>>>>>>> https://lore.kernel.org/linux-arm-kernel/5acd7308-f6e1-4b1e-c744-=
bb2e5fdca1be@web.de/
>>>>>>>> https://lore.kernel.org/patchwork/patch/1151158/
>>>>>>>> https://lkml.org/lkml/2019/11/9/125
=E2=80=A6
>>>  - The patch applies to v5.8-rc.
>>
>> Would you like to try it out if my proposal is still valid?

Are you going to compare the published patches any further?


>> Does the change approach by Yu Kuai supersede it?

Which patch variant will be integrated finally?

Regards,
Markus
