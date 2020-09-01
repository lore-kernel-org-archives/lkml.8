Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1267BC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 01:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9CC02098B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 01:58:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="FTd/dDbq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgIAB6L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 21:58:11 -0400
Received: from mail-eopbgr30080.outbound.protection.outlook.com ([40.107.3.80]:65505
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725941AbgIAB6K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 21:58:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XEL1YUhpcxWI7VMc4AqUMbWGsSU8Lt8goU7z3zvP8jv4WuiLHyKi84i+Vkv5oCEf0FH5urE+T7bb3/46wFLD5/oOZRE283UKH0/F09C2r/Krr3ZJTWaeh44RnF73ZWJd8MDkkpk0RrUaiJHwURJsFUjXoVptHYvws9QzhBcWA2j5msFabrq7wTtmZ5Ojms1nGvQQmkybQMSuyvCHeuyNpLGcS9B4Ppkj0Xp3SBHg6akNkQi8jS9FsnQ08N80F+NI+1m/+vwiRgTJtRV6Pwn2Gj8wxexPuEOStrUYms2+2iK5nkQQJ7oztqyzb8wLkA+uJTNs3jOJUQMy1vPhVbxMdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lZJ60Od6ajNhV7N0bXwL/Sg171PT7nNFBeF2CJ/g5no=;
 b=grNmU0UxetupqO1//RB04N61Flya7DWqHVJm0IXMxfzdntF149DXJG4yT6i1om7rtwGxTcUiL2wT/tFGBc8P7A3J2YCUxPVWRI22RlfL5DXFeQMLmCj3INQ+bmKqjuwc/KgXm6ABC95h6qPZkdYH0ekMRLWb81Ov3ACSwHs08OT/TsOyUAeIAxBHYXU/tx731AIiy//kGeWYDIQ/3xXlcxtiiQfvSsesBGDCzsNIylZf8OLd8rCvlsuPy55niOR7GurA7eY5hQv3s+U/IJOF9s5jKwbNvINWY83OgsDM2CY/KoRc4G9d5fJOufqoKzT/7BXJWIynvqiauYmSgl7qGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lZJ60Od6ajNhV7N0bXwL/Sg171PT7nNFBeF2CJ/g5no=;
 b=FTd/dDbqyGQYf9/3atpkmFy4eVodMwgCMwCC4e/cFq+WnoAe1/FWKwNEE+7DCLpy8068z+QZkd7l0++DbUjMbuoAXUnAZFHakld0IlXRH8vi99wPElLwkLkiQSgbmkkkTaYONbBEErHFm5K8U9RtTsHPQxMMvQARkuDlJDtmcro=
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VE1PR04MB7374.eurprd04.prod.outlook.com (2603:10a6:800:1ac::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Tue, 1 Sep
 2020 01:58:07 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::ad7f:d95a:5413:a950]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::ad7f:d95a:5413:a950%3]) with mapi id 15.20.3326.025; Tue, 1 Sep 2020
 01:58:07 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     Marco Felsch <m.felsch@pengutronix.de>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        Anson Huang <anson.huang@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 1/2] regulator: pca9450: add enable_val for all bucks
Thread-Topic: [PATCH v1 1/2] regulator: pca9450: add enable_val for all bucks
Thread-Index: AQHWf3GYvz7pHbbwy0Oh0swEP0rom6lSCuoAgAD5ICA=
Date:   Tue, 1 Sep 2020 01:58:07 +0000
Message-ID: <VE1PR04MB6638767DC4367488F9104913892E0@VE1PR04MB6638.eurprd04.prod.outlook.com>
References: <1598892515-30950-1-git-send-email-yibin.gong@nxp.com>
 <20200831105304.6qcpjfmranay6q4y@pengutronix.de>
