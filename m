Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6448C5ACC1
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 10:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75A2F2051A
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 10:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Y1hSTzGh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730526AbgCPKEi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 06:04:38 -0400
Received: from mail-db8eur05on2072.outbound.protection.outlook.com ([40.107.20.72]:6031
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730468AbgCPKEi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 06:04:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hwJOj4TqVN3fy7uz2z8NR8X51L63BHTz0Sgd1kOQzP/+2H5mF4xS29am9QbmCzv0C/dm3XVPWJ1EuGf2Ef0xhDEyp6oazgFQb0Iomv4sLS7m3+L9CGtV/hqpoHMMNStQDMhZlQiH1oW8dC17Ou5cy5oLaLxMFOjIaLta0gTqoG+rAXmD5ZLpP9xD+ZhJzsTm6uSoHJNPBiB226FTDr94TTi8iXGhE54IBt9p1785g440Q0Gg1g12QnU+CpUg/28Fzde8kOrGS+2dj4Musf1/BycC3WW5AYn04iK3ZaZfhtm4E2RnpMNMQJzoNQSFW7C8x0G6K3AESgf/dlQfPPnWkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SBUUHG5Ozi+m8kCqRE6r2bDW+Rrkk5RR/zz3f5abcXU=;
 b=jxSYALj0Vw/RbSxYRl99M5vbZ8AYFM4fxzTGcB/ZFLL/rnJxi/FzUS4bZjlsfDAHctpOXVunENBcwuxk4KyQFmEFqZDKhKMQ07GOrvCPnqVNE5j+bOX3ZtyZ9kTDhyNWt432IcMghJo1XOoRyAzE4i/zAawWU3SCgojLmVurSIzja3qrcgGE6CeWscJ1NAVs4jIyfpoBL3w1g6/FR1EWGdvy7rku/ijXPP7LFH8LDxc8q9+DeaRBGeiEX+AnXg1OinR9sN81HOeR/xm2H6kSaU/y4sITFo4nGg5EPuzd1prml13cBfN+MjvvGR+6bAYeBP3To7P2abRW0mlSjM/9FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SBUUHG5Ozi+m8kCqRE6r2bDW+Rrkk5RR/zz3f5abcXU=;
 b=Y1hSTzGhZ5ioxwugjb4jSJI2n60W6MCKzFK+nXcRoU7rt+CiDub0QWB759z+qnEpJYfKWqg/8JJm6pk+ZlnJ4s/9fp8QnKGiyEHZMfli7xETyGoayWqu6QFPZRwbPSONg8IiuBri0moeAeqTaCbvIbXHNW13ZCDTf/UdFXNM9AE=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.92.158) by
 AM0PR04MB7137.eurprd04.prod.outlook.com (10.186.130.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.21; Mon, 16 Mar 2020 10:04:34 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::8cb2:6bfa:b5bc:2ae3]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::8cb2:6bfa:b5bc:2ae3%7]) with mapi id 15.20.2814.021; Mon, 16 Mar 2020
 10:04:34 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>, Anson Huang <anson.huang@nxp.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V2 1/2] arm64: dts: imx8qxp-mek: Sort labels
 alphabetically
Thread-Topic: [PATCH V2 1/2] arm64: dts: imx8qxp-mek: Sort labels
 alphabetically
Thread-Index: AQHV+zLkFHZY0iZYO0qE2+EkfrOYNKhKufmAgAAIpICAAAPNgIAANbiw
Date:   Mon, 16 Mar 2020 10:04:34 +0000
Message-ID: <AM0PR04MB4211C02DF855F3444A839FC880F90@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1584321993-8642-1-git-send-email-Anson.Huang@nxp.com>
 <20200316060024.GG17221@dragon>
 <DB3PR0402MB3916C7F4D25024A30FF4EABDF5F90@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <20200316064456.GJ17221@dragon>
