Return-Path: <SRS0=flm+=CO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 205CFC43461
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 00:08:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAA2E2087C
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 00:08:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="SXFIodyR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbgIEAI3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 20:08:29 -0400
Received: from mail-eopbgr60066.outbound.protection.outlook.com ([40.107.6.66]:22528
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726208AbgIEAIY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 20:08:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IloBBokxJtYVMDR8thiJ71HQ72dhrH2mY8bvSdkNMURnbBtd71rZxQhTtuC+NzonFqL0YSPkI5xXXjKuLmeWlhvnhPOgxF0/CbrGlwrLRnmcY5CZuIVcEldn3kxQpDfij7vl/Q0wX92NDhPttoJE+KI+R0bZgTSkUaQ9VkP1K6UTSZCmbWDE+al/bBa+SBC7I/MynY9+WHKwV8BkZf346TYoh7h9TncjdHzHhgblHpXfkx1CfrSd03aiDLY/jGYq3SOCFDsJVuimToQ3t1qqziHsAs2WYVHRBNG8Sr9CL2Wt4vEzeejavYtqkAq16kClKIPPmQy4+t4XOjPVe02WCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Di5ic5M3u8qeiXWsxlVoC2oCP8Nky8hGB4jCIpSvfqY=;
 b=AWBAWl1o/L6f2Hdr7309MIT+6gUcHpOclybQt4bqRS15bi4Vn/gw2+5U0bov+2HeJ13AobDwE7/jJnlCabpQv115trtvPfueyqPoLJcHVzmHiAcVW+YZwpq0mQppJjal3jE6TnGtr4V8ILqMzNnUOnKXa06Zm/oPEAEZp4uGKARwBvzLpwOGy7AQGLnf0Ji+f74Bs+G+fbMk5Gn70SgQG7F0wKX58QhGMTBHAwkR4KqZ/2TH5p9xQxQVZmore1gfQJLqdNURjlPw0rWxbOvX9tTFjuJ70J+bn6G1tpCd2r+e8l5w/TNFJwtE7RuIsJ0gzHoynChaE+QC/Lff2m4bLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Di5ic5M3u8qeiXWsxlVoC2oCP8Nky8hGB4jCIpSvfqY=;
 b=SXFIodyRisnlVv5wrvdGFZajNh+wzO//g1grCG4i49FKYcBXrzlkf/WVRE+xukH2xE/Rw+VDrpcXCKI3iLdk12bHrGGmPWWc4UpdclRskOBQ3NuzUaZRgU9Qo3R2o/IIKcMZeBrTal774zWt+3hR7MEyJZeWGJsUyUkg4UQJnN0=
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com (2603:10a6:20b:118::20)
 by AM6PR04MB5605.eurprd04.prod.outlook.com (2603:10a6:20b:a9::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16; Sat, 5 Sep
 2020 00:08:21 +0000
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::1023:be8d:40c:efe1]) by AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::1023:be8d:40c:efe1%3]) with mapi id 15.20.3348.017; Sat, 5 Sep 2020
 00:08:21 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Paul Cercueil <paul@crapouillou.net>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Cristian Birsan <cristian.birsan@microchip.com>,
        Felipe Balbi <balbi@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Tony Prisk <linux@prisktech.co.nz>, Bin Liu <b-liu@ti.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>
Subject: Re: [PATCH 14/20] usb/phy: mxs-usb: Use pm_ptr() macro
Thread-Topic: [PATCH 14/20] usb/phy: mxs-usb: Use pm_ptr() macro
Thread-Index: AQHWgeU+2b62vIVikUSNVdUVtDfvy6lZLW4A
Date:   Sat, 5 Sep 2020 00:08:20 +0000
Message-ID: <20200905000758.GB24243@b29397-desktop>
References: <20200903112554.34263-1-paul@crapouillou.net>
 <20200903112554.34263-15-paul@crapouillou.net>
In-Reply-To: <20200903112554.34263-15-paul@crapouillou.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: crapouillou.net; dkim=none (message not signed)
 header.d=none;crapouillou.net; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 96288c73-4a0b-465f-ae64-08d8512fcc9f
