Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD22C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 01:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D4BF2072C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 01:08:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ROVHPn8i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbgEVBIq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 21:08:46 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:16520 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726762AbgEVBIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 21:08:46 -0400
X-UUID: dfc4e360bb65418eabff719be51640cd-20200522
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=oO4SaPPTxCTE7bONxyRSPlLMv4RJZyUeyjDZC6W1AEY=;
        b=ROVHPn8iwca7HZzyKWs2KF9hhqwvvnFRObwGofNd4GBJJfcYd1Q2tSlaUYJIVI1P31DREcOb+bwmVKI2M1jh8bhiXMPnPg9nzhmHSur3L4SFkD7aI8DjWoofPPqIwdPXga+KWwx3LWDqxKP9O3c/1j8epjyPIImdGQc7NtbHYi8=;
X-UUID: dfc4e360bb65418eabff719be51640cd-20200522
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1844598716; Fri, 22 May 2020 09:08:38 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33N1.mediatek.inc
 (172.27.4.75) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 22 May
 2020 09:08:31 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 22 May 2020 09:08:34 +0800
Message-ID: <1590109620.5899.18.camel@mhfsdcap03>
Subject: Re: [PATCH v3 0/7] add support USB for MT8183
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Date:   Fri, 22 May 2020 09:07:00 +0800
In-Reply-To: <2e98982b-ab8a-9fa9-0903-881ebce916a5@gmail.com>
References: <1567150854-30033-1-git-send-email-chunfeng.yun@mediatek.com>
         <1567562067.7317.52.camel@mhfsdcap03>
         <2e98982b-ab8a-9fa9-0903-881ebce916a5@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: D722D1425AC6E7F67072680642C70D142CB6E1803E9F058E532825CF51FE18462000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWF0dGhpYXMsDQoNCk9uIFRodSwgMjAyMC0wNS0yMSBhdCAxNDo0MSArMDIwMCwgTWF0dGhp
