Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E82C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 03:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 307DB20738
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 03:05:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="u7PlTMKU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725915AbgFCDFX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 23:05:23 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:24778 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725780AbgFCDFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 23:05:23 -0400
X-UUID: 013f03ca456545518d26a021da9022c8-20200603
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=W7tF7Mgc/fvciJgJ7QAqTgTQjhCvBLQ6CPGKAAjG2D8=;
        b=u7PlTMKUuiWIMlZ0yaBgoWCf4OpcgaFcNVfiVgNmlk2zLhiNPd3kUQlg7W6aIdqImhJbJprM8BCe3Cc/QNGHDs88+/FgsVcq8lVR6UyPHj5BPxHB6dIeK9exI0XwZxTTCekXvT/bOmbq28HrNagnnEmWfNr2V9pGwnMU32OhBq4=;
X-UUID: 013f03ca456545518d26a021da9022c8-20200603
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 62782876; Wed, 03 Jun 2020 11:05:17 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 3 Jun 2020 11:05:10 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 3 Jun 2020 11:05:10 +0800
Message-ID: <1591153515.23525.50.camel@mtkswgap22>
Subject: Re: [PATCH] sound: usb: pcm: fix incorrect power state when playing
 sound after PM_AUTO suspend
From:   Macpaul Lin <macpaul.lin@mediatek.com>
To:     Takashi Iwai <tiwai@suse.de>
CC:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Alexander Tsoy <alexander@tsoy.me>,
        Johan Hovold <johan@kernel.org>,
        Hui Wang <hui.wang@canonical.com>,
        Szabolcs =?UTF-8?Q?Sz=C5=91ke?= <szszoke.code@gmail.com>,
        <alsa-devel@alsa-project.org>, <linux-usb@vger.kernel.org>,
        Mediatek WSD Upstream <wsd_upstream@mediatek.com>,
        Macpaul Lin <macpaul.lin@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date:   Wed, 3 Jun 2020 11:05:15 +0800
