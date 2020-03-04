Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9466FC3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 12:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C55E2146E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 12:22:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="eRQ3etiQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387948AbgCDMWg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 07:22:36 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:60093 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387801AbgCDMWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 07:22:36 -0500
X-UUID: 5c917b8437d84f08acf4f479c26a34f2-20200304
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=G3qywGgyJLG5zIB5C4MO427fFnJC0uUmsvwjBMR84aU=;
        b=eRQ3etiQz0k00Y/O4qrGp5zeoDLOhNrZ4ojvFAtAXDxEWXpBTGh2IbBnX8KxMd8L10IaGPxFFfIjlbeptdFy6PQDpT8JfRr8HpWGIJbL+DZBcwGLdlquXaR4qGYBsRIoB38xriDIObO3TM/fDCY1AvvcMepSfYlQQN/2cp+NYM0=;
X-UUID: 5c917b8437d84f08acf4f479c26a34f2-20200304
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1720254188; Wed, 04 Mar 2020 20:22:27 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by mtkmbs05n1.mediatek.inc
 (172.21.101.15) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 4 Mar
 2020 20:21:18 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 4 Mar 2020 20:21:25 +0800
Message-ID: <1583324538.4784.22.camel@mhfsdcap03>
Subject: Re: [PATCH v2 3/3] iommu/mediatek: add support for MT8167
From:   Yong Wu <yong.wu@mediatek.com>
To:     Fabien Parent <fparent@baylibre.com>
CC:     <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <iommu@lists.linux-foundation.org>, <matthias.bgg@gmail.com>,
        <ck.hu@mediatek.com>, <joro@8bytes.org>
Date:   Wed, 4 Mar 2020 20:22:18 +0800
In-Reply-To: <20200302112152.2887131-3-fparent@baylibre.com>
References: <20200302112152.2887131-1-fparent@baylibre.com>
         <20200302112152.2887131-3-fparent@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIwLTAzLTAyIGF0IDEyOjIxICswMTAwLCBGYWJpZW4gUGFyZW50IHdyb3RlOg0K
