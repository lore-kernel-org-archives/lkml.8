Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C9CC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 05:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 500292075D
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 05:31:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="eiktJ9AZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbgIBFbP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 01:31:15 -0400
Received: from mail-eopbgr70075.outbound.protection.outlook.com ([40.107.7.75]:13065
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725774AbgIBFbM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 01:31:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W18XlFZuMCr9N35qapg9rFOOMD/nR1NZ8g+qed4rq+853r2RMxdmJaKwDZ+2wBMn0ok1HwdoCdXz9tG9H1/A5mNHaQwKqSG9zs70v5G3USHCJufK9iKLgyMg20xmrGNGZjCyeUbl33dZbkgHEh23vvDWdhjpv/hzxEbNXWyM+6l3+4bDDiccMg8aA/m9ECd+jad7zLXg03kJwkdKTWvfjjmOZZa4v6J1sfyxFmjPv4Bb3wFJMJLhXJI5UDi6G0MDu2czpHC66cFsumuui8mWtzM+GQnb2v8sBJjZikS1oo2YlCzY9SzVPa2PYyUbHWtROnk8fZZUlQFW+jMB7AGkGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jNgYDr5OM8sXcVMM8AYRtIU0kJ10o5wQzjX/8kZHIpk=;
 b=W2ymdqwUITyxDz5fwMUDOmKm8wy2tpkiFZHDncDfy67pPvQtVmH0GoA5hrymwskE0gks853RK3mkI+QdbgWa42Qs6AF1iswOjTDV9jiwPhrX/YF2J/kVevgD5PlMKQ5fMA+pb3qEC4oM+hL+WPTFcoS6Q4f7JgpgEp40PXEd44x/yK2oOaC/9g/CkV/qXFSGWzLn15tIuryars9R7S5OICjZYmk1h/sIMYpGWWcWSaO9wCSJn+aiSZL8h+tiFnyeB7mqrYLUrHtkgYmhjS+YMxkPtor5K+iu8W97GEh5nTQVsbkKRLJH1pAa5hW2rTC0rde1ElqqLzK9QhZL+WrfVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jNgYDr5OM8sXcVMM8AYRtIU0kJ10o5wQzjX/8kZHIpk=;
 b=eiktJ9AZLy2/2+LPzCgQuEN7DoBcGeVTIhlnCvoG/OkrLfMf92H0bZgk9NiJYpUsfQITrJrZ1e8HQMd1Dg/myrvdsp8m3XUGXzIJRab59uwK+RoEPAJtkU1YyUGnnTu5gfE7GEm5gnmC00gXRgW+P7lkJ6nUTzuU0MnOb6h9kBI=
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com (2603:10a6:20b:118::20)
 by AM5PR0401MB2595.eurprd04.prod.outlook.com (2603:10a6:203:2f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.25; Wed, 2 Sep
 2020 05:31:06 +0000
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::1023:be8d:40c:efe1]) by AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::1023:be8d:40c:efe1%3]) with mapi id 15.20.3348.015; Wed, 2 Sep 2020
 05:31:06 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Matthias Kaehlcke <mka@chromium.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Bastien Nocera <hadess@hadess.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [RFC PATCH] USB: misc: Add usb_hub_pwr driver
