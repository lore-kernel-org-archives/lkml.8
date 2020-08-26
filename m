Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 637C7C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 08:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F271920707
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 08:31:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="UYY8pk8R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbgHZIa7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 04:30:59 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:9066 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726813AbgHZIa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 04:30:59 -0400
X-UUID: 0f79fa79b1674757a54b18818e31429c-20200826
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=nm4wPKgjzNpL+M+MH1P1YfFvO1+9lob2dGm1Je/jS9g=;
        b=UYY8pk8RrFN5Ktsq4mYdkLCk+MG55jVXvkOYUj6iGpzSXBatS7p/oTN+UeevR2ouKpz5Oajh1vhOiwkP5oiMsIDshYQvmecKBdxDTbtMwsXhBlWL+0slwcBkrE6MXGmNnX0rTE3vywnD1Df7/7UDYj2gw2b4ToUJCD351KPbMgs=;
X-UUID: 0f79fa79b1674757a54b18818e31429c-20200826
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <andrew-ct.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 560009724; Wed, 26 Aug 2020 16:30:57 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 26 Aug 2020 16:30:51 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 26 Aug 2020 16:30:51 +0800
Message-ID: <1598430653.18394.5.camel@mtksdaap41>
Subject: Re: [PATCH v2] nvmem: mtk-efuse: Remove EFUSE register write support
From:   andrew-ct chen <andrew-ct.chen@mediatek.com>
To:     Chih-En Hsu <chih-en.hsu@mediatek.com>
CC:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        <Michael.Mei@mediatek.com>
Date:   Wed, 26 Aug 2020 16:30:53 +0800
In-Reply-To: <20200826062148.27293-1-chih-en.hsu@mediatek.com>
References: <20200826062148.27293-1-chih-en.hsu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ2hpaC1FbiwNCg0KT24gV2VkLCAyMDIwLTA4LTI2IGF0IDE0OjIxICswODAwLCBDaGloLUVu
IEhzdSB3cm90ZToNCj4gVGhpcyBwYXRjaCBpcyB0byByZW1vdmUgZnVuY3Rpb24gIm10a19yZWdf
d3JpdGUiIHNpbmNlDQo+IE1lZGlhdGVrIEVGVVNFIGhhcmR3YXJlIG9ubHkgc3VwcG9ydHMgcmVh
ZCBmdW5jdGlvbmFsaXR5DQo+IGZvciBOVk1FTSBjb25zdW1lcnMuDQoNClRoZSBmaXhlZCBwYXRj
aCBzaG91bGQgYmUgYmEzNjBmZDA0MGUzNCAoIm52bWVtOiBtdGstZWZ1c2U6IHJlbW92ZSBudm1l
bQ0KcmVnbWFwIGRlcGVuZGVuY3kiKQ0KDQo+IEZpeGVzOiA0YzdlNGZlMzc3NjYgKCJudm1lbTog
bWVkaWF0ZWs6IEFkZCBNZWRpYXRlayBFRlVTRSBkcml2ZXIiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBD
aGloLUVuIEhzdSA8Y2hpaC1lbi5oc3VAbWVkaWF0ZWsuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMv
bnZtZW0vbXRrLWVmdXNlLmMgfCAxNCAtLS0tLS0tLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQs
IDE0IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZW0vbXRrLWVm
dXNlLmMgYi9kcml2ZXJzL252bWVtL210ay1lZnVzZS5jDQo+IGluZGV4IDg1NmQ5YzNmYzM4ZS4u
NmE1MzdkOTU5ZjE0IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL252bWVtL210ay1lZnVzZS5jDQo+
ICsrKyBiL2RyaXZlcnMvbnZtZW0vbXRrLWVmdXNlLmMNCj4gQEAgLTI4LDE5ICsyOCw2IEBAIHN0
YXRpYyBpbnQgbXRrX3JlZ19yZWFkKHZvaWQgKmNvbnRleHQsDQo+ICAJcmV0dXJuIDA7DQo+ICB9
DQo+ICANCj4gLXN0YXRpYyBpbnQgbXRrX3JlZ193cml0ZSh2b2lkICpjb250ZXh0LA0KPiAtCQkJ
IHVuc2lnbmVkIGludCByZWcsIHZvaWQgKl92YWwsIHNpemVfdCBieXRlcykNCj4gLXsNCj4gLQlz
dHJ1Y3QgbXRrX2VmdXNlX3ByaXYgKnByaXYgPSBjb250ZXh0Ow0KPiAtCXUzMiAqdmFsID0gX3Zh
bDsNCj4gLQlpbnQgaSA9IDAsIHdvcmRzID0gYnl0ZXMgLyA0Ow0KPiAtDQo+IC0Jd2hpbGUgKHdv
cmRzLS0pDQo+IC0JCXdyaXRlbCgqdmFsKyssIHByaXYtPmJhc2UgKyByZWcgKyAoaSsrICogNCkp
Ow0KPiAtDQo+IC0JcmV0dXJuIDA7DQo+IC19DQo+IC0NCj4gIHN0YXRpYyBpbnQgbXRrX2VmdXNl
X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICB7DQo+ICAJc3RydWN0IGRl
dmljZSAqZGV2ID0gJnBkZXYtPmRldjsNCj4gQEAgLTYxLDcgKzQ4LDYgQEAgc3RhdGljIGludCBt
dGtfZWZ1c2VfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gIAllY29uZmln
LnN0cmlkZSA9IDQ7DQo+ICAJZWNvbmZpZy53b3JkX3NpemUgPSA0Ow0KPiAgCWVjb25maWcucmVn
X3JlYWQgPSBtdGtfcmVnX3JlYWQ7DQo+IC0JZWNvbmZpZy5yZWdfd3JpdGUgPSBtdGtfcmVnX3dy
aXRlOw0KPiAgCWVjb25maWcuc2l6ZSA9IHJlc291cmNlX3NpemUocmVzKTsNCj4gIAllY29uZmln
LnByaXYgPSBwcml2Ow0KPiAgCWVjb25maWcuZGV2ID0gZGV2Ow0KDQo=

