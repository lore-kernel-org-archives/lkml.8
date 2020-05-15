Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE2A3C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 06:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B88D20728
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 06:23:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ao1EG2Hn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbgEOGXa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 02:23:30 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:26635 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726182AbgEOGX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 02:23:29 -0400
X-UUID: 1f5f5546bcd04062b8e1cfd1ddf15554-20200515
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=JKzhC7ZyS4Az8kB6uFAL7FCHI2123du89vRJcZ+CFlY=;
        b=ao1EG2HnyD5fy2iEl9El8MPa3Uf41MTi/kICMADmQQeHsT7a3cWGHaoamHnh04gimNralyoOdg4cGKGpNhGunTJZXGRKftrbxNGoqTyxW2E+ZXMM0Li+STER+0R8sGKjB45DcdW9fI4LXfJZFLalmRKAKHhJmUNWDebXSIXdOI4=;
X-UUID: 1f5f5546bcd04062b8e1cfd1ddf15554-20200515
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <fengping.yu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 683011692; Fri, 15 May 2020 14:23:26 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 15 May 2020 14:23:23 +0800
Received: from localhost.localdomain (10.15.20.246) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 15 May 2020 14:23:22 +0800
From:   Fengping Yu <fengping.yu@mediatek.com>
To:     Yingjoe Chen <yingjoe.chen@mediatek.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Marco Felsch <m.felsch@pengutronix.de>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v8] Add matrix keypad driver support for Mediatek SoCs 
Date:   Fri, 15 May 2020 14:20:04 +0800
Message-ID: <20200515062007.28346-1-fengping.yu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 9506C491B6E551E93E6FC636CE37D46A8BF0457FA886208279F30A3D36F6DB1E2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpDaGFuZ2Ugc2luY2Ugdjc6DQotIHNwZWNpZnkgY29tcGF0aWJsZSBwcm9wZXJ0eSBhcyBjb25z
dCBzdHJpbmcNCi0gYWRkIG1heEl0ZW0gaW4gcmVxdWlyZWQgcHJvcGVydHkNCi0gc3F1YXNoIGtl
eXBhZCBleGFtcGxlIG5vZGVzDQotIHNvcnQgaGVhZGVyIGZpbGUgd2l0aCBhbHBoYWJldGljIG9y
ZGVyDQotIGFsaWduIGFsbCBkZWZpbmUgdmFsdWVzIGFuZCBhZGQgTVRLXyBwcmVmaXggdG8gbWFr
ZSBtb3JlIHVuaWZvcm0NCi0gY2hhbmdlIGRlYm91bmNlIHZhbHVlIHRvIGRlZmF1bHQgMTZtcyBp
ZiBub3Qgc3BlY2lmaWVkIGluIGR0cw0KLSByZW1vdmUgZXh0cmEgYnJhY2VzDQotIHNlcGFyYXRl
IGNsayBwcmVwYXJlIGFzIGFuIGludGVybmFsIGRyaXZlciBmdW5jdGlvbg0KLSBhZGQgc3BlY2lh
bCBjb21wYXRpYmxlIHN0cmluZw0KLSBtb2RpZnkgQ09ORklHX0tFWUJPQVJEX01US19LUEQ9bSB0
byBidWlsZCBrZXlwYWQgYXMga28gbW9kdWxlDQoNCmZlbmdwaW5nLnl1ICgzKToNCiAgZHQtYmlu
ZGluZ3M6IEFkZCBrZXlwYWQgZGV2aWNldHJlZSBkb2N1bWVudGF0aW9uDQogIGRyaXZlcnM6IGlu
cHV0OiBrZXlib2FyZDogQWRkIG10ayBrZXlwYWQgZHJpdmVyDQogIGNvbmZpZ3M6IGRlZmNvbmZp
ZzogQWRkIENPTkZJR19uZy55dSAoMyk6DQogIGR0LWJpbmRpbmdzOiBBZGQga2V5cGFkIGRldmlj
ZXRyZWUgZG9jdW1lbnRhdGlvbg0KICBkcml2ZXJzOiBpbnB1dDoga2V5Ym9hcmQ6IEFkZCBtdGsg
a2V5cGFkIGRyaXZlcg0KICBjb25maWdzOiBkZWZjb25maWc6IEFkZCBDT05GSUdfS0VZQk9BUkRf
TVRLX0tQRD1tDQoNCiAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9pbnB1dC9tdGsta3BkLnlhbWwg
ICAgfCAgOTQgKysrKysrKw0KIGFyY2gvYXJtNjQvY29uZmlncy9kZWZjb25maWcgICAgICAgICAg
ICAgICAgICB8ICAgMSArDQogZHJpdmVycy9pbnB1dC9rZXlib2FyZC9LY29uZmlnICAgICAgICAg
ICAgICAgIHwgICA5ICsNCiBkcml2ZXJzL2lucHV0L2tleWJvYXJkL01ha2VmaWxlICAgICAgICAg
ICAgICAgfCAgIDEgKw0KIGRyaXZlcnMvaW5wdXQva2V5Ym9hcmQvbXRrLWtwZC5jICAgICAgICAg
ICAgICB8IDIzMSArKysrKysrKysrKysrKysrKysNCiA1IGZpbGVzIGNoYW5nZWQsIDMzNiBpbnNl
cnRpb25zKCspDQogY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9pbnB1dC9tdGsta3BkLnlhbWwNCiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9p
bnB1dC9rZXlib2FyZC9tdGsta3BkLmMNCg0KLS0NCjIuMTguMA0KDQo=

