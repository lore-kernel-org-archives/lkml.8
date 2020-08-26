Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43158C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 11:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 207C02080C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 11:11:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="nnIuJBO3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728742AbgHZLLC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 07:11:02 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:11648 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728586AbgHZLKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 07:10:51 -0400
X-UUID: e55c0edbb05643daa301872f462d6ff4-20200826
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=pnlfpEAFsOOmXFIeR1iCQGXMDaBl8g+2wdRlohePfrs=;
        b=nnIuJBO324rDoCeil/c+H+QsWE21nPnyLgP/NhW7P0T5/pvghlHa5DT5QuKGOC2MH9WGQFQtbkI5pYzM5OiYEsn+pJsu/6s+rt2covtMNHXZihotQIaUsCCfwVAtSZWCCH4cFkJJxzd/CoVffeksJL1xkWkXtMJhpV9olDwwFDA=;
X-UUID: e55c0edbb05643daa301872f462d6ff4-20200826
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <crystal.guo@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1114327454; Wed, 26 Aug 2020 19:10:43 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 26 Aug
 2020 19:10:42 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 26 Aug 2020 19:10:41 +0800
Message-ID: <1598440159.30048.13.camel@mhfsdcap03>
Subject: Re: [v4,1/4] dt-binding: reset-controller: ti: add
 reset-duration-us property
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
Date:   Wed, 26 Aug 2020 19:09:19 +0800
In-Reply-To: <20200825174215.GA999117@bogus>
References: <20200817030324.5690-1-crystal.guo@mediatek.com>
         <20200817030324.5690-2-crystal.guo@mediatek.com>
         <20200825174215.GA999117@bogus>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: CD4A58937EB8860E7A6649B1B9819A2D1F0714F405492412FB5A47804F237A782000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIwLTA4LTI2IGF0IDAxOjQyICswODAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4g
T24gTW9uLCBBdWcgMTcsIDIwMjAgYXQgMTE6MDM6MjFBTSArMDgwMCwgQ3J5c3RhbCBHdW8gd3Jv
dGU6DQo+ID4gaW50cm9kdWNlICdyZXNldCcgbWV0aG9kIHRvIGFsbG93IGRldmljZSBkbyBzZXJp
YWxpemVkIGFzc2VydCBhbmQNCj4gPiBkZWFzc2VydCBvcGVyYXRpb25zIGluIGEgc2luZ2xlIHN0
ZXAsIHdoaWNoIG5lZWRzIGEgbWluaW11bSBkZWxheQ0KPiA+IHRvIGJlIHdhaXRlZCBiZXR3ZWVu
IGFzc2VydCBhbmQgZGVhc3NlcnQuDQo+IA0KPiBXaHkgaXMgTWVkaWF0ZWsgYWRkaW5nIHRvIGEg
VEkgYmluZGluZz8NCg0KVEkgcmVzZXQtY29udHJvbGxlciBwcm92aWRlcyBhIGNvbW1vbiByZXNl
dCBtYW5hZ2VtZW50LA0KYW5kIGlzIHN1aXRhYmxlIGZvciBNZWRpYXRlayBTb0NzLCB0aHVzIE1l
ZGlhdGVrIHdhbnRzIHRvIHJldXNlIHRoaXMNCmRyaXZlciBmb3IgcmVzZXQuDQoNCj4gDQo+ID4g
DQo+ID4gU2lnbmVkLW9mZi1ieTogQ3J5c3RhbCBHdW8gPGNyeXN0YWwuZ3VvQG1lZGlhdGVrLmNv
bT4NCj4gPiAtLS0NCj4gPiAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Jlc2V0
L3RpLXN5c2Nvbi1yZXNldC50eHQgfCA1ICsrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA1IGlu
c2VydGlvbnMoKykNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL3Jlc2V0L3RpLXN5c2Nvbi1yZXNldC50eHQgYi9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvcmVzZXQvdGktc3lzY29uLXJlc2V0LnR4dA0KPiA+IGluZGV4IDg2
OTQ1NTAyY2NiNS4uYWIwNDEwMzIzMzliIDEwMDY0NA0KPiA+IC0tLSBhL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9yZXNldC90aS1zeXNjb24tcmVzZXQudHh0DQo+ID4gKysrIGIv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Jlc2V0L3RpLXN5c2Nvbi1yZXNldC50
eHQNCj4gPiBAQCAtNTksNiArNTksMTEgQEAgUmVxdWlyZWQgcHJvcGVydGllczoNCj4gPiAgUGxl
YXNlIGFsc28gcmVmZXIgdG8gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Jlc2V0
L3Jlc2V0LnR4dCBmb3INCj4gPiAgY29tbW9uIHJlc2V0IGNvbnRyb2xsZXIgdXNhZ2UgYnkgY29u
c3VtZXJzLg0KPiA+ICANCj4gPiArT3B0aW9uYWwgcHJvcGVydGllczoNCj4gPiArLSByZXNldC1k
dXJhdGlvbi11czogV2hlbiBkbyBzZXJpYWxpemVkIGFzc2VydCBhbmQgZGVhc3NlcnQgb3BlcmF0
aW9ucywgbWluaW11bSBkZWxheSBpbiBtaWNyb3NlY29uZHMNCj4gPiAraXMgbmVlZGVkIHRvIGJl
IHdhaXRlZCBiZXR3ZWVuIGFuIGFzc2VydCBhbmQgYSBkZWFzc2VydCB0byByZXNldCB0aGUgZGV2
aWNlLiBUaGlzIHZhbHVlIGNhbiBiZSAwLCAwIG1lYW5zDQo+ID4gK3RoYXQgc3VjaCBhIGRlbGF5
IGlzIG5vdCBuZWVkZWQuDQo+IA0KPiBUaGlzIGdvZXMgaW4gdGhlIHJlc2V0IGNvbnRyb2xsZXIg
bm9kZSBvciBlYWNoIGNvbnN1bWVyPyBGb3IgdGhlIGxhdHRlciwgDQo+IGl0IHNob3VsZCBiZSBh
IGNlbGwgaW4gJ3Jlc2V0cycgaWYgeW91IG5lZWQgdGhpcy4gQnV0IHJlYWxseSwgSSB0aGluayAN
Cj4gdGhlIHJlc2V0IGNvbnRyb2xsZXIgc2hvdWxkIGVuZm9yY2Ugc29tZSBtaW5pbXVtIHRpbWUg
dGhhdCB3b3JrcyBmb3IgYWxsIA0KPiBjb25zdW1lcnMuIFN1cmVseSBoYXZpbmcgYSBtaW5pbXVt
IHRpbWUgcGVyIHJlc2V0IGlzbid0IHJlYWxseSBuZWVkZWQuDQo+IA0KPiBSb2INCg0KJ3Jlc2V0
LWR1cmF0aW9uLXVzJyB3aWxsIGJlIGluIHRoZSByZXNldCBjb250cm9sbGVyIG5vZGUsIGFuZCBp
dCdzDQpvcHRpb25hbC4gSWYgbWluaW11bSBkZWxheSBpcyBuZWVkZWQgdG8gYmUgd2FpdGVkIGJl
dHdlZW4gYW4gYXNzZXJ0IGFuZA0KYSBkZWFzc2VydCB0byByZXNldCB0aGUgZGV2aWNlLCB0aGlz
IHByb3BlcnR5IHdpbGwgYmUgc2V0Lk90aGVyd2lzZSBubw0KbmVlZCB0byBzZXQgdGhpcyBwcm9w
ZXJ0eS4NCg0KQmVzdCBSZWdhcmRzDQpDcnlzdGFsDQoNCg==

