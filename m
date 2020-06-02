Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B12C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 12:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F5702068D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 12:19:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="BB6Bogdy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbgFBMTR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 08:19:17 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:63135 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725958AbgFBMTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 08:19:16 -0400
X-UUID: 737c847b080d486a9aaa17344788bb94-20200602
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID; bh=4h8fafRuCGTyIr/VCDupUiRjNszwNbo9UU/ty3wLFYg=;
        b=BB6BogdypJebp2/YbfZk+8Pm2yPYmPU/qlQJKVt+/SfUJ1srvKxmfwtE7f7uXs/psdx6V5ThbEQywmEhtk9NoIPq95235ujRejWTgtmH16QQ1vvQn24vKSUNG4WTODUbipnMbSJs1aDCjQs1nxZQKylOrDpc+AMO5fXCmefny+k=;
X-UUID: 737c847b080d486a9aaa17344788bb94-20200602
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 241703546; Tue, 02 Jun 2020 20:19:10 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 2 Jun 2020 20:19:00 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 2 Jun 2020 20:19:00 +0800
Message-ID: <1591100342.23525.8.camel@mtkswgap22>
Subject: Re: [PATCH] sound: usb: pcm: fix incorrect power state when playing
 sound after PM_AUTO suspend
From:   Macpaul Lin <macpaul.lin@mediatek.com>
To:     Jaroslav Kysela <perex@perex.cz>,
        Alexander Tsoy <alexander@tsoy.me>,
        Johan Hovold <johan@kernel.org>,
        Hui Wang <hui.wang@canonical.com>,
        Szabolcs =?UTF-8?Q?Sz=C5=91ke?= <szszoke.code@gmail.com>,
        <alsa-devel@alsa-project.org>, <linux-usb@vger.kernel.org>,
        "Mediatek WSD Upstream" <wsd_upstream@mediatek.com>,
        Macpaul Lin <macpaul.lin@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Takashi Iwai <tiwai@suse.com>
Date:   Tue, 2 Jun 2020 20:19:02 +0800
In-Reply-To: <1591098821-17910-1-git-send-email-macpaul.lin@mediatek.com>
References: <linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org>
         <1591098821-17910-1-git-send-email-macpaul.lin@mediatek.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 12C71F8E9B7B63D4DF6727041F40092E70F89D4579A111C8EDEBB373FBDFE0332000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIwLTA2LTAyIGF0IDE5OjUzICswODAwLCBNYWNwYXVsIExpbiB3cm90ZToNCj4g