x-ms-traffictypediagnostic: AM6PR04MB5605:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB560584582ED3523DE63324CB8B2A0@AM6PR04MB5605.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v8Qh3mN9HIipZZLM7ztFrKQAoFV27oYY0Ncwv1/cfcefEIT92e4OUZ1HvCOkaJM+tiT3ni/cgCMhTp1U8f17NnLkdlciEmpCiGWCXbSeuh5uG03XhhbEKg21YF2jNqMc7u61eiRM7hEkpCw4dIQWoM4nY3Mw18L4cEe4pW8GwGgvF4+VRTA3bjDLrKXtFswoZs3DyzJqU30X/2CunH2kW3NHL3laJg0PNlJbiseJjp9qku6+WNJU6t5FOmO195h5P55VQA1TShsGMD2xUXXgpSrzo2zF9EwJljkUTPXoCUb/Szz/T+VPTGIRHoJDFqOJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7157.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(136003)(346002)(396003)(366004)(39860400002)(376002)(33716001)(33656002)(478600001)(44832011)(71200400001)(2906002)(91956017)(66556008)(66446008)(66476007)(66946007)(76116006)(83380400001)(86362001)(64756008)(6486002)(5660300002)(1076003)(6506007)(53546011)(316002)(4326008)(54906003)(186003)(8676002)(7416002)(9686003)(6512007)(26005)(6916009)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 0tVuuqjDfX27OrtV3YkbQy3J2mYrtKPVap1yUuVvjHndjRDOm9R+bvtv8NyC05YZR3tkzr5ht1YfBzV/qPToWYAOWt4AIVQVYZu8U/xXo/0M11PSwnO24Gdi3+nVAaFdrgTLXP0fyOi2W2HMyMPAO60KKXnS5KeGfGhqK93hfMl9xThFc5Q5t1rosQ6nZIqth6MsjFtEDml6BnOYRa+ivC8LyRAs4CAmJrdVRII2TGdsasMjKUR0j663tB01/uoROx4NrC4Qdxq5HhvGvQHHfXgleLIOmwKP1YZyy9HXp4iHA8LJ8acuuZ24e4c607PzLGf46FGQL1Fr3iWQpK4dgzi8eba/k1ws6VywLrIjZ4mMztPPFyPcXWZj4PEpCsEsD68vCjNXlbAD3sW7ovb4HUyDA7D9h+DXRNz4blLgiU1VWzJoKlOE1LNnbXqUjxceP2/EPjLbv8b1gRtgFNhy2azN6rkw9gltm8tYzTLgQbFGxzAkouq1MrUsfe44nUBH886hLDFpeYBupg8bbUrVnLuWK9YjkdYZCBMV2Nov5kt/GnUML4J4BKsnxINqclMh81hwqmgDPrVrnDBqYJUf/t6gNVpWGWVv+yWXRFX3Bo4+AVDJPm48HKA6iY2zifu7KgU2MDE6e+vlRGmqDs5w+w==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5F23AC27CA69B84BAEF6DA2F1CA676FE@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7157.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96288c73-4a0b-465f-ae64-08d8512fcc9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2020 00:08:20.8855
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t/T+7exD5w8dbf3ThBeDiU5yLFkkmIugiBMguAu1qf7AmBNeU4pWCBuoP29IfSUKF8AcB/7yxKqWipmsXrXIww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5605
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-09-03 13:25:48, Paul Cercueil wrote:
> Use the newly introduced pm_ptr() macro, and mark the suspend/resume
> functions __maybe_unused. These functions can then be moved outside the
> CONFIG_PM_SUSPEND block, and the compiler can then process them and
> detect build failures independently of the config. If unused, they will
> simply be discarded by the compiler.
>=20
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  drivers/usb/phy/phy-mxs-usb.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/usb/phy/phy-mxs-usb.c b/drivers/usb/phy/phy-mxs-usb.=
c
> index 67b39dc62b37..c5e32d51563f 100644
> --- a/drivers/usb/phy/phy-mxs-usb.c
> +++ b/drivers/usb/phy/phy-mxs-usb.c
> @@ -815,8 +815,8 @@ static int mxs_phy_remove(struct platform_device *pde=
v)
>  	return 0;
>  }
> =20
> -#ifdef CONFIG_PM_SLEEP
> -static void mxs_phy_enable_ldo_in_suspend(struct mxs_phy *mxs_phy, bool =
on)
> +static void __maybe_unused
> +mxs_phy_enable_ldo_in_suspend(struct mxs_phy *mxs_phy, bool on)
>  {
>  	unsigned int reg =3D on ? ANADIG_ANA_MISC0_SET : ANADIG_ANA_MISC0_CLR;
> =20
> @@ -832,7 +832,7 @@ static void mxs_phy_enable_ldo_in_suspend(struct mxs_=
phy *mxs_phy, bool on)
>  			reg, BM_ANADIG_ANA_MISC0_STOP_MODE_CONFIG_SL);
>  }
> =20
> -static int mxs_phy_system_suspend(struct device *dev)
> +static int __maybe_unused mxs_phy_system_suspend(struct device *dev)
>  {
>  	struct mxs_phy *mxs_phy =3D dev_get_drvdata(dev);
> =20
> @@ -842,7 +842,7 @@ static int mxs_phy_system_suspend(struct device *dev)
>  	return 0;
>  }
> =20
> -static int mxs_phy_system_resume(struct device *dev)
> +static int __maybe_unused mxs_phy_system_resume(struct device *dev)
>  {
>  	struct mxs_phy *mxs_phy =3D dev_get_drvdata(dev);
> =20
> @@ -851,7 +851,6 @@ static int mxs_phy_system_resume(struct device *dev)
> =20
>  	return 0;
>  }
> -#endif /* CONFIG_PM_SLEEP */
> =20
>  static SIMPLE_DEV_PM_OPS(mxs_phy_pm, mxs_phy_system_suspend,
>  		mxs_phy_system_resume);
> @@ -862,7 +861,7 @@ static struct platform_driver mxs_phy_driver =3D {
>  	.driver =3D {
>  		.name =3D DRIVER_NAME,
>  		.of_match_table =3D mxs_phy_dt_ids,
> -		.pm =3D &mxs_phy_pm,
> +		.pm =3D pm_ptr(&mxs_phy_pm),
>  	 },
>  };
> =20
> --=20

Acked-by: Peter Chen <peter.chen@nxp.com>

--=20

Thanks,
Peter Chen=
