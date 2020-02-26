Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ECE3C4BA0A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 08:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 635D720714
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 08:11:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="P0FLNMHf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbgBZILz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 03:11:55 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:3030 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727591AbgBZILz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 03:11:55 -0500
X-UUID: 2c6a18f2fbf34161a63d93c2b0500c6a-20200226
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=nmvexf8wPTTC/sBsarWrbzfbzx8vw18pW+m/9vRVm3Y=;
        b=P0FLNMHf4yn6FR6P5s1ZeaR744SGgTubTHcQzl0GEYbpR6PO/qJTh9OTj24ZK/ruVMHWfnP5IvBrEzgmWdj2kSLdiaywyt2mnoYZtFce2toxlE5mhgaJpheM6QkyZ/jAmBi+jDc149WS7Odv/ebWMapqcdtgLhjz505Kbis4Cys=;
X-UUID: 2c6a18f2fbf34161a63d93c2b0500c6a-20200226
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1278026201; Wed, 26 Feb 2020 16:11:49 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 26 Feb 2020 16:09:46 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 26 Feb 2020 16:11:47 +0800
Message-ID: <1582704699.11957.0.camel@mtksdaap41>
Subject: Re: [PATCH v9 3/5] dt-bindings: display: mediatek: dpi sample data
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
Date:   Wed, 26 Feb 2020 16:11:39 +0800
In-Reply-To: <20200226053238.31646-4-jitao.shi@mediatek.com>
References: <20200226053238.31646-1-jitao.shi@mediatek.com>
         <20200226053238.31646-4-jitao.shi@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEppdGFvOg0KDQpPbiBXZWQsIDIwMjAtMDItMjYgYXQgMTM6MzIgKzA4MDAsIEppdGFvIFNo
aSB3cm90ZToNCj4gQWRkIHByb3BlcnR5ICJwY2xrLXNhbXBsZSIgdG8gY29uZmlnIHRoZSBkcGkg
c2FtcGxlIG9uIGZhbGxpbmcgKDApLA0KPiByaXNpbmcgKDEpLCBib3RoIGZhbGxpbmcgYW5kIHJp
c2luZyAoMikuDQo+IA0KDQpSZXZpZXdlZC1ieTogQ0sgSHUgPGNrLmh1QG1lZGlhdGVrLmNvbT4N
Cg0KPiBTaWduZWQtb2ZmLWJ5OiBKaXRhbyBTaGkgPGppdGFvLnNoaUBtZWRpYXRlay5jb20+DQo+
IC0tLQ0KPiAgLi4uL2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9tZWRpYXRlay9tZWRpYXRl
ayxkcGkudHh0ICAgICAgIHwgMiArKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygr
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9k
aXNwbGF5L21lZGlhdGVrL21lZGlhdGVrLGRwaS50eHQgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvZGlzcGxheS9tZWRpYXRlay9tZWRpYXRlayxkcGkudHh0DQo+IGluZGV4IGE3
YjFiOGJmYjY1ZS4uNDI5OWFhMWFkZjQ1IDEwMDY0NA0KPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9tZWRpYXRlay9tZWRpYXRlayxkcGkudHh0DQo+ICsr
KyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5L21lZGlhdGVrL21l
ZGlhdGVrLGRwaS50eHQNCj4gQEAgLTIwLDYgKzIwLDcgQEAgUmVxdWlyZWQgcHJvcGVydGllczoN
Cj4gIE9wdGlvbmFsIHByb3BlcnRpZXM6DQo+ICAtIHBpbmN0cmwtbmFtZXM6IENvbnRhaW4gImdw
aW9tb2RlIiBhbmQgImRwaW1vZGUiLg0KPiAgICBwaW5jdHJsLW5hbWVzIHNlZSBEb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGluY3RybHBpbmN0cmwtYmluZGluZ3MudHh0DQo+ICst
IHBjbGstc2FtcGxlOiByZWZlciBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWVk
aWEvdmlkZW8taW50ZXJmYWNlcy50eHQuDQo+ICANCj4gIEV4YW1wbGU6DQo+ICANCj4gQEAgLTM3
LDYgKzM4LDcgQEAgZHBpMDogZHBpQDE0MDFkMDAwIHsNCj4gIA0KPiAgCXBvcnQgew0KPiAgCQlk
cGkwX291dDogZW5kcG9pbnQgew0KPiArCQkJcGNsay1zYW1wbGUgPSAwOw0KPiAgCQkJcmVtb3Rl
LWVuZHBvaW50ID0gPCZoZG1pMF9pbj47DQo+ICAJCX07DQo+ICAJfTsNCg0K

