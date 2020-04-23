Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D08C1C54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 14:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A07B620781
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 14:03:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="E4hMR6c+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728754AbgDWODP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 10:03:15 -0400
Received: from mail-db8eur05on2045.outbound.protection.outlook.com ([40.107.20.45]:15070
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728747AbgDWODN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 10:03:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XgWicg+YLdUDdggwHOnKhpiFyQRHMB8dQNgOUsGUb7ws6/cbmxLtdj+wu41eOeNuXheu6TyygvtVmortF9wP0Qq2xICFq+2Dl4ujzqmPBplQ9dDXHvRRfN8oxjy5l4fIuv59iPfgyLByHoYCzjWXqnfeQ+ZnmcgxSnv26T8qPDI0yKp/xIH5RoA0akVImOxWCKnjjbXHq7fGGFOw8P3KT94weEvZwV4eeDxgHhJT8/PnNuG84U/nTwLUjUosVs0aNFs3VxdJCWyWEkSnadOqjpJVVf06adVGehQ7T4RVD+S3AHfXce9XwDfOWfyiEIVyi3/SRzzWmjOMQtIVboPBSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sHvfHf+dTuu9Hr1PcZtrVKkvrJ+MzOeekC/JPrn6dQM=;
 b=mpiGVHSzmodck5Bsbs85PGkcQUDtMN6JMhewrwG3QGxIXevUVDgRERiEm/I9eDWSLJmiCMHk2Eur3aOUpmcswEMGZQa2GjTMuQnQ4nFwVc/5zXL68vPXFwd/Dr6N8HyT6C8HYcNoAQLiNLHgQy0EMcZeyzdblRAvfJSUmbqvR8tv9nQneo36N1pqwK5gIhGiY0tnv4aUCPjcH7hOuONava94zPiSMzGclZ5L6jwCnbtmBRN1Q7RGEeOK7cLEp+BsrQq7meDcu+C2mkjbU9YS1I+mgdxgvqNmqQ8mYpeH3N68JP6rFF4/wY355rFW6IOIXywwG1EYKq1guDpRKVmzUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sHvfHf+dTuu9Hr1PcZtrVKkvrJ+MzOeekC/JPrn6dQM=;
 b=E4hMR6c+5jL8fF+okz42RXy2y2ZO9lVwBYawxbLh0lcl8uI0616s8mQft3KQ1wZLV/fvSJOlmRb+J+1SUzmABU1061yrft8qoZ2N9Z4ARIqfJzKVmOCFeIxTzQ7BDFGlF85mFkzoaLeajB891euZokrk3h5mxf/pCs6G21VX2jk=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR04MB5574.eurprd04.prod.outlook.com (2603:10a6:20b:28::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25; Thu, 23 Apr
 2020 14:03:09 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::d9f7:5527:e89d:1ae3]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::d9f7:5527:e89d:1ae3%7]) with mapi id 15.20.2921.032; Thu, 23 Apr 2020
 14:03:09 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Peng Fan <peng.fan@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "sboyd@kernel.org" <sboyd@kernel.org>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] clk: imx: introduce imx_clk_hw_critical
Thread-Topic: [PATCH] clk: imx: introduce imx_clk_hw_critical
Thread-Index: AQHWGTz23ipTFSUpC02goIyCROLLPKiGhOhwgAADf4CAADHRcA==
Date:   Thu, 23 Apr 2020 14:03:09 +0000
Message-ID: <AM6PR04MB4966460FE849E557FDA754F980D30@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <1587624748-27228-1-git-send-email-peng.fan@nxp.com>
 <AM6PR04MB4966934EE0411F7C3FF5AA2F80D30@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <DB6PR0402MB2760793865AA2E67E1C33F4488D30@DB6PR0402MB2760.eurprd04.prod.outlook.com>
