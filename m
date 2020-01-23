Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04DCEC2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 15:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C351B214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 15:51:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="Txs+i29G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728988AbgAWPvp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 10:51:45 -0500
Received: from mail1.bemta26.messagelabs.com ([85.158.142.117]:36835 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726231AbgAWPvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 10:51:44 -0500
Received: from [85.158.142.204] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-6.bemta.az-b.eu-central-1.aws.symcld.net id 3E/50-01390-B01C92E5; Thu, 23 Jan 2020 15:51:39 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDJsWRWlGSWpSXmKPExsWSoS+Yoct9UDP
  O4MwzEYsn71azWdz/epTR4vKuOWwOzB4TFh1g97hzbQ+bx+dNcgHMUayZeUn5FQmsGb+/32cs
  eCxZsfNsK2sD4x7RLkZODkaBpcwSH+7zdTFyAdnHWCRu/FnKCOFsZpT43fuTDcRhETjBLPFi9
  24WkBYhgX4miQUzM0ASQgJ3GSV+7VrKCpJgE7CQmHziAViHiEALo8SciW/AOpgFHCVu733LBG
  ILC/hIvOi8yghiiwj4SlxecgzKNpL4MfM+G4jNIqAqsWLPHjCbVyBWonXfZmaIzXoSZ1u6wGZ
  yCuhL/Fz2ixniCVmJL42rmSF2iUvcejIfbJeEgIDEkj3nmSFsUYmXj/+xQtSnSpxsusEIEdeR
  OHv9CZStJDFv7hEoW1bi0vxuKNtXoqO9nRXC1pJ4/ucT1EwLiSXdrUD3cADZKhL/DlVChHMk7
  jyYwg5hq0nceNPBDFEiI/GwMx0UPBICs1gkFsxZxzyBUX8WkqshbB2JBbs/sUHY2hLLFr5mng
  UOCUGJkzOfsCxgZFnFaJlUlJmeUZKbmJmja2hgoGtoaKxromtkZKKXWKWbpJdaqpucmldSlAi
  U1UssL9YrrsxNzknRy0st2cQITEIphSwPdjB2fH2rd4hRkoNJSZTXwlUzTogvKT+lMiOxOCO+
  qDQntfgQowwHh5IEr/IOoJxgUWp6akVaZg4wIcKkJTh4lER4u/YDpXmLCxJzizPTIVKnGI05J
  rycu4iZ4/L1eYuYhVjy8vNSpcR5N4OUCoCUZpTmwQ2CJepLjLJSwryMDAwMQjwFqUW5mSWo8q
  8YxTkYlYR5iw8ATeHJzCuB2/cK6BQmoFPKddRATilJREhJNTAdFTm67bV1dsh75tcfzVq+JIT
  lN59Zb6Ogke18vuDVj6onpnFpF1JvcG3eHmWxTX/7ivvHL7HpPbycctSaqSFu8krDRfZWQiaZ
  F3763DYPNeb+l3tC673oNdGlVm1ndBznTZ5S0jHFJJNp6xOnkDV7q46fy9j78ax9lzWbn88to
  cUs3Rcal7H8PZPOxmfgP/tCk63SMf5r7aESaXz1AUzngk9cm7asRVm5W/DqBQWrj1vX5e99n3
  hJROFQRpPEhqxVZj1cInp3ru92vvKLTYH70tLlR5d++hbI/enE/D8TrBQXZm872bJApeWAlrv
  5OoWm3MhaLr3P72JidatY53goT+houB2nsYX1zJNzkiZKLMUZiYZazEXFiQB1r+asTwQAAA==
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-12.tower-249.messagelabs.com!1579794698!684606!1
X-Originating-IP: [104.47.17.104]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.44.25; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 15433 invoked from network); 23 Jan 2020 15:51:39 -0000
Received: from mail-db8eur05lp2104.outbound.protection.outlook.com (HELO EUR05-DB8-obe.outbound.protection.outlook.com) (104.47.17.104)
  by server-12.tower-249.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 23 Jan 2020 15:51:39 -0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m0otWf3iuWzPqLQdQG6bTqRU9Z1gVOQ6rqPZLdC8kdKBaMMqEvL++fF3Z24Ppgl0Lj6aMvAyJ1Bhlm8+d5QFs1f6Ep8rCaGIhSeWdpfB49ks3cnkp4/0/fUmCVqhb0vzE6nwtwdWgSDBCjEtnU4xRpsrlwP7dUW+6MkDy/ZzSnEu5av2T1uTZoR/BWwibKoT8PJJjdTiQllrZuG0lwtHEZn/iAMu0QTuHteiS7Hr20wHzNCFk5G6YB0a99S62geFqn0LTcx/PmJOaSLpznmdJP/xb5RpxgWc9lpLTw9o5K8dTQpF8m/bGFwnypXbCVUi0AQszzJAF6skXNkw07hlKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5CFsXL+yNlSt9UXwf2vniKK88G5zX2V/z4SLoqbtxno=;
 b=UC9q7tESCfXq/OcF0uZtuG3Ol8Rd97vC8P7FfU0GjYq9Ar/YNeogLBh6K5N015ckG0QlB646wzo37EWHRQ4OiJaWDSWlfQxeQeqR9dalBeqH07pei49hL0P8KwpFQIHfOqisS/gPfMiEsXRCPfQI8F/qEyN6AKFaOZUbZG1N7e0r5WvhgBW1cOwHtThnFD0/XED/sRV+lzePR0s+QVG3r2cjvSRycfbMPprld6YgZDRwVsmVu7LgVxW1X3CvW6KVFJBkM490MYvHWorYUPJiP+SI3y8Fx5a2B1WscDEG/JjPV+7rxxlIJiLsPSLjLXc6aafKRq/b4YanwLE6iU3fmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5CFsXL+yNlSt9UXwf2vniKK88G5zX2V/z4SLoqbtxno=;
 b=Txs+i29GnV0F7IAxA2Os5iiNHL3c/L7FhT8g2TJvqa76JVQg/eWAqZesOp5ldDLzYzp4VNF0oOoGbwumQJQhz7MUIbhiXEvRoXtb7Y6n70HZ1OfQ+pvC5mmNOyjG9B0U10JYzClqb5mbkPDayOuYvwK2ho7DQkO7rkm+o76v9BA=
