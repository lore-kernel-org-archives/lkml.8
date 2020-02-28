Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23848C3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 14:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E19C52072A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 14:55:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="i5Zcoth6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbgB1Ozr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 09:55:47 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:15064 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726906AbgB1Ozq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 09:55:46 -0500
X-UUID: bec45df404ff4219a8476fd81106c3f9-20200228
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=KupROzX3aGOHBHNRJXxfTvVaiYRDVDCR4a16idnL8VA=;
        b=i5Zcoth6DexXSmXFNfAo4B6rl2NkfsojbC3nBlrWeDPp4kyLQrXpvwZeDdC8hRWFlcmSous5b/Mbr0AFA/N+RWBCKFZJ7xISDX7pwPurp16w3GDp9qsbQWazZuag0bRcfpC2i9Mvf6hP0uFTDXNYrwA9PS7r6G7Sb1lOTGVD6U0=;
X-UUID: bec45df404ff4219a8476fd81106c3f9-20200228
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 425614716; Fri, 28 Feb 2020 22:55:42 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 28 Feb 2020 22:54:47 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 28 Feb 2020 22:55:23 +0800
Message-ID: <1582901741.14824.6.camel@mtksdaap41>
Subject: Re: [PATCH v3 09/13] soc: mediatek: cmdq: add write_s value function
From:   CK Hu <ck.hu@mediatek.com>
To:     Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
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
Date:   Fri, 28 Feb 2020 22:55:41 +0800
In-Reply-To: <1582897461-15105-11-git-send-email-dennis-yc.hsieh@mediatek.com>
References: <1582897461-15105-1-git-send-email-dennis-yc.hsieh@mediatek.com>
         <1582897461-15105-11-git-send-email-dennis-yc.hsieh@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIERlbm5pczoNCg0KT24gRnJpLCAyMDIwLTAyLTI4IGF0IDIxOjQ0ICswODAwLCBEZW5uaXMg
