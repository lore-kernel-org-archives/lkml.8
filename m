Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7016C35254
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 02:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E274208C4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 02:53:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Lae74vM2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbgBJCxP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Feb 2020 21:53:15 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:38691 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726910AbgBJCxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Feb 2020 21:53:14 -0500
X-UUID: 669d501fcfcc4530a26b11203217b0ac-20200210
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=W9H3gUT21gGxakLPlN7C+OdzFLN/Tl44T7eG40NyIp0=;
        b=Lae74vM2lIGTQnPzJo/fh/ko34RNSZ4n9XoVN6pkcEpVpsT8Ii2WMVvVkuXVdCpP9TvwJ+CWzxE2MbQJML09lHlOdQvbVglMlbQAJ7F4sD/CvODLq3Rk+MxiTpMuIMSb5vg2EWrkxHetweCevm8ifcFM4eJoclnBBGmRgkvvK8E=;
X-UUID: 669d501fcfcc4530a26b11203217b0ac-20200210
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 77091319; Mon, 10 Feb 2020 10:53:08 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 10 Feb 2020 10:52:25 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by mtkcas07.mediatek.inc
 (172.21.101.84) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 10 Feb
 2020 10:52:18 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 10 Feb 2020 10:53:24 +0800
Message-ID: <1581303187.951.2.camel@mtksdaap41>
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
Date:   Mon, 10 Feb 2020 10:53:07 +0800
In-Reply-To: <1581064499.590.0.camel@mtksdaap41>
References: <20200206140140.GA18465@art_vandelay>
         <20200207152348.1.Ie0633018fc787dda6e869cae23df76ae30f2a686@changeid>
         <1581064499.590.0.camel@mtksdaap41>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEV2YW46DQoNCk9uIEZyaSwgMjAyMC0wMi0wNyBhdCAxNjozNCArMDgwMCwgQ0sgSHUgd3Jv