In-Reply-To: <DB6PR0402MB2760793865AA2E67E1C33F4488D30@DB6PR0402MB2760.eurprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: baa6ea68-eb7e-4b7a-9b4e-08d7e78f0de3
x-ms-traffictypediagnostic: AM6PR04MB5574:|AM6PR04MB5574:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB557473605EEEB55FEDE559B780D30@AM6PR04MB5574.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 03827AF76E
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(366004)(376002)(136003)(346002)(396003)(39860400002)(8936002)(81156014)(52536014)(55016002)(44832011)(4326008)(33656002)(478600001)(2906002)(186003)(6506007)(66446008)(71200400001)(26005)(53546011)(8676002)(9686003)(66476007)(66556008)(5660300002)(316002)(66946007)(110136005)(64756008)(7696005)(76116006)(86362001)(54906003);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FjwE3CzBZOvdC/ZBmRiA43cw0EHAgNISrzhvAxatCevLzqCfK2pgvyDvTpFPjanuFs9TSkklsNymog5SDpJjwu4253MjmUNg86kVgv4vBlzWWIetCEBWnjQ31xBBeQ8kqNuTqbmdxtdg1camW8jSbXVGAt3SOYk1Do8mODHqbZlzGa21EEf+lvPcE/0s7Bm9pvLJLL7wG17tKSEKNMKv3DEKCWyrH24hwqv4EdMrEbYLJK+b6qi1H9rPYIx8DVD1th7UfcYKANSR8nytm6MKO6P09oZPbhWrw6bYYjo+OShRB5/YilhOPTZhP6zJyBxU9d9R8LKnA2ScADC+KMKvJll1JENJcbx2c/v0xDIk4xjP2wRKhnIskqsh08dJ2xe3bmEPLuHeYf166BUfwmTKAgqAbLalTDX5XvooT17Wolz7aXWtL9AH47vDqgedB1de
x-ms-exchange-antispam-messagedata: 5zoC3G1VKAyVWv2HUlBmdO6ypHrOWbA8C7MtSY0RqKUJ7REq3lVe4Gsj8lXJ4AorEVckjxKQYhfvQmb7Uxpd3rBHg+mIYlXZ/OvnQijE7hWAWfa1x4fh8m1+eXvtLrNS7bffgyEbhm4mJdeL2ZZ41w==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: baa6ea68-eb7e-4b7a-9b4e-08d7e78f0de3
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2020 14:03:09.4506
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +90AjBlKnnaXdpN5OCIk9qb8e8yjiiB8UKh2dIt3rux/Mg3j5LxQ3s2EZrzGmePyL+y7y0Z3BfzMk/3VzOJ6Lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5574
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIEFw
cmlsIDIzLCAyMDIwIDY6NTQgUE0NCj4gDQo+ID4gU3ViamVjdDogUkU6IFtQQVRDSF0gY2xrOiBp
bXg6IGludHJvZHVjZSBpbXhfY2xrX2h3X2NyaXRpY2FsDQo+ID4NCj4gPiA+IEZyb206IFBlbmcg
RmFuIDxwZW5nLmZhbkBueHAuY29tPg0KPiA+ID4gU2VudDogVGh1cnNkYXksIEFwcmlsIDIzLCAy
MDIwIDI6NTIgUE0NCj4gPiA+DQo+ID4gPiBUbyBpLk1YOE0gU29DLCB0aGVyZSBpcyBhbiBjYXNl
IGlzIHdoZW4gcnVubmluZyBkdWFsIE9TZXMgd2l0aA0KPiA+ID4gaHlwZXJ2aXNvciwgdGhlIGNs
ayBvZiB0aGUgaGFyZHdhcmUgdGhhdCBwYXNzdGhyb3VnaCB0byB0aGUgMm5kIE9TDQo+ID4gPiBu
ZWVkcyB0byBiZSBzZXR1cCBieSAxc3QgTGludXggT1MuDQo+ID4gPiBTbyBkZXRlY3QgY2xvY2st
Y3JpdGljYWwgZnJvbSBjY20gbm9kZSBhbmQgZW5hYmxlIHRoZSBjbG9ja3MgdG8gbGV0DQo+ID4g
PiB0aGUgMm5kIE9TIGNvdWxkIHVzZSB0aGUgaGFyZHdhcmUgd2l0aG91dCB0b3VjaCBDQ00gbW9k
dWxlLg0KPiA+ID4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAu
Y29tPg0KPiA+ID4gLS0tDQo+ID4gPiAgZHJpdmVycy9jbGsvaW14L2Nsay5jIHwgMTkgKysrKysr
KysrKysrKysrKysrKw0KPiA+ID4gZHJpdmVycy9jbGsvaW14L2Nsay5oDQo+ID4gPiB8ICAxDQo+
ID4gPiArDQo+ID4gPiAgMiBmaWxlcyBjaGFuZ2VkLCAyMCBpbnNlcnRpb25zKCspDQo+ID4gPg0K
PiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL2lteC9jbGsuYyBiL2RyaXZlcnMvY2xrL2lt
eC9jbGsuYyBpbmRleA0KPiA+ID4gODdhYjhkYjNkMjgyLi5lYzdkNDIyNTQwYzEgMTAwNjQ0DQo+
ID4gPiAtLS0gYS9kcml2ZXJzL2Nsay9pbXgvY2xrLmMNCj4gPiA+ICsrKyBiL2RyaXZlcnMvY2xr
L2lteC9jbGsuYw0KPiA+ID4gQEAgLTE3NywzICsxNzcsMjIgQEAgc3RhdGljIGludCBfX2luaXQg
aW14X2Nsa19kaXNhYmxlX3VhcnQodm9pZCkNCj4gPiA+ICAJcmV0dXJuIDA7DQo+ID4gPiAgfQ0K
PiA+ID4gIGxhdGVfaW5pdGNhbGxfc3luYyhpbXhfY2xrX2Rpc2FibGVfdWFydCk7DQo+ID4gPiAr
DQo+ID4gPiAraW50IGlteF9jbGtfaHdfY3JpdGljYWwoc3RydWN0IGRldmljZV9ub2RlICpucCwg
c3RydWN0IGNsa19odyAqDQo+ID4gPiArY29uc3QNCj4gPiA+ICtod3NbXSkgew0KPiA+ID4gKwlz
dHJ1Y3QgcHJvcGVydHkgKnByb3A7DQo+ID4gPiArCWNvbnN0IF9fYmUzMiAqY3VyOw0KPiA+ID4g
Kwl1MzIgaWR4Ow0KPiA+ID4gKwlpbnQgcmV0Ow0KPiA+ID4gKw0KPiA+ID4gKwlpZiAoIW5wIHx8
ICFod3MpDQo+ID4gPiArCQlyZXR1cm4gLUVJTlZBTDsNCj4gPiA+ICsNCj4gPiA+ICsJb2ZfcHJv
cGVydHlfZm9yX2VhY2hfdTMyKG5wLCAiY2xvY2stY3JpdGljYWwiLCBwcm9wLCBjdXIsIGlkeCkg
ew0KPiA+DQo+ID4gSXMgdGhlcmUgYSBiaW5kaW5nIGZvciBpdCBhbHJlYWR5Pw0KPiANCj4gSSB0
aGluayBjbG9jay1jcml0aWNhbCBpcyBhIGNvbW1vbiBiaW5kaW5ncz8gU2VlIG9mX2Nsa19kZXRl
Y3RfY3JpdGljYWwuDQo+IFBsZWFzZSByZXZpZXcgd2hldGhlciB0aGlzIGFwcHJvYWNoIGlzIGFj
Y2VwdGFibGUsIGlmIGRvIG5lZWQgYmluZGluZ3MsIEkgY291bGQNCj4gYWRkIHRoYXQgaW4gdjIu
DQo+IA0KDQpJJ20gb2sgaWYgaXQncyBhIGNvbW1vbiBiaW5kaW5nIGFscmVhZHkgc3VwcG9ydGVk
IGJ5IGN1cnJlbnQgY2xrIGZyYW1ld29yay4NCkJ1dCBpdCBzZWVtcyB0byBiZSBtb3JlIGxpa2Ug
YSBjb21tb24gY2xrIGZlYXR1cmUgcmF0aGVyIHRoYW4gcGxhdGZvcm0gZmVhdHVyZS4NCkFsc28g
YSBiaXQgc3RyYW5nZSB0aGF0IHdoeSBJIGRpZCBub3QgZmluZCB0aGUgYmluZGluZyBkb2MgaW4g
bGF0ZXN0IGtlcm5lbC4NCk1heWJlIFN0ZXBoZW4gY291bGQgY29tbWVudCBtb3JlLg0KDQpCVFcs
IGlmIHVzaW5nIHRoaXMgZm9yIGR1YWwgT1NlcyBjYXNlLCB3aWxsIHRob3NlIGNyaXRpY2FsIGNs
b2NrcyBhZmZlY3QgdGhlIG5vcm1hbCB1c2VycyB0aGF0DQpub3QgYm9vdGluZyB0aGUgc2Vjb25k
IE9TPw0KDQpSZWdhcmRzDQpBaXNoZW5nDQoNCj4gVGhhbmtzLA0KPiBQZW5nLg0KPiANCj4gPg0K
PiA+IFJlZ2FyZHMNCj4gPiBBaXNoZW5nDQo+ID4NCj4gPiA+ICsJCXJldCA9IGNsa19wcmVwYXJl
X2VuYWJsZShod3NbaWR4XS0+Y2xrKTsNCj4gPiA+ICsJCWlmIChyZXQpDQo+ID4gPiArCQkJcmV0
dXJuIHJldDsNCj4gPiA+ICsJfQ0KPiA+ID4gKw0KPiA+ID4gKwlyZXR1cm4gMDsNCj4gPiA+ICt9
DQo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jbGsvaW14L2Nsay5oIGIvZHJpdmVycy9jbGsv
aW14L2Nsay5oIGluZGV4DQo+ID4gPiBkNGVhMTYwOWJjYjcuLjcwMWQ3NDQwZjk4YyAxMDA2NDQN
Cj4gPiA+IC0tLSBhL2RyaXZlcnMvY2xrL2lteC9jbGsuaA0KPiA+ID4gKysrIGIvZHJpdmVycy9j
bGsvaW14L2Nsay5oDQo+ID4gPiBAQCAtOSw2ICs5LDcgQEAgZXh0ZXJuIHNwaW5sb2NrX3QgaW14
X2NjbV9sb2NrOw0KPiA+ID4NCj4gPiA+ICB2b2lkIGlteF9jaGVja19jbG9ja3Moc3RydWN0IGNs
ayAqY2xrc1tdLCB1bnNpZ25lZCBpbnQgY291bnQpOw0KPiA+ID4gdm9pZCBpbXhfY2hlY2tfY2xr
X2h3cyhzdHJ1Y3QgY2xrX2h3ICpjbGtzW10sIHVuc2lnbmVkIGludCBjb3VudCk7DQo+ID4gPiAr
aW50IGlteF9jbGtfaHdfY3JpdGljYWwoc3RydWN0IGRldmljZV9ub2RlICpucCwgc3RydWN0IGNs
a19odyAqDQo+ID4gPiArY29uc3QgaHdzW10pOw0KPiA+ID4gIHZvaWQgaW14X3JlZ2lzdGVyX3Vh
cnRfY2xvY2tzKHN0cnVjdCBjbGsgKiogY29uc3QgY2xrc1tdKTsgIHZvaWQNCj4gPiA+IGlteF9t
bWRjX21hc2tfaGFuZHNoYWtlKHZvaWQgX19pb21lbSAqY2NtX2Jhc2UsIHVuc2lnbmVkIGludCBj
aG4pOw0KPiA+ID4gdm9pZCBpbXhfdW5yZWdpc3Rlcl9jbG9ja3Moc3RydWN0IGNsayAqY2xrc1td
LCB1bnNpZ25lZCBpbnQgY291bnQpOw0KPiA+ID4gLS0NCj4gPiA+IDIuMTYuNA0KDQo=
