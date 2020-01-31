Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45225C33C9E
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 02:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09184206F0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 02:07:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="t/kHqHbI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbgAaCFU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 21:05:20 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:48904 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727722AbgAaCFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 21:05:20 -0500
X-UUID: 24c37e8d9db44fb08dba1a6848d86912-20200131
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=eAN7TYSx5Ngnmh1dy1RUM0HJOBtCp5tpJodPVFhl6LQ=;
        b=t/kHqHbIsMuJDEtefMCvcLTmsW/5c4BBHLrMccFqL+IkVCD9EQGYsUxoeu3xExjhxaeLQeVc6JHic3PR8Th2tLKjUwCDhHw+oOtddmhwkThlVxzRWfvCm6SWd2aIudQTNypgISxPxIiwjIZsMgp3a3SAABvmQQATXNRZhwr6k0Y=;
X-UUID: 24c37e8d9db44fb08dba1a6848d86912-20200131
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1591912662; Fri, 31 Jan 2020 10:05:08 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 31 Jan 2020 10:04:23 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 31 Jan 2020 10:05:16 +0800
Message-ID: <1580436306.11126.16.camel@mtksdccf07>
Subject: Re: [PATCH v3] lib/stackdepot: Fix global out-of-bounds in
 stackdepot
From:   Walter Wu <walter-zh.wu@mediatek.com>
To:     Alexander Potapenko <glider@google.com>
CC:     Dmitry Vyukov <dvyukov@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Josh Poimboeuf" <jpoimboe@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>
Date:   Fri, 31 Jan 2020 10:05:06 +0800
In-Reply-To: <CAG_fn=X_jSUJXD932z9oN5hBa--n3Qct4zrjzGaPtb2MwJye7A@mail.gmail.com>
References: <20200130064430.17198-1-walter-zh.wu@mediatek.com>
         <CAG_fn=X_jSUJXD932z9oN5hBa--n3Qct4zrjzGaPtb2MwJye7A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIwLTAxLTMwIGF0IDEzOjAzICswMTAwLCBBbGV4YW5kZXIgUG90YXBlbmtvIHdy
