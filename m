Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC9FBC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 06:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B98DF2074D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 06:10:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="cfApXo/2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbgFPGKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 02:10:05 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:22746 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725775AbgFPGKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 02:10:04 -0400
X-UUID: 2eca7ca8d7574622918d7a14cdc55589-20200616
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=XiVSb9XsT4rYYp4QQy5/4H2opMhj9fqBilP9u1oaeFk=;
        b=cfApXo/29TO1mit3Ub9SEyKIK53RCqCudW1UdlrcoBpdxcSOl+zU07JaJKWt4b79bCJRUBVTcMh+PmH03wGlxfuFYKIkeAs+SLV3QZu1umIZDtJ8x+AxuFGPLoJ4QRTW+/tOf2YEl28JlwLQgEtRiMMcc4uysWb57vJF02OT1qI=;
X-UUID: 2eca7ca8d7574622918d7a14cdc55589-20200616
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <neal.liu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1515460118; Tue, 16 Jun 2020 14:09:59 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 16 Jun 2020 14:09:55 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 16 Jun 2020 14:09:53 +0800
Message-ID: <1592287798.18012.3.camel@mtkswgap22>
Subject: Re: [PATCH 2/2] soc: mediatek: devapc: add devapc-mt6873 driver
From:   Neal Liu <neal.liu@mediatek.com>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
CC:     Neal Liu <neal.liu@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <devicetree@vger.kernel.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Date:   Tue, 16 Jun 2020 14:09:58 +0800
In-Reply-To: <CAAOTY_8booP95diFN=C-ybTBciqsw=B7Zq4dCS8=VOjgyUTu1A@mail.gmail.com>
References: <1591698261-22639-1-git-send-email-neal.liu@mediatek.com>
         <1591698261-22639-3-git-send-email-neal.liu@mediatek.com>
         <CAAOTY_8W7FLrjKbNt+WHXjsBzgn_E7n5stKjv94RBnF7ktVuiA@mail.gmail.com>
         <1592188994.18525.11.camel@mtkswgap22>
         <CAAOTY_8EFYoAtuAugkYuG=F6kkbu3yeBnyoKBGTnHzPJKHQ5EQ@mail.gmail.com>
         <CAAOTY_8booP95diFN=C-ybTBciqsw=B7Zq4dCS8=VOjgyUTu1A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ2h1bi1LdWFuZywNCg0KT24gTW9uLCAyMDIwLTA2LTE1IGF0IDIyOjE3ICswODAwLCBDaHVu
