Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A1EC3B186
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 09:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A93AA2173E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 09:15:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jmvOrXfs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728738AbgBLJPv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 04:15:51 -0500
Received: from mail-eopbgr80078.outbound.protection.outlook.com ([40.107.8.78]:47286
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728150AbgBLJPv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 04:15:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PQ+djMYHbRnDzBklzjYrsYr0aSIDNRYXEnwzR3VEYrS8fM1DDI6V2HeqTPedOaYvxLcPdhGlAu8N1x0V3frZ77omSUlju74y9Tt0zxrVVwF0Yk1I865qVKF+s2ygVWQbaEdukZIlRRsBgl9ZeHdbVt0NsU/QYhkM37+phZ1RQNuSxnx9l88mCpuM5jk/rLDirF0zwZneMDsDYI0jD/P19jaIhBymWpler7TXqTdfa1mepvUZYWPloRQR2AAdd/BT+ncY1uYCu4O6M4DY8c0pg8C+mG2+aDW8hbYPNZTa/35e6AQVYldEue5pUgywLtKt3M5qHFXFvb2W48ug51wnDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HAIEf/+QyeiIQ+a1ZNt/mhUOdaMd61SzsLmGoU7+FHU=;
 b=ZNPOGWsSJOt0/H3kqIajMdKKY+RLEoUPP1RqtJg4IiorwPpaTIXMR8Ym9qy9gs2aoZSSNzf/r1aEFZC73qdRYsT5NY9+CNZpr15TBOfX55tG+xyLWbRqcGuvlIw6WAUys78PTlo5QAV95H3rWlZcZMHZHDbJbmo+wId/1/T1vbvPGUBv1I+qzzj7Hd3X2zHEytYcO+Z9NmrOGZRPeko+tbExvoY2odsuyWtclAzoOEFSKhKaJp04qzABMnbPxbTKqLLQCRxWtP6IfdH/Vt0DlBh/lsu4hojMvLEv4GQsFTWx5+WHuVs1B1yK7oBxmklrR4ZrT7A4YcH1LbO5fO8Mlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HAIEf/+QyeiIQ+a1ZNt/mhUOdaMd61SzsLmGoU7+FHU=;
 b=jmvOrXfsqMyx3vIHjxZGLhrLxBnCnFiLhSDKWryg2gkoP2K5K9cNGn3ZszGZbp5cy4pMJNRcGIpnCCC5jypBNp+ZzCHWGolRXlVwyJbbmoy3Ij9nrZTq4XlSjBKpPEsJOETYqI09XRuRja8/tHEWsVzI5VipVRHo+mrspuwNCdo=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3947.eurprd04.prod.outlook.com (52.134.67.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.23; Wed, 12 Feb 2020 09:15:47 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e44d:fa34:a0af:d96]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e44d:fa34:a0af:d96%5]) with mapi id 15.20.2729.021; Wed, 12 Feb 2020
 09:15:47 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Peng Fan <peng.fan@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "aford173@gmail.com" <aford173@gmail.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Jun Li <jun.li@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] arm64: dts: imx8mm: Remove redundant interrupt-parent
 assignment
Thread-Topic: [PATCH] arm64: dts: imx8mm: Remove redundant interrupt-parent
 assignment
Thread-Index: AQHV4XW+d5C7DyyLjk2aRizRdCCKcqgXKOqAgAAeCLA=
Date:   Wed, 12 Feb 2020 09:15:47 +0000
Message-ID: <DB3PR0402MB3916BC592914EC3387D457D2F51B0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1581492049-23523-1-git-send-email-Anson.Huang@nxp.com>
 <AM0PR04MB4481546EFDF5A53078F1A385881B0@AM0PR04MB4481.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB4481546EFDF5A53078F1A385881B0@AM0PR04MB4481.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ae7ef57b-da43-4cec-45bd-08d7af9c2587
