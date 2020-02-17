Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5121EC7619F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 11:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29B0620836
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 11:35:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="PxgkLckJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728531AbgBQLf0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 06:35:26 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:29078 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728312AbgBQLfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 06:35:25 -0500
X-UUID: 3d255e9f271344ebb1ffecef37e7560d-20200217
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=eP5l76kC+wYQ1SgKc3IwEHH0X8lfLQiaEbwRojJdv0w=;
        b=PxgkLckJECq3POl9lr7b11FiX6J7VBJhpW9lzfhfyaeC8bClzLDomAHJJNbS0AGFXgqS3lT7bRVr/0XoIUCMxYVG6uTnEwRgFURys9PNNNS1h0ZfwzfIKjaNCvsn6+sMuCkpOKLdJdA5NuyTsBr1JQgK52yKnRv5goDgA1i82tY=;
X-UUID: 3d255e9f271344ebb1ffecef37e7560d-20200217
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 2131103376; Mon, 17 Feb 2020 19:35:20 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by mtkmbs05n1.mediatek.inc
 (172.21.101.15) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 17 Feb
 2020 19:34:24 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 17 Feb 2020 19:35:55 +0800
Message-ID: <1581939298.4784.12.camel@mhfsdcap03>
Subject: Re: [PATCH 2/2] iommu/mediatek: add support for MT8167
From:   Yong Wu <yong.wu@mediatek.com>
To:     Fabien Parent <fparent@baylibre.com>
CC:     <iommu@lists.linux-foundation.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <mark.rutland@arm.com>,
        <matthias.bgg@gmail.com>, <joro@8bytes.org>, <robh+dt@kernel.org>,
        CK Hu <ck.hu@mediatek.com>
Date:   Mon, 17 Feb 2020 19:34:58 +0800
In-Reply-To: <1581902146.28283.0.camel@mtksdaap41>
References: <20200103162632.109553-1-fparent@baylibre.com>
         <20200103162632.109553-2-fparent@baylibre.com>
         <1581902146.28283.0.camel@mtksdaap41>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRmFiaWVuLA0KDQpUaGFua3MgdmVyeSBtdWNoIGZvciB5b3VyIHBhdGNoLg0KDQpPbiBNb24s
