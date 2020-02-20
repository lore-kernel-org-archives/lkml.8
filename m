Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D1E7C11D81
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 01:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05D512465D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 01:36:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Cj+GpElC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbgBTBgR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 20:36:17 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:9219 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727135AbgBTBgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 20:36:15 -0500
X-UUID: 8822993177144f7cae617536a7168d95-20200220
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=M86BLgqozbH/Kl6AgJIXd8CaALScxACbiWE+AGXHu0M=;
        b=Cj+GpElCDUUggrUPzXSWal+0LBXA/Js6cHOFqPE/HSfaiaFT5cQVqGJOVhIk4xx0Y8hcHvzyj1y6Q9oTXDtHHS3Uj3fqXFw9iZpkhY6n4ouBXRHWRSCrFNfZ8aENxznZvMCINcJKXhRTUIxqURVMkFU95xxb1IPgavATLujoa7g=;
X-UUID: 8822993177144f7cae617536a7168d95-20200220
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 23207877; Thu, 20 Feb 2020 09:36:09 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 20 Feb 2020 09:36:08 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 20 Feb 2020 09:35:31 +0800
Message-ID: <1582162568.24713.0.camel@mtksdaap41>
Subject: Re: [PATCH] drm/mediatek: component type MTK_DISP_OVL_2L is not
 correctly handled
From:   CK Hu <ck.hu@mediatek.com>
To:     Phong LE <ple@baylibre.com>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Date:   Thu, 20 Feb 2020 09:36:08 +0800
In-Reply-To: <20200219141324.29299-1-ple@baylibre.com>
References: <20200219141324.29299-1-ple@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFBob25nOg0KDQpPbiBXZWQsIDIwMjAtMDItMTkgYXQgMTU6MTMgKzAxMDAsIFBob25nIExF
IHdyb3RlOg0KPiBUaGUgbGFyYiBkZXZpY2UgcmVtYWlucyBOVUxMIGlmIHRoZSB0eXBlIGlzIE1U
S19ESVNQX09WTF8yTC4NCj4gQSBrZXJuZWwgcGFuaWMgaXMgcmFpc2VkIHdoZW4gYSBjcnRjIHVz
ZXMgbXRrX3NtaV9sYXJiX2dldCBvcg0KPiBtdGtfc21pX2xhcmJfcHV0Lg0KPiANCg0KUmV2aWV3
ZWQtYnk6IENLIEh1IDxjay5odUBtZWRpYXRlay5jb20+DQoNCj4gU2lnbmVkLW9mZi1ieTogUGhv
bmcgTEUgPHBsZUBiYXlsaWJyZS5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlh
dGVrL210a19kcm1fZGRwX2NvbXAuYyB8IDEgKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0
aW9uKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19k
cm1fZGRwX2NvbXAuYyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2RkcF9jb21w
LmMNCj4gaW5kZXggMWY1YTExMmJiMDM0Li41N2M4OGRlOWEzMjkgMTAwNjQ0DQo+IC0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2RkcF9jb21wLmMNCj4gKysrIGIvZHJpdmVy
cy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZGRwX2NvbXAuYw0KPiBAQCAtNDcxLDYgKzQ3MSw3
IEBAIGludCBtdGtfZGRwX2NvbXBfaW5pdChzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBkZXZp
Y2Vfbm9kZSAqbm9kZSwNCj4gIAkvKiBPbmx5IERNQSBjYXBhYmxlIGNvbXBvbmVudHMgbmVlZCB0
aGUgTEFSQiBwcm9wZXJ0eSAqLw0KPiAgCWNvbXAtPmxhcmJfZGV2ID0gTlVMTDsNCj4gIAlpZiAo
dHlwZSAhPSBNVEtfRElTUF9PVkwgJiYNCj4gKwkgICAgdHlwZSAhPSBNVEtfRElTUF9PVkxfMkwg
JiYNCj4gIAkgICAgdHlwZSAhPSBNVEtfRElTUF9SRE1BICYmDQo+ICAJICAgIHR5cGUgIT0gTVRL
X0RJU1BfV0RNQSkNCj4gIAkJcmV0dXJuIDA7DQoNCg==

