Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71272C35673
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 02:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F0A82051A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 02:01:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="CG4icWvm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbgBXCB4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 21:01:56 -0500
Received: from mail-eopbgr30067.outbound.protection.outlook.com ([40.107.3.67]:34815
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727151AbgBXCBz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 21:01:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fQ4cWRqvLAstoQkLR1MdBZnV6n1+iNOO8EAys2qCa5iF+0T8L2p9MRBKHJWkcLx25zl22kAuB0Dogn+M8EUL/rONmr/PZWgnRwSsGlEEGMufpTx7E9GHqS+oZH0o0lMSjG13gFwHl2DE91HMX9dahIfVp1ttqqla5cUVKRVzgH3Cqw0B+rqJiI0SwCpudq1nWtgDa4cmjuJUF+qGE18HO563s2+D83uO2QirlpuG7v6hV2AS+xz0gY3fDdZ1WNTVVoATgM4PJc+yBXWsd1vMgRM3l4Wy7Uw3wao+NJvR/ESmDTmqqf7Ecq05WPXb98+oYV0tnJTTJUNOuVSkLMxCPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8+Zr2GY8pjGaD22GFA0d4Jvlmmq9kQ+hUoXy5KQvA50=;
 b=T6iZaSblbgbZ/CWBz4pzxZuDwxSepp9ilSZ0PYCQNpuHDUatWG+HpmirJ4mmVqH69dN86IvrGYjaHVDwtZSGvWXkxXCLFwWsbp7vS7pClWsHQ84QKnz+q1sfF/e1pjl/nK150e5UjVWN8y3xIvTL+Ohv49IdKlPmt2hm/xGskU8NafvzkK4wIKrHngfasbZfB4EeHRwol1xSdGtf4kmhV5BgA/6p5OWYyRv2zb6L3zjDUYgnhrb/hDjyal7ou3Hgm3XaqJ2Dm0Q84OLYKo6IyDdEnOFyys0dkNzq8uxW2OA3jO07UerVnVqChdNZJ5YxVhV177ylTYthJctRO6Jz+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8+Zr2GY8pjGaD22GFA0d4Jvlmmq9kQ+hUoXy5KQvA50=;
 b=CG4icWvmwgzR3fJI8qHP051lvNjrivyPsI9AxDTqS/sdsE0aIFVBo6yMnJmJs/UOrEZZj80IkZbmO8WyVqRTTxNBKKs/0ItFts8a0Tp5MluwfgAIUynf+SehcvMqNqTT0aAn+9d1UGiXPSwNr/B2oL+ESmh0OvwCiqCauvxruJo=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3913.eurprd04.prod.outlook.com (52.134.65.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.21; Mon, 24 Feb 2020 02:01:51 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e44d:fa34:a0af:d96]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e44d:fa34:a0af:d96%5]) with mapi id 15.20.2750.021; Mon, 24 Feb 2020
 02:01:51 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] arm64: dts: imx8mn-ddr4-evk: Adjust 1.2GHz OPP voltage to
 OD mode
Thread-Topic: [PATCH] arm64: dts: imx8mn-ddr4-evk: Adjust 1.2GHz OPP voltage
 to OD mode
Thread-Index: AQHV5f7nnxcZEOnHvUiMPtQ2Xd2MmKgpnOUAgAADUPA=
Date:   Mon, 24 Feb 2020 02:01:50 +0000
Message-ID: <DB3PR0402MB391621D12FF3B43490505C7CF5EC0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1581990752-10219-1-git-send-email-Anson.Huang@nxp.com>
 <20200224014759.GB27688@dragon>
