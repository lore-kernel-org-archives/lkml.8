Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 331EDC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 02:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0F812522B
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 02:42:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="HUpMNTj1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731071AbgFVCmF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jun 2020 22:42:05 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:41723 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726659AbgFVCmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 22:42:05 -0400
X-UUID: fd81c072e57144a39b84c4196b87ed28-20200622
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=cB8SOTSbnezNpmNBAOc7AwgCBVUaB05yWxYs3kD21Ak=;
        b=HUpMNTj10uivzOWnCi5tAl7RzZ0gh0gQV6V3y/85EPEyCB+7dclnoG0opc7mJcWL5fjL0Sike7u/cbaj23vTrSXQfYQgy7d3v7rd6iTA27B2jwv5XPaj1gwpn7EbexQLmxgBjE7SdjesRFuH1EKhWGqY6oodnCFyKMhuehNAfhA=;
X-UUID: fd81c072e57144a39b84c4196b87ed28-20200622
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <bibby.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 11815441; Mon, 22 Jun 2020 10:42:04 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 22 Jun 2020 10:42:01 +0800
Received: from [172.21.77.4] (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 22 Jun 2020 10:41:52 +0800
Message-ID: <1592793722.11692.10.camel@mtksdaap41>
Subject: Re: [PATCH v1 01/11] soc: mediatek: cmdq: add address shift in jump
From:   Bibby Hsieh <bibby.hsieh@mediatek.com>
To:     Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, CK Hu <ck.hu@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>,
        HS Liao <hs.liao@mediatek.com>
Date:   Mon, 22 Jun 2020 10:42:02 +0800
In-Reply-To: <1592749115-24158-2-git-send-email-dennis-yc.hsieh@mediatek.com>
References: <1592749115-24158-1-git-send-email-dennis-yc.hsieh@mediatek.com>
         <1592749115-24158-2-git-send-email-dennis-yc.hsieh@mediatek.com>
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
YW5rcy4NCg0KT24gU3VuLCAyMDIwLTA2LTIxIGF0IDIyOjE4ICswODAwLCBEZW5uaXMgWUMgSHNp
ZWggd3JvdGU6DQo+IEFkZCBhZGRyZXNzIHNoaWZ0IHdoZW4gY29tcG9zZSBqdW1wIGluc3RydWN0
aW9uDQo+IHRvIGNvbXBhdGlibGUgd2l0aCAzNWJpdCBmb3JtYXQuDQo+IA0KPiBTaWduZWQtb2Zm
LWJ5OiBEZW5uaXMgWUMgSHNpZWggPGRlbm5pcy15Yy5oc2llaEBtZWRpYXRlay5jb20+DQo+IC0t
LQ0KPiAgZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMgfCAgICAzICsrLQ0K
PiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jIGIvZHJp
dmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMNCj4gaW5kZXggYzY3MDgxNzU5NzI4
Li45OGYyM2JhM2JhNDcgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1j
bWRxLWhlbHBlci5jDQo+ICsrKyBiL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBl
ci5jDQo+IEBAIC0yOTEsNyArMjkxLDggQEAgc3RhdGljIGludCBjbWRxX3BrdF9maW5hbGl6ZShz
dHJ1Y3QgY21kcV9wa3QgKnBrdCkNCj4gIA0KPiAgCS8qIEpVTVAgdG8gZW5kICovDQo+ICAJaW5z
dC5vcCA9IENNRFFfQ09ERV9KVU1QOw0KPiAtCWluc3QudmFsdWUgPSBDTURRX0pVTVBfUEFTUzsN
Cj4gKwlpbnN0LnZhbHVlID0gQ01EUV9KVU1QX1BBU1MgPj4NCj4gKwkJY21kcV9tYm94X3NoaWZ0
KCgoc3RydWN0IGNtZHFfY2xpZW50ICopcGt0LT5jbCktPmNoYW4pOw0KPiAgCWVyciA9IGNtZHFf
cGt0X2FwcGVuZF9jb21tYW5kKHBrdCwgaW5zdCk7DQo+ICANCj4gIAlyZXR1cm4gZXJyOw0KDQo=

