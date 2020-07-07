Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B55FBC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 03:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DE67206E6
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 03:30:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="cpTwCnUc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728096AbgGGDai (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 23:30:38 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:31878 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726869AbgGGDai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 23:30:38 -0400
X-UUID: 37955c864bee42898962f30a4be32809-20200707
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=xXfL3TuAtjkYQYWJISRyQ46uxdKVzkwh663c3FEQbZc=;
        b=cpTwCnUcSL4cDbKP4noOOdf9lFJN9QiOHYVhjoJgp0t14ShDnO9W7lXeDBBsN+nW0NibxuIlcDRn3Msflf98BKtuG+PgMbvqL08+F3H+o6I0OKsXjyfgBcaD06yWW1rGDxy+WFnnmGw8r95cElrz9TbHHaoyNupaEnNQp8zs2ik=;
X-UUID: 37955c864bee42898962f30a4be32809-20200707
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <neal.liu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 2059621264; Tue, 07 Jul 2020 11:30:34 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 7 Jul 2020 11:30:30 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 7 Jul 2020 11:30:31 +0800
Message-ID: <1594092631.20820.4.camel@mtkswgap22>
Subject: Re: [PATCH 2/2] soc: mediatek: devapc: add devapc-mt6779 driver
From:   Neal Liu <neal.liu@mediatek.com>
To:     Randy Dunlap <rdunlap@infradead.org>
CC:     Neal Liu <neal.liu@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>
Date:   Tue, 7 Jul 2020 11:30:31 +0800
In-Reply-To: <dd03ec1e-e511-4c13-4e12-a9f8ec407326@infradead.org>
References: <1594027693-19530-1-git-send-email-neal.liu@mediatek.com>
         <1594027693-19530-3-git-send-email-neal.liu@mediatek.com>
         <dd03ec1e-e511-4c13-4e12-a9f8ec407326@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 7C124BCAC688D580459B4BB001DA4F885A5228596ACC2F264F482A1C854A0E7C2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUmFuZHksDQoNClRoYW5rcyBmb3IgeW91ciByZXZpZXcuDQoNCk9uIE1vbiwgMjAyMC0wNy0w
NiBhdCAwOToxMyAtMDcwMCwgUmFuZHkgRHVubGFwIHdyb3RlOg0KPiBPbiA3LzYvMjAgMjoyOCBB
TSwgTmVhbCBMaXUgd3JvdGU6DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvc29jL21lZGlhdGVr
L2RldmFwYy9LY29uZmlnIGIvZHJpdmVycy9zb2MvbWVkaWF0ZWsvZGV2YXBjL0tjb25maWcNCj4g
PiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiA+IGluZGV4IDAwMDAwMDAuLmIwZjdkMGUNCj4gPiAt
LS0gL2Rldi9udWxsDQo+ID4gKysrIGIvZHJpdmVycy9zb2MvbWVkaWF0ZWsvZGV2YXBjL0tjb25m
aWcNCj4gPiBAQCAtMCwwICsxLDE3IEBADQo+ID4gK2NvbmZpZyBNVEtfREVWQVBDDQo+ID4gKwl0
cmlzdGF0ZSAiTWVkaWF0ZWsgRGV2aWNlIEFQQyBTdXBwb3J0Ig0KPiA+ICsJaGVscA0KPiA+ICsJ
ICBEZXZpY2UgQVBDIGlzIGEgSFcgSVAgY29udHJvbGxpbmcgaW50ZXJuYWwgZGV2aWNlIHNlY3Vy
aXR5Lg0KPiANCj4gcHJlZmVyYWJseTogICAgICAgICAgICAgICBzL0hXL2hhcmR3YXJlLw0KPiAN
Cj4gPiArCSAgTWVkaWFUZWsgYnVzIGZyYWJyaWMgcHJvdmlkZXMgVHJ1c3Rab25lIHNlY3VyaXR5
IHN1cHBvcnQgYW5kIGRhdGENCj4gDQo+IAkgICAgICAgICAgICAgICBmYWJyaWMNCj4gDQo+ID4g
KwkgIHByb3RlY3Rpb24gdG8gcHJldmVudCBzbGF2ZXMgZnJvbSBiZWluZyBhY2Nlc3NlZCBieSB1
bmV4cGVjdGVkDQo+ID4gKwkgIGJ1cyBtYXN0ZXJzLg0KPiA+ICsJICBEZXZpY2UgQVBDIHByZXZl
bnRzIG1hbGljaW91cyBhY2Nlc3MgdG8gaW50ZXJuYWwgZGV2aWNlcy4NCj4gPiArDQo+ID4gK2Nv
bmZpZyBERVZBUENfTVQ2Nzc5DQo+ID4gKwl0cmlzdGF0ZSAiTWVkaWF0ZWsgTVQ2Nzc5IERldmlj
ZSBBUEMgZHJpdmVyIg0KPiA+ICsJc2VsZWN0IE1US19ERVZBUEMNCj4gPiArCWhlbHANCj4gPiAr
CSAgU2F5IHllcyBoZXJlIHRvIGVuYWJsZSBzdXBwb3J0IE1lZGlhdGVrIE1UNjc3OSBEZXZpY2Ug
QVBDIGRyaXZlci4NCj4gDQo+IAkgICAgICAgICAgICAgICAgICAgICAgICAgc3VwcG9ydCBmb3Ig
TWVkaWF0ZWsNCj4gDQo+ID4gKwkgIFRoaXMgZHJpdmVyIG1haW5seSB1c2VkIHRvIGhhbmRsZSB0
aGUgdmlvbGF0aW9uIHdpdGggMSBERVZBUEMgQU8vUERzLg0KPiANCj4gCSAgVGhpcyBkcml2ZXIg
aXMgbWFpbmx5IHVzZWQgICAgICAgICAgICAgICAgICAgICAgICAgICBeXl5eXl5eXl5eXl5eXl5e
DQo+IA0KPiAJICAgICAgICAgICAgICAgICAgICAgIFdoYXQgaXMgdGhhdCBtZWFuaW5nbGVzcyBz
dHJpbmcgb2YgY2hhcnM/IF5eXl5eXl4NCg0KSSBkaWQgbm90IHNlZSBhbnkgbWVhbmluZ2xlc3Mg
c3RyaW5nIG9mIGNoYXJzIGZyb20gbXkgb3JpZ2luYWwgcGF0Y2guDQpJcyB0aGVyZSBzb21ldGhp
bmcgd3Jvbmc/DQoNClsxXSBodHRwczovL2xrbWwub3JnL2xrbWwvMjAyMC83LzYvMTY4DQoNCj4g
DQo+ID4gKwkgIFRoZSB2aW9sYXRpb24gaW5mb3JtYXRpb24gYXJlIGxvZ2dlZCBmb3IgZnVydGhl
ciBhbmFseXNpcyBvcg0KPiANCj4gCSAgICAgICAgICAgICAgICAgICAgICAgICAgICBpcw0KPiAN
Cj4gPiArCSAgY291bnRlcm1lYXN1cmVzLg0KPiANCj4gdGhhbmtzLg0KDQo=

