Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C7CC2BA19
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 10:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C07120776
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 10:39:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ghz8kfwE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbgDWKjr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 06:39:47 -0400
Received: from mail-eopbgr40072.outbound.protection.outlook.com ([40.107.4.72]:27005
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725863AbgDWKjq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 06:39:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TveFPiPUhWIg32R04eg8YX/zbTTD+V9hRPFMozQehgOQwTXz7zpEdp2njmUN40f9K4qcq7qiBLjq/rXVTceT2YdOYhN7mW5pnV7wiOqjfroI/drs5GHEJfvD8mSllZDdTykkcc3ZFRGWs1HcciaMfzHlSO3sKLL1Gd7yBK7W5Uul+e1X5Ipck0M8l1RK//R65TOyRMzwAikWuG1WJCYBO6B7SyGXK/sNBUSFGyaK83gjNU+pLJZs41u0Ck+tAoZkc90RgPya6aTn4tqNFlIzS+M49kC6IYShZh3SUbvaRVH/Z/1Smw5c7kMI2chx926uGTNhdFgBT5sFSlBaAbb1/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BgXQqXd3k7Ry5uSR/sCFL67uXejxjD4vgIHNxPEeZEE=;
 b=AV7OhwcsfgQ+UVZvsU6OWWD3qsVb6dZVAP8Gntu9WscsgGOlubyoUaDpUfEpo5xe99tmKiV9FCAOKSFnDfy7f+Y9DNTU2FZpxu5TjY5MH6e4oquZ4Vfw5MDZ0lcFlxYTr47fSKm2O27PsaVplDdjKMYtln2aV1Nc5rTON/fYF5DSRJCL7Ej4ZtGkCb9aLXX1hkceF8UUjl66i3n5OHEE2+yHq7djn9Ty44UmRhEweJY9Fb0QbuqVHE2XSt9VGcPXLJRbQbWfveAYrTJ95AcbNyCjGhd4p9q53OOuUgADyF+618IALZYNXmOCjoNYV7P2nllQsZW1e+I7k7Ok+KMaFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BgXQqXd3k7Ry5uSR/sCFL67uXejxjD4vgIHNxPEeZEE=;
 b=Ghz8kfwE6euXdV34e0anr5TVYHzr4izHYdavw3/VZskyxEG9sGduTUiX4HPPvumKzkssMbZ6WItLj9NTqOOJ8uT6NxvJG1gYyzHEoGnYZLudhaltngz3jOzJSVvIpPzYUgMgd7tMOCTCovup6s8mCOeWHP/kK+wULBCbxSSfaRc=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR04MB4326.eurprd04.prod.outlook.com (2603:10a6:209:4d::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Thu, 23 Apr
 2020 10:39:42 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::d9f7:5527:e89d:1ae3]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::d9f7:5527:e89d:1ae3%7]) with mapi id 15.20.2921.032; Thu, 23 Apr 2020
 10:39:42 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Peng Fan <peng.fan@nxp.com>,
        "broonie@kernel.org" <broonie@kernel.org>
