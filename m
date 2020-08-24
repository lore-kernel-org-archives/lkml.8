Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A24C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 02:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08CD1206F7
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 02:36:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="NkEM55mq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbgHXCgc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Aug 2020 22:36:32 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:52917 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726635AbgHXCgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 22:36:32 -0400
X-UUID: 33aabed618234360a425b73f3b99570a-20200824
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=DGXAb/0Vl5Dez9+vEDFYuUVf9EcPLGR8eaFdhVWVXVQ=;
        b=NkEM55mqaTTFbe9ofPB2EPse6Ev1uXSjFyTDSKG1xnK+iIVkvAWzUO1CZDrNM9jX+bXsZfh3gwwXa8MPfsewfZoJmyr9hdJs05kLnMR2gnLc4mreJbPkJ/Tpk7ZFKwT92LTizzMD7/iOY9JwSATfY8Z6e2mc+oTgWVbOXwVtpzk=;
X-UUID: 33aabed618234360a425b73f3b99570a-20200824
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <mark-pk.tsai@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1536756996; Mon, 24 Aug 2020 10:36:27 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 24 Aug 2020 10:36:25 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 24 Aug 2020 10:36:24 +0800
From:   Mark-PK Tsai <mark-pk.tsai@mediatek.com>
To:     <daniel@0x0f.com>, Mark-PK Tsai <mark-pk.tsai@mediatek.com>
CC:     <alix.wu@mediatek.com>, <devicetree@vger.kernel.org>,
        <jason@lakedaemon.net>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <maz@kernel.org>, <robh+dt@kernel.org>, <tglx@linutronix.de>,
        <yj.chiang@mediatek.com>
Subject: Re: [PATCH v2 1/2] irqchip: irq-mst: Add MStar interrupt controller support
Date:   Mon, 24 Aug 2020 10:36:08 +0800
Message-ID: <20200824023608.12694-1-mark-pk.tsai@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <CAFr9PXni=BmDY6_iuJPnYb3d6XB1VrxE6WP3YtSBxT6NciZMMA@mail.gmail.com>
References: <CAFr9PXni=BmDY6_iuJPnYb3d6XB1VrxE6WP3YtSBxT6NciZMMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 6E4C3BF49D4DFB9E466CFBA5624D59848AA25DE09D0CFEF9A30BC7D17FB7468C2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogRGFuaWVsIFBhbG1lciA8ZGFuaWVsQDB4MGYuY29tPg0KDQo+SGkgTWFyay1QSywNCj4N
Cj5PbiBUaHUsIDIwIEF1ZyAyMDIwIGF0IDAwOjM4LCBNYXJrLVBLIFRzYWkgPG1hcmstcGsudHNh
aUBtZWRpYXRlay5jb20+IHdyb3RlOg0KPj4NCj4+IEFkZCBNU3RhciBpbnRlcnJ1cHQgY29udHJv
bGxlciBzdXBwb3J0IHVzaW5nIGhpZXJhcmNoeSBpcnENCj4+IGRvbWFpbi4NCj4+DQo+PiBTaWdu
ZWQtb2ZmLWJ5OiBNYXJrLVBLIFRzYWkgPG1hcmstcGsudHNhaUBtZWRpYXRlay5jb20+DQo+DQo+
SSd2ZSBpbnRlZ3JhdGVkIHRoaXMgdmVyc2lvbiBpbnRvIG15IE1TdGFyL1NpZ21hU3RhciB0cmVl
IGFuZCB0ZXN0ZWQNCj5vbiBhbiBNU3RhciBNU0MzMTNFDQo+YmFzZWQgYm9hcmQgKEJyZWFkQmVl
KSBhbmQgSSdtIGhhcHB5IHRvIHNheSBpdCBzZWVtcyB0byBiZSB3b3JraW5nOg0KPg0KPiQgY2F0
IC9wcm9jL2ludGVycnVwdHMNCj4gICAgICAgICAgQ1BVMA0KPjE3OiAgICAgICAxMjE5ICAgICBH
SUMtMCAgMjkgTGV2ZWwgICAgIGFyY2hfdGltZXINCj4xODogICAgICAgICAgMCAgICAgR0lDLTAg
IDMwIExldmVsICAgICBhcmNoX3RpbWVyDQo+MjE6ICAgICAgICAgIDAgICAgIEdJQy0wICA0MiBM
ZXZlbCAgICAgYXJtLXBtdQ0KPjI0OiAgICAgICAgICAwICBtc3QtaW50YyAgNDQgTGV2ZWwgICAg
IDFmMDAyNDAwLnJ0Yw0KPjMwOiAgICAgICAgICAwICBtc3QtaW50YyAgIDIgTGV2ZWwgICAgIDFm
MDA2MDAwLndkdA0KPjMxOiAgICAgICAgICAwICBtc3QtaW50YyAgIDAgTGV2ZWwgICAgIDFmMDA2
MDQwLnRpbWVyDQo+MzI6ICAgICAgICAgIDAgIG1zdC1pbnRjICAgMSBMZXZlbCAgICAgMWYwMDYw
ODAudGltZXINCj4zMzogICAgICAgICAgMCAgbXN0LWludGMgIDEyIExldmVsICAgICAxZjAwNjBj
MC50aW1lcg0KPjM0OiAgICAgICAgICAwICBtc3QtaW50YyAgNDAgTGV2ZWwgICAgIDFmMjAwNDAw
LmJkbWENCj4zNTogICAgICAgMzk3NyAgbXN0LWludGMgIDQxIExldmVsICAgICAxZjIwMDQwMC5i
ZG1hDQo+Mzc6ICAgICAgICAxOTYgIG1zdC1pbnRjICAzNCBMZXZlbCAgICAgdHR5UzANCj40MDog
ICAgICAgICAgMCAgbXN0LWludGMgIDMwIExldmVsICAgICBzb2M6dXNicGh5QDANCj48c25pcD4N
Cj4NCj5TbyBoZXJlJ3MgbXkgdGVzdGVkIGJ5Og0KPg0KPlRlc3RlZC1ieTogRGFuaWVsIFBhbG1l
ciA8ZGFuaWVsQHRoaW5neS5qcD4NCj4NCg0KVGhhbmtzIGZvciB5b3VyIHRlc3QuDQoNCj5JIGRv
bid0IHRoaW5rIHlvdXIgc2VyaWVzIGNvbnRhaW5lZCBhbiB1cGRhdGUgdG8gTUFJTlRBSU5FUlMu
DQo+SWYvd2hlbiB5b3UgYWRkIHRoaXMgY291bGQgeW91IGFkZCBteSBhZGRyZXNzIGFib3ZlIGFz
IGEgcmV2aWV3ZXIgc28NCj5JJ20gaW4gdGhlIGxvb3AgaWYgYW55b25lIG1ha2VzIGNoYW5nZXMg
dG8gdGhpcyBnb2luZyBmb3J3YXJkPw0KPg0KDQpTdXJlLCBJIHdpbGwgYWRkIHlvdXIgYWRkcmVz
cyBpbiB0aGVyZS4gOikNCkNhbiBJIGp1c3QgYWRkIGEgcGF0Y2ggaW4gdGhpcyB0aHJlYWQgd2hp
Y2ggb25seSBjb250YWluIE1BSU5UQUlORVJTIHVwZGF0ZT8=

