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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3ACCC433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 11:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AE18204EA
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 11:35:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="nHLAe92Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730845AbgHTLfB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 07:35:01 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:20365 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730579AbgHTLcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 07:32:52 -0400
X-UUID: cd6d0fd3f0ed4643bbbc24b82b81f9f7-20200820
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=NlLOEjhrKP97DoQusjM5b+qRcLhq9hxp0Tc7oq1k5U8=;
        b=nHLAe92Q++YbEcpfahF0tKi0jkxMmNt9SSYMvBfJvVPfGllnOEy+UFstd00pauoaIoYxr4ZT823Q5gEcCk0Wo0YurWZnSlZm+615CfUd8ik/E9UBq252DsQrfcVgJS+6ZedKGcT6Th+N8aLQncK9HkLimyOn6N9qz28hqefM3uM=;
X-UUID: cd6d0fd3f0ed4643bbbc24b82b81f9f7-20200820
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1914301953; Thu, 20 Aug 2020 19:32:27 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 20 Aug 2020 19:32:27 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 20 Aug 2020 19:32:24 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Al Cooper <alcooperx@gmail.com>,
        Sasi Kumar <sasi.kumar@broadcom.com>,
        Peter Chen <peter.chen@nxp.com>,
        Minas Harutyunyan <hminas@synopsys.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v2 05/11] usb: gadget: bdc: fix check warning of block comments alignment
