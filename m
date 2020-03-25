Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5080FC54FD0
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 09:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2329520722
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 09:22:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Yg1qvMxP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbgCYJWe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 05:22:34 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:56353 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725907AbgCYJWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 05:22:34 -0400
X-UUID: b76f619bb6e049fc9be921327f75bc92-20200325
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=BVyTHhelUjx59FjyxWQdpVbGtCVCGjT0t0rY/9a/ceg=;
        b=Yg1qvMxPnQhw33GbmLfbB9dTN00UUkRGXdhqb8HRojugEDEWgnpVwZgZIUS5Xct0/xypCoWJyuT0YyTUQxmqCatwBt4xqWeTr2+8ElGTWw5Bt2yJV+RhcZx4Mg5/RcqrnYXpEqQDAtdmyljEVz2YU+XFXR4eW5PsbZVzV/6M0Gk=;
X-UUID: b76f619bb6e049fc9be921327f75bc92-20200325
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <yingjoe.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1257327960; Wed, 25 Mar 2020 17:22:24 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 25 Mar 2020 17:22:22 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 25 Mar 2020 17:22:22 +0800
Message-ID: <1585128143.18052.3.camel@mtksdaap41>
Subject: Re: [PATCH v4 3/6] pinctrl: mediatek: avoid virtual gpio trying to
 set reg
From:   Yingjoe Chen <yingjoe.chen@mediatek.com>
To:     Hanks Chen <hanks.chen@mediatek.com>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>, Andy Teng <andy.teng@mediatek.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Mars Cheng <mars.cheng@mediatek.com>
Date:   Wed, 25 Mar 2020 17:22:23 +0800
In-Reply-To: <1585123964-10791-4-git-send-email-hanks.chen@mediatek.com>
References: <1585123964-10791-1-git-send-email-hanks.chen@mediatek.com>
         <1585123964-10791-4-git-send-email-hanks.chen@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIwLTAzLTI1IGF0IDE2OjEyICswODAwLCBIYW5rcyBDaGVuIHdyb3RlOg0KPiBm
