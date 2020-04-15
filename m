Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CCDAC2BB1D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 01:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 782A120737
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 01:53:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="pGa7f6AE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392772AbgDOBxk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 21:53:40 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:28129 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387766AbgDOBxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 21:53:34 -0400
X-UUID: 73b05dc708bd4681a1b45d44c43761df-20200415
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=bIUc1LatWTPrRy0d0hIMzrPytsvlDok1S2YutEMtvpY=;
        b=pGa7f6AEhu0gFbZjS5Z0LX1aSJhT3HT0Cja7zjbk0vTDLL//95+yFUEg8ffasW8J+1Ry83bWL3fX2eN4jba/jmWE6FIKKKHZjB5B3p0dLakeRiTvKzZbKE0Mk7kOj5LwhshWnKUYnrWhbs2NsOtddI8dFHlnrMHpTMqyKJkOTR8=;
X-UUID: 73b05dc708bd4681a1b45d44c43761df-20200415
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1100836088; Wed, 15 Apr 2020 09:53:27 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 15 Apr 2020 09:53:26 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 15 Apr 2020 09:53:25 +0800
Message-ID: <1586915606.5647.5.camel@mtkswgap22>
Subject: Re: [PATCH] mm/gup: fix null pointer dereference detected by
 coverity
From:   Miles Chen <miles.chen@mediatek.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Peter Xu <peterx@redhat.com>
Date:   Wed, 15 Apr 2020 09:53:26 +0800
In-Reply-To: <20200414170827.d32fc1fc12a33b140b740b94@linux-foundation.org>
References: <20200407095107.1988-1-miles.chen@mediatek.com>
         <20200414170827.d32fc1fc12a33b140b740b94@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIwLTA0LTE0IGF0IDE3OjA4IC0wNzAwLCBBbmRyZXcgTW9ydG9uIHdyb3RlOg0K
