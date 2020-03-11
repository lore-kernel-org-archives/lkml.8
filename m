Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 122CAC0044D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 18:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8533206BE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 18:54:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ivqedFCm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730985AbgCKSyF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 14:54:05 -0400
Received: from mail-eopbgr70055.outbound.protection.outlook.com ([40.107.7.55]:6990
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730799AbgCKSyE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 14:54:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BJz43VyAZkD9THS7ekaFpjGwjJPNZt61B8Ar4u3Mlx5ogTXqipINciOl4cEtMEjLXI+9i9UZZ2e5LqagBRkkrJywGBZAwqGFVTd7W461x84gBqmHuKpJ/WT0zPmrSeYQ58PE92DlABxShqMuen8RCyCsct7eKW695MquMPKdkAbJ+Hz810W3W5+0JGOXNEASNsZc0TfmMF+xWWuJHjF2jFgNWSs3/GsRxzI98M2t0Qk/Vn91Sh7vim2EeImmKaV+jrdAa3lXiKISxWfTtRiRFZRHgz3tfepfpZJXDrIzrnUP52IhHf2MNCbL9DHWldDgz+nO0GNcLV23cQdQ/YyCBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TT/mhrumhx/kPJ+Qzls4qcJ5p9rq3U2CQATIhES8/bU=;
 b=Kge+2wKo+LOdOwNHTZGyWSMTyw22hG4+wx/27FWdbDakwbxUjQub7ux+HwFwJdrUPGF1atMcwxeaaIOTELEgyA5LYn0xDz+ScyaBzg4050xNy+VJQHoIICDeeAPAQADAe3bbfTdL5d3MSC0Dqxjdrc8dEsGfKFGYDVLIZ7OnSJpxi9eY58EW8D3z1vRUaGE3BeIu+c3D+4FTI+coY0fiTiwIbpHAXiZZDV+wtQuSeiZbRo82O805rXsIS63U1JWtyD4WVOQXmTgZ0YJdDie5igYKO4n7xB2Kl90CIgJXuCdzPrmVKnsHaXqaljTctONe6UW2PrGunjeRFa4eB1Gsgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TT/mhrumhx/kPJ+Qzls4qcJ5p9rq3U2CQATIhES8/bU=;
 b=ivqedFCmGxJILbwlBHuwH9695KqBcywX5xeiyjj6pg+6nbcDtmQ6DC04+mLQSetDP58m1OMS8KFM9E1zaWdxL7QphWtER8mDxJw0i1/ErlPt0ainkWS/5KqtuGSCgZQS0jVno7biC53MHZg57rb7CK5M0HKdoZOyvHQXmtMtrZY=
Received: from VE1PR04MB6687.eurprd04.prod.outlook.com (20.179.234.30) by
 VE1PR04MB6446.eurprd04.prod.outlook.com (20.179.233.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.16; Wed, 11 Mar 2020 18:54:01 +0000
Received: from VE1PR04MB6687.eurprd04.prod.outlook.com
 ([fe80::b896:5bc0:c4dd:bd23]) by VE1PR04MB6687.eurprd04.prod.outlook.com
 ([fe80::b896:5bc0:c4dd:bd23%2]) with mapi id 15.20.2814.007; Wed, 11 Mar 2020
 18:54:01 +0000
From:   Leo Li <leoyang.li@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 07/15] arm64: defconfig: Enable QorIQ cpufreq driver
Thread-Topic: [PATCH 07/15] arm64: defconfig: Enable QorIQ cpufreq driver
Thread-Index: AQHV62dVL2g/wtlvM02iwpLe9+E/l6hDAT2AgADUc2A=
Date:   Wed, 11 Mar 2020 18:54:00 +0000
Message-ID: <VE1PR04MB66873A9B6773FFBF96F37C6B8FFC0@VE1PR04MB6687.eurprd04.prod.outlook.com>
References: <1582585690-463-1-git-send-email-leoyang.li@nxp.com>
 <1582585690-463-8-git-send-email-leoyang.li@nxp.com>
 <20200311061220.GB29269@dragon>
In-Reply-To: <20200311061220.GB29269@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leoyang.li@nxp.com; 
x-originating-ip: [136.49.234.194]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0cc9e7c3-8e39-469f-5a3d-08d7c5ed9000
x-ms-traffictypediagnostic: VE1PR04MB6446:
x-microsoft-antispam-prvs: <VE1PR04MB64462FCD5B19BB32A73750278FFC0@VE1PR04MB6446.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-forefront-prvs: 0339F89554
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(39860400002)(396003)(376002)(346002)(199004)(81156014)(55016002)(8676002)(52536014)(81166006)(66556008)(64756008)(9686003)(66476007)(76116006)(66446008)(71200400001)(66946007)(5660300002)(8936002)(86362001)(26005)(33656002)(316002)(2906002)(54906003)(966005)(7696005)(4326008)(6916009)(186003)(53546011)(6506007)(45080400002)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR04MB6446;H:VE1PR04MB6687.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qjmSUFgSpmC2U7TGBhSJ5rLFOD4UnqtMK0wpdJKn5F5gGUaX+wuVsSP3C+GT496kA+pNVmXtO49cWzrBSF8I4t9wlZhzravffIolZmtOXr9iuHLpaJyqewqM6YAdD58Ghu0E5UCHgzTTU/lXyGdyXe8wFWT+4ArfVyQcXAl98iItNREuLxiMZZh2er2BG+FxiIGry1kC1m5a56P6/ZDQdcCMTuTpobhSdInzFB/RYH71YBvyMGQr/WsfyAvOeNgQAg/ZxI9DQoak1VxxLzEoWIjSUaZV35DxvjJ7/1kSlQ62XE39ceaZlzB/b/Vvbw7M2IA3ZLf4iVZPu3K2ltXolcKuSTwJa6p0E2EDXCxqdsh539awlRtCYuovBQG7AfF/gN/eUKBsja0755nwqOYoygQjL3HTnqW06V0u8hB8Fgbe9ekld+jUV6EA5yc5NdplJDGcuFdW+uyrW+cjrkLUrED3omMA4mSmrgPieZ8mpNybio00BNjy4IA+u6XpSIB1A2gpcef01bXSUyibL6PSaA==
x-ms-exchange-antispam-messagedata: zSPtdTizLfRkqscBofGghrdxvY9CIIXo52qeKqZmVpxnEfnTq1uR1GM1cqOytyg5wGp8YCGebMQzivlCyYjmHti/6okQEP5RBs0o+jpc+Rlg2FK293gTDIdP0FcTdbionUdKT3+BzX21rJ+D+QWv+g==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cc9e7c3-8e39-469f-5a3d-08d7c5ed9000
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2020 18:54:00.8348
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AA1rA46SWinpYAwaZZHPWCrKD4ocM/Mtyb5G0BUh+Zq64xSykJzECJxzNYDk9sn89vNSpbicWv9e8L9xjFCbug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6446
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Shawn Guo <shawnguo@kernel.org>
> Sent: Wednesday, March 11, 2020 1:12 AM
> To: Leo Li <leoyang.li@nxp.com>
> Cc: linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 07/15] arm64: defconfig: Enable QorIQ cpufreq driver
>=20
> On Mon, Feb 24, 2020 at 05:08:02PM -0600, Li Yang wrote:
> > Enables the generic QorIQ cpufreq driver to support frequency scaling
> > for various QorIQ SoCs.  Enabled as built-in as it is a core feature.
> >
> > Signed-off-by: Li Yang <leoyang.li@nxp.com>
> > ---
> >  arch/arm64/configs/defconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfi=
g
> > index e97ef8b944b8..996dc749ea5c 100644
> > --- a/arch/arm64/configs/defconfig
> > +++ b/arch/arm64/configs/defconfig
> > @@ -90,6 +90,7 @@ CONFIG_ARM_QCOM_CPUFREQ_NVMEM=3Dy
> >  CONFIG_ARM_QCOM_CPUFREQ_HW=3Dy
> >  CONFIG_ARM_RASPBERRYPI_CPUFREQ=3Dm
> >  CONFIG_ARM_TEGRA186_CPUFREQ=3Dy
> > +CONFIG_QORIQ_CPUFREQ=3Dy
> >  CONFIG_ARM_SCPI_PROTOCOL=3Dy
> >  CONFIG_RASPBERRYPI_FIRMWARE=3Dy
> >  CONFIG_INTEL_STRATIX10_SERVICE=3Dy
> > @@ -722,7 +723,6 @@ CONFIG_COMMON_CLK_RK808=3Dy
> >  CONFIG_COMMON_CLK_SCPI=3Dy
> >  CONFIG_COMMON_CLK_CS2000_CP=3Dy
> >  CONFIG_COMMON_CLK_S2MPS11=3Dy
> > -CONFIG_CLK_QORIQ=3Dy
>=20
> Why is this getting removed?

Newly added QORIQ_CPUFREQ selects CLK_QORIQ, so it is removed by savedefcon=
fig.

Regards,
Leo

>=20
> Shawn
>=20
> >  CONFIG_COMMON_CLK_PWM=3Dy
> >  CONFIG_CLK_RASPBERRYPI=3Dm
> >  CONFIG_CLK_IMX8MM=3Dy
> > --
> > 2.17.1
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> >
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Flists.=
inf
> radead.org%2Fmailman%2Flistinfo%2Flinux-arm-
> kernel&amp;data=3D02%7C01%7Cleoyang.li%40nxp.com%7C9fc5f6a95bf74523
> 717708d7c5832d15%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C
> 637195039498757892&amp;sdata=3DnsR%2F3bVYD61W2%2BE393dhJNgKCp%2
> FfvH9cYSdRLckOxns%3D&amp;reserved=3D0
