Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA28EC35DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 05:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E5D02467C
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 05:07:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="k6MaK41Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbgBYFHs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 00:07:48 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:27889 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725788AbgBYFHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 00:07:47 -0500
X-UUID: e29ec071ec53492589a630c73f070c9f-20200225
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=/rtGSIQMd4B3KB57xrUi7K3ubIpRTDkINY3agOAnA5g=;
        b=k6MaK41Z4INDrhlLEsvigYWeqTh9KMbVAE4ZQ0AUwAR/E6/XeZeuqynBxE/WxD1qeeiY7W6m6HsF1GYPTzQpTTLUSHUPGcjZs4u8fenJ3IydNtJ6BfnlT7x9HSypnkdAbgcTOR+2PeEMeKS5eV4IsmKz/Dev9txQai0K7pSeBEA=;
X-UUID: e29ec071ec53492589a630c73f070c9f-20200225
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 356552752; Tue, 25 Feb 2020 13:07:42 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkexhb02.mediatek.inc (172.21.101.103) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 25 Feb 2020 13:07:08 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 25 Feb 2020 13:07:28 +0800
Message-ID: <1582607261.2773.0.camel@mtksdaap41>
Subject: Re: [PATCH] drm/mediatek: component type MTK_DISP_OVL_2L is not
 correctly handled
From:   CK Hu <ck.hu@mediatek.com>
To:     Phong LE <ple@baylibre.com>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Date:   Tue, 25 Feb 2020 13:07:41 +0800
In-Reply-To: <1582162568.24713.0.camel@mtksdaap41>
References: <20200219141324.29299-1-ple@baylibre.com>
         <1582162568.24713.0.camel@mtksdaap41>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFBob25nOg0KDQpPbiBUaHUsIDIwMjAtMDItMjAgYXQgMDk6MzYgKzA4MDAsIENLIEh1IHdy
b3RlOg0KPiBIaSwgUGhvbmc6DQo+IA0KPiBPbiBXZWQsIDIwMjAtMDItMTkgYXQgMTU6MTMgKzAx
MDAsIFBob25nIExFIHdyb3RlOg0KPiA+IFRoZSBsYXJiIGRldmljZSByZW1haW5zIE5VTEwgaWYg
dGhlIHR5cGUgaXMgTVRLX0RJU1BfT1ZMXzJMLg0KPiA+IEEga2VybmVsIHBhbmljIGlzIHJhaXNl
ZCB3aGVuIGEgY3J0YyB1c2VzIG10a19zbWlfbGFyYl9nZXQgb3INCj4gPiBtdGtfc21pX2xhcmJf
cHV0Lg0KPiA+IA0KPiANCj4gUmV2aWV3ZWQtYnk6IENLIEh1IDxjay5odUBtZWRpYXRlay5jb20+
DQo+IA0KDQpBcHBsaWVkIHRvIG1lZGlhdGVrLWRybS1maXhlcy01LjYgWzFdLCB0aGFua3MuDQoN
ClsxXQ0KaHR0cHM6Ly9naXRodWIuY29tL2NraHUtbWVkaWF0ZWsvbGludXguZ2l0LXRhZ3MvY29t
bWl0cy9tZWRpYXRlay1kcm0tZml4ZXMtNS42DQoNClJlZ2FyZHMsDQpDSw0KDQo+ID4gU2lnbmVk
LW9mZi1ieTogUGhvbmcgTEUgPHBsZUBiYXlsaWJyZS5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZl
cnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2RkcF9jb21wLmMgfCAxICsNCj4gPiAgMSBmaWxl
IGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2RkcF9jb21wLmMgYi9kcml2ZXJzL2dwdS9kcm0vbWVk
aWF0ZWsvbXRrX2RybV9kZHBfY29tcC5jDQo+ID4gaW5kZXggMWY1YTExMmJiMDM0Li41N2M4OGRl
OWEzMjkgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1f
ZGRwX2NvbXAuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2Rk
cF9jb21wLmMNCj4gPiBAQCAtNDcxLDYgKzQ3MSw3IEBAIGludCBtdGtfZGRwX2NvbXBfaW5pdChz
dHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBkZXZpY2Vfbm9kZSAqbm9kZSwNCj4gPiAgCS8qIE9u
bHkgRE1BIGNhcGFibGUgY29tcG9uZW50cyBuZWVkIHRoZSBMQVJCIHByb3BlcnR5ICovDQo+ID4g
IAljb21wLT5sYXJiX2RldiA9IE5VTEw7DQo+ID4gIAlpZiAodHlwZSAhPSBNVEtfRElTUF9PVkwg
JiYNCj4gPiArCSAgICB0eXBlICE9IE1US19ESVNQX09WTF8yTCAmJg0KPiA+ICAJICAgIHR5cGUg
IT0gTVRLX0RJU1BfUkRNQSAmJg0KPiA+ICAJICAgIHR5cGUgIT0gTVRLX0RJU1BfV0RNQSkNCj4g
PiAgCQlyZXR1cm4gMDsNCj4gDQoNCg==