PiBPbiBUdWUsIDcgQXByIDIwMjAgMTc6NTE6MDcgKzA4MDAgTWlsZXMgQ2hlbiA8bWlsZXMuY2hl
bkBtZWRpYXRlay5jb20+IHdyb3RlOg0KPiANCj4gPiBJbiBmaXh1cF91c2VyX2ZhdWx0KCksIGl0
IGlzIHBvc3NpYmxlIHRoYXQgdW5sb2NrZWQgaXMgTlVMTCwNCj4gPiBzbyB3ZSBzaG91bGQgdGVz
dCB1bmxvY2tlZCBiZWZvcmUgdXNpbmcgaXQuDQo+ID4gDQo+ID4gRm9yIGV4YW1wbGUsIGluIGFy
Y2gvYXJjL2tlcm5lbC9wcm9jZXNzLmMsIE5VTEwgaXMgcGFzc2VkDQo+ID4gdG8gZml4dXBfdXNl
cl9mYXVsdCgpLg0KPiA+IA0KPiA+IFNZU0NBTExfREVGSU5FMyhhcmNfdXNyX2NtcHhjaGcsIGlu
dCAqLCB1YWRkciwgaW50LCBleHBlY3RlZCwgaW50LCBuZXcpDQo+ID4gew0KPiA+IC4uLg0KPiA+
IAlyZXQgPSBmaXh1cF91c2VyX2ZhdWx0KGN1cnJlbnQsIGN1cnJlbnQtPm1tLCAodW5zaWduZWQg
bG9uZykgdWFkZHIsDQo+ID4gCQkJICAgICAgIEZBVUxUX0ZMQUdfV1JJVEUsIE5VTEwpOw0KPiA+
IC4uLg0KPiA+IH0NCj4gDQo+IChjYyBQZXRlcikNCj4gDQo+ID4gLS0tIGEvbW0vZ3VwLmMNCj4g
PiArKysgYi9tbS9ndXAuYw0KPiA+IEBAIC0xMjMwLDcgKzEyMzAsOCBAQCBpbnQgZml4dXBfdXNl
cl9mYXVsdChzdHJ1Y3QgdGFza19zdHJ1Y3QgKnRzaywgc3RydWN0IG1tX3N0cnVjdCAqbW0sDQo+
ID4gIAlpZiAocmV0ICYgVk1fRkFVTFRfUkVUUlkpIHsNCj4gPiAgCQlkb3duX3JlYWQoJm1tLT5t
bWFwX3NlbSk7DQo+ID4gIAkJaWYgKCEoZmF1bHRfZmxhZ3MgJiBGQVVMVF9GTEFHX1RSSUVEKSkg
ew0KPiA+IC0JCQkqdW5sb2NrZWQgPSB0cnVlOw0KPiA+ICsJCQlpZiAodW5sb2NrZWQpDQo+ID4g
KwkJCQkqdW5sb2NrZWQgPSB0cnVlOw0KPiA+ICAJCQlmYXVsdF9mbGFncyB8PSBGQVVMVF9GTEFH
X1RSSUVEOw0KPiA+ICAJCQlnb3RvIHJldHJ5Ow0KPiA+ICAJCX0NCj4gDQo+IE5vdCBzdXJlLiAg
SWYgdGhlIGNhbGxlciBwYXNzZXMgRkFVTFRfRkxBR19BTExPV19SRVRSWSB0aGVuIHRoZXkgbXVz
dA0KPiBhbHNvIHBhc3MgaW4gYSB2YWxpZCBub24tTlVMTCBgdW5sb2NrZWQnLiAgSWYgdGhlIGNh
bGxlciBwYXNzZWQNCj4gRkFVTFRfRkxBR19BTExPV19SRVRSWSBhbmQgdW5sb2NrZWQ9PU5VTEwg
dGhlbiB0aGUgcmVzdWx0aW5nIG9vcHMgaXMgYW4NCj4gYXBwcm9wcmlhdGUgd2F5IG9mIHJlcG9y
dGluZyB0aGlzIG1pc3Rha2UuICBJIHRoaW5rPw0KPiANCkFncmVlLiBIb3cgYWJvdXQgcHV0ICJ1
bmxvY2tlZD09TlVMTCBtdXN0IG5vdCBiZSB1c2VkIHdpdGgNCkZBVUxUX0ZMQUdfQUxMT1dfUkVU
UlkuIiBpbiB0aGUgY29tbWVudD8gTWFrZSBpdCBlYXNpZXIgdG8gdW5kZXJzdGFuZA0KdGhlIG9v
cHMuDQoNCmUuZy4sIA0KDQotLS0gYS9tbS9ndXAuYw0KKysrIGIvbW0vZ3VwLmMNCkBAIC0xMTc2
LDcgKzExNzYsOCBAQCBzdGF0aWMgYm9vbCB2bWFfcGVybWl0c19mYXVsdChzdHJ1Y3QNCnZtX2Fy
ZWFfc3RydWN0ICp2bWEsDQogICogQGFkZHJlc3M6ICAgdXNlciBhZGRyZXNzDQogICogQGZhdWx0
X2ZsYWdzOmZsYWdzIHRvIHBhc3MgZG93biB0byBoYW5kbGVfbW1fZmF1bHQoKQ0KICAqIEB1bmxv
Y2tlZDogIGRpZCB3ZSB1bmxvY2sgdGhlIG1tYXBfc2VtIHdoaWxlIHJldHJ5aW5nLCBtYXliZSBO
VUxMIGlmDQpjYWxsZXINCi0gKiAgICAgICAgICAgICBkb2VzIG5vdCBhbGxvdyByZXRyeQ0KKyAq
ICAgICAgICAgICAgIGRvZXMgbm90IGFsbG93IHJldHJ5LiBJZiBOVUxMLCB0aGUgY2FsbGVyIG11
c3QgZ3VhcmFudGVlDQorICogICAgICAgICAgICAgdGhlIGZhdWx0X2ZsYWdzIGRvZXMgbm90IGNv
bnRhaW4gRkFVTFRfRkxBR19BTExPV19SRVRSWS4NCg0KDQo=

