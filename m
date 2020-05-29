Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31891C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 00:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06DE920776
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 00:53:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Awvs9rJt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438198AbgE2Axi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 20:53:38 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:32304 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2438167AbgE2Axg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 20:53:36 -0400
X-UUID: a68046c16bb149f5892918719c8b01ff-20200529
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=/lOPSyCSRH8SaRh0UrYmb2qBLU0m25A26vWSjOAhAzw=;
        b=Awvs9rJtUKRmaW223hgHgyROhiX52oAfmrGmw3ZpYy6TYQpmtDDq+SX9c35JGpO7btn9XMChany4W56FhL+V1w5rzroUwt0HDnhFxfEmBTnEyhoy3fIb2Sybs8nzhX6aEMoM7dUieZUwHol5yEuJVSSQiokfnezy2lneosR4RuI=;
X-UUID: a68046c16bb149f5892918719c8b01ff-20200529
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1393919277; Fri, 29 May 2020 08:53:31 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 29 May 2020 08:53:25 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 29 May 2020 08:53:24 +0800
Message-ID: <1590713609.1313.1.camel@mtkswgap22>
Subject: Re: [PATCH v6 08/16] soc: mediatek: cmdq: add write_s function
From:   Dennis-YC Hsieh <dennis-yc.hsieh@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>, <dri-devel@lists.freedesktop.org>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        HS Liao <hs.liao@mediatek.com>
Date:   Fri, 29 May 2020 08:53:29 +0800
In-Reply-To: <086cd50f-1cf5-a87d-9547-7a826e6b6252@gmail.com>
References: <1590685491-17107-1-git-send-email-dennis-yc.hsieh@mediatek.com>
         <1590685491-17107-9-git-send-email-dennis-yc.hsieh@mediatek.com>
         <086cd50f-1cf5-a87d-9547-7a826e6b6252@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: BADAF1CEB1FE522F0D19D2C0252EAD855B25F39E7E640634BA704236E5DB5E2F2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWF0dGhpYXMsDQoNClRoYW5rcyBmb3IgeW91ciBjb21tZW50Lg0KDQpPbiBUaHUsIDIwMjAt