CC:     "rafael@kernel.org" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>
Subject: RE: [PATCH] regmap: mmio: prepare/unprepare clk only when read/write
Thread-Topic: [PATCH] regmap: mmio: prepare/unprepare clk only when read/write
Thread-Index: AQHWGTO+pFfuDihUFU+ofwmpi1EKU6iGfXDw
Date:   Thu, 23 Apr 2020 10:39:42 +0000
Message-ID: <AM6PR04MB496625ACFE460F756C49270B80D30@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <1587620791-5279-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1587620791-5279-1-git-send-email-peng.fan@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9815e67a-1fa9-40e7-67dc-08d7e772a21d
x-ms-traffictypediagnostic: AM6PR04MB4326:|AM6PR04MB4326:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB4326AE4732574A210EA72F1580D30@AM6PR04MB4326.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:923;
x-forefront-prvs: 03827AF76E
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(39860400002)(136003)(346002)(366004)(396003)(2906002)(81156014)(76116006)(54906003)(8936002)(33656002)(86362001)(55016002)(9686003)(52536014)(5660300002)(66446008)(186003)(66476007)(66946007)(66556008)(64756008)(4326008)(478600001)(8676002)(6506007)(71200400001)(110136005)(44832011)(316002)(7696005)(26005);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y7jT7KLMHrIvBWNzjeUrtsZce70/pEZSTVbRLVdNcxaaNYvWnElMfS1633EKZyIMy1DRMVor6SdPdBqnCvtzw93hBvxPR4PgaZqfq/C4Tt6ugEibsDERL9ajWermlZC1PIEAXtVW7ftgaYn+Q2ztCVL+xvwQb1cm1abWEzxZTTgqicAl+gatNbjoR42MSioj0FRCKZvbXfN6G5ZhIqMpvKYhf3QhR8J5ZHbXnrLBxoJta7l80Y+FeM1wz+fX+y1DOxn6qphopbBPdtMFT/LPptXAaoSHj95+q+PLFqqiBs1eUnTOw0ZupGL+HqmuwbTep+i0D6KGcdPSccLV2rkRx7PIIDtGebCrUwvH6PVOqOdczzBHBEfqHc06PV31/ctmAftLTyIht8fnmxIFUlwD7C0G0g/xyk0pgg0kIxOEU5TuW+gILBCOl/MGdqXfBEAW
x-ms-exchange-antispam-messagedata: ss23oECr++YzVb9UCfejOJJJMec/Wb64aRR1+oJP+FnQ5r3o1BOLFfDexjGSkasi5ixvjrR2PmX8+hB5nI6hswhPtKLWHrHtmXWlmABgbV056R9z2CoCPFveHIF1QxH7xa1qMpCtrnEO7dVxlnCA6Q==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9815e67a-1fa9-40e7-67dc-08d7e772a21d
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2020 10:39:42.7739
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x3gsuOQgkkrCtKBebAMa+uLsY1hGjNLL4SDDE8QpnT/9g1Ku428yoJTSWJR4IL+K8mS9YylpuFtv1PcoG2SVMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4326
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIEFw
cmlsIDIzLCAyMDIwIDE6NDcgUE0NCj4gDQo+IHVzZSBjbGtfcHJlcGFyZSBhdCB0aGUgdmVyeSBi
ZWdpbm5pbmcgd2lsbCBpbnZva2UgcG0gcnVudGltZSByZXN1bWUsIGlmIHRoZSBjbGsgaXMNCj4g
YmluZGVkIHdpdGggYSBwb3dlciBkb21haW4uIFRoaXMgd2lsbCBjYXVzZSBydW50aW1lIHBvd2Vy
IGhpZ2guIExldCdzIHVzZQ0KPiBjbGtfcHJlcGFyZV9lbmFibGUgYW5kIGNsa19kaXNhYmxlX3Vu
cHJlcGFyZSB3aGVuIHJlYWQvd3JpdGUgdG8gYXZvaWQgdGhlDQo+IHJ1bnRpbWUgcG93ZXIgaXNz
dWUuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCg0K
SSB3b25kZXIgeW91IG1heSBjYW4ndCBkbyB0aGF0IGJlY2F1c2UgbW1pbyBidXMgaXMgdXNpbmcg
c3BpbmxvY2suDQoNClJlZ2FyZHMNCkFpc2hlbmcNCg0KPiAtLS0NCj4gIGRyaXZlcnMvYmFzZS9y
ZWdtYXAvcmVnbWFwLW1taW8uYyB8IDE5ICsrKysrLS0tLS0tLS0tLS0tLS0NCj4gIDEgZmlsZSBj
aGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDE0IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvYmFzZS9yZWdtYXAvcmVnbWFwLW1taW8uYw0KPiBiL2RyaXZlcnMvYmFzZS9y
ZWdtYXAvcmVnbWFwLW1taW8uYw0KPiBpbmRleCBhZjk2N2Q4Zjk3NWUuLmExYWQ3NDE5YzRhMyAx
MDA2NDQNCj4gLS0tIGEvZHJpdmVycy9iYXNlL3JlZ21hcC9yZWdtYXAtbW1pby5jDQo+ICsrKyBi
L2RyaXZlcnMvYmFzZS9yZWdtYXAvcmVnbWFwLW1taW8uYw0KPiBAQCAtMTE4LDcgKzExOCw3IEBA
IHN0YXRpYyBpbnQgcmVnbWFwX21taW9fd3JpdGUodm9pZCAqY29udGV4dCwgdW5zaWduZWQNCj4g
aW50IHJlZywgdW5zaWduZWQgaW50IHZhbCkNCj4gIAlpbnQgcmV0Ow0KPiANCj4gIAlpZiAoIUlT
X0VSUihjdHgtPmNsaykpIHsNCj4gLQkJcmV0ID0gY2xrX2VuYWJsZShjdHgtPmNsayk7DQo+ICsJ
CXJldCA9IGNsa19wcmVwYXJlX2VuYWJsZShjdHgtPmNsayk7DQo+ICAJCWlmIChyZXQgPCAwKQ0K
PiAgCQkJcmV0dXJuIHJldDsNCj4gIAl9DQo+IEBAIC0xMjYsNyArMTI2LDcgQEAgc3RhdGljIGlu
dCByZWdtYXBfbW1pb193cml0ZSh2b2lkICpjb250ZXh0LCB1bnNpZ25lZA0KPiBpbnQgcmVnLCB1
bnNpZ25lZCBpbnQgdmFsKQ0KPiAgCWN0eC0+cmVnX3dyaXRlKGN0eCwgcmVnLCB2YWwpOw0KPiAN
Cj4gIAlpZiAoIUlTX0VSUihjdHgtPmNsaykpDQo+IC0JCWNsa19kaXNhYmxlKGN0eC0+Y2xrKTsN
Cj4gKwkJY2xrX2Rpc2FibGVfdW5wcmVwYXJlKGN0eC0+Y2xrKTsNCj4gDQo+ICAJcmV0dXJuIDA7
DQo+ICB9DQo+IEBAIC0xNzUsNyArMTc1LDcgQEAgc3RhdGljIGludCByZWdtYXBfbW1pb19yZWFk
KHZvaWQgKmNvbnRleHQsIHVuc2lnbmVkDQo+IGludCByZWcsIHVuc2lnbmVkIGludCAqdmFsKQ0K
PiAgCWludCByZXQ7DQo+IA0KPiAgCWlmICghSVNfRVJSKGN0eC0+Y2xrKSkgew0KPiAtCQlyZXQg
PSBjbGtfZW5hYmxlKGN0eC0+Y2xrKTsNCj4gKwkJcmV0ID0gY2xrX3ByZXBhcmVfZW5hYmxlKGN0
eC0+Y2xrKTsNCj4gIAkJaWYgKHJldCA8IDApDQo+ICAJCQlyZXR1cm4gcmV0Ow0KPiAgCX0NCj4g
QEAgLTE4Myw3ICsxODMsNyBAQCBzdGF0aWMgaW50IHJlZ21hcF9tbWlvX3JlYWQodm9pZCAqY29u
dGV4dCwgdW5zaWduZWQNCj4gaW50IHJlZywgdW5zaWduZWQgaW50ICp2YWwpDQo+ICAJKnZhbCA9
IGN0eC0+cmVnX3JlYWQoY3R4LCByZWcpOw0KPiANCj4gIAlpZiAoIUlTX0VSUihjdHgtPmNsaykp
DQo+IC0JCWNsa19kaXNhYmxlKGN0eC0+Y2xrKTsNCj4gKwkJY2xrX2Rpc2FibGVfdW5wcmVwYXJl
KGN0eC0+Y2xrKTsNCj4gDQo+ICAJcmV0dXJuIDA7DQo+ICB9DQo+IEBAIC0xOTMsNyArMTkzLDYg
QEAgc3RhdGljIHZvaWQgcmVnbWFwX21taW9fZnJlZV9jb250ZXh0KHZvaWQgKmNvbnRleHQpDQo+
ICAJc3RydWN0IHJlZ21hcF9tbWlvX2NvbnRleHQgKmN0eCA9IGNvbnRleHQ7DQo+IA0KPiAgCWlm
ICghSVNfRVJSKGN0eC0+Y2xrKSkgew0KPiAtCQljbGtfdW5wcmVwYXJlKGN0eC0+Y2xrKTsNCj4g
IAkJaWYgKCFjdHgtPmF0dGFjaGVkX2NsaykNCj4gIAkJCWNsa19wdXQoY3R4LT5jbGspOw0KPiAg
CX0NCj4gQEAgLTMwNSwxMiArMzA0LDYgQEAgc3RhdGljIHN0cnVjdCByZWdtYXBfbW1pb19jb250
ZXh0DQo+ICpyZWdtYXBfbW1pb19nZW5fY29udGV4dChzdHJ1Y3QgZGV2aWNlICpkZXYsDQo+ICAJ
CWdvdG8gZXJyX2ZyZWU7DQo+ICAJfQ0KPiANCj4gLQlyZXQgPSBjbGtfcHJlcGFyZShjdHgtPmNs
ayk7DQo+IC0JaWYgKHJldCA8IDApIHsNCj4gLQkJY2xrX3B1dChjdHgtPmNsayk7DQo+IC0JCWdv
dG8gZXJyX2ZyZWU7DQo+IC0JfQ0KPiAtDQo+ICAJcmV0dXJuIGN0eDsNCj4gDQo+ICBlcnJfZnJl
ZToNCj4gQEAgLTM2MSw3ICszNTQsNyBAQCBpbnQgcmVnbWFwX21taW9fYXR0YWNoX2NsayhzdHJ1
Y3QgcmVnbWFwICptYXAsDQo+IHN0cnVjdCBjbGsgKmNsaykNCj4gIAljdHgtPmNsayA9IGNsazsN
Cj4gIAljdHgtPmF0dGFjaGVkX2NsayA9IHRydWU7DQo+IA0KPiAtCXJldHVybiBjbGtfcHJlcGFy
ZShjdHgtPmNsayk7DQo+ICsJcmV0dXJuIDA7DQo+ICB9DQo+ICBFWFBPUlRfU1lNQk9MX0dQTChy
ZWdtYXBfbW1pb19hdHRhY2hfY2xrKTsNCj4gDQo+IEBAIC0zNjksOCArMzYyLDYgQEAgdm9pZCBy
ZWdtYXBfbW1pb19kZXRhY2hfY2xrKHN0cnVjdCByZWdtYXAgKm1hcCkNCj4gew0KPiAgCXN0cnVj
dCByZWdtYXBfbW1pb19jb250ZXh0ICpjdHggPSBtYXAtPmJ1c19jb250ZXh0Ow0KPiANCj4gLQlj
bGtfdW5wcmVwYXJlKGN0eC0+Y2xrKTsNCj4gLQ0KPiAgCWN0eC0+YXR0YWNoZWRfY2xrID0gZmFs
c2U7DQo+ICAJY3R4LT5jbGsgPSBOVUxMOw0KPiAgfQ0KPiAtLQ0KPiAyLjE2LjQNCg0K