dGU6DQo+IEhpLCBFdmFuOg0KPiANCj4gT24gRnJpLCAyMDIwLTAyLTA3IGF0IDE1OjIzICsxMTAw
LCBFdmFuIEJlbm4gd3JvdGU6DQo+ID4gVGhlIGN1cnNvciBhbmQgcHJpbWFyeSBwbGFuZXMgd2Vy
ZSBoYXJkIGNvZGVkLg0KPiA+IE5vdyBzZWFyY2ggZm9yIHRoZW0gZm9yIHBhc3NpbmcgdG8gZHJt
X2NydGNfaW5pdF93aXRoX3BsYW5lcw0KPiA+IA0KPiANCj4gUmV2aWV3ZWQtYnk6IENLIEh1IDxj
ay5odUBtZWRpYXRlay5jb20+DQoNCkFwcGxpZWQgdG8gbWVkaWF0ZWstZHJtLWZpeGVzLTUuNiBb
MV0sIHRoYW5rcy4NCg0KWzFdDQpodHRwczovL2dpdGh1Yi5jb20vY2todS1tZWRpYXRlay9saW51
eC5naXQtdGFncy9jb21taXRzL21lZGlhdGVrLWRybS1maXhlcy01LjYNCg0KUmVnYXJkcywNCkNL
DQoNCj4gDQo+ID4gU2lnbmVkLW9mZi1ieTogRXZhbiBCZW5uIDxldmFuYmVubkBjaHJvbWl1bS5v
cmc+DQo+ID4gLS0tDQo+ID4gDQo+ID4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJt
X2NydGMuYyB8IDE4ICsrKysrKysrKysrKy0tLS0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTIg
aW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5jIGIvZHJpdmVycy9ncHUvZHJtL21l
ZGlhdGVrL210a19kcm1fY3J0Yy5jDQo+ID4gaW5kZXggN2IzOTJkNmM3MWNjLi45MzU2NTI5OTBh
ZmEgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0
Yy5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5jDQo+
ID4gQEAgLTY1OCwxMCArNjU4LDE4IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZHJtX2NydGNfaGVs
cGVyX2Z1bmNzIG10a19jcnRjX2hlbHBlcl9mdW5jcyA9IHsNCj4gPiAgDQo+ID4gIHN0YXRpYyBp
bnQgbXRrX2RybV9jcnRjX2luaXQoc3RydWN0IGRybV9kZXZpY2UgKmRybSwNCj4gPiAgCQkJICAg
ICBzdHJ1Y3QgbXRrX2RybV9jcnRjICptdGtfY3J0YywNCj4gPiAtCQkJICAgICBzdHJ1Y3QgZHJt
X3BsYW5lICpwcmltYXJ5LA0KPiA+IC0JCQkgICAgIHN0cnVjdCBkcm1fcGxhbmUgKmN1cnNvciwg
dW5zaWduZWQgaW50IHBpcGUpDQo+ID4gKwkJCSAgICAgdW5zaWduZWQgaW50IHBpcGUpDQo+ID4g
IHsNCj4gPiAtCWludCByZXQ7DQo+ID4gKwlzdHJ1Y3QgZHJtX3BsYW5lICpwcmltYXJ5ID0gTlVM
TDsNCj4gPiArCXN0cnVjdCBkcm1fcGxhbmUgKmN1cnNvciA9IE5VTEw7DQo+ID4gKwlpbnQgaSwg
cmV0Ow0KPiA+ICsNCj4gPiArCWZvciAoaSA9IDA7IGkgPCBtdGtfY3J0Yy0+bGF5ZXJfbnI7IGkr
Kykgew0KPiA+ICsJCWlmIChtdGtfY3J0Yy0+cGxhbmVzW2ldLnR5cGUgPT0gRFJNX1BMQU5FX1RZ
UEVfUFJJTUFSWSkNCj4gPiArCQkJcHJpbWFyeSA9ICZtdGtfY3J0Yy0+cGxhbmVzW2ldOw0KPiA+
ICsJCWVsc2UgaWYgKG10a19jcnRjLT5wbGFuZXNbaV0udHlwZSA9PSBEUk1fUExBTkVfVFlQRV9D
VVJTT1IpDQo+ID4gKwkJCWN1cnNvciA9ICZtdGtfY3J0Yy0+cGxhbmVzW2ldOw0KPiA+ICsJfQ0K
PiA+ICANCj4gPiAgCXJldCA9IGRybV9jcnRjX2luaXRfd2l0aF9wbGFuZXMoZHJtLCAmbXRrX2Ny
dGMtPmJhc2UsIHByaW1hcnksIGN1cnNvciwNCj4gPiAgCQkJCQkmbXRrX2NydGNfZnVuY3MsIE5V
TEwpOw0KPiA+IEBAIC04MzAsOSArODM4LDcgQEAgaW50IG10a19kcm1fY3J0Y19jcmVhdGUoc3Ry
dWN0IGRybV9kZXZpY2UgKmRybV9kZXYsDQo+ID4gIAkJCXJldHVybiByZXQ7DQo+ID4gIAl9DQo+
ID4gIA0KPiA+IC0JcmV0ID0gbXRrX2RybV9jcnRjX2luaXQoZHJtX2RldiwgbXRrX2NydGMsICZt
dGtfY3J0Yy0+cGxhbmVzWzBdLA0KPiA+IC0JCQkJbXRrX2NydGMtPmxheWVyX25yID4gMSA/ICZt
dGtfY3J0Yy0+cGxhbmVzWzFdIDoNCj4gPiAtCQkJCU5VTEwsIHBpcGUpOw0KPiA+ICsJcmV0ID0g
bXRrX2RybV9jcnRjX2luaXQoZHJtX2RldiwgbXRrX2NydGMsIHBpcGUpOw0KPiA+ICAJaWYgKHJl
dCA8IDApDQo+ID4gIAkJcmV0dXJuIHJldDsNCj4gPiAgDQo+IA0KDQo=

