Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39AD0C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 10:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6AD7221E3
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 10:02:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="d8x8waj0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725838AbgIKKCm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 06:02:42 -0400
Received: from mail-eopbgr70072.outbound.protection.outlook.com ([40.107.7.72]:30087
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725781AbgIKKCd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 06:02:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AmpsSXbpuyBR/Q8Ljc+DTCsX2GxGVQKhZLGjLgFbDehgz9YBdoT3WHbBDo/fCsd5LtpRWumNHvXyJ7e6FV1sgCseakiCB7VU6pEg24ykWmTe36sVy0ocK01hDuMNQHP2+RQ/RGnhAq6+2aMw3fM+LqO+5R8Jo9lo1N7hN7O22TjbC16+1VG6TLIrKRHmLF+Hx9E3LQR3j6pM2c8C62e1T0HE1hRvRVmLO4tE2qJNfY6af/hicH3AhExpKV9BvVj6WiAGqRlFT5VH0cl+EHQ4Af+rRgy1zHTMsRBw5ouvjPfiBe45Gdux6/0OpJ43dpLLuBf6eHrcllM4WJtN+kVLdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=053rAeRHgvgGekkV5G7YqZrWAoFWV2KxWsiSYovR4K4=;
 b=UTk2TYO+qvcB+B5siT4w1+8Atx0g76CxLykZVffocXau6DOTGcijFubB/2/gKSENpqOUm+EsusAGnsDxPm3LARlu7BwFvBlsre4si7xJ+Cdh5kZ/ZKKW2YQsoFVab/0mgWmEmDpX5Uesi/z1kf2Ae3pISBh9NirO+37vLEh9tzD22JI91keo3u04bb5qVz+KaevEcUH8rKB1lDet1b7SCprOFiu53qb3sztgbGuu7xlyxlXtSE+uDW2vI3xpESR/9U8/UOd3oTylpxunICAV0oNOHGpCeb0LN+6OYkfurNNiEn11lq8GOqmPrTIEP89UYxnm7yBKDVD1AlZLJDgLcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=053rAeRHgvgGekkV5G7YqZrWAoFWV2KxWsiSYovR4K4=;
 b=d8x8waj05rVGa9tt4chU/WR/5xLb0PY9VBFsHVD51FpUe/rIa39X94mijyI5PDAlYmIDSDxyhb2JZ0SOPZUh/SyarxVUgfsvJ+bSWyk0eWOKo00X/DMrXeBQXqYRN21rvmpNYEa0s1PgmEfwicKsH0u2w3girZ8a9IjOy99Wywk=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR04MB6069.eurprd04.prod.outlook.com (2603:10a6:20b:72::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Fri, 11 Sep
 2020 10:02:27 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::99b5:145d:16cc:78ca]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::99b5:145d:16cc:78ca%3]) with mapi id 15.20.3370.016; Fri, 11 Sep 2020
 10:02:27 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Peng Fan <peng.fan@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH 1/4] dt-bindings: fsl: add i.MX7ULP PMC binding doc
Thread-Topic: [PATCH 1/4] dt-bindings: fsl: add i.MX7ULP PMC binding doc
Thread-Index: AQHWh+zi0lUqzLc3V0GYGgj5TwZkHqljAcZggAANXwCAACPckA==
Date:   Fri, 11 Sep 2020 10:02:27 +0000
Message-ID: <AM6PR04MB4966F55C01E44A581A186AAE80240@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <1599795053-5091-1-git-send-email-peng.fan@nxp.com>
 <1599795053-5091-2-git-send-email-peng.fan@nxp.com>
 <AM6PR04MB49661958310D649508AB698B80240@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <DB6PR0402MB276056780BC661041A5D604C88240@DB6PR0402MB2760.eurprd04.prod.outlook.com>
