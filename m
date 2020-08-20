Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B082C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 06:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AD8F207DE
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 06:06:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="bU4ZnG4M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbgHTGGy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 02:06:54 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:65280 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726765AbgHTGFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 02:05:47 -0400
X-UUID: 1650d91ceda542c9a81706c9b7d8e378-20200820
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=o1GR/JP56KwhHadHVRRsgKjaM3oHmqygNovIP6VBnrY=;
        b=bU4ZnG4MyYk0jGJAI8vWuZVzIECAzI+a54bl8lKy9xPvLDLehN+OMWzWHJX3rFqygEu4FAh3dfq1wUY/V+dk0eluUOc0HwZGxgOcZ5aqXComjmR23YIxXfBAISKpMsAep3Thl0YXMI/ci3K0XRvubCCgwh4phI1VDBV935NQokc=;
X-UUID: 1650d91ceda542c9a81706c9b7d8e378-20200820
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1897108210; Thu, 20 Aug 2020 14:05:42 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 20 Aug 2020 14:05:40 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 20 Aug 2020 14:05:39 +0800
From:   Yongqiang Niu <yongqiang.niu@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>
Subject: [PATCH v1 09/21] drm/mediatek: fix aal size config
Date:   Thu, 20 Aug 2020 14:04:06 +0800
Message-ID: <1597903458-8055-10-git-send-email-yongqiang.niu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1597903458-8055-1-git-send-email-yongqiang.niu@mediatek.com>
References: <1597903458-8055-1-git-send-email-yongqiang.niu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zml4IGFhbCBzaXplIGNvbmZpZw0KDQpTaWduZWQtb2ZmLWJ5OiBZb25ncWlhbmcgTml1IDx5b25n
cWlhbmcubml1QG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9t
dGtfZHJtX2RkcF9jb21wLmMgfCAxMSArKysrKysrKysrLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxMCBp
bnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vbWVkaWF0ZWsvbXRrX2RybV9kZHBfY29tcC5jIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVr
L210a19kcm1fZGRwX2NvbXAuYw0KaW5kZXggYzkwZDJlZS4uZmU3NjM4NyAxMDA2NDQNCi0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2RkcF9jb21wLmMNCisrKyBiL2RyaXZl
cnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2RkcF9jb21wLmMNCkBAIC0zMSw4ICszMSwxMyBA
QA0KICNkZWZpbmUgRElTUF9SRUdfVUZPX1NUQVJUCQkJMHgwMDAwDQogDQogI2RlZmluZSBESVNQ
X0FBTF9FTgkJCQkweDAwMDANCisjZGVmaW5lIERJU1BfQUFMX0NGRwkJCQkweDAwMjANCisjZGVm
aW5lIEFBTF9SRUxBWV9NT0RFCQkJCQlCSVQoMCkNCisjZGVmaW5lIEFBTF9FTkdJTkVfRU4JCQkJ
CUJJVCgxKQ0KICNkZWZpbmUgRElTUF9BQUxfU0laRQkJCQkweDAwMzANCiANCisjZGVmaW5lIERJ
U1BfQUFMX09VVFBVVF9TSVpFCQkJMHgwNGQ4DQorDQogI2RlZmluZSBESVNQX0NDT1JSX0VOCQkJ
CTB4MDAwMA0KICNkZWZpbmUgQ0NPUlJfRU4JCQkJQklUKDApDQogI2RlZmluZSBESVNQX0NDT1JS
X0NGRwkJCQkweDAwMjANCkBAIC0xODIsNyArMTg3LDExIEBAIHN0YXRpYyB2b2lkIG10a19hYWxf
Y29uZmlnKHN0cnVjdCBtdGtfZGRwX2NvbXAgKmNvbXAsIHVuc2lnbmVkIGludCB3LA0KIAkJCSAg
IHVuc2lnbmVkIGludCBoLCB1bnNpZ25lZCBpbnQgdnJlZnJlc2gsDQogCQkJICAgdW5zaWduZWQg
aW50IGJwYywgc3RydWN0IGNtZHFfcGt0ICpjbWRxX3BrdCkNCiB7DQotCW10a19kZHBfd3JpdGUo
Y21kcV9wa3QsIGggPDwgMTYgfCB3LCBjb21wLCBESVNQX0FBTF9TSVpFKTsNCisJbXRrX2RkcF93
cml0ZShjbWRxX3BrdCwgdyA8PCAxNiB8IGgsIGNvbXAsIERJU1BfQUFMX1NJWkUpOw0KKwltdGtf
ZGRwX3dyaXRlKGNtZHFfcGt0LCB3IDw8IDE2IHwgaCwgY29tcCwgRElTUF9BQUxfT1VUUFVUX1NJ
WkUpOw0KKw0KKwltdGtfZGRwX3dyaXRlX21hc2soTlVMTCwgQUFMX1JFTEFZX01PREUsIGNvbXAs
IERJU1BfQUFMX0NGRywNCisJCQkgICBBQUxfUkVMQVlfTU9ERSB8IEFBTF9FTkdJTkVfRU4pOw0K
IH0NCiANCiBzdGF0aWMgdm9pZCBtdGtfYWFsX3N0YXJ0KHN0cnVjdCBtdGtfZGRwX2NvbXAgKmNv
bXApDQotLSANCjEuOC4xLjEuZGlydHkNCg==

