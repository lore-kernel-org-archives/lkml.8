Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E0C6C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 05:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34A412076C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 05:10:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="NiOcZHdm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbgHDFKf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 01:10:35 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:20337 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726000AbgHDFKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 01:10:35 -0400
X-UUID: 797e73bc974747c88fe1266d237f519d-20200804
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=HcqTMCQTc6cS8wLmYpdxtIBv3OwMvyeVXOAl4pmbLwo=;
        b=NiOcZHdmhwCnv5eyaxQnmjiYjRDCQJtzmsCfSPczEPVplRmKlP/5HmJzdKMEmaRMUH6UfR8JSRxL/wAaOAXoe9BWqznSYzUzICRxs/+a9mj5AeMecoMLOmpzlkgoGIfO8ncfDQmtQMA12VoCSNhhw9U1Ile45DfPSo8K6gPJ2Fw=;
X-UUID: 797e73bc974747c88fe1266d237f519d-20200804
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 391500231; Tue, 04 Aug 2020 13:10:32 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 4 Aug 2020 13:10:30 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 4 Aug 2020 13:10:32 +0800
Message-ID: <1596517831.27829.3.camel@mtkswgap22>
Subject: Re: [v2,4/6] reset-controller: ti: introduce a new reset handler
From:   Stanley Chu <stanley.chu@mediatek.com>
To:     Crystal Guo <crystal.guo@mediatek.com>
CC:     <p.zabel@pengutronix.de>, <robh+dt@kernel.org>,
        <matthias.bgg@gmail.com>, <srv_heupstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <seiya.wang@mediatek.com>,
        <yingjoe.chen@mediatek.com>, <fan.chen@mediatek.com>,
        <yong.liang@mediatek.com>
Date:   Tue, 4 Aug 2020 13:10:31 +0800
In-Reply-To: <20200803061511.29555-5-crystal.guo@mediatek.com>
References: <20200803061511.29555-1-crystal.guo@mediatek.com>
         <20200803061511.29555-5-crystal.guo@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIwLTA4LTAzIGF0IDE0OjE1ICswODAwLCBDcnlzdGFsIEd1byB3cm90ZToNCj4g
