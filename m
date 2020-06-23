Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67865C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 08:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FB7C2072E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 08:09:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="tbtPgDHs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731709AbgFWII6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 04:08:58 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:11690 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731677AbgFWII6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 04:08:58 -0400
X-UUID: 0ebb0f637b2f453fb30c8e70f9946db1-20200623
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=2JUe8k4H2JAIMhaQ+KEJKU5IVfrqr7nlfFcnjCydfXU=;
        b=tbtPgDHsmiVcG7fEhW7wxxMDYtmH/s+3tO76M9R2zUU1hPiS3q3QsYHjarQ4xHVU9nXLYe2sVcUQh/Bg3s1qlnSaNOiyZaFJNXHsN33eUpv7FZ/eTIPA+a++56zDV+t+wG072vNBjXpRjkNdaBOPEJH47Z0FriWOGzK168DSFTA=;
X-UUID: 0ebb0f637b2f453fb30c8e70f9946db1-20200623
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1981792401; Tue, 23 Jun 2020 16:08:53 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 23 Jun 2020 16:08:45 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 23 Jun 2020 16:08:45 +0800
Message-ID: <1592899732.13735.8.camel@mtksdccf07>
Subject: Re: [PATCH v7 0/4] kasan: memorize and print call_rcu stack
From:   Walter Wu <walter-zh.wu@mediatek.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Andrey Konovalov" <andreyknvl@google.com>,
        <kasan-dev@googlegroups.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        "Andrey Ryabinin" <aryabinin@virtuozzo.com>
