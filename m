Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE33C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 14:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2765B20722
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 14:21:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="iDvNp8x5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729269AbgGFOVQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 10:21:16 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:65207 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729140AbgGFOVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 10:21:16 -0400
X-UUID: ef53f8de7e3146d1b4dba97de3107d3a-20200706
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=OXs1SySUuohRlkO/f7ZMQ1WQrymho9U6t0SKN8dmd0A=;
        b=iDvNp8x5hX0ZvvrjeLDjd0lBU/8azwNDYfNE+Dpei8W/G+GY/nWS1Dqxho2/2Zf7k3lmB4ZPURCOLNkvhVZAVdUk2iP825BmmTZyJpZ/mfRIMasNvCN6EGtNsDhCuZngUJPmxYlXYw6fL0c2mvhp8XXYu0t2W04JB5NYQkTPAgM=;
X-UUID: ef53f8de7e3146d1b4dba97de3107d3a-20200706
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 763318562; Mon, 06 Jul 2020 22:21:13 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 6 Jul 2020 22:21:06 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 6 Jul 2020 22:21:07 +0800
Message-ID: <1594045270.19205.4.camel@mtkswgap22>
Subject: Re: [PATCH v2 1/8] soc: mediatek: cmdq: add address shift in jump
From:   Dennis-YC Hsieh <dennis-yc.hsieh@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, CK Hu <ck.hu@mediatek.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>,
        HS Liao <hs.liao@mediatek.com>
Date:   Mon, 6 Jul 2020 22:21:10 +0800
In-Reply-To: <31a41c40-10f5-260d-cebd-7cc2a432095d@gmail.com>
References: <1593931715-32761-1-git-send-email-dennis-yc.hsieh@mediatek.com>
         <1593931715-32761-2-git-send-email-dennis-yc.hsieh@mediatek.com>
         <31a41c40-10f5-260d-cebd-7cc2a432095d@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: D9D74A0864D11FB68CC9C721CD27F57DA020E8AE1AAB324BDCC36D49191540CF2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWF0dGhpYXMsDQoNCnRoYW5rcyBmb3IgeW91ciBjb21tZW50DQoNCk9uIE1vbiwgMjAyMC0w
Ny0wNiBhdCAxNjowMyArMDIwMCwgTWF0dGhpYXMgQnJ1Z2dlciB3cm90ZToNCj4gDQo+IE9uIDA1
LzA3LzIwMjAgMDg6NDgsIERlbm5pcyBZQyBIc2llaCB3cm90ZToNCj4gPiBBZGQgYWRkcmVzcyBz
aGlmdCB3aGVuIGNvbXBvc2UganVtcCBpbnN0cnVjdGlvbg0KPiA+IHRvIGNvbXBhdGlibGUgd2l0
aCAzNWJpdCBmb3JtYXQuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogRGVubmlzIFlDIEhzaWVo
IDxkZW5uaXMteWMuaHNpZWhAbWVkaWF0ZWsuY29tPg0KPiANCj4gWW91IGFyZSBtaXNzaW5nIEJp
YmJ5J3MgUmV2aWV3ZWQtYnkuIFBsZWFzZSBob25vdXIgdGhlIGVmZm9ydCByZXZpZXdlcnMgZG8g
YnkNCj4gYWRkaW5nIHRoZSBhcHByb3ByaWF0ZSB0YWdzLg0KPiANCj4gUGxlYXNlIGRvdWJsZSBj
aGVjayB0aGUgc2VyaWVzIGFuZCByZXNlbmQgd2l0aCBhbGwgdGFncyBhZGRlZC4NCj4gDQo+IEFs
c28sIGl0IHdvdWxkIGJlIGdvb2QgaWYgeW91IGNvdWxkIHByb3ZpZGUgYSBjaGFuZ2UgbG9nLiBU
aGF0IG1ha2VzIGl0IGVhc2llcg0KPiBmb3IgdGhlIG1haW50YWluZXIgdG8gc2VlIHdoaWNoIHN0
YXRlbWVudHMgeW91IGFkZHJlc3NlZC4NCg0KdGhpcyBwYXRjaCBjaGFuZ2VkIHNpbmNlIGNtZHFf
bWJveF9zaGlmdCgpIHJlbmFtZSB0byBjbWRxX2dldF9zaGlmdF9wYSgpDQpieSBCaWJieSdzIGNv
bW1lbnQgWzFdLCBzbyBJIHJlbW92ZWQgcmV2aWV3ZWQgdGFncyBmcm9tIHRoaXMgcGF0Y2guDQoN
CkknbGwgcHJvdmlkZSBjaGFuZ2UgbG9nIHRvIHRoaXMgcGF0Y2ggYW5kIHJlc2VuZCBsYXRlciwg
dGhhbmtzLg0KDQpbMV0NCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL3BpcGVybWFpbC9saW51
eC1tZWRpYXRlay8yMDIwLUp1bmUvMDEzMzg3Lmh0bWwNCg0KDQpSZWdhcmRzLA0KRGVubmlzDQoN
Cj4gDQo+IFRoYW5rcywNCj4gTWF0dGhpYXMNCj4gDQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvc29j
L21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jIHwgICAgMyArKy0NCj4gPiAgMSBmaWxlIGNoYW5n
ZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYyBiL2RyaXZlcnMvc29jL21l
ZGlhdGVrL210ay1jbWRxLWhlbHBlci5jDQo+ID4gaW5kZXggZGM2NDRjZmI2NDE5Li45ZmFmNzhm
YmVkM2EgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVs
cGVyLmMNCj4gPiArKysgYi9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYw0K
PiA+IEBAIC0zMjksNyArMzI5LDggQEAgaW50IGNtZHFfcGt0X2ZpbmFsaXplKHN0cnVjdCBjbWRx
X3BrdCAqcGt0KQ0KPiA+ICANCj4gPiAgCS8qIEpVTVAgdG8gZW5kICovDQo+ID4gIAlpbnN0Lm9w
ID0gQ01EUV9DT0RFX0pVTVA7DQo+ID4gLQlpbnN0LnZhbHVlID0gQ01EUV9KVU1QX1BBU1M7DQo+
ID4gKwlpbnN0LnZhbHVlID0gQ01EUV9KVU1QX1BBU1MgPj4NCj4gPiArCQljbWRxX2dldF9zaGlm
dF9wYSgoKHN0cnVjdCBjbWRxX2NsaWVudCAqKXBrdC0+Y2wpLT5jaGFuKTsNCj4gPiAgCWVyciA9
IGNtZHFfcGt0X2FwcGVuZF9jb21tYW5kKHBrdCwgaW5zdCk7DQo+ID4gIA0KPiA+ICAJcmV0dXJu
IGVycjsNCj4gPiANCg0K

