Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E8EC35249
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 02:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7104420661
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 02:06:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="KfUoiozT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbgBCCFv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Feb 2020 21:05:51 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:10826 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727164AbgBCCFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Feb 2020 21:05:51 -0500
X-UUID: 71469db80d4c4a238448bf648b9e4005-20200203
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=NWarxv3wt0FpySWansQ4rSsY2Q9gQTyzvXi1iyPbHi8=;
        b=KfUoiozTl+xGCm0GvD2XneP2ZVmfO9bJxcTfBM2JruQjmJZ1UvKGiyqhkMYm+fkaIfIB0g/b5Cuza/pnklo4z2bfFbDmN8aPj2PCKlrwrrwwag+qhlrwN6PLt3xe+Qw07XnRaAGHXI6dV1VgoKw8s8Nrz4KWd0ipsaMxytotsBo=;
X-UUID: 71469db80d4c4a238448bf648b9e4005-20200203
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1162479976; Mon, 03 Feb 2020 10:05:46 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 3 Feb 2020 10:05:06 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 3 Feb 2020 10:05:30 +0800
Message-ID: <1580695544.17006.7.camel@mtksdccf07>
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
Date:   Mon, 3 Feb 2020 10:05:44 +0800
In-Reply-To: <CAG_fn=X2V0nL=+s38bDbS3UXf2_i61tSevd8vzkV-ZKY=7MHvw@mail.gmail.com>
References: <20200130064430.17198-1-walter-zh.wu@mediatek.com>
         <CAG_fn=X_jSUJXD932z9oN5hBa--n3Qct4zrjzGaPtb2MwJye7A@mail.gmail.com>
         <1580436306.11126.16.camel@mtksdccf07>
         <CAG_fn=X2V0nL=+s38bDbS3UXf2_i61tSevd8vzkV-ZKY=7MHvw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIwLTAxLTMxIGF0IDE5OjExICswMTAwLCBBbGV4YW5kZXIgUG90YXBlbmtvIHdy
