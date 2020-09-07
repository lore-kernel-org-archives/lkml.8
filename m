Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F816C433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 03:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18DEC20757
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 03:46:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="P9EOq1ce"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbgIGDqB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Sep 2020 23:46:01 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:22518 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726871AbgIGDp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 23:45:56 -0400
X-UUID: fc2d7b33f73a41f7a03f428ee60e33c2-20200907
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=mMKGJq1Irdy84Dk7/453p0dQlCzRanBPVBBNedi1E24=;
        b=P9EOq1ceoJ6v6yA29aGdcKM3W63uv5PYkiygfYBy6w9vVkxgGtbU+Mpeh8KIpuPKOy/ArbN13XNJxxAfNrrbDzjJf6pwFpt9h0n2n/r7fjCldYbt1rqud1RgU5/O/uTbKENeJKSt4p24R7F2Zgcm6xJRw3837t+QCkR9ssmhWcA=;
X-UUID: fc2d7b33f73a41f7a03f428ee60e33c2-20200907
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1169113425; Mon, 07 Sep 2020 11:45:51 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by mtkmbs08n2.mediatek.inc
 (172.21.101.56) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 7 Sep
 2020 11:45:40 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 7 Sep 2020 11:45:39 +0800
Message-ID: <1599450232.27773.13.camel@mhfsdcap03>
Subject: Re: [PATCH v3 3/3] iommu/mediatek: add support for MT8167
From:   Yong Wu <yong.wu@mediatek.com>
To:     Fabien Parent <fparent@baylibre.com>
CC:     <iommu@lists.linux-foundation.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <joro@8bytes.org>,
        <robh+dt@kernel.org>, <matthias.bgg@gmail.com>,
        <miles.chen@mediatek.com>
Date:   Mon, 7 Sep 2020 11:43:52 +0800
In-Reply-To: <20200906151928.881209-3-fparent@baylibre.com>
References: <20200906151928.881209-1-fparent@baylibre.com>
         <20200906151928.881209-3-fparent@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 508C82F0F2088845E7C370D4AA3DA4F89501BFD7F85F229D412844D957F046852000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU3VuLCAyMDIwLTA5LTA2IGF0IDE3OjE5ICswMjAwLCBGYWJpZW4gUGFyZW50IHdyb3RlOg0K
