Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11210C4724C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 15:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF76D2076D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 15:31:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727862AbgD3Pbo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 11:31:44 -0400
Received: from skedge03.snt-world.com ([91.208.41.68]:34720 "EHLO
        skedge03.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726468AbgD3Pbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 11:31:44 -0400
Received: from sntmail10s.snt-is.com (unknown [10.203.32.183])
        by skedge03.snt-world.com (Postfix) with ESMTP id 2B4B167A90D;
        Thu, 30 Apr 2020 17:31:38 +0200 (CEST)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail10s.snt-is.com
 (10.203.32.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Thu, 30 Apr
 2020 17:31:37 +0200
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%3]) with mapi id
 15.01.1913.007; Thu, 30 Apr 2020 17:31:37 +0200
From:   Schrempf Frieder <frieder.schrempf@kontron.de>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Adam Ford <aford173@gmail.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "Fabio Estevam" <festevam@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "Li Jun" <jun.li@nxp.com>, NXP Linux Team <linux-imx@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        "Russell King" <linux+etnaviv@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "etnaviv@lists.freedesktop.org" <etnaviv@lists.freedesktop.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 1/4] drm/etnaviv: Prevent IRQ triggering at probe time
 on i.MX8MM
Thread-Topic: [RFC PATCH 1/4] drm/etnaviv: Prevent IRQ triggering at probe
 time on i.MX8MM
Thread-Index: AQHWHu1RaS/QCZFEh0aIMChy0QTuwqiRmPWAgAAQiIA=
Date:   Thu, 30 Apr 2020 15:31:37 +0000
Message-ID: <6a5fbb8a-bf28-9c8e-53c7-7a3e5f338a2c@kontron.de>
References: <20200430124602.14463-1-frieder.schrempf@kontron.de>
 <20200430124602.14463-2-frieder.schrempf@kontron.de>
 <5e1f804c4c27927d10b2283747c1cae6606abe7c.camel@pengutronix.de>
In-Reply-To: <5e1f804c4c27927d10b2283747c1cae6606abe7c.camel@pengutronix.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.193]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="utf-8"
Content-ID: <BA4382012F57B34A874DFB7B14B0BD99@snt-world.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: 2B4B167A90D.A1282
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

