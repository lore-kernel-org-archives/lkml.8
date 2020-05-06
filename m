Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A5A5C38A2A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 11:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 456932070B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 11:27:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727937AbgEFL1T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 07:27:19 -0400
Received: from skedge04.snt-world.com ([91.208.41.69]:38122 "EHLO
        skedge04.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725824AbgEFL1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 07:27:17 -0400
Received: from sntmail11s.snt-is.com (unknown [10.203.32.181])
        by skedge04.snt-world.com (Postfix) with ESMTP id 44AF067A6F2;
        Wed,  6 May 2020 13:27:11 +0200 (CEST)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail11s.snt-is.com
 (10.203.32.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Wed, 6 May 2020
 13:27:10 +0200
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%3]) with mapi id
 15.01.1913.007; Wed, 6 May 2020 13:27:10 +0200
From:   Schrempf Frieder <frieder.schrempf@kontron.de>
To:     Peng Fan <peng.fan@nxp.com>, Lucas Stach <l.stach@pengutronix.de>,
        "Adam Ford" <aford173@gmail.com>,
        Anson Huang <anson.huang@nxp.com>,
        "Christian Gmeiner" <christian.gmeiner@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Jun Li <jun.li@nxp.com>, dl-linux-imx <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        "Russell King" <linux+etnaviv@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "etnaviv@lists.freedesktop.org" <etnaviv@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 3/4] drm/etnaviv: Change order of enabling clocks to
 fix boot on i.MX8MM
Thread-Topic: [RFC PATCH 3/4] drm/etnaviv: Change order of enabling clocks to
 fix boot on i.MX8MM
Thread-Index: AQHWHu1V9EwL5xxa+UiJnz7nneFudaiRmbMAgAAQ8oCAAWBPgIAHyDoA
Date:   Wed, 6 May 2020 11:27:10 +0000
Message-ID: <24a5aceb-9c47-2029-aa5b-8fa7f9ba5670@kontron.de>
References: <20200430124602.14463-1-frieder.schrempf@kontron.de>
 <20200430124602.14463-4-frieder.schrempf@kontron.de>
 <3895f202cf5919e41a56878a62f6d5259dea12d3.camel@pengutronix.de>
 <72e8618b-856e-de42-9282-958cd03b239f@kontron.de>
 <DB6PR0402MB276059A8D612ECBA8812379988AB0@DB6PR0402MB2760.eurprd04.prod.outlook.com>
In-Reply-To: <DB6PR0402MB276059A8D612ECBA8812379988AB0@DB6PR0402MB2760.eurprd04.prod.outlook.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.193]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="utf-8"
Content-ID: <D25527CCBDEB3645AAE31FCF6D268574@snt-world.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: 44AF067A6F2.A23F9
X-SnT-MailScanner: Not scanned: please contact your Internet E-Mail Service Provider for details
X-SnT-MailScanner-SpamCheck: 
X-SnT-MailScanner-From: frieder.schrempf@kontron.de
X-SnT-MailScanner-To: aford173@gmail.com, anson.huang@nxp.com,
        christian.gmeiner@gmail.com, daniel.baluta@nxp.com,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        etnaviv@lists.freedesktop.org, festevam@gmail.com, jun.li@nxp.com,
        kernel@pengutronix.de, l.stach@pengutronix.de,
        leonard.crestez@nxp.com, linux+etnaviv@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, peng.fan@nxp.com,
        s.hauer@pengutronix.de, shawnguo@kernel.org, shengjiu.wang@nxp.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUGVuZywNCg0KT24gMDEuMDUuMjAgMTQ6MzYsIFBlbmcgRmFuIHdyb3RlOg0KPj4gU3ViamVj
