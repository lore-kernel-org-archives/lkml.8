Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FF67C34033
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 07:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 066CF206E2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 07:46:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="HD7TFrvS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgBRHqq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 02:46:46 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:41981 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726127AbgBRHqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 02:46:45 -0500
X-UUID: 729695ee8e884b638f224bd5a485de69-20200218
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=g5TmMK5xtaVwCyccKk6B3PT0J4POGsB8eAQQZd7hA8o=;
        b=HD7TFrvS6QC6Drlf77grZ51MNyFDbKjPzyk/JZWI7CRHiSbSg7oCO6b/oSx4fJoCbx0bk/AlUNiQyynHV+uoluE2iLBPc3LQp6P/N53YrOxpoGQ1dAAIy1Gb4munRdwCCMWiubHm07o1ARpMbctJt76bjdpObTDYTjfxy8IP++I=;
X-UUID: 729695ee8e884b638f224bd5a485de69-20200218
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 108004550; Tue, 18 Feb 2020 15:46:38 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 18 Feb 2020 15:45:47 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 18 Feb 2020 15:46:14 +0800
Message-ID: <1582011997.15399.1.camel@mtksdaap41>
Subject: Re: [PATCH 2/2] drm/mediatek: add fb swap in async_update
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
Date:   Tue, 18 Feb 2020 15:46:37 +0800
In-Reply-To: <1581566763.12071.1.camel@mtksdaap41>
References: <20200213012353.26815-1-bibby.hsieh@mediatek.com>
         <20200213012353.26815-2-bibby.hsieh@mediatek.com>
         <1581566763.12071.1.camel@mtksdaap41>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEJpYmJ5Og0KDQpPbiBUaHUsIDIwMjAtMDItMTMgYXQgMTI6MDYgKzA4MDAsIENLIEh1IHdy
b3RlOg0KPiBIaSwgQmliYnk6DQo+IA0KPiBPbiBUaHUsIDIwMjAtMDItMTMgYXQgMDk6MjMgKzA4
MDAsIEJpYmJ5IEhzaWVoIHdyb3RlOg0KPiA+IEJlc2lkZXMgeCwgeSBwb3NpdGlvbiwgd2lkdGgg
YW5kIGhlaWdodCwNCj4gPiBmYiBhbHNvIG5lZWQgdXBkYXRpbmcgaW4gYXN5bmMgdXBkYXRlLg0K
PiA+IA0KPiANCj4gUmV2aWV3ZWQtYnk6IENLIEh1IDxjay5odUBtZWRpYXRlay5jb20+DQo+IA0K
DQpBcHBsaWVkIHRvIG1lZGlhdGVrLWRybS1maXhlcy01LjYgWzFdLCB0aGFua3MuDQoNClsxXQ0K
aHR0cHM6Ly9naXRodWIuY29tL2NraHUtbWVkaWF0ZWsvbGludXguZ2l0LXRhZ3MvY29tbWl0cy9t
ZWRpYXRlay1kcm0tZml4ZXMtNS42DQoNClJlZ2FyZHMsDQpDSw0KDQo+ID4gRml4ZXM6IDkyMGZm
ZmNjODkxMiAoImRybS9tZWRpYXRlazogdXBkYXRlIGN1cnNvcnMgYnkgdXNpbmcgYXN5bmMgYXRv
bWljIHVwZGF0ZSIpDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogQmliYnkgSHNpZWggPGJpYmJ5
LmhzaWVoQG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9ncHUvZHJtL21lZGlh
dGVrL210a19kcm1fcGxhbmUuYyB8IDEgKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRp
b24oKykNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210
a19kcm1fcGxhbmUuYyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX3BsYW5lLmMN
Cj4gPiBpbmRleCBkMzJiNDk0ZmYxZGUuLmUwODRjMzZmZGQ4YSAxMDA2NDQNCj4gPiAtLS0gYS9k
cml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9wbGFuZS5jDQo+ID4gKysrIGIvZHJpdmVy
cy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fcGxhbmUuYw0KPiA+IEBAIC0xMjIsNiArMTIyLDcg
QEAgc3RhdGljIHZvaWQgbXRrX3BsYW5lX2F0b21pY19hc3luY191cGRhdGUoc3RydWN0IGRybV9w
bGFuZSAqcGxhbmUsDQo+ID4gIAlwbGFuZS0+c3RhdGUtPnNyY195ID0gbmV3X3N0YXRlLT5zcmNf
eTsNCj4gPiAgCXBsYW5lLT5zdGF0ZS0+c3JjX2ggPSBuZXdfc3RhdGUtPnNyY19oOw0KPiA+ICAJ
cGxhbmUtPnN0YXRlLT5zcmNfdyA9IG5ld19zdGF0ZS0+c3JjX3c7DQo+ID4gKwlzd2FwKHBsYW5l
LT5zdGF0ZS0+ZmIsIG5ld19zdGF0ZS0+ZmIpOw0KPiA+ICAJc3RhdGUtPnBlbmRpbmcuYXN5bmNf
ZGlydHkgPSB0cnVlOw0KPiA+ICANCj4gPiAgCW10a19kcm1fY3J0Y19hc3luY191cGRhdGUobmV3
X3N0YXRlLT5jcnRjLCBwbGFuZSwgbmV3X3N0YXRlKTsNCj4gDQoNCg==

