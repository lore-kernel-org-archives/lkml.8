Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF13C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 06:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 975FC206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 06:21:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="QLK3qWpI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726056AbgENGVK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 02:21:10 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:22108 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725806AbgENGVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 02:21:10 -0400
X-UUID: d6e25b18fc1146349bca91208bbcff79-20200514
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=wQyMY1i9PotArkUWD4AtPY8qAbkcQgFz5GnPbTCKrx0=;
        b=QLK3qWpILB8znUPvpzLmfBL0qE1d6i12/JE621Uxtze6Q78Y8b8QwbYkpMKCC+Y/Volvgx6AhMRvguBiwWXn7o1mInH86YVWFRYNyXb3WKGuGOoU6EqGSZnoa9APeZLIS0AG1H1TyWq+h2Ml1prIlgSvO6phpvfHiM+BSHWXAN4=;
X-UUID: d6e25b18fc1146349bca91208bbcff79-20200514
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <fengping.yu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 2088078309; Thu, 14 May 2020 14:21:08 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 14 May 2020 14:21:00 +0800
Received: from localhost.localdomain (10.15.20.246) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 14 May 2020 14:21:00 +0800
From:   Fengping Yu <fengping.yu@mediatek.com>
To:     Yingjoe Chen <yingjoe.chen@mediatek.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Marco Felsch <m.felsch@pengutronix.de>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v7] Add matrix keypad driver support for Mediatek SoCs  
Date:   Thu, 14 May 2020 14:17:44 +0800
Message-ID: <20200514061747.25466-1-fengping.yu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpDaGFuZ2Ugc2luY2UgdjY6DQotIHVwZGF0ZSBrZXlwYWQgZGV2aWNlIHRyZWUgZG9jdW1lbnQg
c2NoZW1hDQoNCmZlbmdwaW5nLnl1ICgzKToNCiAgZHQtYmluZGluZ3M6IEFkZCBrZXlwYWQgZGV2
aWNldHJlZSBkb2N1bWVudGF0aW9uDQogIGRyaXZlcnM6IGlucHV0OiBrZXlib2FyZDogQWRkIG10
ayBrZXlwYWQgZHJpdmVyDQogIGNvbmZpZ3M6IGRlZmNvbmZpZzogQWRkIENPTkZJR19LRVlCT0FS
RF9NVEtfS1BEPXkNCg0KIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lucHV0L210ay1rcGQueWFt
bCAgICB8IDEwMiArKysrKysrKw0KIGFyY2gvYXJtNjQvY29uZmlncy9kZWZjb25maWcgICAgICAg
ICAgICAgICAgICB8ICAgMiArDQogZHJpdmVycy9pbnB1dC9rZXlib2FyZC9LY29uZmlnICAgICAg
ICAgICAgICAgIHwgICA4ICsNCiBkcml2ZXJzL2lucHV0L2tleWJvYXJkL01ha2VmaWxlICAgICAg
ICAgICAgICAgfCAgIDEgKw0KIGRyaXZlcnMvaW5wdXQva2V5Ym9hcmQvbXRrLWtwZC5jICAgICAg
ICAgICAgICB8IDIyMyArKysrKysrKysrKysrKysrKysNCiA1IGZpbGVzIGNoYW5nZWQsIDMzNiBp
bnNlcnRpb25zKCspDQogY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9pbnB1dC9tdGsta3BkLnlhbWwNCiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVy
cy9pbnB1dC9rZXlib2FyZC9tdGsta3BkLmMNCg0KLS0NCjIuMTguMA0KDQo=

