Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A33C35670
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 08:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5809205C9
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 08:53:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="WnM6R2F7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbgBWIx2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 03:53:28 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:22825 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726592AbgBWIx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 03:53:28 -0500
X-UUID: 38e39728baba4c5a88c3e39a367ab3e1-20200223
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=L6+Le50jyFOltKwz1JENBOZc2qg1uyeNTqnh9DLfcl4=;
        b=WnM6R2F75bga3qqX7bdF+i6UDekkzY4y8slHZtEFTxxHqj0R3TmWLYniNfaMKj9YLekaSJCowU+6KZ8ZD8PJ8yyndwNiq0OIXeDBNL6BXyL2Gx9flOZYilIVHas3Wn0zK6zVs0OBjQH49DaWz9jVmcXYkUaqAP0pVN2qpbbWHtY=;
X-UUID: 38e39728baba4c5a88c3e39a367ab3e1-20200223
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 574559612; Sun, 23 Feb 2020 16:53:24 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sun, 23 Feb 2020 16:52:09 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sun, 23 Feb 2020 16:52:29 +0800
From:   Macpaul Lin <macpaul.lin@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Shen Jing <jingx.shen@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Vincent Pelletier <plr.vincent@gmail.com>,
        Jerry Zhang <zhangjerry@google.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Mediatek WSD Upstream <wsd_upstream@mediatek.com>,
        CC Hwang <cc.hwang@mediatek.com>,
        Loda Chou <loda.chou@mediatek.com>,
        Al Viro <viro@zeniv.linux.org.uk>
