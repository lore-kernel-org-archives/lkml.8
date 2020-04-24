Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A24A2C2BA19
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 02:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 768B62087E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 02:53:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="e0Ki3lUx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbgDXCxp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 22:53:45 -0400
Received: from mail-eopbgr70070.outbound.protection.outlook.com ([40.107.7.70]:56577
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726154AbgDXCxp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 22:53:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DiQbTzJB9lPxzdGvAKPtI8Ec3u1J7AXicpNM70pjK2i1wCho0lKja1LUHLfqFuQXPHkT1tw8411tJ3KfC2aq01RnHcL4w82Hov9G1GRo1867C91zn23B2DwblLSS5ZwaVl/CF9rhPvnPTxqiMQdXRe8Ipf4vgRBFS77MDkKYWmGpQwkW0sedeoNb5MDkva24vChuq6zTHIeLEumlAY/5AXypFM7WnF/NKBLMBmN7wkqqwwcGZllyAcAA4Z2Z2DitKmnBUfD3o+EH57ZqrSDLMGJXU/yQV0qK85dT738jEf9kmMGEZ8LAmITlQ4+9ekbjWYR9RUm8f+nMMmCxZsx6vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eunnHzmerHZAFK0GvBE5No6+AtG91kkZV42DpYdozkA=;
 b=Z7u3WfgNFBoq8JWOsDLNaTh75IZQyfq6hTdVWTxugwo+UJel53YpRhIwvdyi1WfH9UWNFsfK35LftNXxuESJb3kK36URjgEO0ZrMmX3YMOu4Ddbze7RLMnE2aIwWi0sWO/JoD4yAV8qsGWp1tWW/rFuFHuu5d7wAKk30WubEtPaOkgnXPC6NTzlxWPDBcmov0sceS+ugMSrMExZN1r2t+cw5uJtpllgrlPgKanvrRsNQ1ANA23/YJ2i6yLF4gWXWRnWjKfp1hKb0Bxs3Tj5KBJtXH8MsipZRQBtxx9fJ2Ud72mhNttbG4BS4HnT0B5/cllQ/84M9V+82/0ag49DBJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eunnHzmerHZAFK0GvBE5No6+AtG91kkZV42DpYdozkA=;
 b=e0Ki3lUxXTEyDX7pFmCROAuhEgyqsoeftyWRrvPDMpGelyJdLDK7FL7tmpSXECMDKYoOKuFciBbnFECTd4oYVuB6Y5AyfeZvXr1Ah5liLrWy8CasIaDFdq25eg+wQjWpLHsj2w8He6xq6QSLTBdFvFYxowPjQnaCjJ/NDTCfGhU=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (2603:10a6:8:10::18)
 by DB3PR0402MB3851.eurprd04.prod.outlook.com (2603:10a6:8:12::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Fri, 24 Apr
 2020 02:53:39 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3143:c46:62e4:8a8b]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3143:c46:62e4:8a8b%7]) with mapi id 15.20.2921.035; Fri, 24 Apr 2020
 02:53:39 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Aisheng Dong <aisheng.dong@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "ben.dooks@codethink.co.uk" <ben.dooks@codethink.co.uk>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 2/2] firmware: imx: MU IRQ group number should be 7
Thread-Topic: [PATCH 2/2] firmware: imx: MU IRQ group number should be 7
Thread-Index: AQHWGcUyRBBHbYoQgE22BeJnUGUH+KiHjasAgAAAN3CAAAT9gIAAAGSQ
Date:   Fri, 24 Apr 2020 02:53:39 +0000
Message-ID: <DB3PR0402MB3916F906513074C97A8B4AA7F5D00@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1587683231-18468-1-git-send-email-Anson.Huang@nxp.com>
 <1587683231-18468-2-git-send-email-Anson.Huang@nxp.com>
 <AM6PR04MB496669637FE86E928B9E0EBE80D00@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <DB3PR0402MB391699FFA107CD570B943705F5D00@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <AM6PR04MB49668CCFFB4439B051E99A3B80D00@AM6PR04MB4966.eurprd04.prod.outlook.com>
