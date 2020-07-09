Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8408C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 08:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 816DE206A1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 08:27:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="gIlryQUV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbgGII1B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 04:27:01 -0400
Received: from mail-eopbgr1410097.outbound.protection.outlook.com ([40.107.141.97]:7166
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726260AbgGII07 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 04:26:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CHte7zkOfUZkhKDJOcZm3PJ1Uniu8c5HUi5TSZGKO4VSCMAYmezSBaVe+IqQguET5BPS9i7CaD/V52+WOUmysz6InYcvPnwgHsSzhawNIQBnuShJOEJoc50uv8HPtI8PHMxtzSJh90HpZzOCWstMBUXimlXjndukRtg1H6iVwlq1FeXyYqA0Q3xSFQCyCx7h7emdW0hgT93HOuSz84+AyrjzGtsEhKVve8PtVlrgOJNC+hSLNpdiWw8v566sw/PmI5Ih2ROgFP6sm5hrmTolSMopMkYoIkcCf0c6mUDEHviqt0DrBy/w41Q5BMW50a9++cFHEqjOKWUpxMquh3CKNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zqfqHswkkodXlx9NUf9BNUAPFYb6AYL0H3tIgAcH9DQ=;
 b=HzQvLfbRc5Vn/7NIQA0BOa7z8pwphin77wYdlOff+Sb55TcjrTh+IcT7OiS937LYG0J9oqBdI4q/jpd89Jt+88dSsnkGMb49o42kzILMn3cOEE/MfrT2/9Gxt75F3cM4js1I2m5T3RiBhO5dVFWqq8i1IIAEIMEzL+UHG5FY1lgK6j37aRy3gxDhwwgaS0FZ7Qmml9xzbwvDGlMZwePm4mTidJfKeCGZl76ovAlWzXoLEUmtVjlbeWM5PrByN3le/CAWcTMV7uze2jk2sdN9qq8DMhSDtayC8J3sOIC+RZ5nOhPfjaCs+MCLakXM6qmW0/JF18wbMyVKnvgl4nZx1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zqfqHswkkodXlx9NUf9BNUAPFYb6AYL0H3tIgAcH9DQ=;
 b=gIlryQUVHRMGbTUTr0aEhEVhe4jmk5CIy+YeEoQB8bZa11DP9JWgkBkhpDEMUQbu5gGjYQU9SY0rcLHdmD7HeqijC/LgiJ/N8WbzgZkp1Xof34asIoWbIAar1EQTRwAhKY1bIgfWGZB5ySLAuEa8h5ZVjd2bPZQx1EKdcxkObds=
Received: from OSBPR01MB4024.jpnprd01.prod.outlook.com (2603:1096:604:4b::15)
 by OSBPR01MB2711.jpnprd01.prod.outlook.com (2603:1096:604:11::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Thu, 9 Jul
 2020 08:26:54 +0000
Received: from OSBPR01MB4024.jpnprd01.prod.outlook.com
 ([fe80::2198:7e23:8f02:b240]) by OSBPR01MB4024.jpnprd01.prod.outlook.com
 ([fe80::2198:7e23:8f02:b240%5]) with mapi id 15.20.3153.029; Thu, 9 Jul 2020
 08:26:54 +0000
From:   Dien Pham <dien.pham.ry@renesas.com>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Subject: RE: [PATCH v2 2/2] clk: scmi: Fix min and max rate when registering
 clocks with discrete rates
Thread-Topic: [PATCH v2 2/2] clk: scmi: Fix min and max rate when registering
 clocks with discrete rates
Thread-Index: AQHWVcldxf7eBbhrV0WytRuJ2WVzT6j+6QFg
Date:   Thu, 9 Jul 2020 08:26:54 +0000
Message-ID: <OSBPR01MB40249DA5EFECDA8C5AC9C619D1640@OSBPR01MB4024.jpnprd01.prod.outlook.com>
References: <20200709081705.46084-1-sudeep.holla@arm.com>
 <20200709081705.46084-2-sudeep.holla@arm.com>
In-Reply-To: <20200709081705.46084-2-sudeep.holla@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=renesas.com;
x-originating-ip: [210.245.28.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3c6301ab-2fa2-484d-9d64-08d823e1d64d
x-ms-traffictypediagnostic: OSBPR01MB2711:
x-microsoft-antispam-prvs: <OSBPR01MB27113303E06838EBD7A9B6ACD1640@OSBPR01MB2711.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rUD69FLQz2B59uQnDc/XQnQZc2jq33pfAq32DMBEicbPjqdM0N7vtZtw/Cwu2euHRAHs/ByoshjdxMmUmWa9hWnqkEj2sba8yxqAlUrKKauArqQgbLEeK90BQd3U+xnQZ7HYPo1gpYYNQubIKbIxgS9PaG176M4gJtUuXrJozdWQ4z3KVALTWYJA6G+P8sv15SOX0n6nviuiOatLwbSf0b74wvI00/NhHi4PCM8YGIhKrpNRB4JmevE2rldRpqDftqVOkTkPCQf9h/NByDY0UD97eRaUj/f7+hoYLICQZB0oci1f8feIN10dHQMXjc41A8C0xC/G1rTbkiOexbx/8SKUVXn7opEhiQ+yInxbwSgGZF4YLexcfvDQbsFUlvID9BdFdNtq+iszKwLCfonrQw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB4024.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(376002)(136003)(396003)(366004)(346002)(4326008)(6506007)(316002)(54906003)(83380400001)(110136005)(8676002)(5660300002)(2906002)(8936002)(9686003)(478600001)(33656002)(966005)(52536014)(7696005)(71200400001)(86362001)(55016002)(26005)(66946007)(64756008)(66556008)(66476007)(66446008)(76116006)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 6Tk8Z6733SByEGTZlyQ4GO6qqCcIbomS7snxdlPz5No18n32HIxz8IcgRe47fnUljSusCUCf2PSQEkWb+m763wI61zNRkaNMKw8LhyODoVrGMpNID0PpaIfdnJ0oJBGVgvo7h8FN8qxJbESRA4PcgqnI/72mjce9JNNycV1dErwwnYwCkKBDW6/oAmrJ2Zrc0B5LSe9ewPT3gL9WCGR1PCCMZgwbKII+mz4j0dqWmu/QWvcB7hkCuFfUkJ4SOI65Jd+WAjhe4bHFXuTYQ/OsDPrrhZLclky4CnHqGdu9VS89JzK+SnuOTXbpQ6pN4X+O6ivL6hSMuWz0RWTYM1YrA5tbzJdXx7d2UuoNrFvgELPmCMoHktFaEg9CCAF2gmcARndHN40wOA7PwLK8n/gL3af6XZsFmLTzQbIQWTCcHFN4l/wwlHhCGLo8f+wg3k0PArtaQHSZsLVPcC3NQQi+BJrA5A3G5liMmmbjh097IBE=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB4024.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c6301ab-2fa2-484d-9d64-08d823e1d64d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2020 08:26:54.1310
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vwICqxtx0rGNePcvqwK0XehDcygFzDruOekAgmPq6DoT112Q1umVpB+C62Fyie/y99SAB+VXl3llikEkJAHoegrWs5RwPbeeYRVXku4Vbgo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2711
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sudeep,

Thanks for your patch.

>-----Original Message-----
>From: Sudeep Holla <sudeep.holla@arm.com>=20
>Sent: Thursday, July 9, 2020 3:17 PM
>To: linux-arm-kernel@lists.infradead.org; linux-clk@vger.kernel.org; Steph=
en Boyd <sboyd@kernel.org>
>Cc: Sudeep Holla <sudeep.holla@arm.com>; linux-kernel@vger.kernel.org; Mic=
hael Turquette <mturquette@baylibre.com>; Dien Pham <dien.pham.ry@renesas.c=
om>
>Subject: [PATCH v2 2/2] clk: scmi: Fix min and max rate when registering c=
locks with discrete rates
>
>Currently we are not initializing the scmi clock with discrete rates corre=
ctly. We fetch the min_rate and max_rate value only for clocks with ranges =
and ignore the ones with discrete rates. This will lead to wrong initializa=
tion of rate range when clock supports discrete rate.
>
>Fix this by using the first and the last rate in the sorted list of the di=
screte clock rates while registering the clock.
>
>Link: https://lore.kernel.org/r/20200708110725.18017-2-sudeep.holla@arm.co=
m
>Fixes: 6d6a1d82eaef7 ("clk: add support for clocks provided by SCMI")
>Reported-by: Dien Pham <dien.pham.ry@renesas.com>
>Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>---
> drivers/clk/clk-scmi.c | 22 +++++++++++++++++++---
> 1 file changed, 19 insertions(+), 3 deletions(-)
>
>Hi Stephen,
>
>If you are fine, I can take this via ARM SoC along with the change in firm=
ware driver. However it is also fine if you want to merge this independentl=
y as there is no strict dependency. Let me know either way.
>
>v1[1]->v2:
>	- Fixed the missing ; which was sent by mistake.

I tested the patch,
I is ok and can fix my issue.

>Regards,
>Sudeep
>
>[1] https://lore.kernel.org/r/20200708110725.18017-2-sudeep.holla@arm.com
>
>diff --git a/drivers/clk/clk-scmi.c b/drivers/clk/clk-scmi.c index c491f5d=
e0f3f..c754dfbb73fd 100644
>--- a/drivers/clk/clk-scmi.c
>+++ b/drivers/clk/clk-scmi.c
>@@ -103,6 +103,8 @@ static const struct clk_ops scmi_clk_ops =3D {  static=
 int scmi_clk_ops_init(struct device *dev, struct scmi_clk *sclk)  {
> 	int ret;
>+	unsigned long min_rate, max_rate;
>+
> 	struct clk_init_data init =3D {
> 		.flags =3D CLK_GET_RATE_NOCACHE,
> 		.num_parents =3D 0,
>@@ -112,9 +114,23 @@ static int scmi_clk_ops_init(struct device *dev, stru=
ct scmi_clk *sclk)
>=20
> 	sclk->hw.init =3D &init;
> 	ret =3D devm_clk_hw_register(dev, &sclk->hw);
>-	if (!ret)
>-		clk_hw_set_rate_range(&sclk->hw, sclk->info->range.min_rate,
>-				      sclk->info->range.max_rate);
>+	if (ret)
>+		return ret;
>+
>+	if (sclk->info->rate_discrete) {
>+		int num_rates =3D sclk->info->list.num_rates;
>+
>+		if (num_rates <=3D 0)
>+			return -EINVAL;
>+
>+		min_rate =3D sclk->info->list.rates[0];
>+		max_rate =3D sclk->info->list.rates[num_rates - 1];
>+	} else {
>+		min_rate =3D sclk->info->range.min_rate;
>+		max_rate =3D sclk->info->range.max_rate;
>+	}
>+
>+	clk_hw_set_rate_range(&sclk->hw, min_rate, max_rate);
> 	return ret;
> }
>=20
>--
>2.17.1

Best regard,
DIEN Pham
