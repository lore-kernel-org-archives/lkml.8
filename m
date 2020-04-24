Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA7FC2BA19
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 03:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F8B72074F
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 03:05:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="iYfVaqgR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbgDXDFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 23:05:19 -0400
Received: from mail-eopbgr70055.outbound.protection.outlook.com ([40.107.7.55]:58022
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726240AbgDXDFS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 23:05:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GOXuXoGTV2quVY9mErTVpy8WqyJX7SXn+Tx1LOW0Vt2II/JQulHdJY9md+j/sSTcmVUt3DX4DyIAL4+idDRKiYE2gzgpe0EW5PxuTVSQUKPKVOXoJSpP5EM1WxSGVLfPX/frjqI41Rp25oVHab5UWL0AE0hSiozl7rplEE89LyPVVPy4w77MkosgMjmB5tOJuwWGP3Hmz1rd8PKWji3hX5/Wt+ELYQmZ4QGcp3lp9u4Roup/CFlEvbMCgZMTzv+12TaTzyGrzR6UmNtyO2hCa21p70NBwkDRPP/AX6IjNAwGTKjGZJE6nFRRmaYps8SwVApMTczB3qWHCrKBnVC/mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eok9cKFXesz11dPUiXb7Pe7i9+jhpIQbEmW2Ui/94/I=;
 b=SzLjF3bibz5itzzcDrUFJms2sIpQDTGplyDkQhllPZtf6ZtLELZDnRiuNRcd1sQy0f0YTf4D5vHbw8xGtRCqnb1VhlIIPU/A6AZbZt5qZ9jyln4ergrMIyCoKIPtr6aj2iZbtegiUqVIQApYkmarFOlEbS5tnBYTOVHBOQw1jm/RDWvGrKx8E6dshXBnqrTIDzt5W5QsQdILDfNVq3O3N33OtE5Ey9H0TrTBO4jTEYkH10UAbX/wWp9j08GtvSDJK7tUoY40nl2vXmj4bw4ZEJVhP0wEuj231PflLm3wYTUSFDoBN4P9LZZg1G4AjgqwTJq/HNHcqh+yh3v0knQETQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eok9cKFXesz11dPUiXb7Pe7i9+jhpIQbEmW2Ui/94/I=;
 b=iYfVaqgRAbNzEOPXMu6XkcjzZN69g+PrFtI2rJ6DkckxzUu+0hbgi4uLMGrUMoUdj27dmwjyp7GO8beTb3FGj8CY6jiyWHOPSs9DkQJoxRBsDQg366i5YWiyATo/V88o2M2gZtx9INmDf2XpEQI46aeFhANfs5hYCwrrXGAnTO0=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR04MB6598.eurprd04.prod.outlook.com (2603:10a6:20b:fe::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Fri, 24 Apr
 2020 03:05:14 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::d9f7:5527:e89d:1ae3]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::d9f7:5527:e89d:1ae3%7]) with mapi id 15.20.2921.032; Fri, 24 Apr 2020
 03:05:12 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
        "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] mailbox: imx: Add context save/restore for suspend/resume
Thread-Topic: [PATCH] mailbox: imx: Add context save/restore for
 suspend/resume
Thread-Index: AQHWGcRIgrxdUkc8WEWRmowVEyQEl6iHi5TQgAACNYCAAAU8oA==
Date:   Fri, 24 Apr 2020 03:05:12 +0000
Message-ID: <AM6PR04MB496671BFF3496FD1C4C51E7E80D00@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <1587682871-528-1-git-send-email-Anson.Huang@nxp.com>
 <AM6PR04MB49666D6A0B015FD1DF3A20B480D00@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <DB3PR0402MB3916D588A9432A9F1D1F99BAF5D00@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB3916D588A9432A9F1D1F99BAF5D00@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ea4456ae-c714-4428-fba6-08d7e7fc4e61
