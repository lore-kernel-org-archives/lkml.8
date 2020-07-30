Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D008C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 01:14:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E608B2074B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 01:14:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="iS/YMDwL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbgG3BOO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 21:14:14 -0400
Received: from mail-eopbgr70044.outbound.protection.outlook.com ([40.107.7.44]:32263
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725851AbgG3BON (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 21:14:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KDSLK04NucYkHy2nzJv4HuMf1TEqE2IMc9P3t3xdQZLGkZXeBUEVSi2uiGvCrmanaTnO01L/2lpnIkM9hCx+EdZ/FckhS/7w6xBXTR9Qwcx1EgeKOYaOT2dBgihj/sMolBAr2o2AknnJaRiFV9YX6hEUyZym+LYB0R4b7AXqgs2247QpuUGEn31xLyq+yBpxs+8pVkhPhPD5XJuxxGZw26P4quHZk33rNYJmK0H2wILgnUVHedyB7a3oA1oD52dIZbDRmAesP5iBRRrOoDawHTZBjNRJOdXVbxvtL0FmyXYuvFjKoJfePPPTl8DAj1ZuUTsc2RSgRMwTyZ8NSuf4BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S8nOBMNwBSQwukf6r+4hE61HBrSRBYCO9O/8AVN1DTQ=;
 b=HEU6+yK7YGJs2tiK9Ptx9jZU2HLq/kMx2x3DN7n2LxKovWSPdHaXEPVJPVStifOgfJpyH9xogUiZlMNq3+1EV03lkFf3E4BmT0+oPwKDssLO//kZE4ncZJkUL/uCtPrqXOpeAlkSq9MvEnlTeWTIwFhwMBsF4/vxIwKyY+05gcBlUIp4qp33XewOM7UfT1WpwGCBZN3KgYKQgqQY6lqo7GS2G1iHHEXk534mFkaXAXNLeeCsHVS5XZrvZr2fwe9Ma+OUEYYJ5xpyYkSnH9EXzYxeX4uPC9bL4Yr0chnjFtTUFmUUeCFGoZ+ORUppDKRi6xlZ5DzttuFiBck9Us5YQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S8nOBMNwBSQwukf6r+4hE61HBrSRBYCO9O/8AVN1DTQ=;
 b=iS/YMDwLIemQSSfyq2RkTdaiPNBPwbAhFMkde4SOTtlH28XyWowSGnolmMwU+2Sd6V0avyKf2ZgwfnW32/EBIFcRZQ01SZWWbwoGB/Lqtq0GybPxVDHZUxiLwgj+k+aMzsLTS/Zr2h0KRqr6JQTAAUBXDrkYpZsrSkuP+hnhogw=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (2603:10a6:8:10::18)
 by DB8PR04MB7050.eurprd04.prod.outlook.com (2603:10a6:10:129::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17; Thu, 30 Jul
 2020 01:14:08 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::49f8:20ce:cf20:80b3]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::49f8:20ce:cf20:80b3%6]) with mapi id 15.20.3216.034; Thu, 30 Jul 2020
 01:14:08 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "arnd@arndb.de" <arnd@arndb.de>, Peng Fan <peng.fan@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>, Andy Duan <fugang.duan@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "yuehaibing@huawei.com" <yuehaibing@huawei.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V7 1/6] clk: imx6sl: Use BIT(x) to avoid shifting signed
 32-bit value by 31 bits
Thread-Topic: [PATCH V7 1/6] clk: imx6sl: Use BIT(x) to avoid shifting signed
 32-bit value by 31 bits
Thread-Index: AQHWZbf31I7BtnmqO0Gipqqw0aCR4aketDaAgACFjvCAAAwLAIAAC0MA
Date:   Thu, 30 Jul 2020 01:14:08 +0000
Message-ID: <DB3PR0402MB3916E18C8B36010D60086EA2F5710@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1596034117-24246-1-git-send-email-Anson.Huang@nxp.com>
 <1596034117-24246-2-git-send-email-Anson.Huang@nxp.com>
 <86ae1d4e-27c9-07e4-73be-37d490cb0063@infradead.org>
 <DB3PR0402MB3916559F7E1908D76B47FE66F5700@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <34161e5c-0e83-97de-3cb6-1040d8abdc71@infradead.org>
