Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC12BC433E5
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 08:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4A3F2067D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 08:27:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="QIpcZeDh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729048AbgGMI1c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 04:27:32 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:7971 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725818AbgGMI1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 04:27:31 -0400
X-UUID: b3bd923ea6ec4d3fb544467c6410bebc-20200713
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=bAp3L2r0l+bStR8a6Cp7A6LrBmqQxrRR0lfS2YHQrQ8=;
        b=QIpcZeDh2aQRL/MWCDrwXnaSp3XIYQWkOjKo4con4Cn2eKaNBxQ5aFW7T3he8OF1wZwy8V3HC1jh/AJ6wrhUOeEykAF6/gOTMX+MH+7eiQn8QkkZOWGOzYoGWA3K1iBlSJQc1+LCO7GoNZq018jyw3GhZ1ZUhIi+Gved3xRPwPs=;
X-UUID: b3bd923ea6ec4d3fb544467c6410bebc-20200713
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <neal.liu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1238615068; Mon, 13 Jul 2020 16:27:26 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 13 Jul 2020 16:27:22 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 13 Jul 2020 16:27:22 +0800
Message-ID: <1594628844.22730.48.camel@mtkswgap22>
Subject: Re: [PATCH v2 2/2] soc: mediatek: add mtk-devapc driver
From:   Neal Liu <neal.liu@mediatek.com>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
CC:     Neal Liu <neal.liu@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <devicetree@vger.kernel.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Date:   Mon, 13 Jul 2020 16:27:24 +0800
In-Reply-To: <CAAOTY_9MPYi=FAisE50UzT=eceSykN+Z8HnfFLLg_uRDhPAkpg@mail.gmail.com>
References: <1594285927-1840-1-git-send-email-neal.liu@mediatek.com>
         <1594285927-1840-3-git-send-email-neal.liu@mediatek.com>
         <CAAOTY_-7PwoPG_0ce2p4BCNQ3rundg40Bsni14XSmVETExkKkw@mail.gmail.com>
         <1594351423.4670.18.camel@mtkswgap22>
         <CAAOTY_9MPYi=FAisE50UzT=eceSykN+Z8HnfFLLg_uRDhPAkpg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ2h1bi1LdWFuZywNCg0KVGhhbmtzIGZvciB5b3VyIHJldmlldy4NCg0KT24gRnJpLCAyMDIw
