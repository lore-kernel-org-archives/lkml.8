Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30616C34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 16:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFF132176D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 16:54:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="lNpdbNpp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbgBRQyM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 11:54:12 -0500
Received: from mail-eopbgr70088.outbound.protection.outlook.com ([40.107.7.88]:13801
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726360AbgBRQyM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 11:54:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O0j2N1JX8HCtL5j57zisWnejuZzP+9NzK4cu5wsKUgpf+ADXnhATBV9uJCP8LcUhhsUncwu4in19M7vxeSubQg4ZmcqD5rjWJUa0q8T2nzOBik5kzp16rWHgaeFxsMWB57+fBOZR4E4JISNWnIFLSNsQ8ArWIGN6f3AAc5W3d6hIEb88J1ent29iFdagFpNyaz8+ZPXx5rlA1g9wzFfpKZqajlRfVf9/nLpinPUQF/qp2ugPipB3SZ4dRGn3aGqyUkGqWuULtKTztZ49cFKHqDBUih6HoUChXMGtcLaYhtzLV3isZar7vVr9zinQx9WUVOgc2jGNYwjqyUE1eQ3qpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KKMxCb1mG3KkEYxtE8YDfXySNv2vkczNnN5hnO8yUSw=;
 b=Gg5eD4x5dajHcl/s2LtgAUG/9r2rJwdY+UEfGz7Xrhu98mwNPIQZf7xM4GEF4e1ovXvB+maFC0s4xO2AhoS+mJ5SjpknLhry7VvgkOSOG4jmLYDi9E+X+rtK/QuIIbKptsynz/rNzHWO0Icjp1BzMpfijYVpuU6Q5LxfcfJRywPXNGAq2OfiT5KmwrhiWqiEOyrKHq7RDYdJJRRjKTyjkOzyfvayR+GpXqtHIGodTVm+Ac/Br/nvzvN7ktWSichZLBuPwF4Uo6/RiplVPWNN+U83gzgoIbKE4z5DA+v99buHzKBaJvMMCZFC5H/xabVdszY18MoMNSM0TY9mQS7qyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KKMxCb1mG3KkEYxtE8YDfXySNv2vkczNnN5hnO8yUSw=;
 b=lNpdbNppo8VJ3AxxEtL/HWfVgN6tJ0mrmSojrTfhRMNsWgro05t1auuek2swkcZBYMuvanMjC15gowR0sAG9izNs18na4tvaYV6nnT+91bZxKGcaFiLfqhrehvFSXkvAffT7nXIpUs1fGXaQsBQTyui/vh3spK5jZz1jeTHa1B8=
Received: from VE1PR04MB6687.eurprd04.prod.outlook.com (20.179.234.30) by
 VE1PR04MB6656.eurprd04.prod.outlook.com (20.179.235.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25; Tue, 18 Feb 2020 16:54:06 +0000
Received: from VE1PR04MB6687.eurprd04.prod.outlook.com
 ([fe80::b896:5bc0:c4dd:bd23]) by VE1PR04MB6687.eurprd04.prod.outlook.com
 ([fe80::b896:5bc0:c4dd:bd23%2]) with mapi id 15.20.2729.032; Tue, 18 Feb 2020
 16:54:06 +0000
From:   Leo Li <leoyang.li@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] arm64: defconfig: run through savedefconfig for
 ordering
Thread-Topic: [PATCH 1/2] arm64: defconfig: run through savedefconfig for
 ordering
Thread-Index: AQHV4HYQkBp5gNwa3EW+6CF+jjRMxage5usAgAJPBQA=
Date:   Tue, 18 Feb 2020 16:54:05 +0000
Message-ID: <VE1PR04MB6687EFB8CC40D9A53E8D25008F110@VE1PR04MB6687.eurprd04.prod.outlook.com>
References: <1581382559-18520-1-git-send-email-leoyang.li@nxp.com>
 <20200217053427.GA6042@dragon>
In-Reply-To: <20200217053427.GA6042@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leoyang.li@nxp.com; 
x-originating-ip: [64.157.242.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e50be303-3f19-48e2-cc87-08d7b4932a6d
x-ms-traffictypediagnostic: VE1PR04MB6656:
x-microsoft-antispam-prvs: <VE1PR04MB66567772077F85E11FDB39368F110@VE1PR04MB6656.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 031763BCAF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(346002)(396003)(136003)(366004)(199004)(189003)(186003)(33656002)(478600001)(81166006)(81156014)(6506007)(52536014)(316002)(110136005)(53546011)(54906003)(8936002)(7696005)(8676002)(55016002)(9686003)(2906002)(26005)(86362001)(5660300002)(66476007)(66946007)(76116006)(66556008)(64756008)(66446008)(4326008)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR04MB6656;H:VE1PR04MB6687.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yvDBWnI/n8LKmHmBzX2EfxrqkYdIfGOO4mPevz2VRLukKDJzGwkXTgfKtE+5unmNt3c6W/ZUnxDPplK0fmKG1Pm4USY8f/z53ABAVm6bqT/wDFfUrL7W8IOhfiyc9O9WQnKtKcTlSD7FaqKQo4H1kl49qR8EbioZcHWkOLd+jxN9tErV4DDMSEe2HEsqAZCJE0ICR2SDhkduxz1B+AQwjNx45da74Xqa0d6QakIxkniiQhGKttym+6MKBBL/xWbAhVVbNRIcv0gKXaF8KyJZOCLfv+80jGLs6TlyBhGJybmUEDveWp2+7LuWCbj+cZ605G069K5nVQM/CQOf+x9wZyZDSYqmfYpZzJqK3ibnOkAXOGiCAiS7E9BatZpwnMJGtCl8+P+n6TZ1IA5OFqc0x9BAwvVAj3NAsu96cYuHWzndsyl6pJZpVng20GjjUuBt
x-ms-exchange-antispam-messagedata: rpC6UYZb0lN332KRE12gfUggPTSo36oV+bI724z9HpscZMzGyqUfSiSbNkl4t6yjbIiSUxilPo7biE2dAGTxZpwJ4Q1O+wrwP1Tywt/oRkHCiGNUPifdWfzR46ukNtE5ZvhpckJCyBJihTa/zaCMdg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e50be303-3f19-48e2-cc87-08d7b4932a6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2020 16:54:05.9936
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zf57IO5YRY+NuEyrmFrmMFpn9aWney9KNd04SjkvhWoEo9Vik3WcSvbIyAHF9/1z+ir6/xa8Sb6KiYaqJ56FZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6656
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Shawn Guo <shawnguo@kernel.org>
> Sent: Sunday, February 16, 2020 11:34 PM
> To: Leo Li <leoyang.li@nxp.com>; Arnd Bergmann <arnd@arndb.de>; Olof
> Johansson <olof@lixom.net>
> Cc: linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 1/2] arm64: defconfig: run through savedefconfig for
> ordering
>=20
> On Mon, Feb 10, 2020 at 06:55:58PM -0600, Li Yang wrote:
> > Used "make defconfig savedefconfig" to regenerate defconfig file in the
> > right order to prepare for additional defconfig changes.
> >
> > Signed-off-by: Li Yang <leoyang.li@nxp.com>
>=20
> Arnd, Olof,
>=20
> How do we handle arm64 defconfig savedefconfig changes? I think it will
> likely cause conflicts with changes from other platform maintainers.

Actually I think it helps a lot for managing off-tree defconfig patches whe=
n we keep it sorted with savedefconfig because changes to the same option w=
ill always be at the same location and shown as proper conflicts when mergi=
ng.

Regards,
Leo
>=20
> Shawn
>=20
> > ---
> >  arch/arm64/configs/defconfig | 15 ++++++---------
> >  1 file changed, 6 insertions(+), 9 deletions(-)
> >
> > diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfi=
g
> > index 0f212889c931..618001ef5c81 100644
> > --- a/arch/arm64/configs/defconfig
> > +++ b/arch/arm64/configs/defconfig
> > @@ -471,9 +471,9 @@ CONFIG_DW_WATCHDOG=3Dy
> >  CONFIG_SUNXI_WATCHDOG=3Dm
> >  CONFIG_IMX2_WDT=3Dy
> >  CONFIG_IMX_SC_WDT=3Dm
> > +CONFIG_QCOM_WDT=3Dm
> >  CONFIG_MESON_GXBB_WATCHDOG=3Dm
> >  CONFIG_MESON_WATCHDOG=3Dm
> > -CONFIG_QCOM_WDT=3Dm
> >  CONFIG_RENESAS_WDT=3Dy
> >  CONFIG_UNIPHIER_WATCHDOG=3Dy
> >  CONFIG_BCM2835_WDT=3Dy
> > @@ -594,8 +594,8 @@ CONFIG_SND_SOC_TAS571X=3Dm
> >  CONFIG_SND_SIMPLE_CARD=3Dm
> >  CONFIG_SND_AUDIO_GRAPH_CARD=3Dm
> >  CONFIG_I2C_HID=3Dm
> > -CONFIG_USB=3Dy
> >  CONFIG_USB_CONN_GPIO=3Dm
> > +CONFIG_USB=3Dy
> >  CONFIG_USB_OTG=3Dy
> >  CONFIG_USB_XHCI_HCD=3Dy
> >  CONFIG_USB_XHCI_TEGRA=3Dy
> > @@ -617,7 +617,6 @@ CONFIG_USB_CHIPIDEA_HOST=3Dy
> >  CONFIG_USB_ISP1760=3Dy
> >  CONFIG_USB_HSIC_USB3503=3Dy
> >  CONFIG_NOP_USB_XCEIV=3Dy
> > -CONFIG_USB_ULPI=3Dy
> >  CONFIG_USB_GADGET=3Dy
> >  CONFIG_USB_RENESAS_USBHS_UDC=3Dm
> >  CONFIG_USB_RENESAS_USB3=3Dm
> > @@ -756,7 +755,6 @@ CONFIG_OWL_PM_DOMAINS=3Dy
> >  CONFIG_RASPBERRYPI_POWER=3Dy
> >  CONFIG_IMX_SCU_SOC=3Dy
> >  CONFIG_QCOM_AOSS_QMP=3Dy
> > -CONFIG_QCOM_COMMAND_DB=3Dy
> >  CONFIG_QCOM_GENI_SE=3Dy
> >  CONFIG_QCOM_GLINK_SSR=3Dm
> >  CONFIG_QCOM_RMTFS_MEM=3Dm
> > @@ -771,14 +769,12 @@ CONFIG_ARCH_R8A774A1=3Dy
> >  CONFIG_ARCH_R8A774B1=3Dy
> >  CONFIG_ARCH_R8A774C0=3Dy
> >  CONFIG_ARCH_R8A7795=3Dy
> > -CONFIG_ARCH_R8A7796=3Dy
> >  CONFIG_ARCH_R8A77961=3Dy
> >  CONFIG_ARCH_R8A77965=3Dy
> >  CONFIG_ARCH_R8A77970=3Dy
> >  CONFIG_ARCH_R8A77980=3Dy
> >  CONFIG_ARCH_R8A77990=3Dy
> >  CONFIG_ARCH_R8A77995=3Dy
> > -CONFIG_QCOM_PDC=3Dy
> >  CONFIG_ROCKCHIP_PM_DOMAINS=3Dy
> >  CONFIG_ARCH_TEGRA_132_SOC=3Dy
> >  CONFIG_ARCH_TEGRA_210_SOC=3Dy
> > @@ -809,6 +805,7 @@ CONFIG_PWM_ROCKCHIP=3Dy
> >  CONFIG_PWM_SAMSUNG=3Dy
> >  CONFIG_PWM_SUN4I=3Dm
> >  CONFIG_PWM_TEGRA=3Dm
> > +CONFIG_QCOM_PDC=3Dy
> >  CONFIG_RESET_QCOM_AOSS=3Dy
> >  CONFIG_RESET_QCOM_PDC=3Dm
> >  CONFIG_RESET_TI_SCI=3Dy
> > @@ -880,16 +877,16 @@ CONFIG_NLS_ISO8859_1=3Dy
> >  CONFIG_SECURITY=3Dy
> >  CONFIG_CRYPTO_ECHAINIV=3Dy
> >  CONFIG_CRYPTO_ANSI_CPRNG=3Dy
> > +CONFIG_CRYPTO_USER_API_RNG=3Dm
> >  CONFIG_CRYPTO_DEV_SUN8I_CE=3Dm
> >  CONFIG_CRYPTO_DEV_FSL_CAAM=3Dm
> > -CONFIG_CRYPTO_DEV_HISI_ZIP=3Dm
> > -CONFIG_CRYPTO_USER_API_RNG=3Dm
> >  CONFIG_CRYPTO_DEV_QCOM_RNG=3Dm
> > +CONFIG_CRYPTO_DEV_HISI_ZIP=3Dm
> >  CONFIG_CMA_SIZE_MBYTES=3D32
> >  CONFIG_PRINTK_TIME=3Dy
> >  CONFIG_DEBUG_INFO=3Dy
> > -CONFIG_DEBUG_FS=3Dy
> >  CONFIG_MAGIC_SYSRQ=3Dy
> > +CONFIG_DEBUG_FS=3Dy
> >  CONFIG_DEBUG_KERNEL=3Dy
> >  # CONFIG_SCHED_DEBUG is not set
> >  # CONFIG_DEBUG_PREEMPT is not set
> > --
> > 2.17.1
> >
