Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA33C3F2D3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 14:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43AD8246A3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 14:44:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="fEwVUgql"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbgB1OoS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 09:44:18 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:46938 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726860AbgB1OoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 09:44:17 -0500
X-UUID: 134be1b3739c47e38870e25573550941-20200228
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=Oo9OqLwNu+IUBMtwmf3xp6IAkUZJKqSI+TGBkTXf0MU=;
        b=fEwVUgql/zgAEvFPUsB1rTth52ppMq5xvxEtXGDFEnmLQAwzf1iwYmv5g9NQp2GyQFqm1kGUfeWgOREcWZ96HM7YfgEaQrPogjzACShpLTDF+v8lvVjzC2NKuImn5d+Mc/xxcy0fExBkNGQ3sOlK6LTWLJjX1XH+hfIpcrthZW4=;
X-UUID: 134be1b3739c47e38870e25573550941-20200228
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1620552108; Fri, 28 Feb 2020 22:44:14 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 28 Feb 2020 22:45:52 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 28 Feb 2020 22:44:05 +0800
Message-ID: <1582901053.14824.3.camel@mtksdaap41>
Subject: Re: [PATCH v3 06/13] soc: mediatek: cmdq: add assign function
From:   CK Hu <ck.hu@mediatek.com>
To:     Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        "Ming-Fan Chen" <ming-fan.chen@mediatek.com>
Date:   Fri, 28 Feb 2020 22:44:13 +0800
In-Reply-To: <1582897461-15105-8-git-send-email-dennis-yc.hsieh@mediatek.com>
References: <1582897461-15105-1-git-send-email-dennis-yc.hsieh@mediatek.com>
         <1582897461-15105-8-git-send-email-dennis-yc.hsieh@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIERlbm5pczoNCg0KT24gRnJpLCAyMDIwLTAyLTI4IGF0IDIxOjQ0ICswODAwLCBEZW5uaXMg
