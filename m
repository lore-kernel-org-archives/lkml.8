Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94DE6C352A3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 04:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68095206D7
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 04:06:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="kpmybhKQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729638AbgBMEGJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 23:06:09 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:44151 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729407AbgBMEGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 23:06:09 -0500
X-UUID: ee66a7eda1314322a27b7f3b6a4c3a53-20200213
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=s7mv4CulVo+FKLuN0ptbU/bnthf97z5/e/fjB5FwBns=;
        b=kpmybhKQdM0UuTLo2W31uMP2MXKOgUW6qFXVCLD8g9hYUPgRq1a5MzCMfTo2gk8oZe7QyWjUUeonCu3vb5uXLs56Cipt2n8q4cnOxWEs0dIhzo48JcQjuduupD631NO9RAuLWnyzTqXh9iPvBO5wZTdNvL9L61DrbVCUPz+wIuI=;
X-UUID: ee66a7eda1314322a27b7f3b6a4c3a53-20200213
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 409715423; Thu, 13 Feb 2020 12:06:05 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 13 Feb 2020 12:06:37 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 13 Feb 2020 12:05:00 +0800
Message-ID: <1581566763.12071.1.camel@mtksdaap41>
Subject: Re: [PATCH 2/2] drm/mediatek: add fb swap in async_update
From:   CK Hu <ck.hu@mediatek.com>
To:     Bibby Hsieh <bibby.hsieh@mediatek.com>
CC:     David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        YT Shen <yt.shen@mediatek.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>, <tfiga@chromium.org>,
        <drinkcat@chromium.org>, <linux-kernel@vger.kernel.org>,
        <srv_heupstream@mediatek.com>
Date:   Thu, 13 Feb 2020 12:06:03 +0800
In-Reply-To: <20200213012353.26815-2-bibby.hsieh@mediatek.com>
References: <20200213012353.26815-1-bibby.hsieh@mediatek.com>
         <20200213012353.26815-2-bibby.hsieh@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEJpYmJ5Og0KDQpPbiBUaHUsIDIwMjAtMDItMTMgYXQgMDk6MjMgKzA4MDAsIEJpYmJ5IEhz
aWVoIHdyb3RlOg0KPiBCZXNpZGVzIHgsIHkgcG9zaXRpb24sIHdpZHRoIGFuZCBoZWlnaHQsDQo+
IGZiIGFsc28gbmVlZCB1cGRhdGluZyBpbiBhc3luYyB1cGRhdGUuDQo+IA0KDQpSZXZpZXdlZC1i
eTogQ0sgSHUgPGNrLmh1QG1lZGlhdGVrLmNvbT4NCg0KPiBGaXhlczogOTIwZmZmY2M4OTEyICgi
ZHJtL21lZGlhdGVrOiB1cGRhdGUgY3Vyc29ycyBieSB1c2luZyBhc3luYyBhdG9taWMgdXBkYXRl
IikNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEJpYmJ5IEhzaWVoIDxiaWJieS5oc2llaEBtZWRpYXRl
ay5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fcGxhbmUu
YyB8IDEgKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fcGxhbmUuYyBiL2RyaXZlcnMv
Z3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX3BsYW5lLmMNCj4gaW5kZXggZDMyYjQ5NGZmMWRlLi5l
MDg0YzM2ZmRkOGEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtf
ZHJtX3BsYW5lLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fcGxh
bmUuYw0KPiBAQCAtMTIyLDYgKzEyMiw3IEBAIHN0YXRpYyB2b2lkIG10a19wbGFuZV9hdG9taWNf
YXN5bmNfdXBkYXRlKHN0cnVjdCBkcm1fcGxhbmUgKnBsYW5lLA0KPiAgCXBsYW5lLT5zdGF0ZS0+
c3JjX3kgPSBuZXdfc3RhdGUtPnNyY195Ow0KPiAgCXBsYW5lLT5zdGF0ZS0+c3JjX2ggPSBuZXdf
c3RhdGUtPnNyY19oOw0KPiAgCXBsYW5lLT5zdGF0ZS0+c3JjX3cgPSBuZXdfc3RhdGUtPnNyY193
Ow0KPiArCXN3YXAocGxhbmUtPnN0YXRlLT5mYiwgbmV3X3N0YXRlLT5mYik7DQo+ICAJc3RhdGUt
PnBlbmRpbmcuYXN5bmNfZGlydHkgPSB0cnVlOw0KPiAgDQo+ICAJbXRrX2RybV9jcnRjX2FzeW5j
X3VwZGF0ZShuZXdfc3RhdGUtPmNydGMsIHBsYW5lLCBuZXdfc3RhdGUpOw0KDQotLSANCkNLIEh1
IDxjay5odUBtZWRpYXRlay5jb20+DQo=

