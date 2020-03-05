Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71544C3F2CE
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 00:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A4022084E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 00:49:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Xwj1loR4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725877AbgCEAtN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 19:49:13 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:36531 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725797AbgCEAtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 19:49:12 -0500
X-UUID: 6a35557ffad6498e860e9d885c29fc43-20200305
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=Dt+NjDKJnvFkl8R5AeUjlcgnglhu+f9HBOgNSX0bmEE=;
        b=Xwj1loR4Nq+7Sw402bvRcCWVaxghwi193wHlRv+MIMIqTepRD0jaBRlF5spKuX1dfN/9eybs2Zq1+/B4xrizQ6FY0O+OqjuwxoBPWbgk3EMfUjbqM6NwzD1MNP/FICR1hPoVYC3lWMFV5jWpTsupB8G/AUN03rZz6F2+wxLuV70=;
X-UUID: 6a35557ffad6498e860e9d885c29fc43-20200305
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1851158184; Thu, 05 Mar 2020 08:49:04 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 5 Mar 2020 08:47:54 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 5 Mar 2020 08:48:18 +0800
Message-ID: <1583369342.28558.0.camel@mtkswgap22>
Subject: Re: [PATCH v4 11/13] soc: mediatek: cmdq: add jump function
From:   Dennis-YC Hsieh <dennis-yc.hsieh@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "David Airlie" <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>, <dri-devel@lists.freedesktop.org>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        HS Liao <hs.liao@mediatek.com>
Date:   Thu, 5 Mar 2020 08:49:02 +0800
In-Reply-To: <1583290652.1062.2.camel@mtksdaap41>
References: <1583233125-7827-1-git-send-email-dennis-yc.hsieh@mediatek.com>
         <1583233125-7827-12-git-send-email-dennis-yc.hsieh@mediatek.com>
         <1583290652.1062.2.camel@mtksdaap41>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ0ssDQoNClRoYW5rcyBmb3IgeW91ciBjb21tZW50Lg0KDQpPbiBXZWQsIDIwMjAtMDMtMDQg
