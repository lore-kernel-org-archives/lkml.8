Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA501C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 07:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8841A20707
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 07:50:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ufuncYV3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbgHZHuq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 03:50:46 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:40363 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726609AbgHZHuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 03:50:46 -0400
X-UUID: e038ea77c6164426b7e0dcc7dbc249b4-20200826
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Mk/MVFxbDJOWelnRC4EXaAkQpD5FL2twqZna26deVKk=;
        b=ufuncYV3CLwCGbQpoQ1rVUNCns+zAv3Xfcdpdd6QgYAZ75j9bBS40tLHOv/6GFyQIBAI7JJlrDXZwc7TzeoL+0idAQDTd0aZ03UejjSW9Sf4LQlsRvl2lOrKvI0HRHOMbL6R0Os287gdPjDuJbg0RPk6mwdAYDDlkurYHNe2sxc=;
X-UUID: e038ea77c6164426b7e0dcc7dbc249b4-20200826
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <mark-pk.tsai@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 399286582; Wed, 26 Aug 2020 15:50:41 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 26 Aug 2020 15:50:39 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 26 Aug 2020 15:50:39 +0800
From:   Mark-PK Tsai <mark-pk.tsai@mediatek.com>
To:     <robh@kernel.org>, Mark-PK Tsai <mark-pk.tsai@mediatek.com>
CC:     <alix.wu@mediatek.com>, <daniel@0x0f.com>,
        <devicetree@vger.kernel.org>, <jason@lakedaemon.net>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <maz@kernel.org>, <tglx@linutronix.de>, <yj.chiang@mediatek.com>
