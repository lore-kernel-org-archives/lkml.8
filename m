Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF74C7619B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 01:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96EA1208C4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 01:15:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="mgKM+8Nw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbgBQBPy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Feb 2020 20:15:54 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:56056 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726183AbgBQBPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 20:15:54 -0500
X-UUID: 58ba2fca33f14c9791cf60f1413a63f1-20200217
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=udU/3e9H9cGpZ7qWkk4wYru8GgYPMObjkY0Yy3r1L74=;
        b=mgKM+8Nwn5zTb+/rSNb5iz+ExOM4Sc8MJzwPOEl9Zm6o724DKBP/zA1xoJZiHL8YDpP6WEh3nDoNYG3A98KErmjV79kxkXk2ic/+xGEQid62GraYImiua/s7hbcxQZMmDCcEhbSqFxp1+sYvJe5XBz2/Jf5E7vi6ycpB47HVuBk=;
X-UUID: 58ba2fca33f14c9791cf60f1413a63f1-20200217
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 689842576; Mon, 17 Feb 2020 09:15:48 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 17 Feb 2020 09:14:16 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 17 Feb 2020 09:15:24 +0800
Message-ID: <1581902146.28283.0.camel@mtksdaap41>
Subject: Re: [PATCH 2/2] iommu/mediatek: add support for MT8167
From:   CK Hu <ck.hu@mediatek.com>
To:     Fabien Parent <fparent@baylibre.com>,
        Yong Wu <yong.wu@mediatek.com>
CC:     <iommu@lists.linux-foundation.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <mark.rutland@arm.com>,
        <matthias.bgg@gmail.com>, <joro@8bytes.org>, <robh+dt@kernel.org>
Date:   Mon, 17 Feb 2020 09:15:46 +0800
In-Reply-To: <20200103162632.109553-2-fparent@baylibre.com>
References: <20200103162632.109553-1-fparent@baylibre.com>
         <20200103162632.109553-2-fparent@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 1FF58C5F95081E4197AD9A1E11E99E371D55C8CC78938A0A06E74C41163DCFFC2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

