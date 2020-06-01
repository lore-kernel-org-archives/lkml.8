Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D95C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 02:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 986C120810
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 02:41:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="D/a54sh9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbgFAClT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 22:41:19 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:61159 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726218AbgFAClS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 22:41:18 -0400
X-UUID: ffb75a9db1e344dbaa7f25d2fc04a721-20200601
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=5OOtmndFogETs8MsnbhnGCSCp5lzPK/Ub28tiH9HSm4=;
        b=D/a54sh9osEHpX5XVThxMncpCglXBCKrRh9zE44kXnu85UCznYciTAcSGelRgu4qi6W3+3Kmj3t+WWXP9A6fm4L3jbePDoQ2hAfuACLbPzSKs9I9leIMDKKikzb8JBeSXT5FP9Sm78jAN+yrspHh2CEiOLkUq5FJv7H6+87lq5A=;
X-UUID: ffb75a9db1e344dbaa7f25d2fc04a721-20200601
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 2059801762; Mon, 01 Jun 2020 10:41:15 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 1 Jun 2020 10:41:08 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 1 Jun 2020 10:41:07 +0800
Message-ID: <1590979273.15486.0.camel@mtkswgap22>
Subject: Re: [PATCH v6] support gce on mt6779 platform
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
Date:   Mon, 1 Jun 2020 10:41:13 +0800
In-Reply-To: <CABb+yY16FzgafSYRo8DuVMttqUR5JVzXDsaP2rX+UnrNOD6k2A@mail.gmail.com>
References: <1590685491-17107-1-git-send-email-dennis-yc.hsieh@mediatek.com>
         <CABb+yY16FzgafSYRo8DuVMttqUR5JVzXDsaP2rX+UnrNOD6k2A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 23F5E0BF1671CC4EE062D7B349A502EB7F010BB185DCAB11634C1C6C2FE40B6C2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSmFzc2ksDQoNClRoYW5rcyBmb3IgeW91ciBjb21tZW50DQoNCk9uIFNhdCwgMjAyMC0wNS0z
