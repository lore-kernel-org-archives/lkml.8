Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F6F9C3F2D8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 02:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC2E420842
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 02:33:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Hb/slNju"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387563AbgCDCdA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 21:33:00 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:60578 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387411AbgCDCc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 21:32:59 -0500
X-UUID: 9a1ed69c69c748128d7770e5bb1f5166-20200304
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=mYLX3IiH72ajlTAiOtL8JHWaOes5nllQiW2Y7ugTO8A=;
        b=Hb/slNjuHGxwAPkxv1ZQDDjR1MwVJpZTP2ajDZcBGUPN1lViR8MIM7PnyEduWkYR5eQ/qy0N00+1BIBwz6ppXq857XVJbc7PJ6JgdAZvJVVK5gRcOvW1sEHEdgzwBElQaw7CyJI5YsXtZn+h5HRwaQh9cy8YWpiJ4S7feK5WiyI=;
X-UUID: 9a1ed69c69c748128d7770e5bb1f5166-20200304
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1111508034; Wed, 04 Mar 2020 10:32:52 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 4 Mar 2020 10:31:55 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 4 Mar 2020 10:32:11 +0800
Message-ID: <1583289170.32049.1.camel@mtksdaap41>
Subject: Re: [PATCH v4 02/13] mailbox: cmdq: variablize address shift in
 platform
From:   CK Hu <ck.hu@mediatek.com>
To:     Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "David Airlie" <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>, <dri-devel@lists.freedesktop.org>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        HS Liao <hs.liao@mediatek.com>
Date:   Wed, 4 Mar 2020 10:32:50 +0800
In-Reply-To: <1583233125-7827-3-git-send-email-dennis-yc.hsieh@mediatek.com>
References: <1583233125-7827-1-git-send-email-dennis-yc.hsieh@mediatek.com>
         <1583233125-7827-3-git-send-email-dennis-yc.hsieh@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIERlbm5pczoNCg0KT24gVHVlLCAyMDIwLTAzLTAzIGF0IDE4OjU4ICswODAwLCBEZW5uaXMg
WUMgSHNpZWggd3JvdGU6DQo+IFNvbWUgZ2NlIGhhcmR3YXJlIHNoaWZ0IHBjIGFuZCBlbmQgYWRk
cmVzcyBpbiByZWdpc3RlciB0byBzdXBwb3J0DQo+IGxhcmdlIGRyYW0gYWRkcmVzc2luZy4NCj4g
SW1wbGVtZW50IGdjZSBhZGRyZXNzIHNoaWZ0IHdoZW4gd3JpdGUgb3IgcmVhZCBwYyBhbmQgZW5k
IHJlZ2lzdGVyLg0KPiBBbmQgYWRkIHNoaWZ0IGJpdCBpbiBwbGF0Zm9ybSBkZWZpbml0aW9uLg0K
PiANCj4gU2lnbmVkLW9mZi1ieTogRGVubmlzIFlDIEhzaWVoIDxkZW5uaXMteWMuaHNpZWhAbWVk
aWF0ZWsuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmMg
ICAgICAgfCA2MSArKysrKysrKysrKysrKysrKystLS0tLS0NCj4gIGRyaXZlcnMvc29jL21lZGlh
dGVrL210ay1jbWRxLWhlbHBlci5jICAgfCAgMyArLQ0KPiAgaW5jbHVkZS9saW51eC9tYWlsYm94
L210ay1jbWRxLW1haWxib3guaCB8ICAyICsNCj4gIDMgZmlsZXMgY2hhbmdlZCwgNTAgaW5zZXJ0
aW9ucygrKSwgMTYgZGVsZXRpb25zKC0pDQo+IA0KDQpbc25pcF0NCg0KPiAgDQo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYyBiL2RyaXZlcnMvc29j
L21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jDQo+IGluZGV4IGRlMjBlNmNiYTgzYi4uMmUxYmM1
MTM1NjliIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxw
ZXIuYw0KPiArKysgYi9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYw0KPiBA
QCAtMjkxLDcgKzI5MSw4IEBAIHN0YXRpYyBpbnQgY21kcV9wa3RfZmluYWxpemUoc3RydWN0IGNt
ZHFfcGt0ICpwa3QpDQo+ICANCj4gIAkvKiBKVU1QIHRvIGVuZCAqLw0KPiAgCWluc3Qub3AgPSBD
TURRX0NPREVfSlVNUDsNCj4gLQlpbnN0LnZhbHVlID0gQ01EUV9KVU1QX1BBU1M7DQo+ICsJaW5z
dC52YWx1ZSA9IENNRFFfSlVNUF9QQVNTID4+DQo+ICsJCWNtZHFfbWJveF9zaGlmdCgoKHN0cnVj
dCBjbWRxX2NsaWVudCAqKXBrdC0+Y2wpLT5jaGFuKTsNCg0KV2h5IG5vdCBqdXN0IGNtZHFfbWJv
eF9zaGlmdChwa3QtPmNsLT5jaGFuKSA/DQoNClJlZ2FyZHMsDQpDSw0KDQo+ICAJZXJyID0gY21k
cV9wa3RfYXBwZW5kX2NvbW1hbmQocGt0LCBpbnN0KTsNCj4gIA0KPiAgCXJldHVybiBlcnI7DQo+
IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5oIGIv
aW5jbHVkZS9saW51eC9tYWlsYm94L210ay1jbWRxLW1haWxib3guaA0KPiBpbmRleCBhNGRjNDVm
YmVjMGEuLmRmZTViMmViODVjYyAxMDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9saW51eC9tYWlsYm94
L210ay1jbWRxLW1haWxib3guaA0KPiArKysgYi9pbmNsdWRlL2xpbnV4L21haWxib3gvbXRrLWNt
ZHEtbWFpbGJveC5oDQo+IEBAIC04OCw0ICs4OCw2IEBAIHN0cnVjdCBjbWRxX3BrdCB7DQo+ICAJ
dm9pZAkJCSpjbDsNCj4gIH07DQo+ICANCj4gK3U4IGNtZHFfbWJveF9zaGlmdChzdHJ1Y3QgbWJv
eF9jaGFuICpjaGFuKTsNCj4gKw0KPiAgI2VuZGlmIC8qIF9fTVRLX0NNRFFfTUFJTEJPWF9IX18g
Ki8NCg0K

