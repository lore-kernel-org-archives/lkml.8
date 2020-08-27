Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5171C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 14:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60FBC22B4B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 14:49:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="FMWxyd/5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbgH0Otl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 10:49:41 -0400
Received: from mout.gmx.net ([212.227.17.20]:34275 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728085AbgH0N6U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 09:58:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1598536675;
        bh=uLRcuAAqrW07F82sdCLeqyG0DIS6eSFEXsO8Otq5bp0=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=FMWxyd/5iXXZPguaf7EKjRwG2pjmyud5WcYyk5d3zmTSl1E2kVEtgswydUbWAt04Z
         8whhoWHz9f7gggJOApBoe6DI8hk0D1uoa+2+VlVqXkZOBwpaI+QdTaDwzmZ7ISMzCt
         /lWrLkydxD3exYUwBPVQJ1TD9EVe88Yg0XBedEHc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [217.61.146.7] ([217.61.146.7]) by web-mail.gmx.net
 (3c-app-gmx-bap26.server.lan [172.19.172.96]) (via HTTP); Thu, 27 Aug 2020
 15:57:55 +0200
MIME-Version: 1.0
Message-ID: <trinity-b7618ae5-0917-4595-81bb-51764215b02e-1598536674992@3c-app-gmx-bap26>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        HS Liao <hs.liao@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: Aw: [PATCH v2] maiblox: mediatek: Fix handling of
 platform_get_irq() error
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 27 Aug 2020 15:57:55 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <20200827073128.28389-1-krzk@kernel.org>
References: <20200827073128.28389-1-krzk@kernel.org>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:drKYd56QSglEjBuE+8kuiQEXMZ69EFTHi5u/RppsCaMnl2/1bzI+ad4TQuZM0LpPqMNI+
 bExz9I1CKtGN34wjU1YyJSm3LBeYZfKsPeRgTyXRClOF+OWGliHzwAXMA+ay1Ks7D+mPHiPtHbzU
 K7Ew5QronW1DJL7BgSoozF64nGFtmUs1gN1Q5Cbmsj8D0iZBWQ2GkaBGD7vwnwyTTRp23etWN1fV
 Ala6BRWTs6AQTtgkQcNxFsGd2VeHOX+wQYRIBHc5NbPtEQ8KWzYB2777+aCB41SXzFtjx0nnZ5ZM
 cU=
X-UI-Out-Filterresults: notjunk:1;V03:K0:2UK820SKAxA=:vbeSVlKXwhbcN7oKajiC5U
 3CJwxk7wBAzk3AXJ4fc/GGxrx0mzp2YROODrLeVB01H8r8bEJ23+5MulE1Ya5ThF7nVZ7jLTZ
 5EiwmTD2uL6xoIeSjnTo2N8uXwX+EDBa+Vf7DjGjovmwmPJSwYT3l7B7C8VAMa0QmefAgtdJm
 MNkzCWPjV/iUVAPqn5iXJxWmfHXNpnF/aQB+EsaWo2IsE66zAOajIpC+rjprzr4gHKxAXWK/0
 OO0l6eTS1Rvo4f12zHnTFBWjbI7qQwJEF4Y8bWRZhVPEJdx43zBAmRtmIGtB7Yhla4+3bShHl
 76oyFO5bXPD1zVEF712nAZt8Jgp8RS962sDTjuPScKUif2LNz3n82zW879xdCez4RIZ078KJ2
 xuhG4IeYbs37Lb0kZe5yTXCvDP1QD24XVIKUErRXVxncixl8dsLNlMSKAy4usz4pryMEl7BGB
 2WmbN4ZAXtxo01PUsBXfzJGRf0Ved7eZ4tmOdUGWUv+t4NuxofjC65l6Cl+ICE0O0EQVuyN46
 ZcMftG9E3nVtZiZFtrnGg4q5lySvnzklOZARVkgkvvfpSw+QSKF6p0GUlzgfSf7mceFbbLj2i
 p6c8wm1ft4WIYm3WQnSjnyr6vF5Zu3X4daci59TJY9OTbQYV6/Q22eIXWsdUxBfVT4OdQfEMI
 1s8InPqms8jiow8NwjVs8pWSKhTtdnBQPXJT5gKWBQYM80ZgjcY+ervVV67nAAhWV1rk=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Gesendet: Donnerstag, 27. August 2020 um 09:31 Uhr
> Von: "Krzysztof Kozlowski" <krzk@kernel.org>
> Betreff: [PATCH v2] maiblox: mediatek: Fix handling of platform_get_irq() error

typo in subject i guess it should be "mailbox"

regards Frank