QWRkIHRpX3N5c2Nvbl9yZXNldCgpIHRvIGludGVncmF0ZSBhc3NlcnQgYW5kIGRlYXNzZXJ0IHRv
Z2V0aGVyLg0KPiBJZiBzb21lIG1vZHVsZXMgbmVlZCBkbyBzZXJpYWxpemVkIGFzc2VydCBhbmQg
ZGVhc3NlcnQgb3BlcmF0aW9ucw0KPiB0byByZXNldCBpdHNlbGYsIHJlc2V0X2NvbnRyb2xfcmVz
ZXQgY2FuIGJlIGNhbGxlZCBmb3IgY29udmVuaWVuY2UuDQo+IA0KPiBDaGFuZ2UtSWQ6IEk5MDQ2
OTkyYjExNWE0NmYzNTk0ZGU1N2ZhODljNmEyZGU5OTU3ZDQ5DQoNClBsZWFzZSBkcm9wICJDaGFu
Z2UtSWQiIHRhZ3MuDQoNCj4gLS0tDQo+ICBkcml2ZXJzL3Jlc2V0L3Jlc2V0LXRpLXN5c2Nvbi5j
IHwgMjAgKysrKysrKysrKysrKysrKysrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCAyMCBpbnNlcnRp
b25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9yZXNldC9yZXNldC10aS1zeXNjb24u
YyBiL2RyaXZlcnMvcmVzZXQvcmVzZXQtdGktc3lzY29uLmMNCj4gaW5kZXggYTI2MzVjMjFkYjdm
Li4xYzc0YmNiOWE2YzMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvcmVzZXQvcmVzZXQtdGktc3lz
Y29uLmMNCj4gKysrIGIvZHJpdmVycy9yZXNldC9yZXNldC10aS1zeXNjb24uYw0KPiBAQCAtNTYs
NiArNTYsNyBAQCBzdHJ1Y3QgdGlfc3lzY29uX3Jlc2V0X2RhdGEgew0KPiAgCXN0cnVjdCByZWdt
YXAgKnJlZ21hcDsNCj4gIAlzdHJ1Y3QgdGlfc3lzY29uX3Jlc2V0X2NvbnRyb2wgKmNvbnRyb2xz
Ow0KPiAgCXVuc2lnbmVkIGludCBucl9jb250cm9sczsNCj4gKwlib29sIGFzc2VydF9kZWFzc2Vy
dF90b2dldGhlcjsNCj4gIH07DQo+ICANCj4gICNkZWZpbmUgdG9fdGlfc3lzY29uX3Jlc2V0X2Rh
dGEocmNkZXYpCVwNCj4gQEAgLTE1OCwxMCArMTU5LDI0IEBAIHN0YXRpYyBpbnQgdGlfc3lzY29u
X3Jlc2V0X3N0YXR1cyhzdHJ1Y3QgcmVzZXRfY29udHJvbGxlcl9kZXYgKnJjZGV2LA0KPiAgCQkh
KGNvbnRyb2wtPmZsYWdzICYgU1RBVFVTX1NFVCk7DQo+ICB9DQo+ICANCj4gK3N0YXRpYyBpbnQg
dGlfc3lzY29uX3Jlc2V0KHN0cnVjdCByZXNldF9jb250cm9sbGVyX2RldiAqcmNkZXYsDQo+ICsJ
CQkgIHVuc2lnbmVkIGxvbmcgaWQpDQo+ICt7DQo+ICsJc3RydWN0IHRpX3N5c2Nvbl9yZXNldF9k
YXRhICpkYXRhID0gdG9fdGlfc3lzY29uX3Jlc2V0X2RhdGEocmNkZXYpOw0KPiArDQo+ICsJaWYg
KGRhdGEtPmFzc2VydF9kZWFzc2VydF90b2dldGhlcikgew0KPiArCQl0aV9zeXNjb25fcmVzZXRf
YXNzZXJ0KHJjZGV2LCBpZCk7DQo+ICsJCXJldHVybiB0aV9zeXNjb25fcmVzZXRfZGVhc3NlcnQo
cmNkZXYsIGlkKTsNCj4gKwl9IGVsc2Ugew0KPiArCQlyZXR1cm4gLUVOT1RTVVBQOw0KPiArCX0N
Cj4gK30NCj4gKw0KPiAgc3RhdGljIGNvbnN0IHN0cnVjdCByZXNldF9jb250cm9sX29wcyB0aV9z
eXNjb25fcmVzZXRfb3BzID0gew0KPiAgCS5hc3NlcnQJCT0gdGlfc3lzY29uX3Jlc2V0X2Fzc2Vy
dCwNCj4gIAkuZGVhc3NlcnQJPSB0aV9zeXNjb25fcmVzZXRfZGVhc3NlcnQsDQo+ICAJLnN0YXR1
cwkJPSB0aV9zeXNjb25fcmVzZXRfc3RhdHVzLA0KPiArCS5yZXNldAkJPSB0aV9zeXNjb25fcmVz
ZXQsDQo+ICB9Ow0KPiAgDQo+ICBzdGF0aWMgaW50IHRpX3N5c2Nvbl9yZXNldF9wcm9iZShzdHJ1
Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiBAQCAtMjA0LDYgKzIxOSwxMSBAQCBzdGF0aWMg
aW50IHRpX3N5c2Nvbl9yZXNldF9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0K
PiAgCQljb250cm9sc1tpXS5mbGFncyA9IGJlMzJfdG9fY3B1cChsaXN0KyspOw0KPiAgCX0NCj4g
IA0KPiArCWlmIChvZl9wcm9wZXJ0eV9yZWFkX2Jvb2wobnAsICJhc3NlcnQtZGVhc3NlcnQtdG9n
ZXRoZXIiKSkNCj4gKwkJZGF0YS0+YXNzZXJ0X2RlYXNzZXJ0X3RvZ2V0aGVyID0gdHJ1ZTsNCj4g
KwllbHNlDQo+ICsJCWRhdGEtPmFzc2VydF9kZWFzc2VydF90b2dldGhlciA9IGZhbHNlOw0KPiAr
DQo+ICAJZGF0YS0+cmNkZXYub3BzID0gJnRpX3N5c2Nvbl9yZXNldF9vcHM7DQo+ICAJZGF0YS0+
cmNkZXYub3duZXIgPSBUSElTX01PRFVMRTsNCj4gIAlkYXRhLT5yY2Rldi5vZl9ub2RlID0gbnA7
DQoNClBlcmhhcHMgcGxlYXNlIHByb3ZpZGUgdGhlIHJlYXNvbiB3aHkgeW91IHNoYWxsIGFkZCB0
aGlzIG5ldyBtZXRob2Q/IEFueQ0KZXhpc3RlZCBvciB1cGNvbWluZyB1c2Vycz8NCg0KVGhhbmtz
LA0KDQpTdGFubGV5IENodQ0KDQoNCg==

