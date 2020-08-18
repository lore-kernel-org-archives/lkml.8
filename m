Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D87E2C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 15:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAC0C207DA
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 15:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597764237;
	bh=HpQrw3dSRuULmu7pAjgDli/38IUo+15Aerb5BtWgGbk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=SbRjC8DvB++egpweAnswLatVXCcoWTbAXqykT48Il316qXI6v2RnLnS6UHHP0LW7r
	 g5yn8p5CnSYA73uPiAWrU393pH/7kGaVs9/2AbV3ZYFMPagPglrpgswUEM5rRVYd61
	 JGPxejJJUAoNq5rb4C2NaM0yL87/RGdlmPKLrh4M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbgHRPX4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 11:23:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:49288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726630AbgHRPXu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 11:23:50 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2DF5206DA;
        Tue, 18 Aug 2020 15:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597764229;
        bh=HpQrw3dSRuULmu7pAjgDli/38IUo+15Aerb5BtWgGbk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=zXJGw6+41RMiXqsi8HA1lcWAoe+ELCgZ+17PvoyKTcUMnCSfLrCqiTnRF7HlVDJx8
         Fkmv01FEVd4DxYxtfM35x8srBSm73NzP0cIc225181ZGgDcujUtT8OJpY61N0gx2Ft
         UuhvzcaHhJLMEIC1K6oh5TaKhBgDMaqEuVCdSoGE=
Date:   Tue, 18 Aug 2020 08:23:47 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Landen Chao <landen.chao@mediatek.com>
Cc:     <andrew@lunn.ch>, <f.fainelli@gmail.com>,
        <vivien.didelot@savoirfairelinux.com>, <matthias.bgg@gmail.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <davem@davemloft.net>,
        <sean.wang@mediatek.com>, <opensource@vdorst.com>,
        <frank-w@public-files.de>, <dqfext@gmail.com>
Subject: Re: [PATCH net-next v2 5/7] net: dsa: mt7530: Add the support of
 MT7531 switch
Message-ID: <20200818082347.353fe926@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <e980fda45e0fb478f55e72765643bb641f352c65.1597729692.git.landen.chao@mediatek.com>
References: <cover.1597729692.git.landen.chao@mediatek.com>
        <e980fda45e0fb478f55e72765643bb641f352c65.1597729692.git.landen.chao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Aug 2020 15:14:10 +0800 Landen Chao wrote:
> Add new support for MT7531:
>=20
> MT7531 is the next generation of MT7530. It is also a 7-ports switch with
> 5 giga embedded phys, 2 cpu ports, and the same MAC logic of MT7530. Cpu
> port 6 only supports SGMII interface. Cpu port 5 supports either RGMII
> or SGMII in different HW sku. Due to SGMII interface support, pll, and
> pad setting are different from MT7530. This patch adds different initial
> setting, and SGMII phylink handlers of MT7531.
>=20
> MT7531 SGMII interface can be configured in following mode:
> - 'SGMII AN mode' with in-band negotiation capability
>     which is compatible with PHY_INTERFACE_MODE_SGMII.
> - 'SGMII force mode' without in-bnad negotiation
>     which is compatible with 10B/8B encoding of
>     PHY_INTERFACE_MODE_1000BASEX with fixed full-duplex and fixed pause.
> - 2.5 times faster clocked 'SGMII force mode' without in-bnad negotiation
>     which is compatible with 10B/8B encoding of
>     PHY_INTERFACE_MODE_2500BASEX with fixed full-duplex and fixed pause.
>=20
> Signed-off-by: Landen Chao <landen.chao@mediatek.com>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>

Please fix these W=3D1 warnings:

../drivers/net/dsa/mt7530.c:1976:1: warning: no previous prototype for =E2=
=80=98mt7531_sgmii_link_up_force=E2=80=99 [-Wmissing-prototypes]
 1976 | mt7531_sgmii_link_up_force(struct dsa_switch *ds, int port,
      | ^~~~~~~~~~~~~~~~~~~~~~~~~~
../drivers/net/dsa/mt7530.c:2081:6: warning: no previous prototype for =E2=
=80=98mt7531_sgmii_restart_an=E2=80=99 [-Wmissing-prototypes]
 2081 | void mt7531_sgmii_restart_an(struct dsa_switch *ds, int port)
      |      ^~~~~~~~~~~~~~~~~~~~~~~
../drivers/net/dsa/mt7530.c:1976:1: warning: symbol 'mt7531_sgmii_link_up_f=
orce' was not declared. Should it be static?
../drivers/net/dsa/mt7530.c:2081:6: warning: symbol 'mt7531_sgmii_restart_a=
n' was not declared. Should it be static?