MCBhdCAxNTozNCAtMDUwMCwgSmFzc2kgQnJhciB3cm90ZToNCj4gT24gVGh1LCBNYXkgMjgsIDIw
MjAgYXQgMTI6MDUgUE0gRGVubmlzIFlDIEhzaWVoDQo+IDxkZW5uaXMteWMuaHNpZWhAbWVkaWF0
ZWsuY29tPiB3cm90ZToNCj4gPg0KPiA+IFRoaXMgcGF0Y2ggc3VwcG9ydCBnY2Ugb24gbXQ2Nzc5
IHBsYXRmb3JtLg0KPiA+DQo+ID4gQ2hhbmdlIHNpbmNlIHY1Og0KPiA+IC0gc3BlYXJhdGUgYWRk
cmVzcyBzaGlmdCBjb2RlIGluIGNsaWVudCBoZWxwZXIgYW5kIG1haWxib3ggY29udHJvbGxlcg0K
PiA+IC0gc2VwYXJhdGUgd3JpdGVfcy93cml0ZV9zX21hc2sgYW5kIHdyaXRlX3NfdmFsdWUvd3Jp
dGVfc19tYXNrX3ZhbHVlIHNvIHRoYXQNCj4gPiAgIGNsaWVudCBjYW4gZGVjaWRlIHVzZSBtYXNr
IG9yIG5vdA0KPiA+IC0gZml4IHR5cG8gaW4gaGVhZGVyDQo+ID4NCj4gPiBDaGFuZ2Ugc2luY2Ug
djQ6DQo+ID4gLSBkbyBub3QgY2xlYXIgZGlzcCBldmVudCBhZ2FpbiBpbiBkcm0gZHJpdmVyDQo+
ID4gLSBzeW1ib2xpemUgdmFsdWUgMSB0byBqdW1wIHJlbGF0aXZlDQo+ID4NCj4gPiBbLi4uIHNu
aXAgLi4uXQ0KPiA+DQo+ID4NCj4gPg0KPiA+IERlbm5pcyBZQyBIc2llaCAoMTYpOg0KPiA+ICAg
ZHQtYmluZGluZzogZ2NlOiBhZGQgZ2NlIGhlYWRlciBmaWxlIGZvciBtdDY3NzkNCj4gPiAgIG1h
aWxib3g6IGNtZHE6IHZhcmlhYmxpemUgYWRkcmVzcyBzaGlmdCBpbiBwbGF0Zm9ybQ0KPiA+ICAg
bWFpbGJveDogY21kcTogc3VwcG9ydCBtdDY3NzkgZ2NlIHBsYXRmb3JtIGRlZmluaXRpb24NCj4g
PiAgIG1haWxib3g6IG1lZGlhdGVrOiBjbWRxOiBjbGVhciB0YXNrIGluIGNoYW5uZWwgYmVmb3Jl
IHNodXRkb3duDQo+ID4gICBzb2M6IG1lZGlhdGVrOiBjbWRxOiByZXR1cm4gc2VuZCBtc2cgZXJy
b3IgY29kZQ0KPiA+ICAgc29jOiBtZWRpYXRlazogY21kcTogYWRkIGFkZHJlc3Mgc2hpZnQgaW4g
anVtcA0KPiA+ICAgc29jOiBtZWRpYXRlazogY21kcTogYWRkIGFzc2lnbiBmdW5jdGlvbg0KPiA+
ICAgc29jOiBtZWRpYXRlazogY21kcTogYWRkIHdyaXRlX3MgZnVuY3Rpb24NCj4gPiAgIHNvYzog
bWVkaWF0ZWs6IGNtZHE6IGFkZCB3cml0ZV9zX21hc2sgZnVuY3Rpb24NCj4gPiAgIHNvYzogbWVk
aWF0ZWs6IGNtZHE6IGFkZCByZWFkX3MgZnVuY3Rpb24NCj4gPiAgIHNvYzogbWVkaWF0ZWs6IGNt
ZHE6IGFkZCB3cml0ZV9zIHZhbHVlIGZ1bmN0aW9uDQo+ID4gICBzb2M6IG1lZGlhdGVrOiBjbWRx
OiBhZGQgd3JpdGVfc19tYXNrIHZhbHVlIGZ1bmN0aW9uDQo+ID4gICBzb2M6IG1lZGlhdGVrOiBj
bWRxOiBleHBvcnQgZmluYWxpemUgZnVuY3Rpb24NCj4gPiAgIHNvYzogbWVkaWF0ZWs6IGNtZHE6
IGFkZCBqdW1wIGZ1bmN0aW9uDQo+ID4gICBzb2M6IG1lZGlhdGVrOiBjbWRxOiBhZGQgY2xlYXIg
b3B0aW9uIGluIGNtZHFfcGt0X3dmZSBhcGkNCj4gPiAgIHNvYzogbWVkaWF0ZWs6IGNtZHE6IGFk
ZCBzZXQgZXZlbnQgZnVuY3Rpb24NCj4gPg0KPiA+ICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9t
YWlsYm94L210ay1nY2UudHh0ICAgfCAgIDggKy0NCj4gPiAgZHJpdmVycy9ncHUvZHJtL21lZGlh
dGVrL210a19kcm1fY3J0Yy5jICAgICAgIHwgICAzICstDQo+ID4gIGRyaXZlcnMvbWFpbGJveC9t
dGstY21kcS1tYWlsYm94LmMgICAgICAgICAgICB8IDEwMSArKysrKystLQ0KPiA+ICBkcml2ZXJz
L3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYyAgICAgICAgfCAxNjMgKysrKysrKysrKysr
LQ0KPiA+ICBpbmNsdWRlL2R0LWJpbmRpbmdzL2djZS9tdDY3NzktZ2NlLmggICAgICAgICAgfCAy
MjIgKysrKysrKysrKysrKysrKysrDQo+ID4gIGluY2x1ZGUvbGludXgvbWFpbGJveC9tdGstY21k
cS1tYWlsYm94LmggICAgICB8ICAxMCArLQ0KPiA+ICBpbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRl
ay9tdGstY21kcS5oICAgICAgICAgfCAxMjUgKysrKysrKysrLQ0KPiA+DQo+IFBsZWFzZSBicmVh
ayB0aGUgcGF0Y2hzZXQgaW50byB0d28uIFRoZSBsb3dlciBtYWlsYm94IHJlbGF0ZWQgY2hhbmdl
cw0KPiB3aXRoIHNvYyBjaGFuZ2VzIG9uIHRvcC4NCg0KT2ssIEknbGwgc2VwYXJhdGUgcGF0Y2hl
cyBpbnRvIHR3byBwYXRjaHNldCwgdGhhbmtzLg0KDQoNClJlZ2FyZHMsDQpEZW5uaXMNCg0KPiAN
Cj4gdGhhbmtzDQoNCg==

