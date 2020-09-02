Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E9BC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 01:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACDB22068F
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 01:11:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qdTwo9+b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbgIBBLs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 21:11:48 -0400
Received: from mail-eopbgr10042.outbound.protection.outlook.com ([40.107.1.42]:42723
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726116AbgIBBLr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 21:11:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ahqTMmhK8jsEBzpEvz9GKZLQrw7H4QultUKUXE+9i/78smHoS5DFV8bFwbH9fwCzHtZuexuN9BkJKOHtHrF+RkidesK07TM5X1CdWulUk2I3cCaQ1mjE4VFR0sLXMq3CwJNONDjhXMh9Ictqnxi94jRnR1vau4CY/Ee7yzOJU5zpJ61x/0lLG7d183XyAcmgZ7e1tT1c3dsAXI9N3tcbap6b1bb1cF13V3N07VsoaFoljomcEMSEdpxju5tGNOFdEsESd4NkAAAu8Q4PrnkE0LoqPk1TX6BLxAKgN6efp/PgeeGP8aEEXhTZi9H9jAvelODByX4hYxtVa4+cdGwQcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LVel5CFKn3enuJXi3G5UZBPm0RVfarADyvZkjri/44c=;
 b=i+EUPC6wEPt2er/e0ftWh7kvdAIZpABiRm6vVgm21uuYqmop/K+mgJP0uk+ZPyCEJSNpTSBgC5vgcFJCLUFiOtls86Wnyyx9vvpHS2vBe3TY8F2rtlaPjTL/WYm3Z8HyZRG3jA4ZJ8VVSE5wT/awfsNd4rPepK26RL6XvwEZ5f5WFa+omL4Ium5QkzXpYcscxTZvFdBnquRmvWapVrTjUPFrjFnvfbKz9VnuIiA/gmmatA6Aa9agV+M1eYRWP5Z6yV1bVWAuxQJLnQyHSArVyMrf2NVXF1RzaIC/Z3uro4K3uo8kZvhkO09D49ocWTtb5aWllnqKnXDwziO15vUNbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LVel5CFKn3enuJXi3G5UZBPm0RVfarADyvZkjri/44c=;
 b=qdTwo9+b0YgeNJ8cBkA6wCR8OqHdl0A+hEwusx07z/6Bkw/fFL2fB2dSq241XeTC+2wyaO0G7KBSk1P14bKLMhZY9sA0ARiAqgOGr8PMlkyWOT/+gBdtY8tmZ22YXVp46Os7Vp+Qdgk+r1TQAp6h4UXsKbeqoz6fBWOTNp74+LQ=
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB6PR0402MB2934.eurprd04.prod.outlook.com (2603:10a6:4:9b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.23; Wed, 2 Sep
 2020 01:11:42 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::24d0:f783:3c7d:e232]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::24d0:f783:3c7d:e232%12]) with mapi id 15.20.3348.015; Wed, 2 Sep 2020
 01:11:42 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Saravana Kannan <saravanak@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "naresh.kamboju@linaro.org" <naresh.kamboju@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Dong Aisheng <dongas86@gmail.com>,
        "kernel-team@android.com" <kernel-team@android.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] driver core: Fix device_pm_lock() locking for device
 links
Thread-Topic: [PATCH v2] driver core: Fix device_pm_lock() locking for device
 links
