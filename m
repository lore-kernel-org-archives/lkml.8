Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44CC6C54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 15:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 160CA20781
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 15:21:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rAhJM3ku"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729106AbgDWPVP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 11:21:15 -0400
Received: from mail-eopbgr20046.outbound.protection.outlook.com ([40.107.2.46]:20953
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728990AbgDWPVO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 11:21:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=defTJs7/qtYgV7IeM1LBwfAvSCr9Ks0CRRdoiyVaJtY2uPv3VOei7BOxHm/3bURxDA5oB2r2n67MKNkHcE0L1Wve+RERZaYfOZHm3Do1DbCBKcZEo4xkGqt8SEu4WBHDkCRqxQ9/x2Osdm/1vFCGI01VD2fafDjDA1IJvM5+qRJQ0QSbq9ywmBlj40knhF8JSxfKwE0NyoZtd4814aa1BJLL5uSJPqXWAsX2S2GqrZ/diX9qtVcWvT+dmwYCcIhK6pe/PQm3y1dafv8iMwSObiL+bmri3G1xW6ocL2Sp9nb3w15bCnKHRe8DgZt0noZttzB0LzuAhomZ/oO7WvC7yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9lT8kZPVdbWrnAFtrhb0pR+QflTxtzHRb7aPQscy7tM=;
 b=PJ0QDrB/4FXenIj++zo3ja/oiSHRWhuudq7NiyvpmdJT+mpWDQnKNj6hMEzauS5EDParQOxGVzO7CSP/GxY7Ywg9/eWUvcaeYZs8L71Z237JJk4yufyXbmpuGXF3hp/ggu4bDfRoxc9w1VukVqqFSJiP0w9Z+JhLfeP9yrZjRVqN0Em2gmqoQMakoxHMCzHKFS4AcIXVC9GPxXyN/EiPwnLhffeHFTZJSUZCMHvV9mJgTmRIcnEsTPQri7Tuvhg35LlfKOd+NpzcVCGtvEF0zdgunoULlPF2oxajLFJu9WkszAHnbb/RNs57Q85hNBueIEACqRp0wWRUSmC6VXR3kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9lT8kZPVdbWrnAFtrhb0pR+QflTxtzHRb7aPQscy7tM=;
 b=rAhJM3kuPA95K8okSqM41c1lpbQnMt4jrSeoilSGMuDe/5iOHO2pyDdf1NUG0OwHuuXHUwli+Qo4ihVYwi/Riov2eesrMfcdGi22SZYCcZddsf9s6mZw7wWvOJDmqSLlz0etnmtHvPE7E9fMjj5jzUphK7lLPyjIZ91Uc91WEj8=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR04MB6614.eurprd04.prod.outlook.com (2603:10a6:20b:fe::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Thu, 23 Apr
 2020 15:21:08 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::d9f7:5527:e89d:1ae3]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::d9f7:5527:e89d:1ae3%7]) with mapi id 15.20.2921.032; Thu, 23 Apr 2020
 15:21:08 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Abel Vesa <abel.vesa@nxp.com>, Lee Jones <lee.jones@linaro.org>,
        "arnd@arndb.de" <arnd@arndb.de>
CC:     Shawn Guo <shawnguo@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Anson Huang <anson.huang@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, dl-linux-imx <linux-imx@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v3 01/13] mfd: Add i.MX generic mix support
Thread-Topic: [PATCH v3 01/13] mfd: Add i.MX generic mix support
Thread-Index: AQHWEvxM3XZiF9OGK0STX/aWr983Xqh8+JaAgAfvhwCAAfYF0A==
Date:   Thu, 23 Apr 2020 15:21:08 +0000
Message-ID: <AM6PR04MB4966B3527BF97918C1689A4580D30@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <1586937773-5836-1-git-send-email-abel.vesa@nxp.com>
 <1586937773-5836-2-git-send-email-abel.vesa@nxp.com>
 <20200417080747.GE2167633@dell>
 <20200422091854.rhtkcfrdptwofngs@fsr-ub1664-175>
