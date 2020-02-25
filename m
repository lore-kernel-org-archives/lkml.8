Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21009C35DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 08:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1BFD2176D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 08:59:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Txf3M9Fb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729584AbgBYI7D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 03:59:03 -0500
Received: from mail-vi1eur05on2077.outbound.protection.outlook.com ([40.107.21.77]:34016
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726916AbgBYI7D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 03:59:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QlkZtw7Lr4RDkG57fh5+thIYWHD8XQToK7O0dQiSR7LqT4Zc9mJvfIY5F3jCL+/PhXA/RQbkAP9xRLu5DuZwBV4C9d7ypzmzpBCCRSLW2psRubMOgZiuQ/12kKNit311Pdr0UKOF6rDev09RT9f5/RZPYD1qrcyk7GF11HrAVzhcoIQKkW/zP0JR0neUUEo1f/riu8w6iiuW+AjzJvf+ZVi3ofvzp6s4BlOkd50awFIloJ4jnwd7/z44yOki/vbzUqL5QDKpeiecHukIjC7eAW8WoKDAcBTD2jf0/lvBbmhBaVmxtZr1zfPxAHHkZ0f7H7gO6Rr8TL7J77RjkokQeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UpSmpbFgbbZ7GStM33pX9QJ0urAWkrjNAZeEzer5uOY=;
 b=l62y53lPUyp7yj3g4W7nT93nUOjo1B0xolJwmgoi4SyaXWT1Dt1MbxK+B9UOfqGtYyP8QOatBDmk9gPUCxCB3UllDMGZgfpPqQO/LqCR8zKvt99i1S8qbwS2m/fe7xMLzteoeHkN49diHs4O2KcpICPwS2Elg67dCCsAcvEa5xDIKCEvYMGJbQDJFon9l5a3CHBSXXGGB3Ol7qodcZpfFFpN+5IOzjKavV19gXwpdn3Bxa3qcACRN7AgQRhkmg8wFMsH5+AzPangMegYojeRK8zyZ2TaGhu5oaE/7vboYOgX8TooO8EL0W6N1Rm/0kVuYgiqdC3dJC0swVfSozWggA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UpSmpbFgbbZ7GStM33pX9QJ0urAWkrjNAZeEzer5uOY=;
 b=Txf3M9FbH56i9lePTOIHUEDMxdITYxZ5KZqOl2IvAqXWj6f6BA571QY5BxIp/UdwaS2bXW+Jz53XQP8QwFt9j/rZIgMGAUGDAg+caWgoWKWPU5qMdle6pB3K/YyQNYSmH3wwtb2w3+mccgItXm0b5fE2mC9pMLOXFKhWfol87Y0=
Received: from VI1PR0402MB3839.eurprd04.prod.outlook.com (52.134.16.147) by
 VI1PR0402MB3421.eurprd04.prod.outlook.com (52.134.2.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.21; Tue, 25 Feb 2020 08:58:22 +0000
Received: from VI1PR0402MB3839.eurprd04.prod.outlook.com
 ([fe80::8881:e155:f058:c0d1]) by VI1PR0402MB3839.eurprd04.prod.outlook.com
 ([fe80::8881:e155:f058:c0d1%4]) with mapi id 15.20.2750.021; Tue, 25 Feb 2020
 08:58:22 +0000
From:   Daniel Baluta <daniel.baluta@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, Andy Duan <fugang.duan@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH 1/4] clk: imx8mn: A53 core clock no need to be critical
Thread-Topic: [PATCH 1/4] clk: imx8mn: A53 core clock no need to be critical
Thread-Index: AQHV67lXcMqetl8NvkmUcnxVH88LyKgrnAKA
Date:   Tue, 25 Feb 2020 08:58:22 +0000
Message-ID: <65500dc7-dc03-7dc1-92cd-5557cd73232e@nxp.com>
References: <1582620554-32689-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1582620554-32689-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d4198b2b-ecc6-48a4-7c8c-08d7b9d0dde1
x-ms-traffictypediagnostic: VI1PR0402MB3421:|VI1PR0402MB3421:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0402MB3421F452E929302AA445F14BF9ED0@VI1PR0402MB3421.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2089;
x-forefront-prvs: 0324C2C0E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(39860400002)(396003)(136003)(376002)(346002)(199004)(189003)(81156014)(66476007)(81166006)(66446008)(8936002)(64756008)(66946007)(66556008)(8676002)(36756003)(71200400001)(5660300002)(6512007)(4326008)(6486002)(31696002)(316002)(478600001)(110136005)(6506007)(2906002)(86362001)(53546011)(26005)(44832011)(186003)(2616005)(76116006)(31686004)(921003)(32563001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3421;H:VI1PR0402MB3839.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qN4bNajEPX8MOjMV/2T4o4cGJ7DLghmgmyQhpB79REb+Yaa8OfUUX4eF+fDjAZASdF4khX3rqZ5uxXc9eQE9FX42anGrfabKQomAXv1f9hBMyOeaEKQ6/2hceMi/JYZyv0yYoDkxHEVw+rdAbkJ1z3fCdECgl4PTxOpmMXiS81jfie5kfFEEC+KqiT9rqCqRKrWQPJrevfHMKtmkWEL19SPfmrEenDDlZHGBbfmBLD9hjsXqxTOxEBA6gRpUQrR72IqzcvQySw+C25dARMGJrj88+TxcwyKxcl7QZg/+uxL69BY5RHV/pacefHVYrsylw+K6SSCN2EjUze6H21Cph5NB7nsPHyDwGc29jWf7c6cSPfvtbdqvxw/M2KPQnHeXgrPlOIzT3qhr8KR7uQvTdnnTkxMVgjV1B76X8P6gjMzxm73TmASHxtX4LJUIEnl6rGtYgDe+3FNXnj2uAa6NqLHsE7EdJqJONzf2qyN22pD4Pl+wNX4f3U25aLRzbRA4OFsVb2QeKGA+ms3ZxCCrCg==
x-ms-exchange-antispam-messagedata: qmz/zjxbS29gD4VpO6rYS9/Nq63EDqpl+tkfMg1VtmW66So/Z9H6Ptkr5qHt9mw2epeBalCCyMAmEQEHiPU2uutLMSE5WPutnXUSfKSP1Chcpct6UUQXK2I7gKspio6ki8wCCza1QOZdOYaFRNMMLg==
Content-Type: text/plain; charset="utf-8"
Content-ID: <CA91AB0ACE7DDD40B5448B9D95081730@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4198b2b-ecc6-48a4-7c8c-08d7b9d0dde1
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2020 08:58:22.1473
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: otwt8jGAEo+f9AuAw7hlPxtOmqgM4Mtkwgcxh692DxYkXUXo2+IsjTEGYbQQCa0QuqA1HIvgOWPsGua65iuaMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3421
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5zb24sDQoNCk9uZSBjb21tZW50IGlubGluZToNCg0KT24gMjUuMDIuMjAyMCAxMDo0OSwg
QW5zb24gSHVhbmcgd3JvdGU6DQo+ICdBNTNfQ09SRScgaXMganVzdCBhIG11eCBhbmQgbm8gbmVl
ZCB0byBiZSBjcml0aWNhbCwgYmVpbmcgY3JpdGljYWwNCj4gd2lsbCBjYXVzZSBpdHMgcGFyZW50
IGNsb2NrIGFsd2F5cyBPTiB3aGljaCBkb2VzIE5PVCBtYWtlIHNlbnNlLA0KPiB0byBtYWtlIHN1
cmUgQ1BVJ3MgaGFyZHdhcmUgY2xvY2sgc291cmNlIE5PVCBiZWluZyBkaXNhYmxlZCBkdXJpbmcN
Cj4gY2xvY2sgdHJlZSBzZXR1cCwgbmVlZCB0byBtb3ZlIHRoZSAnQTUzX1NSQycvJ0E1M19DT1JF
JyByZXBhcmVudA0KPiBvcGVyYXRpb25zIHRvIGFmdGVyIGNyaXRpY2FsIGNsb2NrICdBUk1fQ0xL
JyBzZXR1cCBmaW5pc2hlZC4NCj4NCj4gU2lnbmVkLW9mZi1ieTogQW5zb24gSHVhbmcgPEFuc29u
Lkh1YW5nQG54cC5jb20+DQo+IC0tLQ0KPiAgIGRyaXZlcnMvY2xrL2lteC9jbGstaW14OG1uLmMg
fCA4ICsrKystLS0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgNCBkZWxl
dGlvbnMoLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL2lteC9jbGstaW14OG1uLmMg
Yi9kcml2ZXJzL2Nsay9pbXgvY2xrLWlteDhtbi5jDQo+IGluZGV4IDgzNjE4YWYuLjBiYzcwNzAg
MTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvY2xrL2lteC9jbGstaW14OG1uLmMNCj4gKysrIGIvZHJp
dmVycy9jbGsvaW14L2Nsay1pbXg4bW4uYw0KPiBAQCAtNDI4LDcgKzQyOCw3IEBAIHN0YXRpYyBp
bnQgaW14OG1uX2Nsb2Nrc19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAg
IAlod3NbSU1YOE1OX0NMS19HUFVfU0hBREVSX0RJVl0gPSBod3NbSU1YOE1OX0NMS19HUFVfU0hB
REVSXTsNCj4gICANCj4gICAJLyogQ09SRSBTRUwgKi8NCj4gLQlod3NbSU1YOE1OX0NMS19BNTNf
Q09SRV0gPSBpbXhfY2xrX2h3X211eDJfZmxhZ3MoImFybV9hNTNfY29yZSIsIGJhc2UgKyAweDk4
ODAsIDI0LCAxLCBpbXg4bW5fYTUzX2NvcmVfc2VscywgQVJSQVlfU0laRShpbXg4bW5fYTUzX2Nv
cmVfc2VscyksIENMS19JU19DUklUSUNBTCk7DQo+ICsJaHdzW0lNWDhNTl9DTEtfQTUzX0NPUkVd
ID0gaW14X2Nsa19od19tdXgyKCJhcm1fYTUzX2NvcmUiLCBiYXNlICsgMHg5ODgwLCAyNCwgMSwg
aW14OG1uX2E1M19jb3JlX3NlbHMsIEFSUkFZX1NJWkUoaW14OG1uX2E1M19jb3JlX3NlbHMpKTsN
Cj4gICANCj4gICAJLyogQlVTICovDQo+ICAgCWh3c1tJTVg4TU5fQ0xLX01BSU5fQVhJXSA9IGlt
eDhtX2Nsa19od19jb21wb3NpdGVfY3JpdGljYWwoIm1haW5fYXhpIiwgaW14OG1uX21haW5fYXhp
X3NlbHMsIGJhc2UgKyAweDg4MDApOw0KPiBAQCAtNTU5LDE1ICs1NTksMTUgQEAgc3RhdGljIGlu
dCBpbXg4bW5fY2xvY2tzX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICAg
DQo+ICAgCWh3c1tJTVg4TU5fQ0xLX0RSQU1fQUxUX1JPT1RdID0gaW14X2Nsa19od19maXhlZF9m
YWN0b3IoImRyYW1fYWx0X3Jvb3QiLCAiZHJhbV9hbHQiLCAxLCA0KTsNCj4gICANCj4gLQljbGtf
aHdfc2V0X3BhcmVudChod3NbSU1YOE1OX0NMS19BNTNfU1JDXSwgaHdzW0lNWDhNTl9TWVNfUExM
MV84MDBNXSk7DQo+IC0JY2xrX2h3X3NldF9wYXJlbnQoaHdzW0lNWDhNTl9DTEtfQTUzX0NPUkVd
LCBod3NbSU1YOE1OX0FSTV9QTExfT1VUXSk7DQoNCg0KV2h5IGRvIHlvdSBuZWVkIHRvIG1vdmUg
dGhpcyBjb2RlPyBJZiB0aGVyZSBpcyBhIHJlYXNvbiBwbGVhc2UgYWRkIGEgDQpzZXBhcmF0ZSBw
YXRjaCBhbmQgZXhwbGFpbiB3aHkuDQoNCj4gLQ0KPiAgIAlod3NbSU1YOE1OX0NMS19BUk1dID0g
aW14X2Nsa19od19jcHUoImFybSIsICJhcm1fYTUzX2NvcmUiLA0KPiAgIAkJCQkJICAgaHdzW0lN
WDhNTl9DTEtfQTUzX0NPUkVdLT5jbGssDQo+ICAgCQkJCQkgICBod3NbSU1YOE1OX0NMS19BNTNf
Q09SRV0tPmNsaywNCj4gICAJCQkJCSAgIGh3c1tJTVg4TU5fQVJNX1BMTF9PVVRdLT5jbGssDQo+
ICAgCQkJCQkgICBod3NbSU1YOE1OX0NMS19BNTNfRElWXS0+Y2xrKTsNCj4gICANCj4gKwljbGtf
aHdfc2V0X3BhcmVudChod3NbSU1YOE1OX0NMS19BNTNfU1JDXSwgaHdzW0lNWDhNTl9TWVNfUExM
MV84MDBNXSk7DQo+ICsJY2xrX2h3X3NldF9wYXJlbnQoaHdzW0lNWDhNTl9DTEtfQTUzX0NPUkVd
LCBod3NbSU1YOE1OX0FSTV9QTExfT1VUXSk7DQo+ICsNCj4gICAJaW14X2NoZWNrX2Nsa19od3Mo
aHdzLCBJTVg4TU5fQ0xLX0VORCk7DQo+ICAgDQo+ICAgCXJldCA9IG9mX2Nsa19hZGRfaHdfcHJv
dmlkZXIobnAsIG9mX2Nsa19od19vbmVjZWxsX2dldCwgY2xrX2h3X2RhdGEpOw0KDQoNCg==
