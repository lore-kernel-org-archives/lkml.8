Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D1FBC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 08:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D25142072C
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 08:11:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="GvEyBcpD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbgETILr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 04:11:47 -0400
Received: from mail-eopbgr20070.outbound.protection.outlook.com ([40.107.2.70]:40334
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726403AbgETILq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 04:11:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a6svDrZITWPy2aleVqJAjG2Mzk0fbEt+MtV9+0DxfuaKymovdZcX0D3L+r5WPVX5870NVqz9k2zvLybF/xb8tEJIrQ7Xi9qI4z1N+ezX29ck0LPVXxTeJWN7UiGYwOFXF7eNHPPCpEmUvm+WkxosgDwYyPYpsqlgUWyezZS9o5STtqas9xFjOapbp+JqNWsqmtrLgg2903YXTLIoapx19C5dix/GBrS+3FRSGAU5BlrwHUY3QuGwToZU4XkHVW5FxcQGNwa37bpr0pv5o1TR+zsKhzxR6p1Ofsz3E+0nCeK7vXbXuDUjax7J4dLX/9cA6r6Xa0RW9aD3enJ4AZrdVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YJrQbDfNQGzrLyEB8x9OawLS5/sK5dTyCpcvKdeACOQ=;
 b=e+ZWaqdB3GnC1psOgeeTHEqfB/pwgq3v+c8fc0ygQKWNZNNnzr6NIrfbU+VGYYlU9xzY+WyVTkIuw6HRtyjmvmw2/owXj3ow5BNUgDH1DWnvBnI0YPbvNbGpg9Nb/jaC+46TY1JieQolOJWn3dY9Pf9lHiDiaGZKkrX1ZZV8vs+K9Jibi5mAksVzksvCKXzoOW0AjY9FkQcL4sgTcGIbNYrmTy4U/d6t7ATKejiY1mLhBrcC66R2PQVKPzZitJgkJrik2jOF3ahOe5bZ7ZQ9A0PlRMBbfiTnOhBvji5OmGvZ3Dc5c0Nxrt1LU1ONUBzU5Y5SlJ8qyscE/wYXjFB7HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YJrQbDfNQGzrLyEB8x9OawLS5/sK5dTyCpcvKdeACOQ=;
 b=GvEyBcpDa/O6fvRpNjs6WMSXEhwvL7ze0l5opiJVrVo8xNfgy9XcXU0K4YINhe626oIvl9VPkLJ68iMbyok3jIT1WP5cO9IIJY6vN5WCzsCzYA/0nTTvmvsvwBxUu6Agn2Di11H9I455ACLMeEpLowrvN6rVJviRVTBzvGbC+tA=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (2603:10a6:8:10::18)
 by DB3PR0402MB3659.eurprd04.prod.outlook.com (2603:10a6:8:5::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.27; Wed, 20 May
 2020 08:11:42 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1dab:b68c:e028:acb3]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1dab:b68c:e028:acb3%6]) with mapi id 15.20.3000.034; Wed, 20 May 2020
 08:11:42 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Aisheng Dong <aisheng.dong@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] ARM: dts: imx: Make tempmon node as child of anatop node
Thread-Topic: [PATCH] ARM: dts: imx: Make tempmon node as child of anatop node
Thread-Index: AQHWLnGKHrF20oveIESDr3+xecMSEqiwl/QAgAAARbCAAAYAgIAAAQaA
Date:   Wed, 20 May 2020 08:11:41 +0000
Message-ID: <DB3PR0402MB39161EA7B95886D56EB91E8BF5B60@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1589956216-22499-1-git-send-email-Anson.Huang@nxp.com>
 <AM6PR04MB49663B517C218072B2845DBF80B60@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <DB3PR0402MB39167A0961963B73758F6CA9F5B60@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <AM6PR04MB496661BDF6B5F966A218092380B60@AM6PR04MB4966.eurprd04.prod.outlook.com>
