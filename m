Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C840EC433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 06:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3D1A20792
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 06:44:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="CSkZGAO0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgG0Goh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 02:44:37 -0400
Received: from mail-eopbgr60089.outbound.protection.outlook.com ([40.107.6.89]:44674
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726124AbgG0Goh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 02:44:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZCHjiqANm/gKzdHezyG5Dy1u8ugjFp5Bxtu9j5QUjmEo1+l6jbCdlxjdWr3UPpMtxrDU/tjn3/QkwrZowAcgwn2CnMPq1CF9O6Qo98xaePv0J0gdjGgSKgvyiQxYXpbaenMv6kCYYLqYBJZdPnwwLxTT4LDjMOE8/2jo3VpPm9OVD2s0t3K9LElV/3ktrPIoOu+1gERfONn7/F9EvTaWXUvB0CPFSFrvqm+XcgLJfxLU5hEWZHIfY7uwxqt2xf1wsoGIHFBWCE1HXS+e8wduLmseoAKHjV1Z/5sP1RZIQdGYPGLNcB2fF/gvMJxmvSmPgHZGytnUt4xM+PtYm7FqUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H7Hs+LxJP/slV8jpTRvmitNpZi8DfKkezyEVd3kRA/0=;
 b=BsPjtffiPhKjfiMYT59nCdE20TjLki7DhXa+NolGEPFJzmxYEnFstWalrOJFYaad7f/in8AU5/2SAKBFgmfhM1msuGxQt+8830hsWgN1YusqPsMlbdCG3Vke5GyNwlbe8AjI6RtjH9EgDzAO3hBT06/OiFFikG1z5IPrDoVdja3YOGzKXXb93zTiPAVM3gGX40cyKurEsLYVyUgdLUuDlfGh3XQI6MNIVyWDbLgXsX9KGHSg8hCg4xa01UrPa73mal/uNhYtGGoW+BWFbHzm+4MObswtE6Xu5RFO38yZYuUnm6nIgjakvEWMdmeBTs11cdQreq4m+R8j6AVybTQnMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H7Hs+LxJP/slV8jpTRvmitNpZi8DfKkezyEVd3kRA/0=;
 b=CSkZGAO0RdJ3vv/Nu0IDj7iVM+vKcFRDfn/G8C2gUII+v/IuBQayhJjBglTg9FkRPu/MB1dDzTSGfv6FhErWDi9zRoWdBkpg9ap6AvIVhdb5euog+iccd/ChlOhQxWWGCinkejQfRNRU4IRLvgpcGmbs+g5Hp9nVie5uRbLRTf8=
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB8PR04MB7177.eurprd04.prod.outlook.com (2603:10a6:10:127::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23; Mon, 27 Jul
 2020 06:44:33 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::2d36:b569:17c:7701]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::2d36:b569:17c:7701%4]) with mapi id 15.20.3216.033; Mon, 27 Jul 2020
 06:44:33 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
CC:     "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH 00/10] remoteproc: imx_rproc: support iMX8M and early boot
Thread-Topic: [PATCH 00/10] remoteproc: imx_rproc: support iMX8M and early
 boot
Thread-Index: AQHWYY4eiJ2SF2lCSU+quq5ttXjJ16ka/gOAgAAAWJA=
Date:   Mon, 27 Jul 2020 06:44:32 +0000
Message-ID: <DB6PR0402MB2760FBC0109E98A447BB716588720@DB6PR0402MB2760.eurprd04.prod.outlook.com>
References: <20200724080813.24884-1-peng.fan@nxp.com>
 <20200727063839.kfgrtperzkygvjr2@pengutronix.de>