LUt1YW5nIEh1IHdyb3RlOg0KPiBDaHVuLUt1YW5nIEh1IDxjaHVua3VhbmcuaHVAa2VybmVsLm9y
Zz4g5pa8IDIwMjDlubQ25pyIMTXml6Ug6YCx5LiAIOS4i+WNiDEwOjE05a+r6YGT77yaDQo+ID4N
Cj4gPiBIaSwgTmVhbDoNCj4gPg0KPiA+IE5lYWwgTGl1IDxuZWFsLmxpdUBtZWRpYXRlay5jb20+
IOaWvCAyMDIw5bm0NuaciDE15pelIOmAseS4gCDkuIrljYgxMDo0M+Wvq+mBk++8mg0KPiA+ID4N
Cj4gPiA+IEhpIENodW4tS3VhbmcsDQo+ID4gPg0KPiA+ID4NCj4gPiA+IE9uIFN1biwgMjAyMC0w
Ni0xNCBhdCAxMToyNiArMDgwMCwgQ2h1bi1LdWFuZyBIdSB3cm90ZToNCj4gPiA+ID4gSGksIE5l
YWw6DQo+ID4gPiA+DQo+ID4gPiA+IE5lYWwgTGl1IDxuZWFsLmxpdUBtZWRpYXRlay5jb20+IOaW
vCAyMDIw5bm0NuaciDnml6Ug6YCx5LqMIOS4i+WNiDY6MjXlr6vpgZPvvJoNCj4gPiA+ID4gPg0K
PiA+ID4gPiA+IE1UNjg3MyBidXMgZnJhYnJpYyBwcm92aWRlcyBUcnVzdFpvbmUgc2VjdXJpdHkg
c3VwcG9ydCBhbmQgZGF0YQ0KPiA+ID4gPiA+IHByb3RlY3Rpb24gdG8gcHJldmVudCBzbGF2ZXMg
ZnJvbSBiZWluZyBhY2Nlc3NlZCBieSB1bmV4cGVjdGVkDQo+ID4gPiA+ID4gbWFzdGVycy4NCj4g
PiA+ID4gPiBUaGUgc2VjdXJpdHkgdmlvbGF0aW9ucyBhcmUgbG9nZ2VkIGFuZCBzZW50IHRvIHRo
ZSBwcm9jZXNzb3IgZm9yDQo+ID4gPiA+ID4gZnVydGhlciBhbmFseXNpcyBvciBjb3VudGVybWVh
c3VyZXMuDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBBbnkgb2NjdXJyZW5jZSBvZiBzZWN1cml0eSB2
aW9sYXRpb24gd291bGQgcmFpc2UgYW4gaW50ZXJydXB0LCBhbmQNCj4gPiA+ID4gPiBpdCB3aWxs
IGJlIGhhbmRsZWQgYnkgZGV2YXBjLW10Njg3MyBkcml2ZXIuIFRoZSB2aW9sYXRpb24NCj4gPiA+
ID4gPiBpbmZvcm1hdGlvbiBpcyBwcmludGVkIGluIG9yZGVyIHRvIGZpbmQgdGhlIG11cmRlcmVy
Lg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogTmVhbCBMaXUgPG5lYWwubGl1
QG1lZGlhdGVrLmNvbT4NCj4gPiA+ID4gPiAtLS0NCj4gPiA+ID4NCj4gPiA+ID4gW3NuaXBdDQo+
ID4gPiA+DQo+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ICsgICAgICAgLyogNTAgKi8NCj4gPiA+ID4g
PiArICAgICAgIHstMSwgLTEsIDUwLCAiT09CX3dheV9lbiIsIHRydWV9LA0KPiA+ID4gPiA+ICsg
ICAgICAgey0xLCAtMSwgNTEsICJPT0Jfd2F5X2VuIiwgdHJ1ZX0sDQo+ID4gPiA+ID4gKyAgICAg
ICB7LTEsIC0xLCA1MiwgIk9PQl93YXlfZW4iLCB0cnVlfSwNCj4gPiA+ID4gPiArICAgICAgIHst
MSwgLTEsIDUzLCAiT09CX3dheV9lbiIsIHRydWV9LA0KPiA+ID4gPiA+ICsgICAgICAgey0xLCAt
MSwgNTQsICJPT0Jfd2F5X2VuIiwgdHJ1ZX0sDQo+ID4gPiA+ID4gKyAgICAgICB7LTEsIC0xLCA1
NSwgIk9PQl93YXlfZW4iLCB0cnVlfSwNCj4gPiA+ID4gPiArICAgICAgIHstMSwgLTEsIDU2LCAi
RGVjb2RlX2Vycm9yIiwgdHJ1ZX0sDQo+ID4gPiA+ID4gKyAgICAgICB7LTEsIC0xLCA1NywgIkRl
Y29kZV9lcnJvciIsIHRydWV9LA0KPiA+ID4gPiA+ICsgICAgICAgey0xLCAtMSwgNTgsICJESVNQ
X1BXTSIsIGZhbHNlfSwNCj4gPiA+ID4gPiArICAgICAgIHstMSwgLTEsIDU5LCAiSU1QX0lJQ19X
UkFQIiwgZmFsc2V9LA0KPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiArICAgICAgIC8qIDYwICovDQo+
ID4gPiA+ID4gKyAgICAgICB7LTEsIC0xLCA2MCwgIkRFVklDRV9BUENfUEVSSV9QQVJfX0FPIiwg
ZmFsc2V9LA0KPiA+ID4gPiA+ICsgICAgICAgey0xLCAtMSwgNjEsICJERVZJQ0VfQVBDX1BFUklf
UEFSX1BETiIsIGZhbHNlfSwNCj4gPiA+ID4NCj4gPiA+ID4gWW91IGRvZXMgbm90IHByb2Nlc3Mg
dGhlIGl0ZW0gd2hvc2UgZW5hYmxlX3Zpb19pcnEgaXMgZmFsc2UsIHNvIEkNCj4gPiA+ID4gdGhp
bmsgeW91IHNob3VsZCByZW1vdmUgdGhlc2UgaXRlbXMgYW5kIHJlbW92ZSBlbmFibGVfdmlvX2ly
cSBiZWNhdXNlDQo+ID4gPiA+IHRoZSByZXN0IGl0ZW0ncyBlbmFibGVfdmlvX2lycSB3b3VsZCBh
bHdheXMgYmUgdHJ1ZS4NCj4gPiA+DQo+ID4gPiBJbiBzb21lIHVzZXJzLCB0aGV5IGNhbiBkZWNp
ZGUgd2hpY2ggc2xhdmVzIHRoZXkgd2FudCB0byBlbmFibGUgb3INCj4gPiA+IGRpc2FibGUgdmlv
bGF0aW9uIGlycSBpbiBkaWZmZXJlbnQgcHJvZHVjdC4gV2UgcmVtYWluIHRoaXMgcHJvcGVydHkg
Zm9yDQo+ID4gPiBjb21wYXRpYmlsaXR5Lg0KPiA+DQo+ID4gSSB0aGluayBpbiB1cHN0cmVhbSB2
ZXJzaW9uLCB5b3UgY291bGQgc3RpbGwgcmVtb3ZlIGVuYWJsZV92aW9faXJxIGFuZA0KPiA+IHBy
b2Nlc3MgYWxsIGl0ZW1zLiBGb3IgZG93bnN0cmVhbSBjYXNlLCB1c2VycyBjb3VsZCByZW1vdmUg
aXRlbXMgdGhleQ0KPiA+IGRvZXMgbm90IGludGVyZXN0IGluLg0KDQpPa2F5LCBzb3VuZHMgZ29v
ZC4gSSdsbCB0cnkgdG8gcmV2aXNlIGFuZCB1cHN0cmVhbSBhZ2Fpbi4NCg0KPiA+DQo+ID4gPg0K
PiA+ID4gPg0KPiA+ID4gPiA+ICt9Ow0KPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiArc3RhdGljIHN0
cnVjdCBtdGtfZGV2aWNlX251bSBtdGs2ODczX2RldmljZXNfbnVtW10gPSB7DQo+ID4gPiA+ID4g
KyAgICAgICB7U0xBVkVfVFlQRV9JTkZSQSwgVklPX1NMQVZFX05VTV9JTkZSQX0sDQo+ID4gPiA+
ID4gKyAgICAgICB7U0xBVkVfVFlQRV9QRVJJLCBWSU9fU0xBVkVfTlVNX1BFUkl9LA0KPiA+ID4g
PiA+ICsgICAgICAge1NMQVZFX1RZUEVfUEVSSTIsIFZJT19TTEFWRV9OVU1fUEVSSTJ9LA0KPiA+
ID4gPiA+ICsgICAgICAge1NMQVZFX1RZUEVfUEVSSV9QQVIsIFZJT19TTEFWRV9OVU1fUEVSSV9Q
QVJ9LA0KPiA+ID4gPiA+ICt9Ow0KPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiArc3RhdGljIHN0cnVj
dCBQRVJJQVhJX0lEX0lORk8gcGVyaV9taV9pZF90b19tYXN0ZXJbXSA9IHsNCj4gPiA+ID4gPiAr
ICAgICAgIHsiVEhFUk0yIiwgICAgICAgeyAwLCAwLCAwIH0gfSwNCj4gPiA+ID4gPiArICAgICAg
IHsiU1BNIiwgICAgICAgICAgeyAwLCAxLCAwIH0gfSwNCj4gPiA+ID4gPiArICAgICAgIHsiQ0NV
IiwgICAgICAgICAgeyAwLCAwLCAxIH0gfSwNCj4gPiA+ID4gPiArICAgICAgIHsiVEhFUk0iLCAg
ICAgICAgeyAwLCAxLCAxIH0gfSwNCj4gPiA+ID4gPiArICAgICAgIHsiU1BNX0RSQU1DIiwgICAg
eyAxLCAxLCAwIH0gfSwNCj4gPiA+ID4NCj4gPiA+ID4gVGhlIGJpdHMgeyAxLCAxLCAwIH0gZXF1
YWwgdG8gYSBudW1iZXIgMHgzLCBJIHRoaWluayB5b3Ugc2hvdWxkIHVzZSBhDQo+ID4gPiA+IG51
bWJlciBpbnN0ZWFkIG9mIGJpdHMgYW5kIGV2ZXJ5dGhpbmcgd291bGQgYmUgbW9yZSBlYXN5Lg0K
PiA+ID4NCj4gPiA+IFdlIHdvdWxkIGxpa2UgdG8ga2VlcCBpdCBiZWNhdXNlIHRoZSBiaXQgdmFs
dWUgY29udGFpbnMgbW9yZSB0aGFuIDAvMSwNCj4gPiA+IGl0IG1pZ2h0IGJlICcyJyBpbiBzb21l
IGNhc2VzLiAnMicgbWVhbnMgaXQgY2FuIGJlIDAgb3IgMS4gVGhpcyB0b3RhbGx5DQo+ID4gPiBi
eSBoYXJkd2FyZSBkZXNpZ24gJiBpbXBsZW1lbnRhdGlvbi4NCj4gPg0KPiA+IFVwc3RyZWFtIHRo
ZSBwYXRjaCB0aGF0IGhhcyBkb250LWNhcmUtYml0cywgb3RoZXJ3aXNlLCB1c2UgYSBudW1iZXIg
Zm9yIHRoaXMuDQo+ID4gRXZlbiB0aGVyZSBpcyBkb250LWNhcmUtYml0cywgSSBoYXZlIGEgYmV0
dGVyIHdheSB0byBwcm9jZXNzIGl0LiBIZXJlDQo+ID4gaXMgYW4gZXhhbXBsZSB0aGF0IGhhcyBk
b250LWNhcmUtYml0czoNCj4gPg0KPiA+ICsgeyJUaW55c3lzIiwgICAgICAgICB7IDAsIDEsIDAs
IDAsIDIsIDIsIDIsIDIsIDIsIDIsIDAsIDAsIDAsIDAgfSB9LA0KPiA+DQo+ID4gSSBjb3VsZCB1
c2UgYSB7IHZhbHVlLCBtYXNrIH0gcGFpciBmb3IgdGhpcyBjYXNlLA0KPiA+DQo+ID4gdmFsdWUg
PSAweDAwMDI7IC8qIHZhbHVlIGZvciBjYXJlIGJpdHMgKi8NCj4gPiBtYXNrID0gMHgzYzAyOyAv
KiBtYXNrIGZvciBjYXJlIGJpdHMgKi8NCj4gDQo+IFNvcnJ5LCB0aGlzIHdvdWxkIGJlDQo+IA0K
PiBtYXNrID0gMHgzYzBmOyAvKiBtYXNrIGZvciBjYXJlIGJpdHMgKi8NCj4gDQo+ID4NCj4gPiBT
byB0aGUgY29tcGFyZSBzdGF0ZW1lbnQgd291bGQgYmUNCj4gPg0KPiA+IGlmICgoYnVzX2lkICYg
bWFzaykgPT0gdmFsdWUpDQo+ID4NCj4gPiBTbyB5b3UgY291bGQgZ2V0IHJpZCBvZiB0aGUgc2Vj
b25kIGZvci1sb29wIGFuZCByZWR1Y2UgdGhlIHByb2Nlc3NpbmcNCj4gPiB0aW1lIGluIGlycSBo
YW5kbGVyLg0KPiA+DQoNCkdyZWF0IGlkZWEhIEknbGwgdHJ5IHRvIHJldmlzZSBhbmQgdXBzdHJl
YW0gYWdhaW4uDQoNCj4gPiBSZWdhcmRzLA0KPiA+IENodW4tS3VhbmcuDQoNCg==

