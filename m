Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EFE2C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 06:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04B872076B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 06:02:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="JoxO1z0D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbgHKGC2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 02:02:28 -0400
Received: from mail-am6eur05on2062.outbound.protection.outlook.com ([40.107.22.62]:8321
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726083AbgHKGC2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 02:02:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G3zFV52p418Rny55LcUUt1e39ieEMYBzl7V5ZoYXUC6pTxRuWr0PwVhaniJYzlZhGSCFEsxhs0hfNrXzjdZ5ZqnFeykRIKVF92+RL32VHT3YfEehOCtCkq51sitPlkOuOujRr7zTyKMOeATfI5paFXLlfmBqm88A54gk6rQrluCudaMyh5MCgMBIh9kL060TlY+WIzY3DzmS66wEaj6byDrRPXwkkCY2sj92Oc5KsXyv3Yiq8drkMD+R9roYW5scGgxSCW6Eac0Etg1aZVmuKLFhiItYeQTNAj7ES/heqxYg+CExgRgF87QkRobhmZ69Ooljf9Q9fnCTpxaESPWHSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7iWCoWI+dGCVhGOdZMHpAy+TzgtuTfgiPoTULXJg+Zk=;
 b=YZQojALW18hJfwTOvqUSDETGny1Qeyz/UI+nqUIqTJwjj/wNpO4fh+nz/CxvtVynkyMZ2kGtIfRIIDfbeKwbskIzFgwZfF7z792zMavL+yB92ap9GuVq52hGRfpaee9Kgies7UVs+SP4jUMucHsZGfs3T+rND+hL3QLT/RGLRs8kVbTyW9L5jppqcs2EK1BBiKBQEKTMDzW6PLoayfHWNxvUNtw+OnPFAwLyDKYqxWfL77wf7cHmke36V+cmhxv/DT/k1ZWDp6HJQlqGXNM089zfy2i19w1BsOaIHglyqh6n9mxlOO5RfWJEVucurQOSQX3YKBw5a3cxir2ZitpcoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7iWCoWI+dGCVhGOdZMHpAy+TzgtuTfgiPoTULXJg+Zk=;
 b=JoxO1z0DhOE51DhPxGd/wDPa2ji4DtaSTBxLSFMWW253w5EC8nYLnZnELubOjw8BjEASQC+nV14uTBPhI7kk7A12Egfd3Ql6jOZsJdfN7w45oHjY9YKFeT90lkcIjd2S2bvPy8HzJaQB18/y2UNkeeKau1UQQgIRmvhLphdWz2Y=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (2603:10a6:8:10::18)
 by DB7PR04MB5465.eurprd04.prod.outlook.com (2603:10a6:10:85::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.16; Tue, 11 Aug
 2020 06:02:25 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::8db5:8715:8570:1406]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::8db5:8715:8570:1406%7]) with mapi id 15.20.3261.025; Tue, 11 Aug 2020
 06:02:25 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "maz@kernel.org" <maz@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 1/2] irqchip/imx-intmux: Use dev_err_probe() to simplify
 error handling
Thread-Topic: [PATCH 1/2] irqchip/imx-intmux: Use dev_err_probe() to simplify
 error handling
Thread-Index: AQHWb5gVemUuAr1DYEmMSHzUy/pgSKkyZkqAgAAESeA=
Date:   Tue, 11 Aug 2020 06:02:24 +0000
Message-ID: <DB3PR0402MB3916C979E73D47F21E29F3EEF5450@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1597119905-7341-1-git-send-email-Anson.Huang@nxp.com>
 <178e532c-723c-75da-6c24-fd3a720843fb@pengutronix.de>
