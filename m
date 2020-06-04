Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E58C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 03:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A23320829
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 03:39:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Uz2Fe97+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbgFDDj5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 23:39:57 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:19964 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726604AbgFDDj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 23:39:56 -0400
X-UUID: 594cecd9cb784878b791891d003735b8-20200604
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=gg0xFQsrpVwavUKDGPkf/KTKDKCcT5COSQE37vYTZu4=;
        b=Uz2Fe97+pGFfmbd7GLVLPa3P27PFL8rgTvzACaOi2WWmU/yTSWuIvKFwx4ChkNsakc0lnik5OJMTgoG18bVo2er8g11PHMHZJqbmJ+yHdenqacBaXwOG4Tc7PLGib65OcwGcQlyef48dW2KDFh+h5CJQZ+m7dCfz7x+YWWZ1ORo=;
X-UUID: 594cecd9cb784878b791891d003735b8-20200604
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 850519545; Thu, 04 Jun 2020 11:39:54 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 4 Jun 2020 11:39:46 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 4 Jun 2020 11:39:46 +0800
Message-ID: <1591241986.29475.18.camel@mtkswgap22>
Subject: Re: [PATCH] mm/memblock: export max_pfn for kernel modules
From:   Miles Chen <miles.chen@mediatek.com>
To:     Mike Rapoport <rppt@linux.ibm.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>
Date:   Thu, 4 Jun 2020 11:39:46 +0800
In-Reply-To: <20200603170624.GA202648@linux.ibm.com>
References: <20200603161132.2441-1-miles.chen@mediatek.com>
         <20200603170624.GA202648@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIwLTA2LTAzIGF0IDIwOjA2ICswMzAwLCBNaWtlIFJhcG9wb3J0IHdyb3RlOg0K
PiBPbiBUaHUsIEp1biAwNCwgMjAyMCBhdCAxMjoxMTozMkFNICswODAwLCBNaWxlcyBDaGVuIHdy
b3RlOg0KPiA+IG1heF9wZm4gaXMgdWVzZCB0byBnZXQgdGhlIGhpZ2hlc3QgcGZuIGluIHRoZSBz
eXN0ZW0uIERyaXZlcnMgbGlrZQ0KPiA+IGRyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMgY2hlY2tz
IG1heF9wZm4gdG8gc2VlIGlmIGl0IHNob3VsZCBlbmFibGUNCj4gPiBpdHMgIjRHQiBtb2RlIi4N
Cj4gPiANCj4gPiBUaGlzIHBhdGNoIGV4cG9ydHMgdGhlIG1heF9wZm4gc3ltYm9sLCBzbyB3ZSBj
YW4gYnVpbGQgdGhlIGRyaXZlciBhcw0KPiA+IGEga2VybmVsIG1vZHVsZS4NCj4gDQo+IFlvdSBj
YW4gdXNlIHRvdGFscmFtX3BhZ2VzKCksIGxpa2UgZS5nLg0KPiBkcml2ZXJzL21lZGlhL3BsYXRm
b3JtL210ay12cHUvbXRrX3ZwdS5jOg0KPiANCj4gJCBnaXQgZ3JlcCAtbnAgdG90YWxyYW1fcGFn
ZXMgZHJpdmVycy9tZWRodHRwczovL2xrbWwub3JnL2xrbWwvMjAyMC81LzMwLzEyM2lhLw0KPiBk
cml2ZXJzL21lZGlhL3BsYXRmb3JtL210ay12cHUvbXRrX3ZwdS5jPTc3OT1zdGF0aWMgaW50IG10
a192cHVfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gZHJpdmVycy9tZWRp
YS9wbGF0Zm9ybS9tdGstdnB1L210a192cHUuYzo4NjE6ICAgdnB1LT5lbmFibGVfNEdCID0gISEo
dG90YWxyYW1fcGFnZXMoKSA+IChTWl8yRyA+PiBQQUdFX1NISUZUKSk7DQo+IA0KDQpUaGFua3Mg
Zm9yIHRoZSBzdWdnZXN0aW9uLg0KdG90YWxyYW1fcGFnZXMoKSB3b3JrcyBhbmQgSSBjYW4gZm9s
bG93IHRoaXMgZXhhbXBsZS4NCg0KTWlsZXMNCg0KPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBNaWxl
cyBDaGVuIDxtaWxlcy5jaGVuQG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAgbW0vbWVtYmxv
Y2suYyB8IDEgKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCj4gPiANCj4g
PiBkaWZmIC0tZ2l0IGEvbW0vbWVtYmxvY2suYyBiL21tL21lbWJsb2NrLmMNCj4gPiBpbmRleCBj
NzliYTZmOTkyMGMuLjNiMmIyMWVjZWJiNiAxMDA2NDQNCj4gPiAtLS0gYS9tbS9tZW1ibG9jay5j
DQo+ID4gKysrIGIvbW0vbWVtYmxvY2suYw0KPiA+IEBAIC05OSw2ICs5OSw3IEBAIEVYUE9SVF9T
WU1CT0woY29udGlnX3BhZ2VfZGF0YSk7DQo+ID4gIHVuc2lnbmVkIGxvbmcgbWF4X2xvd19wZm47
DQo+ID4gIHVuc2lnbmVkIGxvbmcgbWluX2xvd19wZm47DQo+ID4gIHVuc2lnbmVkIGxvbmcgbWF4
X3BmbjsNCj4gPiArRVhQT1JUX1NZTUJPTChtYXhfcGZuKTsNCj4gPiAgdW5zaWduZWQgbG9uZyBs
b25nIG1heF9wb3NzaWJsZV9wZm47DQo+ID4gIA0KPiA+ICBzdGF0aWMgc3RydWN0IG1lbWJsb2Nr
X3JlZ2lvbiBtZW1ibG9ja19tZW1vcnlfaW5pdF9yZWdpb25zW0lOSVRfTUVNQkxPQ0tfUkVHSU9O
U10gX19pbml0ZGF0YV9tZW1ibG9jazsNCj4gPiAtLSANCj4gPiAyLjE4LjANCj4gDQoNCg==