K1lvbmcuV3UuDQoNCk9uIEZyaSwgMjAyMC0wMS0wMyBhdCAxNzoyNiArMDEwMCwgRmFiaWVuIFBh
cmVudCB3cm90ZToNCj4gQWRkIHN1cHBvcnQgZm9yIHRoZSBJT01NVSBvbiBNVDgxNjcNCj4gDQo+
IFNpZ25lZC1vZmYtYnk6IEZhYmllbiBQYXJlbnQgPGZwYXJlbnRAYmF5bGlicmUuY29tPg0KPiAt
LS0NCj4gIGRyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMgfCAxMSArKysrKysrKysrLQ0KPiAgZHJp
dmVycy9pb21tdS9tdGtfaW9tbXUuaCB8ICAxICsNCj4gIDIgZmlsZXMgY2hhbmdlZCwgMTEgaW5z
ZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9t
bXUvbXRrX2lvbW11LmMgYi9kcml2ZXJzL2lvbW11L210a19pb21tdS5jDQo+IGluZGV4IDZmYzFm
NWVjZjkxZS4uNWZjNjE3OGE4MmRjIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2lvbW11L210a19p
b21tdS5jDQo+ICsrKyBiL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMNCj4gQEAgLTU2OSw3ICs1
NjksOCBAQCBzdGF0aWMgaW50IG10a19pb21tdV9od19pbml0KGNvbnN0IHN0cnVjdCBtdGtfaW9t
bXVfZGF0YSAqZGF0YSkNCj4gIAkJRl9JTlRfUFJFVEVUQ0hfVFJBTlNBVElPTl9GSUZPX0ZBVUxU
Ow0KPiAgCXdyaXRlbF9yZWxheGVkKHJlZ3ZhbCwgZGF0YS0+YmFzZSArIFJFR19NTVVfSU5UX01B
SU5fQ09OVFJPTCk7DQo+ICANCj4gLQlpZiAoZGF0YS0+cGxhdF9kYXRhLT5tNHVfcGxhdCA9PSBN
NFVfTVQ4MTczKQ0KPiArCWlmIChkYXRhLT5wbGF0X2RhdGEtPm00dV9wbGF0ID09IE00VV9NVDgx
NzMgfHwNCj4gKwkgICAgZGF0YS0+cGxhdF9kYXRhLT5tNHVfcGxhdCA9PSBNNFVfTVQ4MTY3KQ0K
PiAgCQlyZWd2YWwgPSAoZGF0YS0+cHJvdGVjdF9iYXNlID4+IDEpIHwgKGRhdGEtPmVuYWJsZV80
R0IgPDwgMzEpOw0KPiAgCWVsc2UNCj4gIAkJcmVndmFsID0gbG93ZXJfMzJfYml0cyhkYXRhLT5w
cm90ZWN0X2Jhc2UpIHwNCj4gQEAgLTc4Miw2ICs3ODMsMTMgQEAgc3RhdGljIGNvbnN0IHN0cnVj
dCBtdGtfaW9tbXVfcGxhdF9kYXRhIG10MjcxMl9kYXRhID0gew0KPiAgCS5sYXJiaWRfcmVtYXAg
PSB7MCwgMSwgMiwgMywgNCwgNSwgNiwgNywgOCwgOX0sDQo+ICB9Ow0KPiAgDQo+ICtzdGF0aWMg
Y29uc3Qgc3RydWN0IG10a19pb21tdV9wbGF0X2RhdGEgbXQ4MTY3X2RhdGEgPSB7DQo+ICsJLm00
dV9wbGF0ICAgICA9IE00VV9NVDgxNjcsDQo+ICsJLmhhc180Z2JfbW9kZSA9IHRydWUsDQo+ICsJ
LnJlc2V0X2F4aSAgICA9IHRydWUsDQo+ICsJLmxhcmJpZF9yZW1hcCA9IHswLCAxLCAyLCAzLCA0
LCA1fSwgLyogTGluZWFyIG1hcHBpbmcuICovDQo+ICt9Ow0KPiArDQo+ICBzdGF0aWMgY29uc3Qg
c3RydWN0IG10a19pb21tdV9wbGF0X2RhdGEgbXQ4MTczX2RhdGEgPSB7DQo+ICAJLm00dV9wbGF0
ICAgICA9IE00VV9NVDgxNzMsDQo+ICAJLmhhc180Z2JfbW9kZSA9IHRydWUsDQo+IEBAIC03OTgs
NiArODA2LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfaW9tbXVfcGxhdF9kYXRhIG10ODE4
M19kYXRhID0gew0KPiAgDQo+ICBzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBtdGtf
aW9tbXVfb2ZfaWRzW10gPSB7DQo+ICAJeyAuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDI3MTIt
bTR1IiwgLmRhdGEgPSAmbXQyNzEyX2RhdGF9LA0KPiArCXsgLmNvbXBhdGlibGUgPSAibWVkaWF0
ZWssbXQ4MTY3LW00dSIsIC5kYXRhID0gJm10ODE2N19kYXRhfSwNCj4gIAl7IC5jb21wYXRpYmxl
ID0gIm1lZGlhdGVrLG10ODE3My1tNHUiLCAuZGF0YSA9ICZtdDgxNzNfZGF0YX0sDQo+ICAJeyAu
Y29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxODMtbTR1IiwgLmRhdGEgPSAmbXQ4MTgzX2RhdGF9
LA0KPiAgCXt9DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L210a19pb21tdS5oIGIvZHJp
dmVycy9pb21tdS9tdGtfaW9tbXUuaA0KPiBpbmRleCBlYTk0OWEzMjRlMzMuLmNiOGZkNTk3MGNk
NCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuaA0KPiArKysgYi9kcml2
ZXJzL2lvbW11L210a19pb21tdS5oDQo+IEBAIC0zMCw2ICszMCw3IEBAIHN0cnVjdCBtdGtfaW9t
bXVfc3VzcGVuZF9yZWcgew0KPiAgZW51bSBtdGtfaW9tbXVfcGxhdCB7DQo+ICAJTTRVX01UMjcw
MSwNCj4gIAlNNFVfTVQyNzEyLA0KPiArCU00VV9NVDgxNjcsDQo+ICAJTTRVX01UODE3MywNCj4g
IAlNNFVfTVQ4MTgzLA0KPiAgfTsNCg0K

