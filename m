Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 534B8C4BA0B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 01:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 243AF20732
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 01:54:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="JElzA3PP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729854AbgBZByN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 20:54:13 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:31114 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729465AbgBZByM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 20:54:12 -0500
X-UUID: 1ce9fd4fe5b7447e90befb178f901fde-20200226
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=fmtsNN0uSeJVYQhys/t7YS9quDrs4iXg3LaXINTkW+w=;
        b=JElzA3PP4ihq7INUOdakeWAiHRQHgqZbV4WX8RA1Dmepd8u2G6C7t71wdOR3ZY6a+8Hhm6XDarQexNAwKxidtJCKrNbzYq12nsXgW7uybUYSv8bfhkne/COUU2EhzGREXXFZQhWFos/rkTfNMfEbRDl8C3RrcEHUm5cScNq3aUY=;
X-UUID: 1ce9fd4fe5b7447e90befb178f901fde-20200226
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 571004529; Wed, 26 Feb 2020 09:54:08 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 26 Feb 2020 09:52:50 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 26 Feb 2020 09:54:15 +0800
Message-ID: <1582682045.16944.5.camel@mtksdaap41>
Subject: Re: [PATCH v8 3/7] dt-bindings: display: mediatek: control dpi pins
 mode to avoid leakage
From:   CK Hu <ck.hu@mediatek.com>
To:     Jitao Shi <jitao.shi@mediatek.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <yingjoe.chen@mediatek.com>,
        <eddie.huang@mediatek.com>, <cawa.cheng@mediatek.com>,
        <bibby.hsieh@mediatek.com>, <stonea168@163.com>,
        <huijuan.xie@mediatek.com>
Date:   Wed, 26 Feb 2020 09:54:05 +0800
In-Reply-To: <20200225094057.120144-4-jitao.shi@mediatek.com>
References: <20200225094057.120144-1-jitao.shi@mediatek.com>
         <20200225094057.120144-4-jitao.shi@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIwLTAyLTI1IGF0IDE3OjQwICswODAwLCBKaXRhbyBTaGkgd3JvdGU6DQo+IEFk
ZCBwcm9wZXJ0eSAicGluY3RybC1uYW1lcyIgdG8gc3dhcCBwaW4gbW9kZSBiZXR3ZWVuIGdwaW8g
YW5kIGRwaSBtb2RlLiBTZXQNCj4gcGluIG1vZGUgdG8gZ3BpbyBvdXBwdXQtbG93IHRvIGF2b2lk
IGxlYWthZ2UgY3VycmVudCB3aGVuIGRwaSBkaXNhYmxlLg0KPiANCg0KUmV2aWV3ZWQtYnk6IENL
IEh1IDxjay5odUBtZWRpYXRlay5jb20+DQoNCj4gU2lnbmVkLW9mZi1ieTogSml0YW8gU2hpIDxq
aXRhby5zaGlAbWVkaWF0ZWsuY29tPg0KPiAtLS0NCj4gIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdz
L2Rpc3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWssZHBpLnR4dCAgfCA3ICsrKysrKysNCj4gIDEgZmls
ZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9tZWRpYXRlay9tZWRpYXRlayxkcGkudHh0
IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvbWVkaWF0ZWsvbWVk
aWF0ZWssZHBpLnR4dA0KPiBpbmRleCA1ODkxNGNmNjgxYjguLmE3YjFiOGJmYjY1ZSAxMDA2NDQN
Cj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvbWVkaWF0
ZWsvbWVkaWF0ZWssZHBpLnR4dA0KPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvZGlzcGxheS9tZWRpYXRlay9tZWRpYXRlayxkcGkudHh0DQo+IEBAIC0xNyw2ICsxNywx
MCBAQCBSZXF1aXJlZCBwcm9wZXJ0aWVzOg0KPiAgICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvZ3JhcGgudHh0LiBUaGlzIHBvcnQgc2hvdWxkIGJlIGNvbm5lY3RlZA0KPiAgICB0
byB0aGUgaW5wdXQgcG9ydCBvZiBhbiBhdHRhY2hlZCBIRE1JIG9yIExWRFMgZW5jb2RlciBjaGlw
Lg0KPiAgDQo+ICtPcHRpb25hbCBwcm9wZXJ0aWVzOg0KPiArLSBwaW5jdHJsLW5hbWVzOiBDb250
YWluICJncGlvbW9kZSIgYW5kICJkcGltb2RlIi4NCj4gKyAgcGluY3RybC1uYW1lcyBzZWUgRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BpbmN0cmxwaW5jdHJsLWJpbmRpbmdzLnR4
dA0KPiArDQo+ICBFeGFtcGxlOg0KPiAgDQo+ICBkcGkwOiBkcGlAMTQwMWQwMDAgew0KPiBAQCAt
MjcsNiArMzEsOSBAQCBkcGkwOiBkcGlAMTQwMWQwMDAgew0KPiAgCQkgPCZtbXN5cyBDTEtfTU1f
RFBJX0VOR0lORT4sDQo+ICAJCSA8JmFwbWl4ZWRzeXMgQ0xLX0FQTUlYRURfVFZEUExMPjsNCj4g
IAljbG9jay1uYW1lcyA9ICJwaXhlbCIsICJlbmdpbmUiLCAicGxsIjsNCj4gKwlwaW5jdHJsLW5h
bWVzID0gImdwaW9tb2RlIiwgImRwaW1vZGUiOw0KPiArCXBpbmN0cmwtMCA9IDwmZHBpX3Bpbl9n
cGlvPjsNCj4gKwlwaW5jdHJsLTEgPSA8JmRwaV9waW5fZnVuYz47DQo+ICANCj4gIAlwb3J0IHsN
Cj4gIAkJZHBpMF9vdXQ6IGVuZHBvaW50IHsNCg0K