MDUtMjggYXQgMjM6MDggKzAyMDAsIE1hdHRoaWFzIEJydWdnZXIgd3JvdGU6DQo+IA0KPiBPbiAy
OC8wNS8yMDIwIDE5OjA0LCBEZW5uaXMgWUMgSHNpZWggd3JvdGU6DQo+ID4gYWRkIHdyaXRlX3Mg
ZnVuY3Rpb24gaW4gY21kcSBoZWxwZXIgZnVuY3Rpb25zIHdoaWNoDQo+ID4gd3JpdGVzIHZhbHVl
IGNvbnRhaW5zIGluIGludGVybmFsIHJlZ2lzdGVyIHRvIGFkZHJlc3MNCj4gPiB3aXRoIGxhcmdl
IGRtYSBhY2Nlc3Mgc3VwcG9ydC4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBEZW5uaXMgWUMg
SHNpZWggPGRlbm5pcy15Yy5oc2llaEBtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZl
cnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jICAgfCAyMSArKysrKysrKysrKysrKysr
KysrKy0NCj4gPiAgaW5jbHVkZS9saW51eC9tYWlsYm94L210ay1jbWRxLW1haWxib3guaCB8ICAx
ICsNCj4gPiAgaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaCAgICB8IDIwICsr
KysrKysrKysrKysrKysrKysrDQo+ID4gIDMgZmlsZXMgY2hhbmdlZCwgNDEgaW5zZXJ0aW9ucygr
KSwgMSBkZWxldGlvbigtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3NvYy9tZWRp
YXRlay9tdGstY21kcS1oZWxwZXIuYyBiL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhl
bHBlci5jDQo+ID4gaW5kZXggMzMxNTNkMTdjOWQ5Li5lZTI0YzBlYzBhMjQgMTAwNjQ0DQo+ID4g
LS0tIGEvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMNCj4gPiArKysgYi9k
cml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYw0KPiA+IEBAIC0xOCw2ICsxOCwx
MCBAQCBzdHJ1Y3QgY21kcV9pbnN0cnVjdGlvbiB7DQo+ID4gIAl1bmlvbiB7DQo+ID4gIAkJdTMy
IHZhbHVlOw0KPiA+ICAJCXUzMiBtYXNrOw0KPiA+ICsJCXN0cnVjdCB7DQo+ID4gKwkJCXUxNiBh
cmdfYzsNCj4gPiArCQkJdTE2IHNyY19yZWc7DQo+ID4gKwkJfTsNCj4gPiAgCX07DQo+ID4gIAl1
bmlvbiB7DQo+ID4gIAkJdTE2IG9mZnNldDsNCj4gPiBAQCAtMjksNyArMzMsNyBAQCBzdHJ1Y3Qg
Y21kcV9pbnN0cnVjdGlvbiB7DQo+ID4gIAkJc3RydWN0IHsNCj4gPiAgCQkJdTggc29wOjU7DQo+
ID4gIAkJCXU4IGFyZ19jX3Q6MTsNCj4gPiAtCQkJdTggYXJnX2JfdDoxOw0KPiA+ICsJCQl1OCBz
cmNfdDoxOw0KPiANCj4gVGhpcyBzaG91bGQgYmUgcGFydCBvZiA3LzE2Lg0KDQpvaywgSSdsbCBt
b3ZlIGl0DQoNCj4gDQo+ID4gIAkJCXU4IGRzdF90OjE7DQo+ID4gIAkJfTsNCj4gPiAgCX07DQo+
ID4gQEAgLTIyMiw2ICsyMjYsMjEgQEAgaW50IGNtZHFfcGt0X3dyaXRlX21hc2soc3RydWN0IGNt
ZHFfcGt0ICpwa3QsIHU4IHN1YnN5cywNCj4gPiAgfQ0KPiA+ICBFWFBPUlRfU1lNQk9MKGNtZHFf
cGt0X3dyaXRlX21hc2spOw0KPiA+ICANCj4gPiAraW50IGNtZHFfcGt0X3dyaXRlX3Moc3RydWN0
IGNtZHFfcGt0ICpwa3QsIHUxNiBoaWdoX2FkZHJfcmVnX2lkeCwNCj4gPiArCQkgICAgIHUxNiBh
ZGRyX2xvdywgdTE2IHNyY19yZWdfaWR4KQ0KPiA+ICt7DQo+ID4gKwlzdHJ1Y3QgY21kcV9pbnN0
cnVjdGlvbiBpbnN0ID0geyB7MH0gfTsNCj4gDQo+IElmIHlvdSB3YW50IGFuIGVtcHR5IHN0cnVj
dCBvbiB0aGUgc3RhY2ssIEkgdGhpbmsge307IHNob3VsZCBiZSBlbm91Z2gsIHJpZ2h0Pw0KDQpZ
ZXMsIEknbGwgY2hhbmdlIHRoZSBzdHlsZSwgdGhhbmtzDQoNCg0KUmVnYXJkcywNCkRlbm5pcw0K
DQo+IA0KPiBSZWdhcmRzLA0KPiBNYXR0aGlhcw0KPiANCj4gPiArDQo+ID4gKwlpbnN0Lm9wID0g
Q01EUV9DT0RFX1dSSVRFX1M7DQo+ID4gKwlpbnN0LnNyY190ID0gQ01EUV9SRUdfVFlQRTsNCj4g
PiArCWluc3Quc29wID0gaGlnaF9hZGRyX3JlZ19pZHg7DQo+ID4gKwlpbnN0Lm9mZnNldCA9IGFk
ZHJfbG93Ow0KPiA+ICsJaW5zdC5zcmNfcmVnID0gc3JjX3JlZ19pZHg7DQo+ID4gKw0KPiA+ICsJ
cmV0dXJuIGNtZHFfcGt0X2FwcGVuZF9jb21tYW5kKHBrdCwgaW5zdCk7DQo+ID4gK30NCj4gPiAr
RVhQT1JUX1NZTUJPTChjbWRxX3BrdF93cml0ZV9zKTsNCj4gPiArDQo+ID4gIGludCBjbWRxX3Br
dF93ZmUoc3RydWN0IGNtZHFfcGt0ICpwa3QsIHUxNiBldmVudCkNCj4gPiAgew0KPiA+ICAJc3Ry
dWN0IGNtZHFfaW5zdHJ1Y3Rpb24gaW5zdCA9IHsgezB9IH07DQo+ID4gZGlmZiAtLWdpdCBhL2lu
Y2x1ZGUvbGludXgvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmggYi9pbmNsdWRlL2xpbnV4L21h
aWxib3gvbXRrLWNtZHEtbWFpbGJveC5oDQo+ID4gaW5kZXggMTIxYzNiYjZkM2RlLi5lZTY3ZGQz
Yjg2ZjUgMTAwNjQ0DQo+ID4gLS0tIGEvaW5jbHVkZS9saW51eC9tYWlsYm94L210ay1jbWRxLW1h
aWxib3guaA0KPiA+ICsrKyBiL2luY2x1ZGUvbGludXgvbWFpbGJveC9tdGstY21kcS1tYWlsYm94
LmgNCj4gPiBAQCAtNTksNiArNTksNyBAQCBlbnVtIGNtZHFfY29kZSB7DQo+ID4gIAlDTURRX0NP
REVfSlVNUCA9IDB4MTAsDQo+ID4gIAlDTURRX0NPREVfV0ZFID0gMHgyMCwNCj4gPiAgCUNNRFFf
Q09ERV9FT0MgPSAweDQwLA0KPiA+ICsJQ01EUV9DT0RFX1dSSVRFX1MgPSAweDkwLA0KPiA+ICAJ
Q01EUV9DT0RFX0xPR0lDID0gMHhhMCwNCj4gPiAgfTsNCj4gPiAgDQo+ID4gZGlmZiAtLWdpdCBh
L2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmggYi9pbmNsdWRlL2xpbnV4L3Nv
Yy9tZWRpYXRlay9tdGstY21kcS5oDQo+ID4gaW5kZXggODMzNDAyMTFlMWQzLi5kNjIzZjFhYTc4
MTQgMTAwNjQ0DQo+ID4gLS0tIGEvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEu
aA0KPiA+ICsrKyBiL2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmgNCj4gPiBA
QCAtMTIsNiArMTIsOCBAQA0KPiA+ICAjaW5jbHVkZSA8bGludXgvdGltZXIuaD4NCj4gPiAgDQo+
ID4gICNkZWZpbmUgQ01EUV9OT19USU1FT1VUCQkweGZmZmZmZmZmdQ0KPiA+ICsjZGVmaW5lIENN
RFFfQUREUl9ISUdIKGFkZHIpCSgodTMyKSgoKGFkZHIpID4+IDE2KSAmIEdFTk1BU0soMzEsIDAp
KSkNCj4gPiArI2RlZmluZSBDTURRX0FERFJfTE9XKGFkZHIpCSgodTE2KShhZGRyKSB8IEJJVCgx
KSkNCj4gPiAgDQo+ID4gIHN0cnVjdCBjbWRxX3BrdDsNCj4gPiAgDQo+ID4gQEAgLTEwMiw2ICsx
MDQsMjQgQEAgaW50IGNtZHFfcGt0X3dyaXRlKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1OCBzdWJz
eXMsIHUxNiBvZmZzZXQsIHUzMiB2YWx1ZSk7DQo+ID4gIGludCBjbWRxX3BrdF93cml0ZV9tYXNr
KHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1OCBzdWJzeXMsDQo+ID4gIAkJCXUxNiBvZmZzZXQsIHUz
MiB2YWx1ZSwgdTMyIG1hc2spOw0KPiA+ICANCj4gPiArLyoqDQo+ID4gKyAqIGNtZHFfcGt0X3dy
aXRlX3MoKSAtIGFwcGVuZCB3cml0ZV9zIGNvbW1hbmQgdG8gdGhlIENNRFEgcGFja2V0DQo+ID4g
KyAqIEBwa3Q6CXRoZSBDTURRIHBhY2tldA0KPiA+ICsgKiBAaGlnaF9hZGRyX3JlZ19pZHg6CWlu
dGVybmFsIHJlZ2lzdGVyIElEIHdoaWNoIGNvbnRhaW5zIGhpZ2ggYWRkcmVzcyBvZiBwYQ0KPiA+
ICsgKiBAYWRkcl9sb3c6CWxvdyBhZGRyZXNzIG9mIHBhDQo+ID4gKyAqIEBzcmNfcmVnX2lkeDoJ
dGhlIENNRFEgaW50ZXJuYWwgcmVnaXN0ZXIgSUQgd2hpY2ggY2FjaGUgc291cmNlIHZhbHVlDQo+
ID4gKyAqIEBtYXNrOgl0aGUgc3BlY2lmaWVkIHRhcmdldCBhZGRyZXNzIG1hc2ssIHVzZSBVMzJf
TUFYIGlmIG5vIG5lZWQNCj4gPiArICoNCj4gPiArICogUmV0dXJuOiAwIGZvciBzdWNjZXNzOyBl
bHNlIHRoZSBlcnJvciBjb2RlIGlzIHJldHVybmVkDQo+ID4gKyAqDQo+ID4gKyAqIFN1cHBvcnQg
d3JpdGUgdmFsdWUgdG8gcGh5c2ljYWwgYWRkcmVzcyB3aXRob3V0IHN1YnN5cy4gVXNlIENNRFFf
QUREUl9ISUdIKCkNCj4gPiArICogdG8gZ2V0IGhpZ2ggYWRkcmVzcyBhbmQgY2FsbCBjbWRxX3Br
dF9hc3NpZ24oKSB0byBhc3NpZ24gdmFsdWUgaW50byBpbnRlcm5hbA0KPiA+ICsgKiByZWcuIEFs
c28gdXNlIENNRFFfQUREUl9MT1coKSB0byBnZXQgbG93IGFkZHJlc3MgZm9yIGFkZHJfbG93IHBh
cmFtZXRlciB3aGVuDQo+ID4gKyAqIGNhbGwgdG8gdGhpcyBmdW5jdGlvbi4NCj4gPiArICovDQo+
ID4gK2ludCBjbWRxX3BrdF93cml0ZV9zKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1MTYgaGlnaF9h
ZGRyX3JlZ19pZHgsDQo+ID4gKwkJICAgICB1MTYgYWRkcl9sb3csIHUxNiBzcmNfcmVnX2lkeCk7
DQo+ID4gKw0KPiA+ICAvKioNCj4gPiAgICogY21kcV9wa3Rfd2ZlKCkgLSBhcHBlbmQgd2FpdCBm
b3IgZXZlbnQgY29tbWFuZCB0byB0aGUgQ01EUSBwYWNrZXQNCj4gPiAgICogQHBrdDoJdGhlIENN
RFEgcGFja2V0DQo+ID4gDQoNCg==

