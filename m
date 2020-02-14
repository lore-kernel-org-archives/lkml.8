Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC777C3B194
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 05:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EBFA24673
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 05:11:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="VOmmh5c5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726004AbgBNFLR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 00:11:17 -0500
Received: from mail-vi1eur05on2048.outbound.protection.outlook.com ([40.107.21.48]:6242
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725763AbgBNFLQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 00:11:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mtJegUfKKfaN/2qfNmViR3jYsiHUWVveimjDpbWmWDNE4eoxRsIrHe/VzQGkALAXg6D9TPmcc3dSt9+7a3mAeR6pAAyMlyCHJsh4E+Z3CDD+tt9CuPdtfdoqIoWn5m0SxBtA14m15TVJUcCyNMNi0uOOAYCHkpm/NeAmYNxap9rYTf3MK9+cKa5RzABg29jAqasjDKzn09yxJbubMjWX+O+u+IHijcrSXox9Em/+OSXXFo+CKkj4jAK0/t5C4I0hCGvRpCN+T6+BKkXTkhwSlnHr0YagLIAd2gbinL7pwoBVPYTR6RlQ+7A4OiVzkSiPLSwSZy6u+UKM/p9Zk5Z3bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GN3oub+XkqaonK/rjGzrTg4lw/HczDXlK29QtSC2JMk=;
 b=Un5XWt0ZRooQin9fhDaQqL0rU1eATzXlGLP43+g4DjdAbW2fwOGxDhg94FF66NOBPqMam7iUazpBpiwM50yrXJgmMfdi9PH3KI9RTQl4qbzlbsaEtrUMjDoeGC0qZqEuweoHz0xQZE6t14shaXHpMOxT340iNkCe25OywM4ggzsnH5BySHKkoMkqc73d3BAu3pPd7VvrNOnLPLxk7tYY0bnJ3Rs9o0iyFVa8bw+VTgtyzfdnil8BoZK5SA2ljoLMJS9pcTJRoo/6liBgGWjrrSKMU+S2k24lqYVEw6EQeZSSWVjcVHoNb+DernmXFbqJoJ37AmS+tZs+lqcyG94yEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GN3oub+XkqaonK/rjGzrTg4lw/HczDXlK29QtSC2JMk=;
 b=VOmmh5c5Dwti0oIHl9Kd2FyyamL2d7W/3g2TyeoRk0Cd7Uv524qM0mIoBrJ+9nO/p398hsLfTVktXlkwB+GPqbVce/7B5/h+gMjCzMnohETV+xZY6fPSOiwhfZBPYbZ8KMMd9MuiXVO7Ejg8izj6AM51YbSuIcuIWnwuFynEyKI=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3833.eurprd04.prod.outlook.com (52.134.67.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.25; Fri, 14 Feb 2020 05:11:11 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e44d:fa34:a0af:d96]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e44d:fa34:a0af:d96%5]) with mapi id 15.20.2729.025; Fri, 14 Feb 2020
 05:11:11 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>
CC:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH] ARM: dts: imx6sx: Add missing uart mux function
Thread-Topic: [PATCH] ARM: dts: imx6sx: Add missing uart mux function
Thread-Index: AQHV4jmkBGoJScQ3+kWiDMpfJDDuQ6gYuY4AgAAdYTCAAArlgIABQuKw
Date:   Fri, 14 Feb 2020 05:11:11 +0000
Message-ID: <DB3PR0402MB391620CB6FA1C3E86AD5C163F5150@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1581576189-20490-1-git-send-email-Anson.Huang@nxp.com>
 <20200213072710.4snwbo3i7vfbroqy@pengutronix.de>
 <DB3PR0402MB39163A56BF6AA37E3C691964F51A0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <20200213095119.f6obrdqb6ql76qqy@pengutronix.de>