In-Reply-To: <s5hpnahhbz8.wl-tiwai@suse.de>
References: <s5hpnahhbz8.wl-tiwai@suse.de>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 586FA4C026DBFAB221D5480D4E6A63BFED753ABF860C0F7D852D822E2AAFD11B2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIwLTA2LTAyIGF0IDE0OjQ2ICswMjAwLCBUYWthc2hpIEl3YWkgd3JvdGU6DQo+
IE9uIFR1ZSwgMDIgSnVuIDIwMjAgMTM6NTM6NDEgKzAyMDAsDQo+IE1hY3BhdWwgTGluIHdyb3Rl
Og0KPiA+IA0KPiA+IFRoaXMgcGF0Y2ggZml4IGluY29ycmVjdCBwb3dlciBzdGF0ZSBjaGFuZ2Vk
IGJ5IHVzYl9hdWRpb19zdXNwZW5kKCkNCj4gPiB3aGVuIENPTkZJR19QTSBpcyBlbmFibGVkLg0K
PiA+IA0KPiA+IEFmdGVyIHJlY2VpdmluZyBzdXNwZW5kIFBNIG1lc3NhZ2Ugd2l0aCBhdXRvIGZs
YWcsIHVzYl9hdWRpb19zdXNwZW5kKCkNCj4gPiBjaGFuZ2UgY2FyZCdzIHBvd2VyIHN0YXRlIHRv
IFNORFJWX0NUTF9QT1dFUl9EM2hvdC4gT25seSB3aGVuIHRoZSBvdGhlcg0KPiA+IHJlc3VtZSBQ
TSBtZXNzYWdlIHdpdGggYXV0byBmbGFnIGNhbiBjaGFuZ2UgcG93ZXIgc3RhdGUgdG8NCj4gPiBT
TkRSVl9DVExfUE9XRVJfRDAgaW4gX191c2JfYXVkaW9fcmVzdW1lKCkuDQo+ID4gDQo+ID4gSG93
ZXZlciwgd2hlbiBzeXN0ZW0gaXMgbm90IHVuZGVyIGF1dG8gc3VzcGVuZCwgcmVzdW1lIFBNIG1l
c3NhZ2Ugd2l0aA0KPiA+IGF1dG8gZmxhZyBtaWdodCBub3QgYmUgYWJsZSB0byByZWNlaXZlIG9u
IHRpbWUgd2hpY2ggY2F1c2UgdGhlIHBvd2VyDQo+ID4gc3RhdGUgd2FzIGluY29ycmVjdC4gQXQg
dGhpcyB0aW1lLCBpZiBhIHBsYXllciBzdGFydHMgdG8gcGxheSBzb3VuZCwNCj4gPiB3aWxsIGNh
dXNlIHNuZF91c2JfcGNtX29wZW4oKSB0byBhY2Nlc3MgdGhlIGNhcmQgYW5kIHNldHVwX2h3X2lu
Zm8oKSB3aWxsDQo+ID4gcmVzdW1lIHRoZSBjYXJkLg0KPiA+IA0KPiA+IEJ1dCBldmVuIHRoZSBj
YXJkIGlzIGJhY2sgdG8gd29yayBhbmQgYWxsIGZ1bmN0aW9uIG5vcm1hbCwgdGhlIHBvd2VyDQo+
ID4gc3RhdGUgaXMgc3RpbGwgaW4gU05EUlZfQ1RMX1BPV0VSX0QzaG90Lg0KPiANCj4gSG0sIGlu
IGV4YWN0bHkgd2hpY2ggc2l0dWF0aW9uIGRvZXMgdGhpcyBoYXBwZW4/ICBJIHN0aWxsIGRvbid0
IGdldA0KPiBpdC4gIENvdWxkIHlvdSBlbGFib3JhdGUgaG93IHRvIHRyaWdnZXIgdGhpcz8NCg0K
SSdtIG5vdCBzdXJlIGlmIHRoaXMgd2lsbCBoYXBwZW4gb24gbGFwdG9wIG9yIG9uIFBDLg0KV2Un
dmUgZm91bmQgdGhpcyBpc3N1ZSBvbiBBbmRyb2lkIHBob25lIChJJ20gbm90IHN1cmUgaWYgZWFj
aCBBbmRyb2lkDQpwaG9uZSBjYW4gcmVwcm9kdWNlIHRoaXMuKS4NCg0KQWZ0ZXIgYm9vdGluZyB0
aGUgYW5kcm9pZCBwaG9uZSwgaW5zZXJ0IHR5cGUtYyBoZWFkc2V0IHdpdGhvdXQgY2hhcmdpbmcN
CmFuZCBwbGF5IG11c2ljIGF0IGFueSBkdXJhdGlvbiwgc2F5LCAxIHNlY29uZCwgdGhlbiBzdG9w
LiBQdXQgcGhvbmUgYXdheQ0KdG8gaWRsZSBhYm91dCAxN34xOCBtaW51dGVzLiBXYWl0IGF1dG8g
cG0gaGFwcGVuZWQgYW5kIHRoZSBwb3dlciBzdGF0ZQ0KY2hhbmdlIHRvIFNORFJWX0NUTF9QT1dF
Ul9EM2hvdCBpbiBzb3VuZC91c2IvY2FyZC5jLiBUaGVuIHdha2UgdXAgdGhlDQpwaG9uZSwgcGxh
eSBtdXNpYyBhZ2Fpbi4gVGhlbiB5b3UnbGwgcHJvYmFibHkgZm91bmQgdGhlIG11c2ljIHdhcyBu
b3QNCnBsYXlpbmcgYW5kIHRoZSBwcm9ncmVzcyBiYXIga2VlcCBhdCB0aGUgc2FtZSBwb3NpdGlv
bi4gSXQgb25seSBoYXBwZW4gDQp3aGVuIHBvd2VyIHN0YXRlIGlzIFNORFJWX0NUTF9QT1dFUl9E
M2hvdC4gSWYgbm90ICh0aGUgcG93ZXIgc3RhdGUgaXMNClNORFJWX0NUTF9QT1dFUl9EMCksIHJl
cGVhdCB0aGUgc3RlcHMgZm9yIHNldmVyYWwgdGltZXMsIHRoZW4gaXQgd2lsbCBiZQ0KcHJvZHVj
ZWQgYXQgc29tZSB0aW1lLg0KDQpXaGVuIGl0IGhhcHBlbmVkLCBzb3VuZF91c2JfcGNtX29wZW4o
KSB3aWxsIHdha2UgdXAgdGhlIHNvdW5kIGNhcmQgYnkgDQpzZXR1cF9od19pbmZvKCktPl9fdXNi
X2F1ZGlvX3Jlc3VtZSgpLiBIb3dldmVyLCB0aGUgY2FyZCBhbmQgdGhlDQppbnRlcmZhY2UgaXMg
ZnVuY3Rpb24gcHJvcGVybHkgcmlnaHQgbm93LCB0aGUgcG93ZXIgc3RhdGUga2VlcHMgcmVtYWlu
DQpTTkRSVl9DVExfUE9XRVJfRDNob3QuIFRoZSBzdWdnZXN0aXZlIHBhcmFtZXRlciBzZXR0aW5n
cyBmcm9tIHVwcGVyDQpzb3VuZCByZXF1ZXN0IHdpbGwgYmUgcGVuZGluZyBzaW5jZSBsYXRlciBz
bmRfcG93ZXJfd2FpdCgpIGNhbGwgd2lsbA0Kc3RpbGwgd2FpdCB0aGUgY2FyZCBhd2FrZW4uIElk
ZWFsbHksIGF1dG8gUE0gc2hvdWxkIGJlIHJlY292ZXJlZCBieQ0Kc291bmQgY2FyZCBpdHNlbGYu
IEJ1dCBvbmNlIHRoZSBjYXJkIGlzIGF3YWtlbiBhdCB0aGlzIGNpcmN1bXN0YW5jZSwgaXQNCmxv
b2tzIGxpa2UgdGhlcmUgYXJlIG5vdCBtb3JlIGF1dG8gcG0gZXZlbnQuIEFuZCB0aGUgc291bmQg
c3lzdGVtIG9mDQp0aGlzIGludGVyZmFjZSB3aWxsIHN0dWNrIGhlcmUgZm9yZXZlciB1bnRpbCB1
c2VyIHBsdWcgb3V0IHRoZSBoZWFkc2V0DQoocmVzZXQgdGhlIGhhcmR3YXJlKS4NCg0KVGhlIHJv
b3QgY2F1c2UgaXMgdGhhdCBvbmNlIHRoZSBjYXJkIGhhcyBiZWVuIHJlc3VtZWQsIGl0IHNob3Vs
ZCBpbmZvcm0NCmF1dG8gcG0gY2hhbmdlIHRoZSBzdGF0ZSBiYWNrIGludG8gU05EUlZfQ1RMX1BP
V0VSX0QwIGFuZCBtYXJrIHRoZQ0KZGV2aWNlIGlzIHVzaW5nIGJ5IHNvbWUgb25lLg0KDQo+ID4g
V2hpY2ggY2F1c2UgdGhlIGluZmluaXRlIGxvb3ANCj4gPiBoYXBwZW5lZCBpbiBzbmRfcG93ZXJf
d2FpdCgpIHRvIGNoZWNrIHRoZSBwb3dlciBzdGF0ZS4gVGh1cyB0aGUNCj4gPiBzdWNjZXNzaXZl
IHNldHRpbmcgaW9jdGwgY2Fubm90IGJlIHBhc3NlZCB0byBjYXJkLg0KPiA+IA0KPiA+IEhlbmNl
IHdlIHN1Z2dlc3QgdG8gY2hhbmdlIHBvd2VyIHN0YXRlIHRvIFNORFJWX0NUTF9QT1dFUl9EMCB3
aGVuIGNhcmQNCj4gPiBoYXMgYmVlbiByZXN1bWVkIHN1Y2Nlc3NmdWxseS4NCj4gDQo+IFRoaXMg
ZG9lc24ndCBsb29rIGxpa2UgYSByaWdodCBzb2x1dGlvbiBmb3IgdGhlIHByb2JsZW0sIHNvcnJ5
Lg0KPiBUaGUgY2FyZCBQTSBzdGF0dXMgbXVzdCBiZSByZWNvdmVyZWQgdG8gRDAgd2hlbiB0aGUg
YXV0b3Jlc3VtZQ0KPiBzdWNjZWVkcy4gIElmIG5vdCwgc29tZXRoaW5nIGlzIGJyb2tlbiB0aGVy
ZSwgYW5kIGl0IG11c3QgYmUgZml4ZWQNCj4gaW5zdGVhZCBvZiBmaWRkbGluZyB0aGUgc3RhdHVz
IGZsYWcgZXh0ZXJuYWxseS4NCg0KWWVzLCBJIGFncmVlZCwgYnV0IGFmdGVyIGNoZWNraW5nIHRo
ZSBjb2RlIGluIHNvdW5kIGRyaXZlcnMsIA0KaXQgbG9va3MgbGlrZSB0aGVyZSBpcyBvbmx5IGNo
YW5jZSB0aGF0IGF1dG8gcG0gdHJpZ2dlcmVkIGJ5IGxvdy1sZXZlbA0KY29kZSBpbiBzb3VuZC91
c2IvY2FyZC5jLiBJbiBrZXJuZWwgNC4xNCwgYXV0byBwbSBzdXNwZW5kIGlzIHRyaWdnZXJlZA0K
Ynkgc25kX3BjbV9zdXNwZW5kX2FsbCgpLiBJbiBsYXRlciBrZXJuZWwsIGl0IGlzIHRyaWdnZXJl
ZCBieQ0Kc25kX3VzYl9wY21fc3VzcGVuZCgpLiBIb3dldmVyLCBpdCBsb29rcyBsaWtlIHRoZXJl
IGFyZSBubyBhbnkgcmVzdW1lDQp0cmlnZ2VyIHRvIHJlY292ZXIgYXV0byBwbSBzdGF0ZSB3aGVu
IHRoZSBjYXJkIGhhcyBiZWVuIHdha2VuIGJ5DQpzb3VuZF91c2JfcGNtX29wZW4oKS4gVGhlIHJl
bWFpbiByZXN1bWUgdHJpZ2dlciBpbg0Kc291bmQvY29yZS9wY21fbmF0aXZlLmMgd2VyZSBhbGwg
c3RhdGljLiBJJ3ZlIHRyaWVkIHRvIHVzZSB0aGVzZSByZXN1bWUNCmZ1bmN0aW9uIGluIHNvdW5k
L3VzYi9jYXJkLmMgYnV0IGl0IHNlZW1zIGNhbm5vdCBnZXQgYmV0dGVyIHJlc3VsdCB0aGFuDQpj
aGFuZ2luZyB0aGUgcG93ZXIgc3RhdGUgd2hlbiBzb3VuZCBjYXJkIGlzIGluIHVzZS4gDQoNCkkn
dmUgcmVwbGllZCBhbm90aGVyIG1haWwgZWFybGllciBpbmNsdWRlcyBkZWJ1ZyBwYXRjaCBhbmQg
dGhlIG90aGVyDQp3b3JrIGFyb3VuZCB0byB2ZXJpZnkgdGhpcyBpc3N1ZS4gVGhlIGlzc3VlIGhh
cyBiZWVuIGZvdW5kIG9uDQprZXJuZWwtNC4xNCwgYnV0IGNoZWNrIHRoZSBjb2RlIGxvZ2ljIGhl
cmUgaW4gc291bmQvdXNiL2NhcmQuYyBhbmQNCnNvdW5kL3VzYi9wY20uYywgSSB0aGluayB0aGUg
c2FtZSBwcm9ibGVtIHN0aWxsIGV4aXN0ZWQgaW4gNC4xOSwgNS40DQoodXNlZCBieSBhbmRyb2lk
KSwgYW5kIGluIGN1cnJlbnQga2VybmVsIHRyZWUuDQoNCg0KPiB0aGFua3MsDQo+IA0KPiBUYWth
c2hpDQoNCklmIHRoZSBhYm92ZSBleHBsYW5hdGlvbiB3ZXJlIG5vdCBjbGVhciBlbm91Z2gsIEkn
bGwgdHJ5IG15IGJlc3QgdG8NCmV4cGxhaW4gaXQgaW4gbW9yZSBkZXRhaWwuIE1heWJlIHRoZSBi
ZXR0ZXIgd2F5IGlzIHRvIHNlbmQgYm90aCBhdXRvIHBtDQpyZXN1bWUgYW5kIHJ1bnRpbWUgcmVz
dW1lIHdoZW4gc291bmRfdXNiX3BjbV9vcGVuKCkgaXMgY2FsbGVkLiBCdXQNCmFjY29yZGluZyB0
byB0aGUgY3VycmVudCBjb2RlcyBpbiBjYXJkLmMsIHdlIG1pZ2h0IG5lZWQgdG8gY2FsbA0KX191
c2JfYXVkaW9fcmVzdW1lKCkgdHdpY2UgaW4gc2V0dXBfaHdfaW5mbygpLg0KDQpUaGFua3MNCk1h
Y3BhdWwgTGluDQoNCg0KDQo=

