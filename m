Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 447C4C3F2C6
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 02:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C0DB2073B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 02:59:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="GwQ6SaJ2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387645AbgCDC7j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 21:59:39 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:47998 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387532AbgCDC7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 21:59:38 -0500
X-UUID: f2a679150a7f40e995fb03d8fe2b5cc1-20200304
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=Z1qeUZgtAaMPORZUPtFp+pNwtaKiDa0SS964FcwgJfA=;
        b=GwQ6SaJ2wI2zLVOyHdna+OCeQrRKOqVRo7nsEYEQmGgHNSpANp+n6Qr191kgiycEGrZNgjv4V33/E9MBvtgScY/PZA2KfLhoTnR8lOx8r8iFKUcSb2Abj5fhd8v2eX/g3ppaVHXk10l/V0VdLUzhWTQSfDKrKgcYg9/FxwD5asg=;
X-UUID: f2a679150a7f40e995fb03d8fe2b5cc1-20200304
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 666378015; Wed, 04 Mar 2020 10:59:30 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 4 Mar 2020 11:00:52 +0800
Received: from [172.21.77.4] (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 4 Mar 2020 10:56:57 +0800
Message-ID: <1583290769.1062.4.camel@mtksdaap41>
Subject: Re: [PATCH v4 02/13] mailbox: cmdq: variablize address shift in
 platform
From:   CK Hu <ck.hu@mediatek.com>
To:     Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
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
Date:   Wed, 4 Mar 2020 10:59:29 +0800
In-Reply-To: <1583289170.32049.1.camel@mtksdaap41>
References: <1583233125-7827-1-git-send-email-dennis-yc.hsieh@mediatek.com>
         <1583233125-7827-3-git-send-email-dennis-yc.hsieh@mediatek.com>
         <1583289170.32049.1.camel@mtksdaap41>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIERlbm5pczoNCg0KT24gV2VkLCAyMDIwLTAzLTA0IGF0IDEwOjMyICswODAwLCBDSyBIdSB3
cm90ZToNCj4gSGksIERlbm5pczoNCj4gDQo+IE9uIFR1ZSwgMjAyMC0wMy0wMyBhdCAxODo1OCAr
MDgwMCwgRGVubmlzIFlDIEhzaWVoIHdyb3RlOg0KPiA+IFNvbWUgZ2NlIGhhcmR3YXJlIHNoaWZ0
IHBjIGFuZCBlbmQgYWRkcmVzcyBpbiByZWdpc3RlciB0byBzdXBwb3J0DQo+ID4gbGFyZ2UgZHJh
bSBhZGRyZXNzaW5nLg0KPiA+IEltcGxlbWVudCBnY2UgYWRkcmVzcyBzaGlmdCB3aGVuIHdyaXRl
IG9yIHJlYWQgcGMgYW5kIGVuZCByZWdpc3Rlci4NCj4gPiBBbmQgYWRkIHNoaWZ0IGJpdCBpbiBw
bGF0Zm9ybSBkZWZpbml0aW9uLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IERlbm5pcyBZQyBI
c2llaCA8ZGVubmlzLXljLmhzaWVoQG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVy
cy9tYWlsYm94L210ay1jbWRxLW1haWxib3guYyAgICAgICB8IDYxICsrKysrKysrKysrKysrKysr
Ky0tLS0tLQ0KPiA+ICBkcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYyAgIHwg
IDMgKy0NCj4gPiAgaW5jbHVkZS9saW51eC9tYWlsYm94L210ay1jbWRxLW1haWxib3guaCB8ICAy
ICsNCj4gPiAgMyBmaWxlcyBjaGFuZ2VkLCA1MCBpbnNlcnRpb25zKCspLCAxNiBkZWxldGlvbnMo
LSkNCj4gPiANCj4gDQo+IFtzbmlwXQ0KPiANCj4gPiAgDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jIGIvZHJpdmVycy9zb2MvbWVkaWF0ZWsv
bXRrLWNtZHEtaGVscGVyLmMNCj4gPiBpbmRleCBkZTIwZTZjYmE4M2IuLjJlMWJjNTEzNTY5YiAx
MDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYw0K
PiA+ICsrKyBiL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jDQo+ID4gQEAg
LTI5MSw3ICsyOTEsOCBAQCBzdGF0aWMgaW50IGNtZHFfcGt0X2ZpbmFsaXplKHN0cnVjdCBjbWRx
X3BrdCAqcGt0KQ0KPiA+ICANCj4gPiAgCS8qIEpVTVAgdG8gZW5kICovDQo+ID4gIAlpbnN0Lm9w
ID0gQ01EUV9DT0RFX0pVTVA7DQo+ID4gLQlpbnN0LnZhbHVlID0gQ01EUV9KVU1QX1BBU1M7DQo+
ID4gKwlpbnN0LnZhbHVlID0gQ01EUV9KVU1QX1BBU1MgPj4NCj4gPiArCQljbWRxX21ib3hfc2hp
ZnQoKChzdHJ1Y3QgY21kcV9jbGllbnQgKilwa3QtPmNsKS0+Y2hhbik7DQo+IA0KPiBXaHkgbm90
IGp1c3QgY21kcV9tYm94X3NoaWZ0KHBrdC0+Y2wtPmNoYW4pID8NCg0KU29ycnksIHRoZSB0eXBl
IG9mIHBrdC0+Y2wgaXMgJ3ZvaWQgKicsIHNvIHlvdSBuZWVkIHRvIGNhc3QgaXQuDQoNClJldmll
d2VkLWJ5OiBDSyBIdSA8Y2suaHVAbWVkaWF0ZWsuY29tPg0KDQo+IA0KPiBSZWdhcmRzLA0KPiBD
Sw0KPiANCj4gPiAgCWVyciA9IGNtZHFfcGt0X2FwcGVuZF9jb21tYW5kKHBrdCwgaW5zdCk7DQo+
ID4gIA0KPiA+ICAJcmV0dXJuIGVycjsNCj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9t
YWlsYm94L210ay1jbWRxLW1haWxib3guaCBiL2luY2x1ZGUvbGludXgvbWFpbGJveC9tdGstY21k
cS1tYWlsYm94LmgNCj4gPiBpbmRleCBhNGRjNDVmYmVjMGEuLmRmZTViMmViODVjYyAxMDA2NDQN
Cj4gPiAtLS0gYS9pbmNsdWRlL2xpbnV4L21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5oDQo+ID4g
KysrIGIvaW5jbHVkZS9saW51eC9tYWlsYm94L210ay1jbWRxLW1haWxib3guaA0KPiA+IEBAIC04
OCw0ICs4OCw2IEBAIHN0cnVjdCBjbWRxX3BrdCB7DQo+ID4gIAl2b2lkCQkJKmNsOw0KPiA+ICB9
Ow0KPiA+ICANCj4gPiArdTggY21kcV9tYm94X3NoaWZ0KHN0cnVjdCBtYm94X2NoYW4gKmNoYW4p
Ow0KPiA+ICsNCj4gPiAgI2VuZGlmIC8qIF9fTVRLX0NNRFFfTUFJTEJPWF9IX18gKi8NCj4gDQoN
Cg==

