Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BEB4C11D01
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 07:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01609208C4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 07:44:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="mZcUg5NO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbgBTHoY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 02:44:24 -0500
Received: from mail-am6eur05on2049.outbound.protection.outlook.com ([40.107.22.49]:35552
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726248AbgBTHoY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 02:44:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TKeWJ1qaiWLdTohOpuRt+7Km5hL442PaGz5O740KQYoe60j3NnCMaeskxZJHjOMxIWP3BLCQODNTLMcNGNXOH/BOZWf+UkPRrLYTsymvqKiXSptnJxcdWPONh/I5hwHpukg2EBpEePn8LrEyYv50studQysbE0inPHs58xHRjEfDjzhXVXJpiDY6Lea3kcLYa95lO7hXH/CymCvVgBQxM3/lF83BTYzFPS2HNPieHXqsogW/auaSOZXdxNMI8LvjPeCrpLAansP3RvXvNI2Q+Y0ZiSGNw7Ra9OlHt+9c91SecwRzafVBA/SwFuanMyRBhQCGkVchrzzL2HqrBz/NSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V49bchaERnLp/GcZa0wESfo8dw/ygGSKc8PG74Db5+c=;
 b=apWCVmkg4Ufe3dBvDIJc3UmEdDlxa8TjtnRmspBf1Y1Vqw+P2+3Hd8jjlxPVPRYI9Hw844PC0Av0Y6356xBElFP12sseTRyL69xXOCZWewSdsLGUGXz5re5i/rFqAkvUcUgJSRSalAv0ZHF2Vc4B5JK4vb3LGmFl+3K4BarVPfE8jjjGD46P7Asix44HpG652WTdWBDAXtb70UOskWw/F4k98S1st2rnw3DLT0PvyOjMzkctZ2wbRCBjiyFGV6UInVvcOJuuNRh3yy0GaMPzFvAKWtfuu7LfSxZOPmRZnfbo5iVyTzRZ0QE9tp2negrXOYYgiRTNaVEyD8SZvrYWLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V49bchaERnLp/GcZa0wESfo8dw/ygGSKc8PG74Db5+c=;
 b=mZcUg5NOFNdrmBoIhSLcxjkfwn8mzEDKrb0b3CXa9nxZhQb8Rcdd/M4TrQQuB0cUvVuBa+RNjkE9A69FEtO9+YZO9wnEf3gqMGZ1gVfP9l3uqsv/iyPYdUTUS6Z7ABbGJxpr51t4U0ONICIMN0YaNMOGhvgdG/4GW1y8dkGQGfc=
Received: from VI1PR0402MB3839.eurprd04.prod.outlook.com (52.134.16.147) by
 VI1PR0402MB3901.eurprd04.prod.outlook.com (52.134.12.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.31; Thu, 20 Feb 2020 07:44:20 +0000
Received: from VI1PR0402MB3839.eurprd04.prod.outlook.com
 ([fe80::8881:e155:f058:c0d1]) by VI1PR0402MB3839.eurprd04.prod.outlook.com
 ([fe80::8881:e155:f058:c0d1%4]) with mapi id 15.20.2729.033; Thu, 20 Feb 2020
 07:44:20 +0000
From:   Daniel Baluta <daniel.baluta@nxp.com>
To:     Peng Fan <peng.fan@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "festevam@gmail.com" <festevam@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "olof@lixom.net" <olof@lixom.net>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "daniel.baluta@gmail.com" <daniel.baluta@gmail.com>
Subject: Re: [PATCH V4 1/2] firmware: imx: add dummy functions
Thread-Topic: [PATCH V4 1/2] firmware: imx: add dummy functions
Thread-Index: AQHV57c7B86rtqG22kWkq8prRlRnb6gjs6+A
Date:   Thu, 20 Feb 2020 07:44:20 +0000
Message-ID: <a5134838-53d4-97f0-d126-b94164871763@nxp.com>
References: <1582179843-14375-1-git-send-email-peng.fan@nxp.com>
 <1582179843-14375-2-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1582179843-14375-2-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 29e4d806-0b8d-423a-24ca-08d7b5d8b269
x-ms-traffictypediagnostic: VI1PR0402MB3901:|VI1PR0402MB3901:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0402MB3901B3A0C3AD8CF33629115CF9130@VI1PR0402MB3901.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 031996B7EF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(376002)(396003)(39860400002)(346002)(136003)(189003)(199004)(6506007)(2616005)(5660300002)(2906002)(44832011)(36756003)(26005)(8936002)(53546011)(6512007)(66476007)(4326008)(66446008)(64756008)(76116006)(66946007)(66556008)(71200400001)(186003)(81156014)(81166006)(54906003)(86362001)(110136005)(31686004)(31696002)(478600001)(6486002)(316002)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3901;H:VI1PR0402MB3839.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YuZhoJqv2+VnrhYOyq93Sn87szQO2WPBV4pRMh/z0evsa5ptUBY5Vj3f5VwhTCp+FKBVTiWwogf+IwCACBo5QfFMlTNCJ1omWZIlr6u5DKg0F2W0plc4gVINR/jW8APV2/UvwpXyzd2kzMce9bb70nljmjF+ZiZTPYszd9rKhCN0hhURQizxZvXdHsC9q+K4oGpk2oGSMVmnO2NoPHFE/xIZpncm4T5Nl0mgbIsU+1Yr/7BEuH2wGOPqtiUltVbvnzodcergvK6EoY2aYqT95zQICo01gazfqhgedlpnwP/kTvMXRHbynpH3da5rn5QXblfGVEuQslLw/Kk+wl302kjxmeUzazxBB85ehblVD8JcXkFRiDkNZoRsa0ETfzTa5bgx/w44w6yc6BOX52aOdBrwBSARzNG9KlFxz8OjoZF86shJ2pKuFbdiUHfeM3ZY
x-ms-exchange-antispam-messagedata: KkjN2RTRnn5fW8zERwn9OY+59bB6qAZJYi61Je15W1WiivNBBXg4gWfsA/Y/idK1n46C8Lz3FHGKL8vBTIDUmq7mBRXBVz2oDzch6zPsmKehGqQRyD47zd+HggcmI+pzMH9vZJmeZIsGZUh90p+nbg==
Content-Type: text/plain; charset="utf-8"
Content-ID: <78A5491A5CEF7D4D87D4F70DA347075F@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29e4d806-0b8d-423a-24ca-08d7b5d8b269
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2020 07:44:20.5366
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6UeJ3gqUHhvGbEYSKlFjuSd/9z0sO4abtQiof7bUpFW81Gz/5A0alaZK+PBoarXcD6kWuqiPfEgq0AvOCwSTnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3901
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAuMDIuMjAyMCAwODoyNCwgUGVuZyBGYW4gd3JvdGU6DQo+IEZyb206IFBlbmcgRmFuIDxw
ZW5nLmZhbkBueHAuY29tPg0KPg0KPiBJTVhfU0NVX1NPQyBjb3VsZCBiZSBlbmFibGVkIHdpdGgg
Q09NUElMRV9URVNULCBob3dldmVyIHRoZXJlIGlzDQo+IG5vIGR1bW15IGZ1bmN0aW9ucyB3aGVu
IENPTkZJR19JTVhfU0NVIG5vdCBkZWZpbmVkLiBUaGVuIHRoZXJlDQo+IHdpbGwgYmUgYnVpbGQg
ZmFpbHVyZS4NCj4NCj4gU28gYWRkIGR1bW15IGZ1bmN0aW9ucyB0byBhdm9pZCBidWlsZCBmYWls
dXJlIGZvciBDT01QSUxFX1RFU1QNCj4NCj4gU2lnbmVkLW9mZi1ieTogUGVuZyBGYW4gPHBlbmcu
ZmFuQG54cC5jb20+DQo+IC0tLQ0KPiAgIGluY2x1ZGUvbGludXgvZmlybXdhcmUvaW14L2lwYy5o
ICAgICAgfCAxMyArKysrKysrKysrKysrDQo+ICAgaW5jbHVkZS9saW51eC9maXJtd2FyZS9pbXgv
c2NpLmggICAgICB8IDIyICsrKysrKysrKysrKysrKysrKysrKysNCj4gICBpbmNsdWRlL2xpbnV4
L2Zpcm13YXJlL2lteC9zdmMvbWlzYy5oIHwgMTkgKysrKysrKysrKysrKysrKysrKw0KPiAgIDMg
ZmlsZXMgY2hhbmdlZCwgNTQgaW5zZXJ0aW9ucygrKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVk
ZS9saW51eC9maXJtd2FyZS9pbXgvaXBjLmggYi9pbmNsdWRlL2xpbnV4L2Zpcm13YXJlL2lteC9p
cGMuaA0KPiBpbmRleCA2MzEyYzhjYjA4NGEuLjMwNDc1MDgyZjQ3MiAxMDA2NDQNCj4gLS0tIGEv
aW5jbHVkZS9saW51eC9maXJtd2FyZS9pbXgvaXBjLmgNCj4gKysrIGIvaW5jbHVkZS9saW51eC9m
aXJtd2FyZS9pbXgvaXBjLmgNCj4gQEAgLTM1LDYgKzM1LDcgQEAgc3RydWN0IGlteF9zY19ycGNf
bXNnIHsNCj4gICAJdWludDhfdCBmdW5jOw0KPiAgIH07DQo+ICAgDQo+ICsjaWZkZWYgQ09ORklH
X0lNWF9TQ1UNCj4gICAvKg0KPiAgICAqIFRoaXMgaXMgYW4gZnVuY3Rpb24gdG8gc2VuZCBhbiBS
UEMgbWVzc2FnZSBvdmVyIGFuIElQQyBjaGFubmVsLg0KPiAgICAqIEl0IGlzIGNhbGxlZCBieSBj
bGllbnQtc2lkZSBTQ0ZXIEFQSSBmdW5jdGlvbiBzaGltcy4NCj4gQEAgLTU2LDQgKzU3LDE2IEBA
IGludCBpbXhfc2N1X2NhbGxfcnBjKHN0cnVjdCBpbXhfc2NfaXBjICppcGMsIHZvaWQgKm1zZywg
Ym9vbCBoYXZlX3Jlc3ApOw0KPiAgICAqIEByZXR1cm4gUmV0dXJucyBhbiBlcnJvciBjb2RlICgw
ID0gc3VjY2VzcywgZmFpbGVkIGlmIDwgMCkNCj4gICAgKi8NCj4gICBpbnQgaW14X3NjdV9nZXRf
aGFuZGxlKHN0cnVjdCBpbXhfc2NfaXBjICoqaXBjKTsNCj4gKyNlbHNlDQo+ICtzdGF0aWMgaW5s
aW5lIGludCBpbXhfc2N1X2NhbGxfcnBjKHN0cnVjdCBpbXhfc2NfaXBjICppcGMsIHZvaWQgKm1z
ZywNCj4gKwkJCQkgICBib29sIGhhdmVfcmVzcCkNCj4gK3sNCj4gKwlyZXR1cm4gLUVOT1RTVVBQ
Ow0KPiArfQ0KPiArDQo+ICtzdGF0aWMgaW5saW5lIGludCBpbXhfc2N1X2dldF9oYW5kbGUoc3Ry
dWN0IGlteF9zY19pcGMgKippcGMpDQo+ICt7DQo+ICsJcmV0dXJuIC1FTk9UU1VQUDsNCj4gK30N
Cj4gKyNlbmRpZg0KPiAgICNlbmRpZiAvKiBfU0NfSVBDX0ggKi8NCj4gZGlmZiAtLWdpdCBhL2lu
Y2x1ZGUvbGludXgvZmlybXdhcmUvaW14L3NjaS5oIGIvaW5jbHVkZS9saW51eC9maXJtd2FyZS9p
bXgvc2NpLmgNCj4gaW5kZXggMTdiYTRlNDA1MTI5Li43ZWE4NzViMTg2ZTMgMTAwNjQ0DQo+IC0t
LSBhL2luY2x1ZGUvbGludXgvZmlybXdhcmUvaW14L3NjaS5oDQo+ICsrKyBiL2luY2x1ZGUvbGlu
dXgvZmlybXdhcmUvaW14L3NjaS5oDQo+IEBAIC0xNiw4ICsxNiwzMCBAQA0KPiAgICNpbmNsdWRl
IDxsaW51eC9maXJtd2FyZS9pbXgvc3ZjL21pc2MuaD4NCj4gICAjaW5jbHVkZSA8bGludXgvZmly
bXdhcmUvaW14L3N2Yy9wbS5oPg0KPiAgIA0KPiArI2lmZGVmIENPTkZJR19JTVhfU0NVDQo+ICAg
aW50IGlteF9zY3VfZW5hYmxlX2dlbmVyYWxfaXJxX2NoYW5uZWwoc3RydWN0IGRldmljZSAqZGV2
KTsNCj4gICBpbnQgaW14X3NjdV9pcnFfcmVnaXN0ZXJfbm90aWZpZXIoc3RydWN0IG5vdGlmaWVy
X2Jsb2NrICpuYik7DQo+ICAgaW50IGlteF9zY3VfaXJxX3VucmVnaXN0ZXJfbm90aWZpZXIoc3Ry
dWN0IG5vdGlmaWVyX2Jsb2NrICpuYik7DQo+ICAgaW50IGlteF9zY3VfaXJxX2dyb3VwX2VuYWJs
ZSh1OCBncm91cCwgdTMyIG1hc2ssIHU4IGVuYWJsZSk7DQo+ICsjZWxzZQ0KPiArc3RhdGljIGlu
bGluZSBpbnQgaW14X3NjdV9lbmFibGVfZ2VuZXJhbF9pcnFfY2hhbm5lbChzdHJ1Y3QgZGV2aWNl
ICpkZXYpDQo+ICt7DQo+ICsJcmV0dXJuIC1FTk9UU1VQUDsNCj4gK30NCj4gKw0KPiArc3RhdGlj
IGlubGluZSBpbnQgaW14X3NjdV9pcnFfcmVnaXN0ZXJfbm90aWZpZXIoc3RydWN0IG5vdGlmaWVy
X2Jsb2NrICpuYikNCj4gK3sNCj4gKwlyZXR1cm4gLUVOT1RTVVBQOw0KPiArfQ0KPiArDQo+ICtz
dGF0aWMgaW5saW5lIGludCBpbXhfc2N1X2lycV91bnJlZ2lzdGVyX25vdGlmaWVyKHN0cnVjdCBu
b3RpZmllcl9ibG9jayAqbmIpDQo+ICt7DQo+ICsJcmV0dXJuIC1FTk9UU1VQUDsNCj4gK30NCj4g
Kw0KPiArc3RhdGljIGlubGluZSBpbnQgaW14X3NjdV9pcnFfZ3JvdXBfZW5hYmxlKHU4IGdyb3Vw
LCB1MzIgbWFzaywgdTggZW5hYmxlKQ0KPiArew0KPiArCXJldHVybiAtRU5PVFNVUFA7DQo+ICt9
DQo+ICsjZW5kaWYNCj4gICAjZW5kaWYgLyogX1NDX1NDSV9IICovDQo+IGRpZmYgLS1naXQgYS9p
bmNsdWRlL2xpbnV4L2Zpcm13YXJlL2lteC9zdmMvbWlzYy5oIGIvaW5jbHVkZS9saW51eC9maXJt
d2FyZS9pbXgvc3ZjL21pc2MuaA0KPiBpbmRleCAwMzFkZDRkM2M3NjYuLjNmNGEwZjUyNmI3MyAx
MDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9saW51eC9maXJtd2FyZS9pbXgvc3ZjL21pc2MuaA0KPiAr
KysgYi9pbmNsdWRlL2xpbnV4L2Zpcm13YXJlL2lteC9zdmMvbWlzYy5oDQo+IEBAIC00Niw2ICs0
Niw3IEBAIGVudW0gaW14X21pc2NfZnVuYyB7DQo+ICAgICogQ29udHJvbCBGdW5jdGlvbnMNCj4g
ICAgKi8NCj4gICANCj4gKyNpZmRlZiBDT05GSUdfSU1YX1NDVQ0KPiAgIGludCBpbXhfc2NfbWlz
Y19zZXRfY29udHJvbChzdHJ1Y3QgaW14X3NjX2lwYyAqaXBjLCB1MzIgcmVzb3VyY2UsDQo+ICAg
CQkJICAgIHU4IGN0cmwsIHUzMiB2YWwpOw0KPiAgIA0KPiBAQCAtNTQsNSArNTUsMjMgQEAgaW50
IGlteF9zY19taXNjX2dldF9jb250cm9sKHN0cnVjdCBpbXhfc2NfaXBjICppcGMsIHUzMiByZXNv
dXJjZSwNCj4gICANCj4gICBpbnQgaW14X3NjX3BtX2NwdV9zdGFydChzdHJ1Y3QgaW14X3NjX2lw
YyAqaXBjLCB1MzIgcmVzb3VyY2UsDQo+ICAgCQkJYm9vbCBlbmFibGUsIHU2NCBwaHlzX2FkZHIp
Ow0KPiArI2Vsc2UNCkZ1bmN0aW9ucyBmb3IgZHVtbXkgY2FzZSBiZWxvdyBzaG91bGQgYmUgc3Rh
dGljIGlubGluZS4NCj4gK2ludCBpbXhfc2NfbWlzY19zZXRfY29udHJvbChzdHJ1Y3QgaW14X3Nj
X2lwYyAqaXBjLCB1MzIgcmVzb3VyY2UsDQo+ICsJCQkgICAgdTggY3RybCwgdTMyIHZhbCkNCj4g
K3sNCj4gKwlyZXR1cm4gLUVOT1RTVVBQOw0KPiArfQ0KPiArDQo+ICtpbnQgaW14X3NjX21pc2Nf
Z2V0X2NvbnRyb2woc3RydWN0IGlteF9zY19pcGMgKmlwYywgdTMyIHJlc291cmNlLA0KPiArCQkJ
ICAgIHU4IGN0cmwsIHUzMiAqdmFsKQ0KPiArew0KPiArCXJldHVybiAtRU5PVFNVUFA7DQo+ICt9
DQo+ICAgDQo+ICtpbnQgaW14X3NjX3BtX2NwdV9zdGFydChzdHJ1Y3QgaW14X3NjX2lwYyAqaXBj
LCB1MzIgcmVzb3VyY2UsDQo+ICsJCQlib29sIGVuYWJsZSwgdTY0IHBoeXNfYWRkcikNCj4gK3sN
Cj4gKwlyZXR1cm4gLUVOT1RTVVBQOw0KPiArfQ0KPiArI2VuZGlmDQo+ICAgI2VuZGlmIC8qIF9T
Q19NSVNDX0FQSV9IICovDQoNCg0K
