Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2205C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 03:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C08F720708
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 03:38:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Wz+x6l/j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728210AbgGGDiU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 23:38:20 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:52643 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727871AbgGGDiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 23:38:20 -0400
X-UUID: 512f442de6224b6b8b21880f38524bff-20200707
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=orN+U9b8rBcb3cgnPPXbg0k2d4sfceTMwEf/l9coVVs=;
        b=Wz+x6l/jsyBe+FBkiPN2hT8GqrSImQDn0f2JcxNqRlPWZCbRcikFzRxh/J3wfHdni5y+Y96ad9XQ380/b8IreF1N6ewNatev8QcH6gbwDLyLqRm9AtMHx2NBD8/8sT9BA3YnSOeX3Tct5/JC4ezX+Y840t3FB7WpAhJJnHILfKk=;
X-UUID: 512f442de6224b6b8b21880f38524bff-20200707
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <neal.liu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 988155038; Tue, 07 Jul 2020 11:38:17 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 7 Jul 2020 11:38:13 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 7 Jul 2020 11:38:14 +0800
Message-ID: <1594093094.20820.8.camel@mtkswgap22>
Subject: Re: [PATCH 2/2] soc: mediatek: devapc: add devapc-mt6779 driver
From:   Neal Liu <neal.liu@mediatek.com>
To:     Randy Dunlap <rdunlap@infradead.org>
CC:     Neal Liu <neal.liu@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>
Date:   Tue, 7 Jul 2020 11:38:14 +0800
In-Reply-To: <eb2eaab3-1ecc-d2c8-fc40-5bbe51ee31c4@infradead.org>
References: <1594027693-19530-1-git-send-email-neal.liu@mediatek.com>
         <1594027693-19530-3-git-send-email-neal.liu@mediatek.com>
         <dd03ec1e-e511-4c13-4e12-a9f8ec407326@infradead.org>
         <1594092631.20820.4.camel@mtkswgap22>
         <eb2eaab3-1ecc-d2c8-fc40-5bbe51ee31c4@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: BAB8E2C131F09C2E8A131E9F69B010D851F56200AC2906895C4A3E2A86C556E62000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIwLTA3LTA2IGF0IDIwOjMyIC0wNzAwLCBSYW5keSBEdW5sYXAgd3JvdGU6DQo+
