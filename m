Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A5F5C3F68F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 06:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FDFE222C2
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 06:24:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Ocmec2C4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728740AbgBNGYG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 01:24:06 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:13989 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725944AbgBNGYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 01:24:06 -0500
X-UUID: d2ccea35cf6a408f863d76cef6a43745-20200214
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=mJEdOBJrDxxHAkQhloAsNjKpaHcV9joa9xc+Z06QjCA=;
        b=Ocmec2C4uJn1VHMiRGwWoV+jBtk2k31FbI/Bcxy0ZbHJ4B1W4bkfy/ILRXsK5LG6Hf2BjM7xo/CrpiiHhbmxuiOcippNW/j95z0KiLssEgonPX9GYuIIqdUpfd7fhSqe3vMyMBxf4LKKqJOS+mraBp7+bVfJv3LcvWHXdSyW84I=;
X-UUID: d2ccea35cf6a408f863d76cef6a43745-20200214
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1976186927; Fri, 14 Feb 2020 14:23:59 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 14 Feb 2020 14:23:05 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 14 Feb 2020 14:23:28 +0800
Message-ID: <1581661437.16618.0.camel@mtksdaap41>
Subject: Re: [PATCH] soc: mediatek: knows_txdone needs to be set in Mediatek
 CMDQ helper
From:   CK Hu <ck.hu@mediatek.com>
To:     Bibby Hsieh <bibby.hsieh@mediatek.com>
CC:     Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Dennis-YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>
Date:   Fri, 14 Feb 2020 14:23:57 +0800
In-Reply-To: <20200214043545.16713-1-bibby.hsieh@mediatek.com>
References: <20200214043545.16713-1-bibby.hsieh@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEJpYmJ5Og0KDQpPbiBGcmksIDIwMjAtMDItMTQgYXQgMTI6MzUgKzA4MDAsIEJpYmJ5IEhz
aWVoIHdyb3RlOg0KPiBNZWRpYXRlayBDTURRIGRyaXZlciBoYXZlIGEgbWVjaGFuaXNtIHRvIGRv
IFRYRE9ORV9CWV9BQ0ssDQo+IHNvIHdlIHNob3VsZCBzZXQga25vd3NfdHhkb25lLg0KPiANCg0K
UmV2aWV3ZWQtYnk6IENLIEh1IDxjay5odUBtZWRpYXRlay5jb20+DQoNCj4gRml4ZXM6NTc2ZjFi
NGJjODAyICgic29jOiBtZWRpYXRlazogQWRkIE1lZGlhdGVrIENNRFEgaGVscGVyIikNCj4gDQo+
IFNpZ25lZC1vZmYtYnk6IEJpYmJ5IEhzaWVoIDxiaWJieS5oc2llaEBtZWRpYXRlay5jb20+DQo+
IC0tLQ0KPiAgZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMgfCAxICsNCj4g
IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jIGIvZHJpdmVycy9zb2MvbWVkaWF0ZWsv
bXRrLWNtZHEtaGVscGVyLmMNCj4gaW5kZXggOWFkZDBmZDVmYTZjLi4yY2ExYTc1OWEzNDcgMTAw
NjQ0DQo+IC0tLSBhL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jDQo+ICsr
KyBiL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jDQo+IEBAIC04MCw2ICs4
MCw3IEBAIHN0cnVjdCBjbWRxX2NsaWVudCAqY21kcV9tYm94X2NyZWF0ZShzdHJ1Y3QgZGV2aWNl
ICpkZXYsIGludCBpbmRleCwgdTMyIHRpbWVvdXQpDQo+ICAJY2xpZW50LT5wa3RfY250ID0gMDsN
Cj4gIAljbGllbnQtPmNsaWVudC5kZXYgPSBkZXY7DQo+ICAJY2xpZW50LT5jbGllbnQudHhfYmxv
Y2sgPSBmYWxzZTsNCj4gKwljbGllbnQtPmNsaWVudC5rbm93c190eGRvbmUgPSB0cnVlOw0KPiAg
CWNsaWVudC0+Y2hhbiA9IG1ib3hfcmVxdWVzdF9jaGFubmVsKCZjbGllbnQtPmNsaWVudCwgaW5k
ZXgpOw0KPiAgDQo+ICAJaWYgKElTX0VSUihjbGllbnQtPmNoYW4pKSB7DQoNCg==

