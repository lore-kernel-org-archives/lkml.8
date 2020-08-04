Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD5FEC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 14:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5BB52075D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 14:44:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="dYrylRTK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728749AbgHDOol (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 10:44:41 -0400
Received: from mout.gmx.net ([212.227.17.20]:39535 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725932AbgHDOoj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 10:44:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1596552262;
        bh=M74RPzCRuh0utMrP2KavnbtPD979HoMyUkUEHnxdnJs=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=dYrylRTKVRIaRg43Q7R8dFGXyUIuT65S2ps9pSJ4yruv+Jj3pkeAH4uh7lQ3AiF5J
         RZY5f5j8oZLknIonBki5iU8pX8szlaQZHqJrh0eoZf430MnNzgt2PevIm7M8B2Z/rk
         kucm7ikTNfyF7pyzfBBdHb7KJrw9fpXiacUOMQXw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [217.61.144.119] ([217.61.144.119]) by web-mail.gmx.net
 (3c-app-gmx-bap28.server.lan [172.19.172.98]) (via HTTP); Tue, 4 Aug 2020
 16:44:22 +0200
MIME-Version: 1.0
Message-ID: <trinity-5e5aa82a-c026-4138-9f33-d3776710eb47-1596552262328@3c-app-gmx-bap28>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     Frank Wunderlich <linux@fw-web.de>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Aw: Re: [PATCH v3 1/5] drm: mediatek: add ddp routing for mt7623
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 4 Aug 2020 16:44:22 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <CAAOTY_94Kt3Z4FhB+1Chca-tanzY1Xwun8D2ZQ09Y7p7+Jw40Q@mail.gmail.com>
References: <20200804105849.70876-1-linux@fw-web.de>
 <20200804105849.70876-2-linux@fw-web.de>
 <CAAOTY_94Kt3Z4FhB+1Chca-tanzY1Xwun8D2ZQ09Y7p7+Jw40Q@mail.gmail.com>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:K4vr5xLllernAPYxqzkou0b7G3SwErhkjcivj32wkp1hhhjwRwbRXU4j/Bnwcf5k5o44V
 fsU3r3SIxaDuuJpR4PyfEoLEzHoXnaAyzRA8Tu+cILYk7+t+UiHnn0KvLmJdN6igayqfcQE6XJTg
 JwRCXhLqPRdkwKLIo/RcogO0U3xXRKiMhCJZ7afFIIgokPJ9TUrZZJyZBPiFjdk6ZCcnHunNUSip
 kLsOMsNzIukx5LMmkNfHryQwKkcp9Ed/Pe4ioIs36Vjxj2zSdUfHqI3Qbdnni1PJrvnD2OLCMI3r
 KE=
X-UI-Out-Filterresults: notjunk:1;V03:K0:49jcVtSXYUo=:DnAfsV9jgGCpqHD/1MAphF
 hYDUK8odWLBafkI6/tiA/6/C/AOvtCBjZPxJ8SwaQDLBoUjTDioKsGr8dykcCu1vfJh5uPoz1
 JQxyOT9C+JlN4cdP4EyjbG+Mk9CSDBNNJZe0wFI66xx/TotpXuYXgjdoZL/gCb+7vOOZhsOs3
 C0TsuGjF6oz6UVbpWQ0b6ht4H5cc+redjzkrzA/IQF+ZAE991FUb1NWvu1Dqdg4gNUNK4TJxg
 l1oJ7KXNSWzg/syEbOiF18opnTiuIdbSZM5Mj5TwOTw++8V6Rp6swHdRtBnBVuFbMzUnEmI/G
 9aZrLD0oeJsOt/GDancoHAJkzptPKlAUsSjCRdgrZBGbNW/GZB8zNp1P9Q6+SKbjEiujlQpIK
 8VqiJSUXmuVcKjDa381e27es8qbxEh4iTDKT58m5Y0zRZtk6+6eiuSeZJLcpMQOaOv0esbK2p
 MJqvwYhbwrB464E8dJmf3xFJFmBQe0aOg50D2shEcJ57UVUmCDnD/p2z4vCZEJPtmZMnKCgNo
 UnNI3xIvdjp/vmKHUpDPzWMrqdxIBoAhsaJH1jPmr7QnCEoiES2Ku0vCyjvULGkhNb/cTd3vn
 ECawz2iJJJzz12wPpGAEz0S4Iytm1dgiYFDEtfKC7oYrNOX7fu2argrmV1tzDOLN7UcinTaHV
 oIL7Iy8c9qOb/YpbBfCo0DC0C/eTMNxYZsjLy0AOg14NRCRyi42ZIOrJi4VSrodip04Q=
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Gesendet: Dienstag, 04. August 2020 um 16:34 Uhr
> Von: "Chun-Kuang Hu" <chunkuang.hu@kernel.org>

> > -static const enum mtk_ddp_comp_id mt2712_mtk_ddp_main[] =3D {
> > +static enum mtk_ddp_comp_id mt2712_mtk_ddp_main[] =3D {
>
> Why do you remove 'const'?

was removed by previous patch and not re-added (revert failed), sorry. wil=
l fix in next version, if all other is ok.

regards Frank