In-Reply-To: <20200727063839.kfgrtperzkygvjr2@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d6395bf3-8bcb-4e9e-af0e-08d831f88542
x-ms-traffictypediagnostic: DB8PR04MB7177:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR04MB71773530C18EDC9D09A7694988720@DB8PR04MB7177.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ae0bnXguP24IU2zuKbDdtojLAwHglyvyz9wiTZxdc6A9fy0WSpgygrNusVVwhKyheN6ygWsqg0Eoa+adXQhsAIjXF9OYP355uN8FD0A/KcQ/vSoONKtrEVNj3saN5n7fOVTIbFSnJWoAduOblF3V6rohQyXgscMt2efNXavg0+pCP7PI3nBoU4m2kXMLBVnabMYU+tbLyZpdTo+5sJMr4L/JK9m3H2fU+cnUzCadHnxwjz2o/Lr+LN4WNET8WA4bI20YaZhQFKNUaUqELFZ3MZIIVgrBsJDVDrdBadPW2chBohpY/Y7ZSvjosDbT3ASA72C7Fxc1x3ejRR8iO2jQHLF7u7EpEsDEjz15n1OkKM33v/w6ozbTGDs2C5YAUrAFkIWGqBVHI8CBaI7x8U/cFu7k7lqwGM+sAm2ya5fHxsvWJabCYVXIBfxk03ESlPMZj9Ug/dSMwM18XALE1L8etA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(376002)(346002)(39860400002)(136003)(366004)(33656002)(71200400001)(7696005)(26005)(9686003)(5660300002)(7416002)(6506007)(44832011)(186003)(76116006)(66446008)(64756008)(66556008)(66476007)(86362001)(52536014)(478600001)(66946007)(54906003)(8936002)(8676002)(316002)(966005)(55016002)(6916009)(2906002)(4326008)(83380400001)(83080400001)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: pDCdFmKwYM7e1wPFF3S/yD8nueUrRvgUAcyceEtAJnMuexoZpeVk4VaKkfnbn1GrLBcPuO5cHWepdSk45bHPZvCPz9fBDC6jhXuqBlzVE9CkGoir9NZftCc0KHgvF1pX1IXFlz66qwcuSigu8b31WahexLhluXSgX+8gPxRXsSEIiSLFyE3wASYjGslm2mBhg1BA3j+dNqQmhI/FwJ1RB3Nyz61Zt+I7nCQrb5vZMS+Nq5ZotXhaZaizYElcUShdMhdAq+6xvw7rNNeHJtwWUz9jcc6K5cUpplRcdEy7sXYRtdIBbwGDH+eGOlgOG5qo/nEj1Rt9vTGodJkvXh5wZAiHwK9sueVgTnNOZUuHo0ngpCPT+IU5bIyrCaJ2bUHMo+7dA8DvP1kWz+Poyan6GurzgxhKfreVv+W3BgceteEALaXoF5lbpHCBZQdKIpoPAS2hmjp2o/EW1MRdZ+kVJWjjxGHH5c1q/ALRaBI3OVw=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6395bf3-8bcb-4e9e-af0e-08d831f88542
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2020 06:44:32.9535
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tnyo5xn6Jm6YqshHioj3QiQLCOW4JmL1fqC/Sc59q29LbJDkDoKD0Yz/cxW/cDAwyxna8gl0WcZMr39HJRB+5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7177
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgT2xla3NpaiwNCg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDAwLzEwXSByZW1vdGVwcm9jOiBp
bXhfcnByb2M6IHN1cHBvcnQgaU1YOE0gYW5kIGVhcmx5DQo+IGJvb3QNCj4gDQo+IEhpLA0KPiAN
Cj4gT24gRnJpLCBKdWwgMjQsIDIwMjAgYXQgMDQ6MDg6MDNQTSArMDgwMCwgUGVuZyBGYW4gd3Jv
dGU6DQo+ID4gVGhpcyBwYXRjaHNldCBpcyB0byBzdXBwb3J0IGkuTVg4TVEvTSBjb3Byb2MgYm9v
dGVkIGJlZm9yZSBsaW51eC4NCj4gPiBTaW5jZSBpLk1YOE1RL00gd2FzIG5vdCBzdXBwb3J0ZWQs
IHNldmVyYWwgcGF0Y2hlcyBhcmUgbmVlZGVkIHRvIGZpcnN0DQo+ID4gc3VwcG9ydCB0aGUgcGxh
dGZvcm0sIHRoZW4gc3VwcG9ydCBlYXJseSBib290IGNhc2UuDQo+ID4NCj4gPiBJIGludGVuZGVk
IHRvIGluY2x1ZGVkIGkuTVg4UU0vUVhQLCBidXQgdGhhdCB3b3VsZCBpbnRyb2R1Y2UgYSBsYXJn
ZQ0KPiA+IHBhdGNoc2V0LCBzbyBub3QgaW5jbHVkZWQuIEJ1dCB0aGUgY2xrL3N5c2NvbiBvcHRp
b25hbCBwYXRjaCBmb3INCj4gPiBpLk1YOFFNL1FYUCB3YXMgc3RpbGwga2VwdCBoZXJlIHRvIGF2
b2lkIHJlYmFzZSBlcnJvci4NCj4gDQo+IFRoYW5rIHlvdSBmb3IgeW91ciB3b3JrLg0KPiANCj4g
Q2FuIHlvdSBwbGVhc2UgcHJvdmlkZSBtb3JlIGluZm9ybWF0aW9uIGFib3V0IGJpZyBwaWN0dXJl
IG9mIHRoaXMgd29yay4NCj4gDQo+IElmIEkgc2VlIGl0IGNvcnJlY3RseSwgd2UgaGF2ZSBoZXJl
IHN1cHBvcnQgZm9yIGkuTVg4TU0sIHdoaWNoIHNlZW1zIHRvIGJlDQo+IGFibGUgdG8gZnVsbHkg
Y29udHJvbCBDb3J0ZXggTTQgKGVuYWJsZSBDUFUgY29yZSwgZXRjLi4uKS4NCg0KWWVzLg0KDQo+
IA0KPiBBbmQgb3RoZXIgY2FzZSwgd2hlcmUgcmVtb3RlcHJvYyBpcyBydW5uaW5nIG9uIGFwcGxp
Y2F0aW9uIHByb2Nlc3NvciBhbmQNCj4gY2FuJ3Qgb3Igc2hvdWxkIG5vdCB0b3VjaCBNNCAoaS5N
WDdVTFAsIGkuTVg4UU0vUVhQLi4pLiBTaW5jZSBNNCBwcm92aWRlcw0KPiBzb21lIGZ1bmN0aW9u
YWxpdHksIHlvdSBhcmUgdHJ5aW5nIHRvIHJldXNlIHJlbW90ZXByb2MgZnJhbWV3b3JrIHRvIGdl
dA0KPiByZXNvdXJjZSB0YWJsZSBwcmVzZW50IGluIEVMRiBoZWFkZXIgYW5kIHRvIGR5bmFtaWNh
bGx5IGxvYWQgdGhpbmdzLiBGb3Igc29tZQ0KPiByZWFzb25zIHRoaXMgaGVhZGVyIHByb3ZpZGVz
IG1vcmUgaW5mb3JtYXRpb24gdGhlbiBuZWVkZWQsIHNvIHlvdSBhcmUNCj4gY2hhbmdpbmcgdGhl
IEVMRiBwYXJzZXIgaW4gdGhlIGtlcm5lbCB0byB3b3JrYXJvdW5kIGl0Lg0KDQpOb3QgZXhhY3Rs
eS4NCg0KRm9yIGkuTVg4TU0sIHdlIHN1cHBvcnQgdHdvIGNhc2VzLiBNNCBraWNrZWQgYnkgVS1C
b290LCBNNCBraWNrZWQgYnkgTGludXggcmVtb3RlcHJvYy4NCkZvciBpLk1YOFFNL1FYUCwgdGhl
IHR5cGljYWwgdXNlY2FzZSBpcyBNNCBraWNrZWQgYnkgU0NGVywgYnV0IHdlIHdpbGwgYWxzbyBh
ZGQgTTQga2lja2VkDQpieSBMaW51eCByZW1vdGVwcm9jLg0KRm9yIGkuTVg3VUxQLCBJIHdvdWxk
IG9ubHkgc3VwcG9ydCBNNCBkdWFsIGJvb3QgY2FzZSwgTTQgY29udHJvbCBldmVyeXRoaW5nLg0K
DQpUaGUgcmVhc29uIHRoZSBjaGFuZ2UgdGhlIGVsZiBwYXJzZXIgaXMgdGhhdCB3aGVuIE00IGVs
ZiBpcyBsb2FkZWQgYnkgTGludXggcmVtb3RlcHJvYywNCkl0IHVzZSBtZW1zZXQgdG8gY2xlYXIg
YXJlYS4gSG93ZXZlciB3ZSB1c2UgaW9yZW1hcCwgbWVtc2V0IG9uIEFSTTY0IHdpbGwgcmVwb3J0
DQpjcmFzaCB0byBkZXZpY2UgbkduUkUgbWVtb3J5LiBBbmQgd2UgY291bGQgbm90IHVzZSBpb3Jl
bWFwX3djIHRvIFRDTSBhcmVhLCBzaW5jZQ0KaXQgY291bGQgaGF2ZSBkYXRhIGNvcnJlY3RseSB3
cml0dGVuIGludG8gVENNLg0KDQpNYWludGFpbmVyIG5vdCB3YW5uYSB0byBkcm9wIG1lbXNldCBp
biBjb21tb24gY29kZSwgYW5kIFRJIGd1eXMgc3VnZ2VzdA0KYWRkIGkuTVggc3BlY2lmaWMgZWxm
IHN0dWZmLiBTbyBJIGFkZCBlbGYgaGFuZGxlciBpbiBpLk1YIGNvZGUuDQoNClRoYW5rcywNClBl
bmcuDQoNCj4gDQo+IENvcnJlY3Q/DQo+IA0KPiA+IFBlbmcgRmFuICgxMCk6DQo+ID4gICBkdC1i
aW5kaW5nczogcmVtb3RlcHJvYzogaW14X3Jwcm9jOiBhZGQgaS5NWDhNUS9NDQo+ID4gICByZW1v
dGVwcm9jOiBpbXhfcnByb2M6IGNvcnJlY3QgZXJyIG1lc3NhZ2UNCj4gPiAgIHJlbW90ZXByb2M6
IGlteDogdXNlIGRldm1faW9yZW1hcA0KPiA+ICAgcmVtb3RlcHJvYzogaW14X3Jwcm9jOiBtYWtl
IHN5c2NvbiBvcHRpb25hbA0KPiA+ICAgcmVtb3RlcHJvYzogaW14X3Jwcm9jOiBtYWtlIGNsayBv
cHRpb25hbA0KPiA+ICAgcmVtb3RlcHJvYzogaW14X3Jwcm9jOiBhZGQgbG9hZCBob29rDQo+ID4g
ICByZW1vdGVwcm9jOiBpbXhfcnByb2M6IGFkZCBpLk1YIHNwZWNpZmljIHBhcnNlIGZ3IGhvb2sN
Cj4gPiAgIHJlbW90ZXByb2M6IGlteF9ycHJvYzogc3VwcG9ydCBpLk1YOE1RL00NCj4gPiAgIHJl
bW90ZXByb2M6IGlteF9wcm9jOiBlbmFibGUgdmlydGlvL21haWxib3gNCj4gPiAgIHJlbW90ZXBy
b2M6IGlteF9ycHJvYzogc3VwcG9ydCBjb3Byb2MgYm9vdGluZyBiZWZvcmUgTGludXgNCj4gPg0K
PiA+ICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9yZW1vdGVwcm9jL2lteC1ycHJvYy50eHQgICB8
ICAgMyArDQo+ID4gIGRyaXZlcnMvcmVtb3RlcHJvYy9pbXhfcnByb2MuYyAgICAgICAgICAgICAg
ICAgICAgIHwgNDA5DQo+ICsrKysrKysrKysrKysrKysrKysrLQ0KPiA+ICAyIGZpbGVzIGNoYW5n
ZWQsIDQwMSBpbnNlcnRpb25zKCspLCAxMSBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IC0tDQo+ID4g
Mi4xNi40DQo+ID4NCj4gPg0KPiA+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fDQo+ID4gbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QNCj4gPiBsaW51
eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcNCj4gPiBodHRwOi8vbGlzdHMuaW5mcmFk
ZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwNCj4gPg0KPiANCj4gLS0N
Cj4gUGVuZ3V0cm9uaXggZS5LLiAgICAgICAgICAgICAgICAgICAgICAgICAgIHwNCj4gfA0KPiBT
dGV1ZXJ3YWxkZXIgU3RyLiAyMSAgICAgICAgICAgICAgICAgICAgICAgfA0KPiBodHRwOi8vd3d3
LnBlbmd1dHJvbml4LmRlLyAgfA0KPiAzMTEzNyBIaWxkZXNoZWltLCBHZXJtYW55ICAgICAgICAg
ICAgICAgICAgfCBQaG9uZToNCj4gKzQ5LTUxMjEtMjA2OTE3LTAgICAgfA0KPiBBbXRzZ2VyaWNo
dCBIaWxkZXNoZWltLCBIUkEgMjY4NiAgICAgICAgICAgfCBGYXg6DQo+ICs0OS01MTIxLTIwNjkx
Ny01NTU1IHwNCg==
