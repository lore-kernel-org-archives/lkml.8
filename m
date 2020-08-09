Return-Path: <SRS0=dnKw=BT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5038C433E1
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 07:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3AC9206C0
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 07:22:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="JN1c5gPk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgHIHWb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Aug 2020 03:22:31 -0400
Received: from mout.gmx.net ([212.227.15.19]:50745 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725710AbgHIHWa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Aug 2020 03:22:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1596957732;
        bh=Ufa1u1M+5bfMDK9Ye7gYRHBggJJfXwVAm6B1GwwGHn0=;
        h=X-UI-Sender-Class:Date:In-Reply-To:References:Subject:Reply-to:To:
         CC:From;
        b=JN1c5gPkbSMDS3AuVB/mkGhzPEHGlalH9zHg41MUb+e9ga3Fpj5TnRYeTjuToicNc
         T518lKuczJP0pyeVTixAKClgtNaDfEt6fMpqA1HVkrQBJGlNKz9VaruJ2aPhKsRwuD
         7nxawJrckCXpi1UGH+YKWvrvBm+qa4apG7kSWA6o=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from frank-s9 ([217.61.157.211]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MwQT9-1ku1OI3gc1-00sNVR; Sun, 09
 Aug 2020 09:22:12 +0200
Date:   Sun, 09 Aug 2020 09:21:37 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <CAAOTY_9o_hBWxWBdDoeeJ6zuV4rb4R_yEoN5+L0uHBGMw4Kduw@mail.gmail.com>
References: <20200807082754.6790-1-linux@fw-web.de> <20200807082754.6790-2-linux@fw-web.de> <trinity-f5a5deb1-c123-44d7-b7ca-1f7a8dbe1c1c-1596889651064@3c-app-gmx-bap69> <CAAOTY_9o_hBWxWBdDoeeJ6zuV4rb4R_yEoN5+L0uHBGMw4Kduw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/2] arm: dts: mt7623: move more display-related nodes to mt7623n.dtsi
Reply-to: frank-w@public-files.de
To:     linux-mediatek@lists.infradead.org,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
CC:     devicetree@vger.kernel.org, Ryder Lee <ryder.lee@mediatek.com>,
        chunkuang Hu <chunkuang.hu@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Frank Wunderlich <linux@fw-web.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
From:   Frank Wunderlich <frank-w@public-files.de>
Message-ID: <81DFA743-B455-498F-B2F2-161DD9D51F57@public-files.de>
X-Provags-ID: V03:K1:n2qOhvlM6adm2ED7/EAyQ9chstcoSUaBCZ6wyxFwFq1RLFhTUfN
 JDFDMl3ZckGfptmX8EU7AWQ5a/C5hfkiCJcgo5CYN1C2VLc/SvVXPD92osy8F6WnQzX0p6y
 l1VZ0dlWhqt4KFi7bhGjuMIACuBFx1fEsKbMyCjE9HAasMx3UhhcXbeZbuIZLdgeynxXGXa
 Qhwd1J0BrPeTGElNAOS6g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lifgRDGqB34=:OmQNACUUwo1xm4dOfYmlUB
 zZdCiwyN7n6DAkLrAHIaZXWygE6qWAzGHzQIiKsQcUFa2IIJ3A7gxA2zobcJsr/FyOyK7NR4W
 QRNjcFgjCi65aEU1CIwsGYABgKWhOf0Z54ch9223vHJCGBPT4M2AC3wc8gidlKR0mvQTJa8Pk
 z5dpKKJiOAEDJzMR8STuMefGushGSdmVYEvvgZW+EzacyjJZPKpi0SBp8IUe6eszRXNgUTDel
 1ajlpTnxaa9soh4ndFfb1HQlIEgNcIFLktADeqosOKvbbcOvagCXh3mSppXT6LgQEVy5oAKUq
 6s6fnG4aHWQEnse4rOHoUYUUR1PaNpUxtdJMSoPOZzZly2RWz8jvngjLR7qoCmpzITTIQaSDI
 cW/B8msV0KDUNfIJUvlJxC0g1i5pAx/mYHu9H4PrcSftO4uhlMmAWe3uW+DZ6NFaHGuYvJw89
 Pb/iRc9P9s/yE2Joz6vdEdj48xGVWgJIuSczmIPtBerHm/hREU2DDkZjf5yLePuTsLUpakxx9
 SVBud/WWBiJy7ekIXan1LB/9nFOKa3PJjPfHXISX3dbZaMqiuf25gwhG4vctmsdAA45lxlBug
 uvY2b9VFm1A7O3jYfk5cp18BLo/ITDUPJaUuc4ANRAhHmItB7UpbzmlvCJn2j87r5qpM4BpwB
 C9wnSFy/saWUU3hJqCkxCfx5zLLSC7G94TdVXmKQmJAqCgf6sQH6ZdShm5rLkwvuMb0U34Q8U
 VoOTsc9ASDHeFR+Ayo373wU1LBJ/L/YcdZUfU3vTIXRlGjF20T3DR4xv2wkWSbUZCbfcoiioo
 YMOCwevjieGo1PLUD4kiZQxELWj355gF5ygEErN1a1sfBYDbE6V9YsnU8lh7p5YzDQvDAjI7L
 beIX6GTgYxQUbyo+Pap1OUK+YpcUXOzW2eRw7ptxWCIB14EvdIKhZ4j2YPx1jYsellgkzZJ45
 UH+VSVMPwlUHjm9MKbpaks1QS88Tku7fjc7CywsjytUoGAcJgf76zh60AmWogQyB8453xaSgn
 NWFED5MBmqEZjfo0oAH49bGCi/OqF4e4+LDedcZEuJDkhD0S4/OiRu8Jk9KoMeqA2P6Dxo4im
 S7wFeYsdubB1a74cq0VriEyJBMbWHrm93gT/wWY7jKtxfbc/yiqmfQn1tjor8Jl9mjnYxUsQS
 /dt3wa4/GTeD9RnzCrfB38epnDx2VFcGY0QgTdZJczaAXzxjJYyVawufDMOb+kHRgOxFHwXzs
 BU8qrhYAke+JTu1NKozIp6No4H1dmk2mPfE/1zw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 9=2E August 2020 02:16:59 MESZ schrieb Chun-Kuang Hu <chunkuang=2Ehu@ke=
rnel=2Eorg>:
>
>I would like to put all device in mt7623=2Edtsi with some device's
>status is "disabled" and change its status in platform dtsi=2E
>I would like to see all device in mt7623=2Edtsi because of its name=2E If
>you move some device to platform dtsi, we would trace all platform
>dtsi to find out how many device in mt7623=2E One day a new platform
>enable different devices, you would reorganize all these platform
>dtsi?

Ok,then i change the dts-patch from hdmi-series to disable all nodes and e=
nabling them in bpi-r2 dts=2E Do they need to be in alphabetical order (or =
any other)?

Is the tmds Patch ok? (because review missing) https://patchwork=2Ekernel=
=2Eorg/patch/11700679/

Just to know before reposting series as v5 :)
regards Frank
