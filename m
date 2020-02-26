Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F3FC4BA0B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 01:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 340AA222C2
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 01:40:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="tnz5CLGQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729727AbgBZBkV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 20:40:21 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:17658 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729376AbgBZBkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 20:40:21 -0500
X-UUID: bce5fd9329344851bbfd60d17dc936bf-20200226
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=QnRmFmzK3QiGsyx/wln05rmuo5QWWRZM/E9WOlCyH1w=;
        b=tnz5CLGQO8+9JnX2NcIXJCQ3ueoUvYbl5ftp63xkrs5Bcf8kPoGWhq348JVrZaQhs7izOTbhOZTFYNSQWzesWQCAVyxoRbVkxLBH2eH4UmmZqjkCr8OXVzqMF1mSCYylSOMncO8edY9b/Ss1cFMxi3VvP0p2r3Ie3koSCQ4IA+k=;
X-UUID: bce5fd9329344851bbfd60d17dc936bf-20200226
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 393327314; Wed, 26 Feb 2020 09:40:13 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 26 Feb 2020 09:39:10 +0800
Received: from [172.21.77.4] (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 26 Feb 2020 09:37:55 +0800
Message-ID: <1582681211.16944.2.camel@mtksdaap41>
Subject: Re: [PATCH v8 2/7] dt-bindings: display: mediatek: update dpi
 supported chips
From:   CK Hu <ck.hu@mediatek.com>
To:     Rob Herring <robh@kernel.org>, Jitao Shi <jitao.shi@mediatek.com>
CC:     Mark Rutland <mark.rutland@arm.com>,
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
Date:   Wed, 26 Feb 2020 09:40:11 +0800
In-Reply-To: <20200225171052.GA6002@bogus>
References: <20200225094057.120144-1-jitao.shi@mediatek.com>
         <20200225094057.120144-3-jitao.shi@mediatek.com>
         <20200225171052.GA6002@bogus>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIwLTAyLTI1IGF0IDExOjEwIC0wNjAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4g
T24gVHVlLCAyNSBGZWIgMjAyMCAxNzo0MDo1MiArMDgwMCwgSml0YW8gU2hpIHdyb3RlOg0KPiA+
IEFkZCBkZXNjcmlwdGlvbnMgYWJvdXQgc3VwcG9ydGVkIGNoaXBzLCBpbmNsdWRpbmcgTVQyNzAx
ICYgTVQ4MTczICYNCj4gPiBtdDgxODMNCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBKaXRhbyBT
aGkgPGppdGFvLnNoaUBtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4gIC4uLi9kZXZpY2V0cmVl
L2JpbmRpbmdzL2Rpc3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWssZHBpLnR4dCAgICAgICAgfCAxICsN
Cj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+ID4gDQo+IA0KPiBQbGVhc2Ug
YWRkIEFja2VkLWJ5L1Jldmlld2VkLWJ5IHRhZ3Mgd2hlbiBwb3N0aW5nIG5ldyB2ZXJzaW9ucy4g
SG93ZXZlciwNCj4gdGhlcmUncyBubyBuZWVkIHRvIHJlcG9zdCBwYXRjaGVzICpvbmx5KiB0byBh
ZGQgdGhlIHRhZ3MuIFRoZSB1cHN0cmVhbQ0KPiBtYWludGFpbmVyIHdpbGwgZG8gdGhhdCBmb3Ig
YWNrcyByZWNlaXZlZCBvbiB0aGUgdmVyc2lvbiB0aGV5IGFwcGx5Lg0KPiANCj4gSWYgYSB0YWcg
d2FzIG5vdCBhZGRlZCBvbiBwdXJwb3NlLCBwbGVhc2Ugc3RhdGUgd2h5IGFuZCB3aGF0IGNoYW5n
ZWQuDQoNCkkgdGhpbmsgdGhpcyB2ZXJzaW9uIGlzIHRoZSBzYW1lIGFzIHYzIFsxXSB3aGljaCBo
YXMgYmVlbiByZXZpZXdlZCBieQ0KUm9iLCBzbyBJIGFwcGxpZWQgdGhpcyBwYXRjaCBpIG1lZGlh
dGVrLWRybS1uZXh0LTUuNyBbMl0sIHRoYW5rcy4NCg0KWzFdIGh0dHBzOi8vcGF0Y2h3b3JrLmtl
cm5lbC5vcmcvcGF0Y2gvMTA5MDE5NzEvDQpbMl0NCmh0dHBzOi8vZ2l0aHViLmNvbS9ja2h1LW1l
ZGlhdGVrL2xpbnV4LmdpdC10YWdzL2NvbW1pdHMvbWVkaWF0ZWstZHJtLW5leHQtNS43DQoNClJl
Z2FyZHMsDQpDSw0K

