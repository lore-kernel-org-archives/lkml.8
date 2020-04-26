Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2FD1C55191
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 03:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 995482070A
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 03:51:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Yt/aoh6P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbgDZDvo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 23:51:44 -0400
Received: from mail-eopbgr40089.outbound.protection.outlook.com ([40.107.4.89]:14400
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726001AbgDZDvn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 23:51:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jqE98cPLBTXLKkNOMt+Y0Ufzu2wihg9QFI4ibRGU1CBMM6d0FE9IYVH6nDCWZTZZD6G1ROI0MQn9C2nlNJvx4HwPN7/NI8ynBRTlPmCkZn/N7DwIVzxHfURemIgbCGDEH7EooC3shAtD2jKToRrMWJDdsQTiA4ZcNhLfO6myzyWgPFKMWVlGZivxn2/ufhsnaIxSX2+Cv2sBhyL5wojnQ8EyyCPSCRmPOtaxUPELqY49m5zM5r1h9rcjudeiiW6gX9J5CzVwzPnJFWcStU/Q90MOlcGdyxb6zLQhNFwi99+2ovrqzytVmlhYhJFGCJbZRuTVhIrQsStoqZ1CUOr5/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ysgr1oE8kwAfdgxxxpOfehNix3vo5ZDLXS5bmOhxZA0=;
 b=UwhqZAcw1litNJjPt5CHfyH3f85/3DVK9VKBYJ6WFHHdmTwUSDTx2QhX0QvF4KJY5uhPTQy4BlxHFCbfJTu2Sv1l9NFgOLv+JJEhAuFXeGmTiw/QhVq1U90h3r/0ygO6TzeSKJxi5t6J/B1xs4stG/ag6TNcWOt2fVpjsr/TLfRW73EyFtNsiivOh3kItm7CGfMLR0l/EAiNufGo8cpWA22jVBSFnKdMC9H3zQ6Fj5PXnCFA1Isu1G+jFFfn5d5lY9Noj7A9BlJb5OXpRmZqAp5/sK5r4iNxwcxVu2SXGRUJ+mjUqV/jc5IRXT3v/q9T/HSJyeyka1cpugGN5if4MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ysgr1oE8kwAfdgxxxpOfehNix3vo5ZDLXS5bmOhxZA0=;
 b=Yt/aoh6PWqaM/cundvkGuzhYTrcwAI1ToCC0mWwwVJB3+YX+jPym6m33Zex1vVA6IM0ZvWCOwZ3L1dObvrlUAnmE/SCxWiZ6QTvUoiNSKYekf6DLMPNNzGQU6zrk4ZXaloWZOc9gQhJRxYRe4YTQrIZyJQ0bMCYuK1iSVYWYyIU=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR04MB5478.eurprd04.prod.outlook.com (2603:10a6:20b:97::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Sun, 26 Apr
 2020 03:51:39 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::d9f7:5527:e89d:1ae3]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::d9f7:5527:e89d:1ae3%7]) with mapi id 15.20.2937.020; Sun, 26 Apr 2020
 03:51:39 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Peng Fan <peng.fan@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anson Huang <anson.huang@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "aford173@gmail.com" <aford173@gmail.com>,
        Jacky Bai <ping.bai@nxp.com>, Jun Li <jun.li@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        "angus@akkea.ca" <angus@akkea.ca>,
        "heiko@sntech.de" <heiko@sntech.de>,
        Andy Duan <fugang.duan@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: RE: [PATCH V2 01/10] arm64: dts: imx8m: assign clocks for A53
Thread-Topic: [PATCH V2 01/10] arm64: dts: imx8m: assign clocks for A53
Thread-Index: AQHV+Fi3TCc+ShM16kOvHnoU4uoIS6iLCmAw
Date:   Sun, 26 Apr 2020 03:51:38 +0000
Message-ID: <AM6PR04MB496640B6A28BBD8F491EB1C980AE0@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <1584008384-11578-1-git-send-email-peng.fan@nxp.com>
 <1584008384-11578-2-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1584008384-11578-2-git-send-email-peng.fan@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [218.82.155.143]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 242cbd64-8eb5-4d64-3583-08d7e9951fea
