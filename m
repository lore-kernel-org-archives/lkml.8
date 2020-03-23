Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2772C1975A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 01:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9E7B206C3
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 01:12:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="efDLcvC3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbgCWBML (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 21:12:11 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:48759 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726946AbgCWBML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 21:12:11 -0400
X-UUID: 7f2ae8122d3640109396e18c7959ce7c-20200323
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=Ej7b2xhDVPxexbXWATZXTqKZRMpmRwD04pT0SWLn2fk=;
        b=efDLcvC31Zh1JIojnQSsS7mpqC2YLYF4zoBRgMDC6YcI2Wod5p2HWdtxHyvE3JW2GMVrn8inpdOI0X66bpqqfF8Xztq2WUJ7DsqlRoXQxbox9t1TxRJfDBCD4Rkcq3tUqELnIPbrU/k/FuytljHQHFZsr9vXJt0BIwjqp/x0eAI=;
X-UUID: 7f2ae8122d3640109396e18c7959ce7c-20200323
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1058497680; Mon, 23 Mar 2020 09:12:02 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 23 Mar 2020 09:11:00 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 23 Mar 2020 09:09:43 +0800
Message-ID: <1584925915.16928.1.camel@mtkswgap22>
Subject: Re: [PATCH v5 02/13] mailbox: cmdq: variablize address shift in
 platform
From:   Dennis-YC Hsieh <dennis-yc.hsieh@mediatek.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>, <dri-devel@lists.freedesktop.org>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        "CK Hu" <ck.hu@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        HS Liao <hs.liao@mediatek.com>
Date:   Mon, 23 Mar 2020 09:11:55 +0800
In-Reply-To: <CABb+yY04NbSvHkQ0sVHd+KjU3ZFZSZD=H99OSNjoeu+Qpk7R8g@mail.gmail.com>
References: <1583664775-19382-1-git-send-email-dennis-yc.hsieh@mediatek.com>
         <1583664775-19382-3-git-send-email-dennis-yc.hsieh@mediatek.com>
         <CABb+yY04NbSvHkQ0sVHd+KjU3ZFZSZD=H99OSNjoeu+Qpk7R8g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSmFzc2ksDQoNCg0KT24gVGh1LCAyMDIwLTAzLTE5IGF0IDIwOjA1IC0wNTAwLCBKYXNzaSBC
cmFyIHdyb3RlOg0KPiBPbiBTdW4sIE1hciA4LCAyMDIwIGF0IDU6NTMgQU0gRGVubmlzIFlDIEhz
aWVoDQo+IDxkZW5uaXMteWMuaHNpZWhAbWVkaWF0ZWsuY29tPiB3cm90ZToNCj4gPg0KPiA+IFNv
bWUgZ2NlIGhhcmR3YXJlIHNoaWZ0IHBjIGFuZCBlbmQgYWRkcmVzcyBpbiByZWdpc3RlciB0byBz
dXBwb3J0DQo+ID4gbGFyZ2UgZHJhbSBhZGRyZXNzaW5nLg0KPiA+IEltcGxlbWVudCBnY2UgYWRk
cmVzcyBzaGlmdCB3aGVuIHdyaXRlIG9yIHJlYWQgcGMgYW5kIGVuZCByZWdpc3Rlci4NCj4gPiBB
bmQgYWRkIHNoaWZ0IGJpdCBpbiBwbGF0Zm9ybSBkZWZpbml0aW9uLg0KPiA+DQo+ID4gU2lnbmVk
LW9mZi1ieTogRGVubmlzIFlDIEhzaWVoIDxkZW5uaXMteWMuaHNpZWhAbWVkaWF0ZWsuY29tPg0K
PiA+IFJldmlld2VkLWJ5OiBDSyBIdSA8Y2suaHVAbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+
ICBkcml2ZXJzL21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5jICAgICAgIHwgNjEgKysrKysrKysr
KysrKysrKysrLS0tLS0tDQo+ID4gIGRyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBl
ci5jICAgfCAgMyArLQ0KPiA+ICBpbmNsdWRlL2xpbnV4L21haWxib3gvbXRrLWNtZHEtbWFpbGJv
eC5oIHwgIDIgKw0KPiA+DQo+IFBsZWFzZSBzZWdyZWdhdGUgdGhpcyBwYXRjaCwgYW5kIGFueSBv
dGhlciBpZiwgaW50byBtYWlsYm94IGFuZA0KPiBwbGF0Zm9ybSBzcGVjaWZpYyBwYXRjaHNldHMu
IElkZWFsbHkgc29jL2NsaWVudCBzcGVjaWZpYyBjaGFuZ2VzIGxhdGVyDQo+IG9uIHRvcCBvZiBt
YWlsYm94L3Byb3ZpZGVyIGNoYW5nZXMuDQo+IA0KPiBUaGFua3MNCg0KVGhhbmtzIGZvciB5b3Vy
IGNvbW1lbnQuIEknbGwgc2VwYXJhdGUgbWFpbGJveCBhbmQgc29jIGNvZGUuDQoNCg0KUmVnYXJk
cywNCkRlbm5pcw0KDQo=

