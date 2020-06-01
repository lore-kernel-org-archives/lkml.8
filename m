Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F918C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 03:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB867206E2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 03:53:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hEWezhgW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbgFADx1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 23:53:27 -0400
Received: from mail-eopbgr70074.outbound.protection.outlook.com ([40.107.7.74]:13382
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726002AbgFADx0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 23:53:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OXP5iHVN86O3uknFGVda5bCMI6hHB5qBfSieCMe7RYn6Tw9NF32E9xBewvT8uFkjWZ0q6Xf41l0uNKo0uZiLVMsBAmts8srGrHMul+fTISTceCDwy4IqHDq0t66NaYYuPCbtscexm06T/j2v4L7+rrYMfRTjPYDvPiIZz2a8fDLHGMuwgu+5YKaOmoklHZPA3AbcuBi/LMLWep6boKytz7x8e8WwlyHyF4V8Pkjq0bre8gH0ztzGwYTs1TxQ3Dh3sDvp4Ayr/OtE9hZxGrWR6kJtAizTClrRoKbnhvU9x1rl1zDyxfluMRM8c7qOx5fNdW9i50HfsLMeFLVgHUvXpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XMFa6JO/eRVgUrL4TNdfHh6q/x3V6R19119kuq0ASxs=;
 b=gbhZDk1KXbgayzg2bQMtqUGSY8Xslx67i1YPUOcKDshhdytdOqMxZx6RHTWV42y1wttlxAX1EpSKJRpK/0yNVMeik6rHOJKJTGWEwqt3aEbVFgX8g5VXcvJWHoVHK+afgWrX/xbvuJYxDu8LtyuXZPhTJjThvcJ6wdpzAYDK79NUWRu9M/fkF7g1vf35otfW7oVhLOq6jUTuGCK3H7K3nQX+Uv1DmYvQaCsjjkcyfGEYG6yaMMBHK5fn2SCpw31XPCbizKsCk59ryXZYwa3JtGs/ESBRUXx9rkdpQLSL/FjnLBCFEf2CZUyCDZCOGpcmkB02RpjU5/mvx/8T8Q96dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XMFa6JO/eRVgUrL4TNdfHh6q/x3V6R19119kuq0ASxs=;
 b=hEWezhgW5yE7oxIvbLXz1VXqr3lPzcRJuqNLFa7vu4kOUjBrQg8SwvRC3IN+1wyyvsRqTH4JTIZvADeMA5yt9fa8TghadT9DW/ReF59dkpKJt6CoORPb0w22y31XGipDScqrcoDr1xrmMFgJqV3/oFlXnuE8aeMOG1fFGm4SDfQ=
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com (2603:10a6:20b:118::20)
 by AM7PR04MB7160.eurprd04.prod.outlook.com (2603:10a6:20b:119::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.21; Mon, 1 Jun
 2020 03:53:22 +0000
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::1101:adaa:ee89:af2a]) by AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::1101:adaa:ee89:af2a%3]) with mapi id 15.20.3045.024; Mon, 1 Jun 2020
 03:53:22 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
CC:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: gadget: f_acm: don't disable disabled EP
Thread-Topic: [PATCH] usb: gadget: f_acm: don't disable disabled EP
Thread-Index: AQHWNXESSGSOBa+W40WQH/z+ZHSm4ai+toSAgABgMwCAALdzEIABEuQAgAJEkIA=
Date:   Mon, 1 Jun 2020 03:53:22 +0000
Message-ID: <20200601035346.GA13752@b29397-desktop>
References: <237e4bc8c63680f9ce0388d35b4c34a856ed8595.1590690518.git.mirq-linux@rere.qmqm.pl>
 <20200529081104.GD32755@b29397-desktop> <20200529135524.GA14614@qmqm.qmqm.pl>
 <AM7PR04MB715735B54F24293ABF7B37908B8C0@AM7PR04MB7157.eurprd04.prod.outlook.com>
 <20200530171552.GC16333@qmqm.qmqm.pl>