In-Reply-To: <34161e5c-0e83-97de-3cb6-1040d8abdc71@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 39193609-d97d-41a1-a2bd-08d83425dc42
x-ms-traffictypediagnostic: DB8PR04MB7050:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR04MB7050D07DC90CF0D0EB2EEB5EF5710@DB8PR04MB7050.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mHXwBV5cT7JqYFtRZXDOMt0KAWj8skv1SO8UqmSspY9h0brCVubdflP8l5foFYV340HXM8fE6ZTQcSZYQ2G0o4Tqx/JJFoZiXX0b6X/ARJcv8kdfAZT2zF+fYscYcGqCTT+5LAqr8/b5kFplJ1/2FWFWmPT8Nd8iUvyvzbksYGc9LENNpPuLH3PRkiWlyHaVuhdmXX9MdKJ660sIPtEzNtX9hyEUQCxsORDGKu1QWU77NBGfyxKXigUZuKcXH3ED7ZVnU6RqvTxxUj8aQXf9oVStWrD9u0mcxP18036gqhnDC3dotxKvYh+vedmYFExYQpbkFRCkX4CqbGQOPlZo0jQM+Pj6j4vfoFag/Ksf6loUS+kcgnrlP+r8/CojVKOWlQboHFxT6Hf2WIfn2dTM0Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(39860400002)(376002)(366004)(396003)(136003)(53546011)(66946007)(76116006)(66476007)(64756008)(5660300002)(66556008)(8676002)(478600001)(6506007)(26005)(7696005)(316002)(9686003)(71200400001)(66446008)(52536014)(44832011)(2906002)(55016002)(4326008)(186003)(83380400001)(33656002)(8936002)(7416002)(86362001)(110136005)(921003)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 2zlzUvOKPagKruPMKXb/uvHHy/RDZJMc5wyW/o0G5AXEb4UOfz6od2ZtIju8wFhiBFEy893+s+ujMEsRlD4aMm461qmA7Lb0q7OkcCeGd3YNDotOx+RoDS9Mt7ce57iuv3kp/zxdKPmYsp7oA4qzEnoLY6wnVvJoeqs5wxd0fR9b+nGb3BvW/+V6FB01xMCDrj3uyMgcW1mwt1LpTjlncPDApnk2GfIF117mOS29a8eGMHsUHe/1iNaZ/J8WWEFQt/yjZLEVxRqxW7OnyARP9jvUJCLIJoVwlM3qDxwM38aTUOGBS4NXUuFwzdk6439xQbAtbAi1o17RWsVrf3Hs/b/r6kF4OBwxAZxoqEpIG4A/cVJov35yeMdtoQ50lpRuLZXx802pHEtJhCUJgP6Kh2x9eBtXEyS8fgmSfPKK5lD75Swslj5egTe/bFV9vf2ZhE17raGq0LsbNCCvRCtPO9JRjpKbjl1W1AAvfAosxQEq3jdQCXcre2bcE4jRAxroKSMqRlN/cgnD9WBvNXH9f+UKKD5iZxW8Ft+AqmOsFjYn3tPvr9Vp2888D+2giTEiZWstauqHGC5wk69x/ZQMM3OoOWyk0N/6y+oOs8YiZacdaCk1/4EjM8un2XoheCA0Keg+TWtA2+zaGBipXGtYaA==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB3PR0402MB3916.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39193609-d97d-41a1-a2bd-08d83425dc42
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2020 01:14:08.3545
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UBCQKixsfvLxYGwnZ0I/sDBaeiqmfekBnSXdV7ZZI+9mfe2oFTx0uwge9sQ1lnH0Y2bfzv22+31FHjYrz8gI9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7050
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFJhbmR5DQoNCg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIFY3IDEvNl0gY2xrOiBpbXg2c2w6
IFVzZSBCSVQoeCkgdG8gYXZvaWQgc2hpZnRpbmcgc2lnbmVkDQo+IDMyLWJpdCB2YWx1ZSBieSAz
MSBiaXRzDQo+IA0KPiBPbiA3LzI5LzIwIDQ6NTEgUE0sIEFuc29uIEh1YW5nIHdyb3RlOg0KPiA+
IEhpLCBSYW5keQ0KPiA+DQo+ID4NCj4gPj4gU3ViamVjdDogUmU6IFtQQVRDSCBWNyAxLzZdIGNs
azogaW14NnNsOiBVc2UgQklUKHgpIHRvIGF2b2lkIHNoaWZ0aW5nDQo+ID4+IHNpZ25lZCAzMi1i
aXQgdmFsdWUgYnkgMzEgYml0cw0KPiA+Pg0KPiA+PiBPbiA3LzI5LzIwIDc6NDggQU0sIEFuc29u
IEh1YW5nIHdyb3RlOg0KPiA+Pj4gVXNlIHJlYWRsX3JlbGF4ZWQoKSBpbnN0ZWFkIG9mIF9fcmF3
X3JlYWRsKCksIGFuZCB1c2UgQklUKHgpIGluc3RlYWQNCj4gPj4+IG9mICgxIDw8IFgpIHRvIGZp
eCBiZWxvdyBidWlsZCB3YXJuaW5nIHJlcG9ydGVkIGJ5IGtlcm5lbCB0ZXN0IHJvYm90Og0KPiA+
Pj4NCj4gPj4+IGRyaXZlcnMvY2xrL2lteC9jbGstaW14NnNsLmM6MTQ5OjQ5OiB3YXJuaW5nOiBT
aGlmdGluZyBzaWduZWQgMzItYml0DQo+ID4+PiB2YWx1ZSBieSAzMSBiaXRzIGlzIHVuZGVmaW5l
ZCBiZWhhdmlvdXIgW3NoaWZ0VG9vTWFueUJpdHNTaWduZWRdDQo+ID4+PiAgICAgIHdoaWxlICgh
KF9fcmF3X3JlYWRsKGFuYXRvcF9iYXNlICsgUExMX0FSTSkgJg0KPiA+PiBCTV9QTExfQVJNX0xP
Q0spKQ0KPiA+Pj4NCj4gPj4+IFNpZ25lZC1vZmYtYnk6IEFuc29uIEh1YW5nIDxBbnNvbi5IdWFu
Z0BueHAuY29tPg0KPiA+Pj4gUmVwb3J0ZWQtYnk6IGtlcm5lbCB0ZXN0IHJvYm90IDxsa3BAaW50
ZWwuY29tPg0KPiA+Pj4gLS0tDQo+ID4+PiBDaGFuZ2VzIHNpbmNlIFY2Og0KPiA+Pj4gCS0gaW1w
cm92ZSB0aGUgc3ViamVjdC4NCj4gPj4+IC0tLQ0KPiA+Pj4gIGRyaXZlcnMvY2xrL2lteC9jbGst
aW14NnNsLmMgfCAxNSArKysrKysrKy0tLS0tLS0NCj4gPj4+ICAxIGZpbGUgY2hhbmdlZCwgOCBp
bnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQ0KPiA+Pj4NCj4gPj4+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2Nsay9pbXgvY2xrLWlteDZzbC5jDQo+ID4+PiBiL2RyaXZlcnMvY2xrL2lteC9jbGst
aW14NnNsLmMgaW5kZXggMGY2NDdkMS4uZTY5ZGJhMSAxMDA2NDQNCj4gPj4+IC0tLSBhL2RyaXZl
cnMvY2xrL2lteC9jbGstaW14NnNsLmMNCj4gPj4+ICsrKyBiL2RyaXZlcnMvY2xrL2lteC9jbGst
aW14NnNsLmMNCj4gPj4+IEBAIC0zLDYgKzMsNyBAQA0KPiA+Pj4gICAqIENvcHlyaWdodCAyMDEz
LTIwMTQgRnJlZXNjYWxlIFNlbWljb25kdWN0b3IsIEluYy4NCj4gPj4+ICAgKi8NCj4gPj4+DQo+
ID4+PiArI2luY2x1ZGUgPGxpbnV4L2JpdGZpZWxkLmg+DQo+ID4+DQo+ID4+IEhpLA0KPiA+PiBJ
IHRoaW5rIHlvdSB3YW50DQo+ID4+ICNpbmNsdWRlIDxsaW51eC9iaXRzLmg+DQo+ID4+DQo+ID4+
IGZvciBCSVQoKSB1c2FnZS4NCj4gPg0KPiA+IEFjdHVhbGx5LCB0aGUgbGludXgvb2YuaCBhbHJl
YWR5IGluY2x1ZGVzIGxpbnV4L2JpdG9wcy5oIGFuZA0KPiA+IGxpbnV4L2JpdG9wcy5oIGluY2x1
ZGVzIGxpbnV4L2JpdHMuaCwgc28gSSB3aWxsIGp1c3QgZHJvcCBsaW51eC9iaXRmaWVsZC5oIGFu
ZA0KPiBzZW5kIGEgVjguDQo+IA0KPiBvciB5b3UgY291bGQgcmVhZCBEb2N1bWVudGF0aW9uL3By
b2Nlc3Mvc3VibWl0LWNoZWNrbGlzdC5yc3QsDQo+IHdoZXJlIHJ1bGUgIzEgc2F5czoNCj4gDQo+
IDEpIElmIHlvdSB1c2UgYSBmYWNpbGl0eSB0aGVuICNpbmNsdWRlIHRoZSBmaWxlIHRoYXQgZGVm
aW5lcy9kZWNsYXJlcw0KPiAgICB0aGF0IGZhY2lsaXR5LiAgRG9uJ3QgZGVwZW5kIG9uIG90aGVy
IGhlYWRlciBmaWxlcyBwdWxsaW5nIGluIG9uZXMNCj4gICAgdGhhdCB5b3UgdXNlLg0KDQpVbmRl
cnN0b29kLCB3aGlsZSBJIHNlYXJjaCAiQklUKCkiIGluIGNsayBkcml2ZXIsIG1vc3Qgb2YgdGhl
IGRyaXZlcnMgZG9lcyBOT1QgaW5jbHVkZQ0KbGludXgvYml0cy5oIGV2ZW4gdGhleSB1c2UgaXQu
DQoNCkJ1dCBPSywgSSB3aWxsIHNlbmQgVjkgdG8gaW5jbHVkZSBpdC4NCg0KVGhhbmtzLA0KQW5z
b24NCg0KDQoNCg0K
