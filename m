Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36385C35671
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 15:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3298206E0
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 15:49:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="rbUsAmSa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgBWPtW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 10:49:22 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:50327 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726208AbgBWPtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 10:49:22 -0500
X-UUID: 40a2514bdc9745c7a58158bde4f8cc3e-20200223
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=0nKH1cddPqIhprdICOy5mrIMOZ5r54kyLtHZf1Qc6t4=;
        b=rbUsAmSaUKac7XbAmN9yZsihbYIy+rDemDxQRGEtTcx7e+tbsvnNjNUCcIfK+Ok1vmz92OfMZ86XnYpu9WOEBiX4cNMe5k0MVewwy3XgsSV9SCCUyInKjKltvdnodlOnF/N414PDBCZOZtgCvpkO0m39g5//U7x/iOqP8+cvPww=;
X-UUID: 40a2514bdc9745c7a58158bde4f8cc3e-20200223
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1991646407; Sun, 23 Feb 2020 23:49:13 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sun, 23 Feb 2020 23:48:24 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sun, 23 Feb 2020 23:48:17 +0800
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
Subject: [PATCH v2] usb: gadget: f_fs: try to fix AIO issue under ARM 64 bit TAGGED mode
Date:   Sun, 23 Feb 2020 23:49:07 +0800
Message-ID: <1582472947-22471-1-git-send-email-macpaul.lin@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
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
CkNoYW5nZXMgZm9yIHYyOg0KICAtIEZpeCBidWlsZCBlcnJvciBmb3IgMzItYml0IGxvYWQuIEFu
ICNpZiBkZWZpbmVkKENPTkZJR19BUk02NCkgc3RpbGwgbmVlZA0KICAgIGZvciBhdm9pZGluZyB1
bmRlY2xhcmVkIGRlZmluZXMuDQoNCiBkcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vZl9mcy5j
IHwgICAgNSArKysrKw0KIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKykNCg0KZGlmZiAt
LWdpdCBhL2RyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi9mX2ZzLmMgYi9kcml2ZXJzL3VzYi9n
YWRnZXQvZnVuY3Rpb24vZl9mcy5jDQppbmRleCBjZTFkMDIzLi43MjhjMjYwIDEwMDY0NA0KLS0t
IGEvZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9uL2ZfZnMuYw0KKysrIGIvZHJpdmVycy91c2Iv
Z2FkZ2V0L2Z1bmN0aW9uL2ZfZnMuYw0KQEAgLTM1LDYgKzM1LDcgQEANCiAjaW5jbHVkZSA8bGlu
dXgvbW11X2NvbnRleHQuaD4NCiAjaW5jbHVkZSA8bGludXgvcG9sbC5oPg0KICNpbmNsdWRlIDxs
aW51eC9ldmVudGZkLmg+DQorI2luY2x1ZGUgPGxpbnV4L3RocmVhZF9pbmZvLmg+DQogDQogI2lu
Y2x1ZGUgInVfZnMuaCINCiAjaW5jbHVkZSAidV9mLmgiDQpAQCAtODI2LDYgKzgyNywxMCBAQCBz
dGF0aWMgdm9pZCBmZnNfdXNlcl9jb3B5X3dvcmtlcihzdHJ1Y3Qgd29ya19zdHJ1Y3QgKndvcmsp
DQogCWlmIChpb19kYXRhLT5yZWFkICYmIHJldCA+IDApIHsNCiAJCW1tX3NlZ21lbnRfdCBvbGRm
cyA9IGdldF9mcygpOw0KIA0KKyNpZiBkZWZpbmVkKENPTkZJR19BUk02NCkNCisJCWlmIChJU19F
TkFCTEVEKENPTkZJR19BUk02NF9UQUdHRURfQUREUl9BQkkpKQ0KKwkJCXNldF90aHJlYWRfZmxh
ZyhUSUZfVEFHR0VEX0FERFIpOw0KKyNlbmRpZg0KIAkJc2V0X2ZzKFVTRVJfRFMpOw0KIAkJdXNl
X21tKGlvX2RhdGEtPm1tKTsNCiAJCXJldCA9IGZmc19jb3B5X3RvX2l0ZXIoaW9fZGF0YS0+YnVm
LCByZXQsICZpb19kYXRhLT5kYXRhKTsNCi0tIA0KMS43LjkuNQ0K

