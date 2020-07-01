Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D8B3C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 09:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A0F320775
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 09:02:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="f2/xqBMk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729477AbgGAJCA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 05:02:00 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:60583 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729463AbgGAJBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 05:01:55 -0400
X-UUID: 2bb6ab3a34c54340a0ca1ece1198699e-20200701
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=cp0uXdfNJp8Bg/Ghio0s4ftUhM/JfzKVMysMp8sxB/8=;
        b=f2/xqBMk1N3YM89VXuPuezYAyapB/EXopcuyJHuxUwbt2lwXwUtsDRS4xR4aX31A8/SR3u54GEq6oB1LzorCROAV17sShAhcPY+jiTBtQXNTHJAeqq9dNFSEOan/jXdRukG41grqsMA2+akRv5ZZJbeALH2xW3zd4DbOw4zaRcY=;
X-UUID: 2bb6ab3a34c54340a0ca1ece1198699e-20200701
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <eastl.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1725838902; Wed, 01 Jul 2020 17:01:51 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 1 Jul 2020 17:01:47 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 1 Jul 2020 17:01:48 +0800
Message-ID: <1593594109.26931.2.camel@mtkswgap22>
Subject: Re: [PATCH v5 3/4] dmaengine: mediatek-cqdma: add dma mask for
 capability
From:   EastL <EastL.Lee@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     Sean Wang <sean.wang@mediatek.com>, <vkoul@kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>
Date:   Wed, 1 Jul 2020 17:01:49 +0800
In-Reply-To: <54703443-fb01-5aa2-089c-5c7616404b7a@gmail.com>
References: <1592553902-30592-1-git-send-email-EastL.Lee@mediatek.com>
         <1592553902-30592-4-git-send-email-EastL.Lee@mediatek.com>
         <54703443-fb01-5aa2-089c-5c7616404b7a@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIwLTA2LTE5IGF0IDExOjM5ICswMjAwLCBNYXR0aGlhcyBCcnVnZ2VyIHdyb3Rl
