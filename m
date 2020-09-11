Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F04A5C43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 07:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB3E82073E
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 07:23:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="OLpI9kcf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725784AbgIKHXT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 03:23:19 -0400
Received: from mail-vi1eur05on2076.outbound.protection.outlook.com ([40.107.21.76]:37281
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725768AbgIKHXQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 03:23:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fdXG28Ma2GyqYFNSMgGK7A3n7KeTlQ3787SHLZrc2LUSTpRTPU4umkqKOeh5N5IMonsav9Bji2Mh6lpM/wZc4it2/tgi9SXXlr3aIb6K90ca7pTGakO+vVixYlifXdzjZXEj5dWLIWvAoSx5/BFhDpVutgQyHKVhbJRd0eXkUvQmTofck4h6WlQ8jhOR56FhtM6OQl1E60nS87JMeWzWTALH5mjh4r1Q9WGdY6w7UPHod1Fj+MZ2Gn/h9Ft8+NrE4jUhd16EcHEFc7rjYabUXFy6KVy9DGi6nuHg1UMu8/DW29lgOe4JlWYHZuPjVcynVxfXFZHB0FWqk2MDmQ51LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BnYZfATVGQikBjC/ysvSISq7kC1smvn+L0b3xkJxE4o=;
 b=TJTK4/xG1CCpc3y4N5l0ChowBGFQj0oHWH3xtn7FL9N/0mSUIdYEkyihRF2D4BnoO38byi7xZbiH56so7i6WX9PagUpjTk/TSP9aV+MnZR9tODz5pswnwmwTwzWt6RCWAlszMjv3rW9cB/dyjOFDB3fFzVYXmwWTJSYKMULzu1Rkt7Mt4Z6zDZmdGPrwFnEMya+9fKGTzl0y7yrYnhH9sKNwywbMgK85kHJfcpjxVs0Y4k/7qP6myWY+gAE93kYB3WDkKuZ8SzjziNElO1F7dJV5ONMkJbOVAGXnv/kkkpsuQc5EoW+sZFZEB0KQQL2M05YPBtWLfEHQyBHnsk2Ndw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BnYZfATVGQikBjC/ysvSISq7kC1smvn+L0b3xkJxE4o=;
 b=OLpI9kcfiauKkxxocuWixKNyAiHY0ftvaGTvZTjFphaFfIHXkM0GIKiNgz1XqVsWiPjZ6T6BMVfXNo4c+Qld2sluYwd+tUf6gPgjBUiH/J6gGnvz2VmtfIY3nNW7pFecLS2umLZ0aMWev3KO5Dp6ZcNveptQcqOZ408FUT1V2nU=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR04MB4037.eurprd04.prod.outlook.com (2603:10a6:209:49::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.17; Fri, 11 Sep
 2020 07:23:11 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::99b5:145d:16cc:78ca]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::99b5:145d:16cc:78ca%3]) with mapi id 15.20.3370.016; Fri, 11 Sep 2020
 07:23:11 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Abel Vesa <abel.vesa@nxp.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        Andy Duan <fugang.duan@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: RE: [PATCH v3 03/14] dt-bindings: clock: imx8mp: Add ids for the
 audio shared gate
Thread-Topic: [PATCH v3 03/14] dt-bindings: clock: imx8mp: Add ids for the
 audio shared gate
Thread-Index: AQHWhcp4IBbwVG0NdUGmVDta5V+57qljDQVw
Date:   Fri, 11 Sep 2020 07:23:11 +0000
Message-ID: <AM6PR04MB49665C7943DC9056A60E4EE880240@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <1599560691-3763-1-git-send-email-abel.vesa@nxp.com>
 <1599560691-3763-4-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1599560691-3763-4-git-send-email-abel.vesa@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 41c883a2-5fc3-48bc-6549-08d856238a31
