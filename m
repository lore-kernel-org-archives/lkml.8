Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E13F2C4BA0A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 01:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B799A2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 01:41:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="mp6i0DNQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729856AbgBZBls (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 20:41:48 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:51972 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729376AbgBZBls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 20:41:48 -0500
X-UUID: ae65ebf396f141199c2cf8edc11b36d7-20200226
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=Xu9DYGIIRAkO+LnNVacxwQSBi+uqDoimnhH6PXA+e30=;
        b=mp6i0DNQhJAdJoUdz1yS5fEkH6Ghw67Q8XxiiO/+aOoSNcAPh1Y5o1P7jb1nzT6nfhzVG9a94EdkW3HSvPl41Y/5IlzNa8vfv3PgwYFYb6MaZi+1Rr1BhrRiV6Vtg3K713I/9ATpnXOztzvjFFpuaT1w0Z+4r6qbJTNkGxW3550=;
X-UUID: ae65ebf396f141199c2cf8edc11b36d7-20200226
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1358879789; Wed, 26 Feb 2020 09:41:42 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 26 Feb 2020 09:40:52 +0800
Received: from [172.21.77.4] (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 26 Feb 2020 09:39:24 +0800
Message-ID: <1582681300.16944.3.camel@mtksdaap41>
Subject: Re: [PATCH v8 6/7] drm/mediatek: add mt8183 dpi clock factor
From:   CK Hu <ck.hu@mediatek.com>
To:     Jitao Shi <jitao.shi@mediatek.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <yingjoe.chen@mediatek.com>,
        <eddie.huang@mediatek.com>, <cawa.cheng@mediatek.com>,
        <bibby.hsieh@mediatek.com>, <stonea168@163.com>,
        <huijuan.xie@mediatek.com>
Date:   Wed, 26 Feb 2020 09:41:40 +0800
In-Reply-To: <20200225094057.120144-7-jitao.shi@mediatek.com>
References: <20200225094057.120144-1-jitao.shi@mediatek.com>
         <20200225094057.120144-7-jitao.shi@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEppdGFvOg0KDQpPbiBUdWUsIDIwMjAtMDItMjUgYXQgMTc6NDAgKzA4MDAsIEppdGFvIFNo
aSB3cm90ZToNCj4gVGhlIGZhY3RvciBkZXBlbmRzIG9uIHRoZSBkaXZpZGVyIG9mIERQSSBpbiBN
VDgxODMsIHRoZXJlZm9yZSwNCj4gd2Ugc2hvdWxkIGZpeCB0aGlzIGZhY3RvciB0byB0aGUgcmln
aHQgYW5kIG5ldyBvbmUuDQo+IA0KDQpBcHBsaWVkIHRvIG1lZGlhdGVrLWRybS1uZXh0LTUuNyBb
MV0sIHRoYW5rcy4NCg0KWzFdDQpodHRwczovL2dpdGh1Yi5jb20vY2todS1tZWRpYXRlay9saW51
eC5naXQtdGFncy9jb21taXRzL21lZGlhdGVrLWRybS1uZXh0LTUuNw0KDQo+IFNpZ25lZC1vZmYt
Ynk6IEppdGFvIFNoaSA8aml0YW8uc2hpQG1lZGlhdGVrLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IENL
IEh1IDxjay5odUBtZWRpYXRlay5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlh
dGVrL210a19kcGkuYyB8IDE4ICsrKysrKysrKysrKysrKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQs
IDE4IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVk
aWF0ZWsvbXRrX2RwaS5jIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcGkuYw0KPiBp
bmRleCBkZjU5OGY4N2E0MGYuLmRiMzI3MmY3YTRjNCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9n
cHUvZHJtL21lZGlhdGVrL210a19kcGkuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0
ZWsvbXRrX2RwaS5jDQo+IEBAIC02NzYsNiArNjc2LDE2IEBAIHN0YXRpYyB1bnNpZ25lZCBpbnQg
bXQyNzAxX2NhbGN1bGF0ZV9mYWN0b3IoaW50IGNsb2NrKQ0KPiAgCQlyZXR1cm4gMTsNCj4gIH0N
Cj4gIA0KPiArc3RhdGljIHVuc2lnbmVkIGludCBtdDgxODNfY2FsY3VsYXRlX2ZhY3RvcihpbnQg
Y2xvY2spDQo+ICt7DQo+ICsJaWYgKGNsb2NrIDw9IDI3MDAwKQ0KPiArCQlyZXR1cm4gODsNCj4g
KwllbHNlIGlmIChjbG9jayA8PSAxNjcwMDApDQo+ICsJCXJldHVybiA0Ow0KPiArCWVsc2UNCj4g
KwkJcmV0dXJuIDI7DQo+ICt9DQo+ICsNCj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2RwaV9j
b25mIG10ODE3M19jb25mID0gew0KPiAgCS5jYWxfZmFjdG9yID0gbXQ4MTczX2NhbGN1bGF0ZV9m
YWN0b3IsDQo+ICAJLnJlZ19oX2ZyZV9jb24gPSAweGUwLA0KPiBAQCAtNjg3LDYgKzY5NywxMSBA
QCBzdGF0aWMgY29uc3Qgc3RydWN0IG10a19kcGlfY29uZiBtdDI3MDFfY29uZiA9IHsNCj4gIAku
ZWRnZV9zZWxfZW4gPSB0cnVlLA0KPiAgfTsNCj4gIA0KPiArc3RhdGljIGNvbnN0IHN0cnVjdCBt
dGtfZHBpX2NvbmYgbXQ4MTgzX2NvbmYgPSB7DQo+ICsJLmNhbF9mYWN0b3IgPSBtdDgxODNfY2Fs
Y3VsYXRlX2ZhY3RvciwNCj4gKwkucmVnX2hfZnJlX2NvbiA9IDB4ZTAsDQo+ICt9Ow0KPiArDQo+
ICBzdGF0aWMgaW50IG10a19kcGlfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikN
Cj4gIHsNCj4gIAlzdHJ1Y3QgZGV2aWNlICpkZXYgPSAmcGRldi0+ZGV2Ow0KPiBAQCAtNzg0LDYg
Kzc5OSw5IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIG10a19kcGlfb2ZfaWRz
W10gPSB7DQo+ICAJeyAuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxNzMtZHBpIiwNCj4gIAkg
IC5kYXRhID0gJm10ODE3M19jb25mLA0KPiAgCX0sDQo+ICsJeyAuY29tcGF0aWJsZSA9ICJtZWRp
YXRlayxtdDgxODMtZHBpIiwNCj4gKwkgIC5kYXRhID0gJm10ODE4M19jb25mLA0KPiArCX0sDQo+
ICAJeyB9LA0KPiAgfTsNCj4gIA0KDQo=