In-Reply-To: <178e532c-723c-75da-6c24-fd3a720843fb@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 61d179e2-b915-49b2-7a7b-08d83dbc1ea8
x-ms-traffictypediagnostic: DB7PR04MB5465:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR04MB5465DBFBA6CFEAFEDE951E65F5450@DB7PR04MB5465.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dSs262elmZTB4bH0IjDVRubL27llcec1DCLzRxMTuF/UR0YMFdPR52FHlvYL8mcaJj1t88zQEdxhk3O8l8Vg6xv4t+hEI/sKj0dlBpHTWn7OgPTenl03RIcWEdpr+TlJDq2Q2hsoWf9Acg/DCI9AoWnCSFdIIcsDLmzJ4h1x9oWqzH5SF3zlKBFlTuSFCVPqjN1a5ul1bK6h0lht+PYN3iRQIs1cylUPS1FonN13HnTaYKHM6x3JtqqvwNzZWXxyJFZPQfDk2LNV7Du4l8XcPAaRmwRhOqtVhcnQxxXq+K9qUTjQvk1Ai3AxiHtWZp64gzL4gy91OMpDVyQmw+oGWjah6PeJ9iHQYv6335b/eRkHHovFl/WMBu/2PmTJwZqA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(346002)(376002)(136003)(396003)(39860400002)(66946007)(478600001)(76116006)(26005)(110136005)(86362001)(5660300002)(6506007)(66476007)(2906002)(44832011)(186003)(4326008)(7696005)(316002)(8676002)(53546011)(8936002)(66446008)(64756008)(66556008)(52536014)(7416002)(33656002)(71200400001)(55016002)(83380400001)(9686003)(921003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: BWSu2ZKa5JdLXo5nGztFiFYRRTpX8ZSFTaO+Tok9eI+zirsY+y/qp6k8jr7NH/BS6hdloEnC6U6e/aO0FnNCDNSJV1l8LqkCV5J8U155LiG2BlwHeTnB0ZbCDm1fcSMNLMp6KHeKj09uUAZxvP68UCd4H6HCICScE27w+TRXd27h5ZVdovGDVqRBIHovSvwyEVGUyFxOojsky4GBTFGH/VJyOsZyUGcgaPa883z+VlGoL2YlNzk7A+TfaC4m6hPOTlPqDwZ7Q74sD6QxmLHWri8UWWPHX9b6IVqK3lv0Gpvn2MYMJmI3P+IRDrp5rGVfkPD1rGWbUEo6YwFUTBAxUcktQEGUOTAYopEM6yb2kU4JmBswLqK/UGUZ9purwlOhfgDJ1PqSmcZRR9gdgLc3PX/JePblNGMV/QxMAMNwIj5k/GSbDb3Fot/s0wOZ8tYQSoU0eExufWoIMpVbga5lWQhSjiWVPxfIr0/0BGQTYwO80AwfG4pY5rywb1F/1/PcP1Ms+AXnf6pQ7N1zbLX9gUGDI6iR4a8pk9g0ENxjDE2cQ3D8xpqWKFp52egCaKgV3TNuquae/eQztLgcT1EPMQ+lLhBFY0epvXAler9OxpLppztxA9xBP4tqHJ30KjGs9LbawSGYCZ0QW7nXzFdrUA==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB3PR0402MB3916.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61d179e2-b915-49b2-7a7b-08d83dbc1ea8
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2020 06:02:24.9679
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QyzQvbh2KJlB2FjpwLsG/i4jEancZtXpKlr/kiVyGep6+Gqj2cUzxpk6LpZu3SuEFH2iwHYw1RDrDJuTUC4EfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5465
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEFobWFkDQoNCg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDEvMl0gaXJxY2hpcC9pbXgtaW50
bXV4OiBVc2UgZGV2X2Vycl9wcm9iZSgpIHRvIHNpbXBsaWZ5DQo+IGVycm9yIGhhbmRsaW5nDQo+
IA0KPiBIZWxsbywNCj4gDQo+IE9uIDgvMTEvMjAgNjoyNSBBTSwgQW5zb24gSHVhbmcgd3JvdGU6
DQo+ID4gZGV2X2Vycl9wcm9iZSgpIGNhbiByZWR1Y2UgY29kZSBzaXplLCB1bmlmb3JtIGVycm9y
IGhhbmRsaW5nIGFuZA0KPiA+IHJlY29yZCB0aGUgZGVmZXIgcHJvYmUgcmVhc29uIGV0Yy4sIHVz
ZSBpdCB0byBzaW1wbGlmeSB0aGUgY29kZS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEFuc29u
IEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2lycWNo
aXAvaXJxLWlteC1pbnRtdXguYyB8IDEwICsrKystLS0tLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQs
IDQgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2lycWNoaXAvaXJxLWlteC1pbnRtdXguYw0KPiA+IGIvZHJpdmVycy9pcnFjaGlwL2ly
cS1pbXgtaW50bXV4LmMNCj4gPiBpbmRleCBlMzViN2IwLi4yZjUxZWM5IDEwMDY0NA0KPiA+IC0t
LSBhL2RyaXZlcnMvaXJxY2hpcC9pcnEtaW14LWludG11eC5jDQo+ID4gKysrIGIvZHJpdmVycy9p
cnFjaGlwL2lycS1pbXgtaW50bXV4LmMNCj4gPiBAQCAtMjI2LDEyICsyMjYsMTAgQEAgc3RhdGlj
IGludCBpbXhfaW50bXV4X3Byb2JlKHN0cnVjdA0KPiBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+
ID4gIAl9DQo+ID4NCj4gPiAgCWRhdGEtPmlwZ19jbGsgPSBkZXZtX2Nsa19nZXQoJnBkZXYtPmRl
diwgImlwZyIpOw0KPiA+IC0JaWYgKElTX0VSUihkYXRhLT5pcGdfY2xrKSkgew0KPiA+IC0JCXJl
dCA9IFBUUl9FUlIoZGF0YS0+aXBnX2Nsayk7DQo+ID4gLQkJaWYgKHJldCAhPSAtRVBST0JFX0RF
RkVSKQ0KPiA+IC0JCQlkZXZfZXJyKCZwZGV2LT5kZXYsICJmYWlsZWQgdG8gZ2V0IGlwZyBjbGs6
ICVkXG4iLCByZXQpOw0KPiA+IC0JCXJldHVybiByZXQ7DQo+ID4gLQl9DQo+ID4gKwlpZiAoSVNf
RVJSKGRhdGEtPmlwZ19jbGspKQ0KPiA+ICsJCXJldHVybiBkZXZfZXJyX3Byb2JlKCZwZGV2LT5k
ZXYsIFBUUl9FUlIoZGF0YS0+aXBnX2NsayksDQo+ID4gKwkJCQkgICAgICJmYWlsZWQgdG8gZ2V0
IGlwZyBjbGs6ICVsZFxuIiwNCj4gPiArCQkJCSAgICAgUFRSX0VSUihkYXRhLT5pcGdfY2xrKSk7
DQo+IA0KPiBIYXZlbid0IHVzZWQgZGV2X2Vycl9wcm9iZSBteXNlbGYgeWV0LCBidXQgdGhlIGZ1
bmN0aW9uIGRvZXMNCj4gDQo+IAlpZiAoZXJyICE9IC1FUFJPQkVfREVGRVIpIHsNCj4gCQlkZXZf
ZXJyKGRldiwgImVycm9yICVkOiAlcFYiLCBlcnIsICZ2YWYpOw0KPiANCj4gc28geW91ciBtZXNz
YWdlIHdvdWxkIGJlY29tZQ0KPiANCj4gCSJlcnJvciAlZDogZmFpbGVkIHRvIGdldCBpcGcgY2xr
OiAlZFxuIg0KPiANCj4gcHJpbnRpbmcgdGhlIHNhbWUgZXJyb3IgY29kZSB0d2ljZS4gSWYgc28s
IHlvdSBzaG91bGQgZHJvcCB0aGUgc2Vjb25kLg0KDQpDb3JyZWN0LCBJIHdpbGwgZml4IGl0IGlu
IFYyLg0KDQpUaGFua3MsDQpBbnNvbg0KDQoNCg==
