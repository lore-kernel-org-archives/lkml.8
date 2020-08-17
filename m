Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9656C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 15:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84634204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 15:08:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="b7Gx4SkJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729078AbgHQPIu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 11:08:50 -0400
Received: from mout.gmx.net ([212.227.15.19]:54295 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728651AbgHQPIr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:08:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1597676911;
        bh=Tetm6JInZyBDPvWpZyx4Zp5MeGuNToXdO2B+0rlr2c0=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=b7Gx4SkJsN3G34LQ0lOtp/HuetKQZ3xoFOMLFewMlt2SszYYyEbiCiJ+aYgIJ9A3h
         KeImU+Jb8whaJPVnzNWEpk22n4ws1HFruzNELLdr1YPyXOMXfKosSOmIizCZgJTmY4
         p/LEz9UmZ6DOiKdqkds4psfXNCW9sEM63QSmSQO4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [217.61.148.252] ([217.61.148.252]) by web-mail.gmx.net
 (3c-app-gmx-bs07.server.lan [172.19.170.56]) (via HTTP); Mon, 17 Aug 2020
 17:08:31 +0200
MIME-Version: 1.0
Message-ID: <trinity-6aabe11a-b5c2-40ef-b51a-8ec7df0ceeab-1597676911685@3c-app-gmx-bs07>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Enric Balletbo Serra <eballetbo@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>
Subject: Aw: Re: [BUG] 5.9-rc1 broken bootup on mt7622/mt7623
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 17 Aug 2020 17:08:31 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <CAFqH_510ykRd=79hUKbK5k8fqWzt=wri6=-Mv1zvV8inquPmPg@mail.gmail.com>
References: <trinity-e15639c2-d077-4b70-b351-a5888543688c-1597675629284@3c-app-gmx-bs07>
 <CAFqH_510ykRd=79hUKbK5k8fqWzt=wri6=-Mv1zvV8inquPmPg@mail.gmail.com>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:HMLEtvM6sRxHZoQ2yEJ+S/HCggZRutCRqRB3gWpNs9fNkRRhnce6wVt0k1ubkP7P7J0H0
 L0UGHovEALXabrUq5hA1ErKMeGadAW4cewhQ+fJ7RpuetY0QH+5VOcszl3Z1YePqGzwaeslRjQfi
 FCQElwZxnaIpFHnMeTE9Biwzx4lVdE+WuH6THYA55Bc2xRmRM1N5k7HdJhPWtWWynXvT4l1ZnZqo
 s3eu9KU5f8+O5OtlhX28P2+ptXhFWKtRhD/ipo78Dp2LgpDXcJH5C4kJsatFQ1tS7YpagjrJ6OnW
 tQ=
X-UI-Out-Filterresults: notjunk:1;V03:K0:wPXiVH+jU1o=:SO2j5ZAePwOK4Uxo8o0Kj8
 yUr9siyuEmJShS3Xmr6ez0fmkRkChzow26II8un7ZXMHP9HPVDBX8mhso69nNkoNPy0542i4c
 H3R8rqz1OKMSvYsQp1dV2/961VXZaSjaJ4ZDYQb6DLz7ITySwFaegO7/CLytiXbV1DwoQbdgF
 Y6yQr3PEc78lH2IiLYXbID3x3lvng06x2up7nYQlwv4vRf6HEpDWGS3B2M2VVXH1tNcApZ1WB
 9vuLKXVSxReBayDMZ2CWyg+rtWV3Tv26KEgdqQvKb/sM/sCOsjp1ad1Ex/pZk6EcCOtrwdNMS
 71yAkg6vjeB5GV84EvR/W6xpkX31BaLnj6GCQP+3cBbzReQpfbnIJmr/Qcv9ip5nHyoBtFS5q
 D45edwMSH+dgKIXEn4ercvfjHGUffoHEtpE6Yz59Il9IQTmssJ5pZDGbIc4VBXBZpC73e2EBm
 YZ/cgz3nFd+jzUk0UKbW/L90iFK41ONEcDReV06RbVDrE1sMqzOYSZTDQsOI2uZi7/CE0Lp8K
 UGapEvGntHAFk0G+EoBA4/q+hdI5adkzlqTs7se5naMb35nFAPwqJFL+B46lP6fOrZb2CWP/n
 8NcAtEEu12vSPzNmLI70asolVOsrt61YQ4QLWv201H81Bb6tIYsPIoOsaWeBD31mxOzrFMjNF
 vbYm4qf2+vxKlmHadJwVfcS+7vZkZ6MlgKDDqawbLp+PGjpkyKqfnfHy6BAgwozbC90M=
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enric

> Gesendet: Montag, 17. August 2020 um 16:56 Uhr
> Von: "Enric Balletbo Serra" <eballetbo@gmail.com>
> Looks like all Mediatek devices are broken, you should try if this [1]
> fixes the issue for you. It fixes for me.
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.gi=
t/commit/?h=3Dirq/irqchip-next&id=3D7828a3ef8646fb2e69ed45616c8453a037ca78=
67

This seems to fix the issue on my 2 devices too

Thank you

regards Frank