In-Reply-To: <20200224014759.GB27688@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [27.157.70.3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cf10751b-8994-4d9c-48c7-08d7b8cd838e
x-ms-traffictypediagnostic: DB3PR0402MB3913:|DB3PR0402MB3913:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB3913BA8FDE045CFFA9E6A48EF5EC0@DB3PR0402MB3913.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 032334F434
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(136003)(346002)(396003)(39860400002)(366004)(199004)(189003)(26005)(76116006)(186003)(54906003)(66556008)(66476007)(66946007)(7696005)(66446008)(64756008)(44832011)(52536014)(6506007)(8936002)(8676002)(81166006)(81156014)(9686003)(55016002)(71200400001)(4326008)(6916009)(316002)(5660300002)(2906002)(86362001)(33656002)(478600001)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3913;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fXKGRmUZzzIn1cl560IY0YTE5SP4FNoh9sp60Vq/fSjA6FcQvop9entv4V1xoV4hDwok9xryVmrE8WGMhpc6gQNTGij4VhDGyRFo+g2lwWjy5N9D7jUh8daZQvh+6TsKO+nu9d2MuW3XCPgn8r09k9Ul0F5mAjLXk8JL2c1YTRVFbRGFWLd+w/ySJQ4vWCbvLsNPqWMvtOi69FvpS6Wm5FKbE3dmdN/jt/RKBBHGFEGm5uoKlrcrALqpBrEt9yNYSYFccOZ4tQnr6T5nExR26knY3MhPBkao73r291lspaSzMnP4Aqcfd8jr7+PYAsrBR3t5ydOHJEbSO58DyrInS+8F6CHqtZwHQBJ0mJNwtVRXA3iCnO13loP7xAESOeNvpzVTMDXp0D+nsi5DGGvcd1hvF0wSy/vHWxp86vYuM7QuxTItNs6lTzs+uYkGOCdbOn2XO3N4DbM+8EA8vhrluSvZ0mWy3wTOnz8pyeHxs3ZTxbuIvGthqtZl1c5CNTVy
x-ms-exchange-antispam-messagedata: KtbuREThz5kQAnjuy6BG7qs/F61/77o/U7xYmZyJtilK/st5MoJMjg40pKoPd3Krkq9FuE2FDXCBbAJP2RWzSE5QdCRx/AHmWVQkxpYF5TwFTKrLZs9g7T6iMXEPk3BdslBCnQeW7ekiWXiOqt5t3g==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf10751b-8994-4d9c-48c7-08d7b8cd838e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2020 02:01:50.9611
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bERlAgkG6yginfNijV+YKQvR56EtX7+eMZA+IEL1/zlS/OEsFPahQnNJMOU5SkbguLYxZZYnPCoTeU3NzGS/uA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3913
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFNoYXduDQoNCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gYXJtNjQ6IGR0czogaW14OG1uLWRk
cjQtZXZrOiBBZGp1c3QgMS4yR0h6IE9QUA0KPiB2b2x0YWdlIHRvIE9EIG1vZGUNCj4gDQo+IE9u
IFR1ZSwgRmViIDE4LCAyMDIwIGF0IDA5OjUyOjMyQU0gKzA4MDAsIEFuc29uIEh1YW5nIHdyb3Rl
Og0KPiA+IEFjY29yZGluZyB0byBsYXRlc3QgZGF0YXNoZWV0IFJldi4wLCAxMC8yMDE5LCB0aGVy
ZSBpcyByZXN0cmljdGlvbiBhcw0KPiA+IGJlbG93Og0KPiA+DQo+ID4gIklmIFZERF9TT0MvR1BV
L0REUiA9IDAuOTVWLCB0aGVuIFZERF9BUk0gbXVzdCBiZSA+PSAwLjk1Vi4iDQo+ID4NCj4gPiBB
cyBieSBkZWZhdWx0IFNvQyBpcyBydW5uaW5nIGF0IE9EIG1vZGUoVkREX1NPQyA9IDAuOTVWKSwg
c28gVkREX0FSTQ0KPiA+IDEuMkdIeiBPUFAncyB2b2x0YWdlIHNob3VsZCBiZSBpbmNyZWFzZWQg
dG8gMC45NVYuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBBbnNvbiBIdWFuZyA8QW5zb24uSHVh
bmdAbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiAgYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUv
aW14OG1uLWRkcjQtZXZrLmR0cyB8IDYgKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA2IGlu
c2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2Zy
ZWVzY2FsZS9pbXg4bW4tZGRyNC1ldmsuZHRzDQo+ID4gYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2Zy
ZWVzY2FsZS9pbXg4bW4tZGRyNC1ldmsuZHRzDQo+ID4gaW5kZXggMjQ5N2VlYi4uN2E2MWExYSAx
MDA2NDQNCj4gPiAtLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bW4tZGRy
NC1ldmsuZHRzDQo+ID4gKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1u
LWRkcjQtZXZrLmR0cw0KPiA+IEBAIC0xMyw2ICsxMywxMiBAQA0KPiA+ICAJY29tcGF0aWJsZSA9
ICJmc2wsaW14OG1uLWRkcjQtZXZrIiwgImZzbCxpbXg4bW4iOyAgfTsNCj4gPg0KPiA+ICsmYTUz
X29wcF90YWJsZSB7DQo+ID4gKwlvcHAtMTIwMDAwMDAwMCB7DQo+ID4gKwkJb3BwLW1pY3Jvdm9s
dCA9IDw5NTAwMDA+Ow0KPiA+ICsJfTsNCj4gPiArfTsNCj4gPiArDQo+IA0KPiBUaGUgcmVzdHJp
Y3Rpb24gYXBwbGllcyB0byBTb0MgcmF0aGVyIHRoYW4gYSBwYXJ0aWN1bGFyIGJvYXJkLCByaWdo
dD8NCj4gSWYgc28sIHRoZSBjaGFuZ2Ugc2hvdWxkIGJlIG1hZGUgaW4gaW14OG1uLmR0c2k/DQoN
ClllcywgeW91IGFyZSBjb3JyZWN0LCBmb3Igbm93LCBpdCBpcyBOT1QgcmVsYXRlZCB0byBib2Fy
ZCwgSSB3aWxsIGRvIHRoZSBjaGFuZ2UNCmluIC5kdHNpIGluIFYyLg0KDQpBbnNvbg0K
