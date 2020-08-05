Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2091EC433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 08:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EABC42177B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 08:51:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="PQ7H44NK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbgHEIvQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 04:51:16 -0400
Received: from mout.gmx.net ([212.227.17.20]:44637 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725868AbgHEIvK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 04:51:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1596617396;
        bh=KouBFqPcVdY/N2jpqO+a5lVPiMqUcEXz0mYKHefvmGY=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=PQ7H44NKYk24ie8whky4P/jtvHI4A3RB5Ggj+HPlOdWg5moXiKOsEEGJf26zYDqDb
         vfED0TdDZhJ8LzdqPusAOPTY3PjZlnRWwDXRTRL3WrRN/o33l55OP1BrQfiw01gADm
         1uMXYlTYrbbNv4yza3AzyOVWCPWSwEzUrIiCb/Lk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [80.208.209.197] ([80.208.209.197]) by web-mail.gmx.net
 (3c-app-gmx-bap13.server.lan [172.19.172.83]) (via HTTP); Wed, 5 Aug 2020
 10:49:56 +0200
MIME-Version: 1.0
Message-ID: <trinity-35b75199-be7e-4e56-bfc9-1d8bf7075df1-1596617396324@3c-app-gmx-bap13>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        chunhui dai <chunhui.dai@mediatek.com>,
        David Airlie <airlied@linux.ie>,
        Sean Wang <sean.wang@mediatek.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        CK Hu <ck.hu@mediatek.com>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        linux-mediatek@lists.infradead.org,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Frank Wunderlich <linux@fw-web.de>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Aw: Re:  Re:  Re: [PATCH v4 6/6] arm: dts: mt7623: add display
 subsystem related device nodes
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 5 Aug 2020 10:49:56 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <bde8de134f59c4375e4048faf124c61af0b95920.camel@infradead.org>
References: <20200804165555.75159-1-linux@fw-web.de>
 <20200804165555.75159-8-linux@fw-web.de>
 <3966b4f687f2fabf9041059dd5f39165177a6ef6.camel@infradead.org>
 <trinity-5335a61e-b8f0-4441-9fe9-0827cdd67ce4-1596562816887@3c-app-gmx-bap28>
 <45d34c6cc19c2e5c13f9e88a8e04bdae9259ffdc.camel@infradead.org>
 <trinity-16cee263-ff59-4595-adc1-738071745162-1596612461427@3c-app-gmx-bap13>
 <bde8de134f59c4375e4048faf124c61af0b95920.camel@infradead.org>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:02+hrQwIbNKgot54dm3HJDNKjTwKbsyfpioUZ2s9RwWRJQMTA7VOZRh/pL3a9UGoFVTCN
 ERILIMlNaDjkc2TrLP6Gpib+y9jm1gT93Gao0qy6TOyS7ZY5Pcmiwa/hFmqqBw0sETOOim7kdheu
 QrkKaZxd7kwCxWiPRVRs9Pmzo8H/6Yf7oVgLuRlm1LNtnp20Z0bybSKu/XlUT6O3aPAOSAKdTtL+
 Z5whKcy09j+dZ6HoVVNVfUZGSTZ1QRskLbtCPoKU8es+a/aXSpcl6T8dUGYxw6dTA/aBrl0rZfzX
 vE=
X-UI-Out-Filterresults: notjunk:1;V03:K0:sGV1u3BLYEs=:ZmeFvu+MGFu42w9/0EZtNz
 y3ygbRJ/gxvzAKmPS0TDo3EqFrrvRTbvlEgmMQphdULdqverfTtQWhDOvuYX4H9XeTbDYHICh
 1u4nPRhU8LkBfK3OQmKDaFH52AsaQoUPcpNmMFqfXgT2zismRqV4YY/DzhRedSMjbW/LXFX5O
 9f7pJWQR/dzVelZFUa6ktefaFla1rztZfdhFaUoCMkM/6daiFmBOTW6BxP/PfcS581BqmFRvx
 kBqCAOKJN3+cXCFP/xnHMSZfPHlzY1hmvATTKLz+Y6VCSnJ6vCcbjujVUjEkqCOECZCpHjjBK
 3MxKUsIb53GKhcCQWbS+t+6c3lhZCuevgl0ISDshpHINWCIIdvqpAT1qPqihdu1YoVeSAp4jw
 qpdG3elw3uN2wUkYCF+804pajrgO7t0IJ2JaUJHEQ3tV8xrUkA4ENN5dv+PNeOdwh9n0Mvbxw
 HwPEJ0/j3unee2GpYuPG46ZIuA4LU/8RQKdQFDvxzD6Z4WJkDHwiEWinthNXCbpy1tivg3VnK
 5tc8jHH4eOvtsmFzG/AOh4Yib9Ts2ifF3dEcLYDT1k8/baNDPqKIs4fB/HH5zU+LVNg4mcTNr
 /ZZMS/yynDp3VUr5tkPcQ3aiIHtJO7vWqHYKlM9Z65CMilYkQFILL6kJHjWVbrET0GuGryUdz
 MLqM6V6DDQqqyb4nxNRY5/s21N7uiwhZIw6BDbNtXsFaj0hWdzTMhVOzfin8up3/DNLI=
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Gesendet: Mittwoch, 05. August 2020 um 10:36 Uhr
> Von: "David Woodhouse" <dwmw2@infradead.org>

> > mt7623.dtsi =3D> mt7623n.dtsi =3D> mt7623n-bananapi-bpi-r2.dts
> > mt7623.dtsi =3D> mt7623a.dtsi =3D> mt7623a-unielec-u7623.dts (not exis=
ting yet,
> > openwrt seems to use a board-specific dtsi)
>
> Yes, I think we should.

i want to see what MTK/DT owner says to this...
my current way will be still adding the nodes to existing mt7623.dtsi (lik=
e ryder lee did it in original patch)
but disabling them to not break mt7623a and splitting it afterwards.

> I'll create mt7623a.dtsi and upstream the U7623 support; I think that
> can happen without conflicting with anything you do.
>
> I note that the GPU node has been added to mt7623.dtsi in 5.8 too;
> that'll want to move to the new mt7623n.dtsi that you create, along
> with your other new additions.

i guess mali-node also needs to be moved to mt7623n.dtsi, so my current wa=
y seems right...
but it's decision of MTK/DT owner. if they make a note i squash the disabl=
ing-commit into this and post v5

regards Frank
