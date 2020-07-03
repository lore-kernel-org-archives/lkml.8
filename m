Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A66AC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 12:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06A7C20772
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 12:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="VujydwWY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbgGCMZq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 08:25:46 -0400
Received: from mail-eopbgr70052.outbound.protection.outlook.com ([40.107.7.52]:32903
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726022AbgGCMZq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 08:25:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KISnJZAD3dt2ctIK72hUbLB7kA2RdjjR7h2cvytfftybTHbRQTUzhU6IIs1adP81R7aKXPoTI0wdM7QgvEf85zFcfrnEfRGwfGIohT7a8Z0+0df9h+RWWRts6+bghDAkf+WUFbPgO5q59KxIrnBoG2Vtt0voPoJTWjvgL9yYef/uqpOm4DYmgdLipwnrZWEm6C41XrxLX94hHHqlQxacB6YqTCKgNf4FQZOCjBATmt9DPZNOMvSLy/HLgjuVsuVJ74R+angFNyDHq25owLbJo0KMjvlUs0drHyZ5r+oMoVcmHnaQ2As2Iu2hDM+QeCdOOgudmHimNvDJDHxOktwT1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rAnxmv0gifNu+EdEzoGFUwOj40qZa2qTIFDHaF5GV6s=;
 b=ClxlVu9dAvB4ltm5VOGFQJy8RoLmW87vV+b+sEpGjJDkJvYw4j3xvXgNmZLuBCJQzyqWkG24sBeU2gY0B+SwncrHNily060AEem3cak2yQofUBYgXXcP8hzYorJQtA/KElJH0T+nvvatwC2jzzuFNt9Qo3fs3QxiqxXUvITPKb0NTxNiAScaCSIbhT/XEx1rFu0oRf9/S92CswHNnOL2+ABj2MB/DXaoVMNbuXVLUnV7mTCmGnh3V1gisUage6SwWNj0uFSyVvMHqum00jWdXsnztxGw+nDha14zAIpDJKlsNdJMck1sSMlKrI3h9aMhEA+Zzv0PeDABQGWmLr7lGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rAnxmv0gifNu+EdEzoGFUwOj40qZa2qTIFDHaF5GV6s=;
 b=VujydwWY8h34Hmy4/I2o/ZKTwr4GxeumnvJbEcGVbdwVxijtbcvGmyRtfyBQOXCoZxq6q+E3X5JKdKpCn6ZSN09KwUkGkG6AjaZ6+y85aF8J1D/uVvBIEWitUDFxotAZDx3um9db+zyS+2PpX50IhTUe92ky9xSfZqJ143fozhg=
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB6PR0401MB2536.eurprd04.prod.outlook.com (2603:10a6:4:36::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.27; Fri, 3 Jul
 2020 12:25:40 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::2d36:b569:17c:7701]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::2d36:b569:17c:7701%4]) with mapi id 15.20.3131.034; Fri, 3 Jul 2020
 12:25:40 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Horia Geanta <horia.geanta@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "allison@lohutok.net" <allison@lohutok.net>,
        "info@metux.net" <info@metux.net>,
        Anson Huang <anson.huang@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "git@andred.net" <git@andred.net>, Abel Vesa <abel.vesa@nxp.com>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "cphealy@gmail.com" <cphealy@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alison Wang <alison.wang@nxp.com>
Subject: RE: [PATCH V3 0/3] ARM: imx: move cpu code to drivers/soc/imx
Thread-Topic: [PATCH V3 0/3] ARM: imx: move cpu code to drivers/soc/imx
Thread-Index: AQHWLmwVB15qTPGFOECbIUd7NuMlQaj10h0AgAA6/5A=
Date:   Fri, 3 Jul 2020 12:25:40 +0000
Message-ID: <DB6PR0402MB27604DD8AF73824C3972BC90886A0@DB6PR0402MB2760.eurprd04.prod.outlook.com>
References: <1589953889-30955-1-git-send-email-peng.fan@nxp.com>
 <fd6a7452-25f6-4ced-7b3f-4aa92388ad09@nxp.com>