In-Reply-To: <DB6PR0402MB276056780BC661041A5D604C88240@DB6PR0402MB2760.eurprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a10d0865-2acc-4829-3dc3-08d85639ca1f
x-ms-traffictypediagnostic: AM6PR04MB6069:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB60697DB7D00D4F76531649D980240@AM6PR04MB6069.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IFYrRXHIdllgacdCS24l1q9uF/1uvRIyGqtLtNZSecCN+VdYbMwbs9NTa4OZ+h5ssB055jVYLz7TKYR9hNTBBEma8FhdleQSgRG+AmH2EXx8Zws6SDYVL3lhBzsPXqeadZi/QyU28anQWmI48L+jAuxfVNJ+2qpyiNm7LAsLZtVmZOTCw58b7BE3kwpXCM47T65jDdYHqLMyllYr8SkJw8dKz5UbPHgLPBzi+uskz73QK5HkXDuwumuMdhlum0Cn1i1IwH6y4RaIeDB5iPSNFnSyXiUSH9SMKsjLwr+G4SSAOs5+6HTVVApzROuS8oQIJLVgYxpVs0S1FhNAUoQH1rvDlafwwa6gwcJAIgH0MlKgd8ndHYET6ShaMBIbyOoGEDo93xfbr5P0b36eOdE5dg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(396003)(346002)(136003)(376002)(86362001)(64756008)(66446008)(66476007)(66556008)(8676002)(9686003)(478600001)(55016002)(186003)(26005)(7696005)(71200400001)(6506007)(53546011)(4326008)(66946007)(966005)(8936002)(52536014)(5660300002)(2906002)(44832011)(33656002)(110136005)(76116006)(54906003)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: KkRNuPWf3v8maajkRHoh88/iMk7EmvFH0F98qBRV0m/Fz2DiMOAP0WdipQ9LFyPdo8ODREG5Lven06s0gD+4YPqR0U8YvnfV3vbaI1zD6XXwbiIhRBsYWe05gB0Nk7R+eBCcyntBkYJ6LyLIdu5UgWuR4/fTXR1UBG44zLtLaDp9CUvJVwjY028zR0i7By+Qa28Pt6XxRIwcfV6QiryYg8h8ccDaPM7y/yyjB+FY/H7P7B5MeKbGCTzxVH9j7a2nBBksjgTi+xnQk5irA+DHRpaQRRV4VjGhDP4Z8173GOMgApH2hst+yyAsY/wJ4+yVPkIP59orL+R3uwlntBcUmYy8kKLEW+ebaQ0oKzefKELAk71HU7y35gXZu4wtz3HIeON1rcMovl2afRc8Y3Mx6WgdQege7G4snWnTOTdmMrsVchz/n4KbpAfXUFUgZkMKA2ZMb6oIw3Eo3jYmqS9SNJ1VHzAAQRaEQ+axNGwedIEN8BDWnKKtk7bssTvksf5hRFVizXFEQh/xmba/6KbirP8GrEg1VcLfd7039DM89D/m1clcRP2bTMkQ4/zzyt3i/XK+XtrP6WGFh/7Yn/4CYrxGHDRS08zUxJdmeo5GrEtrIXzMwwI5bEKkrwVZGpRwYYUJ6iTeZdaaQ7BsR8D5xw==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4966.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a10d0865-2acc-4829-3dc3-08d85639ca1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2020 10:02:27.4786
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AAHzp3eE25LnZp5HPiW6jSMEUMoxJeB1BWpk3k9sgsLdx8hGWuJCiDyy1dwQsvCt1o+iFQPVvYID0k198qHq4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6069
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gU2VudDogRnJpZGF5LCBTZXB0
ZW1iZXIgMTEsIDIwMjAgMzo0NSBQTQ0KPiANCj4gPiBTdWJqZWN0OiBSRTogW1BBVENIIDEvNF0g
ZHQtYmluZGluZ3M6IGZzbDogYWRkIGkuTVg3VUxQIFBNQyBiaW5kaW5nDQo+ID4gZG9jDQo+ID4N
Cj4gPiA+IEZyb206IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0KPiA+ID4gU2VudDogRnJp
ZGF5LCBTZXB0ZW1iZXIgMTEsIDIwMjAgMTE6MzEgQU0NCj4gPiA+DQo+ID4gPiBBZGQgaS5NWDdV
TFAgUG93ZXIgTWFuYWdlbWVudCBDb250cm9sbGVyIGJpbmRpbmcgZG9jDQo+ID4gPg0KPiA+ID4g
U2lnbmVkLW9mZi1ieTogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQo+ID4gPiAtLS0NCj4g
PiA+ICAuLi4vYmluZGluZ3MvYXJtL2ZyZWVzY2FsZS9pbXg3dWxwLXBtYy55YW1sICAgfCAzMw0K
PiA+ICsrKysrKysrKysrKysrKysrKysNCj4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMzMgaW5zZXJ0
aW9ucygrKQ0KPiA+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiA+ID4gRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9mcmVlc2NhbGUvaW14N3VscC1wbWMueWFtbA0KPiA+DQo+
ID4gSSB3b25kZXIgaWYgd2UgY2FuIG1lcmdlIGl0IGludG8gdGhlIGV4aXN0IGlteDd1bHAgcG0g
YmluZGluZyBkb2MuDQo+ID4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9m
cmVlc2NhbGUvZnNsLGlteDd1bHAtcG0ueWFtbA0KPiANCj4gTm90IHN1cmUgYWJvdXQgdGhpcy4N
Cj4gDQoNCklmIG5vdCBtZXJnZSwgd2UgcHJvYmFibHkgbmVlZCBjaGFuZ2UgdGhlIG5hbWUgb2Yg
ZXhpc3RpbmcgcG0gYmluZGluZyBkb2MgdG8gYXZvaWQgY29uZnVzaW5nLg0KZS5nLg0KZnNsLGlt
eDd1bHAtcG0ueWFtbCAtPiBmc2wsaW14N3VscC1zbWMueWFtbC4NCg0KPiA+DQo+ID4gPg0KPiA+
ID4gZGlmZiAtLWdpdA0KPiA+ID4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
YXJtL2ZyZWVzY2FsZS9pbXg3dWxwLXBtYy55YW1sDQo+ID4gPiBiL0RvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9hcm0vZnJlZXNjYWxlL2lteDd1bHAtcG1jLnlhbWwNCj4gPiA+IG5l
dyBmaWxlIG1vZGUgMTAwNjQ0DQo+ID4gPiBpbmRleCAwMDAwMDAwMDAwMDAuLjMzYTMxZDg3ZGQ2
Mg0KPiA+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ID4gKysrDQo+ID4gYi9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvYXJtL2ZyZWVzY2FsZS9pbXg3dWxwLXBtYy55YW1sDQo+ID4gPiBA
QCAtMCwwICsxLDMzIEBADQo+ID4gPiArIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIu
MA0KPiA+ID4gKyVZQU1MIDEuMg0KPiA+ID4gKy0tLQ0KPiA+ID4gKyRpZDogaHR0cDovL2Rldmlj
ZXRyZWUub3JnL3NjaGVtYXMvYXJtL2ZyZWVzY2FsZS9pbXg3dWxwLXBtYy55YW1sIw0KPiA+ID4g
KyRzY2hlbWE6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9tZXRhLXNjaGVtYXMvY29yZS55YW1sIw0K
PiA+ID4gKw0KPiA+ID4gK3RpdGxlOiBpLk1YN1VMUCBQb3dlciBNYW5hZ2VtZW50IENvbnRyb2xs
ZXIoUE1DKSBEZXZpY2UgVHJlZQ0KPiA+ID4gK0JpbmRpbmdzDQo+ID4gPiArDQo+ID4gPiArbWFp
bnRhaW5lcnM6DQo+ID4gPiArICAtIFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0KPiA+ID4g
Kw0KPiA+ID4gK3Byb3BlcnRpZXM6DQo+ID4gPiArICBjb21wYXRpYmxlOg0KPiA+ID4gKyAgICBp
dGVtczoNCj4gPiA+ICsgICAgICAtIGVudW06DQo+ID4gPiArICAgICAgICAgIC0gZnNsLGlteDd1
bHAtcG1jLW00DQo+ID4gPiArICAgICAgICAgIC0gZnNsLGlteDd1bHAtcG1jLWE3DQo+ID4NCj4g
PiBDYW4gd2UgY2hhbmdlIHRvIHRoZSBleGlzdCBuYW1pbmcgcGF0dGVybiB3aGljaCBhbHNvIGFs
aWduIHdpdGggSFcNCj4gPiByZWZlcmVuY2UgbWFudWFsPw0KPiA+IGUuZy4NCj4gPiBmc2wsaW14
N3VscC1wbWMwDQo+ID4gZnNsLGlteDd1bHAtcG1jMQ0KPiANCj4gVGhpcyB3YXMgcmVqZWN0ZWQg
YnkgU2hhd24gYmVmb3JlLg0KPiBodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3BhdGNoLzEx
MzkwNTkxLw0KDQpJIGRpZG4ndCBzZWUgTkFDSyBmcm9tIFNoYXduIGZyb20gYWJvdmUgVVJMLg0K
U2hhd24gc2VlbWVkIHRvIGp1c3QgYXNrIGZvciBzb21lIGNsYXJpZmljYXRpb25zIHdoeSBuZWVk
IG51bWJlciBzdWZmaXguDQpBbSBJIG1pc3NlZCBzb21ldGhpbmc/DQoNClJlZ2FyZHMNCkFpc2hl
bmcNCg0KPiANCj4gVGhhbmtzLA0KPiBQZW5nLg0KPiANCj4gPg0KPiA+IEFsaWduZWQgd2l0aDoN
Cj4gPiBmc2wsaW14N3VscC1zbWMxDQo+ID4gZnNsLGlteDd1bHAtcGNjMg0KPiA+IGZzbCxpbXg3
dWxwLXNjZzENCj4gPg0KPiA+IFJlZ2FyZHMNCj4gPiBBaXNoZW5nDQo+ID4NCj4gPiA+ICsNCj4g
PiA+ICsgIHJlZzoNCj4gPiA+ICsgICAgbWF4SXRlbXM6IDENCj4gPiA+ICsNCj4gPiA+ICtyZXF1
aXJlZDoNCj4gPiA+ICsgIC0gY29tcGF0aWJsZQ0KPiA+ID4gKyAgLSByZWcNCj4gPiA+ICsNCj4g
PiA+ICthZGRpdGlvbmFsUHJvcGVydGllczogZmFsc2UNCj4gPiA+ICsNCj4gPiA+ICtleGFtcGxl
czoNCj4gPiA+ICsgIC0gfA0KPiA+ID4gKyAgICBwbWMwOiBwbWMtbTRANDEwYTEwMDAgew0KPiA+
ID4gKyAgICAgICAgY29tcGF0aWJsZSA9ICJmc2wsaW14N3VscC1wbWMtbTQiOw0KPiA+ID4gKyAg
ICAgICAgcmVnID0gPDB4NDEwYTEwMDAgMHgxMDAwPjsNCj4gPiA+ICsgICAgfTsNCj4gPiA+IC0t
DQo+ID4gPiAyLjI4LjANCg0K
