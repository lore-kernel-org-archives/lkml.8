Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CB40C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 06:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB7012075F
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 06:27:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="qfsWkCdW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728729AbgG3G1z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 02:27:55 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:42758 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726261AbgG3G1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 02:27:55 -0400
X-UUID: a1c4c86c61144b45a08f7bc811d658c0-20200730
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=8lty/uyzCDwACFd7jNKNUuVqC+GMWXy2t8oEvgAMM2Q=;
        b=qfsWkCdWlfL0cl4OTeF8Cz8oj5cetDwwD1bIqxQrWEWGKwI3CxNw5KXV00UT2cVSNFSCljEzCzF7cYIdDePPJIxyFeJsNh8TizXx9roZ4zSzPcjFdqV2tfhA/rMgBnCK7DbubVDn6AvypnvoCZ1XtcQQ1uu+Nlglbho09RCIqdQ=;
X-UUID: a1c4c86c61144b45a08f7bc811d658c0-20200730
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <crystal.guo@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1567981899; Thu, 30 Jul 2020 14:27:50 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by mtkmbs05n1.mediatek.inc
 (172.21.101.15) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 30 Jul
 2020 14:27:46 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 30 Jul 2020 14:27:45 +0800
Message-ID: <1596090441.11360.27.camel@mhfsdcap03>
Subject: Re: [PATCH 1/2] reset-controller: ti: adjust the reset assert and
 deassert interface
From:   Crystal Guo <crystal.guo@mediatek.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Seiya Wang =?UTF-8?Q?=28=E7=8E=8B=E8=BF=BA=E5=90=9B=29?= 
        <seiya.wang@mediatek.com>, <yingjoe.chen@mediatek.com>,
        <fan.chen@mediatek.com>, <stanley.chu@mediatek.com>
Date:   Thu, 30 Jul 2020 14:27:21 +0800
In-Reply-To: <d259a74ca9e425f9b39ebbf47b0decb6be0beed5.camel@pengutronix.de>
References: <1596008357-11213-1-git-send-email-crystal.guo@mediatek.com>
         <1596008357-11213-2-git-send-email-crystal.guo@mediatek.com>
         <ba0d1e29-3ba3-5379-d03e-1ccec21c2ffa@gmail.com>
         <d259a74ca9e425f9b39ebbf47b0decb6be0beed5.camel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIwLTA3LTI5IGF0IDE2OjAyICswODAwLCBQaGlsaXBwIFphYmVsIHdyb3RlOg0K
