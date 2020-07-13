Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70CE7C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 06:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C5282065F
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 06:11:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="FS11oL08"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729091AbgGMGLs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 02:11:48 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:5151 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727107AbgGMGLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 02:11:48 -0400
X-UUID: 09583ab690804765a025f16a6515d568-20200713
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=4vEP1HF0Q3QvDpYB3OMoRNc2npFo0RTElHQW9KJ35Dc=;
        b=FS11oL08+hRTmcxJ6dQYj+ovay/NdyNli8ZllVhoC5r7Qitav/qNdbGubN/WcGlUyOHVf7I0bWeF0zgIYkJ5qFT0Mg5PGlJJ87i8hvZe02Kxmt9+9QbDO/TtnAOUsd4g54TlEeItGG/iS78NYVvZW+1EO0RYv2BpenIdSAdw61A=;
X-UUID: 09583ab690804765a025f16a6515d568-20200713
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <neal.liu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 729864613; Mon, 13 Jul 2020 14:11:39 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 13 Jul 2020 14:11:36 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 13 Jul 2020 14:11:36 +0800
Message-ID: <1594620698.22730.17.camel@mtkswgap22>
Subject: Re: [PATCH 2/2] soc: mediatek: devapc: add devapc-mt6779 driver
From:   Neal Liu <neal.liu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     Neal Liu <neal.liu@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>
Date:   Mon, 13 Jul 2020 14:11:38 +0800
In-Reply-To: <922d93be-0243-bd7e-81fd-e0068a90ef4b@gmail.com>
References: <1594027693-19530-1-git-send-email-neal.liu@mediatek.com>
         <1594027693-19530-3-git-send-email-neal.liu@mediatek.com>
         <f3cf4ef4-8c85-8921-5457-cef7a3006690@gmail.com>
         <1594107170.20820.84.camel@mtkswgap22>
         <922d93be-0243-bd7e-81fd-e0068a90ef4b@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: A4163080B86FE9835E37A8AABD162877054BB17FBCB2ED198E917A5C279E90912000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W3NuaXBdDQo+ID4+PiArLyoNCj4gPj4+ICsgKiBkZXZhcGNfdmlvbGF0aW9uX2lycSAtIHRoZSBk