x-ms-traffictypediagnostic: DB3PR0402MB3947:|DB3PR0402MB3947:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB3947255F7536C435D1057297F51B0@DB3PR0402MB3947.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0311124FA9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(136003)(366004)(396003)(346002)(189003)(199004)(5660300002)(26005)(7416002)(8676002)(66556008)(33656002)(7696005)(186003)(8936002)(2906002)(66946007)(66446008)(64756008)(66476007)(81166006)(9686003)(966005)(44832011)(55016002)(76116006)(81156014)(4326008)(86362001)(71200400001)(52536014)(478600001)(6506007)(316002)(110136005)(32563001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3947;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wp/zwWvaK8ZFFntZpqXADo/rcw4Relq5r+YvTQ+NhPAj1ULoGb5agkCC0v8ezaNa+1z/oyPbRms8qpPpDYnlB5VhUTGKGk5KXHAf+qHXmQpMl3XNPtQTk7qB4EJU6wdb3sIFZPZ8Hlw5gPV81njPAPEc4/K7cNKT36ev4+xmueSeYkdokyBqWlBL1jMhaB1PVA6Zx3nKO1geYLmFlvXy5l/iocIWdVzk16grm+sH8Z6FcnGQOQZiNNZDI1ZbNQefhZ81cLaIgIGrnoNk7L96OynbbrYN/9ZpUhM52sbZO2ACW5+lREl1mnQtp1bM8R7ZkEVqVJ1dk4DAwh3ZF+NQAC/AT/j/N67FoT81BT/bu3TdcttGmO/uqDHq7UUn0jU0fwjrircllfVyRGIUE4Rn66OnBJFX76oQhx0KB6Lc23uAahthBbV0WxWyy+5/N0i6/S46FF9OY1IqZx4p8eQZIwaBgI0w5YjTQWIr5SMMU7MTz6gapoTPUcodOCovtmavEF08JnDCK2laPyz2MHkTmXF/4fLz+QnBzMLtEzXiYUUPTsEX3K/cLp4dhnuAYTBG5CAJff1VIi6V4AlN0UaW6kItmlVzkawRQa/tWHTnYds=
x-ms-exchange-antispam-messagedata: vpPGYoSZ/yX3Y/iIb+Prbf2mxf5uSeps2Vo2JtRNSVohDx4YFRwiiuN21oG2++zXQbYRtC87AESg8hYMf5WUVhIDYGjFgwJ3TZybixr1G4ONlMyJej7yExARaaKXjG8ezSXqPFz/2zAnfKhlDujM2g==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae7ef57b-da43-4cec-45bd-08d7af9c2587
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2020 09:15:47.3406
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G/380cPs8RXY781KuVd/+PQc+0FD29QlBwtNvJyAMLZ3dqQDhWC2qc80jh+2m5MfmTQnlMcHFeJVc8sKAzvfbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3947
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gU3ViamVjdDogUkU6IFtQQVRDSF0gYXJtNjQ6IGR0czogaW14OG1tOiBSZW1vdmUgcmVk
dW5kYW50IGludGVycnVwdC0NCj4gcGFyZW50IGFzc2lnbm1lbnQNCj4gDQo+IEhpIEFuc29uLA0K
PiANCj4gPiBTdWJqZWN0OiBbUEFUQ0hdIGFybTY0OiBkdHM6IGlteDhtbTogUmVtb3ZlIHJlZHVu
ZGFudCBpbnRlcnJ1cHQtcGFyZW50DQo+ID4gYXNzaWdubWVudA0KPiANCj4gVGhlcmUgaXMgYWxy
ZWFkeSBhIHBhdGNoOiBodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3BhdGNoLzExMzQwNjEz
Lw0KDQoNClRoYW5rcyBmb3Igbm90aWNlLCBwbGVhc2UgaWdub3JlIHRoaXMgcGF0Y2ggdGhlbi4N
Cg0KQW5zb24uDQoNCg0KPiANCj4gVGhhbmtzLA0KPiBQZW5nLg0KPiANCj4gPg0KPiA+IEdJQyBp
cyBhc3NpZ25lZCBhcyBpbnRlcnJ1cHQtcGFyZW50IGJ5IGRlZmF1bHQsIG5vIG5lZWQgdG8gYXNz
aWduIGl0DQo+ID4gYWdhaW4gaW4gZGRyLXBtdSBub2RlLCByZW1vdmUgaXQuDQo+ID4NCj4gPiBT
aWduZWQtb2ZmLWJ5OiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4gPiAtLS0N
Cj4gPiAgYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1tLmR0c2kgfCAxIC0NCj4g
PiAgMSBmaWxlIGNoYW5nZWQsIDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9h
cmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bW0uZHRzaQ0KPiA+IGIvYXJjaC9hcm02
NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1tLmR0c2kNCj4gPiBpbmRleCAxZTVlMTE1Li5iM2Qw
YjI5IDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDht
bS5kdHNpDQo+ID4gKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1tLmR0
c2kNCj4gPiBAQCAtODk2LDcgKzg5Niw2IEBADQo+ID4gIAkJZGRyLXBtdUAzZDgwMDAwMCB7DQo+
ID4gIAkJCWNvbXBhdGlibGUgPSAiZnNsLGlteDhtbS1kZHItcG11IiwgImZzbCxpbXg4bS0NCj4g
ZGRyLXBtdSI7DQo+ID4gIAkJCXJlZyA9IDwweDNkODAwMDAwIDB4NDAwMDAwPjsNCj4gPiAtCQkJ
aW50ZXJydXB0LXBhcmVudCA9IDwmZ2ljPjsNCj4gPiAgCQkJaW50ZXJydXB0cyA9IDxHSUNfU1BJ
IDk4IElSUV9UWVBFX0xFVkVMX0hJR0g+Ow0KPiA+ICAJCX07DQo+ID4gIAl9Ow0KPiA+IC0tDQo+
ID4gMi43LjQNCg0K
