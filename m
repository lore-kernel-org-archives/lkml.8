Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9066AC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 02:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DE7820739
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 02:35:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="GVGX3u5Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731067AbgFVCfh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jun 2020 22:35:37 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:57959 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726696AbgFVCfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 22:35:37 -0400
X-UUID: f155f083c2404d6d8fb851c228b4ae6f-20200622
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=FsSGkrpcGktQk0blepm9MlOqi1tXM0TjQmxwLvfOsKs=;
        b=GVGX3u5QhgwgoczDFTNcz0mTKWFWVjYRqQMyve0YXTVXfodN/wVn3ufjYEP0kE8n07Dh8GbLEcFGgvi5ENkNhapzz7HsugGCJxk3g/Q1G/plF2DW2K50LEoC+w1xcatS4mLyKFwYZ+i8Wa7PPgDyajgk2NjEDZCqWgZy+qOVMVQ=;
X-UUID: f155f083c2404d6d8fb851c228b4ae6f-20200622
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <bibby.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 206992374; Mon, 22 Jun 2020 10:35:35 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 22 Jun 2020 10:35:32 +0800
Received: from [172.21.77.4] (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 22 Jun 2020 10:35:23 +0800
Message-ID: <1592793333.11692.4.camel@mtksdaap41>
Subject: Re: [PATCH v7 3/4] mailbox: cmdq: support mt6779 gce platform
 definition
From:   Bibby Hsieh <bibby.hsieh@mediatek.com>
To:     Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        CK Hu <ck.hu@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        HS Liao <hs.liao@mediatek.com>
Date:   Mon, 22 Jun 2020 10:35:33 +0800
In-Reply-To: <1592745731-14614-4-git-send-email-dennis-yc.hsieh@mediatek.com>
References: <1592745731-14614-1-git-send-email-dennis-yc.hsieh@mediatek.com>
         <1592745731-14614-4-git-send-email-dennis-yc.hsieh@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UmV2aWV3ZWQtYnk6IEJpYmJ5IEhzaWVoIDxiaWJieS5oc2llaEBtZWRpYXRlay5jb20+DQoNClRo
YW5rcy4NCg0KT24gU3VuLCAyMDIwLTA2LTIxIGF0IDIxOjIyICswODAwLCBEZW5uaXMgWUMgSHNp
ZWggd3JvdGU6DQo+IEFkZCBnY2UgdjQgaGFyZHdhcmUgc3VwcG9ydCB3aXRoIGRpZmZlcmVudCB0
aHJlYWQgbnVtYmVyIGFuZCBzaGlmdC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IERlbm5pcyBZQyBI
c2llaCA8ZGVubmlzLXljLmhzaWVoQG1lZGlhdGVrLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IENLIEh1
IDxjay5odUBtZWRpYXRlay5jb20+DQo+IFJldmlld2VkLWJ5OiBNYXR0aGlhcyBCcnVnZ2VyIDxt
YXR0aGlhcy5iZ2dAZ21haWwuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvbWFpbGJveC9tdGstY21k
cS1tYWlsYm94LmMgfCAgICAyICsrDQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCsp
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tYWlsYm94L210ay1jbWRxLW1haWxib3guYyBi
L2RyaXZlcnMvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmMNCj4gaW5kZXggNGRiZWU5MjU4MTI3
Li45OTk0YWM5NDI2ZDYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbWFpbGJveC9tdGstY21kcS1t
YWlsYm94LmMNCj4gKysrIGIvZHJpdmVycy9tYWlsYm94L210ay1jbWRxLW1haWxib3guYw0KPiBA
QCAtNTcyLDEwICs1NzIsMTIgQEAgc3RhdGljIGludCBjbWRxX3Byb2JlKHN0cnVjdCBwbGF0Zm9y
bV9kZXZpY2UgKnBkZXYpDQo+ICANCj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZ2NlX3BsYXQgZ2Nl
X3BsYXRfdjIgPSB7LnRocmVhZF9uciA9IDE2fTsNCj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZ2Nl
X3BsYXQgZ2NlX3BsYXRfdjMgPSB7LnRocmVhZF9uciA9IDI0fTsNCj4gK3N0YXRpYyBjb25zdCBz
dHJ1Y3QgZ2NlX3BsYXQgZ2NlX3BsYXRfdjQgPSB7LnRocmVhZF9uciA9IDI0LCAuc2hpZnQgPSAz
fTsNCj4gIA0KPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgY21kcV9vZl9pZHNb
XSA9IHsNCj4gIAl7LmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTczLWdjZSIsIC5kYXRhID0g
KHZvaWQgKikmZ2NlX3BsYXRfdjJ9LA0KPiAgCXsuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgx
ODMtZ2NlIiwgLmRhdGEgPSAodm9pZCAqKSZnY2VfcGxhdF92M30sDQo+ICsJey5jb21wYXRpYmxl
ID0gIm1lZGlhdGVrLG10Njc3OS1nY2UiLCAuZGF0YSA9ICh2b2lkICopJmdjZV9wbGF0X3Y0fSwN
Cj4gIAl7fQ0KPiAgfTsNCj4gIA0KDQo=

