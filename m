Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C0B0C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 07:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27353207E8
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 07:46:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="E8fsFKdT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbgETHqh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 03:46:37 -0400
Received: from mail-eopbgr10067.outbound.protection.outlook.com ([40.107.1.67]:35648
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726403AbgETHqh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 03:46:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kk/XxHgt907JaN18LsY9HwJqHsWKzIHcorIrc03u74wpadH5BJLmaoJOJoyRWdmedYQBrEtE+4HY02XrHWRHfI1Z61xLtEcmH4+4TpITlJoICUiaPRi/CrldgiSx/1xgqRYaKpGG/alitMrl4W8/6owAANNsUyxsj6q0zqw40sIcM1F/0O9y1lI0U/StLusbz3Ss6C1vePR12y+YACYpyi3QUNhRJFx5l2D1Am3FUeLrJA0oMgXio1zn4Yim34Wq4AVzuKLOunQB55jPHWyulJXtqo1a/uZnVIlmx+5+Vm0Qfhd21HASri7eEBwWVB2vOEmyZRc4wXnaLVHj1T4mjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z8spDK9DSbZiNr16VXsDoiJONX63k4BQuUruqsz7kdI=;
 b=oaURGZleHNGwatC6jJN78/KYIAzQ1vMbI/m2LONTTivkne2LE4UGtzjggRR2WrCOfNrTWTD5dQ7tiD8rNYaGeJ3ZhmOXx6cQZXSAfbXnAoBlD2x53PASjTxd8dkgAPvqi96z3aljs/FupwqaIDFHEtB4Iwz7rH2f++ewmKfaE/jVfNHbCUbBsblZgIqwiqtLanz2dn0ston57UjIudsWHvwwwpliM2mApKfep51A5/8k7JUof/4qdWdI21FFRAxW3DMCzyx6focX0BFNZxFxHOzE+9yMDj1PdaiyyhzbZ87iWHiMOa+ATtFaseIVNyDVEr/qmGJhIiDckNb1/7JcnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z8spDK9DSbZiNr16VXsDoiJONX63k4BQuUruqsz7kdI=;
 b=E8fsFKdT4/KFyhKEC3XH3vR+MsC2Js09hwPDrEz4DTK7bkWKzPpsBd/C3pUG0xJsdsmuV4nreVhV8ZxyxWTf45SSb6fDeM8chcYRMlgjG74fiMKTN6kSqhZGhE68KwILocYjCZp1PGRHFHSuju7jl2+bVCS5xFioDPSArtTPGsg=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (2603:10a6:8:10::18)
 by DB3PR0402MB3691.eurprd04.prod.outlook.com (2603:10a6:8:5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.31; Wed, 20 May
 2020 07:46:32 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1dab:b68c:e028:acb3]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1dab:b68c:e028:acb3%6]) with mapi id 15.20.3000.034; Wed, 20 May 2020
 07:46:32 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Aisheng Dong <aisheng.dong@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] ARM: dts: imx: Make tempmon node as child of anatop node
Thread-Topic: [PATCH] ARM: dts: imx: Make tempmon node as child of anatop node
Thread-Index: AQHWLnGKHrF20oveIESDr3+xecMSEqiwl/QAgAAARbA=
Date:   Wed, 20 May 2020 07:46:32 +0000
Message-ID: <DB3PR0402MB39167A0961963B73758F6CA9F5B60@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1589956216-22499-1-git-send-email-Anson.Huang@nxp.com>
 <AM6PR04MB49663B517C218072B2845DBF80B60@AM6PR04MB4966.eurprd04.prod.outlook.com>