IE9uIDcvNi8yMCA4OjMwIFBNLCBOZWFsIExpdSB3cm90ZToNCj4gPiBIaSBSYW5keSwNCj4gPiAN
Cj4gPiBUaGFua3MgZm9yIHlvdXIgcmV2aWV3Lg0KPiA+IA0KPiA+IE9uIE1vbiwgMjAyMC0wNy0w
NiBhdCAwOToxMyAtMDcwMCwgUmFuZHkgRHVubGFwIHdyb3RlOg0KPiA+PiBPbiA3LzYvMjAgMjoy
OCBBTSwgTmVhbCBMaXUgd3JvdGU6DQo+ID4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zb2MvbWVk
aWF0ZWsvZGV2YXBjL0tjb25maWcgYi9kcml2ZXJzL3NvYy9tZWRpYXRlay9kZXZhcGMvS2NvbmZp
Zw0KPiA+Pj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gPj4+IGluZGV4IDAwMDAwMDAuLmIwZjdk
MGUNCj4gPj4+IC0tLSAvZGV2L251bGwNCj4gPj4+ICsrKyBiL2RyaXZlcnMvc29jL21lZGlhdGVr
L2RldmFwYy9LY29uZmlnDQo+ID4+PiBAQCAtMCwwICsxLDE3IEBADQo+ID4+PiArY29uZmlnIE1U
S19ERVZBUEMNCj4gPj4+ICsJdHJpc3RhdGUgIk1lZGlhdGVrIERldmljZSBBUEMgU3VwcG9ydCIN
Cj4gPj4+ICsJaGVscA0KPiA+Pj4gKwkgIERldmljZSBBUEMgaXMgYSBIVyBJUCBjb250cm9sbGlu
ZyBpbnRlcm5hbCBkZXZpY2Ugc2VjdXJpdHkuDQo+ID4+DQo+ID4+IHByZWZlcmFibHk6ICAgICAg
ICAgICAgICAgcy9IVy9oYXJkd2FyZS8NCj4gPj4NCj4gPj4+ICsJICBNZWRpYVRlayBidXMgZnJh
YnJpYyBwcm92aWRlcyBUcnVzdFpvbmUgc2VjdXJpdHkgc3VwcG9ydCBhbmQgZGF0YQ0KPiA+Pg0K
PiA+PiAJICAgICAgICAgICAgICAgZmFicmljDQo+ID4+DQo+ID4+PiArCSAgcHJvdGVjdGlvbiB0
byBwcmV2ZW50IHNsYXZlcyBmcm9tIGJlaW5nIGFjY2Vzc2VkIGJ5IHVuZXhwZWN0ZWQNCj4gPj4+
ICsJICBidXMgbWFzdGVycy4NCj4gPj4+ICsJICBEZXZpY2UgQVBDIHByZXZlbnRzIG1hbGljaW91
cyBhY2Nlc3MgdG8gaW50ZXJuYWwgZGV2aWNlcy4NCj4gPj4+ICsNCj4gPj4+ICtjb25maWcgREVW
QVBDX01UNjc3OQ0KPiA+Pj4gKwl0cmlzdGF0ZSAiTWVkaWF0ZWsgTVQ2Nzc5IERldmljZSBBUEMg
ZHJpdmVyIg0KPiA+Pj4gKwlzZWxlY3QgTVRLX0RFVkFQQw0KPiA+Pj4gKwloZWxwDQo+ID4+PiAr
CSAgU2F5IHllcyBoZXJlIHRvIGVuYWJsZSBzdXBwb3J0IE1lZGlhdGVrIE1UNjc3OSBEZXZpY2Ug
QVBDIGRyaXZlci4NCj4gPj4NCj4gPj4gCSAgICAgICAgICAgICAgICAgICAgICAgICBzdXBwb3J0
IGZvciBNZWRpYXRlaw0KPiA+Pg0KPiA+Pj4gKwkgIFRoaXMgZHJpdmVyIG1haW5seSB1c2VkIHRv
IGhhbmRsZSB0aGUgdmlvbGF0aW9uIHdpdGggMSBERVZBUEMgQU8vUERzLg0KPiA+Pg0KPiA+PiAJ
ICBUaGlzIGRyaXZlciBpcyBtYWlubHkgdXNlZCAgICAgICAgICAgICAgICAgICAgICAgICAgIF5e
Xl5eXl5eXl5eXl5eXl4NCj4gPj4NCj4gPj4gCSAgICAgICAgICAgICAgICAgICAgICBXaGF0IGlz
IHRoYXQgbWVhbmluZ2xlc3Mgc3RyaW5nIG9mIGNoYXJzPyBeXl5eXl5eDQo+ID4gDQo+ID4gSSBk
aWQgbm90IHNlZSBhbnkgbWVhbmluZ2xlc3Mgc3RyaW5nIG9mIGNoYXJzIGZyb20gbXkgb3JpZ2lu
YWwgcGF0Y2guDQo+ID4gSXMgdGhlcmUgc29tZXRoaW5nIHdyb25nPw0KPiANCj4gVG8gc29tZW9u
ZSB3aG8gaXMgcmVhZGluZyB0aGUgS2NvbmZpZyBoZWxwIHRleHQgYnV0IGlzIHVuZmFtaWxpYXIg
d2l0aCB0aGlzIGRldmljZSwNCj4gSSB3b3VsZCBzYXkgdGhhdCAgICAgICAgIjEgREVWQVBDIEFP
L1BEcyIgICAgICAgICAgICAgICAgICAgIGlzIG5vdCBoZWxwZnVsIGF0IGFsbC4NCg0KR290IGl0
LCBJJ2xsIHRyeSB0byBtYWtlIGl0IG1vcmUgcmVhZGFibGUuDQoNCj4gDQo+ID4gWzFdIGh0dHBz
Oi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwczovL2xrbWwub3JnL2xrbWwvMjAyMC83LzYvMTY4
X187ISFDVFJOS0E5d01nMEFSYnchMHBBbVZxVXJ0REVEUFQtUWtRRU5Yc28tX3VtT3oybmJlLURE
SWxNYjFzRXNENTdCYUt0RFpGNDdRRlRmTVNQLSQgDQo+ID4gDQo+ID4+DQo+ID4+PiArCSAgVGhl
IHZpb2xhdGlvbiBpbmZvcm1hdGlvbiBhcmUgbG9nZ2VkIGZvciBmdXJ0aGVyIGFuYWx5c2lzIG9y
DQo+ID4+DQo+ID4+IAkgICAgICAgICAgICAgICAgICAgICAgICAgICAgaXMNCj4gPj4NCj4gPj4+
ICsJICBjb3VudGVybWVhc3VyZXMuDQo+ID4+DQo+ID4+IHRoYW5rcy4NCj4gPiANCj4gDQo+IA0K
PiB0aGFua3MuDQoNCg==

