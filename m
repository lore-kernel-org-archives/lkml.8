Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_DBL_ABUSE_MALW autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E47C32771
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 05:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A2E7214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 05:05:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="BToHEjvn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbgA0FFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 00:05:19 -0500
Received: from mail-eopbgr40045.outbound.protection.outlook.com ([40.107.4.45]:2082
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725308AbgA0FFS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 00:05:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bU72Ee8qOGCj2qb3nTNxtRoNndU7Vf7aRJ+CrfUMeOm1XGqUlRv17ddo6XRV7lEhP3xVDf4Vc85xaM5VavccsLLqY5fS7txyfoGsnrEUpepVtwXsabKUtYuD5xls6md057/2n4kPmUb0wwbdvtKHOssEtuqb3b/kgLcP6shdhMrZlqnABPqVwBddGGlpUHsMCt4Rv3JPIShW5d5kntcpCMgYzWQrh2Ngxl+uEnC6HkrE6vz5ADfKHlw5G00AGVjgXbf8EdDsCamCVA4bcWycqWx8iGSZJ+LKuKlYsrjRRU+klJlbNCrwWIGdcqxmudooXUze5j5czPX8FNkH5ag5+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3W4gXg10UPcb4CGIgK2TupZ2ij1EsbWMfKwcIwea5pM=;
 b=bUOzPBfC5jOOvtioybThh/kJhPuXwCFdDFP5+avSPR8REzcOWny8jP7QgmRpe8DJ/ZZ+ahBw4hweHcMoQc4L0nMe4RX0j2P+u8Wb2fgXpeNzfSOXhb1lzpM43yfmSwQ/LpAeRShpR8EqSkEvuxOZF093XnXzVmqBiFSZjqOLSfbRm46M81/TmcR6gmN3HkjMXqAYvEZ1m5rO7opd9nwfzS8/38bfw3nGKMyq5tGe3cDBSaxWMLx3bOjpsQtXiAUvHt4H631xB/yaxBSviZ4y1HLNXgC+JQPTBRF+ybbHL2QJOyvUIXGniYxVzggZ/60S8oqg6B8PNz21AA6lb6dzdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3W4gXg10UPcb4CGIgK2TupZ2ij1EsbWMfKwcIwea5pM=;
 b=BToHEjvnkChIuBugJucDXb9NRsOoWaGitYiLCHTajWp8ls/TTAK7qS+Ie1+y+lfCS3DcRMFX2Wge4gpwvPmOu6vl/l/CrBBAdIWnFHTcatGQPTPeCaBY91w6zKDGlEErzqAouLR6Ac1tGwrJ3zqittUOwikeoggw3KmJlkCLcg4=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5217.eurprd04.prod.outlook.com (20.176.214.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.22; Mon, 27 Jan 2020 05:05:14 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2665.017; Mon, 27 Jan 2020
 05:05:14 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Adam Ford <aford173@gmail.com>, Arnd Bergmann <arnd@arndb.de>
CC:     Abel Vesa <abel.vesa@nxp.com>, Anson Huang <anson.huang@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH] soc: imx: Makefile: only build soc-imx8 when CONFIG_ARM64
Thread-Topic: [PATCH] soc: imx: Makefile: only build soc-imx8 when
 CONFIG_ARM64
Thread-Index: AQHVyrHXB0HrD3qW50ui9P9S7z/H8qfp0NaAgAADRlCAACnrAIABBSNwgACHbgCADn0MAIAEANYw
Date:   Mon, 27 Jan 2020 05:05:14 +0000
Message-ID: <AM0PR04MB4481B8BDAD2CD7376208B5F2880B0@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1578989048-10162-1-git-send-email-peng.fan@nxp.com>
 <20200114081751.3wjbbnaem7lbnn3v@pengutronix.de>
 <AM0PR04MB4481A2FB7E2C56C2386297E888340@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <CAK8P3a3x55A8y9kR34zy8YyRhto8uay7PZGbDAufupiNS3+ihA@mail.gmail.com>
 <AM0PR04MB44813A1D55659658E3FA203188370@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <CAK8P3a29=KWrhO8uu7mMS2gbeCGpkL7Q-xaaUVO2wcVD9MN93g@mail.gmail.com>
 <CAHCN7xKtfKVQeaAg9sjvc3cHjLoAqAX6F-JyvkG5u23w1OG8CA@mail.gmail.com>
In-Reply-To: <CAHCN7xKtfKVQeaAg9sjvc3cHjLoAqAX6F-JyvkG5u23w1OG8CA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 23991152-37aa-4cb4-2b4f-08d7a2e67e54
x-ms-traffictypediagnostic: AM0PR04MB5217:|AM0PR04MB5217:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB5217EFFC89AF1051DC96D1D2880B0@AM0PR04MB5217.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 02951C14DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10001)(10009020)(4636009)(396003)(346002)(366004)(376002)(39860400002)(136003)(189003)(199004)(8936002)(6506007)(71200400001)(53546011)(8676002)(81156014)(81166006)(64756008)(316002)(66446008)(66556008)(66476007)(76116006)(186003)(110136005)(26005)(66946007)(54906003)(52536014)(5660300002)(2906002)(44832011)(45080400002)(478600001)(966005)(33656002)(9686003)(55016002)(86362001)(7696005)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5217;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cE8jb81hETjgHEQgws8vXznhv12Kq1TOzWtYEzUnlB5OGQ6pF4tiq31DYmyXlG9CrqOddnoZHfHnul50l91iWd58aAHZxcZjL4OJpIpFEPeoU5P1kxe0IyOMmPbVpCPD9uFuuFIHI16/JLOJygi4gx6oDtnuhY/qNfydAFilgn8WX64T9HWoiM/ER0dMhwuJwhRerNwOA923+13O7nDKdEZqLZDtIcz94Foe7WMGINpgj33S6GbyxuE1hyjZk9A7B625299ZZc2RWHUmCF3/xkQJN2Owj34pob1+3DLFdC+7Ah+tDvX/eTVn77dTm2Hw2keEtgRBFUh/CFNPCVVNa67ukPo/feKTvQe/YFRmYnQ+y3gofGhZyzo+9fzLQpPDvrKxBqm0632RdAcfAGjR64LoPRI2lhzlc3xW20nRRfbT1S8BOhxt+elb63yIWFZmtllQquJUwFmAg/RyTc+PXijgkZjzQgWuxu2AWjTf9bjS1aKnfwgAZR0Zp/4e1dFjySIvwsgmXGm1WwaN+Wrxlk4gsAGCu2TtiUHtuQkmf6U5bFZwHk7aQK0tNOx8TtFGyYCvL+Jx9umFQ9okg6QRAw==
x-ms-exchange-antispam-messagedata: wa0i9EUA/WmV9Ge6KVY+NhXNxdoVh8MtlDx0XbgZ/CJZFr+8CQ+IlTGRGqyurhLEyo0piyX/1XtyFfbyZFBr+uhVcbX1cCwFlZQB7A3HuIQRkwul9zfFsSu8V864va8nCuB4gXqGmNeOtwCwO//7xg==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23991152-37aa-4cb4-2b4f-08d7a2e67e54
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2020 05:05:14.0724
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5ROtNW56XrtB7JbD6hhkUiRlkGXSvvj/IbEOdwH0AXisshrxErjHJ+UoFa2YYv/1AB7tYdSHzu/pnJgs/AIQLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5217
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIXSBzb2M6IGlteDogTWFrZWZpbGU6IG9ubHkgYnVpbGQgc29j
LWlteDggd2hlbg0KPiBDT05GSUdfQVJNNjQNCj4gDQo+IE9uIFdlZCwgSmFuIDE1LCAyMDIwIGF0
IDQ6MzkgQU0gQXJuZCBCZXJnbWFubiA8YXJuZEBhcm5kYi5kZT4gd3JvdGU6DQo+ID4NCj4gPiBP
biBXZWQsIEphbiAxNSwgMjAyMCBhdCAzOjM4IEFNIFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29t
PiB3cm90ZToNCj4gPiA+ID4gU3ViamVjdDogUmU6IFtQQVRDSF0gc29jOiBpbXg6IE1ha2VmaWxl
OiBvbmx5IGJ1aWxkIHNvYy1pbXg4IHdoZW4NCj4gPiA+ID4gQ09ORklHX0FSTTY0IE9uIFR1ZSwg
SmFuIDE0LCAyMDIwIGF0IDk6MzIgQU0gUGVuZyBGYW4NCj4gPHBlbmcuZmFuQG54cC5jb20+IHdy
b3RlOg0KPiA+ID4gPiA+ID4gU3ViamVjdDogUmU6IFtQQVRDSF0gc29jOiBpbXg6IE1ha2VmaWxl
OiBvbmx5IGJ1aWxkIHNvYy1pbXg4DQo+ID4gPiA+ID4gPiB3aGVuDQo+ID4gPiA+ID4NCj4gPiA+
ID4gPiBUaGVyZSBpcyBubyBTT0NfSU1YOCBjdXJyZW50bHkuIE5lZWQgdG8gaW50cm9kdWNlIG9u
ZSBpbg0KPiA+ID4gPiA+IGFyY2gvYXJtNjQvS2NvbmZpZy5wbGF0Zm9ybXMuIEJ1dCBJIG5vdCBz
ZWUgb3RoZXIgdmVuZG9ycw0KPiA+ID4gPiA+IGludHJvZHVjZSBvcHRpb25zIGxpa2UgU09DX1hY
LiBJcyB0aGlzIHRoZSByaWdodCBkaXJlY3Rpb24gdG8NCj4gPiA+ID4gPiBhZGQgb25lIGluIEtj
b25maWcucGxhdGZvcm1zPw0KPiA+ID4gPg0KPiA+ID4gPiBJIHRoaW5rIGl0IHdvdWxkIGJlIG1v
cmUgY29uc2lzdGVudCB3aXRoIHRoZSBvdGhlciBwbGF0Zm9ybXMgdG8NCj4gPiA+ID4gaGF2ZSBh
IHN5bWJvbCBpbiBkcml2ZXJzL3NvYy9pbXgvS2NvbmZpZyB0byBjb250cm9sIHdoZXRoZXIgd2Ug
YnVpbGQNCj4gdGhhdCBkcml2ZXIuDQo+ID4gPg0KPiA+ID4gT2ssIEknbGwgYWRkIEtjb25maWcg
ZW50cnkgaW4gZHJpdmVycy9zb2MvaW14L0tjb25maWcgZm9yIHZhcmlvdXMgaS5NWCBTb0NzLg0K
PiA+DQo+ID4gSSB3YXMgdGhpbmtpbmcgb2Ygb25lIGVudHJ5IGZvciB0aGlzIGRyaXZlci4NCj4g
Pg0KPiA+ID4gPiBGb3Igc29tZSBTb0NzLCB3ZSBhbHNvIGFsbG93IHJ1bm5pbmcgMzItYml0IGtl
cm5lbHMsIHNvIGl0IHdvdWxkDQo+ID4gPiA+IG5vdCBiZSB3cm9uZyB0byBhbGxvdyBlbmFibGlu
ZyB0aGUgc3ltYm9sIG9uIDMyLWJpdCBBUk0gYXMgd2VsbCwNCj4gPiA+ID4gYnV0IHRoaXMgaXMg
cHJvYmFibHkgc29tZXRoaW5nIHdoZXJlIHlvdSB3YW50IHRvIGNvbnNpZGVyIHRoZQ0KPiA+ID4g
PiBiaWdnZXIgcGljdHVyZSB0byBzZWUgaWYgeW91IHdhbnQgdG8gc3VwcG9ydCB0aGF0IGNvbmZp
Z3VyYXRpb24gb3Igbm90Lg0KPiA+ID4NCj4gPiA+IERvZXMgdGhlIGN1cnJlbnQgdXBzdHJlYW0g
a2VybmVsIHN1cHBvcnQgMzJiaXQga2VybmVscyBvbiBBUk02NA0KPiA+ID4gcGxhdGZvcm1zIHdp
dGhvdXQgdmVuZG9yIHNwZWNpZmljIHN0dWZmLiBJIHJlY2FsbGVkIHRoYXQgc2V2ZXJhbA0KPiA+
ID4geWVhcnMgYWdvLCBOWFAgcGVvcGxlIHRyaWVkIHRvIHVwc3RyZWFtIDMyYml0IGtlcm5lbCBz
dXBwb3J0LCBidXQgcmVqZWN0ZWQNCj4gYnkgeW91Lg0KPiA+DQo+ID4gV2UgaGF2ZSBhdCBsZWFz
dCBzb21lIEJyb2FkY29tIFNvQ3MgdGhhdCBhcmUgc3VwcG9ydGVkIHRoaXMgd2F5LiBBcw0KPiA+
IGxvbmcgYXMgeW91IGNhbiB1c2UgdGhlIHNhbWUgZHRiIGZpbGUgb24gYSByZWd1bGFyIG11bHRp
X3Y3X2RlZmNvbmZpZw0KPiA+IEkgc2VlIG5vIHByb2JsZW0gd2l0aCBkb2luZyB0aGlzLg0KPiA+
DQo+ID4gV2hhdCBJIHdvdWxkIGxpa2UgdG8gYXZvaWQgdGhvdWdoIGFyZSBwb3J0cyB0aGF0IHJl
cXVpcmUgZXh0cmEgY29kZSBpbg0KPiA+IGFyY2gvYXJtL21hY2gtKiB0aGF0IGlzIG5vdCBuZWVk
ZWQgZm9yIHRoZSA2NC1iaXQgdGFyZ2V0LCBvciBwb3J0cyB0bw0KPiA+IDY0LWJpdCBoYXJkd2Fy
ZSB0aGF0IG9ubHkgcnVuIGluIDMyLWJpdCBtb2RlLg0KPiA+DQo+ID4gPiBTbyBJcyB0aGVyZSBh
bnkgcGxhbiB0byBzdXBwb3J0IDMyYml0IGtlcm5lbCBvbiBBQVJDSDY0IGluIHVwc3RyZWFtDQo+
ID4gPiBrZXJuZWw/DQo+ID4gPiBPciBhbnkgc3VnZ2VzdGlvbnM/DQo+ID4NCj4gPiBJIGRvbid0
IHRoaW5rIHRoZXJlIHNob3VsZCBiZSAzMi1iaXQga2VybmVsIHJ1bm5pbmcgaW4gYWFyY2g2NC1p
bHAzMg0KPiA+IG1vZGUuIFRoaXMgd2FzIGRpc2N1c3NlZCB3YXkgYmFjayB3aGVuIHRoZSBhYXJj
aDY0LWlscDMyIHVzZXIgc3BhY2UNCj4gPiBwYXRjaGVzIGZpcnN0IGFwcGVhcmVkLg0KPiA+DQo+
ID4gR2VuZXJhbGx5IHNwZWFraW5nIHlvdSBhcmUgdXN1YWxseSBiZXR0ZXIgb2ZmIHJ1bm5pbmcg
YW4gYWFyY2g2NA0KPiA+IGtlcm5lbCB1c2luZyBhYXJjaDMyIHVzZXIgc3BhY2UsIGJ1dCB0aGVy
ZSBtYXkgYmUgcmVhc29ucyBmb3IgcnVubmluZw0KPiA+IGFuIEFSTXY4IGFhcmNoMzIga2VybmVs
IG9uIHRoZSBzYW1lIGhhcmR3YXJlIGFuZCB0aGVyZSBpcyBubyB0ZWNobmljYWwNCj4gPiByZWFz
b24gd2h5IHRoaXMgc2hvdWxkbid0IHdvcmsgZm9yIGEgY2xlYW4gcG9ydC4NCj4gPg0KPiA+IFdl
IG5ldmVyIHJlYWxseSBzdXBwb3J0ZWQgQVJNdjgtYWFyY2gzMiBpbiBhcmNoL2FybS8gYXMgYSBz
ZXBhcmF0ZQ0KPiA+IHRhcmdldCwgYnV0IHVzdWFsbHkgYnVpbGRpbmcgYW4gQVJNdjcga2VybmVs
IGlzIGNsb3NlIGVub3VnaCB0bw0KPiA+IEFSTXY4LWFhcmNoMzIgdGhhdCB0aGluZ3MganVzdCB3
b3JrLiBJZiB5b3Ugd291bGQgbGlrZSB0byBoZWxwIG91dA0KPiA+IG1ha2luZyBBUk12N1ZFIGFu
ZCBBUk12OC1hYXJjaDY0IHByb3BlciB0YXJnZXRzIGZvciBhcmNoL2FybS8sIGxldCBtZQ0KPiA+
IGtub3cgYW5kIHdlIGNhbiBkaXNjdXNzIHdoYXQgcGFydHMgYXJlIG1pc3NpbmcuDQo+IA0KPiBJ
IHdvdWxkIGJlIGludGVyZXN0ZWQgaW4gbGVhcm5pbmcgbW9yZSBhYm91dCBydW5uaW5nIHRoZSBp
Lk1YOE0gaW4gMzItYml0DQo+IG1vZGUuICBJJ20gbG9va2luZyBhdCBydW5uaW5nIExpbnV4IG9u
IGEgZGV2aWNlIHdpdGggPCAxR0Igb2YgUkFNLCBzbyBoYXZpbmcNCj4gMzItYml0IHBvaW50ZXJz
IGFuZCBpbnN0cnVjdGlvbnMgd291bGQgYmUgcHJlZmVycmVkLg0KPiBNeSBwcmVmZXJlbmNlIHdv
dWxkIGJlIHRvIHJ1biBhcyBBUk12NyBmb3IgbWlncmF0aW9uIHB1cnBvc2VzLCBidXQgSSdtDQo+
IG9wZW4gdG8gYWx0ZXJuYXRpdmVzLg0KPiANCj4gRG9lcyBhbnlvbmUgaGF2ZSBhbnkgc3VnZ2Vz
dGlvbnMgb24gd2hlcmUgSSBtaWdodCBmaW5kIHNvbWUgZ2VuZXJpYyBzdHVmZg0KPiBmb3IgZWl0
aGVyIGlNWDhNIG9yIGdlbmVyaWMgQVJNdjggZG9jcyBmb3IgZG9pbmcgc29tZXRoaW5nIGxpa2Ug
dGhpcz8NCg0KV2UgZGlkIGEgcG9ydGluZyBmb3Igb25lIGN1c3RvbWVyLCBidXQgY29kZSBpcyBu
b3QgcHVibGljIGF2YWlsYWJsZS4NCg0KRmlyc3QgbGV0IHVib290IHN3aXRjaCB0byBBQVJDSDMy
IG1vZGUgd2hlbiBib290aW5nIExpbnV4LCB0aGlzIGlzIGFscmVhZHkNCnN1cHBvcnRlZCBieSB1
Ym9vdCBtYWlsaW5lLg0KDQpTZWNvbmQsIGNyZWF0ZSBhIG1hY2gtaW14OG0uYyB1bmRlciBhcmNo
L2FybS9tYWNoLWlteCB0byBoYW5kbGUgaS5NWDhNDQpqdXN0IGxpa2Ugb3RoZXIgaS5teCBhcm0z
MiBzb2NzLiBUaGlzIGlzIG5vdCBwcmVmZXJyZWQgYnkgTGludXggY29tbXVuaXR5Lg0KDQozcmQs
IGJ1aWxkIGkuTVg4TSBkcml2ZXJzIHdoZW4gdXNpbmcgaW14X3Y3X2RlZmNvbmZpZyggb3IgaW14
X3Y2X3Y3X2RlZmNvbmZpZw0KaW4gdXBzdHJlYW0pDQoNClJlZ2FyZHMsDQpQZW5nLg0KDQo+IA0K
PiBhZGFtDQo+IA0KPiA+DQo+ID4gICAgICBBcm5kDQo+ID4NCj4gPiBfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KPiA+IGxpbnV4LWFybS1rZXJuZWwgbWFp
bGluZyBsaXN0DQo+ID4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnDQo+ID4g
aHR0cHM6Ly9ldXIwMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHAl
M0ElMkYlMkZsaXN0cw0KPiA+IC5pbmZyYWRlYWQub3JnJTJGbWFpbG1hbiUyRmxpc3RpbmZvJTJG
bGludXgtYXJtLWtlcm5lbCZhbXA7ZGF0YT0wMiUNCj4gN0MwDQo+ID4NCj4gMSU3Q3BlbmcuZmFu
JTQwbnhwLmNvbSU3Q2NlNTFlMDczNWZlNTQ3ZmE1NjFmMDhkN2EwZTVhZTIyJTdDNjg2DQo+IGVh
MWQzYmMNCj4gPg0KPiAyYjRjNmZhOTJjZDk5YzVjMzAxNjM1JTdDMCU3QzAlN0M2MzcxNTQ3ODA2
MzczNzE5OTkmYW1wO3NkYXRhDQo+ID1uMXdYJTJGRg0KPiA+DQo+IEZiRHZwY1lwRSUyRkRRWkxB
OG1xaE51Z3RjZ3VpdCUyRjhNbyUyQjJPN1ElM0QmYW1wO3Jlc2VydmVkPQ0KPiAwDQo=
