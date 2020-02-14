Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 834A0C35242
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 06:48:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 462A1222C4
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 06:48:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="mNOYLuie"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728761AbgBNGsk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 01:48:40 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:3591 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725897AbgBNGsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 01:48:40 -0500
X-UUID: 8c8f9b2b36a54850b631df62dc69840b-20200214
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=793AtRhL6KTU8oRy5ebaU3z1XDM9P+It3bT3YTeZoSU=;
        b=mNOYLuie8RFfAObLdxVKO47u9kXFV9XODlwdMQBEcAs/8GHTOLaBqkdm0YIMMXTK6xRaEKjsdVmN3S7XyjLLC8fcRMvcrbQ32vCQvHhtjySMHNWP+RXOIUVsnohSlwPNEbUNU1DMVrz/mMGiepG83AUfnrHOxmDNkYubsbdkY+g=;
X-UUID: 8c8f9b2b36a54850b631df62dc69840b-20200214
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 313290993; Fri, 14 Feb 2020 14:48:33 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 14 Feb 2020 14:47:41 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 14 Feb 2020 14:48:32 +0800
Message-ID: <1581662912.17949.4.camel@mtksdaap41>
Subject: Re: [PATCH 2/3] drm/mediatek: make sure previous message done or be
 aborted before send
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
Date:   Fri, 14 Feb 2020 14:48:32 +0800
In-Reply-To: <20200214044954.16923-2-bibby.hsieh@mediatek.com>
References: <20200214044954.16923-1-bibby.hsieh@mediatek.com>
         <20200214044954.16923-2-bibby.hsieh@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEJpYmJ5Og0KDQpPbiBGcmksIDIwMjAtMDItMTQgYXQgMTI6NDkgKzA4MDAsIEJpYmJ5IEhz
aWVoIHdyb3RlOg0KPiBNZWRpYXRlayBDTURRIGRyaXZlciByZW1vdmVkIGF0b21pYyBwYXJhbWV0
ZXIgYW5kIGltcGxlbWVudGF0aW9uDQo+IHJlbGF0ZWQgdG8gYXRvbWljLiBEUk0gZHJpdmVyIG5l
ZWQgdG8gbWFrZSBzdXJlIHByZXZpb3VzIG1lc3NhZ2UNCj4gZG9uZSBvciBiZSBhYm9ydGVkIGJl
Zm9yZSB3ZSBzZW5kIG5leHQgbWVzc2FnZS4NCj4gDQo+IElmIHByZXZpb3VzIG1lc3NhZ2UgaXMg
c3RpbGwgd2FpdGluZyBmb3IgZXZlbnQsIGl0IG1lYW5zIHRoZQ0KPiBzZXR0aW5nIGhhc24ndCBi
ZWVuIHVwZGF0ZWQgaW50byBkaXNwbGF5IGhhcmR3YXJlIHJlZ2lzdGVyLA0KPiB3ZSBjYW4gYWJv
cnQgdGhlIG1lc3NhZ2UgYW5kIHNlbmQgbmV4dCBtZXNzYWdlIHRvIHVwZGF0ZSB0aGUNCj4gbmV3
ZXN0IHNldHRpbmcgaW50byBkaXNwbGF5IGhhcmR3YXJlLg0KPiBJZiBwcmV2aW91cyBtZXNzYWdl
IGFscmVhZHkgc3RhcnRlZCwgd2UgaGF2ZSB0byB3YWl0IGl0IHVudGlsDQo+IHRyYW5zbWlzc2lv
biBoYXMgYmVlbiBjb21wbGV0ZWQuDQo+IA0KPiBTbyB3ZSBmbHVzaCBtYm94IGNsaWVudCBiZWZv
cmUgd2Ugc2VuZCBuZXcgbWVzc2FnZSB0byBjb250cm9sbGVyDQo+IGRyaXZlci4NCj4gDQoNClJl
dmlld2VkLWJ5OiBDSyBIdSA8Y2suaHVAbWVkaWF0ZWsuY29tPg0KDQo+IFRoaXMgcGF0Y2ggZGVw
ZW5kcyBvbiBwdGFjaDoNCj4gWzAvM10gUmVtb3ZlIGF0b21pY19leGVjDQo+IGh0dHBzOi8vcGF0
Y2h3b3JrLmtlcm5lbC5vcmcvY292ZXIvMTEzODE2NzcvDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBC
aWJieSBIc2llaCA8YmliYnkuaHNpZWhAbWVkaWF0ZWsuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMv
Z3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2NydGMuYyB8IDEgKw0KPiAgMSBmaWxlIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlh
dGVrL210a19kcm1fY3J0Yy5jIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0
Yy5jDQo+IGluZGV4IDNjNTNlYTIyMjA4Yy4uZTM1YjY2YzViYTBmIDEwMDY0NA0KPiAtLS0gYS9k
cml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRjLmMNCj4gKysrIGIvZHJpdmVycy9n
cHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5jDQo+IEBAIC00OTEsNiArNDkxLDcgQEAgc3Rh
dGljIHZvaWQgbXRrX2RybV9jcnRjX2h3X2NvbmZpZyhzdHJ1Y3QgbXRrX2RybV9jcnRjICptdGtf
Y3J0YykNCj4gIAl9DQo+ICAjaWYgSVNfRU5BQkxFRChDT05GSUdfTVRLX0NNRFEpDQo+ICAJaWYg
KG10a19jcnRjLT5jbWRxX2NsaWVudCkgew0KPiArCQltYm94X2ZsdXNoKG10a19jcnRjLT5jbWRx
X2NsaWVudC0+Y2hhbiwgMjAwMCk7DQo+ICAJCWNtZHFfaGFuZGxlID0gY21kcV9wa3RfY3JlYXRl
KG10a19jcnRjLT5jbWRxX2NsaWVudCwgUEFHRV9TSVpFKTsNCj4gIAkJY21kcV9wa3RfY2xlYXJf
ZXZlbnQoY21kcV9oYW5kbGUsIG10a19jcnRjLT5jbWRxX2V2ZW50KTsNCj4gIAkJY21kcV9wa3Rf
d2ZlKGNtZHFfaGFuZGxlLCBtdGtfY3J0Yy0+Y21kcV9ldmVudCk7DQoNCg==