Thread-Topic: [RFC PATCH] USB: misc: Add usb_hub_pwr driver
Thread-Index: AQHWgJ2O9T1DMOMaDk2K+eB9hhc5F6lU0zIA
Date:   Wed, 2 Sep 2020 05:31:06 +0000
Message-ID: <20200902053048.GB6837@b29397-desktop>
References: <20200901132005.RFC.1.I7c9a1f1d6ced41dd8310e8a03da666a32364e790@changeid>
In-Reply-To: <20200901132005.RFC.1.I7c9a1f1d6ced41dd8310e8a03da666a32364e790@changeid>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 16606545-e832-4768-12e3-08d84f0163ea
x-ms-traffictypediagnostic: AM5PR0401MB2595:
x-microsoft-antispam-prvs: <AM5PR0401MB2595C36122DB20098C9EE5678B2F0@AM5PR0401MB2595.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +q37tAfE1x9MgfEvWNyT/53Ze/b62FgMk7ExdHqHDjJRsQD435PcjWOEK6Rp5Cv+eRIbxoUF5SZ+uofXSzARriyGAGlwu0Iis5yVuoHsDKjeJt/dTbgcq5LitJxH8uMS6/LfqaFQvgsLFO7yC9y90o3N+HSCmIQZbAAnMxCJsgJuFusZYNfxf7gXXC2j/hYcSkYsttIUK2VuxMolfkuUm95UwH6kWQQPdENFtqzTwdPVaYXX0CmMbTmsgHT4sDVvAtMB5i6ISfAENvNK1WOY0BxLzfUPDBcNeKQOtk1O1fmGN+PYFxEQSFaPNL1OtoI+eGPWlt/cSZU+1ZGXyL1BUft1RHBqQDmtSny5/WxQ96ZQAwZDBhqRlNcxwmQBFPH5r5yiS5Yfbu9v3CKV/MD7Aw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7157.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(136003)(376002)(346002)(366004)(396003)(39860400002)(6506007)(8676002)(6512007)(76116006)(966005)(71200400001)(1076003)(53546011)(91956017)(66946007)(7416002)(9686003)(6916009)(8936002)(44832011)(186003)(30864003)(54906003)(33656002)(26005)(86362001)(5660300002)(2906002)(33716001)(6486002)(478600001)(66556008)(64756008)(66446008)(316002)(66476007)(4326008)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: AE8MBWN3NZqYghDP7/oYRQpvwKIZ1YCyrRCOr4lwldM0FNarKUoJYXBXJeRKcliuleQlkNm6OLPG/arRZWe3N72fkx1LQgwIqGSXMgfa3M5b8dN183dyQyBrlT87iApJszxesCo3pSAJFXOaexOYAqIba0pTdHjlVvkrqbuN3iUEUPvHs5ye4JluXkWO2W7F6UFX0jGjV2JYHlfF/f5BSIoYN2Vui4FaPX2dH6lTFwRhEmffIAV1J/fvSU8HZpXe8J77EJn/5G3M9zAwf2As1Bc5CsWsflfVYmBZSSwg+/qFWc+nRODLx3W26RULkFWCJYyzjeQZRIRV6jrFdnRE6ePQXpbPq97v6oXMc23VdMML2dlfun2M05efb6B0BPhrCc2eNtyQNHVnrL9tI0TWZLs5BeyFzSafvlcHcuuHQ6yiWMS60zGyT486S4kV8PW1iW8Da+krWuvXiswhluU6Ej5U4pPH6Klf+wLr58kiAygtFzqd+rH1ZRijuNDs44NlXIhB9zGTxxaS96ptXkr3C9oY3mF83NwJVBGOWDyhEOlGAOKp7asKeBKu75Ms+/Hg4kti/S0H2r5eKkmhHn/oB7skbgKKFP6xxB+X+HyHY65u7k98nfxrfE8eGgskFlyE+karmbhtEQSqJCB4gqb3hA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7CE811B8D5F9B742BD977A705B839100@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7157.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16606545-e832-4768-12e3-08d84f0163ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2020 05:31:06.2193
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F6V7KKDBwoNjFJe+i7wiYawbbl59uwPy7fi/opWmYB73LrQV+yQjg5Ch1zqUUO2S+cBDSO2p7jqEORPcdbRLZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0401MB2595
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-09-01 13:21:43, Matthias Kaehlcke wrote:
> The driver combo usb_hub_pwr/usb_hub_psupply allows to control
> the power supply of an onboard USB hub.
>=20
> The drivers address two issues:
>  - a USB hub needs to be powered before it can be discovered
>  - battery powered devices may want to switch the USB hub off
>    during suspend to extend battery life
>=20
> The regulator of the hub is controlled by the usb_hub_psupply
> platform driver. The regulator is switched on when the platform
> device is initialized, which enables discovery of the hub. The
> driver provides an external interface to enable/disable the
> power supply which is used by the usb_hub_pwr driver.
>=20
> The usb_hub_pwr extends the generic USB hub driver. The device is
> initialized when the hub is discovered by the USB subsystem. It
> uses the usb_hub_psupply interface to make its own request to
> enable the regulator (increasing the use count to 2).
>=20
> During system suspend usb_hub_pwr checks if any wakeup capable
> devices are connected to the hub. If not it 'disables' the hub
> regulator (decreasing the use count to 1, hence the regulator
> stays enabled for now). When the usb_hub_psupply device suspends
> it disables the hub regulator unconditionally (decreasing the use
> count to 0 or 1, depending on the actions of usb_hub_pwr). This
> is done to allow the usb_hub_pwr device to control the state of
> the regulator during system suspend.
>=20
> Upon resume usb_hub_psupply enables the regulator again, the
> usb_hub_pwr device does the same if it disabled the regulator
> during resume.

