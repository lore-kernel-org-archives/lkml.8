Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 392A1C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 12:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A4D2206B5
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 12:47:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="symRFg/p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728538AbgHSMrk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 08:47:40 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:25570 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726609AbgHSMm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 08:42:59 -0400
X-UUID: 79ff25f0d61c4b9883b1d62e2c45dbe1-20200819
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=gbEvkNvLGl7XkhJbIl8Am9oqDys+ugPHHJ4cNwALPbg=;
        b=symRFg/pIqoSot9Y2muUGLgHLRU5BFlxhtrrtLlDiRT0puX2QLaDnYPRIZ5IOedhljC+9Yavplcf/8fh6m3N/L+Wnmlm+GVDQ0R99JXCXtlZ8YN6vzQnjGyCsz/JOCPLRi9Fc1opUf1WVuUa2lWoVEKcUFYRWTIg3qLEoEFWJOM=;
X-UUID: 79ff25f0d61c4b9883b1d62e2c45dbe1-20200819
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 719342549; Wed, 19 Aug 2020 20:42:46 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 19 Aug 2020 20:42:44 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 19 Aug 2020 20:42:43 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Felipe Balbi <balbi@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Lee Jones <lee.jones@linaro.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH 02/10] usb: early: ehci-dbgp: convert to readl_poll_timeout_atomic()
Date:   Wed, 19 Aug 2020 20:40:57 +0800
Message-ID: <1597840865-26631-2-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1597840865-26631-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1597840865-26631-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 65E32546313909D0757CC1C22E12E8B6E09145F4B7102037ADFB3A642D9C03412000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VXNlIHJlYWRsX3BvbGxfdGltZW91dF9hdG9taWMoKSB0byBzaW1wbGlmeSBjb2RlDQoNCkNjOiAi
RXJpYyBXLiBCaWVkZXJtYW4iIDxlYmllZGVybUB4bWlzc2lvbi5jb20+DQpDYzogUGV0ciBNbGFk
ZWsgPHBtbGFkZWtAc3VzZS5jb20+DQpTaWduZWQtb2ZmLWJ5OiBDaHVuZmVuZyBZdW4gPGNodW5m
ZW5nLnl1bkBtZWRpYXRlay5jb20+DQotLS0NCiBkcml2ZXJzL3VzYi9lYXJseS9laGNpLWRiZ3Au
YyB8IDE1ICsrKysrLS0tLS0tLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyks
IDEwIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZWFybHkvZWhjaS1k
YmdwLmMgYi9kcml2ZXJzL3VzYi9lYXJseS9laGNpLWRiZ3AuYw0KaW5kZXggYjA3NWRiZi4uNDVi
NDJkOCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvdXNiL2Vhcmx5L2VoY2ktZGJncC5jDQorKysgYi9k
cml2ZXJzL3VzYi9lYXJseS9laGNpLWRiZ3AuYw0KQEAgLTE1LDYgKzE1LDcgQEANCiAjaW5jbHVk
ZSA8bGludXgvY29uc29sZS5oPg0KICNpbmNsdWRlIDxsaW51eC9lcnJuby5oPg0KICNpbmNsdWRl
IDxsaW51eC9pbml0Lmg+DQorI2luY2x1ZGUgPGxpbnV4L2lvcG9sbC5oPg0KICNpbmNsdWRlIDxs
aW51eC9wY2lfcmVncy5oPg0KICNpbmNsdWRlIDxsaW51eC9wY2lfaWRzLmg+DQogI2luY2x1ZGUg
PGxpbnV4L3VzYi9jaDkuaD4NCkBAIC0xNjEsMTcgKzE2MiwxMSBAQCBzdGF0aWMgaW5saW5lIHUz
MiBkYmdwX3BpZF9yZWFkX3VwZGF0ZSh1MzIgeCwgdTMyIHRvaykNCiBzdGF0aWMgaW50IGRiZ3Bf
d2FpdF91bnRpbF9jb21wbGV0ZSh2b2lkKQ0KIHsNCiAJdTMyIGN0cmw7DQotCWludCBsb29wID0g
REJHUF9USU1FT1VUOw0KLQ0KLQlkbyB7DQotCQljdHJsID0gcmVhZGwoJmVoY2lfZGVidWctPmNv
bnRyb2wpOw0KLQkJLyogU3RvcCB3aGVuIHRoZSB0cmFuc2FjdGlvbiBpcyBmaW5pc2hlZCAqLw0K
LQkJaWYgKGN0cmwgJiBEQkdQX0RPTkUpDQotCQkJYnJlYWs7DQotCQl1ZGVsYXkoMSk7DQotCX0g
d2hpbGUgKC0tbG9vcCA+IDApOw0KKwlpbnQgcmV0Ow0KIA0KLQlpZiAoIWxvb3ApDQorCXJldCA9
IHJlYWRsX3BvbGxfdGltZW91dF9hdG9taWMoJmVoY2lfZGVidWctPmNvbnRyb2wsIGN0cmwsDQor
CQkJCShjdHJsICYgREJHUF9ET05FKSwgMSwgREJHUF9USU1FT1VUKTsNCisJaWYgKHJldCkNCiAJ
CXJldHVybiAtREJHUF9USU1FT1VUOw0KIA0KIAkvKg0KLS0gDQoxLjkuMQ0K