b3IgdmlydHVhbCBncGlvcywgdGhleSBzaG91bGQgbm90IGRvIHJlZyBzZXR0aW5nIGFuZA0KPiBz
aG91bGQgYmVoYXZlIGFzIGV4cGVjdGVkIGZvciBlaW50IGZ1bmN0aW9uLg0KPiANCj4gQ2hhbmdl
LUlkOiBJOTEzNTAxZjIxYzg0MWMyY2I5ODE1MzBjZDM4NzM5NTY0OGY4Mzk4NA0KDQpQbGVhc2Ug
cmVtb3ZlIENoYW5nZS1JZDoNCg0KDQo+IFNpZ25lZC1vZmYtYnk6IEhhbmtzIENoZW4gPGhhbmtz
LmNoZW5AbWVkaWF0ZWsuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBNYXJzIENoZW5nIDxtYXJzLmNo
ZW5nQG1lZGlhdGVrLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL3BpbmN0cmwvbWVkaWF0ZWsvcGlu
Y3RybC1tdGstY29tbW9uLXYyLmMgfCAgIDI4ICsrKysrKysrKysrKysrKysrKysrKysNCj4gIGRy
aXZlcnMvcGluY3RybC9tZWRpYXRlay9waW5jdHJsLW10ay1jb21tb24tdjIuaCB8ICAgIDEgKw0K
PiAgZHJpdmVycy9waW5jdHJsL21lZGlhdGVrL3BpbmN0cmwtcGFyaXMuYyAgICAgICAgIHwgICAg
NyArKysrKysNCj4gIDMgZmlsZXMgY2hhbmdlZCwgMzYgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvcGluY3RybC9tZWRpYXRlay9waW5jdHJsLW10ay1jb21tb24tdjIu
YyBiL2RyaXZlcnMvcGluY3RybC9tZWRpYXRlay9waW5jdHJsLW10ay1jb21tb24tdjIuYw0KPiBp
bmRleCAyMGUxYzg5Li4wODdkMjMzIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3BpbmN0cmwvbWVk
aWF0ZWsvcGluY3RybC1tdGstY29tbW9uLXYyLmMNCj4gKysrIGIvZHJpdmVycy9waW5jdHJsL21l
ZGlhdGVrL3BpbmN0cmwtbXRrLWNvbW1vbi12Mi5jDQo+IEBAIC0yMjYsNiArMjI2LDMxIEBAIHN0
YXRpYyBpbnQgbXRrX3h0X2ZpbmRfZWludF9udW0oc3RydWN0IG10a19waW5jdHJsICpodywgdW5z
aWduZWQgbG9uZyBlaW50X24pDQo+ICAJcmV0dXJuIEVJTlRfTkE7DQo+ICB9DQo+ICANCj4gKy8q
DQo+ICsgKiBWaXJ0dWFsIEdQSU8gb25seSB1c2VkIGluc2lkZSBTT0MgYW5kIG5vdCBiZWluZyBl
eHBvcnRlZCB0byBvdXRzaWRlIFNPQy4NCj4gKyAqIFNvbWUgbW9kdWxlcyB1c2UgdmlydHVhbCBH
UElPIGFzIGVpbnQgKGUuZy4gcG1pZiBvciB1c2IpLg0KPiArICogSW4gTVRLIHBsYXRmb3JtLCBl
eHRlcm5hbCBpbnRlcnJ1cHQgKEVJTlQpIGFuZCBHUElPIGlzIDEtMSBtYXBwaW5nDQo+ICsgKiBh
bmQgd2UgY2FuIHNldCBHUElPIGFzIGVpbnQuDQo+ICsgKiBCdXQgc29tZSBtb2R1bGVzIHVzZSBz
cGVjaWZpYyBlaW50IHdoaWNoIGRvZXNuJ3QgaGF2ZSByZWFsIEdQSU8gcGluLg0KPiArICogU28g
d2UgdXNlIHZpcnR1YWwgR1BJTyB0byBtYXAgaXQuDQo+ICsgKi8NCj4gKw0KPiArYm9vbCBtdGtf
aXNfdmlydF9ncGlvKHN0cnVjdCBtdGtfcGluY3RybCAqaHcsIHVuc2lnbmVkIGludCBncGlvX24p
DQo+ICt7DQo+ICsJY29uc3Qgc3RydWN0IG10a19waW5fZGVzYyAqZGVzYzsNCj4gKwlib29sIHZp
cnRfZ3BpbyA9IGZhbHNlOw0KPiArDQo+ICsJaWYgKGdwaW9fbiA+PSBody0+c29jLT5ucGlucykN
Cj4gKwkJcmV0dXJuIHZpcnRfZ3BpbzsNCj4gKw0KPiArCWRlc2MgPSAoY29uc3Qgc3RydWN0IG10
a19waW5fZGVzYyAqKSZody0+c29jLT5waW5zW2dwaW9fbl07DQo+ICsNCj4gKwlpZiAoZGVzYy0+
ZnVuY3MgJiYgIWRlc2MtPmZ1bmNzW2Rlc2MtPmVpbnQuZWludF9tXS5uYW1lKQ0KPiArCQl2aXJ0
X2dwaW8gPSB0cnVlOw0KDQpJIHRoaW5rIHJlbW92aW5nIHZpcnRfZ3BpbyBhbmQganVzdCByZXR1
cm4gdHJ1ZS9mYWxzZSBmb3IgdGhpcyBmdW5jdGlvbg0Kd2lsbCBtYWtlIGl0IGVhc2llciB0byBy
ZWFkLg0KDQpKb2UuQw0KDQo+ICsNCj4gKwlyZXR1cm4gdmlydF9ncGlvOw0KPiArfQ0KDQoNCg==