Hi Matthias,

I did similar several years ago [1], but the concept (power sequence)
doesn't be accepted by power maintainer. Your patch introduce an new
way to fix this long-term issue, I have an idea to fix it more generally.

- Create a table (say usb_pm_table) for USB device which needs to do
initial power on and power management during suspend suspend/resume based
on VID and PID, example: usb/core/quirks.c
- After hub (both roothub and intermediate hub) device is created, search
the DT node under this hub, and see if the device is in usb_pm_table. If
it is in it, create a platform device, say usb-power-supply, and the
related driver is like your usb_hub_psupply.c, the parent of this device
is controller device.
- After this usb-power-supply device is probed, do initial power on at
probe, eg, clock, regulator, reset-gpio.
- This usb-power-supply device system suspend operation should be called af=
ter
onboard device has suspended since it is created before it. No runtime PM o=
ps
are needed for it.
- When the hub is removed, delete this platform device.

What's your opinion?

[1] https://lore.kernel.org/lkml/1498027328-25078-1-git-send-email-peter.ch=
en@nxp.com/

Peter
>=20
> Co-developed-by: Ravi Chandra Sadineni <ravisadineni@chromium.org>
> Signed-off-by: Ravi Chandra Sadineni <ravisadineni@chromium.org>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> The driver currently only supports a single power supply. This should
> work for most/many configurations/hubs, support for multiple power
> supplies can be added later if needed.
>=20
> No DT bindings are included since this is just a RFC. Here is a DT
> example:
>=20
> usb_hub_psupply: usb-hub-psupply {
>     compatible =3D "linux,usb_hub_psupply";
>     vdd-supply =3D <&pp3300_hub>;
> };
>=20
> &usb_1_dwc3 {
>     /* 2.0 hub on port 1 */
>     hub@1 {
>         compatible =3D "usbbda,5411";
>         reg =3D <1>;
>         psupply =3D <&usb_hub_psupply>;
>     };
>=20
>     /* 3.0 hub on port 2 */
>     hub@2 {
>         compatible =3D "usbbda,411";
>         reg =3D <2>;
>         psupply =3D <&usb_hub_psupply>;
>     };
> };
>=20
>  drivers/usb/misc/Kconfig           |  14 +++
>  drivers/usb/misc/Makefile          |   1 +
>  drivers/usb/misc/usb_hub_psupply.c | 112 ++++++++++++++++++
>  drivers/usb/misc/usb_hub_psupply.h |   9 ++
>  drivers/usb/misc/usb_hub_pwr.c     | 177 +++++++++++++++++++++++++++++
>  5 files changed, 313 insertions(+)
>  create mode 100644 drivers/usb/misc/usb_hub_psupply.c
>  create mode 100644 drivers/usb/misc/usb_hub_psupply.h
>  create mode 100644 drivers/usb/misc/usb_hub_pwr.c
>=20
> diff --git a/drivers/usb/misc/Kconfig b/drivers/usb/misc/Kconfig
> index 6818ea689cd9..79ed50e6a7bf 100644
> --- a/drivers/usb/misc/Kconfig
> +++ b/drivers/usb/misc/Kconfig
> @@ -275,3 +275,17 @@ config USB_CHAOSKEY
> =20
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called chaoskey.
> +
> +config USB_HUB_PWR
> +	tristate "Control power supply for onboard USB hubs"
> +	depends on PM
> +	help
> +	  Say Y here if you want to control the power supply of an
> +	  onboard USB hub. The driver switches the power supply of the
> +	  hub on, to make sure the hub can be discovered. During system
> +	  suspend the power supply is switched off, unless a wakeup
> +	  capable device is connected to the hub. This may reduce power
> +	  consumption on battery powered devices.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called usb_hub_pwr.
> diff --git a/drivers/usb/misc/Makefile b/drivers/usb/misc/Makefile
> index da39bddb0604..2bd02388ca62 100644
> --- a/drivers/usb/misc/Makefile
> +++ b/drivers/usb/misc/Makefile
> @@ -31,3 +31,4 @@ obj-$(CONFIG_USB_CHAOSKEY)		+=3D chaoskey.o
> =20
>  obj-$(CONFIG_USB_SISUSBVGA)		+=3D sisusbvga/
>  obj-$(CONFIG_USB_LINK_LAYER_TEST)	+=3D lvstest.o
> +obj-$(CONFIG_USB_HUB_PWR)		+=3D usb_hub_pwr.o usb_hub_psupply.o
> diff --git a/drivers/usb/misc/usb_hub_psupply.c b/drivers/usb/misc/usb_hu=
b_psupply.c
> new file mode 100644
> index 000000000000..6a155ae1f831
> --- /dev/null
> +++ b/drivers/usb/misc/usb_hub_psupply.c
> @@ -0,0 +1,112 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2020, Google LLC
> + */
> +
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/regulator/consumer.h>
> +
> +struct usb_hub_psupply_dev {
> +	struct regulator *vdd;
> +};
> +
> +int usb_hub_psupply_on(struct device *dev)
> +{
> +	struct usb_hub_psupply_dev *usb_hub_psupply =3D dev_get_drvdata(dev);
> +	int err;
> +
> +	err =3D regulator_enable(usb_hub_psupply->vdd);
> +	if (err) {
> +		dev_err(dev, "failed to enable regulator: %d\n", err);
> +		return err;
> +	}
> +
> +	return 0;
> +
> +}
> +EXPORT_SYMBOL_GPL(usb_hub_psupply_on);
> +
> +int usb_hub_psupply_off(struct device *dev)
> +{
> +	struct usb_hub_psupply_dev *usb_hub_psupply =3D dev_get_drvdata(dev);
> +	int err;
> +
> +	err =3D regulator_disable(usb_hub_psupply->vdd);
> +	if (err) {
> +		dev_err(dev, "failed to enable regulator: %d\n", err);
> +		return err;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(usb_hub_psupply_off);
> +
> +static int usb_hub_psupply_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct usb_hub_psupply_dev *usb_hub_psupply;
> +
> +	usb_hub_psupply =3D devm_kzalloc(dev, sizeof(*usb_hub_psupply), GFP_KER=
NEL);
> +	if (!usb_hub_psupply)
> +		return -ENOMEM;
> +
> +	dev_set_drvdata(dev, usb_hub_psupply);
> +
> +	usb_hub_psupply->vdd =3D devm_regulator_get(dev, "vdd");
> +	if (IS_ERR(usb_hub_psupply->vdd))
> +		return PTR_ERR(usb_hub_psupply->vdd);
> +
> +	return usb_hub_psupply_on(dev);
> +}
> +
> +static int usb_hub_psupply_remove(struct platform_device *pdev)
> +{
> +	return usb_hub_psupply_off(&pdev->dev);
> +}
> +
> +static int usb_hub_psupply_suspend(struct platform_device *pdev, pm_mess=
age_t msg)
> +{
> +	return usb_hub_psupply_off(&pdev->dev);
> +}
> +
> +static int usb_hub_psupply_resume(struct platform_device *pdev)
> +{
> +	return usb_hub_psupply_on(&pdev->dev);
> +}
> +
> +static const struct of_device_id usb_hub_psupply_match[] =3D {
> +	{ .compatible =3D "linux,usb_hub_psupply" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, usb_hub_psupply_match);
> +
> +static struct platform_driver usb_hub_psupply_driver =3D {
> +	.probe =3D usb_hub_psupply_probe,
> +	.remove =3D usb_hub_psupply_remove,
> +	.suspend =3D usb_hub_psupply_suspend,
> +	.resume =3D usb_hub_psupply_resume,
> +	.driver =3D {
> +		.name =3D "usb-hub-psupply",
> +		.of_match_table =3D usb_hub_psupply_match,
> +	},
> +};
> +
> +static int __init usb_hub_psupply_init(void)
> +{
> +	return platform_driver_register(&usb_hub_psupply_driver);
> +}
> +device_initcall(usb_hub_psupply_init);
> +
> +static void __exit usb_hub_psupply_exit(void)
> +{
> +	platform_driver_unregister(&usb_hub_psupply_driver);
> +}
> +module_exit(usb_hub_psupply_exit);
> +
> +MODULE_AUTHOR("Matthias Kaehlcke <mka@chromium.org>");
> +MODULE_DESCRIPTION("USB Hub Power Supply");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/usb/misc/usb_hub_psupply.h b/drivers/usb/misc/usb_hu=
b_psupply.h
> new file mode 100644
> index 000000000000..284e88f45fcf
> --- /dev/null
> +++ b/drivers/usb/misc/usb_hub_psupply.h
> @@ -0,0 +1,9 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +
> +#ifndef _USB_HUB_PSUPPLY_H
> +#define _USB_HUB_PSUPPLY_H
> +
> +int usb_hub_psupply_on(struct device *dev);
> +int usb_hub_psupply_off(struct device *dev);
> +
> +#endif /* _USB_HUB_PSUPPLY_H */
> diff --git a/drivers/usb/misc/usb_hub_pwr.c b/drivers/usb/misc/usb_hub_pw=
r.c
> new file mode 100644
> index 000000000000..33945ca4a8c0
> --- /dev/null
> +++ b/drivers/usb/misc/usb_hub_pwr.c
> @@ -0,0 +1,177 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * USB hub power control
> + *
> + * Copyright (c) 2020, Google LLC
> + */
> +
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/power_supply.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/slab.h>
> +#include <linux/usb.h>
> +#include <linux/usb/hcd.h>
> +#include "../core/usb.h"
> +#include "usb_hub_psupply.h"
> +
> +#define VENDOR_ID_REALTEK	0x0bda
> +
> +struct usb_hub_pwr_dev {
> +	struct regulator *vdd;
> +	struct device *psupply_dev;
> +	bool powered_off;
> +};
> +
> +static struct device *usb_pwr_find_psupply_dev(struct device *dev)
> +{
> +	const phandle *ph;
> +	struct device_node *np;
> +	struct platform_device *pdev;
> +
> +	ph =3D of_get_property(dev->of_node, "psupply", NULL);
> +	if (!ph) {
> +		dev_err(dev, "failed to read 'psupply' property\n");
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	np =3D of_find_node_by_phandle(be32_to_cpu(*ph));
> +	if (!np) {
> +		dev_err(dev, "failed find device node for power supply\n");
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	pdev =3D of_find_device_by_node(np);
> +	of_node_put(np);
> +	if (!pdev)
> +		return ERR_PTR(-EPROBE_DEFER);
> +
> +	return &pdev->dev;
> +}
> +
> +static int usb_hub_pwr_probe(struct usb_device *udev)
> +{
> +	struct device *dev =3D &udev->dev;
> +	struct usb_hub_pwr_dev *uhpw;
> +	struct device *psupply_dev;
> +	int err;
> +
> +	/* ignore supported hubs without device tree node */
> +	if (!dev->of_node)
> +		return -ENODEV;
> +
> +	psupply_dev =3D usb_pwr_find_psupply_dev(dev);
> +	if (IS_ERR(psupply_dev))
> +		return PTR_ERR(psupply_dev);
> +
> +	err =3D usb_generic_driver_probe(udev);
> +	if (err) {
> +		put_device(psupply_dev);
> +		return err;
> +	}
> +
> +	uhpw =3D devm_kzalloc(dev, sizeof(*uhpw), GFP_KERNEL);
> +	if (!uhpw) {
> +		put_device(psupply_dev);
> +		return -ENOMEM;
> +	}
> +
> +	dev_set_drvdata(&udev->dev, uhpw);
> +
> +	uhpw->psupply_dev =3D psupply_dev;
> +
> +	err =3D usb_hub_psupply_on(psupply_dev);
> +	if (err) {
> +		dev_err(dev, "failed to enable regulator: %d\n", err);
> +		put_device(psupply_dev);
> +		return err;
> +	}
> +
> +	return 0;
> +}
> +
> +static void usb_hub_pwr_disconnect(struct usb_device *udev)
> +{
> +	struct usb_hub_pwr_dev *uhpw =3D dev_get_drvdata(&udev->dev);
> +
> +	usb_hub_psupply_off(uhpw->psupply_dev);
> +	put_device(uhpw->psupply_dev);
> +}
> +
> +static int usb_hub_pwr_suspend(struct usb_device *udev, pm_message_t msg=
)
> +{
> +	struct usb_hub_pwr_dev *uhpw =3D dev_get_drvdata(&udev->dev);
> +	int err;
> +
> +	err =3D usb_generic_driver_suspend(udev, msg);
> +	if (err)
> +		return err;
> +
> +	if (!usb_wakeup_enabled_descendants(udev)) {
> +		usb_port_disable(udev);
> +
> +		err =3D usb_hub_psupply_off(uhpw->psupply_dev);
> +		if (err)
> +			return err;
> +
> +		uhpw->powered_off =3D true;
> +	}
> +
> +	return 0;
> +}
> +
> +static int usb_hub_pwr_resume(struct usb_device *udev, pm_message_t msg)
> +{
> +	struct usb_hub_pwr_dev *uhpw =3D dev_get_drvdata(&udev->dev);
> +	int err;
> +
> +	if (uhpw->powered_off) {
> +		err =3D usb_hub_psupply_on(uhpw->psupply_dev);
> +		if (err)
> +			return err;
> +
> +		uhpw->powered_off =3D false;
> +	}
> +
> +	return usb_generic_driver_resume(udev, msg);
> +}
> +
> +static const struct usb_device_id hub_id_table[] =3D {
> +	{ .idVendor =3D VENDOR_ID_REALTEK,
> +	  .idProduct =3D 0x0411, /* RTS5411 USB 3.0 */
> +	  .match_flags =3D USB_DEVICE_ID_MATCH_DEVICE },
> +	{ .idVendor =3D VENDOR_ID_REALTEK,
> +	  .idProduct =3D 0x5411, /* RTS5411 USB 2.0 */
> +	  .match_flags =3D USB_DEVICE_ID_MATCH_DEVICE },
> +	{},
> +};
> +
> +MODULE_DEVICE_TABLE(usb, hub_id_table);
> +
> +static struct usb_device_driver usb_hub_pwr_driver =3D {
> +
> +	.name =3D "usb-hub-pwr",
> +	.probe =3D usb_hub_pwr_probe,
> +	.disconnect =3D usb_hub_pwr_disconnect,
> +	.suspend =3D usb_hub_pwr_suspend,
> +	.resume =3D usb_hub_pwr_resume,
> +	.id_table =3D hub_id_table,
> +};
> +
> +static int __init usb_hub_pwr_driver_init(void)
> +{
> +	return usb_register_device_driver(&usb_hub_pwr_driver, THIS_MODULE);
> +}
> +
> +static void __exit usb_hub_pwr_driver_exit(void)
> +{
> +	usb_deregister_device_driver(&usb_hub_pwr_driver);
> +}
> +
> +module_init(usb_hub_pwr_driver_init);
> +module_exit(usb_hub_pwr_driver_exit);
> +
> +MODULE_AUTHOR("Matthias Kaehlcke <mka@chromium.org>");
> +MODULE_DESCRIPTION("USB Hub Power Control");
> +MODULE_LICENSE("GPL v2");
> --=20
> 2.28.0.402.g5ffc5be6b7-goog
>=20

--=20

Thanks,
Peter Chen=
