Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD57C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3501120775
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:40:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kMCZrtAC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389468AbgF2UkA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731714AbgF2TOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:14:12 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on20618.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e1a::618])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149AEC0A8883;
        Mon, 29 Jun 2020 00:26:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mcPIIM0J49awy5mMi1lCWfQzPIyIZRC84rprM/zKJ2Bev73l9Pq6hK02VNXsMUz/HsNjOg9BDjW4vbB6epLtoCnrQaLvggq7E9ivOnqLncred8GXpzBSp9fq41m3krpuhVY8zNCb0DCX1u4cc0pBl6iIWfI78b5ECc0JYAx8K6QWyHY4TGB2wyi1xfj29YlPZC5n1IxhXf1BJLdEokhCcesb5CVMTQKTpPGo+rQYftEZsBuCJrcCY2Hm6WnkqUcGnFSmIPFrZYQ03zPpfqSq2qgKG73OsknQC0tTweWViU/Gay8iDvyKfZ0GgNKgxZMA8OLOojDAxXsLUGhIvx1c/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZDsw9jv65xNcBYVWYB2Md7url5wOA/++AE8vL2DTvE=;
 b=fmOkoJfelc5kmOxOBjt5N/hdess9x9lgleez2qCCm1R1FM6kkmvGKABnETAyBgB16DS3IvTbcEQYDN7H5PxIte2EqpSrgElvyh03p5919QcXMqzNfr8PtP5BGfPHl0kcj5gddiqCfN316NVMMV7AUwJQaHPNvnbrom7nOa/Fd6f5WoZ8oPYfkj3mgzw2ZCQn1Fr1mX81g/aWZSL/L1CxtsMa4f5lz3IpnlIEmI5K2u7n8VP318xM1OHQyHY0Ro8hawXlWZle8OBUcqDphwzt75DVqp3p9ncw1LY/DWlWuBe2d7KrUgjER83204KeLzERzpbyXFplNjWcsa+IyUaT+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZDsw9jv65xNcBYVWYB2Md7url5wOA/++AE8vL2DTvE=;
 b=kMCZrtACK+hqAKC1EAwyFArBlbtMC1zGdAMq5iXQVm8nUsKoa/Kw4e0aDAq4/db1FgtSJES9esF/cZoVHI7gzdu+1qGuO7Guew03pkafPSijVyoY3yjG8BpVkeq2YPBtrIWtx5sPaBdzEbCU2q410IDHKWcdUpg+K7wV6w2wpLE=
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com (2603:10a6:20b:118::20)
 by AM5PR04MB3026.eurprd04.prod.outlook.com (2603:10a6:206:11::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.26; Mon, 29 Jun
 2020 07:26:41 +0000
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::1101:adaa:ee89:af2a]) by AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::1101:adaa:ee89:af2a%3]) with mapi id 15.20.3131.027; Mon, 29 Jun 2020
 07:26:41 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Philippe Schenker <philippe.schenker@toradex.com>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Stefan Agner <stefan.agner@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: chipidea: fix ci_irq for role-switching use-case
Thread-Topic: [PATCH] usb: chipidea: fix ci_irq for role-switching use-case
Thread-Index: AQHWS6lrNGtWbd2boEmTo3bADIlBSqjvNguA
Date:   Mon, 29 Jun 2020 07:26:41 +0000
Message-ID: <20200629072703.GC30684@b29397-desktop>
References: <20200626110311.221596-1-philippe.schenker@toradex.com>
In-Reply-To: <20200626110311.221596-1-philippe.schenker@toradex.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: toradex.com; dkim=none (message not signed)
 header.d=none;toradex.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fb58a959-e0ba-418a-be7d-08d81bfdc4a5
