Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ABA2C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 06:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED3C4206FA
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 06:12:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Ar/nkxi6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbgHZGMU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 02:12:20 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:27134 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725786AbgHZGMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 02:12:20 -0400
X-UUID: 2401c97b37ef48f783df91d289af493a-20200826
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=ylPSVH9BPictdHb8dQm8y8sP20WP8ufKl9IkALHg1BE=;
        b=Ar/nkxi6+jNfNOSZ8XAQIhcPFao4E9qf1iF1APWfnnp0Ug0YwG+KoqYI2L3S7YWVmY8F09+Abhjqq+VEAPRY6SRPwnzWEBzelnGgH1xfwL5sW/udC2fZGjDrRsY3dpgslmMyiKZDxiznZfPeSPIzGgyckKq8Q/TfIeaK44No8uY=;
X-UUID: 2401c97b37ef48f783df91d289af493a-20200826
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <chih-en.hsu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1216554603; Wed, 26 Aug 2020 14:12:15 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 26 Aug 2020 14:12:13 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 26 Aug 2020 14:12:12 +0800
Message-ID: <1598422333.15853.9.camel@mtksdccf07>
Subject: Re: [PATCH] nvmem: mtk-efuse: Remove EFUSE register write support
From:   Chih-En Hsu <chih-en.hsu@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>
CC:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <Andrew-CT.Chen@mediatek.com>, <srv_heupstream@mediatek.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <Michael.Mei@mediatek.com>
Date:   Wed, 26 Aug 2020 14:12:13 +0800
In-Reply-To: <1598418963.20150.2.camel@mtksdaap41>
References: <20200826050145.24655-1-chih-en.hsu@mediatek.com>
         <1598418963.20150.2.camel@mtksdaap41>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 9F567A1762FAF26BD80846770A7646E7628B363C3C179FDC61A5C52ED89CB1042000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ0s6DQoNCkkgc2VlLg0KDQpJIHdpbGwgYWRkIHRoZSBmb2xsb3dpbmcgZml4IHRhZyBpbnRv
IHRoZSBuZXh0IHBhdGNoIHZlcnNpb24uDQoNCkZpeGVzOiA0YzdlNGZlMzc3NjYgKCJudm1lbTog
bWVkaWF0ZWs6IEFkZCBNZWRpYXRlayBFRlVTRSBkcml2ZXIiKQ0KDQpUaGFua3MgYSBsb3QuDQoN
CkFsZXgNCg0KDQpPbiBXZWQsIDIwMjAtMDgtMjYgYXQgMTM6MTYgKzA4MDAsIENLIEh1IHdyb3Rl
Og0KPiBIaSwgQ2hpaC1FbjoNCj4gDQo+IE9uIFdlZCwgMjAyMC0wOC0yNiBhdCAxMzowMSArMDgw
MCwgQ2hpaC1FbiBIc3Ugd3JvdGU6DQo+ID4gVGhpcyBwYXRjaCBpcyB0byByZW1vdmUgZnVuY3Rp
b24gIm10a19yZWdfd3JpdGUiIHNpbmNlDQo+ID4gTWVkaWF0ZWsgRUZVU0UgaGFyZHdhcmUgb25s
eSBzdXBwb3J0cyByZWFkIGZ1bmN0aW9uYWxpdHkNCj4gPiBmb3IgTlZNRU0gY29uc3VtZXJzLg0K
PiA+IA0KPiANCj4gVGhpcyBpcyBhIGJ1Zy1maXggcGF0Y2gsIHNvIG5lZWQgYSAnRml4ZXMnIHRh
Zy4gWW91IGNvdWxkIHJlZmVyIHRvIFsxXS4NCj4gDQo+IFsxXQ0KPiBodHRwczovL3d3dy5rZXJu
ZWwub3JnL2RvYy9odG1sL2xhdGVzdC9wcm9jZXNzL3N1Ym1pdHRpbmctcGF0Y2hlcy5odG1sI2Rl
c2NyaWJlLWNoYW5nZXMNCj4gDQo+IFJlZ2FyZHMsDQo+IENLLg0KPiANCj4gPiBTaWduZWQtb2Zm
LWJ5OiBDaGloLUVuIEhzdSA8Y2hpaC1lbi5oc3VAbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+
ICBkcml2ZXJzL252bWVtL210ay1lZnVzZS5jIHwgMTQgLS0tLS0tLS0tLS0tLS0NCj4gPiAgMSBm
aWxlIGNoYW5nZWQsIDE0IGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL252bWVtL210ay1lZnVzZS5jIGIvZHJpdmVycy9udm1lbS9tdGstZWZ1c2UuYw0KPiA+IGlu
ZGV4IDg1NmQ5YzNmYzM4ZS4uNmE1MzdkOTU5ZjE0IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMv
bnZtZW0vbXRrLWVmdXNlLmMNCj4gPiArKysgYi9kcml2ZXJzL252bWVtL210ay1lZnVzZS5jDQo+
ID4gQEAgLTI4LDE5ICsyOCw2IEBAIHN0YXRpYyBpbnQgbXRrX3JlZ19yZWFkKHZvaWQgKmNvbnRl
eHQsDQo+ID4gIAlyZXR1cm4gMDsNCj4gPiAgfQ0KPiA+ICANCj4gPiAtc3RhdGljIGludCBtdGtf
cmVnX3dyaXRlKHZvaWQgKmNvbnRleHQsDQo+ID4gLQkJCSB1bnNpZ25lZCBpbnQgcmVnLCB2b2lk
ICpfdmFsLCBzaXplX3QgYnl0ZXMpDQo+ID4gLXsNCj4gPiAtCXN0cnVjdCBtdGtfZWZ1c2VfcHJp
diAqcHJpdiA9IGNvbnRleHQ7DQo+ID4gLQl1MzIgKnZhbCA9IF92YWw7DQo+ID4gLQlpbnQgaSA9
IDAsIHdvcmRzID0gYnl0ZXMgLyA0Ow0KPiA+IC0NCj4gPiAtCXdoaWxlICh3b3Jkcy0tKQ0KPiA+
IC0JCXdyaXRlbCgqdmFsKyssIHByaXYtPmJhc2UgKyByZWcgKyAoaSsrICogNCkpOw0KPiA+IC0N
Cj4gPiAtCXJldHVybiAwOw0KPiA+IC19DQo+ID4gLQ0KPiA+ICBzdGF0aWMgaW50IG10a19lZnVz
ZV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+ICB7DQo+ID4gIAlzdHJ1
Y3QgZGV2aWNlICpkZXYgPSAmcGRldi0+ZGV2Ow0KPiA+IEBAIC02MSw3ICs0OCw2IEBAIHN0YXRp
YyBpbnQgbXRrX2VmdXNlX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ID4g
IAllY29uZmlnLnN0cmlkZSA9IDQ7DQo+ID4gIAllY29uZmlnLndvcmRfc2l6ZSA9IDQ7DQo+ID4g
IAllY29uZmlnLnJlZ19yZWFkID0gbXRrX3JlZ19yZWFkOw0KPiA+IC0JZWNvbmZpZy5yZWdfd3Jp
dGUgPSBtdGtfcmVnX3dyaXRlOw0KPiA+ICAJZWNvbmZpZy5zaXplID0gcmVzb3VyY2Vfc2l6ZShy
ZXMpOw0KPiA+ICAJZWNvbmZpZy5wcml2ID0gcHJpdjsNCj4gPiAgCWVjb25maWcuZGV2ID0gZGV2
Ow0KPiANCj4gDQoNCg==

