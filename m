Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A56CC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 15:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5C51206D7
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 15:20:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="jZ2N6SOF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729571AbgFVPUj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 11:20:39 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:18646 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729049AbgFVPUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 11:20:39 -0400
X-UUID: 82af9c77f88043cbae780eb636daedec-20200622
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=07tYpv6sMJHQf+tvadCHMvn5amb3rdKyfIHukvZDlGw=;
        b=jZ2N6SOF5LuBOuDwW+kjUMCSgahI8ELSL4N7WXdkg6p1CuWw0crK+RkheLsxl4CKzDaCPxSR4hipuNvwL5lf4XUL0VNocvSedEIQdGUfZ0Ykeiuu6r898+8VKqgxQ9cDC1wdwUhsKGcBPUJJDE0T2YEHEVZMaq+EZ48WBoWdcW4=;
X-UUID: 82af9c77f88043cbae780eb636daedec-20200622
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 692640189; Mon, 22 Jun 2020 23:20:36 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 22 Jun 2020 23:20:31 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 22 Jun 2020 23:20:31 +0800
Message-ID: <1592839235.1307.1.camel@mtkswgap22>
Subject: Re: [PATCH v1 0/11] support cmdq helper function on mt6779 platform
From:   Dennis-YC Hsieh <dennis-yc.hsieh@mediatek.com>
To:     Bibby Hsieh <bibby.hsieh@mediatek.com>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, CK Hu <ck.hu@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>,
        HS Liao <hs.liao@mediatek.com>
Date:   Mon, 22 Jun 2020 23:20:35 +0800
In-Reply-To: <1592793655.11692.9.camel@mtksdaap41>
References: <1592749115-24158-1-git-send-email-dennis-yc.hsieh@mediatek.com>
         <1592793655.11692.9.camel@mtksdaap41>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQmliYnksDQoNCg0KT24gTW9uLCAyMDIwLTA2LTIyIGF0IDEwOjQwICswODAwLCBCaWJieSBI
c2llaCB3cm90ZToNCj4gSGksIERlbm5pcywNCj4gDQo+IFBsZWFzZSBhZGQgImRlcGVuZHMgb24g
cGF0Y2g6IHN1cHBvcnQgZ2NlIG9uIG10Njc3OSBwbGF0Zm9ybSIgaW4gY292ZXINCj4gbGV0dGVy
LiBUaGFua3MNCg0Kb2sgd2lsbCBkbywgdGhhbmtzDQoNCg0KUmVnYXJkcywNCkRlbm5pcw0KDQoN
Cj4gDQo+IEJpYmJ5DQo+IA0KPiBPbiBTdW4sIDIwMjAtMDYtMjEgYXQgMjI6MTggKzA4MDAsIERl
bm5pcyBZQyBIc2llaCB3cm90ZToNCj4gPiBUaGlzIHBhdGNoIHN1cHBvcnQgY21kcSBoZWxwZXIg
ZnVuY3Rpb24gb24gbXQ2Nzc5IHBsYXRmb3JtLA0KPiA+IGJhc2VkIG9uICJzdXBwb3J0IGdjZSBv
biBtdDY3NzkgcGxhdGZvcm0iIHBhdGNoc2V0Lg0KPiA+IA0KPiA+IA0KPiA+IERlbm5pcyBZQyBI
c2llaCAoMTEpOg0KPiA+ICAgc29jOiBtZWRpYXRlazogY21kcTogYWRkIGFkZHJlc3Mgc2hpZnQg
aW4ganVtcA0KPiA+ICAgc29jOiBtZWRpYXRlazogY21kcTogYWRkIGFzc2lnbiBmdW5jdGlvbg0K
PiA+ICAgc29jOiBtZWRpYXRlazogY21kcTogYWRkIHdyaXRlX3MgZnVuY3Rpb24NCj4gPiAgIHNv
YzogbWVkaWF0ZWs6IGNtZHE6IGFkZCB3cml0ZV9zX21hc2sgZnVuY3Rpb24NCj4gPiAgIHNvYzog
bWVkaWF0ZWs6IGNtZHE6IGFkZCByZWFkX3MgZnVuY3Rpb24NCj4gPiAgIHNvYzogbWVkaWF0ZWs6
IGNtZHE6IGFkZCB3cml0ZV9zIHZhbHVlIGZ1bmN0aW9uDQo+ID4gICBzb2M6IG1lZGlhdGVrOiBj
bWRxOiBhZGQgd3JpdGVfc19tYXNrIHZhbHVlIGZ1bmN0aW9uDQo+ID4gICBzb2M6IG1lZGlhdGVr
OiBjbWRxOiBleHBvcnQgZmluYWxpemUgZnVuY3Rpb24NCj4gPiAgIHNvYzogbWVkaWF0ZWs6IGNt
ZHE6IGFkZCBqdW1wIGZ1bmN0aW9uDQo+ID4gICBzb2M6IG1lZGlhdGVrOiBjbWRxOiBhZGQgY2xl
YXIgb3B0aW9uIGluIGNtZHFfcGt0X3dmZSBhcGkNCj4gPiAgIHNvYzogbWVkaWF0ZWs6IGNtZHE6
IGFkZCBzZXQgZXZlbnQgZnVuY3Rpb24NCj4gPiANCj4gPiAgZHJpdmVycy9ncHUvZHJtL21lZGlh
dGVrL210a19kcm1fY3J0Yy5jICB8ICAgMyArLQ0KPiA+ICBkcml2ZXJzL3NvYy9tZWRpYXRlay9t
dGstY21kcS1oZWxwZXIuYyAgIHwgMTU5ICsrKysrKysrKysrKysrKysrKysrKy0tDQo+ID4gIGlu
Y2x1ZGUvbGludXgvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmggfCAgIDggKy0NCj4gPiAgaW5j
bHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaCAgICB8IDEyNCArKysrKysrKysrKysr
KysrKy0NCj4gPiAgNCBmaWxlcyBjaGFuZ2VkLCAyODAgaW5zZXJ0aW9ucygrKSwgMTQgZGVsZXRp
b25zKC0pDQo+ID4gDQo+IA0KPiANCg0K

