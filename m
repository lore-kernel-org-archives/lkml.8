Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAAADC4BA06
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 01:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 916E221927
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 01:58:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="KLZEbI3h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730109AbgBZB6v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 20:58:51 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:26066 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727809AbgBZB6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 20:58:51 -0500
X-UUID: 8220794a7cc843d1b721db1695d043d8-20200226
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=ju7q+m3fC5tzr5BkYbHgGDb6f000b3+zmY3EzNVVdc4=;
        b=KLZEbI3htPZmO2LXUp0P9nUMInozvbAKjVyDRUOkMT3feU6gNXCwLlZMaQy8+p2G26GFxcNzCCBvdDAY+dzf75oRfLWs8Sn+LQ5gjXaTebhlCixKxpOMg8sLp/O8+yRaa91Qi6pE3FJSRiTMgpIC7GVEydfmNzT9aodFL2UmoG8=;
X-UUID: 8220794a7cc843d1b721db1695d043d8-20200226
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 487766622; Wed, 26 Feb 2020 09:58:43 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 26 Feb 2020 09:57:45 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 26 Feb 2020 09:58:51 +0800
Message-ID: <1582682322.16944.7.camel@mtksdaap41>
Subject: Re: [PATCH v8 4/7] dt-bindings: display: mediatek: dpi sample data
 in dual edge support
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
Date:   Wed, 26 Feb 2020 09:58:42 +0800
In-Reply-To: <20200225094057.120144-5-jitao.shi@mediatek.com>
References: <20200225094057.120144-1-jitao.shi@mediatek.com>
         <20200225094057.120144-5-jitao.shi@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEppdGFvOg0KDQpPbiBUdWUsIDIwMjAtMDItMjUgYXQgMTc6NDAgKzA4MDAsIEppdGFvIFNo
aSB3cm90ZToNCj4gQWRkIHByb3BlcnR5ICJwY2xrLXNhbXBsZSIgdG8gY29uZmlnIHRoZSBkcGkg
c2FtcGxlIG9uIGZhbGxpbmcgKDApLA0KPiByaXNpbmcgKDEpLCBib3RoIGZhbGxpbmcgYW5kIHJp
c2luZyAoMikuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBKaXRhbyBTaGkgPGppdGFvLnNoaUBtZWRp
YXRlay5jb20+DQo+IC0tLQ0KPiAgLi4uL2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9tZWRp
YXRlay9tZWRpYXRlayxkcGkudHh0ICAgICB8IDQgKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDQg
aW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9kaXNwbGF5L21lZGlhdGVrL21lZGlhdGVrLGRwaS50eHQgYi9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9tZWRpYXRlay9tZWRpYXRlayxkcGkudHh0
DQo+IGluZGV4IGE3YjFiOGJmYjY1ZS4uZjM2MmZmZjUxNDM3IDEwMDY0NA0KPiAtLS0gYS9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9tZWRpYXRlay9tZWRpYXRlayxk
cGkudHh0DQo+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5
L21lZGlhdGVrL21lZGlhdGVrLGRwaS50eHQNCj4gQEAgLTIwLDYgKzIwLDkgQEAgUmVxdWlyZWQg
cHJvcGVydGllczoNCj4gIE9wdGlvbmFsIHByb3BlcnRpZXM6DQo+ICAtIHBpbmN0cmwtbmFtZXM6
IENvbnRhaW4gImdwaW9tb2RlIiBhbmQgImRwaW1vZGUiLg0KPiAgICBwaW5jdHJsLW5hbWVzIHNl
ZSBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGluY3RybHBpbmN0cmwtYmluZGlu
Z3MudHh0DQo+ICstIHBjbGstc2FtcGxlOiAwOiBzYW1wbGUgaW4gZmFsbGluZyBlZGdlLCAxOiBz
YW1wbGUgaW4gcmlzaW5nIGVkZ2UsIDI6IHNhbXBsZQ0KPiArICBpbiBib3RoIGZhbGxpbmcgYW5k
IHJpc2luZyBlZGdlLg0KDQpUaGUgdmFsdWUgaGFzIGJlZW4gZGVmaW5lZCBpbiB2aWRlby1pbnRl
cmZhY2VzLnR4dCwgeW91IG5lZWQgbm90IHRvDQpkZWZpbmUgaXQgYWdhaW4uDQoNClJlZ2FyZHMs
DQpDSw0KDQo+ICsgIHBjbGstc2FtcGxlIHNlZSBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvbWVkaWEvdmlkZW8taW50ZXJmYWNlcy50eHQuDQo+ICANCj4gIEV4YW1wbGU6DQo+ICAN
Cj4gQEAgLTM3LDYgKzQwLDcgQEAgZHBpMDogZHBpQDE0MDFkMDAwIHsNCj4gIA0KPiAgCXBvcnQg
ew0KPiAgCQlkcGkwX291dDogZW5kcG9pbnQgew0KPiArCQkJcGNsay1zYW1wbGUgPSAwOw0KPiAg
CQkJcmVtb3RlLWVuZHBvaW50ID0gPCZoZG1pMF9pbj47DQo+ICAJCX07DQo+ICAJfTsNCg0K