In-Reply-To: <20200530171552.GC16333@qmqm.qmqm.pl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: rere.qmqm.pl; dkim=none (message not signed)
 header.d=none;rere.qmqm.pl; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 86814ae4-3a49-477d-8240-08d805df544f
x-ms-traffictypediagnostic: AM7PR04MB7160:
x-microsoft-antispam-prvs: <AM7PR04MB7160F679C55C9277F8F80A668B8A0@AM7PR04MB7160.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0421BF7135
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YVV3nCOrg9tZBAdo+52dd0qGLjZy41Q9neR79/jDWWA4GNDavxEsA1+M0oqKyyS5UKJ5YpRntjC9Xot6ZrTUpqM7WOpPBCoz3WKkwp3lSr0im4CfHPp4K1eIDtlaSdyDGC8FfZmLnfbmMuw3XJwGiNpgv9xVs4WgvuAwjlH1QGFYTlH6OEHyjBetDv2IqO2N5PvtHad4DnzMzWcfa1LLXEwhkpXWiJzgTePSayfGt7NndrKgyYqmAYcEUjc6O+gVjOf8I7EjFXO/Gdl5TwXKlUfy28aotMXw83n8KaRtxSOnypzgM7OwxxsvbE0ONAUSjr5A8DV5Adeq+vAJ9sB1qA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7157.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(7916004)(4636009)(346002)(376002)(366004)(39860400002)(136003)(396003)(26005)(6486002)(91956017)(76116006)(53546011)(6506007)(71200400001)(83380400001)(4326008)(33716001)(8676002)(66574014)(316002)(86362001)(54906003)(6916009)(8936002)(1076003)(44832011)(33656002)(64756008)(66446008)(66476007)(186003)(478600001)(2906002)(6512007)(66556008)(66946007)(5660300002)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: yZYNEruk3z94IHyVhK8kGN7tmJpzfPtFq7nTZHjiM1J3BjNmfwUGaDBi/6ZdhvPLrnPHnhvLo5lD9KND/GXAnqaQsPrrq9/8xWaPuXL0NrkkYZg4t1vkO0VSHN7sOuojuSIeyiB4JuXWoaOC4XEh/jbXrdk0baaby6zNOlTBzROh26Fv+usCjhBVNmbKkK1Qrtt8DqOo8zIzRUlCS5ecJ3wE+KeRee9QU6Smg+nw9RWE6hu/KUWwNBiXuAETdunmOrUTIrpsiO/LKfgUpdyTklpdvWPDAchRDlrqbM5hTiP1cPof0QM1V6RHwcbRvW1Nw9cr5ow1+6lWadmtLat5lRbFLRULkO1b6sFHJgVFXUHPfJOO9MMsiitoX7BHEq+pqXiugiXfJZdyB7uVTd4bnGwHu13g89/Nf03Hb9nXtcjjA1c0P8TRz5FD/xKE80wH9KEM4Q4UEvxoWE75QI4bDW+peAs1uJoTypWvoep9/es=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <127836C7B08B7C4588F58FA16F149E38@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86814ae4-3a49-477d-8240-08d805df544f
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2020 03:53:22.2371
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0LlTY0cAExxTDFfyPvcvfrS7anMZGZ0Y3KQWaUf+ZvVT07qUy6gOqdexqwY4sYCJM9W7QQZv5SjY3Sv4DhhNCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7160
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAtMDUtMzAgMTk6MTU6NTIsIE1pY2hhxYIgTWlyb3PFgmF3IHdyb3RlOg0KPiBPbiBTYXQs
IE1heSAzMCwgMjAyMCBhdCAwMTowMzoxN0FNICswMDAwLCBQZXRlciBDaGVuIHdyb3RlOg0KPiA+
ICANCj4gPiA+ID4gPiBAQCAtNDI1LDkgKzQyNSwxMSBAQCBzdGF0aWMgaW50IGFjbV9zZXRfYWx0
KHN0cnVjdCB1c2JfZnVuY3Rpb24gKmYsIHVuc2lnbmVkDQo+ID4gPiBpbnRmLCB1bnNpZ25lZCBh
bHQpDQo+ID4gPiA+ID4gIAkvKiB3ZSBrbm93IGFsdCA9PSAwLCBzbyB0aGlzIGlzIGFuIGFjdGl2
YXRpb24gb3IgYSByZXNldCAqLw0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gIAlpZiAoaW50ZiA9PSBh
Y20tPmN0cmxfaWQpIHsNCj4gPiA+ID4gPiAtCQlkZXZfdmRiZygmY2Rldi0+Z2FkZ2V0LT5kZXYs
DQo+ID4gPiA+ID4gLQkJCQkicmVzZXQgYWNtIGNvbnRyb2wgaW50ZXJmYWNlICVkXG4iLCBpbnRm
KTsNCj4gPiA+ID4gPiAtCQl1c2JfZXBfZGlzYWJsZShhY20tPm5vdGlmeSk7DQo+ID4gPiA+ID4g
KwkJaWYgKGFjbS0+bm90aWZ5LT5lbmFibGVkKSB7DQo+ID4gPiA+ID4gKwkJCWRldl92ZGJnKCZj
ZGV2LT5nYWRnZXQtPmRldiwNCj4gPiA+ID4gPiArCQkJCQkicmVzZXQgYWNtIGNvbnRyb2wgaW50
ZXJmYWNlICVkXG4iLCBpbnRmKTsNCj4gPiA+ID4gPiArCQkJdXNiX2VwX2Rpc2FibGUoYWNtLT5u
b3RpZnkpOw0KPiA+ID4gPiA+ICsJCX0NCj4gPiA+ID4NCj4gPiA+ID4gQnV0IGl0IGRvZXMgbm90
IGZpeCBhbnkgaXNzdWVzLCB0aGUgdXNiX2VwX2Rpc2FibGUgY2hlY2tzICdlbmFibGVkJyBmbGFn
Lg0KPiA+ID4gDQo+ID4gPiBJdCBnZW5lcmF0ZXMgc3B1cmlvdXMgdHJhY2UgZXZlbnRzIGlmIHlv
dSBlbmFibGUgdGhlbS4NCj4gPiBZb3UgbWVhbiB0aGUgdHJhY2UgZXZlbnRzIGZyb20gY29yZS5j
PyBJZiBpdCBpcywgd2UgY291bGQgdHJ5IHRvIGltcHJvdmUgaXQNCj4gPiBhbmQgaW5kaWNhdGUg
aXQgaXMgYWxyZWFkeSBlbmFibGVkIG9yIGRpc2FibGVkLg0KPiANCj4gSXQgaXMgaW5kaWNhdGVk
IGluIHJldHVybiBjb2RlLCBidXQgdGhlIHByb2JsZW0gaXMgdGhhdCB0aGlzIGdlbmVyYXRlcw0K
PiBub2lzZSBhbmQgd2FzdGVzIGRlYnVnZ2luZyB0aW1lLiBUaGUgcHJvYmxlbSBJIHdhcyBzZWVp
bmcgbWFuaWZlc3RlZA0KPiBpdHNlbGYgYXMgZGlzYWJsaW5nIGRpc2FibGVkIEVQcyBhbmQgZGVz
eW5jIG9mIEVQIHN0YXRlIGJldHdlZW4gY29yZQ0KPiBhbmQgVURDIGRyaXZlci4gVGhlIHBhdGNo
IGF2b2lkcyB0aGUgbm9pc2UgYW5kIG1ha2VzIHRoZSBjb2RlIG9idmlvdXMuDQo+IChUaGlzIGNo
ZWNrIHdhcyB0aGVyZSBhdCBzb21lIHBvaW50IGluIHRpbWUsIEJUVy4pDQo+IA0KDQpSZXZpZXdl
ZC1ieTogUGV0ZXIgQ2hlbiA8cGV0ZXIuY2hlbkBueHAuY29tPg0KDQoNCg0KLS0gDQoNClRoYW5r
cywNClBldGVyIENoZW4=
