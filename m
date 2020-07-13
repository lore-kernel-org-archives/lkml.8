Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE71C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 02:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B851206D9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 02:49:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pGezGzvo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728590AbgGMCto (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 22:49:44 -0400
Received: from mail-eopbgr40073.outbound.protection.outlook.com ([40.107.4.73]:14146
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728382AbgGMCtg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 22:49:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fiaBNSU5gVBlLJ2mxzLiWagp1NAAtXkjoY/n2b0Qu0GHrfN+LPe5tS52xZcV8dh8Bk9iMSMtFu5r4pBREVRZLMQDUw8m1LP3Z7KgiOyfB+8PwiHi72toJY7eLyqsatc6QgkY1Yb58WnCP7ZHU2xj45vjjriWWhMKTS4eOPwz9Ou5IgzFERM8X8TzcWAQjkEtA924/sUNpqKgbrs1FaU5UtW8sQAD6uXumGVMG+jAJxPa7AyhFloXnbi7nfYUWhVaoGQDnbevFd8vq+a3IrqznXHRNVtxVkIMA6UfTSX6BHusiz1EkNCHvsx4pg7EzX91FeMGsjANI7HnA8RrRBsRIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hLWDeMSRGQoO6W+Pz/yn0FwnMBVXlT5/E9G0BdvYsC4=;
 b=Y9HAFKkIAbezlYCtfouGjWrRR+WKIo4CQd9qo+mhizhcpT9mw6h5TYrexoyrK3jVZvDOtG9PQ4KBUTECp3karjrRf8c81EnpXyWhrzx+ONJEqvRYKmfVW4BoyRCWOxM9GX9fFo8/o4A0mybw36783Aqa2udquf9Kk8w5VnsZooz7tL0KcMLr/9WtNrqZon7TET2Ldh582biAueefx78kVSkovrEuUWDLjuz5BbdX4NQ94B9k36Ysg/PbAii8aAzREF6kA2pWWPCma7NQH9kDnVwInhsUR7Ykgp2f3Q6uvCsUzJ4jWOlajn2WnY8Ytq15rpn+7+ti3bGWkdIARxNKKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hLWDeMSRGQoO6W+Pz/yn0FwnMBVXlT5/E9G0BdvYsC4=;
 b=pGezGzvoyDghmORA7kzN89qxy8YiD/5r7klo2W5z+d+nsA3JcVxMLhTm3Cl21+/u8lbSjdt52xwTErXcbnBUR3NoQ4Fo3MuMgxEObnbOvxqf5uvdnJiB19acrYbdhuAivxwM2PRT04nojAxZ00JmuY9bkAfwg5J0TUY7mBItWAA=
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com (2603:10a6:20b:118::20)
 by AM5PR04MB3026.eurprd04.prod.outlook.com (2603:10a6:206:11::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.24; Mon, 13 Jul
 2020 02:49:32 +0000
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::1101:adaa:ee89:af2a]) by AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::1101:adaa:ee89:af2a%3]) with mapi id 15.20.3174.025; Mon, 13 Jul 2020
 02:49:32 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Philippe Schenker <philippe.schenker@toradex.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] usb: chipidea: imx: support disabling runtime-pm
Thread-Topic: [PATCH 2/3] usb: chipidea: imx: support disabling runtime-pm
Thread-Index: AQHWVtG+IVcgco4rmU66cFLuq3QOdakE0tqA
Date:   Mon, 13 Jul 2020 02:49:31 +0000
Message-ID: <20200713024937.GA2388@b29397-desktop>
References: <20200710154935.697190-1-philippe.schenker@toradex.com>
 <20200710154935.697190-2-philippe.schenker@toradex.com>
In-Reply-To: <20200710154935.697190-2-philippe.schenker@toradex.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: toradex.com; dkim=none (message not signed)
 header.d=none;toradex.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 348dd771-5046-45a5-67d9-08d826d75ea2
