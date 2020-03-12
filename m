Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 368B5C10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 16:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1F562067C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 16:31:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="QEXG8LfJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbgCLQbX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 12:31:23 -0400
Received: from mail-am6eur05on2076.outbound.protection.outlook.com ([40.107.22.76]:6186
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727083AbgCLQbX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 12:31:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fdw/HcG5neYoSsAudSWFMrUjsJlopPzmLOrK3+BQPzbhBB0ilOXpAISC5PrsnDDj0rltjKy+H7NE/NQusYVFQRQcFz+VE/GAcTlGglNCuai6H/gonFeK1RWZy06rl5HuY83YSth2vGyhGwTpY/eifEoqd0zOs03OXVtFxDqgtekrnR8vYVvLZHL8Jdzl7HTdAEERszg2AwJrjCDpDlYF0EvQqahDqD6HKbiwMq4TgRcpCyBdt7vNCoQLozLVmBVZJHityJFplhc5W6mL+2VtlEfXrfegjrwoRtw/uDgjVDY5hzFqdBgcFyGY9UKheB8Jc7xvCGYomdroFo1WyngHTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DHtrRzwYMGV6sskrFFIT9qv0rLcqJNS9tDmSj0ew02I=;
 b=MQgs7PWiTIBplnLQ/Hg42m9ud0KGvu5coXVRv0FL/odrM829XVn/XMpbwD3yoECJLjcenQMUDnswemZS4jglrvxD2t6B55q8YpqwXUentvECU5czw3RDAH2TXDY8mOCxJs3x5DTuhgaX8QfNLz/neshFQsVbpgVIxT4hbiEpWSSUkI2077YszSOk94hAtGroiHk8ECsZV05pmt7Q1u+LE+gJK6K3V54OyQZ1JM8uCPmmgHSy27mOLqIEjbTs296GQUFaxirRaAPJF2iSdr2dLDf3L3A1wsBwS1tLpsZG/8F3b8SjFPPf0PNxQ+w0ZwA0QZlhZv3irnpAzstBSLzH/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DHtrRzwYMGV6sskrFFIT9qv0rLcqJNS9tDmSj0ew02I=;
 b=QEXG8LfJDzBHoUQpO5D/LImP1yy8akumDgUBHEZbIOLe4mqd91kneUwSGdb0x8cZYmjy+JMrcZ3AFN/rdzW//I+QG0G2iOb2f3xSzWrECJBhluOXmoD9SMIkMQG42BOQW5+fAmqwYzrH188Ts+g3dtxEk58VHBtG9J1NsOYQGnY=
Received: from VE1PR04MB6687.eurprd04.prod.outlook.com (20.179.234.30) by
 VE1PR04MB6749.eurprd04.prod.outlook.com (10.255.118.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.17; Thu, 12 Mar 2020 16:31:20 +0000
Received: from VE1PR04MB6687.eurprd04.prod.outlook.com
 ([fe80::b896:5bc0:c4dd:bd23]) by VE1PR04MB6687.eurprd04.prod.outlook.com
 ([fe80::b896:5bc0:c4dd:bd23%2]) with mapi id 15.20.2814.007; Thu, 12 Mar 2020
 16:31:20 +0000
From:   Leo Li <leoyang.li@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 07/15] arm64: defconfig: Enable QorIQ cpufreq driver
Thread-Topic: [PATCH 07/15] arm64: defconfig: Enable QorIQ cpufreq driver
Thread-Index: AQHV62dVL2g/wtlvM02iwpLe9+E/l6hDAT2AgADUc2CAAUbWgIAAI+TQ
Date:   Thu, 12 Mar 2020 16:31:20 +0000
Message-ID: <VE1PR04MB66873BABF08127186E1C135D8FFD0@VE1PR04MB6687.eurprd04.prod.outlook.com>
References: <1582585690-463-1-git-send-email-leoyang.li@nxp.com>
 <1582585690-463-8-git-send-email-leoyang.li@nxp.com>
 <20200311061220.GB29269@dragon>
 <VE1PR04MB66873A9B6773FFBF96F37C6B8FFC0@VE1PR04MB6687.eurprd04.prod.outlook.com>
 <20200312142229.GA1249@dragon>
In-Reply-To: <20200312142229.GA1249@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leoyang.li@nxp.com; 
x-originating-ip: [64.157.242.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a87604c8-2db5-4eb5-6b31-08d7c6a2cc08
x-ms-traffictypediagnostic: VE1PR04MB6749:
x-microsoft-antispam-prvs: <VE1PR04MB6749984A37D5C384ABA5B6A88FFD0@VE1PR04MB6749.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 0340850FCD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(366004)(376002)(39860400002)(396003)(136003)(199004)(9686003)(7696005)(478600001)(2906002)(316002)(81166006)(6916009)(186003)(53546011)(8936002)(6506007)(54906003)(81156014)(55016002)(64756008)(66446008)(5660300002)(66476007)(33656002)(66556008)(66946007)(52536014)(8676002)(26005)(4326008)(76116006)(71200400001)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR04MB6749;H:VE1PR04MB6687.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jhFEhEW4e8vqe42vqw/dFSuaBOHwjgQ6g1dLMD9BnDodgRXiuBjxSdHMbV6pZOfl97Noz6U3q0Vmz6h0/FFmTmnzvfMPCwv41BeQeTt/vDzzz1LqngH3tcq0k1rwPRwoV9YinSjDIoJlPYrV4JCVKtk7nj7HozOH6JNtLaHtj7U4eL+/kdadYU1WeFoTwqHSzocYPZAsMxVT28EQxXI+CQ0E4YYbq792pH1OuCrfGw6ddHZIc/bRlaY3wgdHRFzZjut4JveTtK6tJ6V4xQSbPE3n1DHYLlRnZE/wGLJo67647iinQ+bafimP/MdVV7sFI/esD9dt7s2MEsOhCcBS4j0JeByE5BQ7SXMHuuYftZmgOVR6SaI3td1FCAp86xwYhGiWbzh8ZO8ZwdPEwf6msaEv4zGvqKcM9m85mcmZk5PCvX0tHejeyiFnn7EJiCJ0
x-ms-exchange-antispam-messagedata: 8aEGWrCPwxK3pT/5GSu8NJtH4O4/jk5NuJZemyUU92zzZYie5h47lZtyY/uN7ItAH83sipBLiei9TnDpuJ6YS7NiOe3xRhtMaFDrtWX20BhKPsHaGxxYFIuNrZcJ5emgg0DX7yfpQYMzrCWNX/HzCg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a87604c8-2db5-4eb5-6b31-08d7c6a2cc08
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2020 16:31:20.5000
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hoIWHRadlMpJyH/cus96fR/oeQk4fs2/C87DlnyzQPcpiy0kCVc3UksuZBBAip8C5ZbW70KWc+z9qr+v2k7mmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6749
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Shawn Guo <shawnguo@kernel.org>
> Sent: Thursday, March 12, 2020 9:23 AM
> To: Leo Li <leoyang.li@nxp.com>
> Cc: linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 07/15] arm64: defconfig: Enable QorIQ cpufreq driver
>=20
> On Wed, Mar 11, 2020 at 06:54:00PM +0000, Leo Li wrote:
> >
> >
> > > -----Original Message-----
> > > From: Shawn Guo <shawnguo@kernel.org>
> > > Sent: Wednesday, March 11, 2020 1:12 AM
> > > To: Leo Li <leoyang.li@nxp.com>
> > > Cc: linux-arm-kernel@lists.infradead.org;
> > > linux-kernel@vger.kernel.org
> > > Subject: Re: [PATCH 07/15] arm64: defconfig: Enable QorIQ cpufreq
> > > driver
> > >
> > > On Mon, Feb 24, 2020 at 05:08:02PM -0600, Li Yang wrote:
> > > > Enables the generic QorIQ cpufreq driver to support frequency
> > > > scaling for various QorIQ SoCs.  Enabled as built-in as it is a cor=
e feature.
> > > >
> > > > Signed-off-by: Li Yang <leoyang.li@nxp.com>
> > > > ---
> > > >  arch/arm64/configs/defconfig | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/arch/arm64/configs/defconfig
> > > > b/arch/arm64/configs/defconfig index e97ef8b944b8..996dc749ea5c
> > > > 100644
> > > > --- a/arch/arm64/configs/defconfig
> > > > +++ b/arch/arm64/configs/defconfig
> > > > @@ -90,6 +90,7 @@ CONFIG_ARM_QCOM_CPUFREQ_NVMEM=3Dy
> > > > CONFIG_ARM_QCOM_CPUFREQ_HW=3Dy
> CONFIG_ARM_RASPBERRYPI_CPUFREQ=3Dm
> > > > CONFIG_ARM_TEGRA186_CPUFREQ=3Dy
> > > > +CONFIG_QORIQ_CPUFREQ=3Dy
> > > >  CONFIG_ARM_SCPI_PROTOCOL=3Dy
> > > >  CONFIG_RASPBERRYPI_FIRMWARE=3Dy
> > > >  CONFIG_INTEL_STRATIX10_SERVICE=3Dy
> > > > @@ -722,7 +723,6 @@ CONFIG_COMMON_CLK_RK808=3Dy
> > > > CONFIG_COMMON_CLK_SCPI=3Dy
> CONFIG_COMMON_CLK_CS2000_CP=3Dy
> > > > CONFIG_COMMON_CLK_S2MPS11=3Dy -CONFIG_CLK_QORIQ=3Dy
> > >
> > > Why is this getting removed?
> >
> > Newly added QORIQ_CPUFREQ selects CLK_QORIQ, so it is removed by
> savedefconfig.
>=20
> Note it in the commit log please.

Sure.  Already in v2.

Regards,
Leo