dDogUmU6IFtSRkMgUEFUQ0ggMy80XSBkcm0vZXRuYXZpdjogQ2hhbmdlIG9yZGVyIG9mIGVuYWJs
aW5nIGNsb2NrcyB0bw0KPj4gZml4IGJvb3Qgb24gaS5NWDhNTQ0KPj4NCj4+IE9uIDMwLjA0LjIw
IDE2OjM1LCBMdWNhcyBTdGFjaCB3cm90ZToNCj4+PiBBbSBEb25uZXJzdGFnLCBkZW4gMzAuMDQu
MjAyMCwgMTI6NDYgKzAwMDAgc2NocmllYiBTY2hyZW1wZiBGcmllZGVyOg0KPj4+PiBGcm9tOiBG
cmllZGVyIFNjaHJlbXBmIDxmcmllZGVyLnNjaHJlbXBmQGtvbnRyb24uZGU+DQo+Pj4+DQo+Pj4+
IE9uIHNvbWUgaS5NWDhNTSBkZXZpY2VzIHRoZSBib290IGhhbmdzIHdoZW4gZW5hYmxpbmcgdGhl
IEdQVSBjbG9ja3MuDQo+Pj4+IENoYW5naW5nIHRoZSBvcmRlciBvZiBjbG9jayBpbml0YWxpemF0
aW9uIHRvDQo+Pj4+DQo+Pj4+IGNvcmUgLT4gc2hhZGVyIC0+IGJ1cyAtPiByZWcNCj4+Pj4NCj4+
Pj4gZml4ZXMgdGhlIGlzc3VlLiBUaGlzIGlzIHRoZSBzYW1lIG9yZGVyIHVzZWQgaW4gdGhlIGlt
eCBwbGF0Zm9ybSBjb2RlDQo+Pj4+IG9mIHRoZSBkb3duc3RyZWFtIEdQVSBkcml2ZXIgaW4gdGhl
IE5YUCBrZXJuZWwgWzFdLiBGb3IgdGhlIHNha2Ugb2YNCj4+Pj4gY29uc2lzdGVuY3kgd2UgYWxz
byBhZGp1c3QgdGhlIG9yZGVyIG9mIGRpc2FibGluZyB0aGUgY2xvY2tzIHRvIHRoZQ0KPj4+PiBy
ZXZlcnNlLg0KPj4+Pg0KPj4+PiBbMV0NCj4+Pj4gaHR0cHM6Ly9ldXIwMS5zYWZlbGlua3MucHJv
dGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGc291DQo+Pj4+DQo+PiByY2Uu
Y29kZWF1cm9yYS5vcmclMkZleHRlcm5hbCUyRmlteCUyRmxpbnV4LWlteCUyRnRyZWUlMkZkcml2
ZXJzJTJGDQo+PiBteA0KPj4+Pg0KPj4gYyUyRmdwdS12aXYlMkZoYWwlMkZvcyUyRmxpbnV4JTJG
a2VybmVsJTJGcGxhdGZvcm0lMkZmcmVlc2NhbGUlMkZnYw0KPj4gX2gNCj4+Pj4NCj4+IGFsX2tl
cm5lbF9wbGF0Zm9ybV9pbXguYyUzRmglM0RpbXhfNS40LjNfMi4wLjAlMjNuMTUzOCZhbXA7ZGF0
YT0wMg0KPj4gJTdDDQo+Pj4+DQo+PiAwMSU3Q3BlbmcuZmFuJTQwbnhwLmNvbSU3Q2RjN2RhNTNm
NjY1ZTRmNTY3ZTMwMDhkN2VkMWMyN2UwJTdDNg0KPj4gODZlYTFkMw0KPj4+Pg0KPj4gYmMyYjRj
NmZhOTJjZDk5YzVjMzAxNjM1JTdDMCU3QzAlN0M2MzcyMzg1Nzc0OTc5Njk3ODcmYW1wO3NkYQ0K
Pj4gdGE9UVJIenUNCj4+Pj4gQzZnU0t5JTJGNnkyRlRSdmxORjV0N0RtSkl2VGdCRVNZS2NoSSUy
RkR3JTNEJmFtcDtyZXNlcnZlZD0wDQo+Pj4NCj4+PiBJIGRvbid0IHNlZSB3aHkgdGhlIG9yZGVy
IG9mIHRoZSBjbG9ja3MgaXMgaW1wb3J0YW50LiBJcyB0aGlzIHJlYWxseSBhDQo+Pj4gR1BVIGlz
c3VlPyBBcyBpbjogZG9lcyBhIEdQVSBhY2Nlc3MgaGFuZyB3aGVuIGVuYWJsaW5nIHRoZSBjbG9j
a3MgaW4NCj4+PiB0aGUgd3Jvbmcgb3JkZXI/IE9yIGlzIHRoaXMgYSBjbG9jayBkcml2ZXIgaXNz
dWUgd2l0aCBhIGNsb2NrIGFjY2Vzcw0KPj4+IGhhbmdpbmcgZHVlIHRvIGFuIHVwc3RyZWFtIGNs
b2NrIHN0aWxsIGJlaW5nIGRpc2FibGVkPw0KPj4NCj4+IEFjdHVhbGx5IHlvdSBtaWdodCBiZSBy
aWdodCB3aXRoIHRoaXMgYmVpbmcgYSBjbG9jayBkcml2ZXIgaXNzdWUuIFRoZSBoYW5naW5nDQo+
PiBoYXBwZW5zIHdoaWxlIGVuYWJsaW5nIHRoZSBjbG9ja3MgKHVucmVsYXRlZCB0byBhbnkgR1BV
IHJlZ2lzdGVyIGFjY2VzcykuIFRoZQ0KPj4gc3RyYW5nZSB0aGluZyBpcyB0aGF0IG1vc3Qgb2Yg
dGhlIGRldmljZXMgd2UgaGF2ZSBkb24ndCBjYXJlIGFuZCB3b3JrIGFzIGlzDQo+PiBhbmQgc29t
ZSBkZXZpY2VzIHJlbGlhYmx5IGZhaWwgZWFjaCB0aW1lIHdoZW4gZW5hYmxpbmcgdGhlIGNsb2Nr
cyBpbiB0aGUNCj4+ICJ3cm9uZyIgb3JkZXIuDQo+Pg0KPj4gU28gSSBndWVzcyB0aGlzIGNvdWxk
IGluZGVlZCBiZSBzb21lIGNsb2NrIGJlaW5nIGVuYWJsZWQgd2l0aCBhbiB1cHN0cmVhbQ0KPj4g
UExMIG5vdCBoYXZpbmcgbG9ja2VkIHlldCBvciBzb21ldGhpbmcuDQo+IA0KPiBodHRwczovL2V1
cjA0LnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZw
YXRjaHdvcmsua2VybmVsLm9yZyUyRmNvdmVyJTJGMTE0MzM3NzUlMkYmYW1wO2RhdGE9MDIlN0Mw
MSU3Q2ZyaWVkZXIuc2NocmVtcGYlNDBrb250cm9uLmRlJTdDMTAxNGJlNWY5YjhiNGQwYzZlODEw
OGQ3ZWRjYzViZGUlN0M4YzlkM2M5NzNmZDk0MWM4YTJiMTY0NmYzOTQyZGFmMSU3QzAlN0MwJTdD
NjM3MjM5MzM0Mjc5Njg0NzQ4JmFtcDtzZGF0YT1Vd1ZWelBFdk5PUDZJNGc3OHVHNU85alZZbUh3
cXlvNmhqOTd3dnRsenMwJTNEJmFtcDtyZXNlcnZlZD0wDQo+IA0KPiBXaWxsIHRoaXMgcGFjaHNl
dCBoZWxwPw0KDQpUaGFua3MgZm9yIHRoZSBwb2ludGVyLiBVbmZvcnR1bmF0ZWx5IHRoZSBjbG9j
ayBwYXRjaGVzIGRvbid0IGhlbHAuIEkgDQp0cmllZCB3aXRoIDUuNy1yYzQgYW5kIHlvdXIgcGF0
Y2hlcyBvbiB0b3AgYW5kIHRoZSBpc3N1ZSBzdGlsbCBwZXJzaXN0cy4NCg0KQWxzbyBJIGZvdW5k
IG91dCB0aGF0IGNoYW5naW5nIHRoZSBvcmRlciBvZiB0aGUgY2xvY2sgaW5pdGlhbGl6YXRpb24g
YXMgDQpwcm9wb3NlZCwgZG9lcyBub3QgZml4IHRoZSBwcm9ibGVtLCBlaXRoZXIuIE9uIHNvbWUg
Ym9hcmRzIGl0IGhlbHBzLCANCm90aGVycyBzdGlsbCBoYW5nIHdoZW4gdGhlIGNsb2NrcyBhcmUg
aW5pdGlhbGl6ZWQuDQoNClRoYW5rcywNCkZyaWVkZXINCg0KPiANCj4gVGhlIGkuTVg4TSBDQ00g
cm9vdCBtdXggY29kZSBpbiBMaW51eCBuZWVkcyBhIGZpeC4NCj4gDQo+IFJlZ2FyZHMsDQo+IFBl
bmcuDQo+IA0KPj4NCj4+Pg0KPj4+IFJlZ2FyZHMsDQo+Pj4gTHVjYXMNCj4+Pg0KPj4+PiBTaWdu
ZWQtb2ZmLWJ5OiBGcmllZGVyIFNjaHJlbXBmIDxmcmllZGVyLnNjaHJlbXBmQGtvbnRyb24uZGU+
DQo+Pj4+IC0tLQ0KPj4+PiAgICBkcml2ZXJzL2dwdS9kcm0vZXRuYXZpdi9ldG5hdml2X2dwdS5j
IHwgNDINCj4+ICsrKysrKysrKysrKystLS0tLS0tLS0tLS0tLQ0KPj4+PiAgICAxIGZpbGUgY2hh
bmdlZCwgMjEgaW5zZXJ0aW9ucygrKSwgMjEgZGVsZXRpb25zKC0pDQo+Pj4+DQo+Pj4+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vZXRuYXZpdi9ldG5hdml2X2dwdS5jDQo+Pj4+IGIvZHJp
dmVycy9ncHUvZHJtL2V0bmF2aXYvZXRuYXZpdl9ncHUuYw0KPj4+PiBpbmRleCA3YjEzOGQ0ZGQw
NjguLjQyNGIyZTU5NTFmMCAxMDA2NDQNCj4+Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2V0bmF2
aXYvZXRuYXZpdl9ncHUuYw0KPj4+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vZXRuYXZpdi9ldG5h
dml2X2dwdS5jDQo+Pj4+IEBAIC0xNDg3LDU1ICsxNDg3LDU1IEBAIHN0YXRpYyBpbnQgZXRuYXZp
dl9ncHVfY2xrX2VuYWJsZShzdHJ1Y3QNCj4+IGV0bmF2aXZfZ3B1ICpncHUpDQo+Pj4+ICAgIHsN
Cj4+Pj4gICAgCWludCByZXQ7DQo+Pj4+DQo+Pj4+IC0JaWYgKGdwdS0+Y2xrX3JlZykgew0KPj4+
PiAtCQlyZXQgPSBjbGtfcHJlcGFyZV9lbmFibGUoZ3B1LT5jbGtfcmVnKTsNCj4+Pj4gKwlpZiAo
Z3B1LT5jbGtfY29yZSkgew0KPj4+PiArCQlyZXQgPSBjbGtfcHJlcGFyZV9lbmFibGUoZ3B1LT5j
bGtfY29yZSk7DQo+Pj4+ICAgIAkJaWYgKHJldCkNCj4+Pj4gICAgCQkJcmV0dXJuIHJldDsNCj4+
Pj4gICAgCX0NCj4+Pj4NCj4+Pj4gLQlpZiAoZ3B1LT5jbGtfYnVzKSB7DQo+Pj4+IC0JCXJldCA9
IGNsa19wcmVwYXJlX2VuYWJsZShncHUtPmNsa19idXMpOw0KPj4+PiArCWlmIChncHUtPmNsa19z
aGFkZXIpIHsNCj4+Pj4gKwkJcmV0ID0gY2xrX3ByZXBhcmVfZW5hYmxlKGdwdS0+Y2xrX3NoYWRl
cik7DQo+Pj4+ICAgIAkJaWYgKHJldCkNCj4+Pj4gLQkJCWdvdG8gZGlzYWJsZV9jbGtfcmVnOw0K
Pj4+PiArCQkJZ290byBkaXNhYmxlX2Nsa19jb3JlOw0KPj4+PiAgICAJfQ0KPj4+Pg0KPj4+PiAt
CWlmIChncHUtPmNsa19jb3JlKSB7DQo+Pj4+IC0JCXJldCA9IGNsa19wcmVwYXJlX2VuYWJsZShn
cHUtPmNsa19jb3JlKTsNCj4+Pj4gKwlpZiAoZ3B1LT5jbGtfYnVzKSB7DQo+Pj4+ICsJCXJldCA9
IGNsa19wcmVwYXJlX2VuYWJsZShncHUtPmNsa19idXMpOw0KPj4+PiAgICAJCWlmIChyZXQpDQo+
Pj4+IC0JCQlnb3RvIGRpc2FibGVfY2xrX2J1czsNCj4+Pj4gKwkJCWdvdG8gZGlzYWJsZV9jbGtf
c2hhZGVyOw0KPj4+PiAgICAJfQ0KPj4+Pg0KPj4+PiAtCWlmIChncHUtPmNsa19zaGFkZXIpIHsN
Cj4+Pj4gLQkJcmV0ID0gY2xrX3ByZXBhcmVfZW5hYmxlKGdwdS0+Y2xrX3NoYWRlcik7DQo+Pj4+
ICsJaWYgKGdwdS0+Y2xrX3JlZykgew0KPj4+PiArCQlyZXQgPSBjbGtfcHJlcGFyZV9lbmFibGUo
Z3B1LT5jbGtfcmVnKTsNCj4+Pj4gICAgCQlpZiAocmV0KQ0KPj4+PiAtCQkJZ290byBkaXNhYmxl
X2Nsa19jb3JlOw0KPj4+PiArCQkJZ290byBkaXNhYmxlX2Nsa19idXM7DQo+Pj4+ICAgIAl9DQo+
Pj4+DQo+Pj4+ICAgIAlyZXR1cm4gMDsNCj4+Pj4NCj4+Pj4gLWRpc2FibGVfY2xrX2NvcmU6DQo+
Pj4+IC0JaWYgKGdwdS0+Y2xrX2NvcmUpDQo+Pj4+IC0JCWNsa19kaXNhYmxlX3VucHJlcGFyZShn
cHUtPmNsa19jb3JlKTsNCj4+Pj4gICAgZGlzYWJsZV9jbGtfYnVzOg0KPj4+PiAgICAJaWYgKGdw
dS0+Y2xrX2J1cykNCj4+Pj4gICAgCQljbGtfZGlzYWJsZV91bnByZXBhcmUoZ3B1LT5jbGtfYnVz
KTsNCj4+Pj4gLWRpc2FibGVfY2xrX3JlZzoNCj4+Pj4gLQlpZiAoZ3B1LT5jbGtfcmVnKQ0KPj4+
PiAtCQljbGtfZGlzYWJsZV91bnByZXBhcmUoZ3B1LT5jbGtfcmVnKTsNCj4+Pj4gK2Rpc2FibGVf
Y2xrX3NoYWRlcjoNCj4+Pj4gKwlpZiAoZ3B1LT5jbGtfc2hhZGVyKQ0KPj4+PiArCQljbGtfZGlz
YWJsZV91bnByZXBhcmUoZ3B1LT5jbGtfc2hhZGVyKTsNCj4+Pj4gK2Rpc2FibGVfY2xrX2NvcmU6
DQo+Pj4+ICsJaWYgKGdwdS0+Y2xrX2NvcmUpDQo+Pj4+ICsJCWNsa19kaXNhYmxlX3VucHJlcGFy
ZShncHUtPmNsa19jb3JlKTsNCj4+Pj4NCj4+Pj4gICAgCXJldHVybiByZXQ7DQo+Pj4+ICAgIH0N
Cj4+Pj4NCj4+Pj4gICAgc3RhdGljIGludCBldG5hdml2X2dwdV9jbGtfZGlzYWJsZShzdHJ1Y3Qg
ZXRuYXZpdl9ncHUgKmdwdSkNCj4+Pj4gICAgew0KPj4+PiArCWlmIChncHUtPmNsa19yZWcpDQo+
Pj4+ICsJCWNsa19kaXNhYmxlX3VucHJlcGFyZShncHUtPmNsa19yZWcpOw0KPj4+PiArCWlmIChn
cHUtPmNsa19idXMpDQo+Pj4+ICsJCWNsa19kaXNhYmxlX3VucHJlcGFyZShncHUtPmNsa19idXMp
Ow0KPj4+PiAgICAJaWYgKGdwdS0+Y2xrX3NoYWRlcikNCj4+Pj4gICAgCQljbGtfZGlzYWJsZV91
bnByZXBhcmUoZ3B1LT5jbGtfc2hhZGVyKTsNCj4+Pj4gICAgCWlmIChncHUtPmNsa19jb3JlKQ0K
Pj4+PiAgICAJCWNsa19kaXNhYmxlX3VucHJlcGFyZShncHUtPmNsa19jb3JlKTsNCj4+Pj4gLQlp
ZiAoZ3B1LT5jbGtfYnVzKQ0KPj4+PiAtCQljbGtfZGlzYWJsZV91bnByZXBhcmUoZ3B1LT5jbGtf
YnVzKTsNCj4+Pj4gLQlpZiAoZ3B1LT5jbGtfcmVnKQ0KPj4+PiAtCQljbGtfZGlzYWJsZV91bnBy
ZXBhcmUoZ3B1LT5jbGtfcmVnKTsNCj4+Pj4NCj4+Pj4gICAgCXJldHVybiAwOw0KPj4+PiAgICB9
DQo+Pj4NCj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18N
Cj4gbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QNCj4gbGludXgtYXJtLWtlcm5lbEBsaXN0
cy5pbmZyYWRlYWQub3JnDQo+IGh0dHBzOi8vZXVyMDQuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0
bG9vay5jb20vP3VybD1odHRwJTNBJTJGJTJGbGlzdHMuaW5mcmFkZWFkLm9yZyUyRm1haWxtYW4l
MkZsaXN0aW5mbyUyRmxpbnV4LWFybS1rZXJuZWwmYW1wO2RhdGE9MDIlN0MwMSU3Q2ZyaWVkZXIu
c2NocmVtcGYlNDBrb250cm9uLmRlJTdDMTAxNGJlNWY5YjhiNGQwYzZlODEwOGQ3ZWRjYzViZGUl
N0M4YzlkM2M5NzNmZDk0MWM4YTJiMTY0NmYzOTQyZGFmMSU3QzAlN0MwJTdDNjM3MjM5MzM0Mjc5
Njg0NzQ4JmFtcDtzZGF0YT1rcHg2TERBNlFYZ1IzQ1BHc3VnRUlJRHQyWWJadUpUQzclMkZ4clJz
RGh0b2slM0QmYW1wO3Jlc2VydmVkPTANCj4g
