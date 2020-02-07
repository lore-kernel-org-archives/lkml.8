Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A06C0C352A2
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 08:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E7AC20726
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 08:35:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="i85HRCam"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbgBGIfL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 03:35:11 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:40260 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726451AbgBGIfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 03:35:10 -0500
X-UUID: 0256c2ddcaf640b682504a0c78776d0e-20200207
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=hXWVZ6oSwC7pNQrHxmaSfz6HN+UgtHEL8vkKF8UU45A=;
        b=i85HRCamkErv65eH5EQ5F4f1Uyu2I6hSbtMVf1IKSu6XRS4JO8CFSpiWBCpjm38ZVuFL54Kde34iD7s3cj6qzxmqwA3i4CVcGqwzMg+6BXlW+FBT8Z5xZygfBb9KjSJJ/74B2zVpNAx5s6efEp8nlntQPFoFjvVOWUxZzLqDDUU=;
X-UUID: 0256c2ddcaf640b682504a0c78776d0e-20200207
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 455714423; Fri, 07 Feb 2020 16:35:07 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 7 Feb 2020 16:35:53 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by mtkcas08.mediatek.inc
 (172.21.101.126) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 7 Feb
 2020 16:35:28 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 7 Feb 2020 16:35:28 +0800
Message-ID: <1581064499.590.0.camel@mtksdaap41>
Subject: Re: [PATCH] drm/mediatek: Find the cursor plane instead of hard
 coding it
From:   CK Hu <ck.hu@mediatek.com>
To:     Evan Benn <evanbenn@chromium.org>
CC:     <dri-devel@lists.freedesktop.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        <linux-kernel@vger.kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-mediatek@lists.infradead.org>,
        David Airlie <airlied@linux.ie>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Fri, 7 Feb 2020 16:34:59 +0800
In-Reply-To: <20200207152348.1.Ie0633018fc787dda6e869cae23df76ae30f2a686@changeid>
References: <20200206140140.GA18465@art_vandelay>
         <20200207152348.1.Ie0633018fc787dda6e869cae23df76ae30f2a686@changeid>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEV2YW46DQoNCk9uIEZyaSwgMjAyMC0wMi0wNyBhdCAxNToyMyArMTEwMCwgRXZhbiBCZW5u
IHdyb3RlOg0KPiBUaGUgY3Vyc29yIGFuZCBwcmltYXJ5IHBsYW5lcyB3ZXJlIGhhcmQgY29kZWQu
DQo+IE5vdyBzZWFyY2ggZm9yIHRoZW0gZm9yIHBhc3NpbmcgdG8gZHJtX2NydGNfaW5pdF93aXRo
X3BsYW5lcw0KPiANCg0KUmV2aWV3ZWQtYnk6IENLIEh1IDxjay5odUBtZWRpYXRlay5jb20+DQoN
Cj4gU2lnbmVkLW9mZi1ieTogRXZhbiBCZW5uIDxldmFuYmVubkBjaHJvbWl1bS5vcmc+DQo+IC0t
LQ0KPiANCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2NydGMuYyB8IDE4ICsr
KysrKysrKysrKy0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKyksIDYg
ZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVr
L210a19kcm1fY3J0Yy5jIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5j
DQo+IGluZGV4IDdiMzkyZDZjNzFjYy4uOTM1NjUyOTkwYWZhIDEwMDY0NA0KPiAtLS0gYS9kcml2
ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRjLmMNCj4gKysrIGIvZHJpdmVycy9ncHUv
ZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5jDQo+IEBAIC02NTgsMTAgKzY1OCwxOCBAQCBzdGF0
aWMgY29uc3Qgc3RydWN0IGRybV9jcnRjX2hlbHBlcl9mdW5jcyBtdGtfY3J0Y19oZWxwZXJfZnVu
Y3MgPSB7DQo+ICANCj4gIHN0YXRpYyBpbnQgbXRrX2RybV9jcnRjX2luaXQoc3RydWN0IGRybV9k
ZXZpY2UgKmRybSwNCj4gIAkJCSAgICAgc3RydWN0IG10a19kcm1fY3J0YyAqbXRrX2NydGMsDQo+
IC0JCQkgICAgIHN0cnVjdCBkcm1fcGxhbmUgKnByaW1hcnksDQo+IC0JCQkgICAgIHN0cnVjdCBk
cm1fcGxhbmUgKmN1cnNvciwgdW5zaWduZWQgaW50IHBpcGUpDQo+ICsJCQkgICAgIHVuc2lnbmVk
IGludCBwaXBlKQ0KPiAgew0KPiAtCWludCByZXQ7DQo+ICsJc3RydWN0IGRybV9wbGFuZSAqcHJp
bWFyeSA9IE5VTEw7DQo+ICsJc3RydWN0IGRybV9wbGFuZSAqY3Vyc29yID0gTlVMTDsNCj4gKwlp
bnQgaSwgcmV0Ow0KPiArDQo+ICsJZm9yIChpID0gMDsgaSA8IG10a19jcnRjLT5sYXllcl9ucjsg
aSsrKSB7DQo+ICsJCWlmIChtdGtfY3J0Yy0+cGxhbmVzW2ldLnR5cGUgPT0gRFJNX1BMQU5FX1RZ
UEVfUFJJTUFSWSkNCj4gKwkJCXByaW1hcnkgPSAmbXRrX2NydGMtPnBsYW5lc1tpXTsNCj4gKwkJ
ZWxzZSBpZiAobXRrX2NydGMtPnBsYW5lc1tpXS50eXBlID09IERSTV9QTEFORV9UWVBFX0NVUlNP
UikNCj4gKwkJCWN1cnNvciA9ICZtdGtfY3J0Yy0+cGxhbmVzW2ldOw0KPiArCX0NCj4gIA0KPiAg
CXJldCA9IGRybV9jcnRjX2luaXRfd2l0aF9wbGFuZXMoZHJtLCAmbXRrX2NydGMtPmJhc2UsIHBy
aW1hcnksIGN1cnNvciwNCj4gIAkJCQkJJm10a19jcnRjX2Z1bmNzLCBOVUxMKTsNCj4gQEAgLTgz
MCw5ICs4MzgsNyBAQCBpbnQgbXRrX2RybV9jcnRjX2NyZWF0ZShzdHJ1Y3QgZHJtX2RldmljZSAq
ZHJtX2RldiwNCj4gIAkJCXJldHVybiByZXQ7DQo+ICAJfQ0KPiAgDQo+IC0JcmV0ID0gbXRrX2Ry
bV9jcnRjX2luaXQoZHJtX2RldiwgbXRrX2NydGMsICZtdGtfY3J0Yy0+cGxhbmVzWzBdLA0KPiAt
CQkJCW10a19jcnRjLT5sYXllcl9uciA+IDEgPyAmbXRrX2NydGMtPnBsYW5lc1sxXSA6DQo+IC0J
CQkJTlVMTCwgcGlwZSk7DQo+ICsJcmV0ID0gbXRrX2RybV9jcnRjX2luaXQoZHJtX2RldiwgbXRr
X2NydGMsIHBpcGUpOw0KPiAgCWlmIChyZXQgPCAwKQ0KPiAgCQlyZXR1cm4gcmV0Ow0KPiAgDQoN
Cg==