b3RlOg0KPiBPbiBUaHUsIEphbiAzMCwgMjAyMCBhdCA3OjQ0IEFNIFdhbHRlciBXdSA8d2FsdGVy
LXpoLnd1QG1lZGlhdGVrLmNvbT4gd3JvdGU6DQo+IA0KPiBIaSBXYWx0ZXIsDQo+IA0KPiA+IElm
IHRoZSBkZXBvdF9pbmRleCA9IFNUQUNLX0FMTE9DX01BWF9TTEFCUyAtIDIgYW5kIG5leHRfc2xh
Yl9pbml0ZWQgPSAwLA0KPiA+IHRoZW4gaXQgd2lsbCBjYXVzZSBhcnJheSBvdXQtb2YtYm91bmRz
IGFjY2Vzcywgc28gdGhhdCB3ZSBzaG91bGQgbW9kaWZ5DQo+ID4gdGhlIGRldGVjdGlvbiB0byBh
dm9pZCB0aGlzIGFycmF5IG91dC1vZi1ib3VuZHMgYnVnLg0KPiA+DQo+ID4gQXNzdW1lIGRlcG90
X2luZGV4ID0gU1RBQ0tfQUxMT0NfTUFYX1NMQUJTIC0gMw0KPiA+IENvbnNpZGVyIGZvbGxvd2lu
ZyBjYWxsIGZsb3cgc2VxdWVuY2U6DQo+ID4NCj4gPiBzdGFja19kZXBvdF9zYXZlKCkNCj4gPiAg
ICBkZXBvdF9hbGxvY19zdGFjaygpDQo+ID4gICAgICAgaWYgKHVubGlrZWx5KGRlcG90X2luZGV4
ICsgMSA+PSBTVEFDS19BTExPQ19NQVhfU0xBQlMpKSAvL3Bhc3MNCj4gPiAgICAgICBkZXBvdF9p
bmRleCsrICAvL2RlcG90X2luZGV4ID0gU1RBQ0tfQUxMT0NfTUFYX1NMQUJTIC0gMg0KPiA+ICAg
ICAgIGlmIChkZXBvdF9pbmRleCArIDEgPCBTVEFDS19BTExPQ19NQVhfU0xBQlMpIC8vZW50ZXIN
Cj4gPiAgICAgICAgICBzbXBfc3RvcmVfcmVsZWFzZSgmbmV4dF9zbGFiX2luaXRlZCwgMCk7IC8v
bmV4dF9zbGFiX2luaXRlZCA9IDANCj4gPiAgICAgICBpbml0X3N0YWNrX3NsYWIoKQ0KPiA+ICAg
ICAgICAgIGlmIChzdGFja19zbGFic1tkZXBvdF9pbmRleF0gPT0gTlVMTCkgLy9lbnRlciBhbmQg
ZXhpdA0KPiA+DQo+ID4gc3RhY2tfZGVwb3Rfc2F2ZSgpDQo+ID4gICAgZGVwb3RfYWxsb2Nfc3Rh
Y2soKQ0KPiA+ICAgICAgIGlmICh1bmxpa2VseShkZXBvdF9pbmRleCArIDEgPj0gU1RBQ0tfQUxM
T0NfTUFYX1NMQUJTKSkgLy9wYXNzDQo+ID4gICAgICAgZGVwb3RfaW5kZXgrKyAgLy9kZXBvdF9p
bmRleCA9IFNUQUNLX0FMTE9DX01BWF9TTEFCUyAtIDENCj4gPiAgICAgICBpbml0X3N0YWNrX3Ns
YWIoJnByZWFsbG9jKQ0KPiA+ICAgICAgICAgIHN0YWNrX3NsYWJzW2RlcG90X2luZGV4ICsgMV0g
IC8vaGVyZSBnZXQgZ2xvYmFsIG91dC1vZi1ib3VuZHMNCj4gPg0KPiA+IENjOiBEbWl0cnkgVnl1
a292IDxkdnl1a292QGdvb2dsZS5jb20+DQo+ID4gQ2M6IE1hdHRoaWFzIEJydWdnZXIgPG1hdHRo
aWFzLmJnZ0BnbWFpbC5jb20+DQo+ID4gQ2M6IFRob21hcyBHbGVpeG5lciA8dGdseEBsaW51dHJv
bml4LmRlPg0KPiA+IENjOiBBbGV4YW5kZXIgUG90YXBlbmtvIDxnbGlkZXJAZ29vZ2xlLmNvbT4N
Cj4gPiBDYzogSm9zaCBQb2ltYm9ldWYgPGpwb2ltYm9lQHJlZGhhdC5jb20+DQo+ID4gQ2M6IEth
dGUgU3Rld2FydCA8a3N0ZXdhcnRAbGludXhmb3VuZGF0aW9uLm9yZz4NCj4gPiBDYzogR3JlZyBL
cm9haC1IYXJ0bWFuIDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz4NCj4gPiBDYzogS2F0ZSBT
dGV3YXJ0IDxrc3Rld2FydEBsaW51eGZvdW5kYXRpb24ub3JnPg0KPiA+IFNpZ25lZC1vZmYtYnk6
IFdhbHRlciBXdSA8d2FsdGVyLXpoLnd1QG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiBjaGFu
Z2VzIGluIHYyOg0KPiA+IG1vZGlmeSBjYWxsIGZsb3cgc2VxdWVuY2UgYW5kIHByZWNvbmRpdG9u
DQo+ID4NCj4gPiBjaGFuZ2VzIGluIHYzOg0KPiA+IGFkZCBzb21lIHJldmlld2Vycw0KPiA+IC0t
LQ0KPiA+ICBsaWIvc3RhY2tkZXBvdC5jIHwgMiArLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBp
bnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9saWIvc3Rh
Y2tkZXBvdC5jIGIvbGliL3N0YWNrZGVwb3QuYw0KPiA+IGluZGV4IGVkNzE3ZGQwOGZmMy4uN2U4
YTE1ZTQxNjAwIDEwMDY0NA0KPiA+IC0tLSBhL2xpYi9zdGFja2RlcG90LmMNCj4gPiArKysgYi9s
aWIvc3RhY2tkZXBvdC5jDQo+ID4gQEAgLTEwNiw3ICsxMDYsNyBAQCBzdGF0aWMgc3RydWN0IHN0
YWNrX3JlY29yZCAqZGVwb3RfYWxsb2Nfc3RhY2sodW5zaWduZWQgbG9uZyAqZW50cmllcywgaW50
IHNpemUsDQo+ID4gICAgICAgICByZXF1aXJlZF9zaXplID0gQUxJR04ocmVxdWlyZWRfc2l6ZSwg
MSA8PCBTVEFDS19BTExPQ19BTElHTik7DQo+ID4NCj4gPiAgICAgICAgIGlmICh1bmxpa2VseShk
ZXBvdF9vZmZzZXQgKyByZXF1aXJlZF9zaXplID4gU1RBQ0tfQUxMT0NfU0laRSkpIHsNCj4gPiAt
ICAgICAgICAgICAgICAgaWYgKHVubGlrZWx5KGRlcG90X2luZGV4ICsgMSA+PSBTVEFDS19BTExP
Q19NQVhfU0xBQlMpKSB7DQo+ID4gKyAgICAgICAgICAgICAgIGlmICh1bmxpa2VseShkZXBvdF9p
bmRleCArIDIgPj0gU1RBQ0tfQUxMT0NfTUFYX1NMQUJTKSkgew0KPiANCj4gSSBkb24ndCB0aGlu
ayB0aGlzIGlzIHRoZSByaWdodCB3YXkgdG8gZml4IHRoZSBwcm9ibGVtLg0KPiBZb3UncmUgYmFz
aWNhbGx5IHRocm93aW5nIGF3YXkgdGhlIGxhc3QgZWxlbWVudCBvZiBzdGFja19zbGFic1tdLCBh
cw0KPiB3ZSB3b24ndCBhbGxvY2F0ZSBhbnl0aGluZyBmcm9tIGl0Lg0KPiANCm9rLCBJIGFncmVl
Lg0KIA0KPiBIb3cgYWJvdXQgd2Ugc2V0IHxuZXh0X3NsYWJfaW5pdGVkfCB0byAxIGhlcmU6DQo+
IA0KPiBkaWZmIC0tZ2l0IGEvbGliL3N0YWNrZGVwb3QuYyBiL2xpYi9zdGFja2RlcG90LmMNCj4g
aW5kZXggMmU3ZDIyMzJlZDNjLi45NDNhNTFlYjc0NmQgMTAwNjQ0DQo+IC0tLSBhL2xpYi9zdGFj
a2RlcG90LmMNCj4gKysrIGIvbGliL3N0YWNrZGVwb3QuYw0KPiBAQCAtMTA1LDYgKzEwNSw4IEBA
IHN0YXRpYyBib29sIGluaXRfc3RhY2tfc2xhYih2b2lkICoqcHJlYWxsb2MpDQo+ICAgICAgICAg
ICAgICAgICByZXR1cm4gdHJ1ZTsNCj4gICAgICAgICBpZiAoc3RhY2tfc2xhYnNbZGVwb3RfaW5k
ZXhdID09IE5VTEwpIHsNCj4gICAgICAgICAgICAgICAgIHN0YWNrX3NsYWJzW2RlcG90X2luZGV4
XSA9ICpwcmVhbGxvYzsNCj4gKyAgICAgICAgICAgICAgIGlmIChkZXBvdF9pbmRleCArIDEgPT0g
U1RBQ0tfQUxMT0NfTUFYX1NMQUJTKQ0KPiArICAgICAgICAgICAgICAgICAgICAgICBzbXBfc3Rv
cmVfcmVsZWFzZSgmbmV4dF9zbGFiX2luaXRlZCwgMSk7DQo+ICAgICAgICAgfSBlbHNlIHsNCj4g
ICAgICAgICAgICAgICAgIHN0YWNrX3NsYWJzW2RlcG90X2luZGV4ICsgMV0gPSAqcHJlYWxsb2M7
DQo+ICAgICAgICAgICAgICAgICAvKg0KPiANCj4gVGhpcyB3aWxsIGVuc3VyZSB3ZSB3b24ndCBi
ZSBwcmVhbGxvY2F0aW5nIHBhZ2VzIG9uY2UgfGRlcG90X2luZGV4fA0KPiByZWFjaGVzIHRoZSBs
YXN0IGVsZW1lbnQsIGFuZCB3ZSB3b24ndCBhdHRlbXB0IHRvIHdyaXRlIHRob3NlIHBhZ2VzDQo+
IGFueXdoZXJlIGVpdGhlci4NCj4gDQo+IENvdWxkIHlvdSBwbGVhc2UgY2hlY2sgaWYgdGhpcyBm
aXhlcyB0aGUgcHJvYmxlbSBmb3IgeW91Pw0KPiANCkNvbnNpZGVyIGFib3ZlIGNhbGwgZmxvdyBz
ZXF1ZW5jZSBhdCBmaXJzdCBzdGFja19kZXBvdF9zYXZlKCksDQpkZXBvdF9pbmRleCA9IFNUQUNL
X0FMTE9DX01BWF9TTEFCUyAtIDIgYmVmb3JlIGVudGVyIGluaXRfc3RhY2tfc2xhYigpLA0Kc28g
dGhlIGZpeGVzIHNob3VsZCBiZSBiZWxvdy4NCg0KLS0tIGEvbGliL3N0YWNrZGVwb3QuYw0KKysr
IGIvbGliL3N0YWNrZGVwb3QuYw0KQEAgLTgzLDYgKzgzLDggQEAgc3RhdGljIGJvb2wgaW5pdF9z
dGFja19zbGFiKHZvaWQgKipwcmVhbGxvYykNCiAgICAgICAgICAgICAgICByZXR1cm4gdHJ1ZTsN
CiAgICAgICAgaWYgKHN0YWNrX3NsYWJzW2RlcG90X2luZGV4XSA9PSBOVUxMKSB7DQogICAgICAg
ICAgICAgICAgc3RhY2tfc2xhYnNbZGVwb3RfaW5kZXhdID0gKnByZWFsbG9jOw0KKyAgICAgICAg
ICAgICAgIGlmIChkZXBvdF9pbmRleCArIDIgPT0gU1RBQ0tfQUxMT0NfTUFYX1NMQUJTKQ0KKyAg
ICAgICAgICAgICAgICAgICAgICAgc21wX3N0b3JlX3JlbGVhc2UoJm5leHRfc2xhYl9pbml0ZWQs
IDEpOw0KICAgICAgICB9IGVsc2Ugew0KICAgICAgICAgICAgICAgIHN0YWNrX3NsYWJzW2RlcG90
X2luZGV4ICsgMV0gPSAqcHJlYWxsb2M7DQogICAgICAgICAgICAgICAgLyoNCg0KDQo+ID4gICAg
ICAgICAgICAgICAgICAgICAgICAgV0FSTl9PTkNFKDEsICJTdGFjayBkZXBvdCByZWFjaGVkIGxp
bWl0IGNhcGFjaXR5Iik7DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIE5VTEw7
DQo+ID4gICAgICAgICAgICAgICAgIH0NCj4gPiAtLQ0KPiA+IDIuMTguMA0KPiANCj4gDQo+IA0K
DQo=

