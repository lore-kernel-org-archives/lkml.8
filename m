Return-Path: <SRS0=iO2y=4R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14245C3F2C6
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 13:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6FF8246A2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 13:40:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="e21lr+6W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbgB2NkY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 08:40:24 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:23442 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726995AbgB2NkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 08:40:24 -0500
X-UUID: c27bc30714f845e08a1227099f8995c2-20200229
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=zitOnP+eApgORZH5lc1x2JLP2/ns1VkO1JNAYN3t0Mo=;
        b=e21lr+6W/xGpU+TUl+IqaTN3WQh2yoA+rlZmQeq5gkmpGM2yipPxQOlED9B4xpnYiMCHDzdgPLYXCdX293LMHY7ETbCiwFwcmJZBaYHpi6M4kYsEJOlbVLb5ynemiTU87WSWIwRMVCrC7d4up6f4H+W6tdfns7w7IelYoTbfvbY=;
X-UUID: c27bc30714f845e08a1227099f8995c2-20200229
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 127865145; Sat, 29 Feb 2020 21:40:18 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sat, 29 Feb 2020 21:39:16 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sat, 29 Feb 2020 21:39:54 +0800
Message-ID: <1582983616.21073.4.camel@mtkswgap22>
Subject: Re: [PATCH v3 04/13] mailbox: mediatek: cmdq: clear task in channel
 before shutdown
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
Date:   Sat, 29 Feb 2020 21:40:16 +0800
In-Reply-To: <1582905422.14824.22.camel@mtksdaap41>
References: <1582897461-15105-1-git-send-email-dennis-yc.hsieh@mediatek.com>
         <1582897461-15105-6-git-send-email-dennis-yc.hsieh@mediatek.com>
         <1582905422.14824.22.camel@mtksdaap41>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 3FC05AABEE98AB8056D43B46ECFD21BB96CB48C37D022F69760BF94E6E4745AE2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ0ssDQoNClRoYW5rcyBmb3IgeW91ciBjb21tZW50Lg0KDQpPbiBGcmksIDIwMjAtMDItMjgg
