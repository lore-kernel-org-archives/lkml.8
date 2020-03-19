Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE319C4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 08:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B105720714
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 08:25:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="tZDNpEGq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgCSIZN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 04:25:13 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:25570 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725767AbgCSIZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 04:25:13 -0400
X-UUID: 70dbe579fff94d0b974d855b32ade374-20200319
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=iRLB6NyH9Dw1QuDRyGg/3cbLaE61cSAcOzKDspWyGNs=;
        b=tZDNpEGqVCYzt4s6Ta8FMslDEjhsfLKenpIpG0WqmM+iy/ZJqOSXANY4Wax7178gpFgjOw+bBbjgFeXEXEOiG20Rdz1Fx9bEpqWxiRpEeEeLltgbTBG4gUZcfYFRR4vjAcCec0grVhnDO3DXzv3k6nDGiz71Iy9gnHxkSGf7Q24=;
X-UUID: 70dbe579fff94d0b974d855b32ade374-20200319
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <hanks.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1165661813; Thu, 19 Mar 2020 16:25:03 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 19 Mar 2020 16:24:01 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 19 Mar 2020 16:25:36 +0800
Message-ID: <1584606301.29104.2.camel@mtkswgap22>
Subject: Re: [PATCH v3 1/6] dt-bindings: pinctrl: add bindings for MediaTek
 MT6779 SoC
From:   Hanks Chen <hanks.chen@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>, Andy Teng <andy.teng@mediatek.com>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        Sean Wang <sean.wang@kernel.org>,
        <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Date:   Thu, 19 Mar 2020 16:25:01 +0800
In-Reply-To: <20200318223842.GA31707@bogus>
References: <1584454007-2115-1-git-send-email-hanks.chen@mediatek.com>
         <1584454007-2115-2-git-send-email-hanks.chen@mediatek.com>
         <20200318223842.GA31707@bogus>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIwLTAzLTE4IGF0IDE2OjM4IC0wNjAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4g
T24gVHVlLCAxNyBNYXIgMjAyMCAyMjowNjo0MiArMDgwMCwgSGFua3MgQ2hlbiB3cm90ZToNCj4g
PiBGcm9tOiBBbmR5IFRlbmcgPGFuZHkudGVuZ0BtZWRpYXRlay5jb20+DQo+ID4gDQo+ID4gQWRk
IGRldmljZXRyZWUgYmluZGluZ3MgZm9yIE1lZGlhVGVrIE1UNjc3OSBwaW5jdHJsIGRyaXZlci4N
Cj4gPiANCj4gPiBDaGFuZ2UtSWQ6IEk5MjU4NjM2OTU2NDk0OGYyNjI4ZjcwNDIxYmNkNzA2Njhm
MTMyYzRmDQo+ID4gU2lnbmVkLW9mZi1ieTogQW5keSBUZW5nIDxhbmR5LnRlbmdAbWVkaWF0ZWsu
Y29tPg0KPiA+IC0tLQ0KPiA+ICAuLi4vYmluZGluZ3MvcGluY3RybC9tZWRpYXRlayxtdDY3Nzkt
cGluY3RybC55YW1sICB8ICAyMDggKysrKysrKysrKysrKysrKysrKysNCj4gPiAgMSBmaWxlIGNo
YW5nZWQsIDIwOCBpbnNlcnRpb25zKCspDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGluY3RybC9tZWRpYXRlayxtdDY3NzktcGluY3Ry
bC55YW1sDQo+ID4gDQo+IA0KPiBNeSBib3QgZm91bmQgZXJyb3JzIHJ1bm5pbmcgJ21ha2UgZHRf
YmluZGluZ19jaGVjaycgb24geW91ciBwYXRjaDoNCj4gDQo+IHdhcm5pbmc6IG5vIHNjaGVtYSBm
b3VuZCBpbiBmaWxlOiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGluY3RybC9t
ZWRpYXRlayxtdDY3NzktcGluY3RybC55YW1sDQo+IC9idWlsZHMvcm9iaGVycmluZy9saW51eC1k
dC1yZXZpZXcvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BpbmN0cmwvbWVkaWF0
ZWssbXQ2Nzc5LXBpbmN0cmwueWFtbDogaWdub3JpbmcsIGVycm9yIHBhcnNpbmcgZmlsZQ0KPiBE
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGluY3RybC9tZWRpYXRlayxtdDY3Nzkt
cGluY3RybC55YW1sOiAgd2hpbGUgcGFyc2luZyBhIGJsb2NrIGNvbGxlY3Rpb24NCj4gICBpbiAi
PHVuaWNvZGUgc3RyaW5nPiIsIGxpbmUgMjgsIGNvbHVtbiA1DQo+IGRpZCBub3QgZmluZCBleHBl
Y3RlZCAnLScgaW5kaWNhdG9yDQo+ICAgaW4gIjx1bmljb2RlIHN0cmluZz4iLCBsaW5lIDI5LCBj
b2x1bW4gNQ0KPiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvTWFrZWZpbGU6MTI6
IHJlY2lwZSBmb3IgdGFyZ2V0ICdEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGlu
Y3RybC9tZWRpYXRlayxtdDY3NzktcGluY3RybC5leGFtcGxlLmR0cycgZmFpbGVkDQo+IG1ha2Vb
MV06ICoqKiBbRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BpbmN0cmwvbWVkaWF0
ZWssbXQ2Nzc5LXBpbmN0cmwuZXhhbXBsZS5kdHNdIEVycm9yIDENCj4gTWFrZWZpbGU6MTI2Mjog
cmVjaXBlIGZvciB0YXJnZXQgJ2R0X2JpbmRpbmdfY2hlY2snIGZhaWxlZA0KPiBtYWtlOiAqKiog
W2R0X2JpbmRpbmdfY2hlY2tdIEVycm9yIDINCj4gDQo+IFNlZSBodHRwczovL3BhdGNod29yay5v
emxhYnMub3JnL3BhdGNoLzEyNTY0MjkNCj4gUGxlYXNlIGNoZWNrIGFuZCByZS1zdWJtaXQuDQo+
IA0KDQpNeSBiYWQsIHNob3VsZCB1cGRhdGUgdGhlIGZvcm1hdC4gd2lsbCBkbyBpbiB2NC4NCg0K
VGhhbmtzIGZvciByZXZpZXdpbmcuDQoNCg0KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXw0KPiBMaW51eC1tZWRpYXRlayBtYWlsaW5nIGxpc3QNCj4gTGlu
dXgtbWVkaWF0ZWtAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiBodHRwOi8vbGlzdHMuaW5mcmFkZWFk
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW1lZGlhdGVrDQoNCg==

