Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D10AC2D0EF
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 07:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EE7C206F6
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 07:10:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="pl3sFafD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729834AbgCaHKf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 03:10:35 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:47018 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726420AbgCaHKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 03:10:35 -0400
X-UUID: 72369b837d594f6ba68a801989bb2769-20200331
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=tjPRKJwv3JpOCljaRUaL4xSBagZpOnRqSFRVswzw7Gs=;
        b=pl3sFafDlzdqzPr2tiyYdnfDuM8e2VR5yyrpb56+s6YCZInYGQz7eFVwID0N/vWNuiQfSKrJ16r2al4CpLWqtCbiNnMbhtayoyFDENSBlRIOj8n088F93u2WgR7jJ774noNjnV32YfBnGiZbOJFLeJ9X+2IurBI/yb5Et7QgAoA=;
X-UUID: 72369b837d594f6ba68a801989bb2769-20200331
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 224437747; Tue, 31 Mar 2020 15:10:23 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33N1.mediatek.inc
 (172.27.4.75) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 31 Mar
 2020 15:10:21 +0800
Received: from [10.16.6.141] (10.16.6.141) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 31 Mar 2020 15:10:19 +0800
Message-ID: <1585638593.31955.5.camel@mszsdaap41>
Subject: Re: [PATCH v3 1/4] dt-bindings: display: mediatek: add property to
 control mipi tx drive current
From:   Jitao Shi <jitao.shi@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <yingjoe.chen@mediatek.com>,
        <eddie.huang@mediatek.com>, <cawa.cheng@mediatek.com>,
        <bibby.hsieh@mediatek.com>, <ck.hu@mediatek.com>,
        <stonea168@163.com>, <huijuan.xie@mediatek.com>
Date:   Tue, 31 Mar 2020 15:09:53 +0800
In-Reply-To: <20200323220033.GA29463@bogus>
References: <20200311074032.119481-1-jitao.shi@mediatek.com>
         <20200311074032.119481-2-jitao.shi@mediatek.com>
         <20200323220033.GA29463@bogus>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 518E88426F51400BDCEE41B35C4881984A15EE42DB8BBE274CDC847E3BBA18762000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiBNb24sIDIwMjAtMDMtMjMgYXQgMTY6MDAgLTA2MDAsIFJvYiBIZXJyaW5nIHdyb3RlOg0K
PiBPbiBXZWQsIE1hciAxMSwgMjAyMCBhdCAwMzo0MDoyOVBNICswODAwLCBKaXRhbyBTaGkgd3Jv
dGU6DQo+ID4gQWRkIGEgcHJvcGVydHkgdG8gY29udHJvbCBtaXBpIHR4IGRyaXZlIGN1cnJlbnQ6
DQo+ID4gImRyaXZlLXN0cmVuZ3RoLW1pY3JvYW1wIg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6
IEppdGFvIFNoaSA8aml0YW8uc2hpQG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAgLi4uL2Rl
dmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9tZWRpYXRlay9tZWRpYXRlayxkc2kudHh0ICAgICB8
IDQgKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspDQo+ID4gDQo+ID4g
ZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5L21l
ZGlhdGVrL21lZGlhdGVrLGRzaS50eHQgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvZGlzcGxheS9tZWRpYXRlay9tZWRpYXRlayxkc2kudHh0DQo+ID4gaW5kZXggYTE5YTZjYzM3
NWVkLi5kNTAxZjlmZjRiMWYgMTAwNjQ0DQo+ID4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL2Rpc3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWssZHNpLnR4dA0KPiA+ICsrKyBi
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5L21lZGlhdGVrL21lZGlh
dGVrLGRzaS50eHQNCj4gPiBAQCAtMzMsNiArMzMsOSBAQCBSZXF1aXJlZCBwcm9wZXJ0aWVzOg0K
PiA+ICAtICNjbG9jay1jZWxsczogbXVzdCBiZSA8MD47DQo+ID4gIC0gI3BoeS1jZWxsczogbXVz
dCBiZSA8MD4uDQo+ID4gIA0KPiA+ICtPcHRpb25hbCBwcm9wZXJ0aWVzOg0KPiA+ICstIGRyaXZl
LXN0cmVuZ3RoLW1pY3JvYW1wOiBhZGp1c3QgZHJpdmluZyBjdXJyZW50LCBzaG91bGQgYmUgMSB+
IDB4Rg0KPiANCj4gVEJDLCAxLTB4ZiBpcyBpbiB1bml0cyBvZiBtaWNyb2FtcHM/IFNvIGEgbWF4
IGRyaXZlIHN0cmVuZ3RoIG9mIDE1dUE/IA0KPiBTZWVtcyBhIGJpdCBsb3cuDQo+IA0KDQpUaGUg
bWluaW11bSBhbXAgaXMgMzAwMCBtYWNyb2FtcHMsICBzdGVwIGlzIDIwMG1hY3JvYW1wcy4NClNv
IHRoZSBkcml2ZSBjdXJyZW50IGlzIDMwMDAgKyAyMDAgKiBkcml2ZS1zdHJlbmd0aC1taWNyb2Ft
cCBhbXBzLg0KDQpJIHdpbGwgdXBkYXRlICJkcml2ZS1zdHJlbmd0aC1taWNyb2FtcCIgZGVmaW5l
IG5leHQgdmVyc2lvbi4NCg0KQlINCkppdGFvDQo+ID4gKw0KPiA+ICBFeGFtcGxlOg0KPiA+ICAN
Cj4gPiAgbWlwaV90eDA6IG1pcGktZHBoeUAxMDIxNTAwMCB7DQo+ID4gQEAgLTQyLDYgKzQ1LDcg
QEAgbWlwaV90eDA6IG1pcGktZHBoeUAxMDIxNTAwMCB7DQo+ID4gIAljbG9jay1vdXRwdXQtbmFt
ZXMgPSAibWlwaV90eDBfcGxsIjsNCj4gPiAgCSNjbG9jay1jZWxscyA9IDwwPjsNCj4gPiAgCSNw
aHktY2VsbHMgPSA8MD47DQo+ID4gKwlkcml2ZS1zdHJlbmd0aC1taWNyb2FtcCA9IDwweDg+Ow0K
PiA+ICB9Ow0KPiA+ICANCj4gPiAgZHNpMDogZHNpQDE0MDFiMDAwIHsNCj4gPiAtLSANCj4gPiAy
LjIxLjANCg0KDQo=