YXQgMjM6NTcgKzA4MDAsIENLIEh1IHdyb3RlOg0KPiBIaSwgRGVubmlzOg0KPiANCj4gT24gRnJp
LCAyMDIwLTAyLTI4IGF0IDIxOjQ0ICswODAwLCBEZW5uaXMgWUMgSHNpZWggd3JvdGU6DQo+ID4g
RG8gc3VjY2VzcyBjYWxsYmFjayBpbiBjaGFubmVsIHdoZW4gc2h1dGRvd24uIEZvciB0aG9zZSB0
YXNrIG5vdCBmaW5pc2gsDQo+ID4gY2FsbGJhY2sgd2l0aCBlcnJvciBjb2RlIHRodXMgY2xpZW50
IGhhcyBjaGFuY2UgdG8gY2xlYW51cCBvciByZXNldC4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5
OiBEZW5uaXMgWUMgSHNpZWggPGRlbm5pcy15Yy5oc2llaEBtZWRpYXRlay5jb20+DQo+ID4gLS0t
DQo+ID4gIGRyaXZlcnMvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmMgfCAzOCArKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDM4IGluc2VydGlvbnMo
KykNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tYWlsYm94L210ay1jbWRxLW1haWxi
b3guYyBiL2RyaXZlcnMvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmMNCj4gPiBpbmRleCA3MjQ2
YjdlMjFhMmUuLjUwZGVjMDE1NTkzZiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL21haWxib3gv
bXRrLWNtZHEtbWFpbGJveC5jDQo+ID4gKysrIGIvZHJpdmVycy9tYWlsYm94L210ay1jbWRxLW1h
aWxib3guYw0KPiA+IEBAIC0zODcsNiArMzg3LDEyIEBAIHN0YXRpYyBpbnQgY21kcV9tYm94X3Nl
bmRfZGF0YShzdHJ1Y3QgbWJveF9jaGFuICpjaGFuLCB2b2lkICpkYXRhKQ0KPiA+ICANCj4gPiAg
CWlmIChsaXN0X2VtcHR5KCZ0aHJlYWQtPnRhc2tfYnVzeV9saXN0KSkgew0KPiA+ICAJCVdBUk5f
T04oY2xrX2VuYWJsZShjbWRxLT5jbG9jaykgPCAwKTsNCj4gPiArCQkvKg0KPiA+ICsJCSAqIFRo
ZSB0aHJlYWQgcmVzZXQgd2lsbCBjbGVhciB0aHJlYWQgcmVsYXRlZCByZWdpc3RlciB0byAwLA0K
PiA+ICsJCSAqIGluY2x1ZGluZyBwYywgZW5kLCBwcmlvcml0eSwgaXJxLCBzdXNwZW5kIGFuZCBl
bmFibGUuIFRodXMNCj4gPiArCQkgKiBzZXQgQ01EUV9USFJfRU5BQkxFRCB0byBDTURRX1RIUl9F
TkFCTEVfVEFTSyB3aWxsIGVuYWJsZQ0KPiA+ICsJCSAqIHRocmVhZCBhbmQgbWFrZSBpdCBydW5u
aW5nLg0KPiA+ICsJCSAqLw0KPiA+ICAJCVdBUk5fT04oY21kcV90aHJlYWRfcmVzZXQoY21kcSwg
dGhyZWFkKSA8IDApOw0KPiA+ICANCj4gPiAgCQl3cml0ZWwodGFzay0+cGFfYmFzZSA+PiBjbWRx
LT5zaGlmdF9wYSwNCj4gPiBAQCAtNDUwLDYgKzQ1NiwzOCBAQCBzdGF0aWMgaW50IGNtZHFfbWJv
eF9zdGFydHVwKHN0cnVjdCBtYm94X2NoYW4gKmNoYW4pDQo+ID4gIA0KPiA+ICBzdGF0aWMgdm9p
ZCBjbWRxX21ib3hfc2h1dGRvd24oc3RydWN0IG1ib3hfY2hhbiAqY2hhbikNCj4gPiAgew0KPiA+
ICsJc3RydWN0IGNtZHFfdGhyZWFkICp0aHJlYWQgPSAoc3RydWN0IGNtZHFfdGhyZWFkICopY2hh
bi0+Y29uX3ByaXY7DQo+ID4gKwlzdHJ1Y3QgY21kcSAqY21kcSA9IGRldl9nZXRfZHJ2ZGF0YShj
aGFuLT5tYm94LT5kZXYpOw0KPiA+ICsJc3RydWN0IGNtZHFfdGFzayAqdGFzaywgKnRtcDsNCj4g
PiArCXVuc2lnbmVkIGxvbmcgZmxhZ3M7DQo+ID4gKw0KPiA+ICsJc3Bpbl9sb2NrX2lycXNhdmUo
JnRocmVhZC0+Y2hhbi0+bG9jaywgZmxhZ3MpOw0KPiA+ICsJaWYgKGxpc3RfZW1wdHkoJnRocmVh
ZC0+dGFza19idXN5X2xpc3QpKQ0KPiA+ICsJCWdvdG8gZG9uZTsNCj4gPiArDQo+ID4gKwlXQVJO
X09OKGNtZHFfdGhyZWFkX3N1c3BlbmQoY21kcSwgdGhyZWFkKSA8IDApOw0KPiA+ICsNCj4gPiAr
CS8qIG1ha2Ugc3VyZSBleGVjdXRlZCB0YXNrcyBoYXZlIHN1Y2Nlc3MgY2FsbGJhY2sgKi8NCj4g
PiArCWNtZHFfdGhyZWFkX2lycV9oYW5kbGVyKGNtZHEsIHRocmVhZCk7DQo+ID4gKwlpZiAobGlz
dF9lbXB0eSgmdGhyZWFkLT50YXNrX2J1c3lfbGlzdCkpDQo+ID4gKwkJZ290byBkb25lOw0KPiA+
ICsNCj4gPiArCWxpc3RfZm9yX2VhY2hfZW50cnlfc2FmZSh0YXNrLCB0bXAsICZ0aHJlYWQtPnRh
c2tfYnVzeV9saXN0LA0KPiA+ICsJCQkJIGxpc3RfZW50cnkpIHsNCj4gPiArCQljbWRxX3Rhc2tf
ZXhlY19kb25lKHRhc2ssIC1FQ09OTkFCT1JURUQpOw0KPiANCj4gY21kcV90YXNrX2V4ZWNfZG9u
ZSh0YXNrLCBDTURRX0NCX0VSUk9SKSA/IEhvd2V2ZXIsIEkndmUgbGlrZSB0byB1c2UgdGhlDQo+
IHN0YW5kYXJkIGVycm9yIGFzIHlvdSB3cml0ZSBoZXJlLg0KPiANCg0KT2ssIGZvciBjb25zaXN0
ZW50IHdpdGggY3VycmVudCBkZXNpZ24sIEkgd2lsbCBjaGFuZ2UgdG8gQ01EUV9DQl9FUlJPUi4N
CkFuZCBzZW5kIGFub3RoZXIgcGF0Y2ggdG8gY2hhbmdlIGFsbCBjbWRxIGVycm9yIGRlZmluaXRp
b24gdG8gc3RhbmRhcmQNCmVycm9yIG5leHQgdGltZS4NCg0KDQpSZWdhcmRzLA0KRGVubmlzDQoN
Cg0KPiBSZWdhcmRzLA0KPiBDSw0KPiANCj4gPiArCQlrZnJlZSh0YXNrKTsNCj4gPiArCX0NCj4g
PiArDQo+ID4gKwljbWRxX3RocmVhZF9kaXNhYmxlKGNtZHEsIHRocmVhZCk7DQo+ID4gKwljbGtf
ZGlzYWJsZShjbWRxLT5jbG9jayk7DQo+ID4gK2RvbmU6DQo+ID4gKwkvKg0KPiA+ICsJICogVGhl
IHRocmVhZC0+dGFza19idXN5X2xpc3QgZW1wdHkgbWVhbnMgdGhyZWFkIGFscmVhZHkgZGlzYWJs
ZS4gVGhlDQo+ID4gKwkgKiBjbWRxX21ib3hfc2VuZF9kYXRhKCkgYWx3YXlzIHJlc2V0IHRocmVh
ZCB3aGljaCBjbGVhciBkaXNhYmxlIGFuZA0KPiA+ICsJICogc3VzcGVuZCBzdGF0dWUgd2hlbiBm
aXJzdCBwa3Qgc2VuZCB0byBjaGFubmVsLCBzbyB0aGVyZSBpcyBubyBuZWVkDQo+ID4gKwkgKiB0
byBkbyBhbnkgb3BlcmF0aW9uIGhlcmUsIG9ubHkgdW5sb2NrIGFuZCBsZWF2ZS4NCj4gPiArCSAq
Lw0KPiA+ICsJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmdGhyZWFkLT5jaGFuLT5sb2NrLCBmbGFn
cyk7DQo+ID4gIH0NCj4gPiAgDQo+ID4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbWJveF9jaGFuX29w
cyBjbWRxX21ib3hfY2hhbl9vcHMgPSB7DQo+IA0KPiANCg0K