PiBIaSBDcnlzdGFsLCBNYXR0aGlhcywNCj4gDQo+IE9uIFdlZCwgMjAyMC0wNy0yOSBhdCAwOTo0
OCArMDIwMCwgTWF0dGhpYXMgQnJ1Z2dlciB3cm90ZToNCj4gPiANCj4gPiBPbiAyOS8wNy8yMDIw
IDA5OjM5LCBDcnlzdGFsIEd1byB3cm90ZToNCj4gPiA+IEFkZCB0aV9zeXNjb25fcmVzZXQoKSB0
byBpbnRlZ3JhdGUgYXNzZXJ0IGFuZCBkZWFzc2VydCB0b2dldGhlciwNCj4gPiA+IGFuZCBjaGFu
Z2UgcmV0dXJuIHZhbHVlIG9mIHRoZSByZXNldCBhc3NlcnQgYW5kIGRlYXNzZXJ0IGludGVyZmFj
ZQ0KPiA+ID4gZnJvbSByZWdtYXBfdXBkYXRlX2JpdHMgdG8gcmVnbWFwX3dyaXRlX2JpdHMuDQo+
ID4gPiANCj4gPiA+IHdoZW4gY2xlYXIgYml0IGlzIGFscmVhZHkgMSwgcmVnbWFwX3VwZGF0ZV9i
aXRzIGNhbiBub3Qgd3JpdGUgMSB0byBpdCBhZ2Fpbi4NCj4gPiA+IFNvbWUgSUMgaGFzIHRoZSBm
ZWF0dXJlIHRoYXQsIHdoZW4gc2V0IGJpdCBpcyAxLCB0aGUgY2xlYXIgYml0IGNoYW5nZQ0KPiA+
ID4gdG8gMSB0b2dldGhlci4gSXQgd2lsbCB0cnVseSBjbGVhciBiaXQgdG8gMCBieSB3cml0ZSAx
IHRvIHRoZSBjbGVhciBiaXQNCj4gPiA+IA0KPiA+ID4gU2lnbmVkLW9mZi1ieTogQ3J5c3RhbCBH
dW8gPGNyeXN0YWwuZ3VvQG1lZGlhdGVrLmNvbT4NCj4gPiA+IC0tLQ0KPiA+ID4gICBkcml2ZXJz
L3Jlc2V0L3Jlc2V0LXRpLXN5c2Nvbi5jIHwgMTMgKysrKysrKysrKystLQ0KPiA+ID4gICAxIGZp
bGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPiA+IA0KPiA+
ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcmVzZXQvcmVzZXQtdGktc3lzY29uLmMgYi9kcml2ZXJz
L3Jlc2V0L3Jlc2V0LXRpLXN5c2Nvbi5jDQo+ID4gPiBpbmRleCBhMjYzNWMyLi41YThlYzhmIDEw
MDY0NA0KPiA+ID4gLS0tIGEvZHJpdmVycy9yZXNldC9yZXNldC10aS1zeXNjb24uYw0KPiA+ID4g
KysrIGIvZHJpdmVycy9yZXNldC9yZXNldC10aS1zeXNjb24uYw0KPiA+ID4gQEAgLTg5LDcgKzg5
LDcgQEAgc3RhdGljIGludCB0aV9zeXNjb25fcmVzZXRfYXNzZXJ0KHN0cnVjdCByZXNldF9jb250
cm9sbGVyX2RldiAqcmNkZXYsDQo+ID4gPiAgIAltYXNrID0gQklUKGNvbnRyb2wtPmFzc2VydF9i
aXQpOw0KPiA+ID4gICAJdmFsdWUgPSAoY29udHJvbC0+ZmxhZ3MgJiBBU1NFUlRfU0VUKSA/IG1h
c2sgOiAweDA7DQo+ID4gPiAgIA0KPiA+ID4gLQlyZXR1cm4gcmVnbWFwX3VwZGF0ZV9iaXRzKGRh
dGEtPnJlZ21hcCwgY29udHJvbC0+YXNzZXJ0X29mZnNldCwgbWFzaywgdmFsdWUpOw0KPiA+ID4g
KwlyZXR1cm4gcmVnbWFwX3dyaXRlX2JpdHMoZGF0YS0+cmVnbWFwLCBjb250cm9sLT5hc3NlcnRf
b2Zmc2V0LCBtYXNrLCB2YWx1ZSk7DQo+ID4gDQo+ID4gTmFjaywgdGhpcyB3aWxsIGJyZWFrIHRo
ZSBkcml2ZXIgZm9yIHRoZSBvdGhlciBkZXZpY2VzLg0KPiANCj4gSSBkb24ndCB0aGluayB0aGlz
IHdpbGwgYnJlYWsgdGhlIGRyaXZlciBmb3IgZXhpc3RpbmcgaGFyZHdhcmUuDQo+IHJlZ21hcF93
cml0ZV9iaXRzKCkgaXMgdGhlIHNhbWUgYXMgcmVnbWFwX3VwZGF0ZV9iaXRzKCksIGl0IGp1c3Qg
Zm9yY2VzDQo+IHRoZSB3cml0ZSBpbiBjYXNlIHRoZSByZWFkIGFscmVhZHkgaGFwcGVucyB0byBy
ZXR1cm4gdGhlIGNvcnJlY3QgdmFsdWUuDQo+IE9mIGNvdXJzZSBpdCB3b3VsZCBiZSBnb29kIHRv
IGNoZWNrIHRoYXQgdGhpcyBhY3R1YWxseSB3b3Jrcy4NCg0KWWVzLCByZWdtYXBfd3JpdGVfYml0
cygpIGlzIHRoZSBzYW1lIGFzIHJlZ21hcF91cGRhdGVfYml0cygpLCBpdCB3b3VsZA0Kbm90IGFm
ZmVjdCBleGlzdGVkIHVzZXJzLiBPciBzaG91bGQgSSB1c2UgYSBwcm9wZXJ0eSB0byBzZXBhcmF0
ZQ0KcmVnbWFwX3dyaXRlX2JpdHMoKSBhbmQgcmVnbWFwX3VwZGF0ZV9iaXRzKCkgPw0KDQo+IA0K
PiA+IFRoZSBrZXJuZWwgaGFzIHRvIHdvcmsgbm90IGp1c3QgZm9yIHlvdXIgU29DIGJ1dCBmb3Ig
YWxsIGRldmljZXMgb2YgYWxsIA0KPiA+IGFyY2hpdGVjdHVyZXMuIFlvdSBjYW4ndCBqdXN0IGhh
Y2sgc29tZXRoaW5nIHVwLCB0aGF0IHdpbGwgd29yayBvbiB5b3VyIHNwZWNpZmljIA0KPiA+IFNv
Qy4NCj4gPiANCj4gPiBSZWdhcmRzLA0KPiA+IE1hdHRoaWFzIA0KPiA+IA0KDQpUaGlzIFRJIGRy
aXZlciB3YXMgaW50ZW5kIHRvIGJlIGEgZ2VuZXJpYyByZXNldCBjb250cm9sbGVyDQooaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvcGF0Y2h3b3JrL2NvdmVyLzY4MzU4NS8pLCBzbyB0aGlzIHBhdGNo
IG1heQ0Kbm90IGp1c3Qgd29yayBvbiBhIHNwZWNpZmljIFNvQy4NCg0KVGhhbmtzLA0KQ3J5c3Rh
bA0KDQo+ID4gPiAgIH0NCj4gPiA+ICAgDQo+ID4gPiAgIC8qKg0KPiA+ID4gQEAgLTEyMCw3ICsx
MjAsNyBAQCBzdGF0aWMgaW50IHRpX3N5c2Nvbl9yZXNldF9kZWFzc2VydChzdHJ1Y3QgcmVzZXRf
Y29udHJvbGxlcl9kZXYgKnJjZGV2LA0KPiA+ID4gICAJbWFzayA9IEJJVChjb250cm9sLT5kZWFz
c2VydF9iaXQpOw0KPiA+ID4gICAJdmFsdWUgPSAoY29udHJvbC0+ZmxhZ3MgJiBERUFTU0VSVF9T
RVQpID8gbWFzayA6IDB4MDsNCj4gPiA+ICAgDQo+ID4gPiAtCXJldHVybiByZWdtYXBfdXBkYXRl
X2JpdHMoZGF0YS0+cmVnbWFwLCBjb250cm9sLT5kZWFzc2VydF9vZmZzZXQsIG1hc2ssIHZhbHVl
KTsNCj4gPiA+ICsJcmV0dXJuIHJlZ21hcF93cml0ZV9iaXRzKGRhdGEtPnJlZ21hcCwgY29udHJv
bC0+ZGVhc3NlcnRfb2Zmc2V0LCBtYXNrLCB2YWx1ZSk7DQo+ID4gPiAgIH0NCj4gPiA+ICAgDQo+
ID4gPiAgIC8qKg0KPiA+ID4gQEAgLTE1OCwxMCArMTU4LDE5IEBAIHN0YXRpYyBpbnQgdGlfc3lz
Y29uX3Jlc2V0X3N0YXR1cyhzdHJ1Y3QgcmVzZXRfY29udHJvbGxlcl9kZXYgKnJjZGV2LA0KPiA+
ID4gICAJCSEoY29udHJvbC0+ZmxhZ3MgJiBTVEFUVVNfU0VUKTsNCj4gPiA+ICAgfQ0KPiA+ID4g
ICANCj4gPiA+ICtzdGF0aWMgaW50IHRpX3N5c2Nvbl9yZXNldChzdHJ1Y3QgcmVzZXRfY29udHJv
bGxlcl9kZXYgKnJjZGV2LA0KPiA+ID4gKwkJCSAgIHVuc2lnbmVkIGxvbmcgaWQpDQo+ID4gPiAr
ew0KPiA+ID4gKwl0aV9zeXNjb25fcmVzZXRfYXNzZXJ0KHJjZGV2LCBpZCk7DQo+ID4gPiArDQo+
ID4gPiArCXJldHVybiB0aV9zeXNjb25fcmVzZXRfZGVhc3NlcnQocmNkZXYsIGlkKTsNCj4gPiA+
ICt9DQo+ID4gPiArDQo+IA0KPiBJJ20gdW5zdXJlIGFib3V0IHRoaXMgb25lLCB0aG91Z2guIFRo
aXMgaXMgYW4gaW5jb21wYXRpYmxlIGNoYW5nZS4gQXQNCj4gdGhlIHZlcnkgbGVhc3QgdGhpcyB3
b3VsZCBoYXZlIHRvIGJlIG9wdGlvbmFsIGRlcGVuZGluZyBvbiBjb21wYXRpYmxlLg0KPiANCj4g
cmVnYXJkcw0KPiBQaGlsaXBwDQoNCkkgd2lsbCBhZGQgYSBwcm9wZXJ0eSB0byBtYWtlIHRoaXMg
Y2hhbmdlIGJlIG9wdGlvbmFsLCB0aGFua3MgZm9yIHlvdQ0KYWR2aWNlLg0KDQpUaGFua3MsDQpD
cnlzdGFsDQoNCg0K

