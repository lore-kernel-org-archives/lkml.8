Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F26C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 02:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 342D12074B
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 02:41:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="tNcs7CFN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731095AbgFVCk7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jun 2020 22:40:59 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:37184 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726659AbgFVCk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 22:40:58 -0400
X-UUID: b1e749a258184360b17d3bc83fcace74-20200622
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=T4N0GSeOss5sx6v+I2srZbNSei5hWxozktRdtKpgDsU=;
        b=tNcs7CFNtCl0e0JfkEeyo2nrT2dnMJmHavJ1teDsfECouJAzXeAfMHsKiWnZrs7AZeUOgyzUTEDOBSxnlhIIhGwWHqHQoSMdJbOU9LbGoPtLx9vDMUF9y68IgutW8Ed6Y4u98gW9iZIQE7AZZRdoSvRdZLIwf0kSAMBrosDNZsg=;
X-UUID: b1e749a258184360b17d3bc83fcace74-20200622
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <bibby.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1486169950; Mon, 22 Jun 2020 10:40:56 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 22 Jun 2020 10:40:44 +0800
Received: from [172.21.77.4] (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 22 Jun 2020 10:40:45 +0800
Message-ID: <1592793655.11692.9.camel@mtksdaap41>
Subject: Re: [PATCH v1 0/11] support cmdq helper function on mt6779 platform
From:   Bibby Hsieh <bibby.hsieh@mediatek.com>
To:     Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
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
Date:   Mon, 22 Jun 2020 10:40:55 +0800
In-Reply-To: <1592749115-24158-1-git-send-email-dennis-yc.hsieh@mediatek.com>
References: <1592749115-24158-1-git-send-email-dennis-yc.hsieh@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIERlbm5pcywNCg0KUGxlYXNlIGFkZCAiZGVwZW5kcyBvbiBwYXRjaDogc3VwcG9ydCBnY2Ug
b24gbXQ2Nzc5IHBsYXRmb3JtIiBpbiBjb3Zlcg0KbGV0dGVyLiBUaGFua3MNCg0KQmliYnkNCg0K
T24gU3VuLCAyMDIwLTA2LTIxIGF0IDIyOjE4ICswODAwLCBEZW5uaXMgWUMgSHNpZWggd3JvdGU6
DQo+IFRoaXMgcGF0Y2ggc3VwcG9ydCBjbWRxIGhlbHBlciBmdW5jdGlvbiBvbiBtdDY3NzkgcGxh
dGZvcm0sDQo+IGJhc2VkIG9uICJzdXBwb3J0IGdjZSBvbiBtdDY3NzkgcGxhdGZvcm0iIHBhdGNo
c2V0Lg0KPiANCj4gDQo+IERlbm5pcyBZQyBIc2llaCAoMTEpOg0KPiAgIHNvYzogbWVkaWF0ZWs6
IGNtZHE6IGFkZCBhZGRyZXNzIHNoaWZ0IGluIGp1bXANCj4gICBzb2M6IG1lZGlhdGVrOiBjbWRx
OiBhZGQgYXNzaWduIGZ1bmN0aW9uDQo+ICAgc29jOiBtZWRpYXRlazogY21kcTogYWRkIHdyaXRl
X3MgZnVuY3Rpb24NCj4gICBzb2M6IG1lZGlhdGVrOiBjbWRxOiBhZGQgd3JpdGVfc19tYXNrIGZ1
bmN0aW9uDQo+ICAgc29jOiBtZWRpYXRlazogY21kcTogYWRkIHJlYWRfcyBmdW5jdGlvbg0KPiAg
IHNvYzogbWVkaWF0ZWs6IGNtZHE6IGFkZCB3cml0ZV9zIHZhbHVlIGZ1bmN0aW9uDQo+ICAgc29j
OiBtZWRpYXRlazogY21kcTogYWRkIHdyaXRlX3NfbWFzayB2YWx1ZSBmdW5jdGlvbg0KPiAgIHNv
YzogbWVkaWF0ZWs6IGNtZHE6IGV4cG9ydCBmaW5hbGl6ZSBmdW5jdGlvbg0KPiAgIHNvYzogbWVk
aWF0ZWs6IGNtZHE6IGFkZCBqdW1wIGZ1bmN0aW9uDQo+ICAgc29jOiBtZWRpYXRlazogY21kcTog
YWRkIGNsZWFyIG9wdGlvbiBpbiBjbWRxX3BrdF93ZmUgYXBpDQo+ICAgc29jOiBtZWRpYXRlazog
Y21kcTogYWRkIHNldCBldmVudCBmdW5jdGlvbg0KPiANCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRp
YXRlay9tdGtfZHJtX2NydGMuYyAgfCAgIDMgKy0NCj4gIGRyaXZlcnMvc29jL21lZGlhdGVrL210
ay1jbWRxLWhlbHBlci5jICAgfCAxNTkgKysrKysrKysrKysrKysrKysrKysrLS0NCj4gIGluY2x1
ZGUvbGludXgvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmggfCAgIDggKy0NCj4gIGluY2x1ZGUv
bGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmggICAgfCAxMjQgKysrKysrKysrKysrKysrKyst
DQo+ICA0IGZpbGVzIGNoYW5nZWQsIDI4MCBpbnNlcnRpb25zKCspLCAxNCBkZWxldGlvbnMoLSkN
Cj4gDQoNCg==