x-ms-traffictypediagnostic: AM6PR04MB6598:|AM6PR04MB6598:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB65983A24D88FC588E93A324C80D00@AM6PR04MB6598.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:568;
x-forefront-prvs: 03838E948C
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(39860400002)(366004)(346002)(376002)(396003)(6506007)(66946007)(8936002)(316002)(15650500001)(53546011)(44832011)(71200400001)(81156014)(7696005)(4326008)(26005)(8676002)(110136005)(186003)(66476007)(52536014)(33656002)(86362001)(66446008)(66556008)(76116006)(9686003)(2906002)(478600001)(64756008)(55016002)(5660300002);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m1uJlzoCXYuH9dNrGchUXLn9aT27lARYTuTi3wNeFZGmEKNR7+ZPYoSUePPHWL2EEdCXErUnzvowm0A/U6w+Fngr1gLBeHhCVnG/B+7/QDjKRLllRPa5ssz6IQ87eUK8xedeI0xLT6+ljPYkp0QJkAaBEjLLymRqXI8yWVtEADwYMbf6CjO46fy0Yffx5Y+D3T4nW3/h+L4RhE53IsKP4skSuNRcbK41SIwMzy/SAkKcOTTuMKMcgowyYyw5TvvJmfqMW9dTkFPYxCIlivfWEeupM9atfcRjqDY5ZT49UG/m8CF/ouz7Q1LWM/fDh5Znt02eqvaIq7VsH9ByU3H6lwAFF+9tW+Ni5UhlcchJ+IKwDY6rwf97Tnz2JbaHZsVN8OXi0xvWH535r3YuQp7YM6Uo7Z9RcAmwrrIvnuTL+yOVeMm9VTiOsn1DCBi6ejbn
x-ms-exchange-antispam-messagedata: /oYvH0MBJKikAH5u+l98US5vmepuO6kzYk2ckT4UFLpUnpDv4zLrvcve7TLwGhc4Y+rrpLjkTZuu+I04K+Ajevz6x85qpiBxsWNWr7jZbz5mMa/WIlYEXCQNMzSms+nkwHCYgUxZs759m8mfKfCyEA==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea4456ae-c714-4428-fba6-08d7e7fc4e61
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2020 03:05:12.7760
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 24Xb27SB8gOq/Vs5ufBGrRNVIWw9gS9X6WzoktNSFW0j/6koQFL3Z2xpnr8HKTdH1I+AqFnGqrmnaKAbFHjJ7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6598
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBBbnNvbiBIdWFuZyA8YW5zb24uaHVhbmdAbnhwLmNvbT4NCj4gU2VudDogRnJpZGF5
LCBBcHJpbCAyNCwgMjAyMCAxMDozMyBBTQ0KPiANCj4gPiBTdWJqZWN0OiBSRTogW1BBVENIXSBt
YWlsYm94OiBpbXg6IEFkZCBjb250ZXh0IHNhdmUvcmVzdG9yZSBmb3INCj4gPiBzdXNwZW5kL3Jl
c3VtZQ0KPiA+DQo+ID4gPiBGcm9tOiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4N
Cj4gPiA+IFNlbnQ6IEZyaWRheSwgQXByaWwgMjQsIDIwMjAgNzowMSBBTQ0KPiA+ID4NCj4gPiA+
IEZvciAibWVtIiBtb2RlIHN1c3BlbmQgb24gaS5NWDggU29DcywgTVUgc2V0dGluZ3MgY291bGQg
YmUgbG9zdA0KPiA+ID4gYmVjYXVzZSBpdHMgcG93ZXIgaXMgb2ZmLCBzbyBzYXZlL3Jlc3RvcmUg
aXMgbmVlZGVkIGZvciBNVSBzZXR0aW5ncw0KPiA+ID4gZHVyaW5nDQo+ID4gc3VzcGVuZC9yZXN1
bWUuDQo+ID4gPiBIb3dldmVyLCB0aGUgcmVzdG9yZSBjYW4gT05MWSBiZSBkb25lIHdoZW4gTVUg
c2V0dGluZ3MgYXJlIGFjdHVhbGx5DQo+ID4gPiBsb3N0LCBmb3IgdGhlIHNjZW5hcmlvIG9mIHNl
dHRpbmdzIE5PVCBsb3N0IGluICJmcmVlemUiIG1vZGUNCj4gPiA+IHN1c3BlbmQsIHNpbmNlIHRo
ZXJlIGNvdWxkIGJlIHN0aWxsIElQQyBnb2luZyBvbiBtdWx0aXBsZSBDUFVzLA0KPiA+ID4gcmVz
dG9yaW5nIHRoZSBNVSBzZXR0aW5ncyBjb3VsZCBvdmVyd3JpdGUgdGhlIFRJRSBieSBtaXN0YWtl
IGFuZA0KPiA+ID4gY2F1c2Ugc3lzdGVtIGZyZWV6ZSwgc28gbmVlZCB0byBtYWtlIHN1cmUgT05M
WSByZXN0b3JlIHRoZSBNVQ0KPiA+ID4gc2V0dGluZ3Mgd2hlbiBpdCBpcw0KPiA+IHBvd2VyZWQg
b2ZmLg0KPiA+ID4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IEFuc29uIEh1YW5nIDxBbnNvbi5IdWFu
Z0BueHAuY29tPg0KPiA+DQo+ID4gQXMgbWVudGlvbmVkIGJlZm9yZSwgd2UnZCBiZXR0ZXIga2Vl
cCB0aGUgb3JpZ2luYWwgYXV0aG9yLg0KPiA+DQo+ID4gPiAtLS0NCj4gPiA+ICBkcml2ZXJzL21h
aWxib3gvaW14LW1haWxib3guYyB8IDM1DQo+ID4gPiArKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKw0KPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAzNSBpbnNlcnRpb25zKCspDQo+ID4g
Pg0KPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWFpbGJveC9pbXgtbWFpbGJveC5jDQo+ID4g
PiBiL2RyaXZlcnMvbWFpbGJveC9pbXgtbWFpbGJveC5jIGluZGV4IDk3YmYwYWMuLmI1M2NmNjMg
MTAwNjQ0DQo+ID4gPiAtLS0gYS9kcml2ZXJzL21haWxib3gvaW14LW1haWxib3guYw0KPiA+ID4g
KysrIGIvZHJpdmVycy9tYWlsYm94L2lteC1tYWlsYm94LmMNCj4gPiA+IEBAIC02Nyw2ICs2Nyw4
IEBAIHN0cnVjdCBpbXhfbXVfcHJpdiB7DQo+ID4gPiAgCXN0cnVjdCBjbGsJCSpjbGs7DQo+ID4g
PiAgCWludAkJCWlycTsNCj4gPiA+DQo+ID4gPiArCXUzMiB4Y3I7DQo+ID4gPiArDQo+ID4gPiAg
CWJvb2wJCQlzaWRlX2I7DQo+ID4gPiAgfTsNCj4gPiA+DQo+ID4gPiBAQCAtNTgzLDEyICs1ODUs
NDUgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQNCj4gPiA+IGlteF9tdV9kdF9p
ZHNbXSA9IHsgIH07ICBNT0RVTEVfREVWSUNFX1RBQkxFKG9mLCBpbXhfbXVfZHRfaWRzKTsNCj4g
PiA+DQo+ID4gPiArc3RhdGljIGludCBpbXhfbXVfc3VzcGVuZF9ub2lycShzdHJ1Y3QgZGV2aWNl
ICpkZXYpIHsNCj4gPiA+ICsJc3RydWN0IGlteF9tdV9wcml2ICpwcml2ID0gZGV2X2dldF9kcnZk
YXRhKGRldik7DQo+ID4gPiArDQo+ID4gPiArCXByaXYtPnhjciA9IGlteF9tdV9yZWFkKHByaXYs
IHByaXYtPmRjZmctPnhDUik7DQo+ID4gPiArDQo+ID4gPiArCXJldHVybiAwOw0KPiA+ID4gK30N
Cj4gPiA+ICsNCj4gPiA+ICtzdGF0aWMgaW50IGlteF9tdV9yZXN1bWVfbm9pcnEoc3RydWN0IGRl
dmljZSAqZGV2KSB7DQo+ID4gPiArCXN0cnVjdCBpbXhfbXVfcHJpdiAqcHJpdiA9IGRldl9nZXRf
ZHJ2ZGF0YShkZXYpOw0KPiA+ID4gKw0KPiA+ID4gKwkvKg0KPiA+ID4gKwkgKiBPTkxZIHJlc3Rv
cmUgTVUgd2hlbiBjb250ZXh0IGxvc3QsIHRoZSBUSUUgY291bGQNCj4gPiA+ICsJICogYmUgc2V0
IGR1cmluZyBub2lycSByZXN1bWUgYXMgdGhlcmUgaXMgTVUgZGF0YQ0KPiA+ID4gKwkgKiBjb21t
dW5pY2F0aW9uIGdvaW5nIG9uLCBhbmQgcmVzdG9yZSB0aGUgc2F2ZWQNCj4gPiA+ICsJICogdmFs
dWUgd2lsbCBvdmVyd3JpdGUgdGhlIFRJRSBhbmQgY2F1c2UgTVUgZGF0YQ0KPiA+ID4gKwkgKiBz
ZW5kIGZhaWxlZCwgbWF5IGxlYWQgdG8gc3lzdGVtIGZyZWV6ZS4gVGhpcyBpc3N1ZQ0KPiA+ID4g
KwkgKiBpcyBvYnNlcnZlZCBieSB0ZXN0aW5nIGZyZWV6ZSBtb2RlIHN1c3BlbmQuDQo+ID4gPiAr
CSAqLw0KPiA+ID4gKwlpZiAoIWlteF9tdV9yZWFkKHByaXYsIHByaXYtPmRjZmctPnhDUikpDQo+
ID4gPiArCQlpbXhfbXVfd3JpdGUocHJpdiwgcHJpdi0+eGNyLCBwcml2LT5kY2ZnLT54Q1IpOw0K
PiA+DQo+ID4gVGhpcyBjb3VsZCBiZSBzZXBhcmF0ZSBwYXRjaCBpZiBpdCBhaW1zIHRvIGZpeCBh
IHNwZWNpZmljIGNvcm5lciBjYXNlLg0KPiANCj4gVGhpcyBpcyBOT1QgY29ybmVyIGNhc2UsIGl0
IGNhbiBiZSByZXByb2R1Y2VkIHdpdGggb3VyIGlteF81LjQueSB2ZXJ5IGVhc2lseSwgYW5kDQo+
IHRoaXMgaXNzdWUgY2F1c2UgbWUgbWFueSBkYXlzIHRvIGRlYnVnLi4uQWxzbyBjYXVzZSBDbGFy
aydzIGVmZm9ydCB0byBoZWxwIHRlc3QgaXQNCj4gYSBsb3QgZm9yIG1hbnkgZGF5cy4uLg0KPiAN
Cg0KSXMgdGhpcyBpc3N1ZSBvbmx5IGhhcHBlbiBmb3Igbm9uLXN0YXRlIGxvc3QgY2FzZSAoZWcu
IEZyZWV6ZSBtb2RlKT8NCklmIHllcywgaXQncyBhIHNwZWNpZmljIGNhc2UgYW5kIHdvcnRoIGEg
c2VwYXJhdGUgcGF0Y2ggdG8gaGlnaGxpZ2h0IGl0IElNSE8uDQoNCkJUVywgaXQgc2VlbXMgbW9z
dCBkcml2ZXJzIGhhdmUgdGhpcyBpc3N1ZSBpbiBjdXJyZW50IGtlcm5lbCBiZWNhdXNlIHRoZXkg
ZG9uJ3Qga25vdw0Kd2hldGhlciB0aGUgc3RhdGUgYXJlIHJlYWxseSBsb3N0LCBpdCBzZWVtcyBs
aWtlIGtlcm5lbCBzdGlsbCBkb2Vzbid0IHN1cHBvcnQgdGhpcyB3ZWxsLg0KDQo+IEkgZG8gTk9U
IHRoaW5rIGl0IG1ha2VzIHNlbnNlIHRvIGZpcnN0IHNlbmQgb3V0IHlvdXIgcGF0Y2ggd2l0aCBi
dWcgZm9yIHJldmlldywNCj4gQW5kIHRoZW4gYWRkIGFub3RoZXIgcGF0Y2ggdG8gZml4IGl0LiAx
IHBhdGNoIGlzIGVub3VnaCBmb3IgdGhpcyBmZWF0dXJlLg0KPiANCg0KQW55d2F5LCBpZiB5b3Ug
cmVhbGx5IHdhbnQgdG8gZ28gd2l0aCBvbmUgcGF0Y2gsIGZvciB0aGlzIGNhc2UsIHdlIHVzdWFs
bHkgY291bGQNCmtlZXAgb3JpZ2luYWwgYXV0aG9yIGFuZCBhZGQgYSBzbWFsbCBmaXggbm90ZSBp
biBjb21taXQgbWVzc2FnZS4NCihZb3UgY291bGQgc2VlIG1hbnkgY29tbXVuaXR5IGd1eXMgZG8g
bGlrZSB0aGlzIGlmIHlvdSBzZWFyY2gga2VybmVsIGNvbW1pdCBsb2cpDQoNCkJhc2ljYWxseSB3
ZSB0cnkgb3VyIGJlc3QgdG8ga2VlcCBvcmlnaW4gYXV0aG9yIGluIG9yZGVyIHRvIHJlc3BlY3Qg
b3RoZXJzJyB3b3JrDQpmb3IgY29tbXVuaXR5IHdvcmsuDQoNClJlZ2FyZHMNCkFpc2hlbmcNCg0K
PiANCg0K
