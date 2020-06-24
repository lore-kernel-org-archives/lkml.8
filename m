Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 658D0C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 03:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 443892070E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 03:51:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="LHkJg7Yg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388803AbgFXDve (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 23:51:34 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:31285 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388665AbgFXDvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 23:51:33 -0400
X-UUID: ab9f33d4d1164f7d944f2ceff272d664-20200624
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=2Dog3+Nae8JVLbPa7qMUki8StCUSkZ7vDzgUmgL8nCI=;
        b=LHkJg7YgjU04Nt6u/wwESrQfe1U61/PUIjrTRHJUv06I7DJZjtziIHvpHoLxkWhAx9lvbfpTF4Keg1+3VJdyWy6SBG469XasDS1heAPhFAWVwlxSqWZa06uP/h/DawRL9PPvA4KV2jmqmvNuLtO8kUBkKLyvWcG3M1jVwF7zGgw=;
X-UUID: ab9f33d4d1164f7d944f2ceff272d664-20200624
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <neal.liu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1208736638; Wed, 24 Jun 2020 11:51:30 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 24 Jun 2020 11:51:20 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 24 Jun 2020 11:51:20 +0800
Message-ID: <1592970682.14160.6.camel@mtkswgap22>
Subject: Re: Add MediaTek MT6873 devapc driver
From:   Neal Liu <neal.liu@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     Neal Liu <neal.liu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>
Date:   Wed, 24 Jun 2020 11:51:22 +0800
In-Reply-To: <20200609173204.GB1107294@bogus>
References: <1591698261-22639-1-git-send-email-neal.liu@mediatek.com>
         <20200609173204.GB1107294@bogus>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 94B690576371ABB4BE2991BDACDFB8DE814464701461FFE7D00C600E775A57D32000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIwLTA2LTA5IGF0IDExOjMyIC0wNjAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4g
T24gVHVlLCBKdW4gMDksIDIwMjAgYXQgMDY6MjQ6MTlQTSArMDgwMCwgTmVhbCBMaXUgd3JvdGU6
DQo+ID4gVGhlc2UgcGF0Y2ggc2VyaWVzIGludHJvZHVjZSBhIE1lZGlhVGVrIE1UNjg3MyBkZXZh
cGMgZHJpdmVyLg0KPiA+IA0KPiA+IE1UNjg3MyBidXMgZnJhYnJpYyBwcm92aWRlcyBUcnVzdFpv
bmUgc2VjdXJpdHkgc3VwcG9ydCBhbmQgZGF0YQ0KPiA+IHByb3RlY3Rpb24gdG8gcHJldmVudCBz
bGF2ZXMgZnJvbSBiZWluZyBhY2Nlc3NlZCBieSB1bmV4cGVjdGVkDQo+ID4gbWFzdGVycy4NCj4g
PiBUaGUgc2VjdXJpdHkgdmlvbGF0aW9ucyBhcmUgbG9nZ2VkIGFuZCBzZW50IHRvIHRoZSBwcm9j
ZXNzb3IgZm9yDQo+ID4gZnVydGhlciBhbmFseXNpcyBvciBjb3VudGVybWVhc3VyZXMuDQo+ID4g
DQo+ID4gQW55IG9jY3VycmVuY2Ugb2Ygc2VjdXJpdHkgdmlvbGF0aW9uIHdvdWxkIHJhaXNlIGFu
IGludGVycnVwdCwgYW5kDQo+ID4gaXQgd2lsbCBiZSBoYW5kbGVkIGJ5IGRldmFwYy1tdDY4NzMg
ZHJpdmVyLiBUaGUgdmlvbGF0aW9uDQo+ID4gaW5mb3JtYXRpb24gaXMgcHJpbnRlZCBpbiBvcmRl
ciB0byBmaW5kIHRoZSBtdXJkZXJlci4NCj4gDQo+IFRoZXJlJ3MgYWxzbyBhIHByb3Bvc2VkIGRy
aXZlciB3aXRoIHNpbWlsYXIgZnVuY3Rpb25hbGl0eVsxXS4gQ29tZSB1cCANCj4gd2l0aCBhIGNv
bW1vbiBzb2x1dGlvbi4NCj4gDQo+IFJvYg0KPiANCj4gWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL2xpbnV4LWFybS1rZXJuZWwvMjAyMDAxMjgxNTM4MDYuNzc4MC0xLWJlbmphbWluLmdhaWdu
YXJkQHN0LmNvbS8NCg0KQWN0dWFsbHksIE1lZGlhdGVrIGRldmFwYyBIVyBkbyB0aGUgc2ltaWxh
ciB0aGluZ3MuIEJ1dCB0aGUgcmVhbA0KImZpcmV3YWxsIiBmdW5jdGlvbmFsaXR5IGlzIGltcGxl
bWVudGVkIGluIFRydXN0Wm9uZSBpbnN0cmVhZCBvZiBSRUUuDQpUaGlzIGRldmFwYy1tdDY4NzMg
ZHJpdmVyIGlzIG1haW5seSBoYW5kbGVkIHRoZSB2aW9sYXRpb24uDQoNCkJ1cyBmaXJld2FsbCBm
cmFtZXdvcmsgc2VlbXMgbm90IGNvdmVyIHRoaXMgcGFydHMuDQo=