IDIwMjAtMDItMTcgYXQgMDk6MTUgKzA4MDAsIENLIEh1IHdyb3RlOg0KPiArWW9uZy5XdS4NCj4g
DQo+IE9uIEZyaSwgMjAyMC0wMS0wMyBhdCAxNzoyNiArMDEwMCwgRmFiaWVuIFBhcmVudCB3cm90
ZToNCj4gPiBBZGQgc3VwcG9ydCBmb3IgdGhlIElPTU1VIG9uIE1UODE2Nw0KPiA+IA0KPiA+IFNp
Z25lZC1vZmYtYnk6IEZhYmllbiBQYXJlbnQgPGZwYXJlbnRAYmF5bGlicmUuY29tPg0KPiA+IC0t
LQ0KPiA+ICBkcml2ZXJzL2lvbW11L210a19pb21tdS5jIHwgMTEgKysrKysrKysrKy0NCj4gPiAg
ZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuaCB8ICAxICsNCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCAx
MSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvaW9tbXUvbXRrX2lvbW11LmMgYi9kcml2ZXJzL2lvbW11L210a19pb21tdS5jDQo+ID4g
aW5kZXggNmZjMWY1ZWNmOTFlLi41ZmM2MTc4YTgyZGMgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVy
cy9pb21tdS9tdGtfaW9tbXUuYw0KPiA+ICsrKyBiL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMN
Cj4gPiBAQCAtNTY5LDcgKzU2OSw4IEBAIHN0YXRpYyBpbnQgbXRrX2lvbW11X2h3X2luaXQoY29u
c3Qgc3RydWN0IG10a19pb21tdV9kYXRhICpkYXRhKQ0KPiA+ICAJCUZfSU5UX1BSRVRFVENIX1RS
QU5TQVRJT05fRklGT19GQVVMVDsNCj4gPiAgCXdyaXRlbF9yZWxheGVkKHJlZ3ZhbCwgZGF0YS0+
YmFzZSArIFJFR19NTVVfSU5UX01BSU5fQ09OVFJPTCk7DQo+ID4gIA0KPiA+IC0JaWYgKGRhdGEt
PnBsYXRfZGF0YS0+bTR1X3BsYXQgPT0gTTRVX01UODE3MykNCj4gPiArCWlmIChkYXRhLT5wbGF0
X2RhdGEtPm00dV9wbGF0ID09IE00VV9NVDgxNzMgfHwNCj4gPiArCSAgICBkYXRhLT5wbGF0X2Rh
dGEtPm00dV9wbGF0ID09IE00VV9NVDgxNjcpDQoNCkkgZGlkbid0IGtub3cgbXQ4MTY3IHdpbGwg
ZG8gdXBzdHJlYW0uIEluIG15IG9yaWdpbmFsIHRob3VnaHQsIHRoZXJlIGlzDQpvbmx5IG10ODE3
MyB1c2UgdGhpcyBzZXR0aW5nIGFuZCB0aGUgbGF0ZXIgU29DIHdvbid0IHVzZSB0aGlzLCBTbyBJ
IHVzZWQNCnRoZSAibTR1X3BsYXQiIGRpcmVjdGx5IGhlcmUuDQoNCklmIHdlIGFsc28gbmVlZCBz
dXBwb3J0IG10ODE2NywgdGhlbiBDSydzIHN1Z2dlc3Rpb24gaXMgcmVhc29uYWJsZS4gd2UNCmNv
dWxkIGFkZCBhIG5ldyB2YXJpYWJsZSBsaWtlICJsZWdhY3lfaXZycF9wYWRkciIgZnJvbSBpdHMg
cmVnaXN0ZXIgbmFtZQ0KaW4gYSBzZXBlcmF0ZWQgcGF0Y2gsIHRoZW4gc3VwcG9ydCBtdDgxNjcg
aW4gYSBuZXcgcGF0Y2guDQoNCj4gPiAgCQlyZWd2YWwgPSAoZGF0YS0+cHJvdGVjdF9iYXNlID4+
IDEpIHwgKGRhdGEtPmVuYWJsZV80R0IgPDwgMzEpOw0KPiA+ICAJZWxzZQ0KPiA+ICAJCXJlZ3Zh
bCA9IGxvd2VyXzMyX2JpdHMoZGF0YS0+cHJvdGVjdF9iYXNlKSB8DQo+ID4gQEAgLTc4Miw2ICs3
ODMsMTMgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfaW9tbXVfcGxhdF9kYXRhIG10MjcxMl9k
YXRhID0gew0KPiA+ICAJLmxhcmJpZF9yZW1hcCA9IHswLCAxLCAyLCAzLCA0LCA1LCA2LCA3LCA4
LCA5fSwNCj4gPiAgfTsNCj4gPiAgDQo+ID4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2lvbW11
X3BsYXRfZGF0YSBtdDgxNjdfZGF0YSA9IHsNCj4gPiArCS5tNHVfcGxhdCAgICAgPSBNNFVfTVQ4
MTY3LA0KPiA+ICsJLmhhc180Z2JfbW9kZSA9IHRydWUsDQo+ID4gKwkucmVzZXRfYXhpICAgID0g
dHJ1ZSwNCj4gPiArCS5sYXJiaWRfcmVtYXAgPSB7MCwgMSwgMiwgMywgNCwgNX0sIC8qIExpbmVh
ciBtYXBwaW5nLiAqLw0KPiA+ICt9Ow0KPiA+ICsNCj4gPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBt
dGtfaW9tbXVfcGxhdF9kYXRhIG10ODE3M19kYXRhID0gew0KPiA+ICAJLm00dV9wbGF0ICAgICA9
IE00VV9NVDgxNzMsDQo+ID4gIAkuaGFzXzRnYl9tb2RlID0gdHJ1ZSwNCj4gPiBAQCAtNzk4LDYg
KzgwNiw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2lvbW11X3BsYXRfZGF0YSBtdDgxODNf
ZGF0YSA9IHsNCj4gPiAgDQo+ID4gIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIG10
a19pb21tdV9vZl9pZHNbXSA9IHsNCj4gPiAgCXsgLmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQy
NzEyLW00dSIsIC5kYXRhID0gJm10MjcxMl9kYXRhfSwNCj4gPiArCXsgLmNvbXBhdGlibGUgPSAi
bWVkaWF0ZWssbXQ4MTY3LW00dSIsIC5kYXRhID0gJm10ODE2N19kYXRhfSwNCj4gPiAgCXsgLmNv
bXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTczLW00dSIsIC5kYXRhID0gJm10ODE3M19kYXRhfSwN
Cj4gPiAgCXsgLmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTgzLW00dSIsIC5kYXRhID0gJm10
ODE4M19kYXRhfSwNCj4gPiAgCXt9DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvbXRr
X2lvbW11LmggYi9kcml2ZXJzL2lvbW11L210a19pb21tdS5oDQo+ID4gaW5kZXggZWE5NDlhMzI0
ZTMzLi5jYjhmZDU5NzBjZDQgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9pb21tdS9tdGtfaW9t
bXUuaA0KPiA+ICsrKyBiL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmgNCj4gPiBAQCAtMzAsNiAr
MzAsNyBAQCBzdHJ1Y3QgbXRrX2lvbW11X3N1c3BlbmRfcmVnIHsNCj4gPiAgZW51bSBtdGtfaW9t
bXVfcGxhdCB7DQo+ID4gIAlNNFVfTVQyNzAxLA0KPiA+ICAJTTRVX01UMjcxMiwNCj4gPiArCU00
VV9NVDgxNjcsDQo+ID4gIAlNNFVfTVQ4MTczLA0KPiA+ICAJTTRVX01UODE4MywNCj4gPiAgfTsN
Cj4gDQo+IA0KDQo=

