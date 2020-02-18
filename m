Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC0BC34034
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 08:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4E5E206E2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 08:22:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="mVf66q9c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbgBRIWs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 03:22:48 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:13844 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726105AbgBRIWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 03:22:48 -0500
X-UUID: 3923b5bdecd74763b460bd7dc9a86b7f-20200218
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=SfaeYyzD1vskIHsIX3CHP6DvU8UKTsX3PGwgpB+tsvc=;
        b=mVf66q9caClDpvIVT7XpzG1PZLpTugIeklyrENikbbWCe88V8ZUSqYDnJ/FM65a8FTiEeBSkR4or2kQYIVUXA+Prp5pf4UZPj7CbYIdGy8MadR+o1djiyBN+N9gIAQDtxnqjhBb3VHIf4ziOQuT7HbYR114CQcRJ+LxH/ntw9y8=;
X-UUID: 3923b5bdecd74763b460bd7dc9a86b7f-20200218
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 369555937; Tue, 18 Feb 2020 16:22:43 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 18 Feb 2020 16:22:07 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 18 Feb 2020 16:22:24 +0800
Message-ID: <1582014162.20566.2.camel@mtksdaap41>
Subject: Re: [PATCH 2/3] drm/mediatek: make sure previous message done or be
 aborted before send
From:   CK Hu <ck.hu@mediatek.com>
To:     Bibby Hsieh <bibby.hsieh@mediatek.com>
CC:     David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        YT Shen <yt.shen@mediatek.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>, <tfiga@chromium.org>,
        <drinkcat@chromium.org>, <linux-kernel@vger.kernel.org>,
        <srv_heupstream@mediatek.com>
Date:   Tue, 18 Feb 2020 16:22:42 +0800
In-Reply-To: <1581662912.17949.4.camel@mtksdaap41>
References: <20200214044954.16923-1-bibby.hsieh@mediatek.com>
         <20200214044954.16923-2-bibby.hsieh@mediatek.com>
         <1581662912.17949.4.camel@mtksdaap41>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 971137264DABD4948DC8DF38BF36DD743309BA80C941579AAD6973CA1A1390162000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEJpYmJ5Og0KDQpPbiBGcmksIDIwMjAtMDItMTQgYXQgMTQ6NDggKzA4MDAsIENLIEh1IHdy
