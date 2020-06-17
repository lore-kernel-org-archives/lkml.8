Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A65C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 12:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4956E2098B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 12:36:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="J578COvg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbgFQMg1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 08:36:27 -0400
Received: from mail-eopbgr60063.outbound.protection.outlook.com ([40.107.6.63]:39436
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725894AbgFQMg0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 08:36:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d4Em+dFIlZ8AQ0/Z8agCyxrTIWN9tze3uF8zIPHkvhj9BPnwpj9sfZZ8C9X60+vMQc6qNl4kAmGiM8eQrCIO31Xedf6+M9SDADmNVaCqS4P8aX6L+PVNIlkHW+X6kUu/rmIA2wdD90WP3sJpumTvByCbGh3ZMQExrD2p4KCXasXwoIGwq8+kuheymT7yS68Em70rxLsT73jC7gY16MTldu/LQpQKVRLCUjjw9L0o22tEbYXI/K92pWewoAX461gBVKdMEtfZ6CDcY9p7M7kbHhvf8gSyv8CllJdtiHeis9zhM1vJLomqkpH6/oG1N3PKBsepMyproTRr4f2OWICNIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0+sUt8tKWYWO2FFFau4ww39BKchkOB152/TJQzVqBUA=;
 b=c2TTPMb/VDcy6aNb4sUDLwzhPOQ4BFw94xg96bXNveD+AYvJzyP6kCC1Ym7MIta0KbZAL0aAI0poWCJ+N7RVxbi0GikG7Nw4OSixLPiO80o4NucaDFdD3xOLqOpvxLuwBpMdjWJqzt5Tqivv8BwfLNQmkJjdlwXjrrXKcHYTiA5KZ1GugczBkVBcTZnuZMnsJh0UeRnmfyM3SGS8wjX/tuiFJKH7xpAvEH4rV9rWiQdvO7s/uULtqBxeke8TFbZ3uF7RZ/37Oof+J0HVpJR1Jkx4MjuV0ScqvfJcKg0r84sDNTpMiQbUdyyfqhI+svgesVqf+Yza1SIq3y5/U6WAgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0+sUt8tKWYWO2FFFau4ww39BKchkOB152/TJQzVqBUA=;
 b=J578COvgig6Sk/jmgiBpKsGVtJRV/Lb+q0l6QSs8xP05hIG2x09yZmoIn1YcKVGq3E/jKLZabk/qVf/VXblVoNR0kP6uem5OBgvWmJAF8h/vzz1XZIj0VKyxq83jeWJrjNK5PkZxmtlOJuDYRyom9JlxtpsC6lkQqFMykaZ5L2g=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (2603:10a6:8:10::18)
 by DB3PR0402MB3818.eurprd04.prod.outlook.com (2603:10a6:8:e::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Wed, 17 Jun
 2020 12:36:22 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1dab:b68c:e028:acb3]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1dab:b68c:e028:acb3%6]) with mapi id 15.20.3109.021; Wed, 17 Jun 2020
 12:36:22 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Aisheng Dong <aisheng.dong@nxp.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "oleksandr.suvorov@toradex.com" <oleksandr.suvorov@toradex.com>,
        Stefan Agner <stefan.agner@toradex.com>,
        "arnd@arndb.de" <arnd@arndb.de>, Abel Vesa <abel.vesa@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "allison@lohutok.net" <allison@lohutok.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "info@metux.net" <info@metux.net>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Andy Duan <fugang.duan@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "yuehaibing@huawei.com" <yuehaibing@huawei.com>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V2 2/9] ARM: imx: Select MXC_CLK for ARCH_MXC
Thread-Topic: [PATCH V2 2/9] ARM: imx: Select MXC_CLK for ARCH_MXC
Thread-Index: AQHWPjGj2zNwfnTiD0imGsOupBSBz6jcqXKAgAAhTUA=
Date:   Wed, 17 Jun 2020 12:36:22 +0000
Message-ID: <DB3PR0402MB39160682846B99E0A3762AF1F59A0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1591687933-19495-1-git-send-email-Anson.Huang@nxp.com>
 <1591687933-19495-3-git-send-email-Anson.Huang@nxp.com>
 <AM6PR04MB4966F4A5E0276AEDB5605260809A0@AM6PR04MB4966.eurprd04.prod.outlook.com>
