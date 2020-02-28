Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49822C3F2CD
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 15:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A78A2469D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 15:39:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="TXXSvD1x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbgB1PjP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 10:39:15 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:48351 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726905AbgB1PjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 10:39:15 -0500
X-UUID: 3e229069cc984930aa813cf1bd848ed5-20200228
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=K1/FjNHc57KhQ76Cn3QZo1foNtzkkZjOg40TS1GEvyY=;
        b=TXXSvD1xoKc4AxHzgApu4M+YEl7tlzngM7EeOwPiXedjYZDZFko6yJFaVrMuVddQmZo8L9lP6vlBTCvjreHEPKmV4ZdvpO4A6dh3fvwejvZsTnW+UDVPnSHUEzf6XAx/b6S8iTaZWapB414hEMZr7y8cbu2d7zRw9kJGk7nQwhs=;
X-UUID: 3e229069cc984930aa813cf1bd848ed5-20200228
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1342788308; Fri, 28 Feb 2020 23:39:10 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 28 Feb 2020 23:38:15 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 28 Feb 2020 23:39:00 +0800
Message-ID: <1582904349.14824.19.camel@mtksdaap41>
Subject: Re: [PATCH v3 05/13] soc: mediatek: cmdq: return send msg error code
From:   CK Hu <ck.hu@mediatek.com>
To:     Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        "Ming-Fan Chen" <ming-fan.chen@mediatek.com>
Date:   Fri, 28 Feb 2020 23:39:09 +0800
In-Reply-To: <1582897461-15105-7-git-send-email-dennis-yc.hsieh@mediatek.com>
References: <1582897461-15105-1-git-send-email-dennis-yc.hsieh@mediatek.com>
         <1582897461-15105-7-git-send-email-dennis-yc.hsieh@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIERlbm5pczoNCg0KT24gRnJpLCAyMDIwLTAyLTI4IGF0IDIxOjQ0ICswODAwLCBEZW5uaXMg
WUMgSHNpZWggd3JvdGU6DQo+IFJldHVybiBlcnJvciBjb2RlIHRvIGNsaWVudCBpZiBzZW5kIG1l
c3NhZ2UgZmFpbCwNCj4gc28gdGhhdCBjbGllbnQgaGFzIGNoYW5jZSB0byBlcnJvciBoYW5kbGlu
Zy4NCj4gDQo+IEZpeGVzOiA1NzZmMWI0YmM4MDIgKCJzb2M6IG1lZGlhdGVrOiBBZGQgTWVkaWF0
ZWsgQ01EUSBoZWxwZXIiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBEZW5uaXMgWUMgSHNpZWggPGRlbm5p
cy15Yy5oc2llaEBtZWRpYXRlay5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9zb2MvbWVkaWF0ZWsv
bXRrLWNtZHEtaGVscGVyLmMgfCA0ICsrLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlv
bnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zb2MvbWVk
aWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMgYi9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1o
ZWxwZXIuYw0KPiBpbmRleCAyZTFiYzUxMzU2OWIuLjA2OTg2MTJkZTVhZCAxMDA2NDQNCj4gLS0t
IGEvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMNCj4gKysrIGIvZHJpdmVy
cy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMNCj4gQEAgLTM1MSwxMSArMzUxLDExIEBA
IGludCBjbWRxX3BrdF9mbHVzaF9hc3luYyhzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgY21kcV9hc3lu
Y19mbHVzaF9jYiBjYiwNCj4gIAkJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmY2xpZW50LT5sb2Nr
LCBmbGFncyk7DQo+ICAJfQ0KPiAgDQo+IC0JbWJveF9zZW5kX21lc3NhZ2UoY2xpZW50LT5jaGFu
LCBwa3QpOw0KPiArCWVyciA9IG1ib3hfc2VuZF9tZXNzYWdlKGNsaWVudC0+Y2hhbiwgcGt0KTsN
Cj4gIAkvKiBXZSBjYW4gc2VuZCBuZXh0IHBhY2tldCBpbW1lZGlhdGVseSwgc28ganVzdCBjYWxs
IHR4ZG9uZS4gKi8NCj4gIAltYm94X2NsaWVudF90eGRvbmUoY2xpZW50LT5jaGFuLCAwKTsNCg0K
SWYgZXJyb3IgaGFwcGVuLCB3aHkgdHggaXMgZG9uZT8gSSB0aGluayB5b3Ugc2hvdWxkIHJldHVy
biBpbW1lZGlhdGVseQ0Kd2hlbiBlcnJvciBoYXBwZW4uDQoNClJlZ2FyZHMsDQpDSw0KDQo+ICAN
Cj4gLQlyZXR1cm4gMDsNCj4gKwlyZXR1cm4gZXJyOw0KPiAgfQ0KPiAgRVhQT1JUX1NZTUJPTChj
bWRxX3BrdF9mbHVzaF9hc3luYyk7DQo+ICANCg0K

