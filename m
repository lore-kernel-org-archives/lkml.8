Return-Path: <SRS0=iO2y=4R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17482C3F2C6
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 13:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE86F246A3
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 13:42:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Bl7TXcQf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbgB2Nmg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 08:42:36 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:41395 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727003AbgB2Nmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 08:42:36 -0500
X-UUID: 67885924e42d45bbb4566cf722b0cf0d-20200229
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=cQkQXaq7I6lwdpCSeXRWaWw4mSw0OfTOluhKKLIJai4=;
        b=Bl7TXcQfBqtUvLvsfquaU/Q4/A9yOiUGvhkKA96tGkx6wipngKxWXp5jlIgbVXRiSetfIYRmqOQ1576rVrjXShwRQoyGxhD6h96FD4TE/R04oLapB6Z0QJOq1lp51yf5b6ENVB0pBEfLCkA1r0B0QeJfew122+5DAvPXsJoDUe8=;
X-UUID: 67885924e42d45bbb4566cf722b0cf0d-20200229
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 703551717; Sat, 29 Feb 2020 21:42:28 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sat, 29 Feb 2020 21:41:27 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sat, 29 Feb 2020 21:42:04 +0800
Message-ID: <1582983747.21073.7.camel@mtkswgap22>
Subject: Re: [PATCH v3 11/13] soc: mediatek: cmdq: add jump function
From:   Dennis-YC Hsieh <dennis-yc.hsieh@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        "Ming-Fan Chen" <ming-fan.chen@mediatek.com>
Date:   Sat, 29 Feb 2020 21:42:27 +0800
In-Reply-To: <1582901981.14824.9.camel@mtksdaap41>
References: <1582897461-15105-1-git-send-email-dennis-yc.hsieh@mediatek.com>
         <1582897461-15105-13-git-send-email-dennis-yc.hsieh@mediatek.com>
         <1582901981.14824.9.camel@mtksdaap41>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: CBDBE3BEFEB61174315C589E7E673FE40EFFB573D8E4196F5D7D6274AF11E8562000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ0ssDQoNClRoYW5rcyBmb3IgeW91ciBjb21tZW50Lg0KDQpPbiBGcmksIDIwMjAtMDItMjgg