In-Reply-To: <AM6PR04MB4966F4A5E0276AEDB5605260809A0@AM6PR04MB4966.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [183.192.13.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fac64e68-f590-4969-8818-08d812bb0b21
x-ms-traffictypediagnostic: DB3PR0402MB3818:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB3818B651762299D651A187DAF59A0@DB3PR0402MB3818.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 04371797A5
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Bfij161nQ9qgC1jABe4PGCKsn2TWVtJl+olCXprOjQGI6LM3OTGUqgXZb8gVENruav2yzTnXOBm6HtlQ2XMc1QXJ9u4MnlNKXm5fW57WYWCbR+6B1jJWsaNQsGYs+IanoT0bKezIrYyxCSgpeuMwHZUXiakhdClou3QyEXZvTeGUh5D4rnzByfwC7r2es2tfOZeaUzZyvrJKe3wRACP85ScPAC9ankgOMay1u459DU4M4OEdvY0NQ9Dfr6t7osOLNeqMblus2YiJA9b/qyjUS1NDVzmTwtWpn6T56yg+FhbedFEta72lG+xIrY7PWoN1xJmmtryjF8nvq+XXP8a0vIClTxalY3Y6BvieF43Z1SS0V30cSHglA5r1CT4s7cjCwi3igScRlpkA2cl8dSWC5Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(136003)(39860400002)(396003)(366004)(346002)(186003)(8936002)(5660300002)(86362001)(4744005)(2906002)(71200400001)(52536014)(6506007)(26005)(33656002)(83380400001)(8676002)(4326008)(7416002)(7696005)(316002)(478600001)(9686003)(44832011)(66476007)(66556008)(66946007)(76116006)(64756008)(66446008)(110136005)(55016002)(21314003)(921003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: M1F/27Yr7LHBUs8u2QHQ0UyQ4E3dJ3XxvQavO5QFhpIesmjb5qqPsg8yA1a5wTIQDqjVsaJ/AXEfnnZ3PMVzgfBkCzmig1exthPU0HrLoADDnT2cRlCbfPYQSB0QAPDtS5RC67twRczVq3jcOa1q/nGAicwfZOkbUHWJqqnJWtnWI8XNFSypUnKPj71/p4ha29463LOy4dMioQlK1yvejuTEK2tDlEXmRN5WDR2GcWrBdZkWGL6PJU0umuY3dN1C3/as1XCuXCH8ncYJXev0I7duxG3pBXpYDJziTLX3/xpYqLJF7ReE6UY5Be+o5VRNP23Irz/p1Wo+WbPrQeirzjNzdVOjLl+f/QeKXovFpENfin5it2LZrGenBMtBgaa/IyDx14jwoR5PotKQfKqPbG2RAREOrkmlLufSUoOpoHyFUj4eRJrYpGiJdR79IQzrfb3M4+UQn9dAxVhWfb2phuf8LZj1MrvP/NMyWHr55jlZO5N2AbZii+dwDLzM/MxJ
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fac64e68-f590-4969-8818-08d812bb0b21
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2020 12:36:22.6227
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QfMYLYH+ZFNJglbtX4cqkXPAeFSwr/JU3BL1A+S3ffUcVOXHiQORb2abGPyB4ckXb2SYh51vTsvVvCwqzkaBHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3818
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gU3ViamVjdDogUkU6IFtQQVRDSCBWMiAyLzldIEFSTTogaW14OiBTZWxlY3QgTVhDX0NM
SyBmb3IgQVJDSF9NWEMNCj4gDQo+ID4gRnJvbTogQW5zb24gSHVhbmcgPEFuc29uLkh1YW5nQG54
cC5jb20+DQo+ID4gU2VudDogVHVlc2RheSwgSnVuZSA5LCAyMDIwIDM6MzIgUE0NCj4gPg0KPiA+
IGkuTVggY29tbW9uIGNsb2NrIGRyaXZlcnMgbWF5IHN1cHBvcnQgbW9kdWxlIGJ1aWxkLCBzbyBp
dCBpcyBOT1QNCj4gPiBzZWxlY3RlZCBieSBkZWZhdWx0LCBmb3IgQVJDSF9NWEMgQVJNdjcgcGxh
dGZvcm1zLCBuZWVkIHRvIHNlbGVjdCBpdA0KPiA+IG1hbnVhbGx5IHRvIG1ha2UgYnVpbGQgcGFz
cy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEFuc29uIEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAu
Y29tPg0KPiANCj4gQ2FuJ3QgdGhlIG9yaWdpbmFsIGRlZl94eHggd29yaz8NCj4gDQo+IGNvbmZp
ZyBNWENfQ0xLDQo+ICAgICAgICAgdHJpc3RhdGUNCj4gICAgICAgICBkZWZfdHJpc3RhdGUgQVJD
SF9NWEMNCg0KU3VjaCBjaGFuZ2Ugd2lsbCBtYWtlIE1YQ19DTEs9eSBldmVuIGFsbCBpLk1YOCBT
b0NzIGNsb2NrIGRyaXZlcnMgYXJlIHNlbGVjdGVkIGFzIG1vZHVsZSwNCnNvIGl0IGRvZXMgTk9U
IG1lZXQgdGhlIHJlcXVpcmVtZW50IG9mIG1vZHVsZSBzdXBwb3J0LiBCZWxvdyBpcyBmcm9tIC5j
b25maWcgd2hlbiBhbGwNCmkuTVg4IFNvQ3MgY2xvY2sgZHJpdmVycyBhcmUgY29uZmlndXJlZCB0
byBtb2R1bGUuDQoNCiBDT05GSUdfTVhDX0NMSz15DQogQ09ORklHX01YQ19DTEtfU0NVPW0NCiBD
T05GSUdfQ0xLX0lNWDhNTT1tDQogQ09ORklHX0NMS19JTVg4TU49bQ0KIENPTkZJR19DTEtfSU1Y
OE1QPW0NCiBDT05GSUdfQ0xLX0lNWDhNUT1tDQogQ09ORklHX0NMS19JTVg4UVhQPW0NCg0KQW5z
b24NCg==
