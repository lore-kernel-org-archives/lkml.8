Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC585C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 11:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7CD02080C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 11:12:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="aqoihg3I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728822AbgHZLLy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 07:11:54 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:23653 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728787AbgHZLLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 07:11:21 -0400
X-UUID: 19e34c8c3e124a3eb67b9bb4caad93dd-20200826
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=A/c+zO1Bn8tRKZBh2n+Hldsc4ufJubZKEbW6ppLUBsk=;
        b=aqoihg3It/4Hf77PUejyDJWtM8XDztDF4++8he97g9PETyl31mp4aRKcZXGqci+A4SstpPsqQXDjuCeN+PkqIHCvhgmUFfohx+rv77y71cXcBVRibEDJdTA+fo2ADJUXK4dAaqtb3sm4mdOU1dt+DIgzzqPQMzC1cmSCCfokloY=;
X-UUID: 19e34c8c3e124a3eb67b9bb4caad93dd-20200826
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <crystal.guo@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 94182355; Wed, 26 Aug 2020 19:11:06 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 26 Aug
 2020 19:11:05 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 26 Aug 2020 19:11:05 +0800
Message-ID: <1598440183.30048.14.camel@mhfsdcap03>
Subject: Re: [v4,2/4] dt-binding: reset-controller: ti: add
 'mediatek,infra-reset' to compatible
From:   Crystal Guo <crystal.guo@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "s-anna@ti.com" <s-anna@ti.com>, "afd@ti.com" <afd@ti.com>,
        Seiya Wang =?UTF-8?Q?=28=E7=8E=8B=E8=BF=BA=E5=90=9B=29?= 
        <seiya.wang@mediatek.com>,
        Stanley Chu =?UTF-8?Q?=28=E6=9C=B1=E5=8E=9F=E9=99=9E=29?= 
        <stanley.chu@mediatek.com>,
        Yingjoe Chen =?UTF-8?Q?=28=E9=99=B3=E8=8B=B1=E6=B4=B2=29?= 
        <Yingjoe.Chen@mediatek.com>,
        Fan Chen =?UTF-8?Q?=28=E9=99=B3=E5=87=A1=29?= 
        <fan.chen@mediatek.com>,
        Yong Liang =?UTF-8?Q?=28=E6=A2=81=E5=8B=87=29?= 
        <Yong.Liang@mediatek.com>
Date:   Wed, 26 Aug 2020 19:09:43 +0800
In-Reply-To: <20200825190219.GA1125997@bogus>
References: <20200817030324.5690-1-crystal.guo@mediatek.com>
         <20200817030324.5690-3-crystal.guo@mediatek.com>
         <20200825190219.GA1125997@bogus>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: F5BA3F4B05E182D188D3A309D1F49535F9637CD33A5A9DB6DAE3FFCC36DBD5282000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIwLTA4LTI2IGF0IDAzOjAyICswODAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4g
T24gTW9uLCBBdWcgMTcsIDIwMjAgYXQgMTE6MDM6MjJBTSArMDgwMCwgQ3J5c3RhbCBHdW8gd3Jv
dGU6DQo+ID4gVGhlIFRJIHN5c2NvbiByZXNldCBjb250cm9sbGVyIHByb3ZpZGVzIGEgY29tbW9u
IHJlc2V0IG1hbmFnZW1lbnQsDQo+ID4gYW5kIGlzIHN1aXRhYmxlIGZvciBNVEsgU29Dcy4gQWRk
IGNvbXBhdGlibGUgJ21lZGlhdGVrLGluZnJhLXJlc2V0JywNCj4gPiB3aGljaCBkZW5vdGVzIHRv
IHVzZSB0aSByZXNldC1jb250cm9sbGVyIGRyaXZlciBkaXJlY3RseS4NCj4gPiANCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBDcnlzdGFsIEd1byA8Y3J5c3RhbC5ndW9AbWVkaWF0ZWsuY29tPg0KPiA+IC0t
LQ0KPiA+ICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcmVzZXQvdGktc3lzY29u
LXJlc2V0LnR4dCB8IDEgKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCj4g
PiANCj4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Jl
c2V0L3RpLXN5c2Nvbi1yZXNldC50eHQgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvcmVzZXQvdGktc3lzY29uLXJlc2V0LnR4dA0KPiA+IGluZGV4IGFiMDQxMDMyMzM5Yi4uNWEw
ZTkzNjViNTFiIDEwMDY0NA0KPiA+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9yZXNldC90aS1zeXNjb24tcmVzZXQudHh0DQo+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL3Jlc2V0L3RpLXN5c2Nvbi1yZXNldC50eHQNCj4gPiBAQCAtMjUs
NiArMjUsNyBAQCBSZXF1aXJlZCBwcm9wZXJ0aWVzOg0KPiA+ICAJCQkgICAgInRpLGsybC1wc2Ny
c3QiDQo+ID4gIAkJCSAgICAidGksazJoay1wc2Nyc3QiDQo+ID4gIAkJCSAgICAidGksc3lzY29u
LXJlc2V0Ig0KPiA+ICsJCQkgICAgIm1lZGlhdGVrLGluZnJhLXJlc2V0IiwgInRpLHN5c2Nvbi1y
ZXNldCINCj4gDQo+IFlvdSBuZWVkIHlvdXIgb3duIGJpbmRpbmcgZG9jLiBJZiB5b3UgY2FuIHVz
ZSB0aGUgc2FtZSBkcml2ZXIgdGhlbiBmaW5lLCANCj4gYnV0IHRoYXQncyBhIHNlcGFyYXRlIGlz
c3VlLiBUaGVyZSdzIGFsc28gcmVzZXQtc2ltcGxlIGRyaXZlciBpZiB5b3UgDQo+IGhhdmUganVz
dCBhcnJheSBvZiAzMi1iaXQgcmVnaXN0ZXJzIHdpdGggYSBiaXQgcGVyIHJlc2V0Lg0KPiANCj4g
RG9uJ3QgcmVwZWF0ICd0aSxyZXNldC1iaXRzJyBlaXRoZXIuDQoNCkRvIHlvdSBtZWFuIEkgc2hv
dWxkIGFkZCBhIE1lZGlhdGVrIHJlc2V0IGJpbmRpbmcgZG9jLCBhbHRob3VnaCBNZWRpYXRlaw0K
cmV1c2UgdGhlIFRJIHJlc2V0IGNvbnRyb2xsZXIgZGlyZWN0bHk/DQoNCkJlc3QgUmVnYXJkcw0K
Q3J5c3RhbA0KPiANCj4gPiAgIC0gI3Jlc2V0LWNlbGxzCQk6IFNob3VsZCBiZSAxLiBQbGVhc2Ug
c2VlIHRoZSByZXNldCBjb25zdW1lciBub2RlIGJlbG93DQo+ID4gIAkJCSAgZm9yIHVzYWdlIGRl
dGFpbHMNCj4gPiAgIC0gdGkscmVzZXQtYml0cwk6IENvbnRhaW5zIHRoZSByZXNldCBjb250cm9s
IHJlZ2lzdGVyIGluZm9ybWF0aW9uDQo+ID4gLS0gDQo+ID4gMi4xOC4wDQoNCg==