In-Reply-To: <20200422091854.rhtkcfrdptwofngs@fsr-ub1664-175>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 62467583-c2aa-4775-be7f-08d7e799f305
x-ms-traffictypediagnostic: AM6PR04MB6614:|AM6PR04MB6614:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB66148C7E2C187125E498C9F080D30@AM6PR04MB6614.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 03827AF76E
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(136003)(396003)(366004)(376002)(346002)(86362001)(33656002)(71200400001)(186003)(6506007)(2906002)(26005)(9686003)(7416002)(44832011)(53546011)(8676002)(66476007)(66556008)(64756008)(66446008)(81156014)(316002)(55016002)(5660300002)(8936002)(7696005)(110136005)(66946007)(4326008)(478600001)(54906003)(76116006)(52536014)(41533002)(21314003);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6D26+D9EouuhRlfC8/ZnS8EyLMhE4SMxRjeOAbbRvkGlj7bUUIFajpkTCajk++/4/m64ZTKFkOnCT4USurvrjl/m4tyerUvV8KGdhvX0RLXjJXuXqYP75deMOu8yr/4in/P8+GRfPALmBFGWmvcNSouBNfjViFy4NtVB2IuUl82tjM8L2VV2WPgPDxcdGeU+77wgn6AfCBd+6hyNh/Ga87gqAcy41FSVSeliSB7PWoIOHyMSjUnFcUyKkKCKFIBYtjvoaeHJEAIwUDxSc1J+pTtHShNYiwYbJgKXHhFWMK48sW2eID1s2abuabVhomYBhabPJYmLQkJMTWjiams364hViGmYDHa2v9/sa2T7FOVoKpnjr/XT0oEUpLUIbU6Y6LiimwQ87gkKTsEJwXz8GbSJ2y/G3zXol2wSWT9tmGf4isIHDKcncG3qc1SP1xlrTBqETI03KP4PHExx8j/HHLz+WG7KFE2bW8hEM6SJCw+n0ajHXOrE9A8xTY/MwWaBcd3WfNXO/rWO+N7zQxvaeg==
x-ms-exchange-antispam-messagedata: VRoFd/2COO6LtQ2Ubrgq/8Jjikdv2OyOubxt2VbhT2fBikazrowAtEIFNIcN98yACiEeb3reL1Ycl5Soze+XDm0ceUTHezETbNAZWOLpmY/itISF0yDZFbaqhecYqwupeR+vABb5Bqas8T4Kd56vIA==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62467583-c2aa-4775-be7f-08d7e799f305
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2020 15:21:08.8853
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EmKFUynwHyY7/I6weEtwwd2DXBk9/kVi1cZJjq9IjJcYjlJrlJWJtmXgUgxq/3FnrHE/XB7cbyVtOhF6nmKNGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6614
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBBYmVsIFZlc2EgPGFiZWwudmVzYUBueHAuY29tPg0KPiBTZW50OiBXZWRuZXNkYXks
IEFwcmlsIDIyLCAyMDIwIDU6MTkgUE0NCj4gT24gMjAtMDQtMTcgMDk6MDc6NDcsIExlZSBKb25l
cyB3cm90ZToNCj4gPiBPbiBXZWQsIDE1IEFwciAyMDIwLCBBYmVsIFZlc2Egd3JvdGU6DQo+ID4N
Cj4gPiA+IFNvbWUgb2YgdGhlIGkuTVggU29DcyBoYXZlIGEgSVAgZm9yIGludGVyZmFjaW5nIHRo
ZSBkZWRpY2F0ZWQgSVBzDQo+ID4gPiB3aXRoIGNsb2NrcywgcmVzZXRzIGFuZCBpbnRlcnJ1cHRz
LCBwbHVzIHNvbWUgb3RoZXIgc3BlY2lmaWMgY29udHJvbCByZWdpc3RlcnMuDQo+ID4gPiBUbyBh
bGxvdyB0aGUgZnVuY3Rpb25hbGl0eSB0byBiZSBzcGxpdCBiZXR3ZWVuIGRyaXZlcnMsIHRoaXMg
TUZEDQo+ID4gPiBkcml2ZXIgaXMgYWRkZWQgdGhhdCBoYXMgb25seSB0d28gcHVycG9zZXM6IHJl
Z2lzdGVyIHRoZSBkZXZpY2VzIGFuZA0KPiA+ID4gbWFwIHRoZSBlbnRpcmUgcmVnaXN0ZXIgYWRk
cmVzc2VzLiBFdmVyeXRoaW5nIGVsc2UgaXMgbGVmdCB0byB0aGUNCj4gPiA+IGRlZGljYXRlZCBk
cml2ZXJzIHRoYXQgd2lsbCBiaW5kIHRvIHRoZSByZWdpc3RlcmVkIGRldmljZXMuDQo+ID4gPg0K
PiA+ID4gU2lnbmVkLW9mZi1ieTogQWJlbCBWZXNhIDxhYmVsLnZlc2FAbnhwLmNvbT4NCj4gPiA+
IC0tLQ0KPiA+ID4gIGRyaXZlcnMvbWZkL0tjb25maWcgICB8IDExICsrKysrKysrKysrDQo+ID4g
PiAgZHJpdmVycy9tZmQvTWFrZWZpbGUgIHwgIDEgKw0KPiA+ID4gIGRyaXZlcnMvbWZkL2lteC1t
aXguYyB8IDQ4DQo+ID4gPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysNCj4gPiA+ICAzIGZpbGVzIGNoYW5nZWQsIDYwIGluc2VydGlvbnMoKykNCj4gPiA+
ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9tZmQvaW14LW1peC5jDQo+ID4NCj4gPiBGb3Ig
Y29tcGxldGVuZXNzIC0gQXJuZCdzIHJlcGx5IHRvIHRoaXMgcGF0Y2g6DQo+ID4NCj4gDQo+IEkn
bSByZXBseWluZyBoZXJlIHRvIEFybmQncyByZXBseS4NCj4gDQo+IEknbSB0cnlpbmcgdG8gZ2l2
ZSBoZXJlIGEgd2hvbGUgcGljdHVyZSBvZiB0aGUgZW50aXJlIHByb2JsZW0gd2hpbGUgdGhlDQo+
IGRvY3VtZW50YXRpb24gZm9yIGkuTVg4TVAgaXMgX25vdCB5ZXRfIHB1YmxpYy4NCj4gDQo+IEhp
c3RvcmljYWxseSwgZWFjaCBJUCB3b3VsZCBoYXZlIGl0cyBvd24gZW5jbG9zdXJlIGZvciBhbGwg
dGhlIHJlbGF0ZWQgR1BScy4NCj4gU3RhcnRpbmcgd2l0aCBpLk1YOE1QIHNvbWUgR1BScyAoYW5k
IHNvbWUgc3VicGFydHMpIGZyb20gdGhlIElQIHdlcmUgcGxhY2VkDQo+IGluc2lkZSB0aGVzZSBt
aXhlcy4NCj4gDQo+IEF1ZGlvbWl4IGZvciBleGFtcGxlLCBoYXMgbXVsdGlwbGUgU0FJcywgYSBQ
TEwsIGFuZCBzb21lIHJlc2V0IGJpdHMgZm9yIEVBUkMNCj4gYW5kIHNvbWUgR1BScyBmb3IgQXVk
aW9EU1AuIFRoaXMgbWVhbnMgdGhhdCBpLk1YOE1QIGhhcyA3IFNBSXMsIDEgRUFSQyBhbmQNCj4g
MSBBdWRpb0RTUC4NCj4gRnV0dXJlIHBsYXRmb3JtcyBtaWdodCBoYXZlIGRpZmZlcmVudCBudW1i
ZXJzIG9mIFNBSXMsIEVBUkNzIG9yIEF1ZGlvRFNQcy4NCj4gVGhlIFBMTCBjYW4ndCBiZSBwbGFj
ZWQgaW4gb25lIG9mIHRob3NlIFNBSXMgYW5kIGl0IHdhcyBwbGFjZWQgaW4gYXVkaW9taXguDQo+
IFRoZSBpLk1YOE1QIGhhcyBhdCBsZWFzdCA0IG9mIHRoZXNlIG1peGVzLg0KPiANCj4gTm93LCB0
aGUgY29tbW9uYWxpdGllcyBiZXR3ZWVuIGFsbCBtaXhlcyBhcmU6DQo+ICAtIGhhdmUgdGhlaXIg
b3duIHBvd2VyIGRvbWFpbnMNCj4gIC0gZHJpdmVuIGJ5IGRlZGljYXRlZCBjbG9jayBzbGljZQ0K
PiAgLSBjb250YWluIGNsb2NrcyBhbmQgcmVzZXRzDQo+ICAtIHNvbWUgdmVyeSBzdWJzeXN0ZW0g
c3BlY2lmaWMgR1BScw0KPiANCj4gS25vd2luZyB0aGF0IGVhY2ggbWl4IGhhcyBpdHMgb3duIHBv
d2VyIGRvbWFpbiwgQUZBSUNULCBpdCBuZWVkcyB0byBiZQ0KPiByZWdpc3RlcmVkIGFzIGEgc2lu
Z2xlIGRldmljZS4gQ29uc2lkZXJpbmcgdGhhdCBpdCBjYW4gaGF2ZSBjbG9ja3MgKGF1ZGlvbWl4
IGhhcw0KPiBnYXRlcywgbXV4ZXMgYW5kIHBsbHMpLCBJIGJlbGlldmUgdGhhdCBuZWVkcyBhIGNs
b2NrIGRyaXZlciwgZXZlbiBtb3JlIHNvIHNpbmNlIHRoZQ0KPiBtdXhlcyBuZWVkIHRoZWlyIHBh
cmVudHMgZnJvbSB0aGUgcGxhdGZvcm0gY2xvY2sgZHJpdmVyLiBTYW1lIHByaW5jaXBsZSBhcHBs
aWVzDQo+IHRvIHJlc2V0IGJpdHMuIFRoZSBzdWJzeXN0ZW0gc3BlY2lmaWMgR1BScyBjYW4gYmUg
cmVnaXN0ZXJlZCBhcyBzeXNjb24gZGV2aWNlcw0KPiBhbmQgdGFrZW4gY2FyZSBvZiBieSBpdHMg
Y291bnRlcnBhcnQgSVAgKGUuZy4gdGhlIEF1ZGlvRFNQIHNwZWNpZmljIHJlZ3Mgd291bGQgYmUN
Cj4gdGFrZW4gY2FyZSBvZiBieSB0aGUgRFNQIGRyaXZlciwgaWYgdGhlcmUgaXMgb25lKS4NCj4g
DQo+IE5vdyBiYXNlZCBvbiBhbGwgb2YgdGhlIGFib3ZlLCBieSB1c2luZyBNRkQgd2UgdGFrZSBj
YXJlIG9mIHRoZSBwb3dlciBkb21haW4NCj4gY29udHJvbCBmb3IgdGhlIGVudGlyZSBtaXgsIHBs
dXMsIHRoZSBNRkQgZG9lc24ndCBoYXZlIGFueSBraW5kIG9mIGZ1bmN0aW9uYWxpdHkNCj4gYnkg
aXRzIG93biwgcmVseWluZyBvbiBpdHMgY2hpbGRyZW4gZGV2aWNlcyB0aGF0IGFyZSBwb3B1bGF0
ZWQgYmFzZWQgb24gd2hhdCBpcyBpbg0KPiB0aGUgbWl4IE1GRCBkZXZpY2V0cmVlIG5vZGUuDQo+
IA0KDQpIb3cgYWJvdXQgZG9pbmcgbGlrZSB0aGlzIHdoaWNoIG1heWJlIGNhbiBhZGRyZXNzIEFy
bmQncyBjb25jZXJucz8NCmF1ZGlvbWl4OiBhdWRpb21peEAzMGUyMDAwMCB7DQogICAgICAgIGNv
bXBhdGlibGUgPSAiZnNsLGlteDhtcC1hdWRpb21peCIsICJzeXNjb24iOw0KICAgICAgICByZWcg
PSA8MHgzMGUyMDAwMCB4eHg+LA0KICAgICAgICAgICAgICA8MHgzMGUyMHh4eCB4eHg+Ow0KICAg
ICAgICByZWctbmFtZXMgPSAiYXVkaW8iLCAicmVzZXQiLCAiLi4uIjsNCiAgICAgICAgI2Nsb2Nr
LWNlbGxzID0gPDE+Ow0KICAgICAgICAjcmVzZXQtY2VsbHMgPSA8MT47DQogICAgICAgIHBvd2Vy
LWRvbWFpbnMgPSA8JmF1ZGlvbWl4X3BkPjsNCn0NCg0KVGhhdCBtZWFucyB3ZSBoYXZlIG9uZSBj
b21ibyBkcml2ZXIgcmVnaXN0ZXJpbmcgdHdvIGNvbnRyb2xsZXJzIChjbGsvcmVzZXQpLCBib3Ro
IHVzZQ0KdGhlIHNhbWUgcG93ZXIgZG9tYWluIGFzIGF1ZGlvbWl4Lg0KQW5kIGl0IGNhbiBiZSBl
YXNpbHkgZXh0ZW5kZWQgdG8gc3VwcG9ydCBtb3JlIHNlcnZpY2VzIHByb3ZpZGVkIGJ5IGF1ZGlv
bWl4IG92ZXIgc3lzY29uDQppZiBuZWVkZWQuDQpUaGVuIHRoZSAnZHVtbXknIE1ERiBkcml2ZXIg
aXMgbm90IG5lZWRlZCBhbnltb3JlLg0KDQpKb25lcyAmIEFybmQsDQpIb3cgZG8geW91IHRoaW5r
Pw0KDQpSZWdhcmRzDQpBaXNoZW5nDQoNCj4gPiAtLQ0KPiA+IExlZSBKb25lcyBb5p2O55C85pav
XQ0KPiA+IExpbmFybyBTZXJ2aWNlcyBUZWNobmljYWwgTGVhZA0KPiA+IExpbmFyby5vcmcg4pSC
IE9wZW4gc291cmNlIHNvZnR3YXJlIGZvciBBUk0gU29DcyBGb2xsb3cgTGluYXJvOiBGYWNlYm9v
aw0KPiA+IHwgVHdpdHRlciB8IEJsb2cNCg==