PiBBZGQgc3VwcG9ydCBmb3IgdGhlIElPTU1VIG9uIE1UODE2Nw0KPiANCj4gU2lnbmVkLW9mZi1i
eTogRmFiaWVuIFBhcmVudCA8ZnBhcmVudEBiYXlsaWJyZS5jb20+DQo+IC0tLQ0KPiANCj4gVjI6
DQo+IAkqIHJlbW92ZWQgaWYgYmFzZWQgb24gbTR1X3BsYXQsIGFuZCB1c2luZyBpbnN0ZWFkIHRo
ZSBuZXcNCj4gCWhhc19sZWdhY3lfaXZycF9wYWRkciBtZW1iZXIgdGhhdCB3YXMgaW50cm9kdWNl
ZCBpbiBwYXRjaCAyLg0KPiANCj4gLS0tDQo+ICBkcml2ZXJzL2lvbW11L210a19pb21tdS5jIHwg
OSArKysrKysrKysNCj4gIGRyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmggfCAxICsNCj4gIDIgZmls
ZXMgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
aW9tbXUvbXRrX2lvbW11LmMgYi9kcml2ZXJzL2lvbW11L210a19pb21tdS5jDQo+IGluZGV4IDc4
Y2IxNGFiN2RkMC4uMjViN2FkMTY0N2JhIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2lvbW11L210
a19pb21tdS5jDQo+ICsrKyBiL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMNCj4gQEAgLTc4Miw2
ICs3ODIsMTQgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfaW9tbXVfcGxhdF9kYXRhIG10Mjcx
Ml9kYXRhID0gew0KPiAgCS5sYXJiaWRfcmVtYXAgPSB7MCwgMSwgMiwgMywgNCwgNSwgNiwgNywg
OCwgOX0sDQo+ICB9Ow0KPiAgDQo+ICtzdGF0aWMgY29uc3Qgc3RydWN0IG10a19pb21tdV9wbGF0
X2RhdGEgbXQ4MTY3X2RhdGEgPSB7DQo+ICsJLm00dV9wbGF0ICAgICA9IE00VV9NVDgxNjcsDQo+
ICsJLmhhc180Z2JfbW9kZSA9IHRydWUsDQo+ICsJLmhhc19sZWdhY3lfaXZycF9wYWRkciA9IHRy
dWU7DQo+ICsJLnJlc2V0X2F4aSAgICA9IHRydWUsDQo+ICsJLmxhcmJpZF9yZW1hcCA9IHswLCAx
LCAyLCAzLCA0LCA1fSwgLyogTGluZWFyIG1hcHBpbmcuICovDQoNCk5vcm1hbGx5IHdlIHB1dCB0
aGUgZmlsZSBpbmNsdWRlL2R0LWJpbmRpbmdzL21lbW9yeS9tdDgxNjctbGFyYi1wb3J0LmgNCmlu
dG8gdGhlIGZpcnN0IGJpbmRpbmcgcGF0Y2guIA0KDQpJZiB3ZSBoYXZlIHRoYXQgZmlsZSwgd2Ug
d2lsbCBrbm93IHRoZXJlIGlzIG9ubHkgMyBsYXJicyBpbiBtdDgxNjcuDQp0aHVzLCBoZXJlIHNo
b3VsZCBiZTogbGFyYmlkX3JlbWFwID0gezAsIDEsIDJ9DQoNCk90aGVyIHRoYW4gdGhpcywNCg0K
UmV2aWV3ZWQtYnk6IFlvbmcgV3UgPHlvbmcud3VAbWVkaWF0ZWsuY29tPg0KDQo+ICt9Ow0KPiAr
DQo+ICBzdGF0aWMgY29uc3Qgc3RydWN0IG10a19pb21tdV9wbGF0X2RhdGEgbXQ4MTczX2RhdGEg
PSB7DQo+ICAJLm00dV9wbGF0ICAgICA9IE00VV9NVDgxNzMsDQo+ICAJLmhhc180Z2JfbW9kZSA9
IHRydWUsDQo+IEBAIC03OTksNiArODA3LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfaW9t
bXVfcGxhdF9kYXRhIG10ODE4M19kYXRhID0gew0KPiAgDQo+ICBzdGF0aWMgY29uc3Qgc3RydWN0
IG9mX2RldmljZV9pZCBtdGtfaW9tbXVfb2ZfaWRzW10gPSB7DQo+ICAJeyAuY29tcGF0aWJsZSA9
ICJtZWRpYXRlayxtdDI3MTItbTR1IiwgLmRhdGEgPSAmbXQyNzEyX2RhdGF9LA0KPiArCXsgLmNv
bXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTY3LW00dSIsIC5kYXRhID0gJm10ODE2N19kYXRhfSwN
Cj4gIAl7IC5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE3My1tNHUiLCAuZGF0YSA9ICZtdDgx
NzNfZGF0YX0sDQo+ICAJeyAuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxODMtbTR1IiwgLmRh
dGEgPSAmbXQ4MTgzX2RhdGF9LA0KPiAgCXt9DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11
L210a19pb21tdS5oIGIvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuaA0KPiBpbmRleCA0Njk2YmEw
MjdhNzEuLjcyZjg3NGVjOWU5YyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9pb21tdS9tdGtfaW9t
bXUuaA0KPiArKysgYi9kcml2ZXJzL2lvbW11L210a19pb21tdS5oDQo+IEBAIC0zMCw2ICszMCw3
IEBAIHN0cnVjdCBtdGtfaW9tbXVfc3VzcGVuZF9yZWcgew0KPiAgZW51bSBtdGtfaW9tbXVfcGxh
dCB7DQo+ICAJTTRVX01UMjcwMSwNCj4gIAlNNFVfTVQyNzEyLA0KPiArCU00VV9NVDgxNjcsDQo+
ICAJTTRVX01UODE3MywNCj4gIAlNNFVfTVQ4MTgzLA0KPiAgfTsNCg0K