Date:   Tue, 23 Jun 2020 16:08:52 +0800
In-Reply-To: <20200601050847.1096-1-walter-zh.wu@mediatek.com>
References: <20200601050847.1096-1-walter-zh.wu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIwLTA2LTAxIGF0IDEzOjA4ICswODAwLCBXYWx0ZXIgV3Ugd3JvdGU6DQo+IFRo
aXMgcGF0Y2hzZXQgaW1wcm92ZXMgS0FTQU4gcmVwb3J0cyBieSBtYWtpbmcgdGhlbSB0byBoYXZl
DQo+IGNhbGxfcmN1KCkgY2FsbCBzdGFjayBpbmZvcm1hdGlvbi4gSXQgaXMgdXNlZnVsIGZvciBw
cm9ncmFtbWVycw0KPiB0byBzb2x2ZSB1c2UtYWZ0ZXItZnJlZSBvciBkb3VibGUtZnJlZSBtZW1v
cnkgaXNzdWUuDQo+IA0KPiBUaGUgS0FTQU4gcmVwb3J0IHdhcyBhcyBmb2xsb3dzKGNsZWFuZWQg
dXAgc2xpZ2h0bHkpOg0KPiANCj4gQlVHOiBLQVNBTjogdXNlLWFmdGVyLWZyZWUgaW4ga2FzYW5f
cmN1X3JlY2xhaW0rMHg1OC8weDYwDQo+IA0KPiBGcmVlZCBieSB0YXNrIDA6DQo+ICBrYXNhbl9z
YXZlX3N0YWNrKzB4MjQvMHg1MA0KPiAga2FzYW5fc2V0X3RyYWNrKzB4MjQvMHgzOA0KPiAga2Fz
YW5fc2V0X2ZyZWVfaW5mbysweDE4LzB4MjANCj4gIF9fa2FzYW5fc2xhYl9mcmVlKzB4MTBjLzB4
MTcwDQo+ICBrYXNhbl9zbGFiX2ZyZWUrMHgxMC8weDE4DQo+ICBrZnJlZSsweDk4LzB4MjcwDQo+
ICBrYXNhbl9yY3VfcmVjbGFpbSsweDFjLzB4NjANCj4gDQo+IExhc3QgY2FsbF9yY3UoKToNCj4g
IGthc2FuX3NhdmVfc3RhY2srMHgyNC8weDUwDQo+ICBrYXNhbl9yZWNvcmRfYXV4X3N0YWNrKzB4
YmMvMHhkMA0KPiAgY2FsbF9yY3UrMHg4Yy8weDU4MA0KPiAga2FzYW5fcmN1X3VhZisweGY0LzB4
ZjgNCj4gDQo+IEdlbmVyaWMgS0FTQU4gd2lsbCByZWNvcmQgdGhlIGxhc3QgdHdvIGNhbGxfcmN1
KCkgY2FsbCBzdGFja3MgYW5kDQo+IHByaW50IHVwIHRvIDIgY2FsbF9yY3UoKSBjYWxsIHN0YWNr
cyBpbiBLQVNBTiByZXBvcnQuIGl0IGlzIG9ubHkNCj4gc3VpdGFibGUgZm9yIGdlbmVyaWMgS0FT
QU4uDQo+IA0KPiBUaGlzIGZlYXR1cmUgY29uc2lkZXJzIHRoZSBzaXplIG9mIHN0cnVjdCBrYXNh
bl9hbGxvY19tZXRhIGFuZA0KPiBrYXNhbl9mcmVlX21ldGEsIHdlIHRyeSB0byBvcHRpbWl6ZSB0
aGUgc3RydWN0dXJlIGxheW91dCBhbmQgc2l6ZQ0KPiAsIGxldHMgaXQgZ2V0IGJldHRlciBtZW1v
cnkgY29uc3VtcHRpb24uDQo+IA0KPiBbMV1odHRwczovL2J1Z3ppbGxhLmtlcm5lbC5vcmcvc2hv
d19idWcuY2dpP2lkPTE5ODQzNw0KPiBbMl1odHRwczovL2dyb3Vwcy5nb29nbGUuY29tL2ZvcnVt
LyMhc2VhcmNoaW4va2FzYW4tZGV2L2JldHRlciQyMHN0YWNrJDIwdHJhY2VzJDIwZm9yJDIwcmN1
JTdDc29ydDpkYXRlL2thc2FuLWRldi9LUXNqVF84OGhERS83ck5VWnByUkJnQUoNCj4gDQo+IENo
YW5nZXMgc2luY2UgdjE6DQo+IC0gcmVtb3ZlIG5ldyBjb25maWcgb3B0aW9uLCBkZWZhdWx0IGVu
YWJsZSBpdCBpbiBnZW5lcmljIEtBU0FODQo+IC0gdGVzdCB0aGlzIGZlYXR1cmUgaW4gU0xBQi9T
TFVCLCBpdCBpcyBwYXNzLg0KPiAtIG1vZGlmeSBtYWNybyB0byBiZSBtb3JlIGNsZWFybHkNCj4g
LSBtb2RpZnkgZG9jdW1lbnRhdGlvbg0KPiANCj4gQ2hhbmdlcyBzaW5jZSB2MjoNCj4gLSBjaGFu
Z2UgcmVjb3JkaW5nIGZyb20gZmlyc3QvbGFzdCB0byB0aGUgbGFzdCB0d28gY2FsbCBzdGFja3MN
Cj4gLSBtb3ZlIGZyZWUgdHJhY2sgaW50byBrYXNhbiBmcmVlIG1ldGENCj4gLSBpbml0IHNsYWJf
ZnJlZV9tZXRhIG9uIG9iamVjdCBzbG90IGNyZWF0aW9uDQo+IC0gbW9kaWZ5IGRvY3VtZW50YXRp
b24NCj4gDQo+IENoYW5nZXMgc2luY2UgdjM6DQo+IC0gY2hhbmdlIHZhcmlhYmxlIG5hbWUgdG8g
YmUgbW9yZSBjbGVhcmx5DQo+IC0gcmVtb3ZlIHRoZSByZWR1bmRhbnQgY29uZGl0aW9uDQo+IC0g
cmVtb3ZlIGluaXQgZnJlZSBtZXRhLWRhdGEgYW5kIGluY3JlYXNpbmcgb2JqZWN0IGNvbmRpdGlv
bg0KPiANCj4gQ2hhbmdlcyBzaW5jZSB2NDoNCj4gLSBhZGQgYSBtYWNybyBLQVNBTl9LTUFMTE9D
X0ZSRUVUUkFDSyBpbiBvcmRlciB0byBjaGVjayB3aGV0aGVyDQo+ICAgcHJpbnQgZnJlZSBzdGFj
aw0KPiAtIGNoYW5nZSBwcmludGluZyBtZXNzYWdlDQo+IC0gcmVtb3ZlIGRlc2NyaXB0aW9ucyBp
biBLb2Nvbmcua2FzYW4NCj4gDQo+IENoYW5nZXMgc2luY2UgdjU6DQo+IC0gcmV1c2UgcHJpbnRf
c3RhY2soKSBpbiBwcmludF90cmFjaygpDQo+IA0KPiBDaGFuZ2VzIHNpbmNlIHY2Og0KPiAtIGZp
eCB0eXBvDQo+IC0gcmVuYW1lZCB0aGUgdmFyaWFibGUgbmFtZSBpbiB0ZXN0Y2FzZQ0KPiANCj4g
V2FsdGVyIFd1ICg0KToNCj4gcmN1OiBrYXNhbjogcmVjb3JkIGFuZCBwcmludCBjYWxsX3JjdSgp
IGNhbGwgc3RhY2sNCj4ga2FzYW46IHJlY29yZCBhbmQgcHJpbnQgdGhlIGZyZWUgdHJhY2sNCj4g
a2FzYW46IGFkZCB0ZXN0cyBmb3IgY2FsbF9yY3Ugc3RhY2sgcmVjb3JkaW5nDQo+IGthc2FuOiB1
cGRhdGUgZG9jdW1lbnRhdGlvbiBmb3IgZ2VuZXJpYyBrYXNhbg0KPiANCg0KSGkgQW5kcmV3LA0K
DQpXb3VsZCB5b3UgdGVsbCBtZSB3aHkgZG9uJ3QgcGljayB1cCB0aGlzIHBhdGNoZXM/DQpEbyBJ
IG1pc3Mgc29tZXRoaW5nPw0KDQpJIHdpbGwgd2FudCB0byBpbXBsZW1lbnQgYW5vdGhlciBuZXcg
cGF0Y2hlcywgYnV0IGl0IG5lZWQgdG8gZGVwZW5kIG9uDQp0aGlzIHBhdGNoZXMuDQoNCg0KVGhh
bmtzIGZvciB5b3VyIGhlbHBzLg0KDQpXYWx0ZXINCg0KPiBEb2N1bWVudGF0aW9uL2Rldi10b29s
cy9rYXNhbi5yc3QgfCAgMyArKysNCj4gaW5jbHVkZS9saW51eC9rYXNhbi5oICAgICAgICAgICAg
IHwgIDIgKysNCj4ga2VybmVsL3JjdS90cmVlLmMgICAgICAgICAgICAgICAgIHwgIDIgKysNCj4g
bGliL3Rlc3Rfa2FzYW4uYyAgICAgICAgICAgICAgICAgIHwgMzAgKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrDQo+IG1tL2thc2FuL2NvbW1vbi5jICAgICAgICAgICAgICAgICB8IDI2ICsr
KystLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+IG1tL2thc2FuL2dlbmVyaWMuYyAgICAgICAgICAg
ICAgICB8IDQzICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4g
bW0va2FzYW4vZ2VuZXJpY19yZXBvcnQuYyAgICAgICAgIHwgIDEgKw0KPiBtbS9rYXNhbi9rYXNh
bi5oICAgICAgICAgICAgICAgICAgfCAyMyArKysrKysrKysrKysrKysrKysrKystLQ0KPiBtbS9r
YXNhbi9xdWFyYW50aW5lLmMgICAgICAgICAgICAgfCAgMSArDQo+IG1tL2thc2FuL3JlcG9ydC5j
ICAgICAgICAgICAgICAgICB8IDU0ICsrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiBtbS9rYXNhbi90YWdzLmMgICAgICAgICAgICAgICAgICAg
fCAzNyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+IDExIGZpbGVzIGNo
YW5nZWQsIDE3MSBpbnNlcnRpb25zKCspLCA1MSBkZWxldGlvbnMoLSkNCg0K