YXQgMTA6NTcgKzA4MDAsIENLIEh1IHdyb3RlOg0KPiBIaSwgRGVubmlzOg0KPiANCj4gT24gVHVl
LCAyMDIwLTAzLTAzIGF0IDE4OjU4ICswODAwLCBEZW5uaXMgWUMgSHNpZWggd3JvdGU6DQo+ID4g
QWRkIGp1bXAgZnVuY3Rpb24gc28gdGhhdCBjbGllbnQgY2FuIGp1bXAgdG8gYW55IGFkZHJlc3Mg
d2hpY2gNCj4gPiBjb250YWlucyBpbnN0cnVjdGlvbi4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5
OiBEZW5uaXMgWUMgSHNpZWggPGRlbm5pcy15Yy5oc2llaEBtZWRpYXRlay5jb20+DQo+ID4gLS0t
DQo+ID4gIGRyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jIHwgMTIgKysrKysr
KysrKysrDQo+ID4gIGluY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmggIHwgMTEg
KysrKysrKysrKysNCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCAyMyBpbnNlcnRpb25zKCspDQo+ID4g
DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5j
IGIvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMNCj4gPiBpbmRleCA1OWJj
MTE2NGI0MTEuLmYyN2M2NzAzNDg4MCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3NvYy9tZWRp
YXRlay9tdGstY21kcS1oZWxwZXIuYw0KPiA+ICsrKyBiL2RyaXZlcnMvc29jL21lZGlhdGVrL210
ay1jbWRxLWhlbHBlci5jDQo+ID4gQEAgLTM3Miw2ICszNzIsMTggQEAgaW50IGNtZHFfcGt0X2Fz
c2lnbihzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgdTE2IHJlZ19pZHgsIHUzMiB2YWx1ZSkNCj4gPiAg
fQ0KPiA+ICBFWFBPUlRfU1lNQk9MKGNtZHFfcGt0X2Fzc2lnbik7DQo+ID4gIA0KPiA+ICtpbnQg
Y21kcV9wa3RfanVtcChzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgZG1hX2FkZHJfdCBhZGRyKQ0KPiA+
ICt7DQo+ID4gKwlzdHJ1Y3QgY21kcV9pbnN0cnVjdGlvbiBpbnN0ID0geyB7MH0gfTsNCj4gPiAr
DQo+ID4gKwlpbnN0Lm9wID0gQ01EUV9DT0RFX0pVTVA7DQo+ID4gKwlpbnN0Lm9mZnNldCA9IDE7
DQo+IA0KPiBTeW1ib2xpemUgdGhlIHZhbHVlICcxJy4NCg0KbWlzcyBpbiB2NCwgd2lsbCBhZGQg
aW4gbmV4dCB2ZXJzaW9uLCB0aGFua3MuDQoNCg0KUmVnYXJkcywNCkRlbm5pcw0KDQoNCj4gDQo+
IFJlZ2FyZHMsDQo+IENLDQo+IA0KPiA+ICsJaW5zdC52YWx1ZSA9IGFkZHIgPj4NCj4gPiArCQlj
bWRxX21ib3hfc2hpZnQoKChzdHJ1Y3QgY21kcV9jbGllbnQgKilwa3QtPmNsKS0+Y2hhbik7DQo+
ID4gKwlyZXR1cm4gY21kcV9wa3RfYXBwZW5kX2NvbW1hbmQocGt0LCBpbnN0KTsNCj4gPiArfQ0K
PiA+ICtFWFBPUlRfU1lNQk9MKGNtZHFfcGt0X2p1bXApOw0KPiA+ICsNCj4gPiAgaW50IGNtZHFf
cGt0X2ZpbmFsaXplKHN0cnVjdCBjbWRxX3BrdCAqcGt0KQ0KPiA+ICB7DQo+ID4gIAlzdHJ1Y3Qg
Y21kcV9pbnN0cnVjdGlvbiBpbnN0ID0geyB7MH0gfTsNCj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVk
ZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaCBiL2luY2x1ZGUvbGludXgvc29jL21lZGlh
dGVrL210ay1jbWRxLmgNCj4gPiBpbmRleCA5OWU3NzE1NWY5NjcuLjFhNmM1NmYzYmVjMSAxMDA2
NDQNCj4gPiAtLS0gYS9pbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5oDQo+ID4g
KysrIGIvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaA0KPiA+IEBAIC0yMTMs
NiArMjEzLDE3IEBAIGludCBjbWRxX3BrdF9wb2xsX21hc2soc3RydWN0IGNtZHFfcGt0ICpwa3Qs
IHU4IHN1YnN5cywNCj4gPiAgICovDQo+ID4gIGludCBjbWRxX3BrdF9hc3NpZ24oc3RydWN0IGNt
ZHFfcGt0ICpwa3QsIHUxNiByZWdfaWR4LCB1MzIgdmFsdWUpOw0KPiA+ICANCj4gPiArLyoqDQo+
ID4gKyAqIGNtZHFfcGt0X2p1bXAoKSAtIEFwcGVuZCBqdW1wIGNvbW1hbmQgdG8gdGhlIENNRFEg
cGFja2V0LCBhc2sgR0NFDQo+ID4gKyAqCQkgICAgIHRvIGV4ZWN1dGUgYW4gaW5zdHJ1Y3Rpb24g
dGhhdCBjaGFuZ2UgY3VycmVudCB0aHJlYWQgUEMgdG8NCj4gPiArICoJCSAgICAgYSBwaHlzaWNh
bCBhZGRyZXNzIHdoaWNoIHNob3VsZCBjb250YWlucyBtb3JlIGluc3RydWN0aW9uLg0KPiA+ICsg
KiBAcGt0OiAgICAgICAgdGhlIENNRFEgcGFja2V0DQo+ID4gKyAqIEBhZGRyOiAgICAgICBwaHlz
aWNhbCBhZGRyZXNzIG9mIHRhcmdldCBpbnN0cnVjdGlvbiBidWZmZXINCj4gPiArICoNCj4gPiAr
ICogUmV0dXJuOiAwIGZvciBzdWNjZXNzOyBlbHNlIHRoZSBlcnJvciBjb2RlIGlzIHJldHVybmVk
DQo+ID4gKyAqLw0KPiA+ICtpbnQgY21kcV9wa3RfanVtcChzdHJ1Y3QgY21kcV9wa3QgKnBrdCwg
ZG1hX2FkZHJfdCBhZGRyKTsNCj4gPiArDQo+ID4gIC8qKg0KPiA+ICAgKiBjbWRxX3BrdF9maW5h
bGl6ZSgpIC0gQXBwZW5kIEVPQyBhbmQganVtcCBjb21tYW5kIHRvIHBrdC4NCj4gPiAgICogQHBr
dDoJdGhlIENNRFEgcGFja2V0DQo+IA0KPiANCg0K