x-ms-traffictypediagnostic: AM5PR04MB3026:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <AM5PR04MB302618210141B1FE9C9AF3818B6E0@AM5PR04MB3026.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 044968D9E1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TX7OxMzli9EDZGdG2/ioiyDWUnuyT6L8t+9F1rf3DvZVe9aPVWe/aFNhmxb8NRKiaPL43RtSouJPICvsTN8fkbd5gJnlUMgP7nGYiPuSwdZybq2ty/oGi5Gc9lSsvHEe0hnq7rke3JyojZKlOW/hFsgYMeaUXvqio+sHh9T2yrHtFg47ULWZIekLZuPoIH3JpUl4JbG3ZeVT+EzKTZ8QUbwEnAzLuZvDHM9evkyyDIvHXJHzAvfPMgG0HbrqNTpHtP1bq3kTftdz2w3C4Ay531epE0pOVkKspdmdugCCLLvHZBYKXPh/zmUXC7Dpu/JlnvoifxfQH6xMy/T+C6qHQA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7157.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(7916004)(4636009)(376002)(39860400002)(346002)(396003)(366004)(136003)(1076003)(26005)(2906002)(71200400001)(66946007)(8676002)(5660300002)(76116006)(91956017)(186003)(53546011)(33716001)(6506007)(33656002)(66476007)(66556008)(64756008)(6916009)(66446008)(44832011)(83380400001)(6486002)(8936002)(54906003)(316002)(478600001)(86362001)(4326008)(9686003)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: dnQiICs8RVMBeA2LtvvOEHyUnonGDpnuIF4FuW2vRaPl/MLjvLMdranttqxdLzP2u21V6bRMBzHDrf4uIzBgU5cF1z+7rt7l1SMlqKxEosHt6yqFOklLSCCgaVnocZaf6y0ZiwRQCcHzOOzObTGlZ+7eJ+PHrATLzKWq6CZebt5fOvdJujZL50awnqCp2V5stBbd3FDlxh6dSwfd9P0xMHYXpTVvfcQunCl83d+Yc0rGspOQe8QDix35ZMuiM6JcXD08L+o8udYhg55pJFQemLuovN7XKQJMgoVisOD4aHWfS8Ku635ODrg5IQki9T2/O3pUPnl+0ss3pmGUmZIbj1ZoFitOmeyEcYoiWxk3DugzI/KmdbFP2HtBZ5u/YKJtkyxEyqlEFYVbWNfUfG5rE8ItKu7E4oqgwbbYkK42pMGmXOiDtalSyuXZWhgI2VfBc4AeXTTyEQg9TJx3VNVcV4yLeCkis3/fml9qdgNLFPM=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3F9A289E77C7A64AA875B803FD787BD5@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7157.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb58a959-e0ba-418a-be7d-08d81bfdc4a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2020 07:26:41.1378
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n9/2cf24CGbg9Pe4wDw9pVkBDoBIY1FGpM1+TwHB7hrlj8F+wuQjzg6NiX0xVwWyQ72J8N6gh5GQYa+51m1VYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB3026
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-06-26 13:03:11, Philippe Schenker wrote:
> If the hardware is in low-power-mode and one plugs in device or host
> it did not switch the mode due to the early exit out of the interrupt.

Do you mean there is no coming call for role-switch? Could you please share
your dts changes? Try below patch:


diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
index e8ce300ad490..9e10dcfeb98f 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -1313,6 +1313,29 @@ static void ci_controller_suspend(struct ci_hdrc *ci=
)
 	enable_irq(ci->irq);
 }
=20
+/*
+ * Handle the wakeup interrupt triggered by extcon connector
+ * We need to call ci_irq again for extcon since the first
+ * interrupt (wakeup int) only let the controller be out of
+ * low power mode, but not handle any interrupts.
+ */
+static void ci_extcon_wakeup_int(struct ci_hdrc *ci)
+{
+	struct ci_hdrc_cable *cable_id, *cable_vbus;
+	u32 otgsc =3D hw_read_otgsc(ci, ~0);
+
+	cable_id =3D &ci->platdata->id_extcon;
+	cable_vbus =3D &ci->platdata->vbus_extcon;
+
+	if (!IS_ERR(cable_id->edev) && ci->is_otg &&
+		(otgsc & OTGSC_IDIE) && (otgsc & OTGSC_IDIS))
+		ci_irq(ci->irq, ci);
+
+	if (!IS_ERR(cable_vbus->edev) && ci->is_otg &&
+		(otgsc & OTGSC_BSVIE) && (otgsc & OTGSC_BSVIS))
+		ci_irq(ci->irq, ci);
+}
+
 static int ci_controller_resume(struct device *dev)
 {
 	struct ci_hdrc *ci =3D dev_get_drvdata(dev);
@@ -1343,6 +1366,7 @@ static int ci_controller_resume(struct device *dev)
 		enable_irq(ci->irq);
 		if (ci_otg_is_fsm_mode(ci))
 			ci_otg_fsm_wakeup_by_srp(ci);
+		ci_extcon_wakeup_int(ci);
 	}
=20
 	return 0;

>=20
> This patch fixes that behaviour and lets the rest of the code check if
> something has to be done. If nothing has to be done the same return
> value gets returned as before.

Before the controller leaving low power mode, otgsc value may not
correct since the controller/PHY is still in low power mode.

>=20
> Fixes: 1f874edcb731 ("usb: chipidea: add runtime power management support=
")
> Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
>=20
> ---
>=20
> Hi Peter
>=20
> During my investigation I found a bug in ci_irq. I would appreciate
> if you could review this. From what I see this patch should be save to ap=
ply.
>=20
> This patch does not solve all of our issues. When I have RUNTIME_PM
> enabled on imx6ull or imx7. RNDIS still does not come up. So there
> has to be another bug hiding somewhere in the Runtime PM code to prevent
> RNDIS from working properly. I quickly looked through your patches
> that added this stuff back in 2015 but couldn't spot anything related to
> usb gadget-mode.
>=20
> If you right away know where the problem could be hiding itself,
> I would appreciate a hint.
>=20

I need information for call trace for further suggestion.

Peter

>=20
> ---
>=20
>  drivers/usb/chipidea/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
> index 9a7c53d09ab4..5159420a23a4 100644
> --- a/drivers/usb/chipidea/core.c
> +++ b/drivers/usb/chipidea/core.c
> @@ -518,7 +518,7 @@ static irqreturn_t ci_irq(int irq, void *data)
>  		disable_irq_nosync(irq);
>  		ci->wakeup_int =3D true;
>  		pm_runtime_get(ci->dev);
> -		return IRQ_HANDLED;
> +		ret =3D IRQ_HANDLED;
>  	}
> =20
>  	if (ci->is_otg) {
> --=20
> 2.27.0
>=20

--=20

Thanks,
Peter Chen=