SGkgTHVjYXMsDQoNCk9uIDMwLjA0LjIwIDE2OjMyLCBMdWNhcyBTdGFjaCB3cm90ZToNCj4gSGkg
RnJpZWRlciwNCj4gDQo+IEFtIERvbm5lcnN0YWcsIGRlbiAzMC4wNC4yMDIwLCAxMjo0NiArMDAw
MCBzY2hyaWViIFNjaHJlbXBmIEZyaWVkZXI6DQo+PiBGcm9tOiBGcmllZGVyIFNjaHJlbXBmIDxm
cmllZGVyLnNjaHJlbXBmQGtvbnRyb24uZGU+DQo+Pg0KPj4gT24gaS5NWDhNTSB0aGVyZSBpcyBh
biBpbnRlcnJ1cHQgZ2V0dGluZyB0cmlnZ2VyZWQgaW1tZWRpYXRlbHkgYWZ0ZXINCj4+IHJlcXVl
c3RpbmcgdGhlIElSUSwgd2hpY2ggbGVhZHMgdG8gYSBzdGFsbCBhcyB0aGUgaGFuZGxlciBhY2Nl
c3Nlcw0KPj4gdGhlIEdQVSByZWdpc3RlcnMgd2hpdGhvdXQgdGhlIGNsb2NrIGJlaW5nIGVuYWJs
ZWQuDQo+Pg0KPj4gRW5hYmxpbmcgdGhlIGNsb2NrcyBicmllZmx5IHNlZW1zIHRvIGNsZWFyIHRo
ZSBJUlEgc3RhdGUsIHNvIHdlIGRvDQo+PiB0aGlzIGJlZm9yZSByZXF1ZXN0aW5nIHRoZSBJUlEu
DQo+IA0KPiBUaGlzIGlzIG1vc3QgbGlrZWx5IGNhdXNlZCBieSBpbXByb3BlciBwb3dlci11cCBz
ZXF1ZW5jaW5nLiBOb3JtYWxseQ0KPiB0aGUgR1BDIHdpbGwgdHJpZ2dlciBhIGhhcmR3YXJlIHJl
c2V0IG9mIHRoZSBtb2R1bGVzIGluc2lkZSBhIHBvd2VyDQo+IGRvbWFpbiB3aGVuIHRoZSBkb21h
aW4gaXMgcG93ZXJlZCBvbi4gVGhpcyByZXF1aXJlcyB0aGUgY2xvY2tzIHRvIGJlDQo+IHJ1bm5p
bmcgYXQgdGhpcyBwb2ludCwgYXMgdGhvc2UgcmVzZXRzIGFyZSBzeW5jaHJvbm91cywgc28gbmVl
ZCBjbG9jaw0KPiBwdWxzZXMgdG8gcHJvcGFnYXRlIHRocm91Z2ggdGhlIGhhcmR3YXJlLg0KDQpP
aywgSSB3YXMgc3VzcGVjdGluZyBzb21ldGhpbmcgbGlrZSB0aGF0IGFuZCB5b3VyIGV4cGxhbmF0
aW9uIG1ha2VzIA0KdG90YWwgc2Vuc2UgdG8gbWUuDQoNCj4gDQo+ICBGcm9tIHdoYXQgSSBzZWUg
dGhlIGkuTVg4TU0gaXMgc3RpbGwgbWlzc2luZyB0aGUgcG93ZXIgZG9tYWluDQo+IGNvbnRyb2xs
ZXIgaW50ZWdyYXRpb24sIGJ1dCBJJ20gcHJldHR5IGNvbmZpZGVudCB0aGF0IHRoaXMgcHJvYmxl
bQ0KPiBzaG91bGQgYmUgc29sdmVkIGluIHRoZSBwb3dlciBkb21haW4gY29kZSwgaW5zdGVhZCBv
ZiB0aGUgR1BVIGRyaXZlci4NCg0KT2suIEkgd2FzIGhvcGluZyB0aGF0IEdQVSBzdXBwb3J0IGNv
dWxkIGJlIGFkZGVkIHdpdGhvdXQgcG93ZXIgZG9tYWluIA0KY29udHJvbCwgYnV0IEkgbm93IHNl
ZSB0aGF0IHRoaXMgaXMgcHJvYmFibHkgbm90IHJlYXNvbmFibGUgYXQgYWxsLg0KU28gSSB3aWxs
IGtlZXAgb24gaG9waW5nIHRoYXQgTlhQIGNvbWVzIHVwIHdpdGggYW4gdXBzdHJlYW1hYmxlIHNv
bHV0aW9uIA0KZm9yIHRoZSBwb3dlciBkb21haW4gaGFuZGxpbmcuDQoNClRoYW5rcywNCkZyaWVk
ZXINCg0KPiANCj4gUmVnYXJkcywNCj4gTHVjYXMNCj4gDQo+PiBTaWduZWQtb2ZmLWJ5OiBGcmll
ZGVyIFNjaHJlbXBmIDxmcmllZGVyLnNjaHJlbXBmQGtvbnRyb24uZGU+DQo+PiAtLS0NCj4+ICAg
ZHJpdmVycy9ncHUvZHJtL2V0bmF2aXYvZXRuYXZpdl9ncHUuYyB8IDI5ICsrKysrKysrKysrKysr
KysrKysrLS0tLS0NCj4+IC0tDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAyMiBpbnNlcnRpb25zKCsp
LCA3IGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vZXRu
YXZpdi9ldG5hdml2X2dwdS5jDQo+PiBiL2RyaXZlcnMvZ3B1L2RybS9ldG5hdml2L2V0bmF2aXZf
Z3B1LmMNCj4+IGluZGV4IGEzMWVlZmYyYjI5Ny4uMjM4NzdjMWYxNTBhIDEwMDY0NA0KPj4gLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2V0bmF2aXYvZXRuYXZpdl9ncHUuYw0KPj4gKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2V0bmF2aXYvZXRuYXZpdl9ncHUuYw0KPj4gQEAgLTE3NzUsMTMgKzE3NzUsNiBA
QCBzdGF0aWMgaW50IGV0bmF2aXZfZ3B1X3BsYXRmb3JtX3Byb2JlKHN0cnVjdA0KPj4gcGxhdGZv
cm1fZGV2aWNlICpwZGV2KQ0KPj4gICAJCXJldHVybiBncHUtPmlycTsNCj4+ICAgCX0NCj4+ICAg
DQo+PiAtCWVyciA9IGRldm1fcmVxdWVzdF9pcnEoJnBkZXYtPmRldiwgZ3B1LT5pcnEsIGlycV9o
YW5kbGVyLCAwLA0KPj4gLQkJCSAgICAgICBkZXZfbmFtZShncHUtPmRldiksIGdwdSk7DQo+PiAt
CWlmIChlcnIpIHsNCj4+IC0JCWRldl9lcnIoZGV2LCAiZmFpbGVkIHRvIHJlcXVlc3QgSVJRJXU6
ICVkXG4iLCBncHUtPmlycSwNCj4+IGVycik7DQo+PiAtCQlyZXR1cm4gZXJyOw0KPj4gLQl9DQo+
PiAtDQo+PiAgIAkvKiBHZXQgQ2xvY2tzOiAqLw0KPj4gICAJZ3B1LT5jbGtfcmVnID0gZGV2bV9j
bGtfZ2V0KCZwZGV2LT5kZXYsICJyZWciKTsNCj4+ICAgCURCRygiY2xrX3JlZzogJXAiLCBncHUt
PmNsa19yZWcpOw0KPj4gQEAgLTE4MDUsNiArMTc5OCwyOCBAQCBzdGF0aWMgaW50IGV0bmF2aXZf
Z3B1X3BsYXRmb3JtX3Byb2JlKHN0cnVjdA0KPj4gcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPj4g
ICAJCWdwdS0+Y2xrX3NoYWRlciA9IE5VTEw7DQo+PiAgIAlncHUtPmJhc2VfcmF0ZV9zaGFkZXIg
PSBjbGtfZ2V0X3JhdGUoZ3B1LT5jbGtfc2hhZGVyKTsNCj4+ICAgDQo+PiArCS8qDQo+PiArCSAq
IE9uIGkuTVg4TU0gdGhlcmUgaXMgYW4gaW50ZXJydXB0IGdldHRpbmcgdHJpZ2dlcmVkDQo+PiBp
bW1lZGlhdGVseQ0KPj4gKwkgKiBhZnRlciByZXF1ZXN0aW5nIHRoZSBJUlEsIHdoaWNoIGxlYWRz
IHRvIGEgc3RhbGwgYXMgdGhlDQo+PiBoYW5kbGVyDQo+PiArCSAqIGFjY2Vzc2VzIHRoZSBHUFUg
cmVnaXN0ZXJzIHdoaXRob3V0IHRoZSBjbG9jayBiZWluZyBlbmFibGVkLg0KPj4gKwkgKiBFbmFi
bGluZyB0aGUgY2xvY2tzIGJyaWVmbHkgc2VlbXMgdG8gY2xlYXIgdGhlIElSUSBzdGF0ZSwgc28N
Cj4+IHdlIGRvDQo+PiArCSAqIHRoaXMgaGVyZSBiZWZvcmUgcmVxdWVzdGluZyB0aGUgSVJRLg0K
Pj4gKwkgKi8NCj4+ICsJZXJyID0gZXRuYXZpdl9ncHVfY2xrX2VuYWJsZShncHUpOw0KPj4gKwlp
ZiAoZXJyKQ0KPj4gKwkJcmV0dXJuIGVycjsNCj4+ICsNCj4+ICsJZXJyID0gZXRuYXZpdl9ncHVf
Y2xrX2Rpc2FibGUoZ3B1KTsNCj4+ICsJaWYgKGVycikNCj4+ICsJCXJldHVybiBlcnI7DQo+PiAr
DQo+PiArCWVyciA9IGRldm1fcmVxdWVzdF9pcnEoJnBkZXYtPmRldiwgZ3B1LT5pcnEsIGlycV9o
YW5kbGVyLCAwLA0KPj4gKwkJCSAgICAgICBkZXZfbmFtZShncHUtPmRldiksIGdwdSk7DQo+PiAr
CWlmIChlcnIpIHsNCj4+ICsJCWRldl9lcnIoZGV2LCAiZmFpbGVkIHRvIHJlcXVlc3QgSVJRJXU6
ICVkXG4iLCBncHUtPmlycSwNCj4+IGVycik7DQo+PiArCQlyZXR1cm4gZXJyOw0KPj4gKwl9DQo+
PiArDQo+PiAgIAkvKiBUT0RPOiBmaWd1cmUgb3V0IG1heCBtYXBwZWQgc2l6ZSAqLw0KPj4gICAJ
ZGV2X3NldF9kcnZkYXRhKGRldiwgZ3B1KTsNCj4+ICAgDQo+IA==