PiBBZGQgc3VwcG9ydCBmb3IgdGhlIElPTU1VIG9uIE1UODE2Nw0KPiANCj4gU2lnbmVkLW9mZi1i
eTogRmFiaWVuIFBhcmVudCA8ZnBhcmVudEBiYXlsaWJyZS5jb20+DQo+IC0tLQ0KPiANCj4gVjM6
DQo+IAkqIHVzZSBMRUdBQ1lfSVZSUF9QQUREUiBmbGFnIGluc3RlYWQgb2YgdXNpbmcgYSBwbGF0
Zm9ybSBkYXRhIG1lbWJlcg0KPiBWMjoNCj4gCSogcmVtb3ZlZCBpZiBiYXNlZCBvbiBtNHVfcGxh
dCwgYW5kIHVzaW5nIGluc3RlYWQgdGhlIG5ldw0KPiAJICBoYXNfbGVnYWN5X2l2cnBfcGFkZHIg
bWVtYmVyIHRoYXQgd2FzIGludHJvZHVjZWQgaW4gcGF0Y2ggMi4NCj4gDQo+IC0tLQ0KPiAgZHJp
dmVycy9pb21tdS9tdGtfaW9tbXUuYyB8IDggKysrKysrKysNCj4gIGRyaXZlcnMvaW9tbXUvbXRr
X2lvbW11LmggfCAxICsNCj4gIDIgZmlsZXMgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYyBiL2RyaXZlcnMvaW9tbXUv
bXRrX2lvbW11LmMNCj4gaW5kZXggYjFmODVhN2U5MzQ2Li42MDc5ZjZhMjNjNzQgMTAwNjQ0DQo+
IC0tLSBhL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMNCj4gKysrIGIvZHJpdmVycy9pb21tdS9t
dGtfaW9tbXUuYw0KPiBAQCAtODE3LDYgKzgxNywxMyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG10
a19pb21tdV9wbGF0X2RhdGEgbXQ2Nzc5X2RhdGEgPSB7DQo+ICAJLmxhcmJpZF9yZW1hcCAgPSB7
ezB9LCB7MX0sIHsyfSwgezN9LCB7NX0sIHs3LCA4fSwgezEwfSwgezl9fSwNCj4gIH07DQo+ICAN
Cj4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2lvbW11X3BsYXRfZGF0YSBtdDgxNjdfZGF0YSA9
IHsNCj4gKwkubTR1X3BsYXQgICAgID0gTTRVX01UODE2NywNCj4gKwkuZmxhZ3MgICAgICAgID0g
SEFTXzRHQl9NT0RFIHwgUkVTRVRfQVhJIHwgSEFTX0xFR0FDWV9JVlJQX1BBRERSLA0KDQpUaGUg
NEdCIG1vZGUgZmxvdyB3YXMgaW1wcm92ZWQgYXRbMV0gd2hpY2ggaGFzIGp1c3QgYmVlbiBhcHBs
aWVkLg0KDQpJZiB5b3UgYWRkIDRnYl9tb2RlIGZsYWcgYnV0IGRvbid0IGhhdmUgIm10ODE2Ny1p
bmZyYWNmZyIsIHRoZSBwcm9iZSBtYXkNCmJlIGZhaWxlZC4NCg0KWzFdDQpodHRwczovL2xvcmUu
a2VybmVsLm9yZy9saW51eC1pb21tdS8yMDIwMDkwNDExMjExNy5HQzE2NjA5QDhieXRlcy5vcmcv
VC8jbTYxM2U5OTI2NzM1ZDA3YWQwMDRmZGRiYmNlZGFhNTBiNWFmYWNjYTENCg0KDQo+ICsJLmlu
dl9zZWxfcmVnICA9IFJFR19NTVVfSU5WX1NFTF9HRU4xLA0KPiArCS5sYXJiaWRfcmVtYXAgPSB7
ezB9LCB7MX0sIHsyfX0sIC8qIExpbmVhciBtYXBwaW5nLiAqLw0KPiArfTsNCj4gKw0KPiAgc3Rh
dGljIGNvbnN0IHN0cnVjdCBtdGtfaW9tbXVfcGxhdF9kYXRhIG10ODE3M19kYXRhID0gew0KPiAg
CS5tNHVfcGxhdCAgICAgPSBNNFVfTVQ4MTczLA0KPiAgCS5mbGFncwkgICAgICA9IEhBU180R0Jf
TU9ERSB8IEhBU19CQ0xLIHwgUkVTRVRfQVhJIHwNCj4gQEAgLTgzNSw2ICs4NDIsNyBAQCBzdGF0
aWMgY29uc3Qgc3RydWN0IG10a19pb21tdV9wbGF0X2RhdGEgbXQ4MTgzX2RhdGEgPSB7DQo+ICBz
dGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBtdGtfaW9tbXVfb2ZfaWRzW10gPSB7DQo+
ICAJeyAuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDI3MTItbTR1IiwgLmRhdGEgPSAmbXQyNzEy
X2RhdGF9LA0KPiAgCXsgLmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ2Nzc5LW00dSIsIC5kYXRh
ID0gJm10Njc3OV9kYXRhfSwNCj4gKwl7IC5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE2Ny1t
NHUiLCAuZGF0YSA9ICZtdDgxNjdfZGF0YX0sDQo+ICAJeyAuY29tcGF0aWJsZSA9ICJtZWRpYXRl
ayxtdDgxNzMtbTR1IiwgLmRhdGEgPSAmbXQ4MTczX2RhdGF9LA0KPiAgCXsgLmNvbXBhdGlibGUg
PSAibWVkaWF0ZWssbXQ4MTgzLW00dSIsIC5kYXRhID0gJm10ODE4M19kYXRhfSwNCj4gIAl7fQ0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuaCBiL2RyaXZlcnMvaW9tbXUv
bXRrX2lvbW11LmgNCj4gaW5kZXggMTIyOTI1ZGJlNTQ3Li5kZjMyYjNlMzQwOGIgMTAwNjQ0DQo+
IC0tLSBhL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmgNCj4gKysrIGIvZHJpdmVycy9pb21tdS9t
dGtfaW9tbXUuaA0KPiBAQCAtMzksNiArMzksNyBAQCBlbnVtIG10a19pb21tdV9wbGF0IHsNCj4g
IAlNNFVfTVQyNzAxLA0KPiAgCU00VV9NVDI3MTIsDQo+ICAJTTRVX01UNjc3OSwNCj4gKwlNNFVf
TVQ4MTY3LA0KPiAgCU00VV9NVDgxNzMsDQo+ICAJTTRVX01UODE4MywNCj4gIH07DQoNCg==

