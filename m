Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6CE3C33CB6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 05:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D49A20842
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 05:45:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="g1tKwRlv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbgAQFpk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 00:45:40 -0500
Received: from mail-eopbgr60062.outbound.protection.outlook.com ([40.107.6.62]:63463
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725813AbgAQFpk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 00:45:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MT5zGZbuLPhJHIPKZrB4lk5/dOIBXlhj0J0pdO+guwKvKPbighZq5gVdfeYhtOZtbRgc2l7HBFQSHQb/p2c+jSuDIWDwPsp58ZaWFahc5GtzfnmRd502dUL99z0AJqXGIQ3z/YT5NQIiTgJoDf/KITKIorrW0KyJyqT6xXLc/7S1QlPc0tpwHxLLOX20+4VH/xq0AK68xsJeUdI++e/FfYQf86L06pANRxhN+3pyLUea5ro+1HgOjxXjI9JqM0vNuK89Bh9w0vpH/zM2QC3C1+0q9L/yv/f5op3KGsViE8ehjDorssX+xPELoCPQTbO3H66yQ38X6Bp8t8rlYqZyzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PYYrVZB2owAhkvx/mOJd55oxR8Oirq2c7ZhRm5ycDRU=;
 b=mLgUFKYC9/FNypl1qzOLJDIMi7keXl6VDRnMHfqPB/hk1xEqcCGzJJFoinrmbxOeluFgLOtu80qWTJq1jj7lu4iRyPGKPENzG8gCvaDTyHeGOC++9AYo4Gf1jOdacPvY8Pc+NVd+gPvomMKwgtgQwbCdIhV8eDJehKs/6eCWf6Rrc1LydOvPBU6l2Vk9VzHvgCsddAfIum47+ExAVcm3Yub4XUEBPFyS2sn6uQWJ+53DtAqY3RrH3+bOY2I0oHT1m4x2XxyvgKoc80VzXSNJox5od5MerODC/X5UD+YpEzpun2x4cvVzVoNof+En9GrCE0IQvcGYVAb8aG4KETjM7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PYYrVZB2owAhkvx/mOJd55oxR8Oirq2c7ZhRm5ycDRU=;
 b=g1tKwRlvsUDx1JupGOs5GA3PY3O8EmmdMDO5qBC/gsED80ErxTfExYsGYSh7+zqt+0b8KkN/buPu7luXx8l4QBGuxNuRBLwS4zLJ5B+ev11OO7QjwxnBEUdPyA7bZLGJmKgJp1yM4aXxjVVpjVZvhsD6+GJCG4JJpBrvLAGE++4=
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com (52.135.139.151) by
 DB7PR04MB5977.eurprd04.prod.outlook.com (20.178.104.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.23; Fri, 17 Jan 2020 05:45:34 +0000
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::5cb4:81c8:1618:5ca]) by DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::5cb4:81c8:1618:5ca%7]) with mapi id 15.20.2644.023; Fri, 17 Jan 2020
 05:45:34 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     Rob Herring <robh@kernel.org>
CC:     "maz@kernel.org" <maz@kernel.org>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>, Andy Duan <fugang.duan@nxp.com>
Subject: RE: [PATCH V5 1/2] dt-bindings/irq: add binding for NXP INTMUX
 interrupt multiplexer
Thread-Topic: [PATCH V5 1/2] dt-bindings/irq: add binding for NXP INTMUX
 interrupt multiplexer
Thread-Index: AQHVy2HlCqpoVSNPM0u45sIas5IfRaftr8UAgACn8XA=
Date:   Fri, 17 Jan 2020 05:45:34 +0000
Message-ID: <DB7PR04MB461896F81D346CC88505F2C1E6310@DB7PR04MB4618.eurprd04.prod.outlook.com>
References: <1579064664-16452-1-git-send-email-qiangqing.zhang@nxp.com>
 <1579064664-16452-2-git-send-email-qiangqing.zhang@nxp.com>
 <20200116192928.GA1014@bogus>