Received: from AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM (20.177.116.141) by
 AM6PR10MB2614.EURPRD10.PROD.OUTLOOK.COM (20.179.2.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20; Thu, 23 Jan 2020 15:51:37 +0000
Received: from AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9be:9fca:6def:97c3]) by AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9be:9fca:6def:97c3%5]) with mapi id 15.20.2644.027; Thu, 23 Jan 2020
 15:51:37 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     Helmut Grohne <helmut.grohne@intenta.de>,
        Support Opensource <Support.Opensource@diasemi.com>,
        Lee Jones <lee.jones@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] mfd: da9062: enable being a system-power-controller
Thread-Topic: [PATCH 1/2] mfd: da9062: enable being a system-power-controller
Thread-Index: AQHVxVLd8ZSwK+YMLk+kKi398FPZzKf4e+UA
Date:   Thu, 23 Jan 2020 15:51:37 +0000
Message-ID: <AM6PR10MB226306BDE8575CED80071148800F0@AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM>
References: <20200107120559.GA700@laureti-dev>
In-Reply-To: <20200107120559.GA700@laureti-dev>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.225.80.228]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f8d0eda8-b1a9-42ca-faec-08d7a01c216b
x-ms-traffictypediagnostic: AM6PR10MB2614:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR10MB2614FBA31309B76BA4151146A70F0@AM6PR10MB2614.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 029174C036
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(39850400004)(136003)(396003)(346002)(376002)(189003)(199004)(53546011)(6506007)(71200400001)(316002)(110136005)(7696005)(4326008)(55236004)(478600001)(66476007)(66556008)(66446008)(64756008)(76116006)(66946007)(33656002)(2906002)(9686003)(86362001)(55016002)(81156014)(8936002)(8676002)(186003)(5660300002)(26005)(52536014)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR10MB2614;H:AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HxuwZe4HNfV28RP0v/f2Ox/x0Llp5d2AYsmfEYYZ/OVT3Gt1X9ZS7JMIONnm4DxvV6qE6nXRnJx9Wr26iF1MXZ5sntbWhloOxUzM7ohoY2+zHY4shu5syeiEhVJ9prsQ/rm58V5BgosGf1648UPPsQo7HMvcfhnX2DZw/ho/pOn76A36Cc72U31A/A9QtVOrCOn/Q3qojGfj2zAJOTY2tVJ8IzQFuo/Cj5S9lKmByRiUMXa5fukHG1cCusnmfpE1KC4AL5FzifnNy0nS0ZHsUoKsGxL+TQZ6lnBHhd9Pl7z3HckMjjwqOPCkIztKkzb7gXNhvNv/QxwlIVskm5lHDs2c1O0YYc2bgT05pO3XyrdDpfC8GV1S8hRMS/UPh+weTVdHCrRoyGVnqGDSJMhttXyA848zbSVpcaCTAZiqRYnRyW2QNXwx0xW0Ie9v+Wmc
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8d0eda8-b1a9-42ca-faec-08d7a01c216b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2020 15:51:37.5608
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jSsp9VdxQ5W7GalezFwT73MZ1Gx1QFElEzJCz/U76jkex4n8NQZenzx9GRdEEh4eoNwwmQ9rXO7xCSL0nWsVnRD96oWBm07WBlj4EvWddXQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR10MB2614
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07 January 2020 12:06, Helmut Grohne wrote:

