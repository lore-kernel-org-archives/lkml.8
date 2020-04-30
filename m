Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8656C47247
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 15:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90F6220661
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 15:35:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbgD3Pfv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 11:35:51 -0400
Received: from skedge04.snt-world.com ([91.208.41.69]:44020 "EHLO
        skedge04.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbgD3Pfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 11:35:50 -0400
Received: from sntmail14r.snt-is.com (unknown [10.203.32.184])
        by skedge04.snt-world.com (Postfix) with ESMTP id 29A1567A7D8;
        Thu, 30 Apr 2020 17:35:47 +0200 (CEST)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail14r.snt-is.com
 (10.203.32.184) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Thu, 30 Apr
 2020 17:35:46 +0200
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%3]) with mapi id
 15.01.1913.007; Thu, 30 Apr 2020 17:35:46 +0200
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
Subject: Re: [RFC PATCH 3/4] drm/etnaviv: Change order of enabling clocks to
 fix boot on i.MX8MM
Thread-Topic: [RFC PATCH 3/4] drm/etnaviv: Change order of enabling clocks to
 fix boot on i.MX8MM
Thread-Index: AQHWHu1V9EwL5xxa+UiJnz7nneFudaiRmbMAgAAQ8oA=
Date:   Thu, 30 Apr 2020 15:35:46 +0000
Message-ID: <72e8618b-856e-de42-9282-958cd03b239f@kontron.de>
References: <20200430124602.14463-1-frieder.schrempf@kontron.de>
 <20200430124602.14463-4-frieder.schrempf@kontron.de>
 <3895f202cf5919e41a56878a62f6d5259dea12d3.camel@pengutronix.de>
In-Reply-To: <3895f202cf5919e41a56878a62f6d5259dea12d3.camel@pengutronix.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.193]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="utf-8"
Content-ID: <9F9D967AC7E63B45A2B9F9A531BF74C8@snt-world.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: 29A1567A7D8.A090B
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