WUMgSHNpZWggd3JvdGU6DQo+IEFkZCBhc3NpZ24gZnVuY3Rpb24gaW4gY21kcSBoZWxwZXIgd2hp
Y2ggYXNzaWduIGNvbnN0YW50IHZhbHVlIGludG8NCj4gaW50ZXJuYWwgcmVnaXN0ZXIgYnkgaW5k
ZXguDQo+IA0KDQpSZXZpZXdlZC1ieTogQ0sgSHUgPGNrLmh1QG1lZGlhdGVrLmNvbT4NCg0KPiBT
aWduZWQtb2ZmLWJ5OiBEZW5uaXMgWUMgSHNpZWggPGRlbm5pcy15Yy5oc2llaEBtZWRpYXRlay5j
b20+DQo+IC0tLQ0KPiAgZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMgICB8
IDI0ICsrKysrKysrKysrKysrKysrKysrKysrLQ0KPiAgaW5jbHVkZS9saW51eC9tYWlsYm94L210
ay1jbWRxLW1haWxib3guaCB8ICAxICsNCj4gIGluY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210
ay1jbWRxLmggICAgfCAxNCArKysrKysrKysrKysrKw0KPiAgMyBmaWxlcyBjaGFuZ2VkLCAzOCBp
bnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9z
b2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMgYi9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGst
Y21kcS1oZWxwZXIuYw0KPiBpbmRleCAwNjk4NjEyZGU1YWQuLjgzNDJhNWM5NGJjNyAxMDA2NDQN
Cj4gLS0tIGEvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMNCj4gKysrIGIv
ZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMNCj4gQEAgLTEyLDYgKzEyLDcg
QEANCj4gICNkZWZpbmUgQ01EUV9XUklURV9FTkFCTEVfTUFTSwlCSVQoMCkNCj4gICNkZWZpbmUg
Q01EUV9QT0xMX0VOQUJMRV9NQVNLCUJJVCgwKQ0KPiAgI2RlZmluZSBDTURRX0VPQ19JUlFfRU4J
CUJJVCgwKQ0KPiArI2RlZmluZSBDTURRX1JFR19UWVBFCQkxDQo+ICANCj4gIHN0cnVjdCBjbWRx
X2luc3RydWN0aW9uIHsNCj4gIAl1bmlvbiB7DQo+IEBAIC0yMSw4ICsyMiwxNyBAQCBzdHJ1Y3Qg
Y21kcV9pbnN0cnVjdGlvbiB7DQo+ICAJdW5pb24gew0KPiAgCQl1MTYgb2Zmc2V0Ow0KPiAgCQl1
MTYgZXZlbnQ7DQo+ICsJCXUxNiByZWdfZHN0Ow0KPiArCX07DQo+ICsJdW5pb24gew0KPiArCQl1
OCBzdWJzeXM7DQo+ICsJCXN0cnVjdCB7DQo+ICsJCQl1OCBzb3A6NTsNCj4gKwkJCXU4IGFyZ19j
X3Q6MTsNCj4gKwkJCXU4IGFyZ19iX3Q6MTsNCj4gKwkJCXU4IGRzdF90OjE7DQo+ICsJCX07DQo+
ICAJfTsNCj4gLQl1OCBzdWJzeXM7DQo+ICAJdTggb3A7DQo+ICB9Ow0KPiAgDQo+IEBAIC0yNzcs
NiArMjg3LDE4IEBAIGludCBjbWRxX3BrdF9wb2xsX21hc2soc3RydWN0IGNtZHFfcGt0ICpwa3Qs
IHU4IHN1YnN5cywNCj4gIH0NCj4gIEVYUE9SVF9TWU1CT0woY21kcV9wa3RfcG9sbF9tYXNrKTsN
Cj4gIA0KPiAraW50IGNtZHFfcGt0X2Fzc2lnbihzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgdTE2IHJl
Z19pZHgsIHUzMiB2YWx1ZSkNCj4gK3sNCj4gKwlzdHJ1Y3QgY21kcV9pbnN0cnVjdGlvbiBpbnN0
ID0geyB7MH0gfTsNCj4gKw0KPiArCWluc3Qub3AgPSBDTURRX0NPREVfTE9HSUM7DQo+ICsJaW5z
dC5kc3RfdCA9IENNRFFfUkVHX1RZUEU7DQo+ICsJaW5zdC5yZWdfZHN0ID0gcmVnX2lkeDsNCj4g
KwlpbnN0LnZhbHVlID0gdmFsdWU7DQo+ICsJcmV0dXJuIGNtZHFfcGt0X2FwcGVuZF9jb21tYW5k
KHBrdCwgaW5zdCk7DQo+ICt9DQo+ICtFWFBPUlRfU1lNQk9MKGNtZHFfcGt0X2Fzc2lnbik7DQo+
ICsNCj4gIHN0YXRpYyBpbnQgY21kcV9wa3RfZmluYWxpemUoc3RydWN0IGNtZHFfcGt0ICpwa3Qp
DQo+ICB7DQo+ICAJc3RydWN0IGNtZHFfaW5zdHJ1Y3Rpb24gaW5zdCA9IHsgezB9IH07DQo+IGRp
ZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5oIGIvaW5j
bHVkZS9saW51eC9tYWlsYm94L210ay1jbWRxLW1haWxib3guaA0KPiBpbmRleCBkZmU1YjJlYjg1
Y2MuLjEyMWMzYmI2ZDNkZSAxMDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9saW51eC9tYWlsYm94L210
ay1jbWRxLW1haWxib3guaA0KPiArKysgYi9pbmNsdWRlL2xpbnV4L21haWxib3gvbXRrLWNtZHEt
bWFpbGJveC5oDQo+IEBAIC01OSw2ICs1OSw3IEBAIGVudW0gY21kcV9jb2RlIHsNCj4gIAlDTURR
X0NPREVfSlVNUCA9IDB4MTAsDQo+ICAJQ01EUV9DT0RFX1dGRSA9IDB4MjAsDQo+ICAJQ01EUV9D
T0RFX0VPQyA9IDB4NDAsDQo+ICsJQ01EUV9DT0RFX0xPR0lDID0gMHhhMCwNCj4gIH07DQo+ICAN
Cj4gIGVudW0gY21kcV9jYl9zdGF0dXMgew0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9z
b2MvbWVkaWF0ZWsvbXRrLWNtZHEuaCBiL2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1j
bWRxLmgNCj4gaW5kZXggYTc0YzFkNWFjZGYzLi44MzM0MDIxMWUxZDMgMTAwNjQ0DQo+IC0tLSBh
L2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmgNCj4gKysrIGIvaW5jbHVkZS9s
aW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaA0KPiBAQCAtMTUyLDYgKzE1MiwyMCBAQCBpbnQg
Y21kcV9wa3RfcG9sbChzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgdTggc3Vic3lzLA0KPiAgICovDQo+
ICBpbnQgY21kcV9wa3RfcG9sbF9tYXNrKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1OCBzdWJzeXMs
DQo+ICAJCSAgICAgICB1MTYgb2Zmc2V0LCB1MzIgdmFsdWUsIHUzMiBtYXNrKTsNCj4gKw0KPiAr
LyoqDQo+ICsgKiBjbWRxX3BrdF9hc3NpZ24oKSAtIEFwcGVuZCBsb2dpYyBhc3NpZ24gY29tbWFu
ZCB0byB0aGUgQ01EUSBwYWNrZXQsIGFzayBHQ0UNCj4gKyAqCQkgICAgICAgdG8gZXhlY3V0ZSBh
biBpbnN0cnVjdGlvbiB0aGF0IHNldCBhIGNvbnN0YW50IHZhbHVlIGludG8NCj4gKyAqCQkgICAg
ICAgaW50ZXJuYWwgcmVnaXN0ZXIgYW5kIHVzZSBhcyB2YWx1ZSwgbWFzayBvciBhZGRyZXNzIGlu
DQo+ICsgKgkJICAgICAgIHJlYWQvd3JpdGUgaW5zdHJ1Y3Rpb24uDQo+ICsgKiBAcGt0Ogl0aGUg
Q01EUSBwYWNrZXQNCj4gKyAqIEByZWdfaWR4Ogl0aGUgQ01EUSBpbnRlcm5hbCByZWdpc3RlciBJ
RA0KPiArICogQHZhbHVlOgl0aGUgc3BlY2lmaWVkIHZhbHVlDQo+ICsgKg0KPiArICogUmV0dXJu
OiAwIGZvciBzdWNjZXNzOyBlbHNlIHRoZSBlcnJvciBjb2RlIGlzIHJldHVybmVkDQo+ICsgKi8N
Cj4gK2ludCBjbWRxX3BrdF9hc3NpZ24oc3RydWN0IGNtZHFfcGt0ICpwa3QsIHUxNiByZWdfaWR4
LCB1MzIgdmFsdWUpOw0KPiArDQo+ICAvKioNCj4gICAqIGNtZHFfcGt0X2ZsdXNoX2FzeW5jKCkg
LSB0cmlnZ2VyIENNRFEgdG8gYXN5bmNocm9ub3VzbHkgZXhlY3V0ZSB0aGUgQ01EUQ0KPiAgICog
ICAgICAgICAgICAgICAgICAgICAgICAgIHBhY2tldCBhbmQgY2FsbCBiYWNrIGF0IHRoZSBlbmQg
b2YgZG9uZSBwYWNrZXQNCg0K