Subject: Re: [PATCH 2/2] dt-bindings: interrupt-controller: Add MStar interrupt controller
Date:   Wed, 26 Aug 2020 15:50:38 +0800
Message-ID: <20200826075038.29594-1-mark-pk.tsai@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200825214842.GA1367012@bogus>
References: <20200825214842.GA1367012@bogus>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 48D8998B49AFCB554C615D0F530C314DC0D9E5DDAA8310EBB8E99AA9277A48302000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz4NCg0KPj4gKw0KPj4gKyAgIiNpbnRl
cnJ1cHQtY2VsbHMiOg0KPj4gKyAgICBjb25zdDogMw0KPj4gKyAgICBkZXNjcmlwdGlvbjogfA0K
Pj4gKyAgICAgIFVzZSB0aGUgc2FtZSBmb3JtYXQgYXMgc3BlY2lmaWVkIGJ5IEdJQyBpbiBhcm0s
Z2ljLnlhbWwuDQo+DQo+VGhhdCdzIG9kZC4gWW91IGhhdmUgdGhlIHNhbWUgU1BJIGFuZCBQUEkg
c3R1ZmY/DQo+DQoNCk5vLCBidXQgSSBqdXN0IHdhbnQgdG8ga2VlcCB0aGUgZm9ybWF0IHNhbWUg
YXMgYXJtLGdpYywgYW5kIGxldCB0aGUNCmRyaXZlciBieXBhc3MgMXN0IGFuZCAzcmQgY2VsbCB0
byB0aGUgcGFyZW50IEdJQy4NClRoZSBtc3QtaW50YyBkcml2ZXIgdHJhbnNsYXRlIHRoZSBpbnRl
cnJ1cHQgbnVtYmVyIGluIDJuZCBjZWxsIHRvIHRoZQ0KaW50ZXJydXB0IG9uIHRoZSBwYXJlbnQg
R0lDLg0KDQo+PiArDQo+PiArICByZWc6DQo+PiArICAgIGRlc2NyaXB0aW9uOiB8DQo+PiArICAg
ICAgUGh5c2ljYWwgYmFzZSBhZGRyZXNzIG9mIHRoZSBtc3RhciBpbnRlcnJ1cHQgY29udHJvbGxl
cg0KPj4gKyAgICAgIHJlZ2lzdGVycyBhbmQgbGVuZ3RoIG9mIG1lbW9yeSBtYXBwZWQgcmVnaW9u
Lg0KPg0KPkRyb3AgdGhpcy4gVGhhdCdzIGV2ZXJ5ICdyZWcnIHByb3BlcnR5Lg0KPg0KPj4gKyAg
ICBtaW5JdGVtczogMQ0KPg0KPm1heEl0ZW1zIGlzIG1vcmUgbG9naWNhbC4NCj4NCj4+ICsNCj4+
ICsgIG1zdGFyLGlycXMtbWFwLXJhbmdlOg0KPj4gKyAgICBkZXNjcmlwdGlvbjogfA0KPj4gKyAg
ICAgIFRoZSByYW5nZSBvZiBwYXJlbnQgaW50ZXJydXB0IGNvbnRyb2xsZXIncyBpbnRlcnJ1cHQg
bGluZXMNCj4+ICsgICAgICB0aGF0IGFyZSBoYXJkd2lyZWQgdG8gbXN0YXIgaW50ZXJydXB0IGNv
bnRyb2xsZXIuDQo+DQo+SXMgdGhpcyA8c3RhcnQgc2l6ZT4gb3IgPHN0YXJ0IGVuZD4/DQo+DQoN
CjxzdGFydCBlbmQ+Lg0KSSB3aWxsIGFkZCB0aGlzIGluIHRoZSBkZXNjcmlwdGlvbi4NCg0KPlJl
YWxseSwgdGhpcyBzaG91bGQganVzdCB1c2UgJ2ludGVycnVwdHMnIGV2ZW4gdGhvdWdoIHRoYXQn
cyBhIGJpdCANCj52ZXJib3NlLiBPciBiZSBpbXBsaWVkIGJ5IHRoZSBjb21wYXRpYmxlIHN0cmlu
Zy4gV2hhdCdzIHRoZSBtYXhpbXVtIA0KPm51bWJlciBvZiBwYXJlbnQgaW50ZXJydXB0cz8NCj4N
Cj5JbiBhbnkgY2FzZSwgd2UgcmVhbGx5IG5lZWQgdG8gc3RvcCBoYXZpbmcgdmVuZG9yIHNwZWNp
ZmljIHByb3BlcnRpZXMgDQo+Zm9yIHRoaXMuDQoNCldlIHVzZSA2NCBpbnRlcnJ1cHRzIHBlciBp
bnRlcnJ1cHQgY29udHJvbGxlci4NCkFzIHlvdSBtZW50aW9ucywgaWYgd2UgdXNlIHRoZSBzdGFu
ZGFyZCBwcm9wZXJ0eSAnaW50ZXJydXB0cycsDQp0aGVuIHdlIG5lZWQgdG8gcHV0IDY0IGludGVy
cnVwdCBwcm9wZXJ0eSBpbiB0aGUgaW50ZXJydXB0DQpjb250cm9sbGVyIG5vZGUsIGFuZCBpdCB3
aWxsIGJlIGhhcmQgdG8gdW5kZXJzdGFuZC4NClNvIEkgc3VwcG9zZSB3ZSBuZWVkIGFuIHZlbmRv
ciBzcGVjaWZpYyBwcm9wZXJ0eSBoZXJlLg0KDQo+DQo+PiArICAgICRyZWY6IC9zY2hlbWFzL3R5
cGVzLnlhbWwjL2RlZmluaXRpb25zL3VpbnQzMi1tYXRyaXgNCj4+ICsgICAgaXRlbXM6DQo+PiAr
ICAgICAgbWluSXRlbXM6IDINCj4+ICsgICAgICBtYXhJdGVtczogMg0KPj4gKw0KPj4gKyAgbXN0
YXIsaW50Yy1uby1lb2k6DQo+PiArICAgIGRlc2NyaXB0aW9uOiB8DQo+DQo+RG9uJ3QgbmVlZCAn
fCcgaWYgdGhlcmUncyBubyBmb3JtYXR0aW5nLg0KPg0KPj4gKyAgICAgIE1hcmsgdGhpcyBjb250
cm9sbGVyIGhhcyBubyBFbmQgT2YgSW50ZXJydXB0KEVPSSkgaW1wbGVtZW50YXRpb24uDQo+PiAr
ICAgICAgVGhpcyBpcyBhIGVtcHR5LCBib29sZWFuIHByb3BlcnR5Lg0KPg0KPllvdSBjYW4gZHJv
cCB0aGlzIGxpbmUuIFRoZSBzY2hlbWEgc2F5cyB0aGlzLg0KPg0KPj4gKyAgICB0eXBlOiBib29s
ZWFuDQo+PiArDQo+PiArcmVxdWlyZWQ6DQo+PiArICAtIGNvbXBhdGlibGUNCj4+ICsgIC0gcmVn
DQo+PiArICAtIG1zdGFyLGlycXMtbWFwLXJhbmdlDQo+PiArDQo+PiArYWRkaXRpb25hbFByb3Bl
cnRpZXM6IGZhbHNlDQo+PiArDQo+PiArZXhhbXBsZXM6DQo+PiArICAtIHwNCj4+ICsgICAgbXN0
X2ludGMwOiBpbnRlcnJ1cHQtY29udHJvbGxlckAxZjIwMzJkMCB7DQo+PiArICAgICAgY29tcGF0
aWJsZSA9ICJtc3Rhcixtc3QtaW50YyIsICJtZWRpYXRlayxtdDU4eHgtaW50YyI7DQo+PiArICAg
ICAgaW50ZXJydXB0LWNvbnRyb2xsZXI7DQo+PiArICAgICAgI2ludGVycnVwdC1jZWxscyA9IDwz
PjsNCj4+ICsgICAgICAjYWRkcmVzcy1jZWxscyA9IDwxPjsNCj4+ICsgICAgICAjc2l6ZS1jZWxs
cyA9IDwxPjsNCj4+ICsgICAgICBpbnRlcnJ1cHQtcGFyZW50ID0gPCZnaWM+Ow0KPj4gKyAgICAg
IHJlZyA9IDwweDFmMjAzMmQwIDB4MzA+Ow0KPj4gKyAgICAgIG1zdGFyLGlycXMtbWFwLXJhbmdl
ID0gPDAgNjM+Ow0KPg0KPklzIDAgYSBQUEkgb3IgU1BJPyBUaGlzIHByb3BlcnR5IGlzIG1ha2lu
ZyBzb21lIGFzc3VtcHRpb24gYW5kIHdvdWxkbid0IA0KPmJlIGFibGUgdG8gc3VwcG9ydCBib3Ro
IHR5cGVzIG9yIGFub3RoZXIgcGFyZW50IGludGVycnVwdCBjb250cm9sbGVyLg0KPg0KDQowIGlz
IHRoZSBpbnRlcnJ1cHQgbnVtYmVyIG9mIHRoZSBwYXJlbnQgaW50ZXJydXB0IGNvbnRyb2xsZXIu
DQpUaGVyZSdzIG5vIFNQSSBhbmQgUFBJIHN0dWZmIGluIG1zdC1pbnRjLCBpdCB3aWxsIGJ5cGFz
cyB0aGUNCjFzdCBjZWxsIHRvIHBhcmVudCBjb250cm9sbGVyLg0KDQplLmcuIFRoZSBkZXZpY2Ug
bm9kZSBhcyBmb2xsb3dpbmcgd2lsbCBwb2ludCB0byBHSUMgU1BJIDMxDQooInZhbHVlIGluIDJu
ZCBjZWxsIiArICJzdGFydCBpbiBpcnFzLW1hcC1yYW5nZSIpLg0KCXVzYjogew0KCQlpbnRlcnJ1
cHQtcGFyZW50ID0gPCZtdGtfaW50YzA+Ow0KCQlpbnRlcnJ1cHRzID0gPDB4MCAzMSAweDQ+Ow0K
CQkuLi4NCgl9Ow0KDQo+PiArICAgIH07DQo+PiArLi4uDQo+PiAtLSANCj4+IDIuMTguMA==

