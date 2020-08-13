Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EBF9C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 12:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E62582078D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 12:26:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="GmWMcG+B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbgHMM0F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 08:26:05 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:17825 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726100AbgHMM0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 08:26:04 -0400
X-UUID: 9372ecbb5ab74080b5bf5f10feeba9a3-20200813
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=e41c5oYHqFyVyE7RzGdj+2oNjx9zrZ3d7b52Xcy+lRI=;
        b=GmWMcG+BIBGO22uTdBbkrn4zxhcIScGQV8kNkFh3aoyvpEBcuhLidVJYbbOhI7ChlNj7U0MR6x8qdXG3THfdCkFhm7VpvhPJEMlezo1v5OQOoERcGV2c9B+IZGSLTcjzEh7wEH6hX8AF+hKfpd2LTpG5oADKtYgSGq3d9Cca9V0=;
X-UUID: 9372ecbb5ab74080b5bf5f10feeba9a3-20200813
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 316300702; Thu, 13 Aug 2020 20:25:58 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 13 Aug 2020 20:25:54 +0800
Received: from [172.21.84.99] (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 13 Aug 2020 20:25:54 +0800
Message-ID: <1597321556.9999.27.camel@mtksdccf07>
Subject: Re: [PATCH 1/5] timer: kasan: record and print timer stack
From:   Walter Wu <walter-zh.wu@mediatek.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        John Stultz <john.stultz@linaro.org>,
        "Stephen Boyd" <sboyd@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        <kasan-dev@googlegroups.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>
Date:   Thu, 13 Aug 2020 20:25:56 +0800
In-Reply-To: <87d03ulqbp.fsf@nanos.tec.linutronix.de>
References: <20200810072313.529-1-walter-zh.wu@mediatek.com>
         <87d03ulqbp.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 6EB2F04DEDD30544E1EE481F458926A2139F49991264C64715B53AF6C629549C2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIwLTA4LTEzIGF0IDEzOjQ4ICswMjAwLCBUaG9tYXMgR2xlaXhuZXIgd3JvdGU6
DQo+IFdhbHRlciwNCj4gDQo+IFdhbHRlciBXdSA8d2FsdGVyLXpoLnd1QG1lZGlhdGVrLmNvbT4g
d3JpdGVzOg0KPiA+IFRoaXMgcGF0Y2ggcmVjb3JkcyB0aGUgbGFzdCB0d28gdGltZXIgcXVldWVp
bmcgc3RhY2tzIGFuZCBwcmludHMNCj4gDQo+ICJUaGlzIHBhdGNoIiBpcyB1c2VsZXNzIGluZm9y
bWF0aW9uIGFzIHdlIGFscmVhZHkga25vdyBmcm9tIHRoZSBzdWJqZWN0DQo+IGxpbmUgdGhhdCB0
aGlzIGlzIGEgcGF0Y2guDQo+IA0KPiBnaXQgZ3JlcCAnVGhpcyBwYXRjaCcgRG9jdW1lbnRhdGlv
bi9wcm9jZXNzLw0KPiANCg0KVGhhbmtzIGZvciB5b3VyIGluZm9ybWF0aW9uLg0KDQo+ID4gdXAg
dG8gMiB0aW1lciBzdGFja3MgaW4gS0FTQU4gcmVwb3J0LiBJdCBpcyB1c2VmdWwgZm9yIHByb2dy
YW1tZXJzDQo+ID4gdG8gc29sdmUgdXNlLWFmdGVyLWZyZWUgb3IgZG91YmxlLWZyZWUgbWVtb3J5
IHRpbWVyIGlzc3Vlcy4NCj4gPg0KPiA+IFdoZW4gdGltZXJfc2V0dXAoKSBvciB0aW1lcl9zZXR1
cF9vbl9zdGFjaygpIGlzIGNhbGxlZCwgdGhlbiBpdA0KPiA+IHByZXBhcmVzIHRvIHVzZSB0aGlz
IHRpbWVyIGFuZCBzZXRzIHRpbWVyIGNhbGxiYWNrLCB3ZSBzdG9yZQ0KPiA+IHRoaXMgY2FsbCBz
dGFjayBpbiBvcmRlciB0byBwcmludCBpdCBpbiBLQVNBTiByZXBvcnQuDQo+IA0KPiB3ZSBzdG9y
ZSBub3RoaW5nLiBEb24ndCBpbXBlcnNvbmF0ZSBjb2RlIHBsZWFzZS4NCj4gDQo+IEFsc28gcGxl
YXNlIHN0cnVjdHVyZSB0aGUgY2hhbmdlbG9nIGluIGEgd2F5IHRoYXQgaXQncyBlYXN5IHRvDQo+
IHVuZGVyc3RhbmQgd2hhdCB0aGlzIGlzIGFib3V0IGluc3RlYWQgb2YgdGVsbGluZyBmaXJzdCB3
aGF0IHRoZSBwYXRjaA0KPiBkb2VzIGFuZCB0aGVuIHNvbWUgaGFsZiBiYWtlbiBpbmZvcm1hdGlv
biB3aHkgdGhpcyBpcyB1c2VmdWwgZm9sbG93ZWQgYnkNCj4gbW9yZSBpbmZvcm1hdGlvbiBhYm91
dCB3aGF0IGl0IGRvZXMuDQo+IA0KPiBTb21ldGhpbmcgbGlrZSB0aGlzOg0KPiANCj4gICBGb3Ig
YW5hbHlzaW5nIHVzZSBhZnRlciBmcmVlIG9yIGRvdWJsZSBmcmVlIG9mIG9iamVjdHMgaXQgaXMg
aGVscGZ1bA0KPiAgIHRvIHByZXNlcnZlIHVzYWdlIGhpc3Rvcnkgd2hpY2ggcG90ZW50aWFsbHkg
Z2l2ZXMgYSBoaW50IGFib3V0IHRoZQ0KPiAgIGFmZmVjdGVkIGNvZGUuDQo+IA0KPiAgIEZvciB0
aW1lcnMgaXQgaGFzIHR1cm5lZCBvdXQgdG8gYmUgdXNlZnVsIHRvIHJlY29yZCB0aGUgc3RhY2sg
dHJhY2UNCj4gICBvZiB0aGUgdGltZXIgaW5pdCBjYWxsLiA8QUREIHRlY2huaWNhbCBleHBsYW5h
dGlvbiB3aHkgdGhpcyBpcyB1c2VmdWw+DQo+ICANCj4gICBSZWNvcmQgdGhlIG1vc3QgcmVjZW50
IHR3byB0aW1lciBpbml0IGNhbGxzIGluIEtBU0FOIHdoaWNoIGFyZSBwcmludGVkDQo+ICAgb24g
ZmFpbHVyZSBpbiB0aGUgS0FTQU4gcmVwb3J0Lg0KPiANCj4gU2VlLCB0aGlzIGdpdmVzIGEgY2xl
YXIgY29udGV4dCwgYW4gZXhwbGFuYXRpb24gd2h5IGl0IGlzIHVzZWZ1bCBhbmQgYQ0KPiBoaWdo
IGxldmVsIGRlc2NyaXB0aW9uIG9mIHdoYXQgaXQgZG9lcy4gVGhlIGRldGFpbHMgYXJlIGluIHRo
ZSBwYXRjaA0KPiBpZnNlbGYgYW5kIGRvIG5vdCBoYXZlIHRvIGJlIGVweGxhaW5lZCBpbiB0aGUg
Y2hhbmdlbG9nLg0KPiANCg0KPiBGb3IgdGhlIHRlY2huaWNhbCBleHBsYW5hdGlvbiB3aGljaCB5
b3UgbmVlZCB0byBhZGQsIHlvdSByZWFsbHkgbmVlZCB0bw0KPiB0ZWxsIHdoYXQncyB0aGUgYWR2
YW50YWdlIG9yIGFkZGl0aW9uYWwgY292ZXJhZ2UgdnMuIGV4aXN0aW5nIGRlYnVnDQo+IGZhY2ls
aXRpZXMgbGlrZSBkZWJ1Z29iamVjdHMuIEp1c3QgY2xhaW1pbmcgdGhhdCBpdCdzIHVzZWZ1bCBk
b2VzIG5vdA0KPiBtYWtlIGFuIGFyZ3VtZW50Lg0KPiANCg0KDQoNCj4gVGhlIFVBRiBwcm9ibGVt
IHdpdGggdGltZXJzIGlzIG5hc3R5IGJlY2F1c2UgaWYgeW91IGZyZWUgYW4gYWN0aXZlIHRpbWVy
DQo+IHRoZW4gZWl0aGVyIHRoZSBzb2Z0aXJxIHdoaWNoIGV4cGlyZXMgdGhlIHRpbWVyIHdpbGwg
Y29ycnVwdCBwb3RlbnRpYWxseQ0KPiByZXVzZWQgbWVtb3J5IG9yIHRoZSByZXVzZSB3aWxsIGNv
cnJ1cHQgdGhlIGxpbmtlZCBsaXN0IHdoaWNoIG1ha2VzIHRoZQ0KPiBzb2Z0aXJxIG9yIHNvbWUg
dW5yZWxhdGVkIGNvZGUgd2hpY2ggYWRkcy9yZW1vdmVzIGEgZGlmZmVyZW50IHRpbWVyDQo+IGV4
cGxvZGUgaW4gdW5kZWJ1Z2dhYmxlIHdheXMuIGRlYnVnb2JqZWN0IHByZXZlbnRzIHRoYXQgYmVj
YXVzZSBpdA0KPiB0cmFja3MgcGVyIHRpbWVyIHN0YXRlIGFuZCBpbnZva2VzIHRoZSBmaXh1cCBm
dW5jdGlvbiB3aGljaCBrZWVwcyB0aGUNCj4gc3lzdGVtIGFsaXZlIGFuZCBhbHNvIHRlbGxzIHlv
dSBleGFjdGx5IHdoZXJlIHRoZSBmcmVlIG9mIHRoZSBhY3RpdmUNCj4gb2JqZWN0IGhhcHBlbnMg
d2hpY2ggaXMgdGhlIHJlYWxseSBpbnRlcmVzdGluZyBwbGFjZSB0byBsb29rIGF0LiBUaGUNCj4g
aW5pdCBmdW5jdGlvbiBpcyBwcmV0dHkgdW5pbnRlcmVzdGluZyBpbiB0aGF0IGNhc2UgYmVjYXVz
ZSB5b3UgcmVhbGx5DQo+IHdhbnQgdG8ga25vdyB3aGVyZSB0aGUgZnJlZWluZyBvZiB0aGUgYWN0
aXZlIG9iamVjdCBoYXBwZW5zLg0KPiANCg0KSXQgaXMgd2hhdCB3ZSB3YW50IHRvIGFjaGlldmUs
IG1heWJlIHdlIGhhdmUgc2hvcnRjb21pbmdzLCBidXQgbXkgcGF0Y2gNCg0KPiBTbyBpZiBLQVNB
TiBkZXRlY3RzIFVBRiBpbiB0aGUgdGltZXIgc29mdGlycSB0aGVuIHRoZSBpbml0IHRyYWNlIGlz
IG5vdA0KPiBnaXZpbmcgYW55IGluZm9ybWF0aW9uIGVzcGVjaWFsbHkgbm90IGluIGNhc2VzIHdo
ZXJlIHRoZSB0aW1lciBpcyBwYXJ0DQo+IG9mIGEgY29tbW9uIGFuZCBmcmVxdWVudGx5IGFsbG9j
YXRlZC9mcmVlZCBvdGhlciBkYXRhIHN0cnVjdHVyZS4NCj4gDQo+ID4gIHN0YXRpYyBpbmxpbmUg
dm9pZCBrYXNhbl9jYWNoZV9zaHJpbmsoc3RydWN0IGttZW1fY2FjaGUgKmNhY2hlKSB7fQ0KPiA+
ICBzdGF0aWMgaW5saW5lIHZvaWQga2FzYW5fY2FjaGVfc2h1dGRvd24oc3RydWN0IGttZW1fY2Fj
aGUgKmNhY2hlKSB7fQ0KPiA+ICBzdGF0aWMgaW5saW5lIHZvaWQga2FzYW5fcmVjb3JkX2F1eF9z
dGFjayh2b2lkICpwdHIpIHt9DQo+ID4gK3N0YXRpYyBpbmxpbmUgdm9pZCBrYXNhbl9yZWNvcmRf
dG1yX3N0YWNrKHZvaWQgKnB0cikge30NCj4gDQo+IER1aCwgc28geW91IGFyZSBhZGRpbmcgcGVy
IG9iamVjdCB0eXBlIGZ1bmN0aW9ucyBhbmQgc3RvcmFnZT8gVGhhdCdzDQo+IGdvaW5nIHRvIGJl
IGEgaHVnZSBjb3B5IGFuZCBwYXN0YSBvcmd5IGFzIGV2ZXJ5IG9iamVjdCByZXF1aXJlcyB0aGUg
c2FtZQ0KPiBjb2RlIGFuZCBleHRyYSBzdG9yYWdlIHNwYWNlLg0KPiANCj4gV2h5IG5vdCBqdXN0
IHVzaW5nIGthc2FuX3JlY29yZF9hdXhfc3RhY2soKSBmb3IgYWxsIG9mIHRoaXM/DQo+IA0KPiBU
aGUgJ2NhbGxfcmN1JyAndGltZXInICd3aGF0ZXZlciBuZXh0JyBwcmludG91dCBpcyBub3QgcmVh
bGx5IHJlcXVpcmVkDQo+IGJlY2F1c2UgdGhlIHN0YWNrIHRyYWNlIGFscmVhZHkgdGVsbHMgeW91
IHRoZSBmdW5jdGlvbiB3aGljaCB3YXMNCj4gaW52b2tlZC4gSWYgVE9TIGlzIGNhbGxfcmN1KCkg
b3IgZG9fdGltZXJfaW5pdCgpIHRoZW4gaXQncyBlbnRpcmVseQ0KPiBjbGVhciB3aGljaCBvYmpl
Y3QgaXMgYWZmZWN0ZWQuIElmIHRoZSB0d28gYXV4IHJlY29yZHMgYXJlIG5vdCBlbm91Z2gNCj4g
dGhlbiBtYWtpbmcgdGhlIGFycmF5IGxhcmdlciBpcyBub3QgdGhlIGVuZCBvZiB0aGUgd29ybGQu
DQo+IA0KPiA+ICAjZW5kaWYgLyogQ09ORklHX0tBU0FOX0dFTkVSSUMgKi8NCj4gPiAgDQo+ID4g
ZGlmZiAtLWdpdCBhL2tlcm5lbC90aW1lL3RpbWVyLmMgYi9rZXJuZWwvdGltZS90aW1lci5jDQo+
ID4gaW5kZXggYTUyMjFhYmI0NTk0Li5lZjJkYTlkZGZhYzcgMTAwNjQ0DQo+ID4gLS0tIGEva2Vy
bmVsL3RpbWUvdGltZXIuYw0KPiA+ICsrKyBiL2tlcm5lbC90aW1lL3RpbWVyLmMNCj4gPiBAQCAt
NzgzLDYgKzc4Myw4IEBAIHN0YXRpYyB2b2lkIGRvX2luaXRfdGltZXIoc3RydWN0IHRpbWVyX2xp
c3QgKnRpbWVyLA0KPiA+ICAJdGltZXItPmZ1bmN0aW9uID0gZnVuYzsNCj4gPiAgCXRpbWVyLT5m
bGFncyA9IGZsYWdzIHwgcmF3X3NtcF9wcm9jZXNzb3JfaWQoKTsNCj4gPiAgCWxvY2tkZXBfaW5p
dF9tYXAoJnRpbWVyLT5sb2NrZGVwX21hcCwgbmFtZSwga2V5LCAwKTsNCj4gPiArDQo+ID4gKwlr
YXNhbl9yZWNvcmRfdG1yX3N0YWNrKHRpbWVyKTsNCj4gPiAgfQ0KPiANCj4gQXJlIHlvdSBzdXJl
IHRoaXMgaXMgY29ycmVjdCBmb3IgYWxsIHRpbWVycz8NCj4gDQo+IFRoaXMgaXMgYWxzbyBjYWxs
ZWQgZm9yIHRpbWVycyB3aGljaCBhcmUgdGVtcG9yYXJpbHkgYWxsb2NhdGVkIG9uIHN0YWNrDQo+
IGFuZCBmb3IgdGltZXJzIHdoaWNoIGFyZSBzdGF0aWNhbGx5IGFsbG9jYXRlZCBhdCBjb21waWxl
IHRpbWUuIEhvdyBpcw0KPiB0aGF0IHN1cHBvc2VkIHRvIHdvcms/DQo+IA0KPiBUaGVzZSBraW5k
IG9mIHRoaW5ncyB3YW50IHRvIGJlIGV4cGxhaW5lZCB1cGZyb250IGFuIG5vdCBsZWZ0IHRvIHRo
ZQ0KPiByZXZpZXdlciBhcyBhbiBleGVyY2lzZS4NCj4gDQo+IFRoYW5rcywNCj4gDQo+ICAgICAg
ICAgdGdseA0KDQpJIGhhdmUgYWxyZWFkeSANCg0K