LTA3LTEwIGF0IDIyOjIxICswODAwLCBDaHVuLUt1YW5nIEh1IHdyb3RlOg0KPiBIaSwgTmVhbDoN
Cj4gDQo+IE5lYWwgTGl1IDxuZWFsLmxpdUBtZWRpYXRlay5jb20+IOaWvCAyMDIw5bm0N+aciDEw
5pelIOmAseS6lCDkuIrljYgxMToyM+Wvq+mBk++8mg0KPiA+DQo+ID4gSGkgQ2h1bi1LdWFuZywN
Cj4gPg0KPiA+IFRoYW5rcyBmb3IgeW91ciByZXZpZXcuDQo+ID4NCj4gPiBPbiBUaHUsIDIwMjAt
MDctMDkgYXQgMjE6MDEgKzA4MDAsIENodW4tS3VhbmcgSHUgd3JvdGU6DQo+ID4gPiBIaSwgTmVh
bDoNCj4gPiA+DQo+ID4gPiBOZWFsIExpdSA8bmVhbC5saXVAbWVkaWF0ZWsuY29tPiDmlrwgMjAy
MOW5tDfmnIg55pelIOmAseWbmyDkuIvljYg1OjEz5a+r6YGT77yaDQo+ID4gPiA+DQo+ID4gPiA+
IE1lZGlhVGVrIGJ1cyBmYWJyaWMgcHJvdmlkZXMgVHJ1c3Rab25lIHNlY3VyaXR5IHN1cHBvcnQg
YW5kIGRhdGENCj4gPiA+ID4gcHJvdGVjdGlvbiB0byBwcmV2ZW50IHNsYXZlcyBmcm9tIGJlaW5n
IGFjY2Vzc2VkIGJ5IHVuZXhwZWN0ZWQNCj4gPiA+ID4gbWFzdGVycy4NCj4gPiA+ID4gVGhlIHNl
Y3VyaXR5IHZpb2xhdGlvbiBpcyBsb2dnZWQgYW5kIHNlbnQgdG8gdGhlIHByb2Nlc3NvciBmb3IN
Cj4gPiA+ID4gZnVydGhlciBhbmFseXNpcyBvciBjb3VudGVybWVhc3VyZXMuDQo+ID4gPiA+DQo+
ID4gPiA+IEFueSBvY2N1cnJlbmNlIG9mIHNlY3VyaXR5IHZpb2xhdGlvbiB3b3VsZCByYWlzZSBh
biBpbnRlcnJ1cHQsIGFuZA0KPiA+ID4gPiBpdCB3aWxsIGJlIGhhbmRsZWQgYnkgbXRrLWRldmFw
YyBkcml2ZXIuIFRoZSB2aW9sYXRpb24NCj4gPiA+ID4gaW5mb3JtYXRpb24gaXMgcHJpbnRlZCBp
biBvcmRlciB0byBmaW5kIHRoZSBtdXJkZXJlci4NCj4gPiA+ID4NCj4gPiA+ID4gU2lnbmVkLW9m
Zi1ieTogTmVhbCBMaXUgPG5lYWwubGl1QG1lZGlhdGVrLmNvbT4NCj4gPiA+DQo+ID4gPiBbc25p
cF0NCj4gPiA+DQo+ID4gPiA+ICsNCj4gPiA+ID4gK3N0YXRpYyB1MzIgZ2V0X3NoaWZ0X2dyb3Vw
KHN0cnVjdCBtdGtfZGV2YXBjX2NvbnRleHQgKmRldmFwY19jdHgsDQo+ID4gPiA+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgIGludCBzbGF2ZV90eXBlLCBpbnQgdmlvX2lkeCkNCj4gPiA+DQo+
ID4gPiB2aW9faWR4ICBpcyB1c2VsZXNzLCBzbyByZW1vdmUgaXQuDQo+ID4gPg0KPiA+DQo+ID4g
eWVzLCBteSBtaXN0YWtlLiBJJ2xsIHJlbW92ZSBpdCBvbiBuZXh0IHBhdGNoLg0KPiA+DQo+ID4g
PiA+ICt7DQo+ID4gPiA+ICsgICAgICAgdTMyIHZpb19zaGlmdF9zdGE7DQo+ID4gPiA+ICsgICAg
ICAgdm9pZCBfX2lvbWVtICpyZWc7DQo+ID4gPiA+ICsgICAgICAgaW50IGJpdDsNCj4gPiA+ID4g
Kw0KPiA+ID4gPiArICAgICAgIHJlZyA9IG10a19kZXZhcGNfcGRfZ2V0KGRldmFwY19jdHgsIHNs
YXZlX3R5cGUsIFZJT19TSElGVF9TVEEsIDApOw0KPiA+ID4gPiArICAgICAgIHZpb19zaGlmdF9z
dGEgPSByZWFkbChyZWcpOw0KPiA+ID4gPiArDQo+ID4gPiA+ICsgICAgICAgZm9yIChiaXQgPSAw
OyBiaXQgPCAzMjsgYml0KyspIHsNCj4gPiA+ID4gKyAgICAgICAgICAgICAgIGlmICgodmlvX3No
aWZ0X3N0YSA+PiBiaXQpICYgMHgxKQ0KPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICBi
cmVhazsNCj4gPiA+ID4gKyAgICAgICB9DQo+ID4gPiA+ICsNCj4gPiA+ID4gKyAgICAgICByZXR1
cm4gYml0Ow0KPiA+ID4gPiArfQ0KPiA+ID4gPiArDQo+ID4gPg0KPiA+ID4gW3NuaXBdDQo+ID4g
Pg0KPiA+ID4gPiArDQo+ID4gPiA+ICsvKg0KPiA+ID4gPiArICogZGV2YXBjX3Zpb2xhdGlvbl9p
cnEgLSB0aGUgZGV2YXBjIEludGVycnVwdCBTZXJ2aWNlIFJvdXRpbmUgKElTUikgd2lsbCBkdW1w
DQo+ID4gPiA+ICsgKiAgICAgICAgICAgICAgICAgICAgICAgdmlvbGF0aW9uIGluZm9ybWF0aW9u
IGluY2x1ZGluZyB3aGljaCBtYXN0ZXIgdmlvbGF0ZXMNCj4gPiA+ID4gKyAqICAgICAgICAgICAg
ICAgICAgICAgICBhY2Nlc3Mgc2xhdmUuDQo+ID4gPiA+ICsgKi8NCj4gPiA+ID4gK3N0YXRpYyBp
cnFyZXR1cm5fdCBkZXZhcGNfdmlvbGF0aW9uX2lycShpbnQgaXJxX251bWJlciwNCj4gPiA+ID4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBtdGtfZGV2YXBj
X2NvbnRleHQgKmRldmFwY19jdHgpDQo+ID4gPiA+ICt7DQo+ID4gPiA+ICsgICAgICAgY29uc3Qg
c3RydWN0IG10a19kZXZpY2VfaW5mbyAqKmRldmljZV9pbmZvOw0KPiA+ID4gPiArICAgICAgIGlu
dCBzbGF2ZV90eXBlX251bTsNCj4gPiA+ID4gKyAgICAgICBpbnQgdmlvX2lkeCA9IC0xOw0KPiA+
ID4gPiArICAgICAgIGludCBzbGF2ZV90eXBlOw0KPiA+ID4gPiArDQo+ID4gPiA+ICsgICAgICAg
c2xhdmVfdHlwZV9udW0gPSBkZXZhcGNfY3R4LT5zbGF2ZV90eXBlX251bTsNCj4gPiA+ID4gKyAg
ICAgICBkZXZpY2VfaW5mbyA9IGRldmFwY19jdHgtPmRldmljZV9pbmZvOw0KPiA+ID4gPiArDQo+
ID4gPiA+ICsgICAgICAgZm9yIChzbGF2ZV90eXBlID0gMDsgc2xhdmVfdHlwZSA8IHNsYXZlX3R5
cGVfbnVtOyBzbGF2ZV90eXBlKyspIHsNCj4gPiA+DQo+ID4gPiBJZiBzbGF2ZV90eXBlX251bSBp
cyAxLCBJIHRoaW5rIHRoZSBjb2RlIHNob3VsZCBiZSBzaW1wbGVyLg0KPiA+DQo+ID4gc2xhdmVf
dHlwZV9udW0gaXMgZGVwZW5kcyBvbiBEVCBkYXRhLCBpdCdzIG5vdCBhbHdheXMgMS4NCj4gDQo+
IFBsZWFzZSBjaGFuZ2UgY29tbWl0IHRpdGxlIHRvICJhZGQgbXQ2Nzc5IG10ay1kZXZhcGMgZHJp
dmVyIi4gVGhpcw0KPiBwYXRjaCBpcyBqdXN0IGZvciBtdDY3NzkuIElmIHNsYXZlX3R5cGVfbnVt
ID0gMSBpbiBtdDY3NzksIHRoZXJlIGlzDQo+IG9ubHkgb25lIHNsYXZlIGFuZCB3ZSBkb24ndCBu
ZWVkIGEgc2xhdmVfdHlwZSB2YXJpYWJsZS4gQWRkDQo+IHNsYXZlX3R5cGVfbnVtIGluIHRoZSBw
YXRjaCBvZiBhZGRpbmcgb25lIFNvQyB3aGljaCBoYXMgbXVsdGlwbGUNCj4gc2xhdmVzLg0KDQpJ
ZiBzbGF2ZV90eXBlX251bSB2YWx1ZSBpcyBwYXNzZWQgZnJvbSBEVCBkYXRhLCBjb3VsZCB3ZSBz
dGlsbCBhc3N1bWUNCml0cyB2YWx1ZT8gRG9lcyBpdCBtYWtlIHNlbnNlIHRvIGhhdmUgdGhpcyBz
dHJvbmcgYXNzdW1wdGlvbj8NCg0KSSdtIGdvaW5nIHRvIHJlbW92ZSBtdGtfZGV2aWNlX2luZm8g
c3RydWN0IGFycmF5LCBhbmQgcGFzcyBhbGwgU29DDQpzcGVjaWZpYyBkYXRhIGZyb20gRFQuDQpJ
cyBpdCBva2F5IHRvIGtlZXAgc2xhdmVfdHlwZV9udW0gYXMgYSB2YXJpYW5jZT8NCg0KPiANCj4g
Pg0KPiA+ID4NCj4gPiA+ID4gKyAgICAgICAgICAgICAgIGlmICghbXRrX2RldmFwY19kdW1wX3Zp
b19kYmcoZGV2YXBjX2N0eCwgc2xhdmVfdHlwZSwgJnZpb19pZHgpKQ0KPiA+ID4gPiArICAgICAg
ICAgICAgICAgICAgICAgICBjb250aW51ZTsNCj4gPiA+ID4gKw0KPiA+ID4gPiArICAgICAgICAg
ICAgICAgLyogRW5zdXJlIHRoYXQgdmlvbGF0aW9uIGluZm8gYXJlIHdyaXR0ZW4gYmVmb3JlDQo+
ID4gPiA+ICsgICAgICAgICAgICAgICAgKiBmdXJ0aGVyIG9wZXJhdGlvbnMNCj4gPiA+ID4gKyAg
ICAgICAgICAgICAgICAqLw0KPiA+ID4gPiArICAgICAgICAgICAgICAgc21wX21iKCk7DQo+ID4g
PiA+ICsNCj4gPiA+ID4gKyAgICAgICAgICAgICAgIG1hc2tfbW9kdWxlX2lycShkZXZhcGNfY3R4
LCBzbGF2ZV90eXBlLCB2aW9faWR4LCB0cnVlKTsNCj4gPiA+DQo+ID4gPiBXaHkgZG8geW91IG1h
c2sgaXJxPw0KPiA+DQo+ID4gSXQgaGFzIHRvIG1hc2sgc2xhdmUncyBpcnEgYmVmb3JlIGNsZWFy
IHZpb2xhdGlvbiBzdGF0dXMuDQo+ID4gSXQncyBvbmUgb2YgaGFyZHdhcmUgZGVzaWduLg0KPiAN
Cj4gSWYgZG9uJ3QgZG8gdGhpcyBiZWZvcmUgY2xlYXJfdmlvX3N0YXR1cywgd2hhdCB3b3VsZCBo
YXBwZW4/IFRoZSBjbGVhcg0KPiB3b3VsZCBmYWlsPw0KDQpJZiB3ZSBkb24ndCBtYXNrIHNsYXZl
J3MgaXJxIGJlZm9yZSBjbGVhciB2aW8gc3RhdHVzLCBJdCBtaWdodCB0cmlnZ2VyDQphbm90aGVy
IGludGVycnVwdCBiZWZvcmUgY3VycmVudCBJU1IgZmluaXNoZWQuIFRoZSBuZXN0ZWQgaW50ZXJy
dXB0IHdpbGwNCmhhdmUgdW5leHBlY3RlZCBiZWhhdmlvciBhbmQgaGFyZHdhcmUgc3RhdGUgbWFj
aGluZSBnb2VzIHdyb25nLg0KDQo+IA0KPiA+DQo+ID4gPg0KPiA+ID4gPiArDQo+ID4gPiA+ICsg
ICAgICAgICAgICAgICBjbGVhcl92aW9fc3RhdHVzKGRldmFwY19jdHgsIHNsYXZlX3R5cGUsIHZp
b19pZHgpOw0KPiA+ID4gPiArDQo+ID4gPiA+ICsgICAgICAgICAgICAgICBtYXNrX21vZHVsZV9p
cnEoZGV2YXBjX2N0eCwgc2xhdmVfdHlwZSwgdmlvX2lkeCwgZmFsc2UpOw0KPiA+ID4gPiArICAg
ICAgIH0NCj4gPiA+ID4gKw0KPiA+ID4gPiArICAgICAgIHJldHVybiBJUlFfSEFORExFRDsNCj4g
PiA+ID4gK30NCj4gPiA+ID4gKw0KPiA+ID4gPiArLyoNCj4gPiA+ID4gKyAqIHN0YXJ0X2RldmFw
YyAtIGluaXRpYWxpemUgZGV2YXBjIHN0YXR1cyBhbmQgc3RhcnQgcmVjZWl2aW5nIGludGVycnVw
dA0KPiA+ID4gPiArICogICAgICAgICAgICAgICB3aGlsZSBkZXZhcGMgdmlvbGF0aW9uIGlzIHRy
aWdnZXJlZC4NCj4gPiA+ID4gKyAqLw0KPiA+ID4NCj4gPiA+IFtzbmlwXQ0KPiA+ID4NCj4gPiA+
ID4gKw0KPiA+ID4gPiArc3RydWN0IG10a19kZXZpY2VfaW5mbyB7DQo+ID4gPiA+ICsgICAgICAg
aW50IHN5c19pbmRleDsNCj4gPiA+DQo+ID4gPiBVc2VsZXNzLCBzbyByZW1vdmUgaXQuDQo+ID4N
Cj4gPiBXZSBuZWVkIHRvIHByaW50IGl0IGFzIG91ciBkZWJ1ZyBpbmZvcm1hdGlvbi4NCj4gPiBC
dXQgSSBkaWQgbm90IGFwcGx5IGl0IG9uIHRoaXMgcGF0Y2gsIEknbGwgYWRkIGl0IG9uIG5leHQg
cGF0Y2guDQo+IA0KPiBJIHRoaW5rIHZpbyBhZGRyZXNzIGlzIGVub3VnaCB0byBmaW5kIG91dCB0
aGUgbXVyZGVyLCBzbyByZW1vdmUgaXQgaW4NCj4gdGhpcyBwYXRjaC4gSWYgaXQgcHJvdmlkZSBh
bm90aGVyIGluZm9ybWF0aW9uLCBhZGQgaXQgaW4gYW5vdGhlciBwYXRjaA0KPiBhbmQgZGVzY3Jp
YmUgY2xlYXIgYWJvdXQgd2hhdCBpcyB0aGlzIGFuZCBob3cgdG8gdXNlIHRoaXMgaW5mb3JtYXRp
b24uDQo+IA0KDQpPa2F5LCBpdCBtYWtlIHNlbnNlLiBJJ2xsIHJlbW92ZSBpdCBpbiBuZXh0IHBh
dGNoZXMuDQoNCj4gPg0KPiA+ID4NCj4gPiA+ID4gKyAgICAgICBpbnQgY3RybF9pbmRleDsNCj4g
PiA+DQo+ID4gPiBEaXR0by4NCj4gPiA+DQo+ID4gPiBSZWdhcmRzLA0KPiA+ID4gQ2h1bi1LdWFu
Zy4NCj4gPiA+DQo+ID4gPiA+ICsgICAgICAgaW50IHZpb19pbmRleDsNCj4gPiA+ID4gK307DQo+
ID4gPiA+ICsNCj4gPg0KDQo=

