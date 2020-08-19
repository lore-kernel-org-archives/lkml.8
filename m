Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD81C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 19:06:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0228207DA
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 19:06:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="bdMbnkNI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgHSTGK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 15:06:10 -0400
Received: from mout.gmx.net ([212.227.15.15]:49165 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725804AbgHSTGJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 15:06:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1597863902;
        bh=ovNaBxbYuzERcRwnFXmf/W5lE2dfM3JaLykQcJudcuE=;
        h=X-UI-Sender-Class:Date:In-Reply-To:References:Subject:Reply-to:To:
         CC:From;
        b=bdMbnkNIepzXEgyh3n8sy47pdmdX70kObSQeW0yMDIfcEe4XpjqY064tbWon6A2N3
         KxYwJMQdSauS2vFXfCTS93bMwoj5vfznrVXVmzMSyBybAA7NKJLKoaP9bVPPyDDNm8
         qLB41IXHM4enMR9nbxSD9/sXx2LBSOFHa/mMxp48=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from frank-s9 ([185.76.97.101]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MmULr-1kYhLD0Egz-00iQta; Wed, 19
 Aug 2020 21:05:02 +0200
Date:   Wed, 19 Aug 2020 21:04:55 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <f68cf4c2-6c79-fe46-b7b4-bcc49e0b6b69@gmail.com>
References: <20200819081752.4805-1-linux@fw-web.de> <20200819081752.4805-4-linux@fw-web.de> <f68cf4c2-6c79-fe46-b7b4-bcc49e0b6b69@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5 3/7] drm/mediatek: disable tmds on mt2701
Reply-to: frank-w@public-files.de
To:     linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Frank Wunderlich <linux@fw-web.de>
CC:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        chunhui dai <chunhui.dai@mediatek.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org
From:   Frank Wunderlich <frank-w@public-files.de>
Message-ID: <0E911554-482A-47C2-B2C6-136486C5ACB5@public-files.de>
X-Provags-ID: V03:K1:I1SQA8RLE1ho3CZGRQd83x4wiGBSFj41+sUykOdSORmkkaF6OAt
 LPaLS/DxLwr1BK9smzW08UYet6YtujrlLy/ipTjGyg26bR8OGsQswRLSDPc+hIp/4vhJM9/
 eP7n24GYoCV/19w6QRWwlGTAp2W2A/7MpXBFp7OBhIOqWgJw+YlUSuj5RB+fC7Icw5fuBLt
 YSsIWMLrNHtWZkdwk1Tcg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hM7lBukaAW4=:CEJojBvwJkGCGXTG2lIpE8
 qqfIoeuayh/LUZ7eLwfsZBSeWfTFByKvHnqNwTu5SS1b1+2pxdGvEwLnq0F60o5Hyeg0jnXsG
 YIRLLOkINYWzeutnZRpXeU1dfGrAn5gvHIgWfVkhq7tMWH7oRi/D5w7JZI0VUOy6+wuMIFagK
 CAl2CGZ3d+30CYn5+uWGWAI226LTZZQDF6sGYPPPtHuYnYkE+q9UDwpcj14vpT90uj/CROSUt
 OV0gU+6Dkw/+UbJ5PJsGjrbqf+aRZAWLaRViyqwO1f2APuFeVdCSLvs0oVusZNoE/EQkzpOnn
 MBVwtxj2MGeoVIDDCcVjLLT2pyMMqA+zc4Ld/WaLtb/Yt6xTCzl3cuO+91lKb7eRhIq92+rRZ
 SXJ+j6crZLjxopx2A9Q3AfISnjKfU42DdHivnasEumIZWQ/5EqRiTsVHne//Qihj9oKab+j+H
 PcJkZPYhTGbWUoOFWDvBgikpweeMCqVxZrQ7mhSFgHmjuG23NbX/5yO05CEy683klPIHyBFsm
 2xXNvxwXkXM+KiIyVpMYohuyThzhQ4cAWvhR5iXfH4N0TnDBnZ1CUBSmLV26iVeZ/Fw7rYJWV
 9oTQU1awJG00fAXYkwJMf9JBNsi5Dibw3zPtGgAW224Z6McMpKLTacvRMslcfjrBcCcwHHy1w
 RmEqoj7jgzV7E6BemDUXcgOdKrT9EeQdSDnJgqOR5SgLPU/Qgg3cFmgsM299mlkhAeL1wu7wY
 iJL8jl0TPOgQf8EC6ucFdzhQux707spxIkI9BEV22qnigJADlOO1Q5RAw2HL90MW3kKrogNqW
 8JA8hwi4yTA96H4YqufKBTi022ntxeLbbK1yvXd4HL2TbrEuYsWpF2+T985F8a+uYzZeB4RFb
 pU6AEf/oOUIlTm+MCmGKqtMJ+BOUSu2cBubfT8Zaf1cLNuADJr1FiU/xhaXsHTJ4JHqIxfKqP
 h0I2QRlcceJB1L222KeKl8n6OU3GjwCmevs44a07IrrSvUzAWEoXpO5qBlE9nLx79Oe3UMAdz
 ou5YC4tnoQyVOJoCGQGaiCiLSsl/0sJL4ZCdbQT188vjbUgoj/EmXChYChD36O8264XnnE1Tm
 mffDeHqOyoU/3aqD8JA08EqRjeEYG//7VXnBlRqAC2iAgKdFUkQW2YWv5w76DoIp41GaU3M6W
 83pTUrrUJblnfytprXQU2WGeg3WNC/bj+WDnnpm5BzYQdamMoSagKAJWf75qOX/ApjfK0uaan
 Hemx9WgrZ3pNWdFhnZQqwrTb7lwJo840EqA7fuQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 19=2E August 2020 19:12:29 MESZ schrieb Matthias Brugger <matthias=2Ebg=
g@gmail=2Ecom>:

>Isn't that worth a Fixes tag?

This could be

https://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/torvalds/linux=2Egit/c=
ommit/?id=3D0fc721b2968e3cadec520c60d2fc63498d865055 (add support for mt270=
1/mt7623)=2E

It uses existing framework which calls mtk_hdmi_phy_enable_tmds by default=
 in mtk_hdmi_phy_power_on=2E

Another way to fix it maybe not enabling it (use the flag in mtk_hdmi_phy_=
power_on) there instead of disabling after enabling it=2E

Maybe this is less hacky than current way (as ck hu pointed in v2)=2E
regards Frank