In-Reply-To: <AM6PR04MB49668CCFFB4439B051E99A3B80D00@AM6PR04MB4966.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [183.192.13.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fa55b81b-0ee8-4bb9-ea51-08d7e7fab153
x-ms-traffictypediagnostic: DB3PR0402MB3851:|DB3PR0402MB3851:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB385136F31B246879B664A733F5D00@DB3PR0402MB3851.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-forefront-prvs: 03838E948C
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(136003)(376002)(39860400002)(346002)(366004)(396003)(186003)(55016002)(81156014)(9686003)(33656002)(8936002)(53546011)(8676002)(478600001)(110136005)(86362001)(316002)(71200400001)(4326008)(2906002)(64756008)(52536014)(66946007)(76116006)(66556008)(7696005)(66476007)(44832011)(66446008)(6506007)(5660300002)(26005);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wK3s+6fCF8fbqYvU1387C2ICt24Z808FF4Gah8djtBQCTSaanymBeyjugIMYLPaRmC4gZJ7KiT29t0Xg7Rq1SJmSQB5bTdt0D64psiZFvgKvqMhgF3RhXN70vA+hmmhEDb0Q8eDwkwFcKxTraoEsr3DYBXhGXR29wm/mVMiocYcBKdRJkCkjNIytODPn5KiZNtvTrMCFKTPZxDLiKyPjup2bIj3TmRg5UETaN7kccyiZZ/pHmLJh89kDc18qpYpOYUpIXuqgLmGHAnNx8qbCUxCeMRL54my0AsBNp4of2DEJpMXU2grsVqya33zM7ZiaQ2K2dqmVmU6+jTnd0jr72V54CFfNo6OrZgWNa0RrlH/SY1B/5wdQDH7GdOOKkyLWbaVX8rckeRw7PKETJe6HQQot9yjvzDH2mxLL6daVGmZpMaJ9yrVGBEutLuK8T+Ic
x-ms-exchange-antispam-messagedata: WKXIkyPI++ljF703GDp3tmWV5SBtO4kuNnj16qh8lv1QHzgfwO4trLp8EI0UupRogRyZRKwONDt/jUl4YiA/rfUDuTNez7EV+mRvjsdewxnFIOl8GRViQO6NrWsHD/BujA3lcw7idirDeiLCPwkefnIwKWQ5FJ0ydIYM7Ue1UYNA/beyHMduh24dizmSca0W4z6MmfpwATpx3mbv8Su+B9RVRYr1x+KZ5R9l3vPGpGBMNRNo9nW+cUNvJ10Gd/Fz961GqoCSyrpJKG33JpqHZkhRsL1pg7FMHMd18yPhJntoc6xo1NBpr2BZQpPqPyxe1fuUSazfxluvxO4mReGBN2zWR9Fm0Gr21fQ7VhIcgGVyQ49sbncS/CelTh5KGHP57d0p3AV4QwF3bMky61NM5QprlsyWpgfVSQOVtEbOLfIa7JXu7fOqZNifI1rJY+gECnFZI1loBa5CGWs36FPvGEhkrf0TOLDyO6Z6+1eJlBeiqfXC9DPXeB9wTfSIp9xDYQQUjHhuS4pgIAo0eyaAIu0rMYR39+2TbQaeGVX2QN7p0+AmNYhFDkeWEEMM58320T8IhNbdxItVfqfHh1W58yApMbavhR2eUmeXkkfw8zGBX1zOAkGFlHFH8Riz7k9LyCNJB8+/Ly8RXC22UMR7wADNma6rRrtjUM6sLo26Ptu3Hh+ioMAP2ErpIkUtKdM2ARRevGzVQYj601xuwyJw0Zy7rCLrLWfccLx0kWn1Rq489eteRb3+p05sG/twyjlZQzpRpnJ/xO5COjVEHA+JqqyJuDsiL18PjDZXa+ZeJIs=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa55b81b-0ee8-4bb9-ea51-08d7e7fab153
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2020 02:53:39.8321
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lmJylDiTCGfKWNSRo3nKVkv+iEhXWvcCbIX+5oCxIRTVdD2NZ7NKkFphgVR8RYxRtZw+x6xGFCF/ex88LK18vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3851
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gU3ViamVjdDogUkU6IFtQQVRDSCAyLzJdIGZpcm13YXJlOiBpbXg6IE1VIElSUSBncm91
cCBudW1iZXIgc2hvdWxkIGJlIDcNCj4gDQo+ID4gRnJvbTogQW5zb24gSHVhbmcgPGFuc29uLmh1
YW5nQG54cC5jb20+DQo+ID4gU2VudDogRnJpZGF5LCBBcHJpbCAyNCwgMjAyMCAxMDozNiBBTQ0K
PiA+DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTogQWlzaGVu
ZyBEb25nIDxhaXNoZW5nLmRvbmdAbnhwLmNvbT4NCj4gPiA+IFNlbnQ6IDIwMjDlubQ05pyIMjTm
l6UgMTA6MzMNCj4gPiA+IFRvOiBBbnNvbiBIdWFuZyA8YW5zb24uaHVhbmdAbnhwLmNvbT47IHNo
YXduZ3VvQGtlcm5lbC5vcmc7DQo+ID4gPiBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOyBrZXJuZWxA
cGVuZ3V0cm9uaXguZGU7IGZlc3RldmFtQGdtYWlsLmNvbTsNCj4gPiA+IGJlbi5kb29rc0Bjb2Rl
dGhpbmsuY28udWs7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4gPiA+
IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gPiA+IENjOiBkbC1saW51eC1pbXggPGxp
bnV4LWlteEBueHAuY29tPg0KPiA+ID4gU3ViamVjdDogUkU6IFtQQVRDSCAyLzJdIGZpcm13YXJl
OiBpbXg6IE1VIElSUSBncm91cCBudW1iZXIgc2hvdWxkDQo+ID4gPiBiZQ0KPiA+ID4gNw0KPiA+
ID4NCj4gPiA+ID4gRnJvbTogQW5zb24gSHVhbmcgPEFuc29uLkh1YW5nQG54cC5jb20+DQo+ID4g
PiA+IFNlbnQ6IEZyaWRheSwgQXByaWwgMjQsIDIwMjAgNzowNyBBTQ0KPiA+ID4gPg0KPiA+ID4g
PiBUaGUgTVUgSVJRIGdyb3VwIG51bWJlciBzaG91bGQgYmUgNyBpbnN0ZWFkIG9mIDQuDQo+ID4g
PiA+DQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEFuc29uIEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAu
Y29tPg0KPiA+ID4NCj4gPiA+IEFyZSB3ZSB1c2luZyBvdGhlcnMgSVJRIGdyb3VwPw0KPiA+ID4g
SWYgbm90LCB0aGlzIGNoYW5nZSBtYXkgc2xvdyBkb3duIHRoZSBpcnEgaGFuZGxpbmcgc3BlZWQu
DQo+ID4NCj4gPiBUaGUgaXJxIGhhbmRsaW5nIGlzIHVzaW5nIHdvcmsgcXVldWUsIE5PVCBpbiBJ
U1IsIHNvIHRoZSBzcGVlZCBpcyBOT1QNCj4gPiB0aGF0IHNlbnNpdGl2ZS4NCj4gDQo+IFNDVSBJ
UEMgaXMgc2hhcmVkIGJ5IHRoZSB3aG9sZSBzeXN0ZW0sIGVhY2ggU0NVIHRyYW5zZmVyIHRha2Vz
IGFib3V0IDEwfjIwDQo+IHVzLg0KPiBIZXJlIHlvdSBtYXkgd2FzdGUgMzB+NjB1cyBpZiBub3Qg
cmVhbGx5IHVzZWQuDQo+IA0KPiA+IFRoZSBzY3UgZ3JvdXAgaXJxIGRyaXZlciBzaG91bGQgcHJv
dmlkZSBmdWxsIGZ1bmN0aW9ucywgYXMgb3RoZXINCj4gPiBkcml2ZXJzIHVzaW5nIGl0IG1heSBl
bmFibGUgdGhlIGdyb3VwIHRoZXkgd2FudC4NCj4gDQo+IEJlbG93IGFyZSBleHRyYSBHUk9VUHMg
eW91J3JlIGdvaW5nIHRvIGFkZDoNCj4gI2RlZmluZSBTQ19JUlFfR1JPVVBfU1lTQ1RSICAgICA0
VSAgIC8qITwgU3lzdGVtIGNvdW50ZXIgaW50ZXJydXB0cyAqLw0KPiAjZGVmaW5lIFNDX0lSUV9H
Uk9VUF9SRUJPT1RFRCAgIDVVICAgLyohPCBQYXJ0aXRpb24gcmVib290IGNvbXBsZXRlDQo+ICov
DQo+ICNkZWZpbmUgU0NfSVJRX0dST1VQX1JFQk9PVCAgICAgNlUgICAvKiE8IFBhcnRpdGlvbiBy
ZWJvb3Qgc3RhcnRpbmcgKi8NCj4gQXJlIHdlIHJlYWxseSBnb2luZyB0byB1c2UgaXQ/IEl0IHNl
ZW1zIEkgYWxzbyBkaWRuJ3Qgc2VlIGFueSB1c2VycyBpbg0KPiBkb3duc3RyZWFtIHRyZWUuDQo+
IA0KPiBTb21lIGZ1bmN0aW9ucyBwcm92aWRlZCBieSBTQ0ZXIG1heSBub3QgcmVhbGx5IHVzZWQg
YnkgTGludXguDQo+IEkgdGhpbmsgSSdzIGJldHRlciB0byBhZGQgdGhlbSB3aGVuIHdlIHJlYWxs
eSBuZWVkIHRoZW0sIG90aGVyd2lzZSB3ZSBiZW5lZml0DQo+IG5vdGhpbmcgQnV0IHdhc3Rpbmcg
Q1BVIG1pcHMuDQoNCkkgZG9uJ3QgYWdyZWUgdGhpcywgaWYgU0NGVyBOT1Qgc3VwcG9ydCBpdCwg
aXQgc2hvdWxkIGZpeCBmcm9tIFNDRlcuIFRoaXMgaXMgYWxpZ25lZCB3aXRoIG91cg0KaW50ZXJu
YWwgdHJlZS4NCg0KQW5zb24NCg==
