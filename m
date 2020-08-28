Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2375CC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 11:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D427420848
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 11:42:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="XOQRvIyy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729265AbgH1LmU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 07:42:20 -0400
Received: from mail-bn7nam10on2064.outbound.protection.outlook.com ([40.107.92.64]:53728
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729040AbgH1Llk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 07:41:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WXB8A6X1pgiKiP+WjpgyMNM+xmDUwjvkvDmMW4T4aRoXI0kQtykmV6+6+EGLxlFb8AOzmiV1n7B/b3i7MGlDWJtbrfQh8Vvsw2JbGPIkZPex/JcNUIgEdN/BVzGolOlH/fg5vWpG9Km3SLU2KXSaiCfWSc3UjKpJYFES/wA8WZzEC0mHu6hY2lSU/lbUTMvu+kgp5GM//85RoI+rItKJ4mQNStiD/cMkPCA3dOQAnPO+hP5OxwtJFHWwuE07tUrNEA6Je4C0FEEYDhAWR0qPFHdHDAhF9mRMF4dtDASgaAyC3xTg4KTJnPIA2aXCUhA3Etfyy1JBj29C/50z9txtrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c7rArOGopfdmyL2kcgrEaMGwtwK65gsxNODF3VUXkbo=;
 b=IgxxRS2g+/HGGsipZ7e+HlDkIMriWK10s7rgPPsL80K2ZMBKRC/vu89fh3EEbTRGSjbyxDeG9oKTLk5AtIWw6Y5oA2H3gTXHR8dep5Ir2nN/BQPDmZAbFxOImtcqcux/6bgivrt/v6i362r6NLeMeJFhN6BzRFptRmDHcdu6gx1ex+qDd1rLFX+4GVP4clqsWW0aUHokJZn4Nf8tgY04v6hL7coVZtLymhAvU8OcaTSNw4NTTpSD/ShbO9t4wuVBkF2KKrZOgrIQHlMuoxxx2ITXEHFpDWWWH65vBex5Dd9e0zK+MZPsAzhvH8JnXwvCjCFf0/90kkwSeaO+LF5qLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c7rArOGopfdmyL2kcgrEaMGwtwK65gsxNODF3VUXkbo=;
 b=XOQRvIyyPEmBU8h6/S8Z3v1OndsazCWk4eFJf1RzsriTPuqNenxSl34fQHBxmKBptE09XVInnZAYFYu1p394igILXNvXPS5rpKBcY1rwI0AjM74SFCi5nLVuBSiOCkSFRetB6+Rh910oweCMr3BHkewBd9vP4deuaqgVCRPP6bc=
Received: from BYAPR02MB5896.namprd02.prod.outlook.com (2603:10b6:a03:122::10)
 by BY5PR02MB7025.namprd02.prod.outlook.com (2603:10b6:a03:238::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Fri, 28 Aug
 2020 11:41:32 +0000
Received: from BYAPR02MB5896.namprd02.prod.outlook.com
 ([fe80::48ec:6240:92db:c6bf]) by BYAPR02MB5896.namprd02.prod.outlook.com
 ([fe80::48ec:6240:92db:c6bf%5]) with mapi id 15.20.3305.032; Fri, 28 Aug 2020
 11:41:31 +0000
From:   Manish Narani <MNARANI@xilinx.com>
To:     Felipe Balbi <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Michal Simek <michals@xilinx.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        git <git@xilinx.com>
Subject: RE: [PATCH 2/2] usb: dwc3: Add driver for Xilinx platforms
Thread-Topic: [PATCH 2/2] usb: dwc3: Add driver for Xilinx platforms
Thread-Index: AQHWe9kSXk9fyd29ekqKVsSVp3b0nKlLf7MAgAHFp1A=
Date:   Fri, 28 Aug 2020 11:41:31 +0000
Message-ID: <BYAPR02MB5896669D47783D06F779608BC1520@BYAPR02MB5896.namprd02.prod.outlook.com>
References: <1598467441-124203-1-git-send-email-manish.narani@xilinx.com>
 <1598467441-124203-3-git-send-email-manish.narani@xilinx.com>
 <87y2m0ioql.fsf@kernel.org>
In-Reply-To: <87y2m0ioql.fsf@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [27.121.100.228]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bf0a9a68-357b-4738-ecf3-08d84b474f53
x-ms-traffictypediagnostic: BY5PR02MB7025:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR02MB70251AE766BC4A0D6A2DD49FC1520@BY5PR02MB7025.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kFwWH3xrxEO+mMyLN+M7k6aC134kcjS8g0prdrZdpY8PZFBBrCfNjaILiD2XDYQI30B6KiJzflVU4UHN7esRuIs6HemtYlKtZ2rBNoo1fMFh6Rq11UzMuboYwMX17N4/paIqHP8DEr+zjbWxqIyGHyGejnuc1yaPOEPlxKOVvZSu5DroZC8mJIHOWC/Nic5qsoefhtXUw/gwGMztZopMfJfNAsvGE3nh8q6wrLb9c9DB+WsV6S1Bgnfs0ABQ5uuBKANn2IiayNXfIyc7doy3++OCkOrsddthSS2CNRhtV9RbPUtkyvyGnx0JfHZ3hpNdA15hNEvRoRmdnev0MRs0FQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR02MB5896.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(39860400002)(366004)(376002)(136003)(33656002)(66556008)(66946007)(53546011)(66476007)(6506007)(186003)(64756008)(5660300002)(478600001)(26005)(76116006)(66446008)(7696005)(110136005)(107886003)(71200400001)(83380400001)(9686003)(54906003)(316002)(86362001)(8676002)(4326008)(52536014)(2906002)(30864003)(55016002)(8936002)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: AzWsZAYPQrvyFwu4aEfteO+MNLdT5z+kCxGgsXmZTTYz84hgp28kh4W7N70RlD7QoneSjFOKFm1uIwW5dSJ7g4ytNeBeTWMbn2uLWhb05Fm+xOF8vb2g2vGvl/+CsmerKHZswnirkJa2GpBeCq5n29vptP9NWbqXrN5PDwU+A5MRqcE999HADClIrZqwFiVgDVocx+V1Tfchj0tDxu5Pb+4yG4WMnzzVvK+qmmOKslXmcrBflDcliduJxbXRPaUVgeUPbqdE60WyWazsJSZg+eQA/Sf0Q55LybdmgBR5IuBnvDnFK0OfzLLXLghtJ3C3TnchUDUBrz5uWEzJ8zbuQHib8BqW563am4mVNxpygGknSc734ndruqxAjX0NMxwxgyvxxtBFzzTXpZDr6s7V+yVhkFTIrGDcbcllFlm1j9Gn2smMS/T2fZaGuNLv6a1cKrGp0pXpTuYItOEqsPXTqu4adD1Gf/+3ejrr3sFak6EjykIoQP3mvRXz8lI2gqh03j4Y4f91Kzeu+NAAzJuzbzikegYznPXYnXMTJajt0Q6fIvhhRhT/leF5zvtMhEpGgj3dYAqNHJlIRVCowHs68YEQxnc3LU7qFHxS/KLmOxQKwk+WhAahx+doiY28UPtkJkvtzWJ67Bolh0nEQoSDFA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB5896.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf0a9a68-357b-4738-ecf3-08d84b474f53
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2020 11:41:31.5728
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oJlvoJ0wukZ6p9MG3IoZZxaKnGy2OX3onUgkYJNt+k2s5eN/XjRAPQOLYN0R5b15G1FG+7igwMxlWcBThIc6aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB7025
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Felipe,

Thanks for the review. Please find my comments below inline.

> -----Original Message-----
> From: Felipe Balbi <balbi@kernel.org>
> Sent: Thursday, August 27, 2020 12:02 PM
> To: Manish Narani <MNARANI@xilinx.com>; gregkh@linuxfoundation.org;
> robh+dt@kernel.org; Michal Simek <michals@xilinx.com>;
> p.zabel@pengutronix.de
> Cc: linux-usb@vger.kernel.org; devicetree@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org; git <git@xilinx=
.com>;
> Manish Narani <MNARANI@xilinx.com>
> Subject: Re: [PATCH 2/2] usb: dwc3: Add driver for Xilinx platforms
>=20
> Manish Narani <manish.narani@xilinx.com> writes:
>=20
> > Add a new driver for supporting Xilinx platforms. This driver handles
> > the USB 3.0 PHY initialization and PIPE control & reset operations for
>=20
> PHY initialization should be done as part of a drivers/phy driver.

Yes. This driver calls those APIs present in the Xilinx PHY driver (drivers=
/phy/xilinx/phy-zynqmp.c) for initializing the PHY.
May be I can optimize this commit message a bit.

>=20
> > ZynqMP platforms. This also handles the USB 2.0 PHY initialization and
> > reset operations for Versal platforms.
>=20
> similarly for USB2 PHYs
>=20
> > diff --git a/drivers/usb/dwc3/dwc3-xilinx.c b/drivers/usb/dwc3/dwc3-xil=
inx.c
> > new file mode 100644
> > index 000000000000..272906797a7a
> > --- /dev/null
> > +++ b/drivers/usb/dwc3/dwc3-xilinx.c
> > @@ -0,0 +1,416 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/**
> > + * dwc3-xilinx.c - Xilinx DWC3 controller specific glue driver
> > + *
> > + * Authors: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
> > + *          Manish Narani <manish.narani@xilinx.com>
> > + */
> > +
> > +#include <linux/module.h>
> > +#include <linux/kernel.h>
> > +#include <linux/slab.h>
> > +#include <linux/clk.h>
> > +#include <linux/of.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/dma-mapping.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/pm_runtime.h>
> > +#include <linux/reset.h>
> > +#include <linux/of_address.h>
> > +#include <linux/delay.h>
> > +#include <linux/firmware/xlnx-zynqmp.h>
> > +#include <linux/io.h>
> > +
> > +#include <linux/phy/phy.h>
> > +
> > +/* USB phy reset mask register */
> > +#define XLNX_USB_PHY_RST		0x001C
> > +#define XLNX_PHY_RST_MASK		0x1
> > +
> > +/* Xilinx USB 3.0 IP Register */
> > +#define XLNX_USB_COHERENCY		0x005C
> > +#define XLNX_USB_COHERENCY_ENABLE	0x1
> > +
> > +/* Versal USB Reset ID */
> > +#define VERSAL_USB_RESET_ID		0xC104036
> > +
> > +#define PIPE_CLK_OFFSET			0x7c
> > +#define PIPE_CLK_ON			1
> > +#define PIPE_CLK_OFF			0
> > +#define PIPE_POWER_OFFSET		0x80
> > +#define PIPE_POWER_ON			1
> > +#define PIPE_POWER_OFF			0
> > +
> > +#define RST_TIMEOUT			1000
> > +
> > +struct dwc3_xlnx {
> > +	int				num_clocks;
> > +	struct clk_bulk_data		*clks;
> > +	struct device			*dev;
> > +	void __iomem			*regs;
> > +	struct dwc3			*dwc;
> > +	struct phy			*phy;
> > +	struct phy			*usb3_phy;
> > +	struct reset_control		*crst;
> > +	struct reset_control		*hibrst;
> > +	struct reset_control		*apbrst;
> > +};
> > +
> > +static void dwc3_xlnx_mask_phy_rst(struct dwc3_xlnx *priv_data, bool
> mask)
> > +{
> > +	u32 reg;
> > +
> > +	reg =3D readl(priv_data->regs + XLNX_USB_PHY_RST);
> > +
> > +	if (mask)
> > +		/*
> > +		 * Mask the phy reset signal from comtroller
>=20
> s/comtroller/controller
>=20
> But really, the comments don't bring any extra information. I'd say
> remove the comments as the code speaks for itself very clearly in this
> case.
>=20
> > +static int dwc3_xlnx_rst_assert(struct reset_control *rstc)
>=20
> this looks like it should be an actual reset controller driver.
>=20
> > +static int dwc3_xlnx_init_versal(struct dwc3_xlnx *priv_data)
> > +{
> > +	struct device *dev =3D priv_data->dev;
> > +	int ret;
> > +
> > +	dwc3_xlnx_mask_phy_rst(priv_data, false);
> > +
> > +	/* Assert and De-assert reset */
> > +	ret =3D zynqmp_pm_reset_assert(VERSAL_USB_RESET_ID,
> > +				     PM_RESET_ACTION_ASSERT);
> > +	if (ret < 0) {
> > +		dev_err(dev, "failed to assert Reset\n");
> > +		return ret;
> > +	}
> > +
> > +	ret =3D zynqmp_pm_reset_assert(VERSAL_USB_RESET_ID,
> > +				     PM_RESET_ACTION_RELEASE);
> > +	if (ret < 0) {
> > +		dev_err(dev, "failed to De-assert Reset\n");
> > +		return ret;
> > +	}
> > +
> > +	dwc3_xlnx_mask_phy_rst(priv_data, true);
> > +
> > +	return 0;
> > +}
> > +
> > +static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx *priv_data)
> > +{
> > +	struct device *dev =3D priv_data->dev;
> > +	int ret;
> > +	u32 reg;
> > +
> > +	priv_data->crst =3D devm_reset_control_get(dev, "usb_crst");
> > +	if (IS_ERR(priv_data->crst)) {
> > +		dev_err(dev, "failed to get %s reset signal\n", "usb_crst");
> > +		ret =3D PTR_ERR(priv_data->crst);
> > +		goto err;
> > +	}
> > +
> > +	priv_data->hibrst =3D devm_reset_control_get(dev, "usb_hibrst");
> > +	if (IS_ERR(priv_data->hibrst)) {
> > +		dev_err(dev, "failed to get %s reset signal\n", "usb_hibrst");
> > +		ret =3D PTR_ERR(priv_data->hibrst);
> > +		goto err;
> > +	}
> > +
> > +	priv_data->apbrst =3D devm_reset_control_get(dev, "usb_apbrst");
> > +	if (IS_ERR(priv_data->apbrst)) {
> > +		dev_err(dev, "failed to get %s reset signal\n", "usb_apbrst");
> > +		ret =3D PTR_ERR(priv_data->apbrst);
> > +		goto err;
> > +	}
> > +
> > +	priv_data->usb3_phy =3D devm_phy_get(dev, "usb3-phy");
> > +
> > +	ret =3D dwc3_xlnx_rst_assert(priv_data->crst);
> > +	if (ret < 0) {
> > +		dev_err(dev, "%s: %d: Failed to assert reset\n",
> > +			__func__, __LINE__);
>=20
> you don't need the function name or the line number here. Just improve
> your error message a bit:
>=20
> 		dev_err(dev, "Failed to assert usb3-phy reset\n");
>=20
> > +		goto err;
> > +	}
> > +
> > +	ret =3D dwc3_xlnx_rst_assert(priv_data->hibrst);
> > +	if (ret < 0) {
> > +		dev_err(dev, "%s: %d: Failed to assert reset\n",
> > +			__func__, __LINE__);
>=20
> 		dev_err(dev, "Failed to assert hibernation reset\n");
>=20
> > +		goto err;
> > +	}
> > +
> > +	ret =3D dwc3_xlnx_rst_assert(priv_data->apbrst);
> > +	if (ret < 0) {
> > +		dev_err(dev, "%s: %d: Failed to assert reset\n",
> > +			__func__, __LINE__);
>=20
> 		dev_err(dev, "Failed to assert APB reset\n");
>=20
> > +		goto err;
> > +	}
> > +
> > +	ret =3D phy_init(priv_data->usb3_phy);
>=20
> dwc3 core should be handling this already

The USB controller used in Xilinx ZynqMP platform uses xilinx GT phy which =
has 4 GT lanes and can used by 4 peripherals at a time.
This USB controller uses 1 GT phy lane among the 4 GT lanes. To configure t=
he GT lane for USB controller, the below sequence is expected.
1. Assert the USB controller resets.
2. Configure the Xilinx GT phy lane for USB controller (phy_init).
3. De-assert the USB controller resets and configure PIPE.
4. Wait for PLL of the GT lane used by USB to be locked (phy_power_on).
The dwc3 core by default does the phy_init() and phy_power_on() but the def=
ault sequence doesn't work with Xilinx platforms. Because of this reason, w=
e have introduced this new driver to support the new sequence.

>=20
> > +	if (ret < 0) {
> > +		phy_exit(priv_data->usb3_phy);
> > +		goto err;
> > +	}
> > +
> > +	ret =3D dwc3_xlnx_rst_deassert(priv_data->apbrst);
> > +	if (ret < 0) {
> > +		dev_err(dev, "%s: %d: Failed to release reset\n",
> > +			__func__, __LINE__);
> > +		goto err;
> > +	}
> > +
> > +	/* Set PIPE power present signal */
> > +	writel(PIPE_POWER_ON, priv_data->regs + PIPE_POWER_OFFSET);
> > +
> > +	/* Clear PIPE CLK signal */
> > +	writel(PIPE_CLK_OFF, priv_data->regs + PIPE_CLK_OFFSET);
>=20
> shouldn't this be hidden under clk_enable()?

Though its naming suggests something related to clock framework, it is a re=
gister in the Xilinx USB controller space which configures the PIPE clock c=
oming from Serdes.

>=20
> > +	ret =3D dwc3_xlnx_rst_deassert(priv_data->crst);
> > +	if (ret < 0) {
> > +		dev_err(dev, "%s: %d: Failed to release reset\n",
> > +			__func__, __LINE__);
> > +		goto err;
> > +	}
> > +
> > +	ret =3D dwc3_xlnx_rst_deassert(priv_data->hibrst);
> > +	if (ret < 0) {
> > +		dev_err(dev, "%s: %d: Failed to release reset\n",
> > +			__func__, __LINE__);
> > +		goto err;
> > +	}
> > +
> > +	ret =3D phy_power_on(priv_data->usb3_phy);
> > +	if (ret < 0) {
> > +		phy_exit(priv_data->usb3_phy);
> > +		goto err;
> > +	}
> > +
> > +	/*
> > +	 * This routes the usb dma traffic to go through CCI path instead
> > +	 * of reaching DDR directly. This traffic routing is needed to
> > +	 * make SMMU and CCI work with USB dma.
> > +	 */
> > +	if (of_dma_is_coherent(dev->of_node) || dev->iommu_group) {
> > +		reg =3D readl(priv_data->regs + XLNX_USB_COHERENCY);
> > +		reg |=3D XLNX_USB_COHERENCY_ENABLE;
> > +		writel(reg, priv_data->regs + XLNX_USB_COHERENCY);
> > +	}
> > +
> > +err:
> > +	return ret;
> > +}
> > +
> > +static int dwc3_xlnx_probe(struct platform_device *pdev)
> > +{
> > +	struct dwc3_xlnx	*priv_data;
> > +	struct device		*dev =3D &pdev->dev;
> > +	struct device_node	*np =3D dev->of_node;
> > +	struct resource		*res;
> > +	void __iomem		*regs;
> > +	int			ret;
> > +
> > +	priv_data =3D devm_kzalloc(dev, sizeof(*priv_data), GFP_KERNEL);
> > +	if (!priv_data)
> > +		return -ENOMEM;
> > +
> > +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	if (!res) {
> > +		dev_err(dev, "missing memory resource\n");
> > +		return -ENODEV;
> > +	}
>=20
> you don't need to check res here. devm_ioremap_resource() already does
> that for you.
>=20
> > +	regs =3D devm_ioremap_resource(&pdev->dev, res);
> > +	if (IS_ERR(regs))
> > +		return PTR_ERR(regs);
>=20
> this looks like it could use an error message.
>=20
> > +	/* Store the usb control regs into priv_data for further usage */
>=20
> pointless comment.
>=20
> > +	priv_data->regs =3D regs;
> > +
>=20
> unnecessary blank line.
>=20
> > +	priv_data->dev =3D dev;
> > +
> > +	platform_set_drvdata(pdev, priv_data);
> > +
> > +	ret =3D clk_bulk_get_all(priv_data->dev, &priv_data->clks);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	priv_data->num_clocks =3D ret;
> > +
> > +	ret =3D clk_bulk_prepare_enable(priv_data->num_clocks, priv_data-
> >clks);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (of_device_is_compatible(pdev->dev.of_node, "xlnx,zynqmp-dwc3"))
> {
> > +		ret =3D dwc3_xlnx_init_zynqmp(priv_data);
> > +		if (ret)
> > +			goto err_clk_put;
> > +	}
>=20
> instead, you could pass a pointer to dwc3_xlnx_init_zynqmp() as driver
> data and just call it unconditionally. It would avoid the compatible
> check here.
>=20
> > +	if (of_device_is_compatible(pdev->dev.of_node, "xlnx,versal-dwc3")) {
> > +		ret =3D dwc3_xlnx_init_versal(priv_data);
> > +		if (ret)
> > +			goto err_clk_put;
> > +	}
>=20
> same as above
>=20
> > +	ret =3D of_platform_populate(np, NULL, NULL, dev);
> > +	if (ret)
> > +		goto err_clk_put;
> > +
> > +	pm_runtime_set_active(dev);
> > +	pm_runtime_enable(dev);
> > +	pm_suspend_ignore_children(dev, false);
> > +	pm_runtime_get_sync(dev);
> > +
> > +	pm_runtime_forbid(dev);
>=20
> why forbid? You already have a get_sync()
>=20
> > +	return 0;
> > +
> > +err_clk_put:
> > +	clk_bulk_disable_unprepare(priv_data->num_clocks, priv_data->clks);
> > +	clk_bulk_put_all(priv_data->num_clocks, priv_data->clks);
> > +
> > +	return ret;
> > +}
> > +
> > +static int dwc3_xlnx_remove(struct platform_device *pdev)
> > +{
> > +	struct dwc3_xlnx	*priv_data =3D platform_get_drvdata(pdev);
> > +	struct device		*dev =3D &pdev->dev;
> > +
> > +	of_platform_depopulate(dev);
> > +
> > +	clk_bulk_disable_unprepare(priv_data->num_clocks, priv_data->clks);
> > +	clk_bulk_put_all(priv_data->num_clocks, priv_data->clks);
> > +	priv_data->num_clocks =3D 0;
> > +
> > +	pm_runtime_disable(dev);
> > +	pm_runtime_put_noidle(dev);
> > +	pm_runtime_set_suspended(dev);
> > +
> > +	return 0;
> > +}
> > +
> > +#ifdef CONFIG_PM
> > +static int dwc3_xlnx_runtime_suspend(struct device *dev)
> > +{
> > +	struct dwc3_xlnx	*priv_data =3D dev_get_drvdata(dev);
> > +
> > +	clk_bulk_disable(priv_data->num_clocks, priv_data->clks);
> > +
> > +	return 0;
> > +}
> > +
> > +static int dwc3_xlnx_runtime_idle(struct device *dev)
> > +{
> > +	pm_runtime_mark_last_busy(dev);
> > +	pm_runtime_autosuspend(dev);
> > +
> > +	return 0;
> > +}
> > +
> > +static int dwc3_xlnx_runtime_resume(struct device *dev)
> > +{
> > +	struct dwc3_xlnx	*priv_data =3D dev_get_drvdata(dev);
> > +
> > +	return clk_bulk_enable(priv_data->num_clocks, priv_data->clks);
> > +}
> > +#endif /* CONFIG_PM */
> > +
> > +#ifdef CONFIG_PM_SLEEP
> > +static int dwc3_xlnx_suspend(struct device *dev)
> > +{
> > +	struct dwc3_xlnx *priv_data =3D dev_get_drvdata(dev);
> > +
> > +	/* Disable the clocks */
> > +	clk_bulk_disable(priv_data->num_clocks, priv_data->clks);
> > +
> > +	return 0;
> > +}
> > +
> > +static int dwc3_xlnx_resume(struct device *dev)
> > +{
> > +	struct dwc3_xlnx *priv_data =3D dev_get_drvdata(dev);
> > +
> > +	return clk_bulk_enable(priv_data->num_clocks, priv_data->clks);
> > +}
>=20
> you have the same implementation for both types of suspend/resume. Maybe
> extract dwc3_xlnx_{suspend,resume}_common() and just call it from both
> callbacks?

Going forward we have a plan to add Hibernation handling calls in dwc3_xlnx=
_suspend/resume functions.
For that reason, these APIs are kept separate. If you insist, I can make th=
em common for now and separate them later when I add hibernation code.

>=20
> > +#endif /* CONFIG_PM_SLEEP */
> > +
> > +static const struct dev_pm_ops dwc3_xlnx_dev_pm_ops =3D {
> > +	SET_SYSTEM_SLEEP_PM_OPS(dwc3_xlnx_suspend, dwc3_xlnx_resume)
> > +	SET_RUNTIME_PM_OPS(dwc3_xlnx_runtime_suspend,
> dwc3_xlnx_runtime_resume,
> > +			   dwc3_xlnx_runtime_idle)
>=20
> seems like it could be replaced with UNIVERSAL_PM_OPS with minor
> modifications.
>=20
> --
> balbi

Thanks,
Manish
