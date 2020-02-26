Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5619C4BA0A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 01:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D55E20732
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 01:52:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ePc0xyAX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729989AbgBZBwZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 20:52:25 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:33482 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729465AbgBZBwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 20:52:24 -0500
X-UUID: 2d1bb0ba50104defa79f6ba5fe505fd8-20200226
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=U5dy4O9U1YCjMd3HfOjbAbPOYUVKV3VTQCaAPmr7dCw=;
        b=ePc0xyAXZnVrqibKNf4RZHSMGGRdn3Xdc5kY6BOrdY9gvxftmUulSAII38L6w1ezwq+jm6iPlc1i996Nsgo1oN2Oop0Bmk6DXw/q7hcg3anMxUzUBdo9KexkKm9AwCNezj27haHts3vArf5LN0Y4Km9aD/YTn5nqjJZf3snbSWA=;
X-UUID: 2d1bb0ba50104defa79f6ba5fe505fd8-20200226
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1999958798; Wed, 26 Feb 2020 09:52:21 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 26 Feb 2020 09:51:31 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 26 Feb 2020 09:52:29 +0800
Message-ID: <1582681939.16944.4.camel@mtksdaap41>
Subject: Re: [PATCH v8 1/7] dt-bindings: media: add pclk-sample dual edge
 property
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
Date:   Wed, 26 Feb 2020 09:52:19 +0800
In-Reply-To: <20200225094057.120144-2-jitao.shi@mediatek.com>
References: <20200225094057.120144-1-jitao.shi@mediatek.com>
         <20200225094057.120144-2-jitao.shi@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIwLTAyLTI1IGF0IDE3OjQwICswODAwLCBKaXRhbyBTaGkgd3JvdGU6DQo+IFNv
bWUgY2hpcHMncyBzYW1wbGUgbW9kZSBhcmUgcmlzaW5nLCBmYWxsaW5nIGFuZCBkdWFsIGVkZ2Ug
KGJvdGgNCj4gZmFsbGluZyBhbmQgcmlzaW5nIGVkZ2UpLg0KPiBFeHRlcm4gdGhlIHBjbGstc2Ft
cGxlIHByb3BlcnR5IHRvIHN1cHBvcnQgZHVhbCBlZGdlLg0KPiANCg0KUmV2aWV3ZWQtYnk6IENL
IEh1IDxjay5odUBtZWRpYXRlay5jb20+DQoNCj4gU2lnbmVkLW9mZi1ieTogSml0YW8gU2hpIDxq
aXRhby5zaGlAbWVkaWF0ZWsuY29tPg0KPiAtLS0NCj4gIERvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9tZWRpYS92aWRlby1pbnRlcmZhY2VzLnR4dCB8IDQgKystLQ0KPiAgMSBmaWxl
IGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1n
aXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWVkaWEvdmlkZW8taW50ZXJm
YWNlcy50eHQgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWVkaWEvdmlkZW8t
aW50ZXJmYWNlcy50eHQNCj4gaW5kZXggZjg4NGFkYTBiZmZjLi5kYTlhZDI0OTM1ZGIgMTAwNjQ0
DQo+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZWRpYS92aWRlby1p
bnRlcmZhY2VzLnR4dA0KPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
bWVkaWEvdmlkZW8taW50ZXJmYWNlcy50eHQNCj4gQEAgLTExOCw4ICsxMTgsOCBAQCBPcHRpb25h
bCBlbmRwb2ludCBwcm9wZXJ0aWVzDQo+ICAtIGRhdGEtZW5hYmxlLWFjdGl2ZTogc2ltaWxhciB0
byBIU1lOQyBhbmQgVlNZTkMsIHNwZWNpZmllcyB0aGUgZGF0YSBlbmFibGUNCj4gICAgc2lnbmFs
IHBvbGFyaXR5Lg0KPiAgLSBmaWVsZC1ldmVuLWFjdGl2ZTogZmllbGQgc2lnbmFsIGxldmVsIGR1
cmluZyB0aGUgZXZlbiBmaWVsZCBkYXRhIHRyYW5zbWlzc2lvbi4NCj4gLS0gcGNsay1zYW1wbGU6
IHNhbXBsZSBkYXRhIG9uIHJpc2luZyAoMSkgb3IgZmFsbGluZyAoMCkgZWRnZSBvZiB0aGUgcGl4
ZWwgY2xvY2sNCj4gLSAgc2lnbmFsLg0KPiArLSBwY2xrLXNhbXBsZTogc2FtcGxlIGRhdGEgb24g
cmlzaW5nICgxKSwgZmFsbGluZyAoMCkgb3IgYm90aCByaXNpbmcgYW5kDQo+ICsgIGZhbGxpbmcg
KDIpIGVkZ2Ugb2YgdGhlIHBpeGVsIGNsb2NrIHNpZ25hbC4NCj4gIC0gc3luYy1vbi1ncmVlbi1h
Y3RpdmU6IGFjdGl2ZSBzdGF0ZSBvZiBTeW5jLW9uLWdyZWVuIChTb0cpIHNpZ25hbCwgMC8xIGZv
cg0KPiAgICBMT1cvSElHSCByZXNwZWN0aXZlbHkuDQo+ICAtIGRhdGEtbGFuZXM6IGFuIGFycmF5
IG9mIHBoeXNpY2FsIGRhdGEgbGFuZSBpbmRleGVzLiBQb3NpdGlvbiBvZiBhbiBlbnRyeQ0KDQo=