Thread-Index: AQHWgI/6qIZbd1A7nUCuQROjaSbDoKlUisOA
Date:   Wed, 2 Sep 2020 01:11:42 +0000
Message-ID: <DB6PR0402MB27601BDD395CC7F5B2D33C0D882F0@DB6PR0402MB2760.eurprd04.prod.outlook.com>
References: <20200901184445.1736658-1-saravanak@google.com>
In-Reply-To: <20200901184445.1736658-1-saravanak@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [49.72.5.245]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f754060d-ada1-4eaf-e7c0-08d84edd274b
x-ms-traffictypediagnostic: DB6PR0402MB2934:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR0402MB2934C405EA33661E73D77D3C882F0@DB6PR0402MB2934.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hA2zjcADqd3slKUatdcwCZEMATH0de6DOYXew87u+3tGe6ss4dWqZitMocyZu2j+kEt0KsHS+L5PmdiDzYnQDGeM2pR+nKoeitMfuzOUWh/NQn8lQgxZTcKeBz/LkyvAQnuInN97cLcPKysW/uBgJ712srixZ7qJCF98ZNxB5vy99Ud4GctEBim7eCmWQJr6X5putx0shaC89f8dsteGAy9S6r61ofLr7nHwYJP4Ex8RB97+tu/lT+ce0K3V0i9fzF/yNoscQ95OmT66MfIq+d7yZhMMoIkd0ZyQ34HnikApg1NK5D9W/+Qrn+rabM/FYZRk3NlmPnxfW8DUgIpAo/WUQZ87gFzeFxjHQWDzabs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(376002)(396003)(136003)(39860400002)(110136005)(2906002)(76116006)(66476007)(316002)(52536014)(54906003)(966005)(6506007)(83380400001)(86362001)(7416002)(66446008)(478600001)(45080400002)(55016002)(9686003)(7696005)(4326008)(66946007)(5660300002)(64756008)(66556008)(71200400001)(26005)(33656002)(8936002)(186003)(44832011)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: FRfpYb1oman6kYEzI75CLeZ6V9zfUo3/jL9E8yk31mw6mp3w2jrsCaECPPWOxC2AUVUiMJvd0ZxzLL0WBhagOFjWLolCZu/uJcreOZdWpUDWDgGt2laxO5GkIWuDttqOEpYsE/74Ets3uBGKXZrqWlQAFFqhjtJufhYGaK9RkEADz/JX9rgrA11plm2D3NWDGTRwoiu0GAQ7GIBuhawp4yxJuqnb3gEtXVS3l5qU4u4q0GzLZyogX/fly2PeOoCupF3Tbnv3GdwisZ1XOfQn/fHSRsNVtrGc7FO8kkFuai4OgbXNfcCoNuzWn+xW6NN/DgDiK24FKXVy/+a06VjTuntt5KDDSFY8h0yCkDsStNY2SkhYWF2VQtCLKJ+Qg1iYQ7CLzTSYm3ydR2f/Z9teLl8lIkCw2k2SkP6ENEX3k7gbSrvqt/80qc9L0+j1I6nFYqnv4vuPdFdTLqgf/wH8X/uqWtWpY4CEq0ny0QelVi8aSnRNbU7T1NEwM6hARCQ1/yAZXmI/7LUIbt8+44jmfUEM3i1GVj1SnlkT0kVft60wwoqVS02yNQM30z2ynFDLsRyDXQNgvJbtSXJq+5OJ8Xqu8TsW0R/c7Ffgw4a5NGk9d6YTPz1BG1WzyMZB/f8d29bobFr5wQX9Oc3Nd29Ekg==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f754060d-ada1-4eaf-e7c0-08d84edd274b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2020 01:11:42.6490
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pyHL8eziF+P5UcBNFoX1T6ghcd9cA6v/H2gtxYWC8r9ZBEx9zBQxhpcxoOhAakB3KUUBrOhcXqLgcbHMJvXKTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2934
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBbUEFUQ0ggdjJdIGRyaXZlciBjb3JlOiBGaXggZGV2aWNlX3BtX2xvY2soKSBs
b2NraW5nIGZvciBkZXZpY2UgbGlua3MNCj4gDQo+IFRoaXMgY29tbWl0IGZpeGVzIHR3byBpc3N1
ZXM6DQo+IA0KPiAxLiBUaGUgbG9ja2RlcCB3YXJuaW5nIHJlcG9ydGVkIGJ5IERvbmcgQWlzaGVu
ZyA8ZG9uZ2FzODZAZ21haWwuY29tPg0KPiBbMV0uDQo+IA0KPiBJdCBpcyBhIHdhcm5pbmcgYWJv
dXQgYSBjeWNsZSAoZHBtX2xpc3RfbXR4IC0tPiBrbi0+YWN0aXZlIzMgLS0+IGZ3X2xvY2spIHRo
YXQNCj4gd2FzIGludHJvZHVjZWQgd2hlbiBkZXZpY2UtbGluayBkZXZpY2VzIHdlcmUgYWRkZWQg
dG8gZXhwb3NlIGRldmljZSBsaW5rDQo+IGluZm9ybWF0aW9uIGluIHN5c2ZzLg0KPiANCj4gVGhl
IHBhdGNoIHRoYXQgImludHJvZHVjZWQiIHRoaXMgY3ljbGUgY2FuJ3QgYmUgcmV2ZXJ0ZWQgYmVj
YXVzZSBpdCdzIGZpeGVzIGENCj4gcmVhbCBTUkNVIGlzc3VlIGFuZCBhbHNvIGVuc3VyZXMgdGhh
dCB0aGUgZGV2aWNlLWxpbmsgZGV2aWNlIGlzIGRlbGV0ZWQgYXMNCj4gc29vbiBhcyB0aGUgZGV2
aWNlLWxpbmsgaXMgZGVsZXRlZC4gVGhpcyBpcyBpbXBvcnRhbnQgdG8gYXZvaWQgc3lzZnMgbmFt
ZQ0KPiBjb2xsaXNpb25zIGlmIHRoZSBkZXZpY2UtbGluayBpcyBjcmVhdGUgYWdhaW4gaW1tZWRp
YXRlbHkgKHRoaXMgY2FuIGhhcHBlbiBhIGxvdA0KPiB3aXRoIGRlZmVycmVkIHByb2JpbmcpLg0K
PiANCj4gMi4gSW5jb25zaXN0ZW5jeSBpbiBncmFiYmluZyBkZXZpY2VfcG1fbG9jaygpIGR1cmlu
ZyBkZXZpY2UgbGluayBkZWxldGlvbg0KPiANCj4gU29tZSBkZXZpY2UgbGluayBkZWxldGlvbiBj
b2RlIHBhdGhzIGdyYWIgZGV2aWNlX3BtX2xvY2soKSwgd2hpbGUgb3RoZXJzDQo+IGRvbid0LiAg
VGhlIGRldmljZV9wbV9sb2NrKCkgaXMgZ3JhYmJlZCBkdXJpbmcgZGV2aWNlX2xpbmtfYWRkKCkg
YmVjYXVzZSBpdA0KPiBjaGVja3MgaWYgdGhlIHN1cHBsaWVyIGlzIGluIHRoZSBkcG1fbGlzdCBh
bmQgYWxzbyByZW9yZGVycyB0aGUgZHBtX2xpc3QuDQo+IEhvd2V2ZXIsIHdoZW4gYSBkZXZpY2Ug
bGluayBpcyBkZWxldGVkLCBpdCBkb2VzIG5vdCBkbyBlaXRoZXIgb2YgdGhvc2UgYW5kDQo+IHRo
ZXJlZm9yZSBkZXZpY2VfcG1fbG9jaygpIGlzIG5vdCBuZWNlc3NhcnkuIERyb3BwaW5nIHRoZSBk
ZXZpY2VfcG1fbG9jaygpDQo+IGluIGFsbCB0aGUgZGV2aWNlIGxpbmsgZGVsZXRpb24gcGF0aHMg
cmVtb3ZlcyB0aGUgaW5jb25zaXN0ZW5jeSBpbiBsb2NraW5nLg0KPiANCj4gVGhhbmtzIHRvIFN0
ZXBoZW4gQm95ZCBmb3IgaGVscGluZyBtZSB1bmRlcnN0YW5kIHRoZSBsb2NrZGVwIHNwbGF0Lg0K
PiANCj4gRml4ZXM6IDg0M2U2MDBiOGEyYiAoImRyaXZlciBjb3JlOiBGaXggc2xlZXBpbmcgaW4g
aW52YWxpZCBjb250ZXh0IGR1cmluZw0KPiBkZXZpY2UgbGluayBkZWxldGlvbiIpIFsxXSAtDQo+
IGh0dHBzOi8vZXVyMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRw
cyUzQSUyRiUyRmxvcmUua2UNCj4gcm5lbC5vcmclMkZsa21sJTJGQ0FBJTJCaEElM0RTNGVBcmVi
N3ZvNjlMQVhTazJ0NSUzRERFS054SGFpWTENCj4gd1NwazR4VHA5dXJMZyU0MG1haWwuZ21haWwu
Y29tJTJGJmFtcDtkYXRhPTAyJTdDMDElN0NwZW5nLmZhbiU0DQo+IDBueHAuY29tJTdDYzA3ZTIz
ZGNjZmE4NGQ5NmIxNzgwOGQ4NGVhNzFiYjklN0M2ODZlYTFkM2JjMmI0YzZmDQo+IGE5MmNkOTlj
NWMzMDE2MzUlN0MwJTdDMCU3QzYzNzM0NTgyNjkyMjU5NDY5OCZhbXA7c2RhdGE9WDBQemINCj4g
bmk1UWNqeE9DV2tmUjl1dnhSY2Z2cHpQUVNOTW1rJTJCSmY5M2RZSSUzRCZhbXA7cmVzZXJ2ZWQ9
MA0KPiBSZXBvcnRlZC1ieTogRG9uZyBBaXNoZW5nIDxkb25nYXM4NkBnbWFpbC5jb20+DQo+IFNp
Z25lZC1vZmYtYnk6IFNhcmF2YW5hIEthbm5hbiA8c2FyYXZhbmFrQGdvb2dsZS5jb20+DQoNClRl
c3RlZC1ieTogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQoNClRoYW5rcywNClBlbmcuDQoN
Cj4gLS0tDQo+IA0KPiBDYydpbmcgZXZlcnlvbmUgZnJvbSB0aGUgb3JpZ2luYWwgdGhyZWFkIFsx
XQ0KPiANCj4gLVNhcmF2YW5hDQo+IA0KPiAgZHJpdmVycy9iYXNlL2NvcmUuYyB8IDQgLS0tLQ0K
PiAgMSBmaWxlIGNoYW5nZWQsIDQgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9iYXNlL2NvcmUuYyBiL2RyaXZlcnMvYmFzZS9jb3JlLmMgaW5kZXgNCj4gZjZmNjIwYWE5
NDA4Li4wN2U1Y2ViNDBiYjEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvYmFzZS9jb3JlLmMNCj4g
KysrIGIvZHJpdmVycy9iYXNlL2NvcmUuYw0KPiBAQCAtODA3LDkgKzgwNyw3IEBAIHN0YXRpYyB2
b2lkIGRldmljZV9saW5rX3B1dF9rcmVmKHN0cnVjdCBkZXZpY2VfbGluaw0KPiAqbGluaykgIHZv
aWQgZGV2aWNlX2xpbmtfZGVsKHN0cnVjdCBkZXZpY2VfbGluayAqbGluaykgIHsNCj4gIAlkZXZp
Y2VfbGlua3Nfd3JpdGVfbG9jaygpOw0KPiAtCWRldmljZV9wbV9sb2NrKCk7DQo+ICAJZGV2aWNl
X2xpbmtfcHV0X2tyZWYobGluayk7DQo+IC0JZGV2aWNlX3BtX3VubG9jaygpOw0KPiAgCWRldmlj
ZV9saW5rc193cml0ZV91bmxvY2soKTsNCj4gIH0NCj4gIEVYUE9SVF9TWU1CT0xfR1BMKGRldmlj
ZV9saW5rX2RlbCk7DQo+IEBAIC04MzAsNyArODI4LDYgQEAgdm9pZCBkZXZpY2VfbGlua19yZW1v
dmUodm9pZCAqY29uc3VtZXIsIHN0cnVjdA0KPiBkZXZpY2UgKnN1cHBsaWVyKQ0KPiAgCQlyZXR1
cm47DQo+IA0KPiAgCWRldmljZV9saW5rc193cml0ZV9sb2NrKCk7DQo+IC0JZGV2aWNlX3BtX2xv
Y2soKTsNCj4gDQo+ICAJbGlzdF9mb3JfZWFjaF9lbnRyeShsaW5rLCAmc3VwcGxpZXItPmxpbmtz
LmNvbnN1bWVycywgc19ub2RlKSB7DQo+ICAJCWlmIChsaW5rLT5jb25zdW1lciA9PSBjb25zdW1l
cikgew0KPiBAQCAtODM5LDcgKzgzNiw2IEBAIHZvaWQgZGV2aWNlX2xpbmtfcmVtb3ZlKHZvaWQg
KmNvbnN1bWVyLCBzdHJ1Y3QNCj4gZGV2aWNlICpzdXBwbGllcikNCj4gIAkJfQ0KPiAgCX0NCj4g
DQo+IC0JZGV2aWNlX3BtX3VubG9jaygpOw0KPiAgCWRldmljZV9saW5rc193cml0ZV91bmxvY2so
KTsNCj4gIH0NCj4gIEVYUE9SVF9TWU1CT0xfR1BMKGRldmljZV9saW5rX3JlbW92ZSk7DQo+IC0t
DQo+IDIuMjguMC40MDIuZzVmZmM1YmU2YjctZ29vZw0KDQo=