x-ms-traffictypediagnostic: AM6PR04MB4037:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB4037037611BB35457C60D74880240@AM6PR04MB4037.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:873;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Lv8VYaAZBj2g7Am0FgJARqoZ9vyP/w1Un9oTe0LPYhuSwH92u4+TZVZ+pebc+9mAEOwymzrtc1KKpT6VOWUnPWY8FEGr2G1XnX23XM85jwtkMeUGkLJd2jfZn0i5yhTUHCpsIde3WmOr1dek1lo5HQR3WOTG7MycG/rUEKqM6uHlULO9gSpe4rG2bYQuV1LzmSN3bIz4LweX34GQHjc2VsuG9NLOPeZvDGaQzfaNxrXCniyi8Mrk7E1dVRpUEJI1YnfGu7WaBWEVBDFKXhx6o3t6/yM5UTJLNkDzDTwzlPbQtGEnW/AZRNkqXpJTLPSTzCtBbxu7MvMPOvA+aEvH8OpNVkOzNKhlmO2o3fIS62GI67XaqJRrwexC7dplnLJIM+kuBVuuvGhOcG25ygQGsw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(376002)(39860400002)(136003)(396003)(44832011)(8936002)(83380400001)(478600001)(33656002)(86362001)(52536014)(7416002)(66446008)(5660300002)(66476007)(64756008)(54906003)(9686003)(66556008)(71200400001)(76116006)(55016002)(66946007)(4326008)(7696005)(26005)(316002)(186003)(110136005)(6506007)(8676002)(2906002)(32563001)(921003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: ISIOtQfh6Cxom3noKzwH4Ru6OcFGwrIafALqmJQhYcjx3A2zVt4/js5z3F5N58ea6QS/f/Gsez6aOUZAOvW3fcLai+jVBs35kIxVA1gIpYxEF5nW6BBsaak4R4ykjCW33JBl6TJKzEhUzvjfLqMCa3Ndw0TalN0AgUZtS9qFFjxIjq2lCKmdCIgX5q7WEtZ2RYynCB8eIFnokJDxJlZ72GmJXV7yIvrFifya3utzcDDtobPAyJJpoQOUZnbD5Vduu3Z4FnWE+xIAM28RH7jrt4oAWvSyR8tKh/Gr79kzz8dAS/Yr06hyPih5XpI+EckRoDmr6XWs3Q0cbCby+cGRmtZdpAZNE/Q/tt4CeLJItX+LBGVeINlpFf8OAXfZvmA/TYHUnMMVRkXBgQ8uHtct7h7VbDcpfeoRoZGLvIop4a+FE2mxKSVtwtGYAk4YVxP2hd8Z07XLi+K2KDhh/ki0q5TpkA44/WtHa50IKEfXaufxNyeZZeiM+XX9VzQMG5JOvMZCYfe/lVkgRiDD2aTDWrqZUpLURuY1zhN3M0eNwX4uPPvVvf6k+/SUKlWQ7hsHGYo4WMmLqDl/6N9bQzi2/kCx6u5JU7mOFRBrbQkF16Sct87wnMez0oKVPTqne1YFxLH8xytK+Wc0k63fIuIlhw==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4966.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41c883a2-5fc3-48bc-6549-08d856238a31
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2020 07:23:11.4013
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WF97ctjBhVpI88cm/4U3SGT8/Z03G1B5CJMNBjsNMbFHPTIdONxUcpnqG/vKIPLFvIhix4XE7gBsy8harzzPkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4037
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBBYmVsIFZlc2EgPGFiZWwudmVzYUBueHAuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBT
ZXB0ZW1iZXIgOCwgMjAyMCA2OjI1IFBNDQo+IA0KPiBBbGwgdGhlc2UgSURzIGFyZSBmb3Igb25l
IHNpbmdsZSBIVyBnYXRlIChDQ0dSMTAxKSB0aGF0IGlzIHNoYXJlZCBiZXR3ZWVuIHRoZXNlDQo+
IHJvb3QgY2xvY2tzLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQWJlbCBWZXNhIDxhYmVsLnZlc2FA
bnhwLmNvbT4NCj4gQWNrZWQtYnk6IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+DQoNClNl
ZW1zIG1pc3NlZCBteSB0YWcuDQpTbzoNClJldmlld2VkLWJ5OiBEb25nIEFpc2hlbmcgPGFpc2hl
bmcuZG9uZ0BueHAuY29tPg0KDQpSZWdhcmRzDQpBaXNoZW5nDQoNCj4gLS0tDQo+ICBpbmNsdWRl
L2R0LWJpbmRpbmdzL2Nsb2NrL2lteDhtcC1jbG9jay5oIHwgMTIgKysrKysrKysrKystDQo+ICAx
IGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlm
ZiAtLWdpdCBhL2luY2x1ZGUvZHQtYmluZGluZ3MvY2xvY2svaW14OG1wLWNsb2NrLmgNCj4gYi9p
bmNsdWRlL2R0LWJpbmRpbmdzL2Nsb2NrL2lteDhtcC1jbG9jay5oDQo+IGluZGV4IDg5YzY3Yjcu
LjVmYzJjNDAgMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUvZHQtYmluZGluZ3MvY2xvY2svaW14OG1w
LWNsb2NrLmgNCj4gKysrIGIvaW5jbHVkZS9kdC1iaW5kaW5ncy9jbG9jay9pbXg4bXAtY2xvY2su
aA0KPiBAQCAtMzIyLDcgKzMyMiwxNyBAQA0KPiAgI2RlZmluZSBJTVg4TVBfQ0xLX0hTSU9fQVhJ
CQkJMzExDQo+ICAjZGVmaW5lIElNWDhNUF9DTEtfTUVESUFfSVNQCQkJMzEyDQo+IA0KPiAtI2Rl
ZmluZSBJTVg4TVBfQ0xLX0VORAkJCQkzMTMNCj4gKyNkZWZpbmUgSU1YOE1QX0NMS19BVURJT19B
SEJfUk9PVAkJMzEzDQo+ICsjZGVmaW5lIElNWDhNUF9DTEtfQVVESU9fQVhJX1JPT1QJCTMxNA0K
PiArI2RlZmluZSBJTVg4TVBfQ0xLX1NBSTFfUk9PVAkJCTMxNQ0KPiArI2RlZmluZSBJTVg4TVBf
Q0xLX1NBSTJfUk9PVAkJCTMxNg0KPiArI2RlZmluZSBJTVg4TVBfQ0xLX1NBSTNfUk9PVAkJCTMx
Nw0KPiArI2RlZmluZSBJTVg4TVBfQ0xLX1NBSTVfUk9PVAkJCTMxOA0KPiArI2RlZmluZSBJTVg4
TVBfQ0xLX1NBSTZfUk9PVAkJCTMxOQ0KPiArI2RlZmluZSBJTVg4TVBfQ0xLX1NBSTdfUk9PVAkJ
CTMyMA0KPiArI2RlZmluZSBJTVg4TVBfQ0xLX1BETV9ST09UCQkJMzIxDQo+ICsNCj4gKyNkZWZp
bmUgSU1YOE1QX0NMS19FTkQJCQkJMzIyDQo+IA0KPiAgI2RlZmluZSBJTVg4TVBfQ0xLX0FVRElP
X0JMS19DVExfU0FJMV9JUEcJCTANCj4gICNkZWZpbmUgSU1YOE1QX0NMS19BVURJT19CTEtfQ1RM
X1NBSTFfTUNMSzEJCTENCj4gLS0NCj4gMi43LjQNCg0K