ZXZhcGMgSW50ZXJydXB0IFNlcnZpY2UgUm91dGluZSAoSVNSKSB3aWxsIGR1bXANCj4gPj4+ICsg
KgkJCSAgdmlvbGF0aW9uIGluZm9ybWF0aW9uIGluY2x1ZGluZyB3aGljaCBtYXN0ZXIgdmlvbGF0
ZXMNCj4gPj4+ICsgKgkJCSAgYWNjZXNzIHNsYXZlLg0KPiA+Pj4gKyAqLw0KPiA+Pj4gK3N0YXRp
YyBpcnFyZXR1cm5fdCBkZXZhcGNfdmlvbGF0aW9uX2lycShpbnQgaXJxX251bWJlciwNCj4gPj4+
ICsJCQkJCXN0cnVjdCBtdGtfZGV2YXBjX2NvbnRleHQgKmRldmFwY19jdHgpDQo+ID4+PiArew0K
PiA+Pj4gKwljb25zdCBzdHJ1Y3QgbXRrX2RldmljZV9pbmZvICoqZGV2aWNlX2luZm8gPSBkZXZh
cGNfY3R4LT5kZXZpY2VfaW5mbzsNCj4gPj4+ICsJaW50IHZpb19pZHggPSAtMTsNCj4gPj4+ICsJ
aW50IGluZGV4ID0gLTE7DQo+ID4+PiArCWludCBzbGF2ZV90eXBlOw0KPiA+Pj4gKw0KPiA+Pj4g
Kwlmb3IgKHNsYXZlX3R5cGUgPSAwOyBzbGF2ZV90eXBlIDwgU0xBVkVfVFlQRV9OVU07IHNsYXZl
X3R5cGUrKykgew0KPiA+Pj4gKwkJaWYgKCFtdGtfZGV2YXBjX2R1bXBfdmlvX2RiZyhkZXZhcGNf
Y3R4LCBzbGF2ZV90eXBlLCAmdmlvX2lkeCwNCj4gPj4+ICsJCQkJCSAgICAgJmluZGV4KSkNCj4g
Pj4+ICsJCQljb250aW51ZTsNCj4gPj4+ICsNCj4gPj4+ICsJCS8qIEVuc3VyZSB0aGF0IHZpb2xh
dGlvbiBpbmZvIGFyZSB3cml0dGVuIGJlZm9yZQ0KPiA+Pj4gKwkJICogZnVydGhlciBvcGVyYXRp
b25zDQo+ID4+PiArCQkgKi8NCj4gPj4+ICsJCXNtcF9tYigpOw0KPiA+Pj4gKw0KPiA+Pj4gKwkJ
bWFza19tb2R1bGVfaXJxKGRldmFwY19jdHgsIHNsYXZlX3R5cGUsIHZpb19pZHgsIHRydWUpOw0K
PiA+Pj4gKw0KPiA+Pj4gKwkJY2xlYXJfdmlvX3N0YXR1cyhkZXZhcGNfY3R4LCBzbGF2ZV90eXBl
LCB2aW9faWR4KTsNCj4gPj4+ICsNCj4gPj4+ICsJCXByX2luZm8oUEZYICJWaW9sYXRpb24gLSBz
bGF2ZV90eXBlOjB4JXgsIHN5c19pbmRleDoweCV4LCBjdHJsX2luZGV4OjB4JXgsIHZpb19pbmRl
eDoweCV4XG4iLA0KPiA+Pj4gKwkJCXNsYXZlX3R5cGUsDQo+ID4+PiArCQkJZGV2aWNlX2luZm9b
c2xhdmVfdHlwZV1baW5kZXhdLnN5c19pbmRleCwNCj4gPj4+ICsJCQlkZXZpY2VfaW5mb1tzbGF2
ZV90eXBlXVtpbmRleF0uY3RybF9pbmRleCwNCj4gPj4+ICsJCQlkZXZpY2VfaW5mb1tzbGF2ZV90
eXBlXVtpbmRleF0udmlvX2luZGV4KTsNCj4gPj4NCj4gPj4gSG93IHdpbGwgdGhhdCB0aGVuIGJl
IHVzZWQ/IFdpbGwgdGhlcmUgc29tZSBraW5kIG9mIHVzZXItc3BhY2UgZGFlbW9uIHdoaWNoIHdp
bGwNCj4gPj4gcGFyc2UgdGhlIGtlcm5lbCBsb2cgdG8gc2VlIGlmIGEgdmlvbGF0aW9uIGhhcHBl
bnM/IFdoYXQgd2lsbCBpdCBkbyB3aXRoIHRoaXMNCj4gPj4gaW5mb3JtYXRpb24/DQo+ID4+DQo+
ID4+IEkgc3RpbGwgZG9uJ3QgdW5kZXJzdGFuZCB3aHkgd2UgbmVlZCB0byBkbyB0aGF0IGluIHRo
ZSBrZXJuZWwgaW5zdGVhZCBvZiBpbg0KPiA+PiBURi1BLiBDYW4geW91IHBsZWFzZSBleHBsYWlu
Pw0KPiA+Pg0KPiA+IA0KPiA+IFdlIHdvdWxkIGRvIGRpZmZlcmVudCBleHRyYSBoYW5kbGUgZm9y
IGRpZmZlcmVudCBidXMgbWFzdGVycyBpbnRlcm5hbGx5Lg0KPiANCj4gRG9lcyB0aGlzIG1lYW4g
dGhhdCB0aGlzIGlzIG9ubHkgb25lIHBhcnQgb2YgdGhlIHdob2xlIHN0b3J5PyBBcmUgeW91IHBs
YW5uaW5nIA0KPiB0byBob29rIGludG8gdGhhdCBjb2RlIGludGVybmFsbHkgdG8gaW1wbGVtZW50
IHRoZSBoYW5kbGluZz8NCj4gSW4gdGhhdCB3ZSB3b3VsZCBuZWVkIHRvIHN1cHBvcnQgdGhlIHdo
b2xlIHRoaW5nIGluIHVwc3RyZWFtLiBBbmQgdGhpcyBzb3VuZHMgDQo+IGxpa2UgeW91IHdpbGwg
bmVlZCBhIG5ldyBzdWJzeXN0ZW0gZm9yIGJ1cyBmaXJld2FsbCAob3IgaG93IHlvdSB3YW50IHRv
IG5hbWUgDQo+IGl0KS4gV2hpY2ggYWxsb3dzIHlvdSB0byBlYXNpbHkgYWRkIHN1cHBvcnQgZm9y
IG90aGVyIHZlbmRvcnMgU29Dcy4NCj4gDQoNCk5vLCB0aGUgZXh0cmEgaGFuZGxpbmcgaXMgaW1w
bGVtZW50ZWQgYnkgTWVkaWF0ZWsgcHJvcHJpZXRhcnkgZHJpdmVycw0Kd2hpY2ggaGFzIG5vIHBs
YW4gdG8gdXBzdHJlYW0uIEFuZCB0aGVyZSBpcyBubyBuZWVkIGZvciBmaXJzdCBwYXRjaCBvZg0K
bXRrLWRldmFwYyBkcml2ZXIuDQpXaHkgZG8geW91IHRoaW5rIGl0IG5lZWQgdG8gc3VwcG9ydD8g
YW5kIHdoeSBpdCB3aWxsIG5lZWQgYSBuZXcNCnN1YnN5c3RlbT8NCg0KVGhlIGJhc2ljIGZ1bmN0
aW9uYWxpdHkgb2YgdGhpcyBkcml2ZXIgaXMgdGhhdCBpdCB3aWxsIGhhbmRsZSB2aW9sYXRpb24N
CmludGVycnVwdCwgYW5kIHByaW50IHZpb2xhdGlvbiBpbmZvcm1hdGlvbiBsb2dzIGZvciBmdXJ0
aGVyIGFuYWx5c2lzLg0KRXh0cmEgaGFuZGxpbmcgaGVscHMgdXMgdG8gYW5hbHl6ZSB2aW9sYXRp
b24gbW9yZSBlYXNpbHksIGJ1dCBpdCdzIG5vdCBhDQpiYXNpYyBmdW5jdGlvbmFsaXR5IG9mIGl0
Lg0KDQo+ID4gQmFzaWNhbGx5LCBkaWZmZXJlbnQgYnVzIG1hc3RlcnMgaGF2ZSBkaWZmZXJlbnQg
ZGVidWcgbWVjaGFuaXNtLg0KPiA+IEFuZCBkaWZmZXJlbnQgY3VzdG9tZXJzIGhhdmUgZGlmZmVy
ZW50IHNldmVyaXR5IGFib3V0IGRldmFwYyB2aW9sYXRpb24uDQo+ID4gRm9yIGV4YW1wbGUsIGtl
cm5lbCBleGNlcHRpb24sIGV4dGVybmFsIGV4Y2VwdGlvbiwgd2FybmluZywgZG9uJ3QNCj4gPiBj
YXJlLC4uLg0KPiA+IA0KPiA+IEkgbGlzdCAyIHJlYXNvbiB3aHkgSSBwdXQgaXQgaW4ga2VybmVs
IGluc3RlYWQgb2YgQVRGLg0KPiA+IDEuIFJpY2ggT1Mgc3VjaCBhcyBMaW51eCBrZXJuZWwgaGFz
IG1vcmUgZGVidWcgbWVjaGFuaXNtIGFuZCB0b29scyB0bw0KPiA+IGZpbmQgbXVyZGVyZXIuDQo+
IA0KPiBCdXQgeW91IGNhbiBhY2Nlc3MgcG9yZ3JhbSBjb3VudGVyIGZyb20gRUwzIGFzIHdlbGws
IHNvIHlvdSBjb3VsZCBwcmludCBhbGwgdGhlIA0KPiBpbmZvIHlvdSBuZWVkIGluIFRGLUEuDQoN
CkZvciBsZWFzdCBwcml2aWxlZ2UgcHJpbmNpcGxlLCB0aGVyZSBpcyBubyByZWFzb24gd2Ugc2hv
dWxkIHByaW50IGFsbA0KdGhlIHZpb2xhdGlvbiBpbmZvcm1hdGlvbiBpbiBURi1BLg0KDQo+IA0K
PiA+IDIuIElmIGludGVycnVwdCBoYXMgdG8gYmUgaGFuZGxlZCBpbiBBVEYsIEdJQyBpbnRyIHdv
dWxkIGJlIHNldCBhcyBHMFMNCj4gPiAoR3JvdXAgMCBTZWN1cmUpLiBGb3Igb3VyIGludGVycnVw
dCByb3V0aW5nLCBHMFMgaW50ciB3b3VsZCBiZSBmaXEuIFdoZW4NCj4gPiB3ZSBoYW5kbGUgaXQg
aW4gRUwzLCBpdCB3b3VsZCBtYXNrIGFsbCBFTDEgaXJxIHRlbXBvcmFyaWx5LiBXZSBkbyBub3QN
Cj4gPiB0cmVhdCBkZXZhcGMgaW50ZXJydXB0IGFzIHN1Y2ggY3JpdGljYWwuDQo+IA0KPiBCdXQg
eW91IHNhaWQgInZpb2xhdGlvbiBzY2VuYXJpbyBpcyB1bmV4cGVjdGVkIiBzbyBhY3R1YWxseSB5
b3UgZG9uJ3QgZXhwZWN0IGl0IA0KPiB0byBoYXBwZW4uDQo+IA0KPiA+IA0KPiA+IERvZSBpdCBt
YWtlIHNlbnNlPyBPciBkbyB5b3UgaGF2ZSBhbnkgcmVhc29uIHRoYXQgaXQgc2hvdWxkIGJlIGhh
bmRsZWQNCj4gPiBpbiBBVEY/DQo+ID4gDQo+IA0KPiBNeSByZWFzb25pbmcgaXMgdGhhdCB5b3Ug
YnJpbmcgYSBzZWN1cml0eSBtZWNoYW5pc20gaW50byB0aGUga2VybmVsLCB3aGljaCBpcyBpbiAN
Cj4gbm9uZS1zZWN1cmUgc3RhdGUuIFRoYXQncyBhIGNvbnRyYWRpY3Rpb24uDQoNClRoZXJlIGFy
ZSB0d28gZnVuY3Rpb25hbGl0eSBmb3IgTWVkaWF0ZWsgZGV2YXBjIGhhcmR3YXJlLg0KMS4gcGVy
bWlzc2lvbiBjb250cm9sL3Byb3RlY3Rpb24NCjIuIHZpb2xhdGlvbiBpbmZvDQoNCllvdSBjYW4g
c2VlIHRoYXQgMS4gaXMgc2VjdXJpdHkgbWVjaGFuaXNtIGZvciBzdXJlLCBhbmQgd2UgcHV0IGl0
IGluDQpURi1BLg0KQnV0IDIuIGlzIG5vdCAic2VjdXJpdHkiIGF0IGFsbC4gaXQncyBmb3IgZGVi
dWdnaW5nIHB1cnBvc2UsIHdlIHRoaW5rDQppdCdzIG5vIGFueSBzZWN1cml0eSBjb25jZXJuIHRv
IHB1dCBpdCBpbiBOUy1FTDEuDQoNCj4gDQo+IFJlZ2FyZHMsDQo+IE1hdHRoaWFzDQo+IA0KW3Nu
aXBdDQoNCg==

