Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1742C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 13:31:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81F46208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 13:31:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="D8Qo80RO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730315AbgHZNbz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 09:31:55 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:33593 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730288AbgHZNbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 09:31:38 -0400
X-UUID: 6760890371604d4e9983398bc164f82d-20200826
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=03acJo/Im0QezgGzNXuxpYDJ+zjBjETD20zLt87IkE4=;
        b=D8Qo80RO3as1IxFATP06pxn1c2gA24MFACFEz8djSUrxIORXzYQiHDgWEy7eOvkci1+S9Ff3dWodQIjCDwZlRlKdqvlO0MCopG8xvteHKnUkdxukcMoFc3OqUih+9QpGBTMQDKC+RTz5MQfdC8l5WUbTeDNZZJBJcZgrKjV8h7A=;
X-UUID: 6760890371604d4e9983398bc164f82d-20200826
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <andrew-ct.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 702879083; Wed, 26 Aug 2020 21:31:11 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 26 Aug 2020 21:31:07 +0800
Received: from [172.21.77.4] (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 26 Aug 2020 21:31:07 +0800
Message-ID: <1598448669.18394.8.camel@mtksdaap41>
Subject: Re: [PATCH v3] nvmem: mtk-efuse: Remove EFUSE register write support
From:   andrew-ct chen <andrew-ct.chen@mediatek.com>
To:     Chih-En Hsu <chih-en.hsu@mediatek.com>
CC:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        <Michael.Mei@mediatek.com>
Date:   Wed, 26 Aug 2020 21:31:09 +0800
In-Reply-To: <20200826083943.810-1-chih-en.hsu@mediatek.com>
References: <20200826083943.810-1-chih-en.hsu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ2hpaC1FbiwNCg0KDQpPbiBXZWQsIDIwMjAtMDgtMjYgYXQgMTY6MzkgKzA4MDAsIENoaWgt
RW4gSHN1IHdyb3RlOg0KPiBUaGlzIHBhdGNoIGlzIHRvIHJlbW92ZSBmdW5jdGlvbiAibXRrX3Jl
Z193cml0ZSIgc2luY2UNCj4gTWVkaWF0ZWsgRUZVU0UgaGFyZHdhcmUgb25seSBzdXBwb3J0cyBy
ZWFkIGZ1bmN0aW9uYWxpdHkNCj4gZm9yIE5WTUVNIGNvbnN1bWVycy4NCg0KQWNrZWQtYnk6IEFu
ZHJldy1DVCBDaGVuIDxhbmRyZXctY3QuY2hlbkBtZWRpYXRlay5jb20+DQoNCj4gDQo+IEZpeGVz
OiBiYTM2MGZkMDQwZTMgKCJudm1lbTogbXRrLWVmdXNlOiByZW1vdmUgbnZtZW0gcmVnbWFwIGRl
cGVuZGVuY3kiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBDaGloLUVuIEhzdSA8Y2hpaC1lbi5oc3VAbWVk
aWF0ZWsuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvbnZtZW0vbXRrLWVmdXNlLmMgfCAxNCAtLS0t
LS0tLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDE0IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvbnZtZW0vbXRrLWVmdXNlLmMgYi9kcml2ZXJzL252bWVtL210ay1l
ZnVzZS5jDQo+IGluZGV4IDg1NmQ5YzNmYzM4ZS4uNmE1MzdkOTU5ZjE0IDEwMDY0NA0KPiAtLS0g
YS9kcml2ZXJzL252bWVtL210ay1lZnVzZS5jDQo+ICsrKyBiL2RyaXZlcnMvbnZtZW0vbXRrLWVm
dXNlLmMNCj4gQEAgLTI4LDE5ICsyOCw2IEBAIHN0YXRpYyBpbnQgbXRrX3JlZ19yZWFkKHZvaWQg
KmNvbnRleHQsDQo+ICAJcmV0dXJuIDA7DQo+ICB9DQo+ICANCj4gLXN0YXRpYyBpbnQgbXRrX3Jl
Z193cml0ZSh2b2lkICpjb250ZXh0LA0KPiAtCQkJIHVuc2lnbmVkIGludCByZWcsIHZvaWQgKl92
YWwsIHNpemVfdCBieXRlcykNCj4gLXsNCj4gLQlzdHJ1Y3QgbXRrX2VmdXNlX3ByaXYgKnByaXYg
PSBjb250ZXh0Ow0KPiAtCXUzMiAqdmFsID0gX3ZhbDsNCj4gLQlpbnQgaSA9IDAsIHdvcmRzID0g
Ynl0ZXMgLyA0Ow0KPiAtDQo+IC0Jd2hpbGUgKHdvcmRzLS0pDQo+IC0JCXdyaXRlbCgqdmFsKyss
IHByaXYtPmJhc2UgKyByZWcgKyAoaSsrICogNCkpOw0KPiAtDQo+IC0JcmV0dXJuIDA7DQo+IC19
DQo+IC0NCj4gIHN0YXRpYyBpbnQgbXRrX2VmdXNlX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZp
Y2UgKnBkZXYpDQo+ICB7DQo+ICAJc3RydWN0IGRldmljZSAqZGV2ID0gJnBkZXYtPmRldjsNCj4g
QEAgLTYxLDcgKzQ4LDYgQEAgc3RhdGljIGludCBtdGtfZWZ1c2VfcHJvYmUoc3RydWN0IHBsYXRm
b3JtX2RldmljZSAqcGRldikNCj4gIAllY29uZmlnLnN0cmlkZSA9IDQ7DQo+ICAJZWNvbmZpZy53
b3JkX3NpemUgPSA0Ow0KPiAgCWVjb25maWcucmVnX3JlYWQgPSBtdGtfcmVnX3JlYWQ7DQo+IC0J
ZWNvbmZpZy5yZWdfd3JpdGUgPSBtdGtfcmVnX3dyaXRlOw0KPiAgCWVjb25maWcuc2l6ZSA9IHJl
c291cmNlX3NpemUocmVzKTsNCj4gIAllY29uZmlnLnByaXYgPSBwcml2Ow0KPiAgCWVjb25maWcu
ZGV2ID0gZGV2Ow0KDQo=