WUMgSHNpZWggd3JvdGU6DQo+IGFkZCB3cml0ZV9zIGZ1bmN0aW9uIGluIGNtZHEgaGVscGVyIGZ1
bmN0aW9ucyB3aGljaA0KPiB3cml0ZXMgYSBjb25zdGFudCB2YWx1ZSB0byBhZGRyZXNzIHdpdGgg
bGFyZ2UgZG1hDQo+IGFjY2VzcyBzdXBwb3J0Lg0KPiANCg0KUmV2aWV3ZWQtYnk6IENLIEh1IDxj
ay5odUBtZWRpYXRlay5jb20+DQoNCj4gU2lnbmVkLW9mZi1ieTogRGVubmlzIFlDIEhzaWVoIDxk
ZW5uaXMteWMuaHNpZWhAbWVkaWF0ZWsuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvc29jL21lZGlh
dGVrL210ay1jbWRxLWhlbHBlci5jIHwgMjYgKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4g
IGluY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmggIHwgMTQgKysrKysrKysrKysr
KysNCj4gIDIgZmlsZXMgY2hhbmdlZCwgNDAgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jIGIvZHJpdmVycy9zb2Mv
bWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMNCj4gaW5kZXggNDI4Zjk5Mjg4Y2E2Li4xMzM2NTIz
ZWI3ZDQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBl
ci5jDQo+ICsrKyBiL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jDQo+IEBA
IC0yNjksNiArMjY5LDMyIEBAIGludCBjbWRxX3BrdF93cml0ZV9zKHN0cnVjdCBjbWRxX3BrdCAq
cGt0LCB1MTYgaGlnaF9hZGRyX3JlZ19pZHgsDQo+ICB9DQo+ICBFWFBPUlRfU1lNQk9MKGNtZHFf
cGt0X3dyaXRlX3MpOw0KPiAgDQo+ICtpbnQgY21kcV9wa3Rfd3JpdGVfc192YWx1ZShzdHJ1Y3Qg
Y21kcV9wa3QgKnBrdCwgdTE2IGhpZ2hfYWRkcl9yZWdfaWR4LA0KPiArCQkJICAgdTE2IGFkZHJf
bG93LCB1MzIgdmFsdWUsIHUzMiBtYXNrKQ0KPiArew0KPiArCXN0cnVjdCBjbWRxX2luc3RydWN0
aW9uIGluc3QgPSB7IHswfSB9Ow0KPiArCWludCBlcnI7DQo+ICsNCj4gKwlpZiAobWFzayAhPSBV
MzJfTUFYKSB7DQo+ICsJCWluc3Qub3AgPSBDTURRX0NPREVfTUFTSzsNCj4gKwkJaW5zdC5tYXNr
ID0gfm1hc2s7DQo+ICsJCWVyciA9IGNtZHFfcGt0X2FwcGVuZF9jb21tYW5kKHBrdCwgaW5zdCk7
DQo+ICsJCWlmIChlcnIgPCAwKQ0KPiArCQkJcmV0dXJuIGVycjsNCj4gKw0KPiArCQlpbnN0Lm9w
ID0gQ01EUV9DT0RFX1dSSVRFX1NfTUFTSzsNCj4gKwl9IGVsc2Ugew0KPiArCQlpbnN0Lm9wID0g
Q01EUV9DT0RFX1dSSVRFX1M7DQo+ICsJfQ0KPiArDQo+ICsJaW5zdC5zb3AgPSBoaWdoX2FkZHJf
cmVnX2lkeDsNCj4gKwlpbnN0Lm9mZnNldCA9IGFkZHJfbG93Ow0KPiArCWluc3QudmFsdWUgPSB2
YWx1ZTsNCj4gKw0KPiArCXJldHVybiBjbWRxX3BrdF9hcHBlbmRfY29tbWFuZChwa3QsIGluc3Qp
Ow0KPiArfQ0KPiArRVhQT1JUX1NZTUJPTChjbWRxX3BrdF93cml0ZV9zX3ZhbHVlKTsNCj4gKw0K
PiAgaW50IGNtZHFfcGt0X3dmZShzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgdTE2IGV2ZW50KQ0KPiAg
ew0KPiAgCXN0cnVjdCBjbWRxX2luc3RydWN0aW9uIGluc3QgPSB7IHswfSB9Ow0KPiBkaWZmIC0t
Z2l0IGEvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaCBiL2luY2x1ZGUvbGlu
dXgvc29jL21lZGlhdGVrL210ay1jbWRxLmgNCj4gaW5kZXggMDFiNDE4NGFmMzEwLi5mZWMyOTJh
YWM4M2MgMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRx
LmgNCj4gKysrIGIvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaA0KPiBAQCAt
MTM1LDYgKzEzNSwyMCBAQCBpbnQgY21kcV9wa3RfcmVhZF9zKHN0cnVjdCBjbWRxX3BrdCAqcGt0
LCB1MTYgaGlnaF9hZGRyX3JlZ19pZHgsIHUxNiBhZGRyX2xvdywNCj4gIGludCBjbWRxX3BrdF93
cml0ZV9zKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1MTYgaGlnaF9hZGRyX3JlZ19pZHgsDQo+ICAJ
CSAgICAgdTE2IGFkZHJfbG93LCB1MTYgc3JjX3JlZ19pZHgsIHUzMiBtYXNrKTsNCj4gIA0KPiAr
LyoqDQo+ICsgKiBjbWRxX3BrdF93cml0ZV9zX3ZhbHVlKCkgLSBhcHBlbmQgd3JpdGVfcyBjb21t
YW5kIHdpdGggbWFzayB0byB0aGUgQ01EUQ0KPiArICoJCQkgICAgICBwYWNrZXQgd2hpY2ggd3Jp
dGUgdmFsdWUgdG8gYSBwaHlzaWNhbCBhZGRyZXNzDQo+ICsgKiBAcGt0Ogl0aGUgQ01EUSBwYWNr
ZXQNCj4gKyAqIEBoaWdoX2FkZHJfcmVnX2lkeDoJaW50ZXJuYWwgcmVnaXNnZXIgSUQgd2hpY2gg
Y29udGFpbnMgaGlnaCBhZGRyZXNzIG9mIHBhDQo+ICsgKiBAYWRkcl9sb3c6CWxvdyBhZGRyZXNz
IG9mIHBhDQo+ICsgKiBAdmFsdWU6CXRoZSBzcGVjaWZpZWQgdGFyZ2V0IHZhbHVlDQo+ICsgKiBA
bWFzazoJdGhlIHNwZWNpZmllZCB0YXJnZXQgbWFzaw0KPiArICoNCj4gKyAqIFJldHVybjogMCBm
b3Igc3VjY2VzczsgZWxzZSB0aGUgZXJyb3IgY29kZSBpcyByZXR1cm5lZA0KPiArICovDQo+ICtp
bnQgY21kcV9wa3Rfd3JpdGVfc192YWx1ZShzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgdTE2IGhpZ2hf
YWRkcl9yZWdfaWR4LA0KPiArCQkJICAgdTE2IGFkZHJfbG93LCB1MzIgdmFsdWUsIHUzMiBtYXNr
KTsNCj4gKw0KPiAgLyoqDQo+ICAgKiBjbWRxX3BrdF93ZmUoKSAtIGFwcGVuZCB3YWl0IGZvciBl
dmVudCBjb21tYW5kIHRvIHRoZSBDTURRIHBhY2tldA0KPiAgICogQHBrdDoJdGhlIENNRFEgcGFj
a2V0DQoNCg==