In-Reply-To: <20200213095119.f6obrdqb6ql76qqy@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f995d8f6-58e7-44bf-efce-08d7b10c4eb6
x-ms-traffictypediagnostic: DB3PR0402MB3833:|DB3PR0402MB3833:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB3833E78187C004E29EAACE06F5150@DB3PR0402MB3833.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 03137AC81E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(376002)(346002)(39860400002)(366004)(199004)(189003)(2906002)(52536014)(316002)(44832011)(26005)(76116006)(4326008)(8936002)(71200400001)(81166006)(8676002)(81156014)(86362001)(6916009)(7416002)(186003)(478600001)(6506007)(33656002)(7696005)(9686003)(5660300002)(54906003)(66446008)(66556008)(55016002)(66946007)(64756008)(66476007)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3833;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ck0JEhMzciHAVndXncU7lK3xs3ad/5BvCX0S3Xcn0A079fXrdnZQEitnuZEVfqZAHNuNBhmrzNAEotGBXbumbjmI9dr7nE8um/3sp7cXAx5KiMTsFKNBC/2eRhwAIcBRavrEBXgLELjU7oavPnASLnVND6iVRxJ4Z0T/mXn86UD7PXwnXtsRGZSuxgyOBS+xG9GDHQSoBb+JNRBcMYGWzPVdB2TAyyX2uyGftklOllDKNhmg0HN+dWR6bvoJeH6Jtoa7ZzXW8xN2jRWisAZJhId+iHLRoVkkTH9d9Yq0SbqgP5oCIRZHwZisNEPMtxmbi/Bt1ZGjzidyQJpqQCDYUXelArEg+thralpiw950oLMUCLHxhyVLnhWoNyNnu92Is7PF+Bk4twO0ZoJs7PR5GW2xKmIzjYtihFUbII9nxsVBHXqP8nJmMD9u+WD88U4/O494jS+2E8cEUWYgRoN2KJkgM2OEuu4n7V4lZOlKqjOO5JvJanCWbKYFVHGIoCry
x-ms-exchange-antispam-messagedata: ce2QojUW470bieHaJPGjoJCwT87kW53lcgyq3H+KQNmKZFnM7U9LL6DYajTK193Cx7k9QTlkb9+RmOIeWJ4Teje38beSqIekxMbaeaGq9O6a5ozb1WxuX86rPyR/MDt3t2z27HEc51w6uZHU6NkQPA==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f995d8f6-58e7-44bf-efce-08d7b10c4eb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2020 05:11:11.3910
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qoU5w2RzGYp6AX8uLUwzdNnwmo5nAUr5cwTXmQjNLVUfjJ0qgtdXE7d0gLM0fD4xPQg9dY6n5cEBrfc7GZFfbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3833
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFV3ZQ0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIEFSTTogZHRzOiBpbXg2c3g6IEFkZCBt
aXNzaW5nIHVhcnQgbXV4IGZ1bmN0aW9uDQo+IA0KPiBIZWxsbyBBbnNvbiwNCj4gDQo+IE9uIFRo
dSwgRmViIDEzLCAyMDIwIGF0IDA5OjE4OjEwQU0gKzAwMDAsIEFuc29uIEh1YW5nIHdyb3RlOg0K
PiA+ID4gT24gVGh1LCBGZWIgMTMsIDIwMjAgYXQgMDI6NDM6MDlQTSArMDgwMCwgQW5zb24gSHVh
bmcgd3JvdGU6DQo+ID4gPiA+IEZyb206IEFuc29uIEh1YW5nIDxiMjA3ODhAZnJlZXNjYWxlLmNv
bT4NCj4gPiA+ID4NCj4gPiA+ID4gVXBkYXRlIGkuTVg2U1ggcGluZnVuYyBoZWFkZXIgdG8gYWRk
IHVhcnQgbXV4IGZ1bmN0aW9uLg0KPiA+ID4NCj4gPiA+IEknbSBhd2FyZSB5b3UgYWRkIHRoZSBt
YWNyb3MgaW4gYSBjb25zaXN0ZW50IHdheSB0byB0aGUgYWxyZWFkeQ0KPiA+ID4gZXhpc3Rpbmcg
c3R1ZmYuIFN0aWxsIEkgdGhpbmsgdGhlcmUgaXMgc29tZXRoaW5nIHRvIGltcHJvdmUgaGVyZS4g
V2UNCj4gPiA+IG5vdyBoYXZlIGRlZmluaXRpb25zIGxpa2U6DQo+ID4gPg0KPiA+ID4gCU1YNlNY
X1BBRF9HUElPMV9JTzA2X19VQVJUMV9SVFNfQg0KPiA+ID4gCU1YNlNYX1BBRF9HUElPMV9JTzA2
X19VQVJUMV9DVFNfQg0KPiA+ID4NCj4gPiA+IAlNWDZTWF9QQURfR1BJTzFfSU8wN19fVUFSVDFf
Q1RTX0INCj4gPiA+IAlNWDZTWF9QQURfR1BJTzFfSU8wN19fVUFSVDFfUlRTX0INCj4gPiA+DQo+
ID4gPiB3aGVyZSAoaWdub3Jpbmcgb3RoZXIgcGlucyB0aGF0IGNvdWxkIGJlIHVzZWQpIG9ubHkg
dGhlIGZvbGxvd2luZw0KPiA+ID4gY29tYmluYXRpb25zIGFyZSB2YWxpZDoNCj4gPiA+DQo+ID4g
PiAJTVg2U1hfUEFEX0dQSU8xX0lPMDRfX1VBUlQxX1RYDQo+ID4gPiAJTVg2U1hfUEFEX0dQSU8x
X0lPMDVfX1VBUlQxX1JYDQo+ID4gPiAJTVg2U1hfUEFEX0dQSU8xX0lPMDZfX1VBUlQxX1JUU19C
DQo+ID4gPiAJTVg2U1hfUEFEX0dQSU8xX0lPMDdfX1VBUlQxX0NUU19CDQo+ID4gPg0KPiA+ID4g
KGluIERDRSBtb2RlKSBhbmQNCj4gPiA+DQo+ID4gPiAJTVg2U1hfUEFEX0dQSU8xX0lPMDRfX1VB
UlQxX1JYDQo+ID4gPiAJTVg2U1hfUEFEX0dQSU8xX0lPMDVfX1VBUlQxX1RYDQo+ID4gPiAJTVg2
U1hfUEFEX0dQSU8xX0lPMDZfX1VBUlQxX0NUU19CDQo+ID4gPiAJTVg2U1hfUEFEX0dQSU8xX0lP
MDdfX1VBUlQxX1JUU19CDQo+ID4gPg0KPiA+ID4gKGluIERURSBtb2RlKS4NCj4gPg0KPiA+IElz
IGl0IHBvc3NpYmxlIHRoZSB1c2luZyBiZWxvdyBjb21iaW5hdGlvbiwgaWYgcG9zc2libGUsIHRo
ZW4gSSB0aGluaw0KPiA+IHRoZSBwcmVmaXggIkRURS9EQ0UiIGFyZSBOT1QgaW1wYWN0aW5nIHJl
YWwgZnVuY3Rpb25zLCB0aGV5IGFyZSBqdXN0DQo+IGRpZmZlcmVudCBuYW1lcyBmb3IgYmV0dGVy
IGlkZW50aWZpY2F0aW9uOg0KPiA+DQo+ID4gTVg2U1hfUEFEX0dQSU8xX0lPMDRfX1VBUlQxX1RY
DQo+ID4gTVg2U1hfUEFEX0dQSU8xX0lPMDVfX1VBUlQxX1JYDQo+ID4gTVg2U1hfUEFEX0dQSU8x
X0lPMDZfX1VBUlQxX0NUU19CDQo+ID4gTVg2U1hfUEFEX0dQSU8xX0lPMDdfX1VBUlQxX1JUU19C
DQo+IA0KPiBUaGlzIGlzIHdyb25nIGFjY29yZGluZyB0byBteSBleHBlcmllbmNlLiBJZiB5b3Ug
bG9vayBhdCB0aGUgZGlhZ3JhbSBpbiB0aGUNCj4gaS5NWDZTWCBSTSBpbiB0aGUgRXh0ZXJuYWwg
U2lnbmFscyBjaGFwdGVyIChwYWdlIDQxMTEgaW4gdGhlIElNWDZTWFJNIFJldi4NCj4gMiwgOS8y
MDE3KSB5b3UgY2FuIG9ubHkgZWl0aGVyIHVzZSBSWC9UWCBhbmQgUlRTL0NUUyBmb3IgdGhlaXIg
b3JpZ2luYWwNCj4gcHVycG9zZSwgb3Igc3dhcCBib3RoIHBhaXJzIHRvZ2V0aGVyLg0KPiANCj4g
PiA+IEZvciBpLk1YNlNMTCwgaS5NWDZVTCwgaW14NlVMTCBhbmQgaS5NWDcgdGhlIG5hbWluZyBj
b252ZW50aW9uIGlzDQo+ID4gPiBzYW5lciwgYSB0eXBpY2FsIGRlZmluaXRpb24gdGhlcmUgaXM6
DQo+ID4gPg0KPiA+ID4gCU1YN0RfUEFEX0xQU1JfR1BJTzFfSU8wNF9fVUFSVDVfRFRFX1JUUw0K
PiA+ID4NCj4gPiA+IHdoZXJlIHRoZSBuYW1lIGluY2x1ZGVzIERURSBhbmQgd2hlcmUgaXMgaXQg
KG1vcmUpIG9idmlvdXMgdGhhdCB0aGlzDQo+ID4gPiBjYW5ub3QgYmUgY29tYmluZWQgd2l0aA0K
PiA+ID4NCj4gPiA+IAlNWDdEX1BBRF9MUFNSX0dQSU8xX0lPMDdfX1VBUlQ1X0RDRV9UWA0KPiA+
ID4NCj4gPiA+IC4NCj4gPiA+DQo+ID4gPiBJIHN1Z2dlc3QgdG8gYWRhcHQgdGhlIGxhdHRlciBu
YW1pbmcgY29udmVudGlvbiBhbHNvIGZvciB0aGUgb3RoZXINCj4gPiA+IGkuTVggcGluZnVuYyBo
ZWFkZXJzLCBwcm9iYWJseSB3aXRoIGludHJvZHVjaW5nIGRlZmluZXMgZm9yIG5vdA0KPiA+ID4g
YnJlYWtpbmcgZXhpc3RpbmcgZHRzIGZpbGVzLg0KPiA+DQo+ID4gSWYgdG8gaW1wcm92ZSB0aGUg
bmFtZSwganVzdCBjaGFuZ2UgdGhlIGV4aXN0aW5nIGR0cyBmaWxlcyB3aGljaCB1c2UNCj4gPiB0
aGVtIHNob3VsZCBiZSBPSywgYXMgdGhpcyBoZWFkZXIgZmlsZSBPTkxZIHVzZWQgYnkgRFQgYW5k
IHNob3VsZCBiZQ0KPiA+IG5vIGNvbXBhdGlibGUgaXNzdWVzLiBTbyBzaG91bGQgSSBjaGFuZ2Ug
dGhlIGR0cyBmaWxlcyB0b2dldGhlcj8NCj4gDQo+IE15IGFwcHJvYWNoIHdvdWxkIGJlIG9uZSBw
YXRjaCBmb3IgZWFjaCBvZjoNCj4gDQo+ICAtIHJlbmFtZSBleGlzdGluZyBpbXg2c3ggc3ltYm9s
cyB0byBjb250YWluIERURSBvciBEQ0UNCj4gICAgKGludHJvZHVjaW5nIGRlZmluZXMgdGhhdCBt
YXAgdGhlIG9sZCBuYW1lIHRvIHRoZSBuZXcpDQoNCklzIHRoZSBpbnRyb2R1Y2luZyBkZWZpbmVz
IHRoYXQgbWFwIHRvIG9sZCBuYW1lIHRvIHRoZSBuZXcgbWFpbmx5IGZvcg0KTk9UIGJyZWFraW5n
IGJpc2VjdD8gQXMgcGluZnVuYy5oIGlzIGNoYW5nZWQgaW4gYSBzZXBhcmF0ZSBwYXRjaCBvdGhl
ciB0aGFuIGR0cyBmaWxlcy4gDQoNCj4gDQo+ICAtIGludHJvZHVjZSB0aGUgbmV3IGRlZmluZXMg
eW91IGFkZGVkIGluIHlvdXIgcGF0Y2ggdW5kZXIgZGlzY3Vzc2lvbg0KPiAgICBoZXJlICh3aXRo
IHRoZSBuZXcgbmFtaW5nIHNjaGVtZSBvYnZpb3VzbHkpDQoNCk1ha2Ugc2Vuc2UuIEN1cnJlbnQg
aGVhZCBmaWxlIE9OTFkgaGFzIERDRS9EVEUgZm9yIFRYL1JYIGJ1dCBtaXNzIHRoZSBSVFMvQ1RT
Lg0KDQo+IA0KPiAgLSBzd2l0Y2ggYWxsIGluLXRyZWUgY29uc3VtZXJzIHRvIHRoZSBuZXcgbmFt
ZXMNCj4gICAgKG1heWJlIG9mZmVyaW5nIHRvIHNwbGl0IHBlciBtYWNoaW5lKQ0KPiANCj4gSSB3
b3VsZCBhbHNvIGRyb3AgdGhlIF9CIHN1ZmZpeCBpbiB0aGUgZmlyc3QgcGF0Y2ggd2hpY2ggc2Vy
dmVzIG5vIHVzZWZ1bA0KPiBwdXJwb3NlLg0KDQpNYWtlIHNlbnNlLg0KDQpUaGFua3MsDQpBbnNv
bg0K
