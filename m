Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B0DC3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 12:23:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68ECC2146E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 12:23:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="V+Wb4VIy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387988AbgCDMXd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 07:23:33 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:3336 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387776AbgCDMXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 07:23:33 -0500
X-UUID: f60a90d2fe3b473190adbc45265b7a85-20200304
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=OssUNRC3Tj6PFiOJDmNMrtiv3wqgqqKa4MYNjVzDtI0=;
        b=V+Wb4VIyQmbCZh6bXJd24Ul9B1GMKJyoRpnzns1S1E30lgZlSKp+4lgjPEoFenjzdYFS/mL/ocNUD5hocCipvUkr2/Rtk4AvC094ZNEbH99fNA9feyBAAv5CRGXPoUSs3BT53M37ce5NrkJFouqyxs2n0uae2ouvpwEbM05f8B8=;
X-UUID: f60a90d2fe3b473190adbc45265b7a85-20200304
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 600072106; Wed, 04 Mar 2020 20:23:27 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 4 Mar
 2020 20:22:02 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 4 Mar 2020 20:22:25 +0800
Message-ID: <1583324597.4784.23.camel@mhfsdcap03>
Subject: Re: [PATCH v2 2/3] iommu/mediatek: add pdata member for legacy ivrp
 paddr
From:   Yong Wu <yong.wu@mediatek.com>
To:     Fabien Parent <fparent@baylibre.com>
CC:     <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <iommu@lists.linux-foundation.org>, <matthias.bgg@gmail.com>,
        <ck.hu@mediatek.com>, <joro@8bytes.org>, <anan.sun@mediatek.com>,
        <youlin.pei@mediatek.com>, <scott.wang@mediatek.com>
Date:   Wed, 4 Mar 2020 20:23:17 +0800
In-Reply-To: <20200302112152.2887131-2-fparent@baylibre.com>
References: <20200302112152.2887131-1-fparent@baylibre.com>
         <20200302112152.2887131-2-fparent@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: C6605E1F8BA11BF1D3312455B42D32C1E8866B40A03E980F364CC1ED7C780BC92000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIwLTAzLTAyIGF0IDEyOjIxICswMTAwLCBGYWJpZW4gUGFyZW50IHdyb3RlOg0K
PiBBZGQgYSBuZXcgcGxhdGZvcm0gZGF0YSBtZW1iZXIgaW4gb3JkZXIgdG8gc2VsZWN0IHdoaWNo
IElWUlBfUEFERFINCj4gZm9ybWF0IGlzIHVzZWQgYnkgYW4gU29DLg0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogRmFiaWVuIFBhcmVudCA8ZnBhcmVudEBiYXlsaWJyZS5jb20+DQo+IC0tLQ0KPiANCj4g
djI6IG5ldyBwYXRjaA0KPiANCj4gLS0tDQo+ICBkcml2ZXJzL2lvbW11L210a19pb21tdS5jIHwg
MyArKy0NCj4gIGRyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmggfCAxICsNCj4gIDIgZmlsZXMgY2hh
bmdlZCwgMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYyBiL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMNCj4g
aW5kZXggOTU5NDVmNDY3YzAzLi43OGNiMTRhYjdkZDAgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMv
aW9tbXUvbXRrX2lvbW11LmMNCj4gKysrIGIvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYw0KPiBA
QCAtNTY5LDcgKzU2OSw3IEBAIHN0YXRpYyBpbnQgbXRrX2lvbW11X2h3X2luaXQoY29uc3Qgc3Ry
dWN0IG10a19pb21tdV9kYXRhICpkYXRhKQ0KPiAgCQlGX0lOVF9QUkVURVRDSF9UUkFOU0FUSU9O
X0ZJRk9fRkFVTFQ7DQo+ICAJd3JpdGVsX3JlbGF4ZWQocmVndmFsLCBkYXRhLT5iYXNlICsgUkVH
X01NVV9JTlRfTUFJTl9DT05UUk9MKTsNCj4gIA0KPiAtCWlmIChkYXRhLT5wbGF0X2RhdGEtPm00
dV9wbGF0ID09IE00VV9NVDgxNzMpDQo+ICsJaWYgKGRhdGEtPnBsYXRfZGF0YS0+aGFzX2xlZ2Fj
eV9pdnJwX3BhZGRyKQ0KPiAgCQlyZWd2YWwgPSAoZGF0YS0+cHJvdGVjdF9iYXNlID4+IDEpIHwg
KGRhdGEtPmVuYWJsZV80R0IgPDwgMzEpOw0KPiAgCWVsc2UNCj4gIAkJcmVndmFsID0gbG93ZXJf
MzJfYml0cyhkYXRhLT5wcm90ZWN0X2Jhc2UpIHwNCj4gQEAgLTc4Niw2ICs3ODYsNyBAQCBzdGF0
aWMgY29uc3Qgc3RydWN0IG10a19pb21tdV9wbGF0X2RhdGEgbXQ4MTczX2RhdGEgPSB7DQo+ICAJ
Lm00dV9wbGF0ICAgICA9IE00VV9NVDgxNzMsDQo+ICAJLmhhc180Z2JfbW9kZSA9IHRydWUsDQo+
ICAJLmhhc19iY2xrICAgICA9IHRydWUsDQo+ICsJLmhhc19sZWdhY3lfaXZycF9wYWRkciA9IHRy
dWU7DQo+ICAJLnJlc2V0X2F4aSAgICA9IHRydWUsDQo+ICAJLmxhcmJpZF9yZW1hcCA9IHswLCAx
LCAyLCAzLCA0LCA1fSwgLyogTGluZWFyIG1hcHBpbmcuICovDQo+ICB9Ow0KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuaCBiL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmgN
Cj4gaW5kZXggZWE5NDlhMzI0ZTMzLi40Njk2YmEwMjdhNzEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZl
cnMvaW9tbXUvbXRrX2lvbW11LmgNCj4gKysrIGIvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuaA0K
PiBAQCAtNDIsNiArNDIsNyBAQCBzdHJ1Y3QgbXRrX2lvbW11X3BsYXRfZGF0YSB7DQo+ICAJYm9v
bCAgICAgICAgICAgICAgICBoYXNfYmNsazsNCj4gIAlib29sICAgICAgICAgICAgICAgIGhhc192
bGRfcGFfcm5nOw0KPiAgCWJvb2wgICAgICAgICAgICAgICAgcmVzZXRfYXhpOw0KPiArCWJvb2wg
ICAgICAgICAgICAgICAgaGFzX2xlZ2FjeV9pdnJwX3BhZGRyOw0KDQpJJ2QgbGlrZSB0byBwdXQg
dGhpcyBiZWZvcmUgImhhc192bGRfcGFfcm5nIiBhbHBoYWJldGljYWxseS4NCg0KT3RoZXIgdGhh
biB0aGlzLA0KDQpSZXZpZXdlZC1ieTogWW9uZyBXdSA8eW9uZy53dUBtZWRpYXRlay5jb20+DQoN
Cj4gIAl1bnNpZ25lZCBjaGFyICAgICAgIGxhcmJpZF9yZW1hcFtNVEtfTEFSQl9OUl9NQVhdOw0K
PiAgfTsNCj4gIA0KDQo=