Date:   Thu, 20 Aug 2020 19:30:40 +0800
Message-ID: <1597923046-12535-5-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1597923046-12535-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1597923046-12535-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: E9AD71729CA0F72BE8F6134097CC8530DF810FA2BA5B743FCD2F930AA0EE64632000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zml4IHRoZSB3YXJuaW5nOg0KICBXQVJOSU5HOkJMT0NLX0NPTU1FTlRfU1RZTEU6DQogIEJsb2Nr
IGNvbW1lbnRzIHNob3VsZCBhbGlnbiB0aGUgKiBvbiBlYWNoIGxpbmUNCg0KQ2M6IEZsb3JpYW4g
RmFpbmVsbGkgPGYuZmFpbmVsbGlAZ21haWwuY29tPg0KU2lnbmVkLW9mZi1ieTogQ2h1bmZlbmcg
WXVuIDxjaHVuZmVuZy55dW5AbWVkaWF0ZWsuY29tPg0KLS0tDQp2MjogYWRkIENjIEZsb3JpYW4N
Ci0tLQ0KIGRyaXZlcnMvdXNiL2dhZGdldC91ZGMvYmRjL2JkYy5oICAgICB8IDIgKy0NCiBkcml2
ZXJzL3VzYi9nYWRnZXQvdWRjL2JkYy9iZGNfZXAuYyAgfCAyICstDQogZHJpdmVycy91c2IvZ2Fk
Z2V0L3VkYy9iZGMvYmRjX3VkYy5jIHwgNiArKystLS0NCiAzIGZpbGVzIGNoYW5nZWQsIDUgaW5z
ZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2dh
ZGdldC91ZGMvYmRjL2JkYy5oIGIvZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9iZGMvYmRjLmgNCmlu
ZGV4IGZjYmE3N2UuLmMwZWU3MzUgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3VzYi9nYWRnZXQvdWRj
L2JkYy9iZGMuaA0KKysrIGIvZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9iZGMvYmRjLmgNCkBAIC0z
NSw3ICszNSw3IEBADQogLyoNCiAgKiBNYXhpbXVtIHNpemUgb2YgZXAwIHJlc3BvbnNlIGJ1ZmZl
ciBmb3IgY2g5IHJlcXVlc3RzLA0KICAqIHRoZSBzZXRfc2VsIHJlcXVlc3QgdXNlcyA2IHNvIGZh
ciwgdGhlIG1heC4NCi0qLw0KKyAqLw0KICNkZWZpbmUgRVAwX1JFU1BPTlNFX0JVRkYgIDYNCiAv
KiBTdGFydCB3aXRoIFNTIGFzIGRlZmF1bHQgKi8NCiAjZGVmaW5lIEVQMF9NQVhfUEtUX1NJWkUg
NTEyDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9iZGMvYmRjX2VwLmMgYi9k
cml2ZXJzL3VzYi9nYWRnZXQvdWRjL2JkYy9iZGNfZXAuYw0KaW5kZXggNDRmM2ExMi4uM2ZiMzZj
OCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvdXNiL2dhZGdldC91ZGMvYmRjL2JkY19lcC5jDQorKysg
Yi9kcml2ZXJzL3VzYi9nYWRnZXQvdWRjL2JkYy9iZGNfZXAuYw0KQEAgLTY4LDcgKzY4LDcgQEAg
c3RhdGljIHZvaWQgZXBfYmRfbGlzdF9mcmVlKHN0cnVjdCBiZGNfZXAgKmVwLCB1MzIgbnVtX3Rh
YnMpDQogCQkgKiBjaGVjayBpZiB0aGUgYmRfdGFibGUgc3RydWN0IGlzIGFsbG9jYXRlZCA/DQog
CQkgKiBpZiB5ZXMsIHRoZW4gY2hlY2sgaWYgYmQgbWVtb3J5IGhhcyBiZWVuIGFsbG9jYXRlZCwg
dGhlbg0KIAkJICogZnJlZSB0aGUgZG1hX3Bvb2wgYW5kIGFsc28gdGhlIGJkX3RhYmxlIHN0cnVj
dCBtZW1vcnkNCi0JCSovDQorCQkgKi8NCiAJCWJkX3RhYmxlID0gYmRfbGlzdC0+YmRfdGFibGVf
YXJyYXlbaW5kZXhdOw0KIAkJZGV2X2RiZyhiZGMtPmRldiwgImJkX3RhYmxlOiVwIGluZGV4OiVk
XG4iLCBiZF90YWJsZSwgaW5kZXgpOw0KIAkJaWYgKCFiZF90YWJsZSkgew0KZGlmZiAtLWdpdCBh
L2RyaXZlcnMvdXNiL2dhZGdldC91ZGMvYmRjL2JkY191ZGMuYyBiL2RyaXZlcnMvdXNiL2dhZGdl
dC91ZGMvYmRjL2JkY191ZGMuYw0KaW5kZXggMjQ4NDI2YS4uMGMxYWI5NSAxMDA2NDQNCi0tLSBh
L2RyaXZlcnMvdXNiL2dhZGdldC91ZGMvYmRjL2JkY191ZGMuYw0KKysrIGIvZHJpdmVycy91c2Iv
Z2FkZ2V0L3VkYy9iZGMvYmRjX3VkYy5jDQpAQCAtMTY0LDcgKzE2NCw3IEBAIHN0YXRpYyB2b2lk
IGJkY19mdW5jX3dha2VfdGltZXIoc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQ0KIAkvKg0KIAkg
KiBDaGVjayBpZiBob3N0IGhhcyBzdGFydGVkIHRyYW5zZmVycmluZyBvbiBlbmRwb2ludHMNCiAJ
ICogRlVOQ19XQUtFX0lTU1VFRCBpcyBjbGVhcmVkIHdoZW4gdHJhbnNmZXIgaGFzIHN0YXJ0ZWQg
YWZ0ZXIgcmVzdW1lDQotCSovDQorCSAqLw0KIAlpZiAoYmRjLT5kZXZzdGF0dXMgJiBGVU5DX1dB
S0VfSVNTVUVEKSB7DQogCQlkZXZfZGJnKGJkYy0+ZGV2LCAiRlVOQ19XQUtFX0lTU1VFRCBGTEFH
IElTIFNUSUxMIFNFVFxuIik7DQogCQkvKiBmbGFnIGlzIHN0aWxsIHNldCwgc28gYWdhaW4gc2Vu
ZCBmdW5jIHdha2UgKi8NCkBAIC0yMDUsNyArMjA1LDcgQEAgc3RhdGljIHZvaWQgaGFuZGxlX2xp
bmtfc3RhdGVfY2hhbmdlKHN0cnVjdCBiZGMgKmJkYywgdTMyIHVzcGMpDQogCQkJCSAqIGlmIG5v
dCB0aGVuIHNlbmQgZnVuY3Rpb24gd2FrZSBhZ2FpbiBldmVyeQ0KIAkJCQkgKiBUTm90aWZpY2F0
aW9uIHNlY3MgdW50aWwgaG9zdCBpbml0aWF0ZXMNCiAJCQkJICogdHJhbnNmZXIgdG8gQkRDLCBV
U0IzIHNwZWMgVGFibGUgOC4xMw0KLQkJCQkqLw0KKwkJCQkgKi8NCiAJCQkJc2NoZWR1bGVfZGVs
YXllZF93b3JrKA0KIAkJCQkJCSZiZGMtPmZ1bmNfd2FrZV9ub3RpZnksDQogCQkJCQkJbXNlY3Nf
dG9famlmZmllcyhCRENfVE5PVElGWSkpOw0KQEAgLTM3OSw3ICszNzksNyBAQCBzdGF0aWMgaW50
IGJkY191ZGNfc3RhcnQoc3RydWN0IHVzYl9nYWRnZXQgKmdhZGdldCwNCiAJICogUnVuIHRoZSBj
b250cm9sbGVyIGZyb20gaGVyZSBhbmQgd2hlbiBCREMgaXMgY29ubmVjdGVkIHRvDQogCSAqIEhv
c3QgdGhlbiBkcml2ZXIgd2lsbCByZWNlaXZlIGEgVVNQQyBTUiB3aXRoIFZCVVMgcHJlc2VudA0K
IAkgKiBhbmQgdGhlbiBkcml2ZXIgd2lsbCBkbyBhIHNvZnRjb25uZWN0Lg0KLQkqLw0KKwkgKi8N
CiAJcmV0ID0gYmRjX3J1bihiZGMpOw0KIAlpZiAocmV0KSB7DQogCQlkZXZfZXJyKGJkYy0+ZGV2
LCAiJXMgYmRjIHJ1biBmYWlsXG4iLCBfX2Z1bmNfXyk7DQotLSANCjEuOS4xDQo=

