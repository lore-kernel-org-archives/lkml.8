Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45A93C34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 16:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 109FE208C4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 16:44:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="NECz367E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbgBRQoN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 11:44:13 -0500
Received: from mail-db8eur05on2076.outbound.protection.outlook.com ([40.107.20.76]:6165
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726399AbgBRQoM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 11:44:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IwhNTGULVBC09XRl7wjSDK0W1/szqBh5l7cM41emnZhWkGAYNnrHpipRrev0OIU8QPMTBfye8659JhtF6pQKoGCDqzU1BkdAwQZIih+ynRhZ86aZpHLlsL+n8dHErkBH1E2rmzmAOYF2UsNy3q6Vod45N8kuWjjfVqE0K50A/UgRIOTcCPQ4JkmSbHsX0WyI598b7yyUXMBhysY/MKHoyULIWTe0SvuHpc3uqw4a2FUOiHDQQLGlTc/uHHlTeWQN0IryIYjGkzrPSKpYqMvVUuwOFxiCbjWY+tq8qnKklKsZx4RsZwkKylngfyNmV2Z9BPPsPc6WsyrXmnZmkmGGOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OpzhRrnCDxkJY/tfjMh2b7cZ8XZF6PilCzZzzAm/n4s=;
 b=WKxjn3GUYSA/nWkjmGdWrB1idHO9pvsFaU8V9pd3mr2vFbivSG7owNu4p+7J2V9GBvT9gJdyGjV+xUYMVgWHX1QmUDg8LYQK3RgWEg5uiOvXGS+yY7+jGdf+vd8b6+dlUxMGQS62vXYtAPwofhEVa+Ldg8yISPyptuN1tHUCuYAW1LFHIHnbjCho0p3A88Kr3be0NgIyRIt5wQuSh4+vQg0G6Y9s/Y7Fkpmeja7IuMe4ao5+dNsrtV2HHu+Xl9sGeCiV73m5AQdLMuhjkFf6WsyEPs2NE0eqDVDDknVGxULtAnMCgl4OKP4PR2RtK6yUwf9wW7VlUwAOBUuiGIBNkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OpzhRrnCDxkJY/tfjMh2b7cZ8XZF6PilCzZzzAm/n4s=;
 b=NECz367ExlfyJMLl3ibzX7u2TckZcjglnIHAdX8hJU3HrujFpgz3ouQ469n202l/jpYHwARIroqMI1TmFOfs/ImKStSP5oW2wHynqdjv4ZrhPI7BLmpfbux8KbhsNPeMkhDwkqS/9WiRKtTVUfnwjpIqZiB7vi55TtL3rtBjJZU=
Received: from VE1PR04MB6687.eurprd04.prod.outlook.com (20.179.234.30) by
 VE1PR04MB6622.eurprd04.prod.outlook.com (20.179.234.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25; Tue, 18 Feb 2020 16:44:09 +0000
Received: from VE1PR04MB6687.eurprd04.prod.outlook.com
 ([fe80::b896:5bc0:c4dd:bd23]) by VE1PR04MB6687.eurprd04.prod.outlook.com
 ([fe80::b896:5bc0:c4dd:bd23%2]) with mapi id 15.20.2729.032; Tue, 18 Feb 2020
 16:44:09 +0000
From:   Leo Li <leoyang.li@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] arm64: defconfig: enable additional drivers needed by
 NXP QorIQ boards
Thread-Topic: [PATCH 2/2] arm64: defconfig: enable additional drivers needed
 by NXP QorIQ boards
Thread-Index: AQHV4HYUpACMHjZeZ0GLCF+pBukm5qge58QAgAJLriA=
Date:   Tue, 18 Feb 2020 16:44:09 +0000
Message-ID: <VE1PR04MB668774D60323E11C7FF1FF7F8F110@VE1PR04MB6687.eurprd04.prod.outlook.com>
References: <1581382559-18520-1-git-send-email-leoyang.li@nxp.com>
 <1581382559-18520-2-git-send-email-leoyang.li@nxp.com>
 <20200217053730.GB6042@dragon>
In-Reply-To: <20200217053730.GB6042@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leoyang.li@nxp.com; 
x-originating-ip: [64.157.242.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c69414a9-9d05-4934-6ac6-08d7b491c6d5
x-ms-traffictypediagnostic: VE1PR04MB6622:
x-microsoft-antispam-prvs: <VE1PR04MB66226496352CFF90C5BC7ED88F110@VE1PR04MB6622.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 031763BCAF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(376002)(396003)(366004)(346002)(199004)(189003)(2906002)(54906003)(6916009)(316002)(7696005)(71200400001)(9686003)(86362001)(55016002)(26005)(53546011)(6506007)(52536014)(186003)(478600001)(76116006)(4326008)(8936002)(66946007)(8676002)(81166006)(66556008)(81156014)(66446008)(33656002)(5660300002)(64756008)(66476007);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR04MB6622;H:VE1PR04MB6687.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WxdmYOdqadeErvfgShHJXb/uMuTcnklVCSXMd81naCHc97yKzIEjYgRIvY3L/jeP6YO150sFjko1qQEVUbi/xfMDptR5VQKK+9ozupzMUIsjB1Y2QijxhL1Ka3//xcZkxgPzdW4dBVZIo1pRIhlMz1+6x5bSXfMqLOCu6q+xX50I70LFkyjNuBhy7aI+h3J6gcsoyqTu2/q0tDWRlrKMXqsJ+rdofy8B11GMV+gDKlPG7fx+EgxS40cHY0cBr1kC3vDV95i/8FI/tM3S6j999os5k9StyF9NILTLmSSNHB1C9ZoG3QPQKWMtnG91mK7QymmOPDa19v5MS2q0DbE1FWmvl7Evm4uxSCJGobNUxUBfJhuPYFUaMolNshcPvivqJhF8uwhtS4npQQ457Q4cjgnJRm+6nVAmA9lfM0XqGLEdfYPR6FHEJBYICqIqy1ea
x-ms-exchange-antispam-messagedata: vDBihq7ynNo/3Nw7gSmBQ8n2bcNyu7oH7PaKvXUDxAGq1/n/oKH3LS9ATs/L9JuL9OQ/dJpkDHX0LgEVyYgle/9zWqc3oYjy/+BWNBsJp28MrOxLxGEcJXhEX8ftO82Lmb5+Nf5r9r+BDBM0Bno+Gg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c69414a9-9d05-4934-6ac6-08d7b491c6d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2020 16:44:09.3968
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a/X2p4Kz7uJS9Zc5P4NaUkqeVXerIxlS3iYjARZDrmx4/RI4H/N75uevL3Ca2hq5KsZa/e8n3EWYpHiAYRmSUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Shawn Guo <shawnguo@kernel.org>
> Sent: Sunday, February 16, 2020 11:38 PM
> To: Leo Li <leoyang.li@nxp.com>
> Cc: linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 2/2] arm64: defconfig: enable additional drivers need=
ed
> by NXP QorIQ boards
>=20
> On Mon, Feb 10, 2020 at 06:55:59PM -0600, Li Yang wrote:
> > This enables the following SoC device drivers for NXP/FSL QorIQ SoCs:
> > CONFIG_QORIQ_CPUFREQ=3Dy
> > CONFIG_NET_SWITCHDEV=3Dy
> > CONFIG_MSCC_OCELOT_SWITCH=3Dy
> > CONFIG_CAN=3Dm
> > CONFIG_CAN_FLEXCAN=3Dm
> > CONFIG_FSL_MC_BUS=3Dy
> > CONFIG_MTD_NAND_FSL_IFC=3Dy
> > CONFIG_FSL_ENETC=3Dy
> > CONFIG_FSL_ENETC_VF=3Dy
> > CONFIG_SPI_FSL_LPSPI=3Dy
> > CONFIG_SPI_FSL_QUADSPI=3Dy
> > CONFIG_SPI_FSL_DSPI=3Dy
> > CONFIG_GPIO_MPC8XXX=3Dy
> > CONFIG_ARM_SBSA_WATCHDOG=3Dy
> > CONFIG_DRM_MALI_DISPLAY=3Dm
> > CONFIG_FSL_MC_DPIO=3Dy
> > CONFIG_CRYPTO_DEV_FSL_DPAA2_CAAM=3Dm
> > CONFIG_FSL_DPAA=3Dy
> > CONFIG_FSL_FMAN=3Dy
> > CONFIG_FSL_DPAA_ETH=3Dy
> > CONFIG_FSL_DPAA2_ETH=3Dy
> >
> > And the drivers for on-board devices for the upstreamed QorIQ
> > reference
> > boards:
> > CONFIG_MTD_CFI=3Dy
> > CONFIG_MTD_CFI_ADV_OPTIONS=3Dy
> > CONFIG_MTD_CFI_INTELEXT=3Dy
> > CONFIG_MTD_CFI_AMDSTD=3Dy
> > CONFIG_MTD_CFI_STAA=3Dy
> > CONFIG_MTD_PHYSMAP=3Dy
> > CONFIG_MTD_PHYSMAP_OF=3Dy
> > CONFIG_MTD_DATAFLASH=3Dy
> > CONFIG_MTD_SST25L=3Dy
> > CONFIG_EEPROM_AT24=3Dm
> > CONFIG_RTC_DRV_DS1307=3Dy
> > CONFIG_RTC_DRV_PCF85363=3Dy
> > CONFIG_RTC_DRV_PCF2127=3Dy
> > CONFIG_E1000=3Dy
> > CONFIG_AQUANTIA_PHY=3Dy
> > CONFIG_MICROSEMI_PHY=3Dy
> > CONFIG_VITESSE_PHY=3Dy
> > CONFIG_MDIO_BUS_MUX_MULTIPLEXER=3Dy
> > CONFIG_MUX_MMIO=3Dy
> >
> > The following two options are implied by new options and removed from
> > defconfig:
> > CONFIG_CLK_QORIQ=3Dy
> > CONFIG_MEMORY=3Dy
> >
> > Signed-off-by: Li Yang <leoyang.li@nxp.com>
>=20
> This is too much change in a single patch. It should be split properly to=
 make
> review and merge easier, considering arm-soc folks are cautious to those =
'y'
> options.

Ok.  So probably separating them based on different subsystems will be good=
?  It would be too many patches if I separate for each individual config op=
tion.

Regards,
Leo