T24gMzAuMDQuMjAgMTY6MzUsIEx1Y2FzIFN0YWNoIHdyb3RlOg0KPiBBbSBEb25uZXJzdGFnLCBk
ZW4gMzAuMDQuMjAyMCwgMTI6NDYgKzAwMDAgc2NocmllYiBTY2hyZW1wZiBGcmllZGVyOg0KPj4g
RnJvbTogRnJpZWRlciBTY2hyZW1wZiA8ZnJpZWRlci5zY2hyZW1wZkBrb250cm9uLmRlPg0KPj4N
Cj4+IE9uIHNvbWUgaS5NWDhNTSBkZXZpY2VzIHRoZSBib290IGhhbmdzIHdoZW4gZW5hYmxpbmcg
dGhlIEdQVSBjbG9ja3MuDQo+PiBDaGFuZ2luZyB0aGUgb3JkZXIgb2YgY2xvY2sgaW5pdGFsaXph
dGlvbiB0bw0KPj4NCj4+IGNvcmUgLT4gc2hhZGVyIC0+IGJ1cyAtPiByZWcNCj4+DQo+PiBmaXhl
cyB0aGUgaXNzdWUuIFRoaXMgaXMgdGhlIHNhbWUgb3JkZXIgdXNlZCBpbiB0aGUgaW14IHBsYXRm
b3JtIGNvZGUNCj4+IG9mIHRoZSBkb3duc3RyZWFtIEdQVSBkcml2ZXIgaW4gdGhlIE5YUCBrZXJu
ZWwgWzFdLiBGb3IgdGhlIHNha2Ugb2YNCj4+IGNvbnNpc3RlbmN5IHdlIGFsc28gYWRqdXN0IHRo
ZSBvcmRlciBvZiBkaXNhYmxpbmcgdGhlIGNsb2NrcyB0byB0aGUNCj4+IHJldmVyc2UuDQo+Pg0K
Pj4gWzFdIGh0dHBzOi8vZXVyMDQuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3Vy
bD1odHRwcyUzQSUyRiUyRnNvdXJjZS5jb2RlYXVyb3JhLm9yZyUyRmV4dGVybmFsJTJGaW14JTJG
bGludXgtaW14JTJGdHJlZSUyRmRyaXZlcnMlMkZteGMlMkZncHUtdml2JTJGaGFsJTJGb3MlMkZs
aW51eCUyRmtlcm5lbCUyRnBsYXRmb3JtJTJGZnJlZXNjYWxlJTJGZ2NfaGFsX2tlcm5lbF9wbGF0
Zm9ybV9pbXguYyUzRmglM0RpbXhfNS40LjNfMi4wLjAlMjNuMTUzOCZhbXA7ZGF0YT0wMiU3QzAx
JTdDZnJpZWRlci5zY2hyZW1wZiU0MGtvbnRyb24uZGUlN0NkYWUxNWYxNGVkNGE0OTk5MDY1NTA4
ZDdlZDEzYWU4NyU3QzhjOWQzYzk3M2ZkOTQxYzhhMmIxNjQ2ZjM5NDJkYWYxJTdDMCU3QzAlN0M2
MzcyMzg1NDEwOTU1OTQwMTkmYW1wO3NkYXRhPSUyQkltdGVYTkglMkZxSkRpb25uSlZIdGpWblhK
ayUyQkclMkJWbGd2QmRSR2ZubFFybyUzRCZhbXA7cmVzZXJ2ZWQ9MA0KPiANCj4gSSBkb24ndCBz
ZWUgd2h5IHRoZSBvcmRlciBvZiB0aGUgY2xvY2tzIGlzIGltcG9ydGFudC4gSXMgdGhpcyByZWFs
bHkgYQ0KPiBHUFUgaXNzdWU/IEFzIGluOiBkb2VzIGEgR1BVIGFjY2VzcyBoYW5nIHdoZW4gZW5h
YmxpbmcgdGhlIGNsb2NrcyBpbg0KPiB0aGUgd3Jvbmcgb3JkZXI/IE9yIGlzIHRoaXMgYSBjbG9j
ayBkcml2ZXIgaXNzdWUgd2l0aCBhIGNsb2NrIGFjY2Vzcw0KPiBoYW5naW5nIGR1ZSB0byBhbiB1
cHN0cmVhbSBjbG9jayBzdGlsbCBiZWluZyBkaXNhYmxlZD8NCg0KQWN0dWFsbHkgeW91IG1pZ2h0
IGJlIHJpZ2h0IHdpdGggdGhpcyBiZWluZyBhIGNsb2NrIGRyaXZlciBpc3N1ZS4gVGhlIA0KaGFu
Z2luZyBoYXBwZW5zIHdoaWxlIGVuYWJsaW5nIHRoZSBjbG9ja3MgKHVucmVsYXRlZCB0byBhbnkg
R1BVIHJlZ2lzdGVyIA0KYWNjZXNzKS4gVGhlIHN0cmFuZ2UgdGhpbmcgaXMgdGhhdCBtb3N0IG9m
IHRoZSBkZXZpY2VzIHdlIGhhdmUgZG9uJ3QgDQpjYXJlIGFuZCB3b3JrIGFzIGlzIGFuZCBzb21l
IGRldmljZXMgcmVsaWFibHkgZmFpbCBlYWNoIHRpbWUgd2hlbiANCmVuYWJsaW5nIHRoZSBjbG9j
a3MgaW4gdGhlICJ3cm9uZyIgb3JkZXIuDQoNClNvIEkgZ3Vlc3MgdGhpcyBjb3VsZCBpbmRlZWQg
YmUgc29tZSBjbG9jayBiZWluZyBlbmFibGVkIHdpdGggYW4gDQp1cHN0cmVhbSBQTEwgbm90IGhh
dmluZyBsb2NrZWQgeWV0IG9yIHNvbWV0aGluZy4NCg0KPiANCj4gUmVnYXJkcywNCj4gTHVjYXMN
Cj4gDQo+PiBTaWduZWQtb2ZmLWJ5OiBGcmllZGVyIFNjaHJlbXBmIDxmcmllZGVyLnNjaHJlbXBm
QGtvbnRyb24uZGU+DQo+PiAtLS0NCj4+ICAgZHJpdmVycy9ncHUvZHJtL2V0bmF2aXYvZXRuYXZp
dl9ncHUuYyB8IDQyICsrKysrKysrKysrKystLS0tLS0tLS0tLS0tLQ0KPj4gICAxIGZpbGUgY2hh
bmdlZCwgMjEgaW5zZXJ0aW9ucygrKSwgMjEgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9ldG5hdml2L2V0bmF2aXZfZ3B1LmMgYi9kcml2ZXJzL2dwdS9k
cm0vZXRuYXZpdi9ldG5hdml2X2dwdS5jDQo+PiBpbmRleCA3YjEzOGQ0ZGQwNjguLjQyNGIyZTU5
NTFmMCAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9ldG5hdml2L2V0bmF2aXZfZ3B1
LmMNCj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9ldG5hdml2L2V0bmF2aXZfZ3B1LmMNCj4+IEBA
IC0xNDg3LDU1ICsxNDg3LDU1IEBAIHN0YXRpYyBpbnQgZXRuYXZpdl9ncHVfY2xrX2VuYWJsZShz
dHJ1Y3QgZXRuYXZpdl9ncHUgKmdwdSkNCj4+ICAgew0KPj4gICAJaW50IHJldDsNCj4+ICAgDQo+
PiAtCWlmIChncHUtPmNsa19yZWcpIHsNCj4+IC0JCXJldCA9IGNsa19wcmVwYXJlX2VuYWJsZShn
cHUtPmNsa19yZWcpOw0KPj4gKwlpZiAoZ3B1LT5jbGtfY29yZSkgew0KPj4gKwkJcmV0ID0gY2xr
X3ByZXBhcmVfZW5hYmxlKGdwdS0+Y2xrX2NvcmUpOw0KPj4gICAJCWlmIChyZXQpDQo+PiAgIAkJ
CXJldHVybiByZXQ7DQo+PiAgIAl9DQo+PiAgIA0KPj4gLQlpZiAoZ3B1LT5jbGtfYnVzKSB7DQo+
PiAtCQlyZXQgPSBjbGtfcHJlcGFyZV9lbmFibGUoZ3B1LT5jbGtfYnVzKTsNCj4+ICsJaWYgKGdw
dS0+Y2xrX3NoYWRlcikgew0KPj4gKwkJcmV0ID0gY2xrX3ByZXBhcmVfZW5hYmxlKGdwdS0+Y2xr
X3NoYWRlcik7DQo+PiAgIAkJaWYgKHJldCkNCj4+IC0JCQlnb3RvIGRpc2FibGVfY2xrX3JlZzsN
Cj4+ICsJCQlnb3RvIGRpc2FibGVfY2xrX2NvcmU7DQo+PiAgIAl9DQo+PiAgIA0KPj4gLQlpZiAo
Z3B1LT5jbGtfY29yZSkgew0KPj4gLQkJcmV0ID0gY2xrX3ByZXBhcmVfZW5hYmxlKGdwdS0+Y2xr
X2NvcmUpOw0KPj4gKwlpZiAoZ3B1LT5jbGtfYnVzKSB7DQo+PiArCQlyZXQgPSBjbGtfcHJlcGFy
ZV9lbmFibGUoZ3B1LT5jbGtfYnVzKTsNCj4+ICAgCQlpZiAocmV0KQ0KPj4gLQkJCWdvdG8gZGlz
YWJsZV9jbGtfYnVzOw0KPj4gKwkJCWdvdG8gZGlzYWJsZV9jbGtfc2hhZGVyOw0KPj4gICAJfQ0K
Pj4gICANCj4+IC0JaWYgKGdwdS0+Y2xrX3NoYWRlcikgew0KPj4gLQkJcmV0ID0gY2xrX3ByZXBh
cmVfZW5hYmxlKGdwdS0+Y2xrX3NoYWRlcik7DQo+PiArCWlmIChncHUtPmNsa19yZWcpIHsNCj4+
ICsJCXJldCA9IGNsa19wcmVwYXJlX2VuYWJsZShncHUtPmNsa19yZWcpOw0KPj4gICAJCWlmIChy
ZXQpDQo+PiAtCQkJZ290byBkaXNhYmxlX2Nsa19jb3JlOw0KPj4gKwkJCWdvdG8gZGlzYWJsZV9j
bGtfYnVzOw0KPj4gICAJfQ0KPj4gICANCj4+ICAgCXJldHVybiAwOw0KPj4gICANCj4+IC1kaXNh
YmxlX2Nsa19jb3JlOg0KPj4gLQlpZiAoZ3B1LT5jbGtfY29yZSkNCj4+IC0JCWNsa19kaXNhYmxl
X3VucHJlcGFyZShncHUtPmNsa19jb3JlKTsNCj4+ICAgZGlzYWJsZV9jbGtfYnVzOg0KPj4gICAJ
aWYgKGdwdS0+Y2xrX2J1cykNCj4+ICAgCQljbGtfZGlzYWJsZV91bnByZXBhcmUoZ3B1LT5jbGtf
YnVzKTsNCj4+IC1kaXNhYmxlX2Nsa19yZWc6DQo+PiAtCWlmIChncHUtPmNsa19yZWcpDQo+PiAt
CQljbGtfZGlzYWJsZV91bnByZXBhcmUoZ3B1LT5jbGtfcmVnKTsNCj4+ICtkaXNhYmxlX2Nsa19z
aGFkZXI6DQo+PiArCWlmIChncHUtPmNsa19zaGFkZXIpDQo+PiArCQljbGtfZGlzYWJsZV91bnBy
ZXBhcmUoZ3B1LT5jbGtfc2hhZGVyKTsNCj4+ICtkaXNhYmxlX2Nsa19jb3JlOg0KPj4gKwlpZiAo
Z3B1LT5jbGtfY29yZSkNCj4+ICsJCWNsa19kaXNhYmxlX3VucHJlcGFyZShncHUtPmNsa19jb3Jl
KTsNCj4+ICAgDQo+PiAgIAlyZXR1cm4gcmV0Ow0KPj4gICB9DQo+PiAgIA0KPj4gICBzdGF0aWMg
aW50IGV0bmF2aXZfZ3B1X2Nsa19kaXNhYmxlKHN0cnVjdCBldG5hdml2X2dwdSAqZ3B1KQ0KPj4g
ICB7DQo+PiArCWlmIChncHUtPmNsa19yZWcpDQo+PiArCQljbGtfZGlzYWJsZV91bnByZXBhcmUo
Z3B1LT5jbGtfcmVnKTsNCj4+ICsJaWYgKGdwdS0+Y2xrX2J1cykNCj4+ICsJCWNsa19kaXNhYmxl
X3VucHJlcGFyZShncHUtPmNsa19idXMpOw0KPj4gICAJaWYgKGdwdS0+Y2xrX3NoYWRlcikNCj4+
ICAgCQljbGtfZGlzYWJsZV91bnByZXBhcmUoZ3B1LT5jbGtfc2hhZGVyKTsNCj4+ICAgCWlmIChn
cHUtPmNsa19jb3JlKQ0KPj4gICAJCWNsa19kaXNhYmxlX3VucHJlcGFyZShncHUtPmNsa19jb3Jl
KTsNCj4+IC0JaWYgKGdwdS0+Y2xrX2J1cykNCj4+IC0JCWNsa19kaXNhYmxlX3VucHJlcGFyZShn
cHUtPmNsa19idXMpOw0KPj4gLQlpZiAoZ3B1LT5jbGtfcmVnKQ0KPj4gLQkJY2xrX2Rpc2FibGVf
dW5wcmVwYXJlKGdwdS0+Y2xrX3JlZyk7DQo+PiAgIA0KPj4gICAJcmV0dXJuIDA7DQo+PiAgIH0N
Cj4g
