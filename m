Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AE44C54E8E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 06:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79E532192A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 06:02:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="XgEvgHZH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728566AbgEKGC1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 02:02:27 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:63895 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725916AbgEKGC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 02:02:27 -0400
X-UUID: bcf760d93a5643c68a53d6605df7a878-20200511
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=KXbgKqeV1jVjM680D36sEteF5YwDhnYQQbhiljtwUfA=;
        b=XgEvgHZHesGhebPzMCYukgw1TLEmPm8Yjvynb3rikJ0PItXUNPlk/p0YMex37B/wfkJveNcwB0e3Wh9ek5WElssz4/qNkvLQ443NiDlGE2srSZ7IvdGKpeHomWdAtWSEjJlCS1R6S7WKwCZUHHdli2PfIbZnczFh1iUtLrr4rcs=;
X-UUID: bcf760d93a5643c68a53d6605df7a878-20200511
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1432146354; Mon, 11 May 2020 14:02:24 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 11 May 2020 14:00:50 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 11 May 2020 14:00:50 +0800
Message-ID: <1589176850.21832.7.camel@mtksdaap41>
Subject: Re: [PATCH v14 01/11] dt-bindings: mediatek: Add property to mt8183
 smi-common
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
CC:     Enric Balletbo Serra <eballetbo@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        "Rob Herring" <robh@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        James Liao <jamesjj.liao@mediatek.com>,
        <srv_heupstream@mediatek.com>, <linux-kernel@vger.kernel.org>,
        Fan Chen <fan.chen@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>
Date:   Mon, 11 May 2020 14:00:50 +0800
In-Reply-To: <7165ec9f-03ca-3020-2c34-246465094c46@collabora.com>
References: <1588752963-19934-1-git-send-email-weiyi.lu@mediatek.com>
         <1588752963-19934-2-git-send-email-weiyi.lu@mediatek.com>
         <7165ec9f-03ca-3020-2c34-246465094c46@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: E8D7064CEC30C202B634F9239908F66108878567A329A3426389968E2E92D1EB2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiBXZWQsIDIwMjAtMDUtMDYgYXQgMjI6NTkgKzAyMDAsIEVucmljIEJhbGxldGJvIGkgU2Vy
cmEgd3JvdGU6DQo+IEhpIFdlaXlpLA0KPiANCj4gVGhhbmsgeW91IGZvciB5b3VyIHBhdGNoLiBE
b24ndCBmb3JnZXQgdG8gY2MgPGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnPiwNCj4gb3RoZXJ3
aXNlIHRoaXMgcGF0Y2ggY291bGQgYmUgc2lsZW50bHkgaWdub3JlZC4NCj4gDQoNClRoYW5rIHlv
dSBmb3IgcmVtaW5kaW5nIQ0KDQo+IE9uIDYvNS8yMCAxMDoxNSwgV2VpeWkgTHUgd3JvdGU6DQo+
ID4gRm9yIHNjcHN5cyBkcml2ZXIgdXNpbmcgcmVnbWFwIGJhc2VkIHN5c2NvbiBkcml2ZXIgQVBJ
Lg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IFdlaXlpIEx1IDx3ZWl5aS5sdUBtZWRpYXRlay5j
b20+DQo+ID4gLS0tDQo+ID4gIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL21lbW9yeS1jb250cm9s
bGVycy9tZWRpYXRlayxzbWktY29tbW9uLnR4dCAgICAgIHwgMiArLQ0KPiA+ICAxIGZpbGUgY2hh
bmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0
IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21lbW9yeS1jb250cm9sbGVycy9t
ZWRpYXRlayxzbWktY29tbW9uLnR4dCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9tZW1vcnktY29udHJvbGxlcnMvbWVkaWF0ZWssc21pLWNvbW1vbi50eHQNCj4gPiBpbmRleCBi
NDc4YWRlLi4wMTc0NGVjIDEwMDY0NA0KPiA+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9tZW1vcnktY29udHJvbGxlcnMvbWVkaWF0ZWssc21pLWNvbW1vbi50eHQNCj4g
PiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWVtb3J5LWNvbnRyb2xs
ZXJzL21lZGlhdGVrLHNtaS1jb21tb24udHh0DQo+ID4gQEAgLTIwLDcgKzIwLDcgQEAgUmVxdWly
ZWQgcHJvcGVydGllczoNCj4gPiAgCSJtZWRpYXRlayxtdDI3MTItc21pLWNvbW1vbiINCj4gPiAg
CSJtZWRpYXRlayxtdDc2MjMtc21pLWNvbW1vbiIsICJtZWRpYXRlayxtdDI3MDEtc21pLWNvbW1v
biINCj4gPiAgCSJtZWRpYXRlayxtdDgxNzMtc21pLWNvbW1vbiINCj4gPiAtCSJtZWRpYXRlayxt
dDgxODMtc21pLWNvbW1vbiINCj4gPiArCSJtZWRpYXRlayxtdDgxODMtc21pLWNvbW1vbiIsICJz
eXNjb24iDQo+ID4gIC0gcmVnIDogdGhlIHJlZ2lzdGVyIGFuZCBzaXplIG9mIHRoZSBTTUkgYmxv
Y2suDQo+ID4gIC0gcG93ZXItZG9tYWlucyA6IGEgcGhhbmRsZSB0byB0aGUgcG93ZXIgZG9tYWlu
IG9mIHRoaXMgbG9jYWwgYXJiaXRlci4NCj4gPiAgLSBjbG9ja3MgOiBNdXN0IGNvbnRhaW4gYW4g
ZW50cnkgZm9yIGVhY2ggZW50cnkgaW4gY2xvY2stbmFtZXMuDQo+ID4gDQoNCg0K