In-Reply-To: <20200316064456.GJ17221@dragon>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5e41bcd7-4d5d-480e-6cbe-08d7c9916ded
x-ms-traffictypediagnostic: AM0PR04MB7137:|AM0PR04MB7137:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB7137D0D0BFEDAA2AD6F16E3880F90@AM0PR04MB7137.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2512;
x-forefront-prvs: 03449D5DD1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(376002)(366004)(396003)(136003)(199004)(2906002)(33656002)(4326008)(966005)(6636002)(66946007)(478600001)(66556008)(66476007)(64756008)(66446008)(86362001)(76116006)(316002)(186003)(6506007)(110136005)(54906003)(5660300002)(81166006)(7696005)(9686003)(8936002)(71200400001)(55016002)(8676002)(44832011)(81156014)(52536014)(26005)(32563001)(473944003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB7137;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1brpO2Oie0oY4ofxrdXF5m5/1+yIDFN8cjpzvL0tFOs8SWX9c+HMn3LApsPAslmx90+/vKpbOH8xIASPyQ/G00zdbUPMrsmoD5W1nBPUW5UEAVd/PnE+7o4HjPt0J52VR9RLd/yRrWIbJP8Nh9LnreLpWapQoHK9LkSe5TFQb0nG3q98KF8K4BnY8Q0Al1wCJXpXbcMoWvzolVbEQoYloniVqbKvhwCMfsTxTwH6MqdI1lWScbfI/unhIntSRge12vysAR/jNA1ja80skv0petNpnRAmJErjYVeYf1prJDRj13h4yWyhbxNHTgYEIEY//7YrCOeY/Yor03w+R22qYPFpTMRAezh3zsDKdrHOeTxtOGIi72caYiffzZzdHdjUbl+houOhsfX/BuM8HozJGjZ8/CwLThpXDgf76A07Ry7mMlx2p+jQFqov9+0oQxLiToR6C8Y8GoF8Wv8OLCSjOQXfyPhyICC/SCsJzWKl0MmBeZHZNRcBnEsCrijj/roZs7I49k39+v3cDsWRY6Wb5LDRucIlxwd/YmPs5vdNdVtLB/VFw8gdxsYXgOHoJBLqFxSTmVU2+Pbh8381LcIleF/AoYkgAvbfipeStqOYjfI=
x-ms-exchange-antispam-messagedata: YbWD0fyY0En++7+hLIfuM/vHlYAhfhtfPpCf9EEJ5eeFYsJVtXRILKmJNjzsaUO9T6QLcMn62dIobn1rMG+xVIFHYuPTkn4TuIQziGYj+6SxiOVNlEmq0biVnPIi1BuCj4xi6RnmWqIwjbtGj3QOOw==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e41bcd7-4d5d-480e-6cbe-08d7c9916ded
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2020 10:04:34.7242
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kf8f1HC8MHrE1lIPuXn6l8lN1NJNCoYRstwSuGqNApTo/ZHrupAao1AJ6sj4jKe81KmIDJQIVCT3uLokFVHVgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7137
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBTaGF3biBHdW8gPHNoYXduZ3VvQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IE1vbmRheSwg
TWFyY2ggMTYsIDIwMjAgMjo0NSBQTQ0KPiANCj4gT24gTW9uLCBNYXIgMTYsIDIwMjAgYXQgMDY6
MzE6MjFBTSArMDAwMCwgQW5zb24gSHVhbmcgd3JvdGU6DQo+ID4gSGksIFNoYXduDQo+ID4NCj4g
PiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjIgMS8yXSBhcm02NDogZHRzOiBpbXg4cXhwLW1lazog
U29ydCBsYWJlbHMNCj4gPiA+IGFscGhhYmV0aWNhbGx5DQo+ID4gPg0KPiA+ID4gT24gTW9uLCBN
YXIgMTYsIDIwMjAgYXQgMDk6MjY6MzJBTSArMDgwMCwgQW5zb24gSHVhbmcgd3JvdGU6DQo+ID4g
PiA+IFNvcnQgdGhlIGxhYmVscyBhbHBoYWJldGljYWxseSBmb3IgY29uc2lzdGVuY3kuDQo+ID4g
PiA+DQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEFuc29uIEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAu
Y29tPg0KPiA+ID4gPiAtLS0NCj4gPiA+ID4gQ2hhbmdlcyBzaW5jZSBWMToNCj4gPiA+ID4gCS0g
UmViYXNlIHRvIGxhdGVzdCBicmFuY2gsIG5vIGNvZGUgY2hhbmdlLg0KPiA+ID4gPiAtLS0NCj4g
PiA+ID4gIGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhxeHAtbWVrLmR0cyB8IDUw
DQo+ID4gPiA+ICsrKysrKysrKysrKysrKystLS0tLS0tLS0tLQ0KPiA+ID4gPiAgMSBmaWxlIGNo
YW5nZWQsIDMwIGluc2VydGlvbnMoKyksIDIwIGRlbGV0aW9ucygtKQ0KPiA+ID4gPg0KPiA+ID4g
PiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OHF4cC1tZWsu
ZHRzDQo+ID4gPiA+IGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OHF4cC1tZWsu
ZHRzDQo+ID4gPiA+IGluZGV4IGQzZDI2Y2MuLmIxYmVmZGIgMTAwNjQ0DQo+ID4gPiA+IC0tLSBh
L2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhxeHAtbWVrLmR0cw0KPiA+ID4gPiAr
KysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4cXhwLW1lay5kdHMNCj4gPiA+
ID4gQEAgLTMwLDE4ICszMCw3IEBADQo+ID4gPiA+ICAJfTsNCj4gPiA+ID4gIH07DQo+ID4gPiA+
DQo+ID4gPiA+IC0mYWRtYV9scHVhcnQwIHsNCj4gPiA+ID4gLQlwaW5jdHJsLW5hbWVzID0gImRl
ZmF1bHQiOw0KPiA+ID4gPiAtCXBpbmN0cmwtMCA9IDwmcGluY3RybF9scHVhcnQwPjsNCj4gPiA+
ID4gLQlzdGF0dXMgPSAib2theSI7DQo+ID4gPiA+IC19Ow0KPiA+ID4gPiAtDQo+ID4gPiA+IC0m
ZmVjMSB7DQo+ID4gPiA+IC0JcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsNCj4gPiA+ID4gLQlw
aW5jdHJsLTAgPSA8JnBpbmN0cmxfZmVjMT47DQo+ID4gPiA+IC0JcGh5LW1vZGUgPSAicmdtaWkt
aWQiOw0KPiA+ID4gPiAtCXBoeS1oYW5kbGUgPSA8JmV0aHBoeTA+Ow0KPiA+ID4gPiAtCWZzbCxt
YWdpYy1wYWNrZXQ7DQo+ID4gPiA+ICsmYWRtYV9kc3Agew0KPiA+ID4gPiAgCXN0YXR1cyA9ICJv
a2F5IjsNCj4gPiA+ID4NCj4gPiA+ID4gIAltZGlvIHsNCj4gPiA+DQo+ID4gPiBIZXJlIGlzIGEg
cmViYXNlIGlzc3VlLCBpLmUuIGFkbWFfZHNwIHNob3VsZG4ndCBnZXQgYSBtZGlvIGNoaWxkIG5v
ZGUuDQo+ID4gPiBJdCBjYW1lIGZyb20gdGhlIGNvbmZsaWN0IHdpdGggb25lIGNvbW1pdCBvbiBt
eSBmaXhlcyBicmFuY2guICBJDQo+ID4gPiBkZWNpZGVkIHRvIGRyb3AgdGhlIHNlcmllcyBmb3Ig
dGhlIGNvbWluZyBtZXJnZSB3aW5kb3cuICBMZXQncyBzdGFydA0KPiA+ID4gb3ZlciBhZ2FpbiBh
ZnRlcg0KPiA+ID4gNS43LXJjMSBiZWNvbWVzIGF2YWlsYWJsZS4NCj4gPg0KPiA+IE9LLCBJIGFt
IGFsc28gY29uZnVzZWQgYnkgdGhpcyBjb25mbGljdCwgSSBub3JtYWxseSBkbyB0aGUgcGF0Y2gg
YmFzZWQNCj4gPiBvbiB5b3VyIGZvci1uZXh0IGJyYW5jaCwgYW5kIEkgZGlkIE5PVCBtZWV0IHRo
ZSBjb25mbGljdCBhdCBhbGwsIHRoZW4NCj4gPiBJIHJlZG8gaXQgYmFzZWQgb24geW91ciBkdCBi
cmFuY2ggSSBtZXQgdGhlIGNvbmZsaWN0IGFuZCBmaXggaXQuLi4NCj4gPg0KPiA+IFNvLCBkbyBJ
IG5lZWQgdG8gcmVzZW5kIHRoZSBwYXRjaCBzZXJpZXMgbGF0ZXIgd2hlbiA1LjctcmMxIGF2YWls
YWJsZT8NCj4gDQo+IFlvdSBuZWVkIHRvIHJlc2VuZCBsYXRlci4NCg0KSGkgU2hhd24sDQoNCkNv
dWxkIHdlIGhvbGQgb24gdGhpcyBwYXRjaCBhcyBzdWJzeXMgcHJlZml4IChlLmcgYWRtYV8pIHdp
bGwgYmUgcmVtb3ZlZCBsYXRlciBhbmQNCmRldmljZXMgd2lsbCBiZSBlbWJlZGRlZCBpbnRvIGVh
Y2ggc3Vic3lzIGR0c2k/DQpTbyB0aGlzIHJlLW9yZGVyIG1heSBiZWNvbWUgbWVhbmluZ2xlc3Mg
d2hpY2ggYWxzbyBwb3RlbnRpYWxseSBjYXVzZSBhIGxvdCB0cm91Ymxlcw0Kb24gdGhlIHJlYmFz
ZSBvZiB0aGUgZHRzIHJlLW9yZyBwYXRjaDoNCltSRVNFTkQsdjMsMDAvMTVdIGFybTY0OiBkdHM6
IGlteDg6IGFyY2hpdGVjdHVyZSBpbXByb3ZlbWVudCBhbmQgYWRkaW5nIGlteDhxbSBzdXBwb3J0
DQpodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL2NvdmVyLzExMjQ4MjcxLw0KDQpSZWdhcmRz
DQpBaXNoZW5nDQoNCj4gDQo+IFNoYXduDQo=