VGhpcyBwYXRjaCBmaXggaW5jb3JyZWN0IHBvd2VyIHN0YXRlIGNoYW5nZWQgYnkgdXNiX2F1ZGlv
X3N1c3BlbmQoKQ0KPiB3aGVuIENPTkZJR19QTSBpcyBlbmFibGVkLg0KPiANCj4gQWZ0ZXIgcmVj
ZWl2aW5nIHN1c3BlbmQgUE0gbWVzc2FnZSB3aXRoIGF1dG8gZmxhZywgdXNiX2F1ZGlvX3N1c3Bl
bmQoKQ0KPiBjaGFuZ2UgY2FyZCdzIHBvd2VyIHN0YXRlIHRvIFNORFJWX0NUTF9QT1dFUl9EM2hv
dC4gT25seSB3aGVuIHRoZSBvdGhlcg0KPiByZXN1bWUgUE0gbWVzc2FnZSB3aXRoIGF1dG8gZmxh
ZyBjYW4gY2hhbmdlIHBvd2VyIHN0YXRlIHRvDQo+IFNORFJWX0NUTF9QT1dFUl9EMCBpbiBfX3Vz
Yl9hdWRpb19yZXN1bWUoKS4NCj4gDQo+IEhvd2V2ZXIsIHdoZW4gc3lzdGVtIGlzIG5vdCB1bmRl
ciBhdXRvIHN1c3BlbmQsIHJlc3VtZSBQTSBtZXNzYWdlIHdpdGgNCj4gYXV0byBmbGFnIG1pZ2h0
IG5vdCBiZSBhYmxlIHRvIHJlY2VpdmUgb24gdGltZSB3aGljaCBjYXVzZSB0aGUgcG93ZXINCj4g
c3RhdGUgd2FzIGluY29ycmVjdC4gQXQgdGhpcyB0aW1lLCBpZiBhIHBsYXllciBzdGFydHMgdG8g
cGxheSBzb3VuZCwNCj4gd2lsbCBjYXVzZSBzbmRfdXNiX3BjbV9vcGVuKCkgdG8gYWNjZXNzIHRo
ZSBjYXJkIGFuZCBzZXR1cF9od19pbmZvKCkgd2lsbA0KPiByZXN1bWUgdGhlIGNhcmQuDQo+IA0K
PiBCdXQgZXZlbiB0aGUgY2FyZCBpcyBiYWNrIHRvIHdvcmsgYW5kIGFsbCBmdW5jdGlvbiBub3Jt
YWwsIHRoZSBwb3dlcg0KPiBzdGF0ZSBpcyBzdGlsbCBpbiBTTkRSVl9DVExfUE9XRVJfRDNob3Qu
IFdoaWNoIGNhdXNlIHRoZSBpbmZpbml0ZSBsb29wDQo+IGhhcHBlbmVkIGluIHNuZF9wb3dlcl93
YWl0KCkgdG8gY2hlY2sgdGhlIHBvd2VyIHN0YXRlLiBUaHVzIHRoZQ0KPiBzdWNjZXNzaXZlIHNl
dHRpbmcgaW9jdGwgY2Fubm90IGJlIHBhc3NlZCB0byBjYXJkLg0KPiANCj4gSGVuY2Ugd2Ugc3Vn
Z2VzdCB0byBjaGFuZ2UgcG93ZXIgc3RhdGUgdG8gU05EUlZfQ1RMX1BPV0VSX0QwIHdoZW4gY2Fy
ZA0KPiBoYXMgYmVlbiByZXN1bWVkIHN1Y2Nlc3NmdWxseS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6
IE1hY3BhdWwgTGluIDxtYWNwYXVsLmxpbkBtZWRpYXRlay5jb20+DQo+IC0tLQ0KPiAgc291bmQv
dXNiL3BjbS5jIHwgICAxMSArKysrKysrKysrK2xpbnV4LXVzYkB2Z2VyLmtlcm5lbC5vcmcsDQo+
ICAxIGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL3Nv
dW5kL3VzYi9wY20uYyBiL3NvdW5kL3VzYi9wY20uYw0KPiBpbmRleCBhNGU0MDY0Li5kNjY3ZWNi
IDEwMDY0NA0KPiAtLS0gYS9zb3VuZC91c2IvcGNtLmMNCj4gKysrIGIvc291bmQvdXNiL3BjbS5j
DQo+IEBAIC0xMzIyLDYgKzEzMjIsMTcgQEAgc3RhdGljIGludCBzZXR1cF9od19pbmZvKHN0cnVj
dCBzbmRfcGNtX3J1bnRpbWUgKnJ1bnRpbWUsIHN0cnVjdCBzbmRfdXNiX3N1YnN0cmUNCj4gIAlp
ZiAoZXJyIDwgMCkNCj4gIAkJcmV0dXJuIGVycjsNCj4gIA0KPiArCS8qIGZpeCBpbmNvcnJlY3Qg
cG93ZXIgc3RhdGUgd2hlbiByZXN1bWluZyBieSBvcGVuIGFuZCBsYXRlciBpb2N0bHMgKi8NCj4g
KwlpZiAoSVNfRU5BQkxFRChDT05GSUdfUE0pICYmDQo+ICsJCXNuZF9wb3dlcl9nZXRfc3RhdGUo
c3Vicy0+c3RyZWFtLT5jaGlwLT5jYXJkKQ0KPiArCQkJPT0gU05EUlZfQ1RMX1BPV0VSX0QzaG90
KSB7DQo+ICsJCS8qIHNldCB0aGVzZSB2YXJpYWJsZXMgZm9yIHBvd2VyIHN0YXRlIGNvcnJlY3Rp
b24gKi8NCj4gKwkJc3Vicy0+c3RyZWFtLT5jaGlwLT5hdXRvc3VzcGVuZGVkID0gMDsNCj4gKwkJ
c3Vicy0+c3RyZWFtLT5jaGlwLT5udW1fc3VzcGVuZGVkX2ludGYgPSAxOw0KPiArCQlkZXZfaW5m
bygmc3Vicy0+ZGV2LT5kZXYsDQo+ICsJCQkiY2hhbmdlIHBvd2VyIHN0YXRlIGZyb20gRDNob3Qg
dG8gRDBcbiIpOw0KPiArCX0NCj4gKw0KPiAgCXJldHVybiBzbmRfdXNiX2F1dG9yZXN1bWUoc3Vi
cy0+c3RyZWFtLT5jaGlwKTsNCj4gIH0NCj4gIA0KDQpUaGUgaXNzdWUgd2FzIGZvdW5kIG9uIGtl
cm5lbCA0LjE0IChhbmRyb2lkIHRyZWUpLiBUaGUgdGVzdCBpcyB0byBhZGQNCmRlYnVnIGxvZyBp
biBzb3VuZC9jb3JlL2luaXQuYyB0byBjaGVjayBpZiB0aGUgcG93ZXIgc3RhdGUgaXMNClNORFJW
X0NUTF9QT1dFUl9EM2hvdC4NCg0KZGlmZiAtLWdpdCBhL3NvdW5kL2NvcmUvaW5pdC5jIGIvc291
bmQvY29yZS9pbml0LmMNCmluZGV4IGIwMmE5OTcuLmEwYmVlNzYgMTAwNjQ0DQotLS0gYS9zb3Vu
ZC9jb3JlL2luaXQuYw0KKysrIGIvc291bmQvY29yZS9pbml0LmMNCkBAIC0xMDExLDYgKzEwMTEs
OCBAQCBpbnQgc25kX3Bvd2VyX3dhaXQoc3RydWN0IHNuZF9jYXJkICpjYXJkLCB1bnNpZ25lZA0K
aW50IHBvd2VyX3N0YXRlKQ0KIAkJaWYgKHNuZF9wb3dlcl9nZXRfc3RhdGUoY2FyZCkgPT0gcG93
ZXJfc3RhdGUpDQogCQkJYnJlYWs7DQogCQlzZXRfY3VycmVudF9zdGF0ZShUQVNLX1VOSU5URVJS
VVBUSUJMRSk7DQorCQlwcl9pbmZvKCIlcyBzbmRfcG93ZXJfZ2V0X3N0YXRlWyV4XVxuIiwgX19m
dW5jX18sDQorCQkJc25kX3Bvd2VyX2dldF9zdGF0ZShjYXJkKSk7DQogCQlzY2hlZHVsZV90aW1l
b3V0KDMwICogSFopOw0KIAl9DQogCXJlbW92ZV93YWl0X3F1ZXVlKCZjYXJkLT5wb3dlcl9zbGVl
cCwgJndhaXQpOw0KDQpBZnRlciBhcHBsaWVkIGEgd29yayBhcm91bmQgYnkgZm9yY2luZyB0aGUg
cG93ZXIgc3RhdGUsIHBjbSByZWxhdGVkDQppb2N0bCBhbmQgcGFyYW1ldGVyIHNldHRpbmdzIGNh
biBiZSBzZXQgdG8gdXNiIHNvdW5kIGNhcmQgY29ycmVjdGx5Lg0KT3RoZXJ3aXNlIGEgaW5maW5p
dGUgbG9vcCB3aWxsIGhhcHBlbmVkIGluIHNuZF9wb3dlcl93YWl0KCkuDQoNCkhlcmUgaXMgdGhl
IG9yaWdpbiB3b3JrIGFyb3VuZCBmb3IgdmVyaWZ5aW5nIHRoaXMgcG93ZXIgc3RhdGUgaXNzdWUg
b24NCmtlcm5lbCA0LjE0Lg0KDQpkaWZmIC0tZ2l0IGEvc291bmQvdXNiL3BjbS5jIGIvc291bmQv
dXNiL3BjbS5jDQppbmRleCA5MzNhZGNkN2FmODEuLjlhY2Q1MGRkNzE1NSAxMDA2NDQNCi0tLSBh
L3NvdW5kL3VzYi9wY20uYw0KKysrIGIvc291bmQvdXNiL3BjbS5jDQpAQCAtMTI3NCw2ICsxMjc0
LDE2IEBAIHN0YXRpYyBpbnQgc2V0dXBfaHdfaW5mbyhzdHJ1Y3Qgc25kX3BjbV9ydW50aW1lDQoq
cnVudGltZSwgc3RydWN0IHNuZF91c2Jfc3Vic3RyZQ0KIAlpZiAoZXJyIDwgMCkNCiAJCXJldHVy
biBlcnI7DQogDQorCS8qIGF2b2lkIGluY29ycmVjdCBwb3dlciBzdGF0ZSB3aGVuIGV4ZWN1dGlu
ZyBJT0NUTCAqLw0KKwlpZiAoSVNfRU5BQkxFRChDT05GSUdfUE0pICYmDQorCQlzbmRfcG93ZXJf
Z2V0X3N0YXRlKHN1YnMtPnN0cmVhbS0+Y2hpcC0+Y2FyZCkNCisJCQk9PSBTTkRSVl9DVExfUE9X
RVJfRDNob3QpIHsNCisJCWRldl9pbmZvKCZzdWJzLT5kZXYtPmRldiwNCisJCQkiY2hhbmdlIHBv
d2VyIHN0YXRlIGZyb20gRDNob3QgdG8gRDBcbiIpOw0KKwkJc25kX3Bvd2VyX2NoYW5nZV9zdGF0
ZShzdWJzLT5zdHJlYW0tPmNoaXAtPmNhcmQsDQorCQkJCQlTTkRSVl9DVExfUE9XRVJfRDApOw0K
Kwl9DQorDQogCXBhcmFtX3BlcmlvZF90aW1lX2lmX25lZWRlZCA9IFNORFJWX1BDTV9IV19QQVJB
TV9QRVJJT0RfVElNRTsNCiAJaWYgKHN1YnMtPnNwZWVkID09IFVTQl9TUEVFRF9GVUxMKQ0KIAkJ
LyogZnVsbCBzcGVlZCBkZXZpY2VzIGhhdmUgZml4ZWQgZGF0YSBwYWNrZXQgaW50ZXJ2YWwgKi8N
Cg0KSG93ZXZlciwgdGhlIHBhdGNoIEkndmUgc2VuZCBpcyBtZWFudCB0byBtYWtlIHN1cmUgdGhl
IHBvd2VyIHN0YXRlIHdpbGwNCmJlIGNvcnJlY3RlZCBiZWZvcmUgc25kX3VzYl9hdXRvcmVzdW1l
KCksIEl0IHNob3VsZCBiZSBhZGFwdCB0byBrZXJuZWwNCjQuMTQgYW5kIGxhdGVyLg0KDQpUaGFu
a3MuDQpNYWNwYXVsIExpbg0KDQo=