YXQgMjI6NTkgKzA4MDAsIENLIEh1IHdyb3RlOg0KPiBIaSwgRGVubmlzOg0KPiANCj4gT24gRnJp
LCAyMDIwLTAyLTI4IGF0IDIxOjQ0ICswODAwLCBEZW5uaXMgWUMgSHNpZWggd3JvdGU6DQo+ID4g
QWRkIGp1bXAgZnVuY3Rpb24gc28gdGhhdCBjbGllbnQgY2FuIGp1bXAgdG8gYW55IGFkZHJlc3Mg
d2hpY2gNCj4gPiBjb250YWlucyBpbnN0cnVjdGlvbi4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5
OiBEZW5uaXMgWUMgSHNpZWggPGRlbm5pcy15Yy5oc2llaEBtZWRpYXRlay5jb20+DQo+ID4gLS0t
DQo+ID4gIGRyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jIHwgMTIgKysrKysr
KysrKysrDQo+ID4gIGluY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmggIHwgMTEg
KysrKysrKysrKysNCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCAyMyBpbnNlcnRpb25zKCspDQo+ID4g
DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5j
IGIvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMNCj4gPiBpbmRleCA1OGZl
YzYzNGRjZjEuLmJiYzY4YTdjODFlOSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3NvYy9tZWRp
YXRlay9tdGstY21kcS1oZWxwZXIuYw0KPiA+ICsrKyBiL2RyaXZlcnMvc29jL21lZGlhdGVrL210
ay1jbWRxLWhlbHBlci5jDQo+ID4gQEAgLTM3Miw2ICszNzIsMTggQEAgaW50IGNtZHFfcGt0X2Fz
c2lnbihzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgdTE2IHJlZ19pZHgsIHUzMiB2YWx1ZSkNCj4gPiAg
fQ0KPiA+ICBFWFBPUlRfU1lNQk9MKGNtZHFfcGt0X2Fzc2lnbik7DQo+ID4gIA0KPiA+ICtpbnQg
Y21kcV9wa3RfanVtcChzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgZG1hX2FkZHJfdCBhZGRyKQ0KPiA+
ICt7DQo+ID4gKwlzdHJ1Y3QgY21kcV9jbGllbnQgKmNsID0gcGt0LT5jbDsNCj4gPiArCXN0cnVj
dCBjbWRxX2luc3RydWN0aW9uIGluc3QgPSB7IHswfSB9Ow0KPiA+ICsNCj4gPiArCWluc3Qub3Ag
PSBDTURRX0NPREVfSlVNUDsNCj4gPiArCWluc3Qub2Zmc2V0ID0gMTsNCj4gDQo+IFN5bWJvbGl6
ZSB0aGUgdmFsdWUgJzEnLg0KPiANCj4gPiArCWluc3QudmFsdWUgPSBhZGRyID4+IGNtZHFfbWJv
eF9zaGlmdChjbC0+Y2hhbik7DQo+IA0KPiBJZiB5b3Ugd3JpdGUgYXMgJ2NtZHFfbWJveF9zaGlm
dChwa3QtPmNsLT5jaGFuKScsIHlvdSBjb3VsZCBkcm9wIGxvY2FsDQo+IHZhcmlhYmxlICdjbCcu
DQoNCk9rLCB3aWxsIGRvLg0KDQoNClJlZ2FyZHMsDQpEZW5uaXMNCg0KPiANCj4gUmVnYXJkcywN
Cj4gQ0sNCj4gDQo+ID4gKwlyZXR1cm4gY21kcV9wa3RfYXBwZW5kX2NvbW1hbmQocGt0LCBpbnN0
KTsNCj4gPiArfQ0KPiA+ICtFWFBPUlRfU1lNQk9MKGNtZHFfcGt0X2p1bXApOw0KPiA+ICsNCj4g
PiAgaW50IGNtZHFfcGt0X2ZpbmFsaXplKHN0cnVjdCBjbWRxX3BrdCAqcGt0KQ0KPiA+ICB7DQo+
ID4gIAlzdHJ1Y3QgY21kcV9pbnN0cnVjdGlvbiBpbnN0ID0geyB7MH0gfTsNCj4gPiBkaWZmIC0t
Z2l0IGEvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaCBiL2luY2x1ZGUvbGlu
dXgvc29jL21lZGlhdGVrL210ay1jbWRxLmgNCj4gPiBpbmRleCA5OWU3NzE1NWY5NjcuLjFhNmM1
NmYzYmVjMSAxMDA2NDQNCj4gPiAtLS0gYS9pbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGst
Y21kcS5oDQo+ID4gKysrIGIvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaA0K
PiA+IEBAIC0yMTMsNiArMjEzLDE3IEBAIGludCBjbWRxX3BrdF9wb2xsX21hc2soc3RydWN0IGNt
ZHFfcGt0ICpwa3QsIHU4IHN1YnN5cywNCj4gPiAgICovDQo+ID4gIGludCBjbWRxX3BrdF9hc3Np
Z24oc3RydWN0IGNtZHFfcGt0ICpwa3QsIHUxNiByZWdfaWR4LCB1MzIgdmFsdWUpOw0KPiA+ICAN
Cj4gPiArLyoqDQo+ID4gKyAqIGNtZHFfcGt0X2p1bXAoKSAtIEFwcGVuZCBqdW1wIGNvbW1hbmQg
dG8gdGhlIENNRFEgcGFja2V0LCBhc2sgR0NFDQo+ID4gKyAqCQkgICAgIHRvIGV4ZWN1dGUgYW4g
aW5zdHJ1Y3Rpb24gdGhhdCBjaGFuZ2UgY3VycmVudCB0aHJlYWQgUEMgdG8NCj4gPiArICoJCSAg
ICAgYSBwaHlzaWNhbCBhZGRyZXNzIHdoaWNoIHNob3VsZCBjb250YWlucyBtb3JlIGluc3RydWN0
aW9uLg0KPiA+ICsgKiBAcGt0OiAgICAgICAgdGhlIENNRFEgcGFja2V0DQo+ID4gKyAqIEBhZGRy
OiAgICAgICBwaHlzaWNhbCBhZGRyZXNzIG9mIHRhcmdldCBpbnN0cnVjdGlvbiBidWZmZXINCj4g
PiArICoNCj4gPiArICogUmV0dXJuOiAwIGZvciBzdWNjZXNzOyBlbHNlIHRoZSBlcnJvciBjb2Rl
IGlzIHJldHVybmVkDQo+ID4gKyAqLw0KPiA+ICtpbnQgY21kcV9wa3RfanVtcChzdHJ1Y3QgY21k
cV9wa3QgKnBrdCwgZG1hX2FkZHJfdCBhZGRyKTsNCj4gPiArDQo+ID4gIC8qKg0KPiA+ICAgKiBj
bWRxX3BrdF9maW5hbGl6ZSgpIC0gQXBwZW5kIEVPQyBhbmQganVtcCBjb21tYW5kIHRvIHBrdC4N
Cj4gPiAgICogQHBrdDoJdGhlIENNRFEgcGFja2V0DQo+IA0KPiANCg0K