YXMgQnJ1Z2dlciB3cm90ZToNCj4gSGkgQ2h1bmdmZW5nLA0KPiANCj4gT24gMDQvMDkvMjAxOSAw
Mzo1NCwgQ2h1bmZlbmcgWXVuIHdyb3RlOg0KPiA+IEhpIEdyZWcsDQo+ID4gDQo+ID4gDQo+ID4g
ICBQbGVhc2UgZG9uJ3QgdHJ5IHRvIHBpY2sgdXAgdGhpcyBzZXJpZXMsIHRoZSBkZXBlbmRlbnQg
b25lcyBhcmUgc3RpbGwNCj4gPiB1bmRlciBwdWJsaWMgcmV2aWV3LCBJJ2xsIGZpeCBidWlsZCB3
YXJuaW5nIGFuZCBzZW5kIG91dCBuZXcgdmVyc2lvbg0KPiA+IGFmdGVyIHRoZSBkZXBlbmRlbnQg
b25lcyBhcmUgYXBwbGllZA0KPiA+ICAgU29ycnkgZm9yIGluY29udmVuaWVuY2UNCj4gPiANCj4g
DQo+IEkgdGhpbmsgdGhlIHBtaWMgZHJpdmVyIGlzIHVwc3RyZWFtIG5vdyBhbmQgc2hvdyB1cCBp
biBsaW51eC1uZXh0IHNvb24uDQo+IA0KPiBJIHByb3Bvc2UgdG8gcmViYXNlIHRoZSBzZXJpZXMg
YW5kIHNlbmQgaXQgYWdhaW4uDQpPaywgSSdsbCByZXNlbmQgdGhpcyBzZXJpZXMsIHRoYW5rcyBh
IGxvdA0KDQo+IA0KPiBSZWdhcmRzLA0KPiBNYXR0aGlhcw0KPiANCj4gPiBUaGFua3MNCj4gPiAN
Cj4gPiBPbiBGcmksIDIwMTktMDgtMzAgYXQgMTU6NDAgKzA4MDAsIENodW5mZW5nIFl1biB3cm90
ZToNCj4gPj4gVGhpcyBzZXJpZXMgc3VwcG9ydCBVU0IgRFJEIGNvbnRyb2xsZXIgYW5kIGVuYWJs
ZSBpdCdzIHJlbW90ZQ0KPiA+PiB3YWtldXAgZnVuY3RvaW4gZm9yIE1UODE4MywgdGhleSBkZXBl
bmQgb24gdGhlIGZvbGxvd2luZw0KPiA+PiBzZXJpZXMgcGF0Y2hlczoNCj4gPj4NCj4gPj4gMS4g
dGhpcyBzZXJpZXMgYWRkIHN1cHBvcnQgTVQ2MzU4IFBNSUMNCj4gPj4gICBbdjUsMDEvMTBdIG1m
ZDogbXQ2Mzk3OiBjbGVhbiB1cCBjb2RlDQo+ID4+ICAgaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVs
Lm9yZy9wYXRjaC8xMTExMDQ4Ny8NCj4gPj4NCj4gPj4gMi4gdGhpcyBzZXJpZXMgYWRkIHN1cHBv
cnQgcGVyaWNmZyBzeXNjb24NCj4gPj4gICBbdjIsMS8yXSBkdC1iaW5kaW5nczogY2xvY2s6IG1l
ZGlhdGVrOiBhZGQgcGVyaWNmZyBmb3IgTVQ4MTgzDQo+ID4+ICAgaHR0cHM6Ly9wYXRjaHdvcmsu
a2VybmVsLm9yZy9wYXRjaC8xMTExODE4My8NCj4gPj4NCj4gPj4gMy4gYWRkIHByb3BlcnR5IG1l
ZGlhdGVrLGRpc2N0aCBmb3IgdHBoeQ0KPiA+PiAgIFswNi8xMV0gcGh5OiBwaHktbXRrLXRwaHk6
IGFkZCBhIHByb3BlcnR5IGZvciBkaXNjb25uZWN0IHRocmVzaG9sZA0KPiA+PiAgIGh0dHBzOi8v
cGF0Y2h3b3JrLmtlcm5lbC5vcmcvcGF0Y2gvMTExMTA2OTUvDQo+ID4+DQo+ID4+IHYzIGNoYW5n
ZXM6DQo+ID4+ICAgMS4gY2hhbmdlcyBtaWNyb3MgZGVmaW5lDQo+ID4+ICAgMi4gcmVtb3ZlICNy
ZXNldC1jZWxsDQo+ID4+ICAgMy4gdXBkYXRlIGRlcGVuZGVudCBzZXJpZXMNCj4gPj4NCj4gPj4g
djIgY2hhbmdlczoNCj4gPj4gICBhZGQgcGF0Y2ggWzcvN10NCj4gPj4NCj4gPj4gQ2h1bmZlbmcg
WXVuICg3KToNCj4gPj4gICBkdC1iaW5kaW5nczogdXNiOiBtdHUzOiBzdXBwb3J0IFVTQiB3YWtl
dXAgZm9yIE1UODE4Mw0KPiA+PiAgIGR0LWJpbmRpbmdzOiB1c2I6IG10ay14aGNpOiBzdXBwb3J0
IFVTQiB3YWtldXAgZm9yIE1UODE4Mw0KPiA+PiAgIHVzYjogbXR1Mzogc3VwcG9ydCBpcC1zbGVl
cCB3YWtldXAgZm9yIE1UODE4Mw0KPiA+PiAgIHVzYjogbXRrLXhoY2k6IHN1cHBvcnQgaXAtc2xl
ZXAgd2FrZXVwIGZvciBNVDgxODMNCj4gPj4gICBhcm02NDogZHRzOiBtdDgxODM6IGFkZCB1c2Ig
YW5kIHBoeSBub2Rlcw0KPiA+PiAgIGFybTY0OiBkdHM6IG10ODE4MzogZW5hYmxlIFVTQiByZW1v
dGUgd2FrZXVwDQo+ID4+ICAgYXJtNjQ6IGR0czogbXQ4MTgzOiB0dW5lIGRpc2Nvbm5lY3QgdGhy
ZXNob2xkIG9mIHUycGh5DQo+ID4+DQo+ID4+ICAuLi4vYmluZGluZ3MvdXNiL21lZGlhdGVrLG10
ay14aGNpLnR4dCAgICAgICAgfCAgMSArDQo+ID4+ICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy91
c2IvbWVkaWF0ZWssbXR1My50eHQgfCAgMSArDQo+ID4+ICBhcmNoL2FybTY0L2Jvb3QvZHRzL21l
ZGlhdGVrL210ODE4My1ldmIuZHRzICAgfCAyMyArKysrKysrDQo+ID4+ICBhcmNoL2FybTY0L2Jv
b3QvZHRzL21lZGlhdGVrL210ODE4My5kdHNpICAgICAgfCA2MyArKysrKysrKysrKysrKysrKysr
DQo+ID4+ICBkcml2ZXJzL3VzYi9ob3N0L3hoY2ktbXRrLmMgICAgICAgICAgICAgICAgICAgfCAx
NCArKysrLQ0KPiA+PiAgZHJpdmVycy91c2IvbXR1My9tdHUzX2hvc3QuYyAgICAgICAgICAgICAg
ICAgIHwgMTQgKysrKy0NCj4gPj4gIDYgZmlsZXMgY2hhbmdlZCwgMTE0IGluc2VydGlvbnMoKyks
IDIgZGVsZXRpb25zKC0pDQo+ID4+DQo+ID4gDQo+ID4gDQoNCg==