CC:     Macpaul Lin <macpaul.lin@mediatek.com>
Subject: [PATCH] usb: gadget: f_fs: try to fix AIO issue under ARM 64 bit TAGGED mode
Date:   Sun, 23 Feb 2020 16:53:12 +0800
Message-ID: <1582447993-7594-1-git-send-email-macpaul.lin@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <n>
References: <n>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBpc3N1ZSB3YXMgZm91bmQgd2hlbiBhZGJkIHRyeWluZyB0byBvcGVuIGZ1bmN0aW9uZnMg
d2l0aCBBSU8gbW9kZS4NClVzdWFsbHksIHdlIG5lZWQgdG8gc2V0ICJzZXRwcm9wIHN5cy51c2Iu
ZmZzLmFpb19jb21wYXQgMCIgdG8gZW5hYmxlDQphZGJkIHdpdGggQUlPIG1vZGUgb24gQW5kcm9p
ZC4NCg0KV2hlbiBhZGJkIGlzIG9wZW5pbmcgZnVuY3Rpb25mcywgaXQgd2lsbCB0cnkgdG8gcmVh
ZCAyNCBieXRlcyBhdCB0aGUNCmZpc3J0IHJlYWQgSS9PIGNvbnRyb2wuIElmIHRoaXMgcmVhZGlu
ZyBoYXMgYmVlbiBmYWlsZWQsIGFkYmQgd2lsbA0KdHJ5IHRvIHNlbmQgRlVOQ1RJT05GU19DTEVB
Ul9IQUxUIHRvIGZ1bmN0aW9uZnMuIFdoZW4gYWRiZCBpcyBpbiBBSU8NCm1vZGUsIGZ1bmN0aW9u
ZnMgd2lsbCBiZSBhY3RlZCB3aXRoIGFzeW5jcm9uaXplZCBJL08gcGF0aC4gQWZ0ZXIgdGhlDQpz
dWNjZXNzZnVsIHJlYWQgdHJhbnNmZXIgaGFzIGJlZW4gY29tcGxldGVkIGJ5IGdhZGdldCBoYXJk
d2FyZSwgdGhlDQpmb2xsb3dpbmcgc2VyaWVzIG9mIGZ1bmN0aW9ucyB3aWxsIGJlIGNhbGxlZC4N
CiAgZmZzX2VwZmlsZV9hc3luY19pb19jb21wbGV0ZSgpIC0+IGZmc191c2VyX2NvcHlfd29ya2Vy
KCkgLT4NCiAgICBjb3B5X3RvX2l0ZXIoKSAtPiBfY29weV90b19pdGVyKCkgLT4gY29weW91dCgp
IC0+DQogICAgaXRlcmF0ZV9hbmRfYWR2YW5jZSgpIC0+IGl0ZXJhdGVfaW92ZWMoKQ0KDQpBZGRp
bmcgZGVidWcgdHJhY2UgdG8gdGhlc2UgZnVuY3Rpb25zLCBpdCBoYXMgYmVlbiBmb3VuZCB0aGF0
IGluDQpjb3B5b3V0KCksIGFjY2Vzc19vaygpIHdpbGwgY2hlY2sgaWYgdGhlIHVzZXIgc3BhY2Ug
YWRkcmVzcyBpcyB2YWxpZA0KdG8gd3JpdGUuIEhvd2V2ZXIgaWYgQ09ORklHX0FSTTY0X1RBR0dF
RF9BRERSX0FCSSBpcyBlbmFibGVkLCBhZGJkDQphbHdheXMgcGFzc2VzIHVzZXIgc3BhY2UgYWRk
cmVzcyBzdGFydCB3aXRoICIweDNDIiB0byBnZGFnZXQncyBBSU8NCmJsb2Nrcy4gVGhpcyB0YWdn
ZWQgYWRkcmVzcyB3aWxsIGNhdXNlIGFjY2Vzc19vaygpIGNoZWNrIGFsd2F5cyBmYWlsLg0KV2hp
Y2ggY2F1c2VzIGxhdGVyIGNhbGN1bGF0aW9uIGluIGl0ZXJhdGVfaW92ZWMoKSB0dXJuIHplcm8u
DQpDb3B5b3V0KCkgd29uJ3QgY29weSBkYXRhIHRvIHVzZXJzcGFjZSBzaW5jZSB0aGUgbGVuZ3Ro
IHRvIGJlIGNvcGllZA0KInYuaW92X2xlbiIgd2lsbCBiZSB6ZXJvLiBGaW5hbGx5IGxlYWRzIGZm
c19jb3B5X3RvX2l0ZXIoKSBhbHdheXMgcmV0dXJuDQotRUZBVUxULCBjYXVzZXMgYWRiZCBjYW5u
b3Qgb3BlbiBmdW5jdGlvbmZzIGFuZCBzZW5kDQpGVU5DVElPTkZTX0NMRUFSX0hBTFQuDQoNClNp
Z25lZC1vZmYtYnk6IE1hY3BhdWwgTGluIDxtYWNwYXVsLmxpbkBtZWRpYXRlay5jb20+DQotLS0N
CiBkcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vZl9mcy5jIHwgICAgMyArKysNCiAxIGZpbGUg
Y2hhbmdlZCwgMyBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9nYWRn
ZXQvZnVuY3Rpb24vZl9mcy5jIGIvZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9uL2ZfZnMuYw0K
aW5kZXggY2UxZDAyMy4uYjIxNTQxYSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvdXNiL2dhZGdldC9m
dW5jdGlvbi9mX2ZzLmMNCisrKyBiL2RyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi9mX2ZzLmMN
CkBAIC0zNSw2ICszNSw3IEBADQogI2luY2x1ZGUgPGxpbnV4L21tdV9jb250ZXh0Lmg+DQogI2lu
Y2x1ZGUgPGxpbnV4L3BvbGwuaD4NCiAjaW5jbHVkZSA8bGludXgvZXZlbnRmZC5oPg0KKyNpbmNs
dWRlIDxsaW51eC90aHJlYWRfaW5mby5oPg0KIA0KICNpbmNsdWRlICJ1X2ZzLmgiDQogI2luY2x1
ZGUgInVfZi5oIg0KQEAgLTgyNiw2ICs4MjcsOCBAQCBzdGF0aWMgdm9pZCBmZnNfdXNlcl9jb3B5
X3dvcmtlcihzdHJ1Y3Qgd29ya19zdHJ1Y3QgKndvcmspDQogCWlmIChpb19kYXRhLT5yZWFkICYm
IHJldCA+IDApIHsNCiAJCW1tX3NlZ21lbnRfdCBvbGRmcyA9IGdldF9mcygpOw0KIA0KKwkJaWYg
KElTX0VOQUJMRUQoQ09ORklHX0FSTTY0X1RBR0dFRF9BRERSX0FCSSkpDQorCQkJc2V0X3RocmVh
ZF9mbGFnKFRJRl9UQUdHRURfQUREUik7DQogCQlzZXRfZnMoVVNFUl9EUyk7DQogCQl1c2VfbW0o
aW9fZGF0YS0+bW0pOw0KIAkJcmV0ID0gZmZzX2NvcHlfdG9faXRlcihpb19kYXRhLT5idWYsIHJl
dCwgJmlvX2RhdGEtPmRhdGEpOw0KLS0gDQoxLjcuOS41DQo=

