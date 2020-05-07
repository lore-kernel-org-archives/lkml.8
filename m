Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A96DBC47247
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 06:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FA18207DD
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 06:20:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="IKgtKafH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbgEGGUN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 02:20:13 -0400
Received: from mail-eopbgr80075.outbound.protection.outlook.com ([40.107.8.75]:23267
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725783AbgEGGUM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 02:20:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fYgX9OvOJw7NBXWLfjGKxRmB92XgrA+tf0oWrq++GqXtICs5ZA3udHglIdMbi+s87HvjdC9tRj3b+vKnWSnndgREGhzAeazCPAKFxXr6ZVtZcO4fSGyO9jQE2YFNEoheySKctR63WQwOXC3lNeqJbCTcn7jTmrZoHa6iwLls1fV41KMCRYkp17chwtZoUGTXVHr5SldmBW+2euASxSIx8OocHKFW+oFVQlNBoIG6q9tHLjzEZ1dleduavR5wfaex8l6M5u/oDdDXS5qIK11/25bC3Sk363WZXb/7hJ4F5S9iNPvz37094YCX9kQIwPCiVPwSiBqp6b4APMSZPF3W8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fi4eBepY/2dWbrA1ZcauJYUaPpsJczk2y3gPqHx80oU=;
 b=SFVgmw/PNNuRdTxW+t6PI/Hva3tVDfDAx7eOS+EIlR2gUSjOAlDPmdnrdgowa5UoyZoLqWqbFdjWxXfe4ZpymsiU/jT3a28y3/a193BlkVH7bIVKQbxDvF0KTOQvJjb2jOgPZ5i+DLbRxu9WyGAcyete4S4vwXhf0srGRW0BQM/sImnPWph6iw1tiMtBad6vO1CtyGnbMhUH0x0yBgXnd92HwHST/CNQ8WEwqrVUfpp3YieGVcMHf6C2VVEvNoPBiw8Dm1ErLyCqaAC6tBngOXRlfmPNfMSCXjQmmudAZnVsy7RoXTbxmPvCGMGdFl/621vy9tnFXOAocsco+nmpmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fi4eBepY/2dWbrA1ZcauJYUaPpsJczk2y3gPqHx80oU=;
 b=IKgtKafHGaiQpjo30bOYGhBdOGt8FYxPUXler8L9mbAMg+lBRxse2QVjeaMJFJbvjl+6vFhd/2HURD+HJBTiTlAlNZeJRWtcGlMY/fPp9bY+K9nkmPiCurqacCxSloeGX9xRP1oRphyjlQ/mQg0s6E57D3AGJ2fQShZtBuxVhT4=
Received: from DBBPR04MB6090.eurprd04.prod.outlook.com (2603:10a6:10:c4::22)
 by DBBPR04MB6170.eurprd04.prod.outlook.com (2603:10a6:10:c9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.27; Thu, 7 May
 2020 06:20:07 +0000
Received: from DBBPR04MB6090.eurprd04.prod.outlook.com
 ([fe80::107d:2130:2140:23ec]) by DBBPR04MB6090.eurprd04.prod.outlook.com
 ([fe80::107d:2130:2140:23ec%5]) with mapi id 15.20.2958.033; Thu, 7 May 2020
 06:20:06 +0000
From:   Andy Tang <andy.tang@nxp.com>
To:     Andy Tang <andy.tang@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] arm64: dts: lx2160a: add more thermal zone support
Thread-Topic: [PATCH] arm64: dts: lx2160a: add more thermal zone support
Thread-Index: AQHWFIH87yVcQzFaz0SXXvTKu8Zwl6icRgTg
Date:   Thu, 7 May 2020 06:20:06 +0000
Message-ID: <DBBPR04MB60901517CCEF34DBD9D3109EF3A50@DBBPR04MB6090.eurprd04.prod.outlook.com>
References: <20200417061618.48032-1-andy.tang@nxp.com>
In-Reply-To: <20200417061618.48032-1-andy.tang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9a03d2df-7e9c-43d0-4609-08d7f24eaff9
x-ms-traffictypediagnostic: DBBPR04MB6170:|DBBPR04MB6170:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DBBPR04MB61700923C2187A23BC4E66BDF3A50@DBBPR04MB6170.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-forefront-prvs: 03965EFC76
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4Lk3/EpyvbiUzH7IJOPddyOM0IY5z63J3AOKDied4oT37xDYNU4AqyeK46DHO+3ztL2suhEQYUx6beWMxaO3aoG7jB4VBs2mpc3RtbcWIQXlWh3S2vyRUP1YBYkV3CMnRv0o7WRhBJlDQonnENKFjSg3snOMGhMENJQwb4u00YyqALdq+fT4AV0XExYiRDQbHioH78tCH9+Mg55QczqtbYGLOdLigIg3ZhOJbZh3huRjel8oPvTsCzF6mi/QIWZya4wVSG+RJyRUCfwUA+Kn1ZMc1Oy4rdmxlZRgP8JMvNRUPb0HnuFDuONYOB4HxTDCqxJbRXGEzS+Yv8E/e1URKvF0qA900u+WDe97q92xptMxrZKw7FXpJBQ5yTXWmHMude95p4fE/d9VTO0gnIMXhQK/Szvm8BHnNjleyDW0ltqb/Bhub4NPMYvpw8yQS0vvFk6j0CbCliWk06rPs4BEThtYOxQxzNUwfTdi11QZfJROhtzb0FuJGFZtT1ICL3kkJNIOARAEaZAhUmwRh5+SAw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB6090.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(396003)(346002)(376002)(366004)(136003)(33430700001)(9686003)(33656002)(52536014)(66556008)(53546011)(6506007)(26005)(64756008)(7696005)(186003)(4326008)(66946007)(66446008)(2906002)(66476007)(8676002)(55016002)(76116006)(5660300002)(44832011)(478600001)(8936002)(33440700001)(54906003)(110136005)(71200400001)(86362001)(316002)(83280400001)(83320400001)(83300400001)(83290400001)(83310400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: bxKvk839/jTm8dmvlqDGw2hLPSlcYd70u6xnhpHhnJTMAMDYzDIdqTVOYN0v1bmDg6aMrm0s5omekGFiCG9WPFeOquGrdX0Lzi1iuMtHlyp5r73tDvmvAOu3d8Mxjboc1ME42HReB+AFCq9lRGOD9tu7kOfrUSk4PANnw1PrYuY2LIxo4FwI1I+nyMl9m2r6A21LX8pzjiawDDha6aEAoaOG5NGCWyVufi+52NXJ/XP47lJDrccAc1caCG5g4phRmAGHeYt2PiZf0qZogRxzEaRqSLnknnE/J3nNUqr0oVlQeknJYgaadj+cwJJJT1XcTBBrV7nBFwjxcy8fSgNBDQDHoinjlNkLE6wnhdGdjP6Rw1TvaJI1y2PKKjru/8p6f9Wso60j5ypMDJcP+zy7w88/WiT/++1iO8K8IxYSJg8v1cg4ZLjWuJ4CePyDZ709oE1ig779LuACjXDF9nZZjF1TE+rz9tHMU9EZpZx49qfQuDN0tlu6QMBn+/+qGzg+x4cSwAIWCp0sxkkOFBr1w7fpi7caT1isfxeTeh8qd3aaoNyu1a8hd0EgK5dyQm9Kk1FppCP84WZEq5sWEQeXdMlY0B12QonOMP8mp/cBIvTbo4WJ/xX4tMuScdGjOegs9vcvT63adcHxkrtaPjCS7n8LR/VzujLNJnPXLBm/jmrHItIvEUHJuMlN42UvAy3YJ/diZn5bg7L4yj4p1X+4BJLx9GI51CZ6ZeucytbIz/1punGRi8wLgcy0Qt6gngadRxwHzujKzc7nJU0Qub0HiehX5P9MBqUUgsavKgutitc=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a03d2df-7e9c-43d0-4609-08d7f24eaff9
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2020 06:20:06.9125
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HZpNqvFDOIa+GLrzN9s2dRTsRKBk2COtAoflVbgNrgC4F+GsxjZHW+cM9QpiVz33ojp7MGJ7X8K00kKD0wi40w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB6170
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UElORy4NCg0KQlIsDQpBbmR5DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJv
bTogWXVhbnRpYW4gVGFuZyA8YW5keS50YW5nQG54cC5jb20+DQo+IFNlbnQ6IDIwMjDE6jTUwjE3
yNUgMTQ6MTYNCj4gVG86IHNoYXduZ3VvQGtlcm5lbC5vcmc7IHJvYmgrZHRAa2VybmVsLm9yZzsg
bWFyay5ydXRsYW5kQGFybS5jb207DQo+IGNhdGFsaW4ubWFyaW5hc0Bhcm0uY29tOyB3aWxsLmRl
YWNvbkBhcm0uY29tDQo+IENjOiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJt
LWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnOyBBbmR5IFRhbmcgPGFuZHkudGFuZ0BueHAuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0hdIGFy
bTY0OiBkdHM6IGx4MjE2MGE6IGFkZCBtb3JlIHRoZXJtYWwgem9uZSBzdXBwb3J0DQo+IA0KPiBU
aGVyZSBhcmUgNyB0aGVybWFsIHpvbmVzIGluIGx4MjE2MGEgc29jLiBBZGQgdGhlIHJlc3QgdGhl
cm1hbCB6b25lIG5vZGUgdG8NCj4gZW5hYmxlIHRoZW0uDQo+IEFsc28gY29ycmVjdCBvbmUgb2Yg
dGhlIHZhbHVlcyBmb3IgdG11LWNhbGlicmF0aW9uIHByb3BlcnR5Lg0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogWXVhbnRpYW4gVGFuZyA8YW5keS50YW5nQG54cC5jb20+DQo+IC0tLQ0KPiAgLi4uL2Fy
bTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHgyMTYwYS5kdHNpIHwgMTMwICsrKysrKysrKysr
KysrKysrLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEyNSBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9u
cygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2Zz
bC1seDIxNjBhLmR0c2kNCj4gYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHgy
MTYwYS5kdHNpDQo+IGluZGV4IGFlMWIxMTNhYjE2Mi4uYWJhZWI1ODdkZTQ4IDEwMDY0NA0KPiAt
LS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHgyMTYwYS5kdHNpDQo+ICsr
KyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1seDIxNjBhLmR0c2kNCj4gQEAg
LTQzNiwxOSArNDM2LDE5IEBADQo+ICAJfTsNCj4gDQo+ICAJdGhlcm1hbC16b25lcyB7DQo+IC0J
CWNvcmVfdGhlcm1hbDE6IGNvcmUtdGhlcm1hbDEgew0KPiArCQljbHVzdGVyNi03IHsNCj4gIAkJ
CXBvbGxpbmctZGVsYXktcGFzc2l2ZSA9IDwxMDAwPjsNCj4gIAkJCXBvbGxpbmctZGVsYXkgPSA8
NTAwMD47DQo+ICAJCQl0aGVybWFsLXNlbnNvcnMgPSA8JnRtdSAwPjsNCj4gDQo+ICAJCQl0cmlw
cyB7DQo+IC0JCQkJY29yZV9jbHVzdGVyX2FsZXJ0OiBjb3JlLWNsdXN0ZXItYWxlcnQgew0KPiAr
CQkJCWNsdXN0ZXI2XzdfYWxlcnQ6IGNsdXN0ZXI2LTctYWxlcnQgew0KPiAgCQkJCQl0ZW1wZXJh
dHVyZSA9IDw4NTAwMD47DQo+ICAJCQkJCWh5c3RlcmVzaXMgPSA8MjAwMD47DQo+ICAJCQkJCXR5
cGUgPSAicGFzc2l2ZSI7DQo+ICAJCQkJfTsNCj4gDQo+IC0JCQkJY29yZV9jbHVzdGVyX2NyaXQ6
IGNvcmUtY2x1c3Rlci1jcml0IHsNCj4gKwkJCQljbHVzdGVyNl83X2NyaXQ6IGNsdXN0ZXI2LTct
Y3JpdCB7DQo+ICAJCQkJCXRlbXBlcmF0dXJlID0gPDk1MDAwPjsNCj4gIAkJCQkJaHlzdGVyZXNp
cyA9IDwyMDAwPjsNCj4gIAkJCQkJdHlwZSA9ICJjcml0aWNhbCI7DQo+IEBAIC00NTcsNyArNDU3
LDcgQEANCj4gDQo+ICAJCQljb29saW5nLW1hcHMgew0KPiAgCQkJCW1hcDAgew0KPiAtCQkJCQl0
cmlwID0gPCZjb3JlX2NsdXN0ZXJfYWxlcnQ+Ow0KPiArCQkJCQl0cmlwID0gPCZjbHVzdGVyNl83
X2FsZXJ0PjsNCj4gIAkJCQkJY29vbGluZy1kZXZpY2UgPQ0KPiAgCQkJCQkJPCZjcHUwIFRIRVJN
QUxfTk9fTElNSVQNCj4gVEhFUk1BTF9OT19MSU1JVD4sDQo+ICAJCQkJCQk8JmNwdTEgVEhFUk1B
TF9OT19MSU1JVA0KPiBUSEVSTUFMX05PX0xJTUlUPiwgQEAgLTQ3OCw2ICs0NzgsMTI2IEBADQo+
ICAJCQkJfTsNCj4gIAkJCX07DQo+ICAJCX07DQo+ICsNCj4gKwkJZGRyLWNsdXN0ZXI1IHsNCj4g
KwkJCXBvbGxpbmctZGVsYXktcGFzc2l2ZSA9IDwxMDAwPjsNCj4gKwkJCXBvbGxpbmctZGVsYXkg
PSA8NTAwMD47DQo+ICsJCQl0aGVybWFsLXNlbnNvcnMgPSA8JnRtdSAxPjsNCj4gKw0KPiArCQkJ
dHJpcHMgew0KPiArCQkJCWRkci1jbHVzdGVyNS1hbGVydCB7DQo+ICsJCQkJCXRlbXBlcmF0dXJl
ID0gPDg1MDAwPjsNCj4gKwkJCQkJaHlzdGVyZXNpcyA9IDwyMDAwPjsNCj4gKwkJCQkJdHlwZSA9
ICJwYXNzaXZlIjsNCj4gKwkJCQl9Ow0KPiArDQo+ICsJCQkJZGRyLWNsdXN0ZXI1LWNyaXQgew0K
PiArCQkJCQl0ZW1wZXJhdHVyZSA9IDw5NTAwMD47DQo+ICsJCQkJCWh5c3RlcmVzaXMgPSA8MjAw
MD47DQo+ICsJCQkJCXR5cGUgPSAiY3JpdGljYWwiOw0KPiArCQkJCX07DQo+ICsJCQl9Ow0KPiAr
CQl9Ow0KPiArDQo+ICsJCXdyaW9wIHsNCj4gKwkJCXBvbGxpbmctZGVsYXktcGFzc2l2ZSA9IDwx
MDAwPjsNCj4gKwkJCXBvbGxpbmctZGVsYXkgPSA8NTAwMD47DQo+ICsJCQl0aGVybWFsLXNlbnNv
cnMgPSA8JnRtdSAyPjsNCj4gKw0KPiArCQkJdHJpcHMgew0KPiArCQkJCXdyaW9wLWFsZXJ0IHsN
Cj4gKwkJCQkJdGVtcGVyYXR1cmUgPSA8ODUwMDA+Ow0KPiArCQkJCQloeXN0ZXJlc2lzID0gPDIw
MDA+Ow0KPiArCQkJCQl0eXBlID0gInBhc3NpdmUiOw0KPiArCQkJCX07DQo+ICsNCj4gKwkJCQl3
cmlvcC1jcml0IHsNCj4gKwkJCQkJdGVtcGVyYXR1cmUgPSA8OTUwMDA+Ow0KPiArCQkJCQloeXN0
ZXJlc2lzID0gPDIwMDA+Ow0KPiArCQkJCQl0eXBlID0gImNyaXRpY2FsIjsNCj4gKwkJCQl9Ow0K
PiArCQkJfTsNCj4gKwkJfTsNCj4gKw0KPiArCQlkY2UtcWJtYW4taHNpbzIgew0KPiArCQkJcG9s
bGluZy1kZWxheS1wYXNzaXZlID0gPDEwMDA+Ow0KPiArCQkJcG9sbGluZy1kZWxheSA9IDw1MDAw
PjsNCj4gKwkJCXRoZXJtYWwtc2Vuc29ycyA9IDwmdG11IDM+Ow0KPiArDQo+ICsJCQl0cmlwcyB7
DQo+ICsJCQkJZGNlLXFibWFuLWFsZXJ0IHsNCj4gKwkJCQkJdGVtcGVyYXR1cmUgPSA8ODUwMDA+
Ow0KPiArCQkJCQloeXN0ZXJlc2lzID0gPDIwMDA+Ow0KPiArCQkJCQl0eXBlID0gInBhc3NpdmUi
Ow0KPiArCQkJCX07DQo+ICsNCj4gKwkJCQlkY2UtcWJtYW4tY3JpdCB7DQo+ICsJCQkJCXRlbXBl
cmF0dXJlID0gPDk1MDAwPjsNCj4gKwkJCQkJaHlzdGVyZXNpcyA9IDwyMDAwPjsNCj4gKwkJCQkJ
dHlwZSA9ICJjcml0aWNhbCI7DQo+ICsJCQkJfTsNCj4gKwkJCX07DQo+ICsJCX07DQo+ICsNCj4g
KwkJY2NuLWRwYWEtdGJ1IHsNCj4gKwkJCXBvbGxpbmctZGVsYXktcGFzc2l2ZSA9IDwxMDAwPjsN
Cj4gKwkJCXBvbGxpbmctZGVsYXkgPSA8NTAwMD47DQo+ICsJCQl0aGVybWFsLXNlbnNvcnMgPSA8
JnRtdSA0PjsNCj4gKw0KPiArCQkJdHJpcHMgew0KPiArCQkJCWNjbi1kcGFhLWFsZXJ0IHsNCj4g
KwkJCQkJdGVtcGVyYXR1cmUgPSA8ODUwMDA+Ow0KPiArCQkJCQloeXN0ZXJlc2lzID0gPDIwMDA+
Ow0KPiArCQkJCQl0eXBlID0gInBhc3NpdmUiOw0KPiArCQkJCX07DQo+ICsNCj4gKwkJCQljY24t
ZHBhYS1jcml0IHsNCj4gKwkJCQkJdGVtcGVyYXR1cmUgPSA8OTUwMDA+Ow0KPiArCQkJCQloeXN0
ZXJlc2lzID0gPDIwMDA+Ow0KPiArCQkJCQl0eXBlID0gImNyaXRpY2FsIjsNCj4gKwkJCQl9Ow0K
PiArCQkJfTsNCj4gKwkJfTsNCj4gKw0KPiArCQljbHVzdGVyNC1oc2lvMyB7DQo+ICsJCQlwb2xs
aW5nLWRlbGF5LXBhc3NpdmUgPSA8MTAwMD47DQo+ICsJCQlwb2xsaW5nLWRlbGF5ID0gPDUwMDA+
Ow0KPiArCQkJdGhlcm1hbC1zZW5zb3JzID0gPCZ0bXUgNT47DQo+ICsNCj4gKwkJCXRyaXBzIHsN
Cj4gKwkJCQljbHVzdDQtaHNpbzMtYWxlcnQgew0KPiArCQkJCQl0ZW1wZXJhdHVyZSA9IDw4NTAw
MD47DQo+ICsJCQkJCWh5c3RlcmVzaXMgPSA8MjAwMD47DQo+ICsJCQkJCXR5cGUgPSAicGFzc2l2
ZSI7DQo+ICsJCQkJfTsNCj4gKw0KPiArCQkJCWNsdXN0NC1oc2lvMy1jcml0IHsNCj4gKwkJCQkJ
dGVtcGVyYXR1cmUgPSA8OTUwMDA+Ow0KPiArCQkJCQloeXN0ZXJlc2lzID0gPDIwMDA+Ow0KPiAr
CQkJCQl0eXBlID0gImNyaXRpY2FsIjsNCj4gKwkJCQl9Ow0KPiArCQkJfTsNCj4gKwkJfTsNCj4g
Kw0KPiArCQljbHVzdGVyMi0zIHsNCj4gKwkJCXBvbGxpbmctZGVsYXktcGFzc2l2ZSA9IDwxMDAw
PjsNCj4gKwkJCXBvbGxpbmctZGVsYXkgPSA8NTAwMD47DQo+ICsJCQl0aGVybWFsLXNlbnNvcnMg
PSA8JnRtdSA2PjsNCj4gKw0KPiArCQkJdHJpcHMgew0KPiArCQkJCWNsdXN0ZXIyLTMtYWxlcnQg
ew0KPiArCQkJCQl0ZW1wZXJhdHVyZSA9IDw4NTAwMD47DQo+ICsJCQkJCWh5c3RlcmVzaXMgPSA8
MjAwMD47DQo+ICsJCQkJCXR5cGUgPSAicGFzc2l2ZSI7DQo+ICsJCQkJfTsNCj4gKw0KPiArCQkJ
CWNsdXN0ZXIyLTMtY3JpdCB7DQo+ICsJCQkJCXRlbXBlcmF0dXJlID0gPDk1MDAwPjsNCj4gKwkJ
CQkJaHlzdGVyZXNpcyA9IDwyMDAwPjsNCj4gKwkJCQkJdHlwZSA9ICJjcml0aWNhbCI7DQo+ICsJ
CQkJfTsNCj4gKwkJCX07DQo+ICsJCX07DQo+ICAJfTsNCj4gDQo+ICAJc29jIHsNCj4gQEAgLTU0
OSw3ICs2NjksNyBAQA0KPiAgCQkJCS8qIENhbGlicmF0aW9uIGRhdGEgZ3JvdXAgMSAqLw0KPiAg
CQkJCTwweDAwMDAwMDAwIDB4MDAwMDAwMzUNCj4gIAkJCQkvKiBDYWxpYnJhdGlvbiBkYXRhIGdy
b3VwIDIgKi8NCj4gLQkJCQkweDAwMDEwMDAxIDB4MDAwMDAxNTQ+Ow0KPiArCQkJCTB4MDAwMDAw
MDEgMHgwMDAwMDE1ND47DQo+ICAJCQlsaXR0bGUtZW5kaWFuOw0KPiAgCQkJI3RoZXJtYWwtc2Vu
c29yLWNlbGxzID0gPDE+Ow0KPiAgCQl9Ow0KPiAtLQ0KPiAyLjE3LjENCg0K