x-ms-traffictypediagnostic: AM6PR04MB5478:|AM6PR04MB5478:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB547856A0AB3DB4BF35D53C5C80AE0@AM6PR04MB5478.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 03853D523D
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(396003)(366004)(136003)(346002)(376002)(9686003)(110136005)(4326008)(55016002)(7416002)(186003)(8676002)(86362001)(5660300002)(52536014)(6506007)(7696005)(44832011)(6636002)(2906002)(54906003)(66476007)(66946007)(316002)(478600001)(64756008)(66556008)(8936002)(66446008)(33656002)(81156014)(76116006)(26005)(71200400001)(32563001);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pJDk36fUdnEvHoY5FNA71gJpb+L7hjaVhOCbnLwSCmUhFclTaDPJPIP0ABy6sO2YFMPdZH0r5k2fKTiYus5o9ztlz4etup/mqzOd3wEzO5/vih+WTT5Z77bf1S9BGS2ta3hYMFHLP7CRuJdcphYpb5Q5Jw1XZuYRs4q8EPq6GNYJ5lsDgsjSqnT1OzYKjP1KoBCu2O46iX3E+8/9c0pLmjakfgoL0IgxPzGTCNbH6mYefChIQfTWWT/fVGR6Z6WME2FlL+AzBWgCOFY5E+sCnQZLli9qzYbSbPVdm7roP/En2FxvbZenQrstPSE32EAT6TmungFwVFUcUW8TytkTzdo9W2YjJXIjybXsDyEVo23gZaZoHl43heT/ey2eXz4vSyZCMK0GN41RT8X/g2+U2/emlI8sgi5YUoD6tOeHpkUoh/l3lmvAert+barC6wV+Xu4hl86F7q7cdV3AaXPwPTDoa1dD4z/k4knCFf7b5uvBt1UtfCMylkiE9aNs20yC
x-ms-exchange-antispam-messagedata: 8+NdaKTiPg3ql+/3vV0uxcz4h6610tMn/qbKiTG/eqQOmumHT8XezL42EdBJRwf/MqFYfEbWL1hWVStx11chK8SykuSMuc8Fv6q1+P/kxBeMFoWrUt5Vi6g+Kn79NKVsXjdgo6tLywE7sAKvbMPNJangnIALUftYE+rvh0z4a0E3HcRxgAL9NFZdtVGeyigqj9g8NQ6Lo1ZqRCCFdRsHOte6aQ5N/DeZKkqyohOkatik/uI/uCG4Te7Jf2gzqP0IQSVKyTQ8J4Kxtnb/WCZ/wZ14+Cy78/uYMFWrtbNmCXG5lMViTYrjtAwVlUemMPZKSStI4lcrhch5aeWhZgeZqJegt1m0IMB69wa1tB2vAqHp2UX0Ta2D4LFX2/Vw+5M6W+l5B49Up3Cb0y8PRHLDdmsgcnlFAgQFgBT/aXrQqGlNRfoxiPeL8/fHy1jJJIy/9yVB5DyyaDl1NBSrME88jO2oYQG6OI/M7aHBtdRj/WJi7nIQHQFK/tahjEYqcY9vAbgj+Ui+0ZiYcECSckWA8Lcho+bJarTd3ksJwWzRG8pi/oCav6QrugcYbpEB6DCP7XYSvhq3niKMzrJCtHhClSrXtxHKdLSPwwsn51NCXXQ5LVD9Ga2afzCohROyX5DDLxW4h/rhLGUJiVi5O8W4khiYoO2Iw4hei9h5zA6e9dx3UI1TTeH+pGVpD0EacqRaAUQSxb02EB2BoViz4eL6Q9MxYqOQAie1a49afcr0qLRdmf44l3xQ1nUBTx4Ynn6vGFjx5GFTVmdDpydIgNmbSkVqbIveOsSJ0zKmVMUng9A=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 242cbd64-8eb5-4d64-3583-08d7e9951fea
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2020 03:51:39.0136
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wzZS7x9rI53NNTEsJl+rMGXkUaJLzq7ME+Co7qlmlNCXQcBN0WQQlQqrCYkYKMllQDps+hisb5YPtagd1FD8gA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5478
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIE1h
cmNoIDEyLCAyMDIwIDY6MjAgUE0NCj4gDQo+IEFzc2lnbiBJTVg4TSpfQ0xLX0E1M19TUkMncyBw
YXJlbnQgdG8gc3lzdGVtIHBsbDEgYW5kIGFzc2lnbg0KPiBJTVg4TSpfQ0xLX0E1M19DT1JFJ3Mg
cGFyZW50IHRvIGFybSBwbGwgb3V0IGFzIHdoYXQgaXMgZG9uZSBpbg0KPiBkcml2ZXJzL2Nsay9p
bXgvY2xrLWlteDhtKi5jLCB0aGVuIHdlIGNvdWxkIHJlbW92ZSB0aGUgc2V0dGluZ3MgaW4gZHJp
dmVyIHdoaWNoDQo+IHRyaWdnZXJzIGxvY2tkZXAgd2FybmluZy4NCj4gDQo+IFJlcG9ydGVkLWJ5
OiBMZW9uYXJkIENyZXN0ZXogPGxlb25hcmQuY3Jlc3RlekBueHAuY29tPg0KPiBTaWduZWQtb2Zm
LWJ5OiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IERvbmcgQWlz
aGVuZyA8YWlzaGVuZy5kb25nQG54cC5jb20+DQoNClJlZ2FyZHMNCkFpc2hlbmcNCg0KPiAtLS0N
Cj4gIGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtbS5kdHNpIHwgMTAgKysrKysr
Ky0tLQ0KPiBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bW4uZHRzaSB8IDEwICsr
KysrKystLS0NCj4gYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1wLmR0c2kgfCAx
MSArKysrKysrKy0tLQ0KPiBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXEuZHRz
aSB8ICA5ICsrKysrKystLQ0KPiAgNCBmaWxlcyBjaGFuZ2VkLCAyOSBpbnNlcnRpb25zKCspLCAx
MSBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2Zy
ZWVzY2FsZS9pbXg4bW0uZHRzaQ0KPiBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lt
eDhtbS5kdHNpDQo+IGluZGV4IDJlNWU3YzQ0NTdkYi4uOGQyMjAwMjI0ZGI0IDEwMDY0NA0KPiAt
LS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bW0uZHRzaQ0KPiArKysgYi9h
cmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bW0uZHRzaQ0KPiBAQCAtNDcxLDE2ICs0
NzEsMjAgQEANCj4gIAkJCQkJIDwmY2xrX2V4dDM+LCA8JmNsa19leHQ0PjsNCj4gIAkJCQljbG9j
ay1uYW1lcyA9ICJvc2NfMzJrIiwgIm9zY18yNG0iLCAiY2xrX2V4dDEiLA0KPiAiY2xrX2V4dDIi
LA0KPiAgCQkJCQkgICAgICAiY2xrX2V4dDMiLCAiY2xrX2V4dDQiOw0KPiAtCQkJCWFzc2lnbmVk
LWNsb2NrcyA9IDwmY2xrIElNWDhNTV9DTEtfTk9DPiwNCj4gKwkJCQlhc3NpZ25lZC1jbG9ja3Mg
PSA8JmNsayBJTVg4TU1fQ0xLX0E1M19TUkM+LA0KPiArCQkJCQkJPCZjbGsgSU1YOE1NX0NMS19B
NTNfQ09SRT4sDQo+ICsJCQkJCQk8JmNsayBJTVg4TU1fQ0xLX05PQz4sDQo+ICAJCQkJCQk8JmNs
ayBJTVg4TU1fQ0xLX0FVRElPX0FIQj4sDQo+ICAJCQkJCQk8JmNsayBJTVg4TU1fQ0xLX0lQR19B
VURJT19ST09UPiwNCj4gIAkJCQkJCTwmY2xrIElNWDhNTV9TWVNfUExMMz4sDQo+ICAJCQkJCQk8
JmNsayBJTVg4TU1fVklERU9fUExMMT4sDQo+ICAJCQkJCQk8JmNsayBJTVg4TU1fQVVESU9fUExM
MT4sDQo+ICAJCQkJCQk8JmNsayBJTVg4TU1fQVVESU9fUExMMj47DQo+IC0JCQkJYXNzaWduZWQt
Y2xvY2stcGFyZW50cyA9IDwmY2xrIElNWDhNTV9TWVNfUExMM19PVVQ+LA0KPiArCQkJCWFzc2ln
bmVkLWNsb2NrLXBhcmVudHMgPSA8JmNsaw0KPiBJTVg4TU1fU1lTX1BMTDFfODAwTT4sDQo+ICsJ
CQkJCQkJIDwmY2xrIElNWDhNTV9BUk1fUExMX09VVD4sDQo+ICsJCQkJCQkJIDwmY2xrIElNWDhN
TV9TWVNfUExMM19PVVQ+LA0KPiAgCQkJCQkJCSA8JmNsayBJTVg4TU1fU1lTX1BMTDFfODAwTT47
DQo+IC0JCQkJYXNzaWduZWQtY2xvY2stcmF0ZXMgPSA8MD4sDQo+ICsJCQkJYXNzaWduZWQtY2xv
Y2stcmF0ZXMgPSA8MD4sIDwwPiwgPDA+LA0KPiAgCQkJCQkJCTw0MDAwMDAwMDA+LA0KPiAgCQkJ
CQkJCTw0MDAwMDAwMDA+LA0KPiAgCQkJCQkJCTw3NTAwMDAwMDA+LA0KPiBkaWZmIC0tZ2l0IGEv
YXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1uLmR0c2kNCj4gYi9hcmNoL2FybTY0
L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bW4uZHRzaQ0KPiBpbmRleCBmZjljMWVhMzgxMzAuLmFk
ODhiYTNiZjI4YyAxMDA2NDQNCj4gLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUv
aW14OG1uLmR0c2kNCj4gKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1u
LmR0c2kNCj4gQEAgLTM4MCwxMyArMzgwLDE3IEBADQo+ICAJCQkJCSA8JmNsa19leHQzPiwgPCZj
bGtfZXh0ND47DQo+ICAJCQkJY2xvY2stbmFtZXMgPSAib3NjXzMyayIsICJvc2NfMjRtIiwgImNs
a19leHQxIiwNCj4gImNsa19leHQyIiwNCj4gIAkJCQkJICAgICAgImNsa19leHQzIiwgImNsa19l
eHQ0IjsNCj4gLQkJCQlhc3NpZ25lZC1jbG9ja3MgPSA8JmNsayBJTVg4TU5fQ0xLX05PQz4sDQo+
ICsJCQkJYXNzaWduZWQtY2xvY2tzID0gPCZjbGsgSU1YOE1OX0NMS19BNTNfU1JDPiwNCj4gKwkJ
CQkJCTwmY2xrIElNWDhNTl9DTEtfQTUzX0NPUkU+LA0KPiArCQkJCQkJPCZjbGsgSU1YOE1OX0NM
S19OT0M+LA0KPiAgCQkJCQkJPCZjbGsgSU1YOE1OX0NMS19BVURJT19BSEI+LA0KPiAgCQkJCQkJ
PCZjbGsgSU1YOE1OX0NMS19JUEdfQVVESU9fUk9PVD4sDQo+ICAJCQkJCQk8JmNsayBJTVg4TU5f
U1lTX1BMTDM+Ow0KPiAtCQkJCWFzc2lnbmVkLWNsb2NrLXBhcmVudHMgPSA8JmNsayBJTVg4TU5f
U1lTX1BMTDNfT1VUPiwNCj4gKwkJCQlhc3NpZ25lZC1jbG9jay1wYXJlbnRzID0gPCZjbGsgSU1Y
OE1OX1NZU19QTEwxXzgwME0+LA0KPiArCQkJCQkJCSA8JmNsayBJTVg4TU5fQVJNX1BMTF9PVVQ+
LA0KPiArCQkJCQkJCSA8JmNsayBJTVg4TU5fU1lTX1BMTDNfT1VUPiwNCj4gIAkJCQkJCQkgPCZj
bGsgSU1YOE1OX1NZU19QTEwxXzgwME0+Ow0KPiAtCQkJCWFzc2lnbmVkLWNsb2NrLXJhdGVzID0g
PDA+LA0KPiArCQkJCWFzc2lnbmVkLWNsb2NrLXJhdGVzID0gPDA+LCA8MD4sIDwwPiwNCj4gIAkJ
CQkJCQk8NDAwMDAwMDAwPiwNCj4gIAkJCQkJCQk8NDAwMDAwMDAwPiwNCj4gIAkJCQkJCQk8NjAw
MDAwMDAwPjsNCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lt
eDhtcC5kdHNpDQo+IGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1wLmR0c2kN
Cj4gaW5kZXggZDkyMTk5YmY2NjM1Li4zYTk2MDgyZTg3MTcgMTAwNjQ0DQo+IC0tLSBhL2FyY2gv
YXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtcC5kdHNpDQo+ICsrKyBiL2FyY2gvYXJtNjQv
Ym9vdC9kdHMvZnJlZXNjYWxlL2lteDhtcC5kdHNpDQo+IEBAIC0yODQsNyArMjg0LDkgQEANCj4g
IAkJCQkJIDwmY2xrX2V4dDM+LCA8JmNsa19leHQ0PjsNCj4gIAkJCQljbG9jay1uYW1lcyA9ICJv
c2NfMzJrIiwgIm9zY18yNG0iLCAiY2xrX2V4dDEiLA0KPiAiY2xrX2V4dDIiLA0KPiAgCQkJCQkg
ICAgICAiY2xrX2V4dDMiLCAiY2xrX2V4dDQiOw0KPiAtCQkJCWFzc2lnbmVkLWNsb2NrcyA9IDwm
Y2xrIElNWDhNUF9DTEtfTk9DPiwNCj4gKwkJCQlhc3NpZ25lZC1jbG9ja3MgPSA8JmNsayBJTVg4
TVBfQ0xLX0E1M19TUkM+LA0KPiArCQkJCQkJICA8JmNsayBJTVg4TVBfQ0xLX0E1M19DT1JFPiwN
Cj4gKwkJCQkJCSAgPCZjbGsgSU1YOE1QX0NMS19OT0M+LA0KPiAgCQkJCQkJICA8JmNsayBJTVg4
TVBfQ0xLX05PQ19JTz4sDQo+ICAJCQkJCQkgIDwmY2xrIElNWDhNUF9DTEtfR0lDPiwNCj4gIAkJ
CQkJCSAgPCZjbGsgSU1YOE1QX0NMS19BVURJT19BSEI+LA0KPiBAQCAtMjkyLDEyICsyOTQsMTUg
QEANCj4gIAkJCQkJCSAgPCZjbGsgSU1YOE1QX0NMS19JUEdfQVVESU9fUk9PVD4sDQo+ICAJCQkJ
CQkgIDwmY2xrIElNWDhNUF9BVURJT19QTEwxPiwNCj4gIAkJCQkJCSAgPCZjbGsgSU1YOE1QX0FV
RElPX1BMTDI+Ow0KPiAtCQkJCWFzc2lnbmVkLWNsb2NrLXBhcmVudHMgPSA8JmNsaw0KPiBJTVg4
TVBfU1lTX1BMTDJfMTAwME0+LA0KPiArCQkJCWFzc2lnbmVkLWNsb2NrLXBhcmVudHMgPSA8JmNs
ayBJTVg4TVBfU1lTX1BMTDFfODAwTT4sDQo+ICsJCQkJCQkJIDwmY2xrIElNWDhNUF9BUk1fUExM
X09VVD4sDQo+ICsJCQkJCQkJIDwmY2xrIElNWDhNUF9TWVNfUExMMl8xMDAwTT4sDQo+ICAJCQkJ
CQkJIDwmY2xrIElNWDhNUF9TWVNfUExMMV84MDBNPiwNCj4gIAkJCQkJCQkgPCZjbGsgSU1YOE1Q
X1NZU19QTEwyXzUwME0+LA0KPiAgCQkJCQkJCSA8JmNsayBJTVg4TVBfU1lTX1BMTDFfODAwTT4s
DQo+ICAJCQkJCQkJIDwmY2xrIElNWDhNUF9TWVNfUExMMV84MDBNPjsNCj4gLQkJCQlhc3NpZ25l
ZC1jbG9jay1yYXRlcyA9IDwxMDAwMDAwMDAwPiwNCj4gKwkJCQlhc3NpZ25lZC1jbG9jay1yYXRl
cyA9IDwwPiwgPDA+LA0KPiArCQkJCQkJICAgICAgIDwxMDAwMDAwMDAwPiwNCj4gIAkJCQkJCSAg
ICAgICA8ODAwMDAwMDAwPiwNCj4gIAkJCQkJCSAgICAgICA8NTAwMDAwMDAwPiwNCj4gIAkJCQkJ
CSAgICAgICA8NDAwMDAwMDAwPiwNCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMv
ZnJlZXNjYWxlL2lteDhtcS5kdHNpDQo+IGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUv
aW14OG1xLmR0c2kNCj4gaW5kZXggOWJiZGFmMmQ2ZTM0Li4xZjNmZmM4YzhhNzggMTAwNjQ0DQo+
IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtcS5kdHNpDQo+ICsrKyBi
L2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtcS5kdHNpDQo+IEBAIC01OTQsOCAr
NTk0LDEzIEBADQo+ICAJCQkJY2xvY2stbmFtZXMgPSAiY2tpbCIsICJvc2NfMjVtIiwgIm9zY18y
N20iLA0KPiAgCQkJCSAgICAgICAgICAgICAgImNsa19leHQxIiwgImNsa19leHQyIiwNCj4gIAkJ
CQkgICAgICAgICAgICAgICJjbGtfZXh0MyIsICJjbGtfZXh0NCI7DQo+IC0JCQkJYXNzaWduZWQt
Y2xvY2tzID0gPCZjbGsgSU1YOE1RX0NMS19OT0M+Ow0KPiAtCQkJCWFzc2lnbmVkLWNsb2NrLXJh
dGVzID0gPDgwMDAwMDAwMD47DQo+ICsJCQkJYXNzaWduZWQtY2xvY2tzID0gPCZjbGsgSU1YOE1R
X0NMS19BNTNfU1JDPiwNCj4gKwkJCQkJCSAgPCZjbGsgSU1YOE1RX0NMS19BNTNfQ09SRT4sDQo+
ICsJCQkJCQkgIDwmY2xrIElNWDhNUV9DTEtfTk9DPjsNCj4gKwkJCQlhc3NpZ25lZC1jbG9jay1y
YXRlcyA9IDwwPiwgPDA+LA0KPiArCQkJCQkJICAgICAgIDw4MDAwMDAwMDA+Ow0KPiArCQkJCWFz
c2lnbmVkLWNsb2NrLXBhcmVudHMgPSA8JmNsaw0KPiBJTVg4TVFfU1lTMV9QTExfODAwTT4sDQo+
ICsJCQkJCQkJIDwmY2xrIElNWDhNUV9BUk1fUExMX09VVD47DQo+ICAJCQl9Ow0KPiANCj4gIAkJ
CXNyYzogcmVzZXQtY29udHJvbGxlckAzMDM5MDAwMCB7DQo+IC0tDQo+IDIuMTYuNA0KDQo=