x-ms-traffictypediagnostic: AM5PR04MB3026:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM5PR04MB30260B74EDB7DC90422AEE278B600@AM5PR04MB3026.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yKBboGosYWud8naonZ/DduOHpNIN2b2swG46PziZmst3NGv5WEnGe9+SlGLIxFyByjHHh+318iYQ3wvCJEejDpwiINs6ye/EN/z5tln1pjf722hnda3a8BO8760l/1g+5G1+/TKm+z/qPZrIm0jUlo7L9hq0G0G4GXDWIZuLRd5D+gxDeGHbAeAYu3yK9reQ8t3n1Ewarh2ey+Ri9qvE//9Kwwtn1CJRNABHwwn+EbTEYXm12ngFqVUnW58EygUzUaJviH2eyAnvhAU9ZsoqAtIDr7aScrwj8d6BavOi3uQcYCGeRmjlWo9BfDcg0KLwtMKxvplCjmY/s1OPROOK1g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7157.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(7916004)(4636009)(366004)(33656002)(1076003)(498600001)(54906003)(4326008)(83380400001)(7416002)(8676002)(6916009)(5660300002)(44832011)(186003)(2906002)(53546011)(71200400001)(6506007)(26005)(33716001)(66446008)(64756008)(66556008)(66476007)(66946007)(76116006)(91956017)(6512007)(6486002)(9686003)(86362001)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 3lHzXtDuygHccp/yLAPUGopM85gLrDAgAFPQcYN/xsb8XPmEIb2XPDbVlzWpEK71Ldj+tcZFmM8gUuJxs65JRal0Wg+issU1FC5jIl9zAjMd3z2hiSse46W/vGxYPdHNaxEcPL2ZPdD8FI9jqfPDoB9+vv6xqd67F4/t7no8XrDjCKW3J+v2kKkoy1BRUssIUH13oyAktFAG+yIJvGJ6+sgDZNTs+X7TixUPvT6iFjJrTLCjvPBeZDXtyWSpmEMMjORb027J2SdwnSSPP1TsY72dvXNI7ItSsgiz0JLg1MsTsEAR95FbUhKqJnZnHoUnM+8k4UiH1qrtIi4BYz87SKlCGb686k16ho3Sit3xYpx2Ww0V9ydj2ouJn6FZMib63lVkV0FgHnPTJzj1vzTGU/GJaNiLJDy4rf8jhrCKk3xThoYtv03br3j5S6JBAZFA6UHi6UmUN7AxSwvPvlO2XacGlyn36w0Jtwj7nCKoZSM=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2F244EAEAC2F4B48B3364DE58809684A@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7157.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 348dd771-5046-45a5-67d9-08d826d75ea2
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2020 02:49:31.9853
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HrKhynSjcwM54KBc8XHzdzuGbGGaBBxqM7NNWJPpdft/H4taLkaLlotXFEKVFMkmqil9tMidrIOThmHTFFPS7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB3026
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-07-10 17:49:33, Philippe Schenker wrote:
> Chipidea depends on some hardware signals to be there in order
> for runtime-pm to work well. Add the possibility to disable runtime
> power management that is necessary for certain boards.
>=20
> Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
> ---
>=20
>  drivers/usb/chipidea/ci_hdrc_imx.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/usb/chipidea/ci_hdrc_imx.c b/drivers/usb/chipidea/ci=
_hdrc_imx.c
> index 5ae16368a0c7..5078d0695eb7 100644
> --- a/drivers/usb/chipidea/ci_hdrc_imx.c
> +++ b/drivers/usb/chipidea/ci_hdrc_imx.c
> @@ -434,6 +434,9 @@ static int ci_hdrc_imx_probe(struct platform_device *=
pdev)
>  		usb_phy_init(pdata.usb_phy);
>  	}
> =20
> +	if (of_property_read_bool(np, "disable-runtime-pm"))
> +		pdata.flags &=3D ~CI_HDRC_SUPPORTS_RUNTIME_PM;
> +
>  	if (pdata.flags & CI_HDRC_SUPPORTS_RUNTIME_PM)
>  		data->supports_runtime_pm =3D true;
> =20

The changes are OK, you may add some descriptions like Fabio suggested,
eg, your use cases.

--=20

Thanks,
Peter Chen=
