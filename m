Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6AF3C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 10:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCC4D2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 10:44:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="VnEm6VIu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728202AbgBLKoN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 05:44:13 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:35838 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727347AbgBLKoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 05:44:11 -0500
X-UUID: 874b2bd27df640b3ac9c2224c5855ee1-20200212
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=mI3fYDry0lo0Gw3fcA1ji/+ZqG9237qwLkz8bgtOGaY=;
        b=VnEm6VIurTUW9qz4DXkvd1aAv5Xr7sWbSbO/Ao7TuAVlDMOYr9IEqk+8dI5I1SOM5e888HJ/WuAVobpUkodj5jc6l9MUMHqsFRr8ZaEG3ydsapywctSKK+ZPCDFtfqUjqGJhSN6fUO4/QIg6vjVXRtjnjbMCkBNnpd45l3+r1n8=;
X-UUID: 874b2bd27df640b3ac9c2224c5855ee1-20200212
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1878158558; Wed, 12 Feb 2020 18:44:05 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 12 Feb 2020 18:43:13 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 12 Feb 2020 18:43:04 +0800
Message-ID: <1581504244.26347.0.camel@mtksdaap41>
Subject: Re: [PATCH 2/2] drm/mediatek: move gce event property to mutex
 device node
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
Date:   Wed, 12 Feb 2020 18:44:04 +0800
In-Reply-To: <20200212095501.12124-2-bibby.hsieh@mediatek.com>
References: <20200212095501.12124-1-bibby.hsieh@mediatek.com>
         <20200212095501.12124-2-bibby.hsieh@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEJpYmJ5Og0KDQpPbiBXZWQsIDIwMjAtMDItMTIgYXQgMTc6NTUgKzA4MDAsIEJpYmJ5IEhz
aWVoIHdyb3RlOg0KPiBBY2NvcmRpbmcgbXRrIGhhcmR3YXJlIGRlc2lnbiwgc3RyZWFtX2RvbmUw
IGFuZCBzdHJlYW1fZG9uZTEgYXJlDQo+IGdlbmVyYXRlZCBieSBtdXRleCwgc28gd2UgbW92ZSBn
Y2UgZXZlbnQgcHJvcGVydHkgdG8gbXV0ZXggZGV2aWNlIG1vZGUuDQo+IA0KDQpSZXZpZXdlZC1i
eTogQ0sgSHUgPGNrLmh1QG1lZGlhdGVrLmNvbT4NCg0KPiBTaWduZWQtb2ZmLWJ5OiBCaWJieSBI
c2llaCA8YmliYnkuaHNpZWhAbWVkaWF0ZWsuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2Ry
bS9tZWRpYXRlay9tdGtfZHJtX2NydGMuYyB8IDIgKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9tZWRpYXRlay9tdGtfZHJtX2NydGMuYyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9t
dGtfZHJtX2NydGMuYw0KPiBpbmRleCAzYzUzZWEyMjIwOGMuLjhhMzFlNWI5ODNkYiAxMDA2NDQN
Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5jDQo+ICsrKyBi
L2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2NydGMuYw0KPiBAQCAtODE5LDcgKzgx
OSw3IEBAIGludCBtdGtfZHJtX2NydGNfY3JlYXRlKHN0cnVjdCBkcm1fZGV2aWNlICpkcm1fZGV2
LA0KPiAgCQkJZHJtX2NydGNfaW5kZXgoJm10a19jcnRjLT5iYXNlKSk7DQo+ICAJCW10a19jcnRj
LT5jbWRxX2NsaWVudCA9IE5VTEw7DQo+ICAJfQ0KPiAtCXJldCA9IG9mX3Byb3BlcnR5X3JlYWRf
dTMyX2luZGV4KGRldi0+b2Zfbm9kZSwgIm1lZGlhdGVrLGdjZS1ldmVudHMiLA0KPiArCXJldCA9
IG9mX3Byb3BlcnR5X3JlYWRfdTMyX2luZGV4KHByaXYtPm11dGV4X25vZGUsICJtZWRpYXRlayxn
Y2UtZXZlbnRzIiwNCj4gIAkJCQkJIGRybV9jcnRjX2luZGV4KCZtdGtfY3J0Yy0+YmFzZSksDQo+
ICAJCQkJCSAmbXRrX2NydGMtPmNtZHFfZXZlbnQpOw0KPiAgCWlmIChyZXQpDQoNCg==