> The DA9062 can be the device used to power the CPU. In that case, it can
> be used to power off the system. In the CONTROL_A register, the M_*_EN
> bits must be zero for the corresponding *_EN bits to have an effect. We
> zero them all to turn off the system.
>=20
> Signed-off-by: Helmut Grohne <helmut.grohne@intenta.de>
> ---
>  drivers/mfd/da9062-core.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>=20
> This patch includes the functionality into the da9062-core driver. If
> that is not the preferred way to integrate it, it can be added as a
> mfd_cell instead. In that case, I can move the functionality to a new
> drivers/power/reset/da9062-poweroff.c. As far as I can see, doing so
> implies that we can no longer use the standard system-power-controller
> property though and must use a new compatible property
> dlg,da9062-poweroff. Please let me know your preference.

I have concerns about using regmap/I2C within the pm_power_off() callback
function although I am aware there are other examples of this in the kernel=
. At
the point that is called I believe IRQs are disabled so it would require a
platform to have an atomic version of the I2C bus's xfer function. Don't kn=
ow
if there's a check to see if the bus supports this, but if not then maybe i=
t's
something worth adding? That way we can then only support the pm_power_off(=
)
approach on systems which can actually do it.

>=20
> diff --git a/drivers/mfd/da9062-core.c b/drivers/mfd/da9062-core.c
> index e69626867c26..a2b5dfee677f 100644
> --- a/drivers/mfd/da9062-core.c
> +++ b/drivers/mfd/da9062-core.c
> @@ -572,6 +572,23 @@ static const struct of_device_id da9062_dt_ids[] =3D=
 {
>  };
>  MODULE_DEVICE_TABLE(of, da9062_dt_ids);
>=20
> +/* Hold client since pm_power_off is global. */
> +static struct i2c_client *da9062_i2c_client;
> +
> +static void da9062_power_off(void)
> +{
> +	struct da9062 *chip =3D i2c_get_clientdata(da9062_i2c_client);
> +	const unsigned int mask =3D DA9062AA_SYSTEM_EN_MASK |
> +		DA9062AA_POWER_EN_MASK | DA9062AA_POWER1_EN_MASK
> |
> +		DA9062AA_M_SYSTEM_EN_MASK |
> DA9062AA_M_POWER_EN_MASK |
> +		DA9062AA_M_POWER1_EN_MASK;
> +	int ret =3D regmap_update_bits(chip->regmap, DA9062AA_CONTROL_A,
> mask, 0);
> +
> +	if (ret < 0)
> +		dev_err(&da9062_i2c_client->dev,
> +			"DA9062AA_CONTROL_A update failed, %d\n", ret);
> +}
> +
>  static int da9062_i2c_probe(struct i2c_client *i2c,
>  	const struct i2c_device_id *id)
>  {
> @@ -661,6 +678,15 @@ static int da9062_i2c_probe(struct i2c_client *i2c,
>  		return ret;
>  	}
>=20
> +	if (of_device_is_system_power_controller(i2c->dev.of_node)) {
> +		if (!pm_power_off) {
> +			da9062_i2c_client =3D i2c;
> +			pm_power_off =3D da9062_power_off;
> +		} else {
> +			dev_warn(&i2c->dev, "Poweroff callback already
> assigned\n");
> +		}
> +	}
> +
>  	return ret;
>  }
>=20
> @@ -668,6 +694,11 @@ static int da9062_i2c_remove(struct i2c_client *i2c)
>  {
>  	struct da9062 *chip =3D i2c_get_clientdata(i2c);
>=20
> +	if (pm_power_off =3D=3D da9062_power_off)
> +		pm_power_off =3D NULL;
> +	if (da9062_i2c_client)
> +		da9062_i2c_client =3D NULL;
> +
>  	mfd_remove_devices(chip->dev);
>  	regmap_del_irq_chip(i2c->irq, chip->regmap_irq);
>=20
> --
> 2.20.1

