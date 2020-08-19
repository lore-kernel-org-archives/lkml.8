Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2530BC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 12:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0028D206FA
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 12:43:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="anVGfFPS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728407AbgHSMnl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 08:43:41 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:13659 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727944AbgHSMnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 08:43:06 -0400
X-UUID: 788bbd9b5bf1409bb9a1938983c795f6-20200819
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=AQIMWJYfBrMtRgOV2GfpNte4cp/Qee5OO3k+Wl9/GA0=;
        b=anVGfFPSZJTh3Hjxn0ixqNUitHVdfhtXF5gVIt/YJJ9pvBQPlLxlb4N7eUThZKN+N8AUZZg9SEJh6Hc9qvhFEUZ3UQPKfAWV79mmeTz0ecMgdN/DRuedCaP1AVWtUE6jYUCAB9JYMBRMRvcxPgS7ZPfbe4AXt9h2BRtsYHnCWZw=;
X-UUID: 788bbd9b5bf1409bb9a1938983c795f6-20200819
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 565172274; Wed, 19 Aug 2020 20:42:48 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 MTKMBS31DR.mediatek.inc (172.27.6.102) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 19 Aug 2020 20:42:46 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 19 Aug 2020 20:42:45 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Felipe Balbi <balbi@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Lee Jones <lee.jones@linaro.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH 04/10] usb: xhci-rcar: convert to readl_poll_timeout_atomic()
Date:   Wed, 19 Aug 2020 20:40:59 +0800
Message-ID: <1597840865-26631-4-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1597840865-26631-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1597840865-26631-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: BCE825A1C94D2720BFEDB625C7672783B5064235399A4E02EC7DCDEB11E3DB422000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VXNlIHJlYWRsX3BvbGxfdGltZW91dF9hdG9taWMoKSB0byBzaW1wbGlmeSBjb2RlDQoNCkNjOiBN
YXRoaWFzIE55bWFuIDxtYXRoaWFzLm55bWFuQGxpbnV4LmludGVsLmNvbT4NCkNjOiBZb3NoaWhp
cm8gU2hpbW9kYSA8eW9zaGloaXJvLnNoaW1vZGEudWhAcmVuZXNhcy5jb20+DQpTaWduZWQtb2Zm
LWJ5OiBDaHVuZmVuZyBZdW4gPGNodW5mZW5nLnl1bkBtZWRpYXRlay5jb20+DQotLS0NCiBkcml2
ZXJzL3VzYi9ob3N0L3hoY2ktcmNhci5jIHwgNDMgKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspLCAzMSBk
ZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2hvc3QveGhjaS1yY2FyLmMg
Yi9kcml2ZXJzL3VzYi9ob3N0L3hoY2ktcmNhci5jDQppbmRleCBjMTAyNWQzLi43NGY4MzZmIDEw
MDY0NA0KLS0tIGEvZHJpdmVycy91c2IvaG9zdC94aGNpLXJjYXIuYw0KKysrIGIvZHJpdmVycy91
c2IvaG9zdC94aGNpLXJjYXIuYw0KQEAgLTYsNiArNiw3IEBADQogICovDQogDQogI2luY2x1ZGUg
PGxpbnV4L2Zpcm13YXJlLmg+DQorI2luY2x1ZGUgPGxpbnV4L2lvcG9sbC5oPg0KICNpbmNsdWRl
IDxsaW51eC9tb2R1bGUuaD4NCiAjaW5jbHVkZSA8bGludXgvcGxhdGZvcm1fZGV2aWNlLmg+DQog
I2luY2x1ZGUgPGxpbnV4L29mLmg+DQpAQCAtMTI3LDggKzEyOCw3IEBAIHN0YXRpYyBpbnQgeGhj
aV9yY2FyX2Rvd25sb2FkX2Zpcm13YXJlKHN0cnVjdCB1c2JfaGNkICpoY2QpDQogCXZvaWQgX19p
b21lbSAqcmVncyA9IGhjZC0+cmVnczsNCiAJc3RydWN0IHhoY2lfcGxhdF9wcml2ICpwcml2ID0g
aGNkX3RvX3hoY2lfcHJpdihoY2QpOw0KIAljb25zdCBzdHJ1Y3QgZmlybXdhcmUgKmZ3Ow0KLQlp
bnQgcmV0dmFsLCBpbmRleCwgaiwgdGltZTsNCi0JaW50IHRpbWVvdXQgPSAxMDAwMDsNCisJaW50
IHJldHZhbCwgaW5kZXgsIGo7DQogCXUzMiBkYXRhLCB2YWwsIHRlbXA7DQogCXUzMiBxdWlya3Mg
PSAwOw0KIAljb25zdCBzdHJ1Y3Qgc29jX2RldmljZV9hdHRyaWJ1dGUgKmF0dHI7DQpAQCAtMTY2
LDMyICsxNjYsMTkgQEAgc3RhdGljIGludCB4aGNpX3JjYXJfZG93bmxvYWRfZmlybXdhcmUoc3Ry
dWN0IHVzYl9oY2QgKmhjZCkNCiAJCXRlbXAgfD0gUkNBUl9VU0IzX0RMX0NUUkxfRldfU0VUX0RB
VEEwOw0KIAkJd3JpdGVsKHRlbXAsIHJlZ3MgKyBSQ0FSX1VTQjNfRExfQ1RSTCk7DQogDQotCQlm
b3IgKHRpbWUgPSAwOyB0aW1lIDwgdGltZW91dDsgdGltZSsrKSB7DQotCQkJdmFsID0gcmVhZGwo
cmVncyArIFJDQVJfVVNCM19ETF9DVFJMKTsNCi0JCQlpZiAoKHZhbCAmIFJDQVJfVVNCM19ETF9D
VFJMX0ZXX1NFVF9EQVRBMCkgPT0gMCkNCi0JCQkJYnJlYWs7DQotCQkJdWRlbGF5KDEpOw0KLQkJ
fQ0KLQkJaWYgKHRpbWUgPT0gdGltZW91dCkgew0KLQkJCXJldHZhbCA9IC1FVElNRURPVVQ7DQor
CQlyZXR2YWwgPSByZWFkbF9wb2xsX3RpbWVvdXRfYXRvbWljKHJlZ3MgKyBSQ0FSX1VTQjNfRExf
Q1RSTCwNCisJCQkJdmFsLCAhKHZhbCAmIFJDQVJfVVNCM19ETF9DVFJMX0ZXX1NFVF9EQVRBMCks
DQorCQkJCTEsIDEwMDAwKTsNCisJCWlmIChyZXR2YWwgPCAwKQ0KIAkJCWJyZWFrOw0KLQkJfQ0K
IAl9DQogDQogCXRlbXAgPSByZWFkbChyZWdzICsgUkNBUl9VU0IzX0RMX0NUUkwpOw0KIAl0ZW1w
ICY9IH5SQ0FSX1VTQjNfRExfQ1RSTF9FTkFCTEU7DQogCXdyaXRlbCh0ZW1wLCByZWdzICsgUkNB
Ul9VU0IzX0RMX0NUUkwpOw0KIA0KLQlmb3IgKHRpbWUgPSAwOyB0aW1lIDwgdGltZW91dDsgdGlt
ZSsrKSB7DQotCQl2YWwgPSByZWFkbChyZWdzICsgUkNBUl9VU0IzX0RMX0NUUkwpOw0KLQkJaWYg
KHZhbCAmIFJDQVJfVVNCM19ETF9DVFJMX0ZXX1NVQ0NFU1MpIHsNCi0JCQlyZXR2YWwgPSAwOw0K
LQkJCWJyZWFrOw0KLQkJfQ0KLQkJdWRlbGF5KDEpOw0KLQl9DQotCWlmICh0aW1lID09IHRpbWVv
dXQpDQotCQlyZXR2YWwgPSAtRVRJTUVET1VUOw0KKwlyZXR2YWwgPSByZWFkbF9wb2xsX3RpbWVv
dXRfYXRvbWljKChyZWdzICsgUkNBUl9VU0IzX0RMX0NUUkwpLA0KKwkJCXZhbCwgKHZhbCAmIFJD
QVJfVVNCM19ETF9DVFJMX0ZXX1NVQ0NFU1MpLCAxLCAxMDAwMCk7DQogDQogCXJlbGVhc2VfZmly
bXdhcmUoZncpOw0KIA0KQEAgLTIwMCwxOCArMTg3LDEyIEBAIHN0YXRpYyBpbnQgeGhjaV9yY2Fy
X2Rvd25sb2FkX2Zpcm13YXJlKHN0cnVjdCB1c2JfaGNkICpoY2QpDQogDQogc3RhdGljIGJvb2wg
eGhjaV9yY2FyX3dhaXRfZm9yX3BsbF9hY3RpdmUoc3RydWN0IHVzYl9oY2QgKmhjZCkNCiB7DQot
CWludCB0aW1lb3V0ID0gMTAwMDsNCisJaW50IHJldHZhbDsNCiAJdTMyIHZhbCwgbWFzayA9IFJD
QVJfVVNCM19BWEhfU1RBX1BMTF9BQ1RJVkVfTUFTSzsNCiANCi0Jd2hpbGUgKHRpbWVvdXQgPiAw
KSB7DQotCQl2YWwgPSByZWFkbChoY2QtPnJlZ3MgKyBSQ0FSX1VTQjNfQVhIX1NUQSk7DQotCQlp
ZiAoKHZhbCAmIG1hc2spID09IG1hc2spDQotCQkJcmV0dXJuIHRydWU7DQotCQl1ZGVsYXkoMSk7
DQotCQl0aW1lb3V0LS07DQotCX0NCi0NCi0JcmV0dXJuIGZhbHNlOw0KKwlyZXR2YWwgPSByZWFk
bF9wb2xsX3RpbWVvdXRfYXRvbWljKGhjZC0+cmVncyArIFJDQVJfVVNCM19BWEhfU1RBLA0KKwkJ
CXZhbCwgKCh2YWwgJiBtYXNrKSA9PSBtYXNrKSwgMSwgMTAwMCk7DQorCXJldHVybiAhIXJldHZh
bDsNCiB9DQogDQogLyogVGhpcyBmdW5jdGlvbiBuZWVkcyB0byBpbml0aWFsaXplIGEgInBoeSIg
b2YgdXNiIGJlZm9yZSAqLw0KLS0gDQoxLjkuMQ0K