In-Reply-To: <20200831105304.6qcpjfmranay6q4y@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 982f6fbd-5359-4c3e-9b71-08d84e1a78b3
x-ms-traffictypediagnostic: VE1PR04MB7374:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VE1PR04MB73743F6D20039D2E4F7E0A96892E0@VE1PR04MB7374.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vPkOsqqqmesGkclrZQtV1XvlpGuIbNRa2z8NLtBJ+v6JLyIqgLX51jowUFRzeV1wY+SBiLiwV3tFSVmK4Qq1FyMW2ylp1m6BdZ4j7nhJBsC5A1XsibfbzwhLsLXC+DVRW6hgSTVDdfZSUs/NGCKMkyDsmwAHTlF3KlRxCF5/IMk7VlYtvQasj9lJih25Sh118Pl5/qH8OhGGDEA0TE/1gb8z6eZ8YJ5FQvsAUy5g2gBNVDIXzprw8FMofj6T+EDK9DYOn7RAiR5OxkT6B5ZrcUarmliPXB9C8vFwYVOzRn2JPWcl0jbJAfKbEJB7KPROBS2iGq0poU2Pd0SvqvEdhA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(136003)(376002)(396003)(39860400002)(6506007)(9686003)(186003)(53546011)(83380400001)(54906003)(71200400001)(55016002)(478600001)(4326008)(26005)(6916009)(52536014)(8936002)(2906002)(76116006)(7696005)(66476007)(5660300002)(66556008)(8676002)(86362001)(66446008)(66946007)(33656002)(316002)(7416002)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 8faGh7lNArnxTFqmwt61iPFppOMubhI+mITYwLn0/ZCFrtqlZ9SE8CCFmiahnaP464HFiGiAjk0w6oegHFNne3O3e6GELACSHgizyum/Th438MucVS1aTZM47j5AheHhD2k5av9um+wSL5MkIQGcm7ewqIxkiqfbX4GzNYvw71hhUYBnxf1lwUfM8azNMzmeho3Pz27vZiYBXiMy+m0djmaxnU8jRmiHqXHFmKbkc6wQHpgrUgRIHMLJdmvLx+3GVuCLAdCnb75SxlRWOCCToUaNWPFihqP3OkxE6vlAxxfznVnI5st3Otsjyw8Boiy0xUSrduZQ/PPIWoNN87EXdB5x1WRbwm6J5w3F/zwC4JHBLGzexzcrJitoSHJnLNnyk3V89diag8S5CyXgUDiUqyWSuY/uATBNexAvNVA/DyFxYzbdYpyvFGgeej8WCMxJulaG8AEsqNoS6eKdx1PLhiJeffGiMpdXZfW0Nro8VZYC2ZIX34zlCxSpE9qhvqiAYO71Xltdg7MfaHhrwm2atis3lBuH+uGAR0VbpVWflgGwJhAck260FQUnI7a8XkXMe1nDg6bK49pYD9s8K4Cu7deU8UPoeqSj0E+r3ZRwnYIL+hInnCc7byeU+yovKSa9ThLLMBmhdUfgV9zkTl8ztQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 982f6fbd-5359-4c3e-9b71-08d84e1a78b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2020 01:58:07.2798
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fIYXVZI9siblfWeZVZXY0Z92KfaP1q2SSZaHXpdgyLUZt+qUN6SUjgGWIpC6lGd2GDVGZDS4LkeoDcLEWUPJ6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7374
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/08/31 18:53 Marco Felsch <m.felsch@pengutronix.de> wrote:
> Hi Robin,
>=20
> On 20-09-01 00:48, Robin Gong wrote:
> > BuckX enable mode
> > 00b =3D OFF
> > 01b =3D ON by PMIC_ON_REQ =3D H
> > 10b =3D ON by PMIC_ON_REQ =3D H && PMIC_STBY_REQ =3D L 11b =3D Always O=
N
> >
> > For such enable mode, enable_value should be clearly set in requlator
> > desc,
> > 00/11 is not enough, correct it now for different bucks. For example,
> > buck2 is designed for vddarm which could be off in 'PMIC_STBY_REQ =3D H=
'
> > after kernel enter suspend, so should be set '10b' as ON, while others =
is '01b'
> as ON.
> > All are the same as the default setting which means bucks no need to
> > be enabled again during kernel boot even if they have been enabled
> > already after pmic on.
>=20
> I wouldn't hard-code the regulator behaviour because the behaviour comes
> from the system design which in most cases are comming from our hw-guys.
> Till now I saw a few intelligent designs don't following the pmic user
> recommendations to save money. I would love to specify the regulator
> behaviour/mode within the dt or acpi.
Well, if so the better way is moving into dts. Will implement it in v2.

>=20
> > Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> > ---
> >  drivers/regulator/pca9450-regulator.c | 15 +++++++++++++--
> >  1 file changed, 13 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/regulator/pca9450-regulator.c
> > b/drivers/regulator/pca9450-regulator.c
> > index eb5822b..79f2a5a 100644
> > --- a/drivers/regulator/pca9450-regulator.c
> > +++ b/drivers/regulator/pca9450-regulator.c
> > @@ -249,6 +249,7 @@ static const struct pca9450_regulator_desc
> pca9450a_regulators[] =3D {
> >  			.vsel_mask =3D BUCK1OUT_DVS0_MASK,
> >  			.enable_reg =3D PCA9450_REG_BUCK1CTRL,
> >  			.enable_mask =3D BUCK1_ENMODE_MASK,
> > +			.enable_val =3D BUCK_ENMODE_ONREQ,
> >  			.owner =3D THIS_MODULE,
> >  			.of_parse_cb =3D pca9450_set_dvs_levels,
> >  		},
> > @@ -273,7 +274,8 @@ static const struct pca9450_regulator_desc
> pca9450a_regulators[] =3D {
> >  			.vsel_reg =3D PCA9450_REG_BUCK2OUT_DVS0,
> >  			.vsel_mask =3D BUCK2OUT_DVS0_MASK,
> >  			.enable_reg =3D PCA9450_REG_BUCK2CTRL,
> > -			.enable_mask =3D BUCK1_ENMODE_MASK,
> > +			.enable_mask =3D BUCK2_ENMODE_MASK,
>=20
> Unrelated change?
Yes, that's just correct it minor literal since that's BUCK2 although
they're the same, will split it anyway.