In-Reply-To: <AM6PR04MB49663B517C218072B2845DBF80B60@AM6PR04MB4966.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [183.192.13.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 231a62a9-c82a-404e-cbe0-08d7fc91ea0a
x-ms-traffictypediagnostic: DB3PR0402MB3691:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB36914B8B0A3AFC8902347E09F5B60@DB3PR0402MB3691.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-forefront-prvs: 04097B7F7F
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qKjydmSqfYeqapHpoM9mwk1oCYIDwP14xCKDLpm8GsEl5Xwe7E1r/hZQTbAEOZDwSumH9hJUy59gs0lkXG2MWoUHRwzCdfBPoN0Agi5L2PN+nwY5cbzEyPtZglwyqke5Y5qR8t1NmvGRa5jZmoe8/wbVWsXMrLMFFUj6Q6JsZXRLzTg8041rJvA7vpV83EeMofHBK6VhbsV3wmwAqS8SucLhOwy6FYhjvde4PphrNH+kctibmmhDWVPNAKcKmtbIw1DruvDF2MMod82C45odhr37qvVKNCgk55ZajGWfKCt/gb0XBamm0M+SNrzFxHjFYXQWZ4eiPRyD/1iTbiQikqidAPlWhobpWFRf54hKmml+MeWoXGyeWkpyjO1LWSbAgGLjBkh2k/Wb7vudcfRYNBAMLj6KESR6RsxCnWp86CP3pkpHRWBjd60vUVZrDxHI
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(396003)(39860400002)(366004)(376002)(346002)(66556008)(66446008)(64756008)(66476007)(76116006)(478600001)(7696005)(86362001)(66946007)(5660300002)(4326008)(2906002)(8676002)(6506007)(8936002)(316002)(55016002)(110136005)(44832011)(186003)(71200400001)(26005)(52536014)(4744005)(33656002)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: XUELVoMS4OKNRtJbnIktlt9LW71WnskPuY+PuKvExY4koAoDIhJvQkNNiU7VdXICVWvH7jfHsru+UI/7rknCJMn1A8gVcXHFU8TmyJJFHWvqRgQA4TcQ1XbHUkWZEFMY60iStjYIIqnxIpDemkEBFep8VHgKro5uqi563OHypcFqLERLeBmb2B7bwoWehzf+UHlBxAu0X+2OmiJrfEjil8nI3WuYoqSQvf9gDMXxvO5oSCE5rKX7hdTrJxbLqgSl6ukjnh1JGMexOxXMpjnQiDkD18cf7FHOJv7UZxEe5hkwNTfeb1BM44XbTpGdR2cD3MNWM75dJTTkBqLuqFXHZYHUdgoXFadahJ/l3BS53QiQ6xajTAtDWLWeRMYYpMAaGFvP0WsbO+fNgyeYJCZbeoAN5GPgQ9qhVUpP/tbVTvcX8DjkNXrJkCBoExeNtVL5cYCr/a5c8WKE6TRAUcHYQh5nzAFh98NfEEG/HLKDbjBAwfNXZXJHBeah6TSQpr6a
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 231a62a9-c82a-404e-cbe0-08d7fc91ea0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2020 07:46:32.1768
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rPuNMSfpjXpO3YE7TKqEp2hbf9KZFjY07uVh7brXsWEh1UjzKQA4//9CUaFhVuc+X2Uyu5fBX6L+bTYOV5baKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3691
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gU3ViamVjdDogUkU6IFtQQVRDSF0gQVJNOiBkdHM6IGlteDogTWFrZSB0ZW1wbW9uIG5v
ZGUgYXMgY2hpbGQgb2YgYW5hdG9wDQo+IG5vZGUNCj4gDQo+ID4gRnJvbTogQW5zb24gSHVhbmcg
PEFuc29uLkh1YW5nQG54cC5jb20+DQo+ID4gU2VudDogV2VkbmVzZGF5LCBNYXkgMjAsIDIwMjAg
MjozMCBQTQ0KPiA+DQo+ID4gaS5NWDYvNyBTb0NzJyB0ZW1wZXJhdHVyZSBzZW5zb3IgaXMgaW5z
aWRlIGFuYXRvcCBtb2R1bGUgZnJvbSBIVw0KPiA+IHBlcnNwZWN0aXZlLCBzbyBpdCBzaG91bGQg
YmUgYSBjaGlsZCBub2RlIG9mIGFuYXRvcC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEFuc29u
IEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAuY29tPg0KPiANCj4gUmV2aWV3ZWQtYnk6IERvbmcgQWlz
aGVuZyA8YWlzaGVuZy5kb25nQG54cC5jb20+DQo+IA0KPiBCVFcsIEkgdGhpbmsgeW91IGFsc28g
bmVlZCBhIGJpbmRpbmcgZG9jIGZvciB0aGlzIGNoYW5nZS4NCg0KVGhlIGJpbmRpbmcgZG9jIGlz
IHRoZSBpbXgtdGhlcm1hbC55YW1sIEkgc2VudCBvdXQsIGl0IGlzIHN1Z2dlc3RlZCBieSBSb2IN
CnRvIG1vdmUgdGVtcG1vbiBpbnRvIGFuYXRvcCBub2RlLCB0aGF0IGlzIHdoeSBJIGRpZCB0aGlz
IHBhdGNoIHRvIGFsaWduDQp3aXRoIHRoZSBiaW5kaW5nIGRvYy4NCg0KQW5zb24NCg==
