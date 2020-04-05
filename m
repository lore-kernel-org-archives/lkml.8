Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB12FC2BA15
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 02:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63DB320672
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 02:04:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="CDnjp3IV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbgDECE1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 22:04:27 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:53009 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726258AbgDECE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 22:04:27 -0400
X-UUID: 18b7f7185d094cd393912fd8e78247c8-20200405
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=6C3FlHQGtBSdpwcN0CT4YS5wT7BtTafM/xlh39vjWCw=;
        b=CDnjp3IVAFpw/2MnoqCmu/DqMax5bkp32pdHIiv8A8A88ldWdErkvPMCI2DOfaehqI1widqRazlyJRJ4DdUX8bzpzbc/SW85Fn8pBAoyImYn3O1CfDB4NpRo273GasplPM/lD4V7KFZ2yQ9wf0vV90LhlvzfFythaoOCKBpW9t0=;
X-UUID: 18b7f7185d094cd393912fd8e78247c8-20200405
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <fengping.yu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 538244710; Sun, 05 Apr 2020 10:04:20 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sun, 5 Apr 2020 10:04:13 +0800
Received: from localhost.localdomain (10.15.20.246) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 5 Apr 2020 10:04:13 +0800
From:   Fengping yu <fengping.yu@mediatek.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>
CC:     <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v3] Add support for MediaTek keypad 
Date:   Sun, 5 Apr 2020 10:01:13 +0800
Message-ID: <20200405020114.14787-1-fengping.yu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpUaGlzIHBhdGNoc2V0IGFkZCBzdXBwb3J0IHRvIE1lZGlhVGVrIG1hdHJpeCBrZXlwYWQuDQoN
CkNoYW5nZSBzaW5jZSBWMjoNCi0gcmVtb3ZlIGV4dHJhIHNwYWNlIGFuZCByZWR1bmRhbnQgbGlu
ZXMNCi0gdXBkYXRlIGtleXBhZCBkZXZpY2V0cmVlIGRvY3VtZW50IGRlYm91bmNlIHRpbWUgdW5p
dA0KLSBjaGFuZ2UgdG8gdXNlIGRldm1fcGxhdGZvcm1faW9yZW1hcF9yZXNvdXJjZSgpIHRvIHNp
bXBsaWZ5IHJlc291cmNlIG1hbmFnZW1lbnQNCi0gdXNlIGJpdG1hcCB0byBzdG9yZSBhbmQgY2hl
Y2sga2V5cGFkIHN0YXRlDQoNCmZlbmdwaW5nLnl1ICgyKToNCiAgYWRkIGR0LWJpbmRpbmcgZG9j
dW1lbnQgZm9yIE1lZGlhVGVrIEtleXBhZA0KICBhZGQgTWVkaWFUZWsga2V5cGFkIGRyaXZlcg0K
DQogLi4uL2RldmljZXRyZWUvYmluZGluZ3MvaW5wdXQvbXRrLWtwZC50eHQgICAgIHwgIDYxICsr
KysrDQogYXJjaC9hcm02NC9jb25maWdzL2RlZmNvbmZpZyAgICAgICAgICAgICAgICAgIHwgICAx
ICsNCiBkcml2ZXJzL2lucHV0L2tleWJvYXJkL0tjb25maWcgICAgICAgICAgICAgICAgfCAgIDcg
Kw0KIGRyaXZlcnMvaW5wdXQva2V5Ym9hcmQvTWFrZWZpbGUgICAgICAgICAgICAgICB8ICAgMSAr
DQogZHJpdmVycy9pbnB1dC9rZXlib2FyZC9tdGsta3BkLmMgICAgICAgICAgICAgIHwgMjU4ICsr
KysrKysrKysrKysrKysrKw0KIDUgZmlsZXMgY2hhbmdlZCwgMzI4IGluc2VydGlvbnMoKykNCiBj
cmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lucHV0
L210ay1rcGQudHh0DQogY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvaW5wdXQva2V5Ym9hcmQv
bXRrLWtwZC5jDQoNCi0tDQoyLjE4LjANCg0K