In-Reply-To: <fd6a7452-25f6-4ced-7b3f-4aa92388ad09@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [49.73.172.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 51560536-1402-4b05-d697-08d81f4c330b
x-ms-traffictypediagnostic: DB6PR0401MB2536:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR0401MB2536A6D7B719653BCDB2AF5C886A0@DB6PR0401MB2536.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 045315E1EE
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UzzVkRdV1LHWCwW/T8fjn3Os83TZIA3nFH7h2UEU/plqYDsxWa0yAH6FMC+3N0yCoIYPAFiwWmZ4dKV2hA99DCuHiY2lStWNBps1Od7LJUfIqXBiIDofxwZe21SrzWI7rq7cDJeNax8Yo+zRd5bm5/XuEkoPPlQvBr6omOgkxUgv2doNW8NpZE7mtRULb5R63oMWKoxLB3Dx5eKu739Zj8VCBtvMIGacc4/3N/j9H99tQZ1I8rpC8KR0npAIs/lK5xKuM6IolyUBjOxikmTM02F2ZQvym4u983K/MffixVQyShrafZ3BL17q7SdvWda0EzBTUvKh4b2QHJbmQv8En0zGl7grPA+sS2eGzWUz2jd3QNmn35CQ0gM7nIUVRNRUUsQ4QTsCGEvXvebpEcxYqA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(366004)(396003)(376002)(39860400002)(346002)(186003)(6506007)(26005)(55016002)(76116006)(9686003)(71200400001)(4326008)(53546011)(66556008)(64756008)(66446008)(33656002)(2906002)(66946007)(44832011)(66476007)(5660300002)(316002)(966005)(52536014)(7696005)(478600001)(54906003)(110136005)(86362001)(8936002)(7416002)(8676002)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 2qISt5sus51smqIewGBzhRqfd3qf1Tnw0V0RmMaBZa7T2Xqrc/QhvL79BcPZfMaO3jLj+c3FMZrdyq90MlwSWxpDRn/Q9w/2SEACSwZ8R+RF3uFa8NSx4ietypENV+ixmQn0bEJLRKfHcRuFaMpTCl8WXsKyABLQ0fkPbyPatje2xaIpxsDsJYZ3kKveLfWv4PXnaPGJHCZ3zp1woS0TvM1DOIrYH0GgLwIiPWB6W0dt3S5aIv21WrLyKi0n1KgxW9iTk+dQ1jiAZfs811goBVQgUggx9TXHbjidYqiBSqDykgrpa9/Ay95+dCrxCHJDST2hXh6kRABdtDZEFPz89Htf6JJW9ax+mLlYU5Rr8YkpD5Eb3/CmY/9lpvnVLDw55GBrE1491uSrBqMiyTqCkxwOyoHnm3ZVyphZvA0RoIic6urV22lZwgPiuVU4mWJxOqJQTanIGO9BKBkXlc1Law7FaRiJt8SwO5Mw5nG+LmQ=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51560536-1402-4b05-d697-08d81f4c330b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2020 12:25:40.5815
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r7gUU2/55O5Bnm07G2S94XUNAEIeBb4LtC6uSIF9WCHIj6O1vNShyf+piA+lBcmvTVsBB+Fpmq2nvHO3oCZwIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2536
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIIFYzIDAvM10gQVJNOiBpbXg6IG1vdmUgY3B1IGNvZGUgdG8g
ZHJpdmVycy9zb2MvaW14DQo+IA0KPiBPbiA1LzIwLzIwMjAgOTowMSBBTSwgUGVuZyBGYW4gd3Jv
dGU6DQo+ID4gRnJvbTogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQo+ID4NCj4gPiBWMzoN
Cj4gPiAgUmViYXNlZCB0byBsYXRlc3QgbmV4dCB0cmVlDQo+ID4gIFJlc29sdmVkIHRoZSBjb25m
bGljdHMgd2l0aCB2ZjYxMCBzb2MgcGF0Y2gNCj4gPg0KPiA+IFYyOg0KPiA+ICBLZWVwIGkuTVgx
LzIvMy81IGNwdSB0eXBlIGZvciBjb21wbGV0bmVzcyAgQ29ycmVjdCByZXR1cm4gdmFsdWUgaW4N
Cj4gPiBwYXRjaCAxLzMgIHVzZSBDT05GSUdfQVJNIHRvIGd1YXJkIGNvbXBpbGUgc29jLWlteC5j
IGluIHBhdGNoIDMvMw0KPiA+DQo+ID4gVjE6DQo+ID4gaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVs
Lm9yZy9jb3Zlci8xMTQzMzY4OS8NCj4gPiBSRkMgdmVyc2lvbiA6DQo+ID4gaHR0cHM6Ly9wYXRj
aHdvcmsua2VybmVsLm9yZy9jb3Zlci8xMTMzNjQzMy8NCj4gPg0KPiA+IE5vdGhpbmcgY2hhbmdl
ZCBpbiB2MSwganVzdCByZW5hbWUgdG8gZm9ybWFsIHBhdGNoZXMNCj4gPg0KPiA+IFNoYXduLA0K
PiA+ICBUaGUgb3JpZ2luYWwgY29uY2VybiBoYXMgYmVlbiBlbGltaW5hdGVkIGluIFJGQyBkaXNj
dXNzaW9uLCAgc28gdGhpcw0KPiA+IHBhdGNoc2V0IGlzIHJlYWR5IHRvIGJlIGluIG5leHQuDQo+
ID4gVGhhbmtzLg0KPiA+DQo+ID4gRm9sbG93IGkuTVg4LCBtb3ZlIHRoZSBzb2MgZGV2aWNlIHJl
Z2lzdGVyIGNvZGUgdG8gZHJpdmVycy9zb2MvaW14IHRvDQo+ID4gc2ltcGxpZnkgYXJjaC9hcm0v
bWFjaC1pbXgvY3B1LmMNCj4gPg0KPiA+IEkgcGxhbm5lZCB0byB1c2Ugc2ltaWxhciBsb2dpYyBh
cyBzb2MtaW14OG0uYyB0byByZXN0cnVjdHVyZSBzb2MtaW14LmMNCj4gPiBhbmQgbWVyZ2VkIHRo
ZSB0d28gZmlsZXMgaW50byBvbmUuIEJ1dCBub3Qgc3VyZSwgc28gc3RpbGwga2VlcCB0aGUNCj4g
PiBsb2dpYyBpbiBjcHUuYy4NCj4gPg0KPiA+IFRoZXJlIGlzIG9uZSBjaGFuZ2UgaXMgdGhlIHBs
YXRmb3JtIGRldmljZXMgYXJlIG5vdCB1bmRlcg0KPiA+IC9zeXMvZGV2aWNlcy9zb2MwIGFmdGVy
IHBhdGNoIDEvNC4gQWN0dWFsbHkgQVJNNjQgcGxhdGZvcm0gZGV2aWNlcyBhcmUNCj4gPiBub3Qg
dW5kZXIgL3N5cy9kZXZpY2VzL3NvYzAsIHN1Y2ggYXMgaS5NWDgvOE0uDQo+ID4gU28gaXQgc2hv
dWxkIG5vdCBodXJ0IHRvIGxldCB0aGUgcGxhdGZvcm0gZGV2aWNlcyB1bmRlciBwbGF0Zm9ybSBk
aXIuDQo+ID4NCj4gPiBQZW5nIEZhbiAoMyk6DQo+ID4gICBBUk06IGlteDogdXNlIGRldmljZV9p
bml0Y2FsbCBmb3IgaW14X3NvY19kZXZpY2VfaW5pdA0KPiA+ICAgQVJNOiBpbXg6IG1vdmUgY3B1
IGRlZmluaXRpb25zIGludG8gYSBoZWFkZXINCj4gPiAgIHNvYzogaW14OiBtb3ZlIGNwdSBjb2Rl
IHRvIGRyaXZlcnMvc29jL2lteA0KPiA+DQo+IFRoaXMgcGF0Y2ggc2VyaWVzIGhhcyB0aGUgc2lk
ZSBlZmZlY3Qgb2YgTFMxMDIxQSBwbGF0Zm9ybSBub3cgcmVwb3J0aW5nIHRoYXQNCj4gaXQncyBw
YXJ0IG9mICJpLk1YIGZhbWlseSIuDQo+IA0KPiBjYWFtIGRyaXZlciByZWxpZXMgb24gdGhlIFNv
QyBidXMgLyBTb0MgYXR0cmlidXRlcyAoSUQsIGZhbWlseSkgdG8gZGV0ZXJtaW5lIGlmDQo+IGl0
J3MgcnVubmluZyBvbiBhbiBpLk1YIFNvQyBvciBvdGhlciAoTGF5ZXJzY2FwZSwgUW9ySVEpLg0K
DQpTb3JyeSB0byBicmVhayBMUzEwMjFBLiBCdXQgSSB3b25kZXIgd2h5IGkuTVggY29kZSB3b3Vs
ZCBhZmZlY3QgTFM/DQoNClJlZ2FyZHMsDQpQZW5nLg0KDQo+IA0KPiBXaXRoIHRoaXMgcGF0Y2gg
c2V0LCBkcml2ZXIgZmFpbHMgdG8gcHJvYmUgb24gTFMxMDIxQToNCj4gWyAgICA1Ljk5ODkyOF0g
Y2FhbSAxNzAwMDAwLmNyeXB0bzogTm8gY2xvY2sgZGF0YSBwcm92aWRlZCBmb3IgaS5NWCBTb0MN
Cj4gWyAgICA2LjAwNTMwNl0gY2FhbTogcHJvYmUgb2YgMTcwMDAwMC5jcnlwdG8gZmFpbGVkIHdp
dGggZXJyb3IgLTIyDQo+IA0KPiBIb3JpYQ0K
