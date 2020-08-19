Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 192FCC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 14:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCA022083B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 14:56:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="CuUdyapr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728648AbgHSO4U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 10:56:20 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:45416 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727827AbgHSO4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 10:56:10 -0400
X-UUID: 9bbb8ce1d5a84066a4409b007606cfb1-20200819
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=AoeUUvCjkrCNhYfqve8JEcUAO7P8LbXeCUbXyAWumY0=;
        b=CuUdyaprq4NzPSfPJNniWUlBoger3pChNskh8ssVrfZkkrpRIie3itK8Yk71o2YN2bvd3Htc5bWN4pkwZzpnj/sMbfMKGkfI5rd1ivuaPFfKXem+oJnEacT4gBBt2rzkacpfKEk9MZx6pL+9dtwJE8vPx0yeCm9KU05fqTUkf5M=;
X-UUID: 9bbb8ce1d5a84066a4409b007606cfb1-20200819
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <mark-pk.tsai@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 909703223; Wed, 19 Aug 2020 22:56:06 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 19 Aug 2020 22:56:05 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 19 Aug 2020 22:56:02 +0800
From:   Mark-PK Tsai <mark-pk.tsai@mediatek.com>
To:     <maz@kernel.org>, Mark-PK Tsai <mark-pk.tsai@mediatek.com>
CC:     <alix.wu@mediatek.com>, <daniel@0x0f.com>,
        <devicetree@vger.kernel.org>, <jason@lakedaemon.net>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <robh+dt@kernel.org>, <tglx@linutronix.de>,
        <yj.chiang@mediatek.com>