b3RlOg0KPiBIaSwgQmliYnk6DQo+IA0KPiBPbiBGcmksIDIwMjAtMDItMTQgYXQgMTI6NDkgKzA4
MDAsIEJpYmJ5IEhzaWVoIHdyb3RlOg0KPiA+IE1lZGlhdGVrIENNRFEgZHJpdmVyIHJlbW92ZWQg
YXRvbWljIHBhcmFtZXRlciBhbmQgaW1wbGVtZW50YXRpb24NCj4gPiByZWxhdGVkIHRvIGF0b21p
Yy4gRFJNIGRyaXZlciBuZWVkIHRvIG1ha2Ugc3VyZSBwcmV2aW91cyBtZXNzYWdlDQo+ID4gZG9u
ZSBvciBiZSBhYm9ydGVkIGJlZm9yZSB3ZSBzZW5kIG5leHQgbWVzc2FnZS4NCj4gPiANCj4gPiBJ
ZiBwcmV2aW91cyBtZXNzYWdlIGlzIHN0aWxsIHdhaXRpbmcgZm9yIGV2ZW50LCBpdCBtZWFucyB0
aGUNCj4gPiBzZXR0aW5nIGhhc24ndCBiZWVuIHVwZGF0ZWQgaW50byBkaXNwbGF5IGhhcmR3YXJl
IHJlZ2lzdGVyLA0KPiA+IHdlIGNhbiBhYm9ydCB0aGUgbWVzc2FnZSBhbmQgc2VuZCBuZXh0IG1l
c3NhZ2UgdG8gdXBkYXRlIHRoZQ0KPiA+IG5ld2VzdCBzZXR0aW5nIGludG8gZGlzcGxheSBoYXJk
d2FyZS4NCj4gPiBJZiBwcmV2aW91cyBtZXNzYWdlIGFscmVhZHkgc3RhcnRlZCwgd2UgaGF2ZSB0
byB3YWl0IGl0IHVudGlsDQo+ID4gdHJhbnNtaXNzaW9uIGhhcyBiZWVuIGNvbXBsZXRlZC4NCj4g
PiANCj4gPiBTbyB3ZSBmbHVzaCBtYm94IGNsaWVudCBiZWZvcmUgd2Ugc2VuZCBuZXcgbWVzc2Fn
ZSB0byBjb250cm9sbGVyDQo+ID4gZHJpdmVyLg0KPiA+IA0KPiANCj4gUmV2aWV3ZWQtYnk6IENL
IEh1IDxjay5odUBtZWRpYXRlay5jb20+DQo+IA0KPiA+IFRoaXMgcGF0Y2ggZGVwZW5kcyBvbiBw
dGFjaDoNCj4gPiBbMC8zXSBSZW1vdmUgYXRvbWljX2V4ZWMNCj4gPiBodHRwczovL3BhdGNod29y
ay5rZXJuZWwub3JnL2NvdmVyLzExMzgxNjc3Lw0KPiA+IA0KDQpUaGlzIHBhdGNoIGRvZXMgbm90
IGRlcGVuZCBvbiBhbnkgcGF0Y2gsIHNvIGFwcGxpZWQgdG8NCm1lZGlhdGVrLWRybS1maXhlcy01
LjYgWzFdLCB0aGFua3MuDQoNClsxXQ0KaHR0cHM6Ly9naXRodWIuY29tL2NraHUtbWVkaWF0ZWsv
bGludXguZ2l0LXRhZ3MvY29tbWl0cy9tZWRpYXRlay1kcm0tZml4ZXMtNS42DQoNClJlZ2FyZHMs
DQpDSw0KDQo+ID4gU2lnbmVkLW9mZi1ieTogQmliYnkgSHNpZWggPGJpYmJ5LmhzaWVoQG1lZGlh
dGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1f
Y3J0Yy5jIHwgMSArDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPiA+IA0K
PiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRjLmMg
Yi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRjLmMNCj4gPiBpbmRleCAzYzUz
ZWEyMjIwOGMuLmUzNWI2NmM1YmEwZiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0v
bWVkaWF0ZWsvbXRrX2RybV9jcnRjLmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0
ZWsvbXRrX2RybV9jcnRjLmMNCj4gPiBAQCAtNDkxLDYgKzQ5MSw3IEBAIHN0YXRpYyB2b2lkIG10
a19kcm1fY3J0Y19od19jb25maWcoc3RydWN0IG10a19kcm1fY3J0YyAqbXRrX2NydGMpDQo+ID4g
IAl9DQo+ID4gICNpZiBJU19FTkFCTEVEKENPTkZJR19NVEtfQ01EUSkNCj4gPiAgCWlmIChtdGtf
Y3J0Yy0+Y21kcV9jbGllbnQpIHsNCj4gPiArCQltYm94X2ZsdXNoKG10a19jcnRjLT5jbWRxX2Ns
aWVudC0+Y2hhbiwgMjAwMCk7DQo+ID4gIAkJY21kcV9oYW5kbGUgPSBjbWRxX3BrdF9jcmVhdGUo
bXRrX2NydGMtPmNtZHFfY2xpZW50LCBQQUdFX1NJWkUpOw0KPiA+ICAJCWNtZHFfcGt0X2NsZWFy
X2V2ZW50KGNtZHFfaGFuZGxlLCBtdGtfY3J0Yy0+Y21kcV9ldmVudCk7DQo+ID4gIAkJY21kcV9w
a3Rfd2ZlKGNtZHFfaGFuZGxlLCBtdGtfY3J0Yy0+Y21kcV9ldmVudCk7DQo+IA0KDQo=