b3RlOg0KPiBPbiBGcmksIEphbiAzMSwgMjAyMCBhdCAzOjA1IEFNIFdhbHRlciBXdSA8d2FsdGVy
LXpoLnd1QG1lZGlhdGVrLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBPbiBUaHUsIDIwMjAtMDEtMzAg
YXQgMTM6MDMgKzAxMDAsIEFsZXhhbmRlciBQb3RhcGVua28gd3JvdGU6DQo+ID4gPiBPbiBUaHUs
IEphbiAzMCwgMjAyMCBhdCA3OjQ0IEFNIFdhbHRlciBXdSA8d2FsdGVyLXpoLnd1QG1lZGlhdGVr
LmNvbT4gd3JvdGU6DQo+ID4gPg0KPiA+ID4gSGkgV2FsdGVyLA0KPiA+ID4NCj4gPiA+ID4gSWYg
dGhlIGRlcG90X2luZGV4ID0gU1RBQ0tfQUxMT0NfTUFYX1NMQUJTIC0gMiBhbmQgbmV4dF9zbGFi
X2luaXRlZCA9IDAsDQo+ID4gPiA+IHRoZW4gaXQgd2lsbCBjYXVzZSBhcnJheSBvdXQtb2YtYm91
bmRzIGFjY2Vzcywgc28gdGhhdCB3ZSBzaG91bGQgbW9kaWZ5DQo+ID4gPiA+IHRoZSBkZXRlY3Rp
b24gdG8gYXZvaWQgdGhpcyBhcnJheSBvdXQtb2YtYm91bmRzIGJ1Zy4NCj4gPiA+ID4NCj4gPiA+
ID4gQXNzdW1lIGRlcG90X2luZGV4ID0gU1RBQ0tfQUxMT0NfTUFYX1NMQUJTIC0gMw0KPiA+ID4g
PiBDb25zaWRlciBmb2xsb3dpbmcgY2FsbCBmbG93IHNlcXVlbmNlOg0KPiA+ID4gPg0KPiA+ID4g
PiBzdGFja19kZXBvdF9zYXZlKCkNCj4gPiA+ID4gICAgZGVwb3RfYWxsb2Nfc3RhY2soKQ0KPiA+
ID4gPiAgICAgICBpZiAodW5saWtlbHkoZGVwb3RfaW5kZXggKyAxID49IFNUQUNLX0FMTE9DX01B
WF9TTEFCUykpIC8vcGFzcw0KPiA+ID4gPiAgICAgICBkZXBvdF9pbmRleCsrICAvL2RlcG90X2lu
ZGV4ID0gU1RBQ0tfQUxMT0NfTUFYX1NMQUJTIC0gMg0KPiA+ID4gPiAgICAgICBpZiAoZGVwb3Rf
aW5kZXggKyAxIDwgU1RBQ0tfQUxMT0NfTUFYX1NMQUJTKSAvL2VudGVyDQo+ID4gPiA+ICAgICAg
ICAgIHNtcF9zdG9yZV9yZWxlYXNlKCZuZXh0X3NsYWJfaW5pdGVkLCAwKTsgLy9uZXh0X3NsYWJf
aW5pdGVkID0gMA0KPiA+ID4gPiAgICAgICBpbml0X3N0YWNrX3NsYWIoKQ0KPiA+ID4gPiAgICAg
ICAgICBpZiAoc3RhY2tfc2xhYnNbZGVwb3RfaW5kZXhdID09IE5VTEwpIC8vZW50ZXIgYW5kIGV4
aXQNCj4gPiA+ID4NCj4gPiA+ID4gc3RhY2tfZGVwb3Rfc2F2ZSgpDQo+ID4gPiA+ICAgIGRlcG90
X2FsbG9jX3N0YWNrKCkNCj4gPiA+ID4gICAgICAgaWYgKHVubGlrZWx5KGRlcG90X2luZGV4ICsg
MSA+PSBTVEFDS19BTExPQ19NQVhfU0xBQlMpKSAvL3Bhc3MNCj4gPiA+ID4gICAgICAgZGVwb3Rf
aW5kZXgrKyAgLy9kZXBvdF9pbmRleCA9IFNUQUNLX0FMTE9DX01BWF9TTEFCUyAtIDENCj4gPiA+
ID4gICAgICAgaW5pdF9zdGFja19zbGFiKCZwcmVhbGxvYykNCj4gPiA+ID4gICAgICAgICAgc3Rh
Y2tfc2xhYnNbZGVwb3RfaW5kZXggKyAxXSAgLy9oZXJlIGdldCBnbG9iYWwgb3V0LW9mLWJvdW5k
cw0KPiA+ID4gPg0KPiA+ID4gPiBDYzogRG1pdHJ5IFZ5dWtvdiA8ZHZ5dWtvdkBnb29nbGUuY29t
Pg0KPiA+ID4gPiBDYzogTWF0dGhpYXMgQnJ1Z2dlciA8bWF0dGhpYXMuYmdnQGdtYWlsLmNvbT4N
Cj4gPiA+ID4gQ2M6IFRob21hcyBHbGVpeG5lciA8dGdseEBsaW51dHJvbml4LmRlPg0KPiA+ID4g
PiBDYzogQWxleGFuZGVyIFBvdGFwZW5rbyA8Z2xpZGVyQGdvb2dsZS5jb20+DQo+ID4gPiA+IENj
OiBKb3NoIFBvaW1ib2V1ZiA8anBvaW1ib2VAcmVkaGF0LmNvbT4NCj4gPiA+ID4gQ2M6IEthdGUg
U3Rld2FydCA8a3N0ZXdhcnRAbGludXhmb3VuZGF0aW9uLm9yZz4NCj4gPiA+ID4gQ2M6IEdyZWcg
S3JvYWgtSGFydG1hbiA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+DQo+ID4gPiA+IENjOiBL
YXRlIFN0ZXdhcnQgPGtzdGV3YXJ0QGxpbnV4Zm91bmRhdGlvbi5vcmc+DQo+ID4gPiA+IFNpZ25l
ZC1vZmYtYnk6IFdhbHRlciBXdSA8d2FsdGVyLXpoLnd1QG1lZGlhdGVrLmNvbT4NCj4gPiA+ID4g
LS0tDQo+ID4gPiA+IGNoYW5nZXMgaW4gdjI6DQo+ID4gPiA+IG1vZGlmeSBjYWxsIGZsb3cgc2Vx
dWVuY2UgYW5kIHByZWNvbmRpdG9uDQo+ID4gPiA+DQo+ID4gPiA+IGNoYW5nZXMgaW4gdjM6DQo+
ID4gPiA+IGFkZCBzb21lIHJldmlld2Vycw0KPiA+ID4gPiAtLS0NCj4gPiA+ID4gIGxpYi9zdGFj
a2RlcG90LmMgfCAyICstDQo+ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyks
IDEgZGVsZXRpb24oLSkNCj4gPiA+ID4NCj4gPiA+ID4gZGlmZiAtLWdpdCBhL2xpYi9zdGFja2Rl
cG90LmMgYi9saWIvc3RhY2tkZXBvdC5jDQo+ID4gPiA+IGluZGV4IGVkNzE3ZGQwOGZmMy4uN2U4
YTE1ZTQxNjAwIDEwMDY0NA0KPiA+ID4gPiAtLS0gYS9saWIvc3RhY2tkZXBvdC5jDQo+ID4gPiA+
ICsrKyBiL2xpYi9zdGFja2RlcG90LmMNCj4gPiA+ID4gQEAgLTEwNiw3ICsxMDYsNyBAQCBzdGF0
aWMgc3RydWN0IHN0YWNrX3JlY29yZCAqZGVwb3RfYWxsb2Nfc3RhY2sodW5zaWduZWQgbG9uZyAq
ZW50cmllcywgaW50IHNpemUsDQo+ID4gPiA+ICAgICAgICAgcmVxdWlyZWRfc2l6ZSA9IEFMSUdO
KHJlcXVpcmVkX3NpemUsIDEgPDwgU1RBQ0tfQUxMT0NfQUxJR04pOw0KPiA+ID4gPg0KPiA+ID4g
PiAgICAgICAgIGlmICh1bmxpa2VseShkZXBvdF9vZmZzZXQgKyByZXF1aXJlZF9zaXplID4gU1RB
Q0tfQUxMT0NfU0laRSkpIHsNCj4gPiA+ID4gLSAgICAgICAgICAgICAgIGlmICh1bmxpa2VseShk
ZXBvdF9pbmRleCArIDEgPj0gU1RBQ0tfQUxMT0NfTUFYX1NMQUJTKSkgew0KPiA+ID4gPiArICAg
ICAgICAgICAgICAgaWYgKHVubGlrZWx5KGRlcG90X2luZGV4ICsgMiA+PSBTVEFDS19BTExPQ19N
QVhfU0xBQlMpKSB7DQo+IA0KPiBUaGlzIGFnYWluIG1lYW5zIHN0YWNrX3NsYWJzW1NUQUNLX0FM
TE9DX01BWF9TTEFCUyAtIDJdIGdldHMNCj4gaW5pdGlhbGl6ZWQsIGJ1dCBzdGFja19zbGFic1tT
VEFDS19BTExPQ19NQVhfU0xBQlMgLSAxXSBkb2Vzbid0LA0KPiBiZWNhdXNlIHdlJ2xsIGJlIGJh
aWxpbmcgb3V0IGZyb20gaW5pdF9zdGFja19zbGFiKCkgZnJvbSBub3cgb24uDQo+IERvZXMgdGhp
cyBwYXRjaCBhY3R1YWxseSBmaXggdGhlIHByb2JsZW0gKGRvIHlvdSBoYXZlIGEgcmVsaWFibGUg
cmVwcm9kdWNlcj8pDQpXZSBnZXQgaXQgYnkgcmV2aWV3aW5nIGNvZGUsIGJlY2F1c2UgS2FzYW4g
ZG9lc24ndCBzY2FuIGl0IGFuZCB3ZSBjYXRjaA0KYW5vdGhlciBidWcgaW50ZXJuYWxseSwgd2Ug
Zm91bmQgaXQgdW5pbnRlbnRpb25hbGx5Lg0KDQo+IFRoaXMgYWRkaXRpb24gb2YgMiBpcyBhbHNv
IGNvdW50ZXJpbnR1aXRpdmUsIEkgZG9uJ3QgdGhpbmsgZnVydGhlcg0KPiByZWFkZXJzIHdpbGwg
dW5kZXJzdGFuZCB0aGUgbG9naWMgYmVoaW5kIGl0Lg0KPiANClllcw0KDQo+IFdoYXQgaWYgd2Ug
anVzdCBjaGVjayB0aGF0IGRlcG90X2luZGV4ICsgMSBpcyBhIHZhbGlkIGluZGV4IGJlZm9yZSBh
Y2Nlc3NpbmcgaXQ/DQo+IA0KSXQgc2hvdWxkIGZpeCB0aGUgcHJvYmxlbSwgZG8geW91IHdhbnQg
dG8gc2VuZCB0aGlzIHBhdGNoPw0KDQo+IGRpZmYgLS1naXQgYS9saWIvc3RhY2tkZXBvdC5jIGIv
bGliL3N0YWNrZGVwb3QuYw0KPiBpbmRleCAyZTdkMjIzMmVkM2MuLmMyZTZmZjE4ZDcxNiAxMDA2
NDQNCj4gLS0tIGEvbGliL3N0YWNrZGVwb3QuYw0KPiArKysgYi9saWIvc3RhY2tkZXBvdC5jDQo+
IEBAIC0xMDYsNyArMTA2LDkgQEAgc3RhdGljIGJvb2wgaW5pdF9zdGFja19zbGFiKHZvaWQgKipw
cmVhbGxvYykNCj4gICAgICAgICBpZiAoc3RhY2tfc2xhYnNbZGVwb3RfaW5kZXhdID09IE5VTEwp
IHsNCj4gICAgICAgICAgICAgICAgIHN0YWNrX3NsYWJzW2RlcG90X2luZGV4XSA9ICpwcmVhbGxv
YzsNCj4gICAgICAgICB9IGVsc2Ugew0KPiAtICAgICAgICAgICAgICAgc3RhY2tfc2xhYnNbZGVw
b3RfaW5kZXggKyAxXSA9ICpwcmVhbGxvYzsNCj4gKyAgICAgICAgICAgICAgIC8qIElmIHRoaXMg
aXMgdGhlIGxhc3QgZGVwb3Qgc2xhYiwgZG8gbm90IHRvdWNoIHRoZSBuZXh0IG9uZS4gKi8NCj4g
KyAgICAgICAgICAgICAgIGlmIChkZXBvdF9pbmRleCArIDEgPCBTVEFDS19BTExPQ19NQVhfU0xB
QlMpDQo+ICsgICAgICAgICAgICAgICAgICAgICAgIHN0YWNrX3NsYWJzW2RlcG90X2luZGV4ICsg
MV0gPSAqcHJlYWxsb2M7DQo+ICAgICAgICAgICAgICAgICAvKg0KPiAgICAgICAgICAgICAgICAg
ICogVGhpcyBzbXBfc3RvcmVfcmVsZWFzZSBwYWlycyB3aXRoIHNtcF9sb2FkX2FjcXVpcmUoKSBm
cm9tDQo+ICAgICAgICAgICAgICAgICAgKiB8bmV4dF9zbGFiX2luaXRlZHwgYWJvdmUgYW5kIGlu
IHN0YWNrX2RlcG90X3NhdmUoKS4NCg0K