Og0KPiANCj4gT24gMTkvMDYvMjAyMCAxMDowNSwgRWFzdEwgd3JvdGU6DQo+ID4gVGhpcyBwYXRj
aCBhZGQgZG1hIG1hc2sgZm9yIGNhcGFiaWxpdHkuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTog
RWFzdEwgPEVhc3RMLkxlZUBtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvZG1h
L21lZGlhdGVrL210ay1jcWRtYS5jIHwgMTcgKysrKysrKysrKysrKysrKysNCj4gPiAgMSBmaWxl
IGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKykNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9kbWEvbWVkaWF0ZWsvbXRrLWNxZG1hLmMgYi9kcml2ZXJzL2RtYS9tZWRpYXRlay9tdGstY3Fk
bWEuYw0KPiA+IGluZGV4IDkwNWJiY2IuLmVkMzNjNjQgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVy
cy9kbWEvbWVkaWF0ZWsvbXRrLWNxZG1hLmMNCj4gPiArKysgYi9kcml2ZXJzL2RtYS9tZWRpYXRl
ay9tdGstY3FkbWEuYw0KPiA+IEBAIC0xMTcsNiArMTE3LDcgQEAgc3RydWN0IG10a19jcWRtYV92
Y2hhbiB7DQo+ID4gICAqIEBjbGs6ICAgICAgICAgICAgICAgICAgICBUaGUgY2xvY2sgdGhhdCBk
ZXZpY2UgaW50ZXJuYWwgaXMgdXNpbmcNCj4gPiAgICogQGRtYV9yZXF1ZXN0czogICAgICAgICAg
IFRoZSBudW1iZXIgb2YgVkNzIHRoZSBkZXZpY2Ugc3VwcG9ydHMgdG8NCj4gPiAgICogQGRtYV9j
aGFubmVsczogICAgICAgICAgIFRoZSBudW1iZXIgb2YgUENzIHRoZSBkZXZpY2Ugc3VwcG9ydHMg
dG8NCj4gPiArICogQGRtYV9tYXNrOiAgICAgICAgICAgICAgIEEgbWFzayBmb3IgRE1BIGNhcGFi
aWxpdHkNCj4gPiAgICogQHZjOiAgICAgICAgICAgICAgICAgICAgIFRoZSBwb2ludGVyIHRvIGFs
bCBhdmFpbGFibGUgVkNzDQo+ID4gICAqIEBwYzogICAgICAgICAgICAgICAgICAgICBUaGUgcG9p
bnRlciB0byBhbGwgdGhlIHVuZGVybHlpbmcgUENzDQo+ID4gICAqLw0KPiA+IEBAIC0xMjYsNiAr
MTI3LDcgQEAgc3RydWN0IG10a19jcWRtYV9kZXZpY2Ugew0KPiA+ICANCj4gPiAgCXUzMiBkbWFf
cmVxdWVzdHM7DQo+ID4gIAl1MzIgZG1hX2NoYW5uZWxzOw0KPiA+ICsJdTMyIGRtYV9tYXNrOw0K
PiA+ICAJc3RydWN0IG10a19jcWRtYV92Y2hhbiAqdmM7DQo+ID4gIAlzdHJ1Y3QgbXRrX2NxZG1h
X3BjaGFuICoqcGM7DQo+ID4gIH07DQo+ID4gQEAgLTYwNyw2ICs2MDksMjEgQEAgc3RhdGljIGlu
dCBtdGtfY3FkbWFfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gPiAgCQlj
cWRtYS0+ZG1hX2NoYW5uZWxzID0gTVRLX0NRRE1BX05SX1BDSEFOUzsNCj4gPiAgCX0NCj4gPiAg
DQo+ID4gKwlpZiAocGRldi0+ZGV2Lm9mX25vZGUpDQo+ID4gKwkJZXJyID0gb2ZfcHJvcGVydHlf
cmVhZF91MzIocGRldi0+ZGV2Lm9mX25vZGUsDQo+ID4gKwkJCQkJICAgImRtYS1jaGFubmVsLW1h
c2siLA0KPiA+ICsJCQkJCSAgICZjcWRtYS0+ZG1hX21hc2spOw0KPiA+ICsJaWYgKGVycikgew0K
PiA+ICsJCWRldl93YXJuKCZwZGV2LT5kZXYsDQo+ID4gKwkJCSAiVXNpbmcgMCBhcyBtaXNzaW5n
IGRtYS1jaGFubmVsLW1hc2sgcHJvcGVydHlcbiIpOw0KPiA+ICsJCWNxZG1hLT5kbWFfbWFzayA9
IDA7DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJaWYgKGRtYV9zZXRfbWFzaygmcGRldi0+ZGV2LCBE
TUFfQklUX01BU0soY3FkbWEtPmRtYV9tYXNrKSkpIHsNCj4gPiArCQlkZXZfd2FybigmcGRldi0+
ZGV2LCAiRE1BIHNldCBtYXNrIGZhaWxcbiIpOw0KPiANCj4gZmFpbCAtPiBmYWlsZWQNCj4gDQo+
IFdpdGggdGhpczoNCj4gUmV2aWV3ZWQtYnk6IE1hdHRoaWFzIEJydWdnZXIgPG1hdHRoaWFzLmJn
Z0BnbWFpbC5jb20+DQoNCk9LLg0KPiANCj4gPiArCQlyZXR1cm4gLUVJTlZBTDsNCj4gPiArCX0N
Cj4gPiArDQo+ID4gIAljcWRtYS0+cGMgPSBkZXZtX2tjYWxsb2MoJnBkZXYtPmRldiwgY3FkbWEt
PmRtYV9jaGFubmVscywNCj4gPiAgCQkJCSBzaXplb2YoKmNxZG1hLT5wYyksIEdGUF9LRVJORUwp
Ow0KPiA+ICAJaWYgKCFjcWRtYS0+cGMpDQo+ID4gDQoNCg==