In-Reply-To: <20200116192928.GA1014@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=qiangqing.zhang@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 977a6aff-8f08-4067-ad20-08d79b1078f2
x-ms-traffictypediagnostic: DB7PR04MB5977:|DB7PR04MB5977:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR04MB597773FF6250900BAF968C96E6310@DB7PR04MB5977.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:826;
x-forefront-prvs: 0285201563
x-forefront-antispam-report: SFV:NSPM;SFS:(10001)(10009020)(4636009)(376002)(136003)(366004)(396003)(346002)(39860400002)(199004)(189003)(2906002)(6506007)(7696005)(53546011)(8676002)(7416002)(478600001)(4326008)(45080400002)(33656002)(66476007)(9686003)(66556008)(66946007)(55016002)(66446008)(64756008)(76116006)(5660300002)(52536014)(316002)(71200400001)(966005)(86362001)(186003)(6916009)(8936002)(26005)(81156014)(81166006)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB5977;H:DB7PR04MB4618.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FwwuNqtz10LabuwFjopuQ0idSmlcqseK2jlavUDGB2dLeEfw39z39qS1bKzFDdhut7jaA1+ac1qyBTvc6MUFCv3vxaplLsP3gjjDzCa25bGhLwkvJEmHpUhxlGFnw6M77jVpJqoNpHOPFJN/dYOanx8sJXUdfPG3iwXjk/DCrtzdQ3fcpwivf07EvE6Qh807xXVRBfi5S41ODKiYhuBTte6LITHM3g8U1Qr8GAJWpYq4sgQSHPSCDXkhv2He/IXlXHu41V/fwoHKmlA9542QVNm8Bg6y7omZljQt1tb+FiCs0lBk0I8JVrDZZ+uVkB1a9ojgZFJyKGfoYfYrMt7gTJTZtB+DZL0ZDu7P1kP2Uzzi0SKKFDua9bwdQNTi/KhNRpYCk3Mg2Q/Yc6QVJJDwqJB95XVS6IkFMHfP5uZDRVaLMcaQYU030Qn8FCzkg5oczq2KRuo9JN50BvGrmScZ7ldmnCydiPa6BXjpUek31Fj2HHR9+CVkztcOQOjer6o/MmdWX2o/acRExZe5G6EH4gSGA1f5WEfXaGYI4iVb2cFBFvdn2UHKU1xUQrZeRIcj9JFqh4SF///coJb3JoecDQ==
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 977a6aff-8f08-4067-ad20-08d79b1078f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2020 05:45:34.6227
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AcjBoS/cbfvV4ItbqNjYejQcvhoMTYUPPRbmPdSt91mEWd8MBKVAiEg6ZclOdc1QC7m2TDSl+9b+vAhzzG8uSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5977
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFJvYiBIZXJyaW5nIDxyb2Jo
QGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjDE6jHUwjE3yNUgMzoyOQ0KPiBUbzogSm9ha2ltIFpo
YW5nIDxxaWFuZ3FpbmcuemhhbmdAbnhwLmNvbT4NCj4gQ2M6IG1hekBrZXJuZWwub3JnOyBqYXNv
bkBsYWtlZGFlbW9uLm5ldDsgdGdseEBsaW51dHJvbml4LmRlOw0KPiByb2JoK2R0QGtlcm5lbC5v
cmc7IG1hcmsucnV0bGFuZEBhcm0uY29tOyBzaGF3bmd1b0BrZXJuZWwub3JnOw0KPiBzLmhhdWVy
QHBlbmd1dHJvbml4LmRlOyBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7IGZlc3RldmFtQGdtYWlsLmNv
bTsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5l
bC5vcmc7DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgZGwtbGludXgt
aW14IDxsaW51eC1pbXhAbnhwLmNvbT47IEFuZHkNCj4gRHVhbiA8ZnVnYW5nLmR1YW5AbnhwLmNv
bT47IEpvYWtpbSBaaGFuZyA8cWlhbmdxaW5nLnpoYW5nQG54cC5jb20+DQo+IFN1YmplY3Q6IFJl
OiBbUEFUQ0ggVjUgMS8yXSBkdC1iaW5kaW5ncy9pcnE6IGFkZCBiaW5kaW5nIGZvciBOWFAgSU5U
TVVYDQo+IGludGVycnVwdCBtdWx0aXBsZXhlcg0KPiANCj4gT24gV2VkLCAxNSBKYW4gMjAyMCAx
MzowNDoyMyArMDgwMCwgSm9ha2ltIFpoYW5nIHdyb3RlOg0KPiA+IFRoaXMgcGF0Y2ggYWRkcyB0
aGUgRFQgYmluZGluZ3MgZm9yIHRoZSBOWFAgSU5UTVVYIGludGVycnVwdA0KPiA+IG11bHRpcGxl
eGVyIGZvciBpLk1YOCBmYW1pbHkgU29Dcy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEpvYWtp
bSBaaGFuZyA8cWlhbmdxaW5nLnpoYW5nQG54cC5jb20+DQo+ID4gLS0tDQo+ID4gIC4uLi9pbnRl
cnJ1cHQtY29udHJvbGxlci9mc2wsaW50bXV4LnlhbWwgICAgICB8IDY3ICsrKysrKysrKysrKysr
KysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDY3IGluc2VydGlvbnMoKykNCj4gPiAgY3JlYXRl
IG1vZGUgMTAwNjQ0DQo+ID4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2ludGVy
cnVwdC1jb250cm9sbGVyL2ZzbCxpbnRtdXgueWFtbA0KPiA+DQo+IA0KPiBNeSBib3QgZm91bmQg
ZXJyb3JzIHJ1bm5pbmcgJ21ha2UgZHRfYmluZGluZ19jaGVjaycgb24geW91ciBwYXRjaDoNCj4g
DQo+IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5L3NpbXBsZS1mcmFt
ZWJ1ZmZlci5leGFtcGxlLmR0czoyDQo+IDEuMTYtMzcuMTE6IFdhcm5pbmcgKGNob3Nlbl9ub2Rl
X2lzX3Jvb3QpOiAvZXhhbXBsZS0wL2Nob3NlbjogY2hvc2VuIG5vZGUNCj4gbXVzdCBiZSBhdCBy
b290IG5vZGUNCj4gRXJyb3I6DQo+IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9p
bnRlcnJ1cHQtY29udHJvbGxlci9mc2wsaW50bXV4LmV4YW1wbGUuZHQNCj4gczoyMC4yNy0yOCBz
eW50YXggZXJyb3IgRkFUQUwgRVJST1I6IFVuYWJsZSB0byBwYXJzZSBpbnB1dCB0cmVlDQo+IHNj
cmlwdHMvTWFrZWZpbGUubGliOjMwMDogcmVjaXBlIGZvciB0YXJnZXQNCj4gJ0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9pbnRlcnJ1cHQtY29udHJvbGxlci9mc2wsaW50bXV4LmV4
YW1wbGUuZA0KPiB0LnlhbWwnIGZhaWxlZA0KPiBtYWtlWzFdOiAqKioNCj4gW0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9pbnRlcnJ1cHQtY29udHJvbGxlci9mc2wsaW50bXV4LmV4
YW1wbGUuZA0KPiB0LnlhbWxdIEVycm9yIDENCj4gTWFrZWZpbGU6MTI2MzogcmVjaXBlIGZvciB0
YXJnZXQgJ2R0X2JpbmRpbmdfY2hlY2snIGZhaWxlZA0KPiBtYWtlOiAqKiogW2R0X2JpbmRpbmdf
Y2hlY2tdIEVycm9yIDINCj4gDQo+IFNlZQ0KPiBodHRwczovL2V1cjAxLnNhZmVsaW5rcy5wcm90
ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZwYXRjaHcNCj4gb3JrLm96bGFi
cy5vcmclMkZwYXRjaCUyRjEyMjMxNzImYW1wO2RhdGE9MDIlN0MwMSU3Q3FpYW5ncWluZy56aGFu
DQo+IGclNDBueHAuY29tJTdDYWFkZTQyZTI1NmYyNDhkYzJlZjcwOGQ3OWFiYTY5NDElN0M2ODZl
YTFkM2JjMmI0YzYNCj4gZmE5MmNkOTljNWMzMDE2MzUlN0MwJTdDMCU3QzYzNzE0Nzk5NzcyNjg4
ODI2NSZhbXA7c2RhdGE9N29wc1pPDQo+IFYlMkZLeklKQmw0TW9FRVNDWVphJTJCamx6S0tvZkc2
bTg0U3NmQUhnJTNEJmFtcDtyZXNlcnZlZD0wDQo+IFBsZWFzZSBjaGVjayBhbmQgcmUtc3VibWl0
Lg0KSGkgUm9iLA0KDQptYWtlIGR0X2JpbmRpbmdfY2hlY2sgRFRfU0NIRU1BX0ZJTEVTPURvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9pbnRlcnJ1cHQtY29udHJvbGxlci9mc2wsaW50
bXV4LnlhbWwNCiAgQ0hLRFQgICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaW50
ZXJydXB0LWNvbnRyb2xsZXIvZnNsLGludG11eC55YW1sDQogIFNDSEVNQSAgRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Byb2Nlc3NlZC1zY2hlbWEueWFtbA0KICBEVEMgICAgIERv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9pbnRlcnJ1cHQtY29udHJvbGxlci9mc2ws
aW50bXV4LmV4YW1wbGUuZHQueWFtbA0KICBDSEVDSyAgIERvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9pbnRlcnJ1cHQtY29udHJvbGxlci9mc2wsaW50bXV4LmV4YW1wbGUuZHQueWFt
bA0KDQpJIGRvbid0IGtub3cgRFRDIGFsc28gbmVlZCBwYXNzIHRoZSBjaGVjaywgc29ycnkgZm9y
IHRoYXQuIEkgd2lsbCByZS1zZW5kIHRoZSBwYXRjaCBzZXQuDQoNCkJlc3QgUmVnYXJkcywNCkpv
YWtpbSBaaGFuZw0K