Subject: Re: [PATCH 1/2] irqchip: irq-mst: Add MStar interrupt controller support
Date:   Wed, 19 Aug 2020 22:55:26 +0800
Message-ID: <20200819145525.26315-1-mark-pk.tsai@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <f593f5e395c8558657a3f265b7038ec3@kernel.org>
References: <f593f5e395c8558657a3f265b7038ec3@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTWFyYyBaeW5naWVyIDxtYXpAa2VybmVsLm9yZz4NCg0KPk9uIDIwMjAtMDgtMTkgMTQ6
MzEsIE1hcmstUEsgVHNhaSB3cm90ZToNCj4+IEZyb206IE1hcmMgWnluZ2llciA8bWF6QGtlcm5l
bC5vcmc+DQo+PiANCj4+PiA+ICsNCj4+PiA+ICtzdGF0aWMgaW50IG1zdF9pbnRjX2RvbWFpbl9h
bGxvYyhzdHJ1Y3QgaXJxX2RvbWFpbiAqZG9tYWluLCB1bnNpZ25lZA0KPj4+ID4gaW50IHZpcnEs
DQo+Pj4gPiArCQkJCSB1bnNpZ25lZCBpbnQgbnJfaXJxcywgdm9pZCAqZGF0YSkNCj4+PiA+ICt7
DQo+Pj4gPiArCWludCBpOw0KPj4+ID4gKwlpcnFfaHdfbnVtYmVyX3QgaHdpcnE7DQo+Pj4gPiAr
CXN0cnVjdCBpcnFfZndzcGVjIHBhcmVudF9md3NwZWMsICpmd3NwZWMgPSBkYXRhOw0KPj4+ID4g
KwlzdHJ1Y3QgbXN0X2ludGNfY2hpcF9kYXRhICpjZCA9IChzdHJ1Y3QgbXN0X2ludGNfY2hpcF9k
YXRhDQo+Pj4gPiAqKWRvbWFpbi0+aG9zdF9kYXRhOw0KPj4+IA0KPj4+IE5vIGNhc3QgbmVjZXNz
YXJ5IGhlcmUuDQo+Pj4gDQo+Pj4gPiArDQo+Pj4gPiArCS8qIE5vdCBHSUMgY29tcGxpYW50ICov
DQo+Pj4gPiArCWlmIChmd3NwZWMtPnBhcmFtX2NvdW50ICE9IDMpDQo+Pj4gPiArCQlyZXR1cm4g
LUVJTlZBTDsNCj4+PiA+ICsNCj4+PiA+ICsJLyogTm8gUFBJIHNob3VsZCBwb2ludCB0byB0aGlz
IGRvbWFpbiAqLw0KPj4+ID4gKwlpZiAoZndzcGVjLT5wYXJhbVswXSkNCj4+PiA+ICsJCXJldHVy
biAtRUlOVkFMOw0KPj4+ID4gKw0KPj4+ID4gKwlpZiAoZndzcGVjLT5wYXJhbVsxXSA+PSBjZC0+
bnJfaXJxcykNCj4+PiANCj4+PiBUaGlzIGNvbmRpdGlvbiBpcyBib2d1cywgYXMgaXQgZG9lc24n
dCB0YWtlIGludG8gYWNjb3VudCB0aGUgbnJfaXJxcw0KPj4+IHBhcmFtZXRlci4NCj4+PiANCj4+
IA0KPj4gDQo+PiBUaGUgaHdpcnEgbnVtYmVyIG5lZWQgdG8gYmUgaW4gdGhlIGlycSBtYXAgcmFu
Z2UuIChwcm9wZXJ0eToNCj4+IG1zdGFyLGlycXMtbWFwLXJhbmdlKQ0KPj4gSWYgaXQncyBub3Qs
IGl0IG11c3QgYmUgaW5jb3JyZWN0IGNvbmZpZ3VyYXRpb24uDQo+DQo+SSBhZ3JlZS4gQW5kIHNp
bmNlIHlvdSBhcmUgY2hlY2tpbmcgd2hldGhlciB0aGUgY29uZmlndXJhdGlvbiBpcyANCj5jb3Jy
ZWN0LA0KPml0J2QgYmV0dGVyIGJlIGNvbXBsZXRlbHkgY29ycmVjdC4NCj4NCj4+IFNvIGhvdyBh
Ym91dCB1c2UgdGhlIGNvbmRpdGlvbiBhcyBmb2xsb3dpbmc/DQo+PiANCj4+IGlmIChod2lycSA+
PSBjZC0+bnJfaXJxcykNCj4+IAlyZXR1cm4gLUVJTlZBTDsNCj4NCj5BZ2FpbiwgdGhpcyBzYXlz
IG5vdGhpbmcgb2YgdGhlIHZhbGlkaXR5IG9mIChod2lycSArIG5yX2lycXMgLSAxKS4uLg0KPg0K
DQpIb3cgYWJvdXQgbW92ZSB0aGlzIHRvIG1zdF9pbnRjX2RvbWFpbl90cmFuc2xhdGU/IFRoZW4g
YWxsIHRoZSBpcnFfZndzcGVjDQpwb2ludCB0byBkb21haW4gbXN0X2ludGMgc2hvdWxkIGJlIHZh
bGlkLg0KDQpUaGUgbXN0X2ludGNfZG9tYWluX3RyYW5zbGF0ZSB3aWxsIGJlIGFzIGZvbGxvd2lu
ZzoNCg0Kc3RhdGljIGludCBtc3RfaW50Y19kb21haW5fdHJhbnNsYXRlKHN0cnVjdCBpcnFfZG9t
YWluICpkLA0KCQkJCSAgICAgc3RydWN0IGlycV9md3NwZWMgKmZ3c3BlYywNCgkJCQkgICAgIHVu
c2lnbmVkIGxvbmcgKmh3aXJxLA0KCQkJCSAgICAgdW5zaWduZWQgaW50ICp0eXBlKQ0Kew0KCXN0
cnVjdCBtc3RfaW50Y19jaGlwX2RhdGEgKmNkID0gZC0+aG9zdF9kYXRhOw0KDQoJaWYgKGlzX29m
X25vZGUoZndzcGVjLT5md25vZGUpKSB7DQoJCWlmIChmd3NwZWMtPnBhcmFtX2NvdW50ICE9IDMp
DQoJCQlyZXR1cm4gLUVJTlZBTDsNCg0KCQkvKiBObyBQUEkgc2hvdWxkIHBvaW50IHRvIHRoaXMg
ZG9tYWluICovDQoJCWlmIChmd3NwZWMtPnBhcmFtWzBdICE9IDApDQoJCQlyZXR1cm4gLUVJTlZB
TDsNCg0KCQlpZiAoZndzcGVjLT5wYXJhbVsxXSA+PSBjZC0+bnJfaXJxcykNCgkJCXJldHVybiAt
RUlOVkFMOw0KDQoJCSpod2lycSA9IGZ3c3BlYy0+cGFyYW1bMV07DQoJCSp0eXBlID0gZndzcGVj
LT5wYXJhbVsyXSAmIElSUV9UWVBFX1NFTlNFX01BU0s7DQoJCXJldHVybiAwOw0KCX0NCg0KCXJl
dHVybiAtRUlOVkFMOw0KfQ0KDQoNCj4+IA0KPj4+ID4gKwkJcmV0dXJuIC1FSU5WQUw7DQo+Pj4g
PiArDQo+Pj4gPiArCWh3aXJxID0gZndzcGVjLT5wYXJhbVsxXTsNCj4+PiA+ICsJZm9yIChpID0g
MDsgaSA8IG5yX2lycXM7IGkrKykNCj4+PiA+ICsJCWlycV9kb21haW5fc2V0X2h3aXJxX2FuZF9j
aGlwKGRvbWFpbiwgdmlycSArIGksIGh3aXJxICsgaSwNCj4+PiA+ICsJCQkJCSAgICAgICZtc3Rf
aW50Y19jaGlwLA0KPj4+ID4gKwkJCQkJICAgICAgZG9tYWluLT5ob3N0X2RhdGEpOw==

