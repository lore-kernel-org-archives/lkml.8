Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4969C34034
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 07:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDD752176D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 07:59:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="uEQFCC26"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbgBRH7q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 02:59:46 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:39631 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726114AbgBRH7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 02:59:46 -0500
X-UUID: d06597b7fdfa454b967e738dd1bc2809-20200218
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=6YFBzKFPnQHNsHeDzbWl+lIwexHJPqvaWd24YzOqLhs=;
        b=uEQFCC26nQWv+B57IB5CDkNNnyTWvh5DJ79rjtOKATRZ0yanT1o+RGeUqNhi6k3tC/m1avfuI3eR2Xug+bWdaI0c2MSDcVSxzRIJr+HjIQErRGx5a9wwHTVCPrLj0/HtGJxd2+PbsQpt2J5igg4zgilYc1GvY4tCV7uaJDDZ8EQ=;
X-UUID: d06597b7fdfa454b967e738dd1bc2809-20200218
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 373769576; Tue, 18 Feb 2020 15:59:40 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 18 Feb 2020 15:58:43 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 18 Feb 2020 15:59:20 +0800
Message-ID: <1582012779.17361.0.camel@mtksdaap41>
Subject: Re: [PATCH 2/2] drm/mediatek: move gce event property to mutex
 device node
From:   CK Hu <ck.hu@mediatek.com>
To:     Bibby Hsieh <bibby.hsieh@mediatek.com>
CC:     David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        YT Shen <yt.shen@mediatek.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>, <tfiga@chromium.org>,
        <drinkcat@chromium.org>, <linux-kernel@vger.kernel.org>,
        <srv_heupstream@mediatek.com>
Date:   Tue, 18 Feb 2020 15:59:39 +0800
In-Reply-To: <1581504244.26347.0.camel@mtksdaap41>
References: <20200212095501.12124-1-bibby.hsieh@mediatek.com>
         <20200212095501.12124-2-bibby.hsieh@mediatek.com>
         <1581504244.26347.0.camel@mtksdaap41>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEJpYmJ5Og0KDQpPbiBXZWQsIDIwMjAtMDItMTIgYXQgMTg6NDQgKzA4MDAsIENLIEh1IHdy
b3RlOg0KPiBIaSwgQmliYnk6DQo+IA0KPiBPbiBXZWQsIDIwMjAtMDItMTIgYXQgMTc6NTUgKzA4
MDAsIEJpYmJ5IEhzaWVoIHdyb3RlOg0KPiA+IEFjY29yZGluZyBtdGsgaGFyZHdhcmUgZGVzaWdu
LCBzdHJlYW1fZG9uZTAgYW5kIHN0cmVhbV9kb25lMSBhcmUNCj4gPiBnZW5lcmF0ZWQgYnkgbXV0
ZXgsIHNvIHdlIG1vdmUgZ2NlIGV2ZW50IHByb3BlcnR5IHRvIG11dGV4IGRldmljZSBtb2RlLg0K
PiA+IA0KPiANCj4gUmV2aWV3ZWQtYnk6IENLIEh1IDxjay5odUBtZWRpYXRlay5jb20+DQo+IA0K
DQpBcHBsaWVkIHRvIG1lZGlhdGVrLWRybS1maXhlcy01LjYgWzFdLCB0aGFua3MuDQoNClsxXQ0K
aHR0cHM6Ly9naXRodWIuY29tL2NraHUtbWVkaWF0ZWsvbGludXguZ2l0LXRhZ3MvY29tbWl0cy9t
ZWRpYXRlay1kcm0tZml4ZXMtNS42DQoNClJlZ2FyZHMsDQpDSw0KDQo+ID4gU2lnbmVkLW9mZi1i
eTogQmliYnkgSHNpZWggPGJpYmJ5LmhzaWVoQG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAg
ZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5jIHwgMiArLQ0KPiA+ICAxIGZp
bGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gPiANCj4gPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5jIGIvZHJpdmVy
cy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5jDQo+ID4gaW5kZXggM2M1M2VhMjIyMDhj
Li44YTMxZTViOTgzZGIgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVr
L210a19kcm1fY3J0Yy5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19k
cm1fY3J0Yy5jDQo+ID4gQEAgLTgxOSw3ICs4MTksNyBAQCBpbnQgbXRrX2RybV9jcnRjX2NyZWF0
ZShzdHJ1Y3QgZHJtX2RldmljZSAqZHJtX2RldiwNCj4gPiAgCQkJZHJtX2NydGNfaW5kZXgoJm10
a19jcnRjLT5iYXNlKSk7DQo+ID4gIAkJbXRrX2NydGMtPmNtZHFfY2xpZW50ID0gTlVMTDsNCj4g
PiAgCX0NCj4gPiAtCXJldCA9IG9mX3Byb3BlcnR5X3JlYWRfdTMyX2luZGV4KGRldi0+b2Zfbm9k
ZSwgIm1lZGlhdGVrLGdjZS1ldmVudHMiLA0KPiA+ICsJcmV0ID0gb2ZfcHJvcGVydHlfcmVhZF91
MzJfaW5kZXgocHJpdi0+bXV0ZXhfbm9kZSwgIm1lZGlhdGVrLGdjZS1ldmVudHMiLA0KPiA+ICAJ
CQkJCSBkcm1fY3J0Y19pbmRleCgmbXRrX2NydGMtPmJhc2UpLA0KPiA+ICAJCQkJCSAmbXRrX2Ny
dGMtPmNtZHFfZXZlbnQpOw0KPiA+ICAJaWYgKHJldCkNCj4gDQoNCg==