In-Reply-To: <AM6PR04MB496661BDF6B5F966A218092380B60@AM6PR04MB4966.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [183.192.13.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8d134e61-7e21-4b1e-1f76-08d7fc956df7
x-ms-traffictypediagnostic: DB3PR0402MB3659:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB365939F4C4628CE94A45790FF5B60@DB3PR0402MB3659.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-forefront-prvs: 04097B7F7F
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CVQgYzg3CiV4gPSV4gmhryJPhTZtIgreF67/H3e7zFsrCCYT+lAPqetquu5Ln5B7AM23iG0MtCDL+uEDLaPgrZ8MVQyNpUYRT9kBPfcSzcjS20yw/EZ+h4WjT6Ri25GFtQCJerpw83foe3uXpeuj8IHQV8XeNxCfhymX1wEPBN/HPFbyc7kimOyeckEWiYgPteL0yccPdEcVKnWCbCRRTgvuVwehUYizsjsuoKzdh48ehV3KSzPS3bTzIIspYqy1iSsGr3ofCc+/pEhp3hJ4dttAJg4JB93DhoI6Nw36gRM7B7Mfnu8nAIbkpdZzID2fjvQJeqOdbmtdiyxQOcwCMx7nfEcJl7K20XJiOOtq/cjniWm2ioZI6fM9vCC6YfXovjFQeGUb+Q2KpsgpNdbvAmg+NVdiOL3Id7tdqxs+16G1vmGtrT0Adj1g5Tg5xOgm
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(396003)(346002)(39860400002)(366004)(136003)(53546011)(33656002)(6506007)(7696005)(316002)(186003)(55016002)(2906002)(9686003)(5660300002)(86362001)(66476007)(66556008)(66446008)(64756008)(8936002)(66946007)(110136005)(8676002)(26005)(52536014)(44832011)(76116006)(71200400001)(4326008)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: cBccdhrJybQg56bDyk8QeBtILkNRBa5m/HMSZ4KFnCCMAHHF08Ao/DXSePrMGfzk6Mvq2bIOvJHmalPtnNx/3ToAKuu5ItDr2M3vW/PNm/2sSRmZvVeiTjL1t4UTHJbWqT8c+wgLD5BBIt+TYQOs7A0wCBJ/7zwUwkpUePTAa3XbTEeByiwUaixNfgouKGyjoN0eqoPKdDO6Qm8BX2b4M7UCBLjWGOwgcn4YjvLl3kCAKt4V6+Rf2ZTap/Z/j15seLlFmEJg9Yt3f9WXIFJwid5DkjEY62B3IcXz+GSj05YRBkD/NQcmJFdfp3gZbhYOiot2Qq8gQ3fK615A2C1EbKrrIPhn3iU+heXeczlIyLHN4xbcAwtOx2SKaaJEEawpNY0u2z3e8Au3zMMnJlAQA2z12+Q13LMOqPaGFb19RgTI81wDfWjftbJkA+d5PFsxxfOwREGMadgb7NHTGCpnoDvqMOZKionulOypiSScsbAoAaTJlV7cTPFMndGfEUlx
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d134e61-7e21-4b1e-1f76-08d7fc956df7
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2020 08:11:41.9974
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bQlPf4V0KdabNljw82DZOv88LzMPxJNoKCOIrXGPH05ykUwquWHJOYPfG+61mx2WbE+2UTQCqjadCWlSCqImBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3659
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gU3ViamVjdDogUkU6IFtQQVRDSF0gQVJNOiBkdHM6IGlteDogTWFrZSB0ZW1wbW9uIG5v
ZGUgYXMgY2hpbGQgb2YgYW5hdG9wDQo+IG5vZGUNCj4gDQo+ID4gRnJvbTogQW5zb24gSHVhbmcg
PGFuc29uLmh1YW5nQG54cC5jb20+DQo+ID4gU2VudDogV2VkbmVzZGF5LCBNYXkgMjAsIDIwMjAg
Mzo0NyBQTQ0KPiA+DQo+ID4gPiBTdWJqZWN0OiBSRTogW1BBVENIXSBBUk06IGR0czogaW14OiBN
YWtlIHRlbXBtb24gbm9kZSBhcyBjaGlsZCBvZg0KPiA+ID4gYW5hdG9wIG5vZGUNCj4gPiA+DQo+
ID4gPiA+IEZyb206IEFuc29uIEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAuY29tPg0KPiA+ID4gPiBT
ZW50OiBXZWRuZXNkYXksIE1heSAyMCwgMjAyMCAyOjMwIFBNDQo+ID4gPiA+DQo+ID4gPiA+IGku
TVg2LzcgU29DcycgdGVtcGVyYXR1cmUgc2Vuc29yIGlzIGluc2lkZSBhbmF0b3AgbW9kdWxlIGZy
b20gSFcNCj4gPiA+ID4gcGVyc3BlY3RpdmUsIHNvIGl0IHNob3VsZCBiZSBhIGNoaWxkIG5vZGUg
b2YgYW5hdG9wLg0KPiA+ID4gPg0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBBbnNvbiBIdWFuZyA8
QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4gPiA+DQo+ID4gPiBSZXZpZXdlZC1ieTogRG9uZyBBaXNo
ZW5nIDxhaXNoZW5nLmRvbmdAbnhwLmNvbT4NCj4gPiA+DQo+ID4gPiBCVFcsIEkgdGhpbmsgeW91
IGFsc28gbmVlZCBhIGJpbmRpbmcgZG9jIGZvciB0aGlzIGNoYW5nZS4NCj4gPg0KPiA+IFRoZSBi
aW5kaW5nIGRvYyBpcyB0aGUgaW14LXRoZXJtYWwueWFtbCBJIHNlbnQgb3V0LCBpdCBpcyBzdWdn
ZXN0ZWQgYnkNCj4gPiBSb2IgdG8gbW92ZSB0ZW1wbW9uIGludG8gYW5hdG9wIG5vZGUsIHRoYXQg
aXMgd2h5IEkgZGlkIHRoaXMgcGF0Y2ggdG8NCj4gPiBhbGlnbiB3aXRoIHRoZSBiaW5kaW5nIGRv
Yy4NCj4gDQo+IFRoYXQncyB0aGVybWFsIGJpbmRpbmcgZG9jLg0KPiBXZSBuZWVkIGEgYmluZGlu
ZyBkb2MgdG8gZGVzY3JpYmUgdGhlIGNvbnN0cmFpbnRzIGZvciBhbmF0b3AgYXMgd2VsbC4NCg0K
YW5hdG9wIGluY2x1ZGVzIFBNVSwgdGhlcm1hbCBldGMuLCBuZWVkIHRvIHRoaW5rIGFib3V0DQpo
b3cgdG8gYWRkIGl0IGFuZCB3aGVyZSB0byBwdXQgaXQsIHdpbGwgdGhpbmsgYWJvdXQgaXQgbGF0
ZXIuDQoNCkFuc29uDQo=
