Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2912C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 07:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EEA121D7A
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 07:36:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="qxGHjAVb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730181AbgIIHgG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 03:36:06 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:26086 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729988AbgIIHf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 03:35:27 -0400
X-UUID: 66595f5a557545cca39de80a36e219d4-20200909
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=7kJllcDXjClhWfBJ3mveoC+PnCLMneF842iGb2qp2Wo=;
        b=qxGHjAVbtNIM0frtJhDCuMS97aS1IoQzP9e23MXXWwJ4SI3+VmTbWzMmhN7iYiNVLJXi0uj0u0gJGjg8y64QdjI10hjitdKRqIKxFNO6OH5UPHZqYcV2wpYkfb+ioJn6K+3lpdIX+NyqICxpv1mV/tVRQvdRV+J0A/FlrvRSlho=;
X-UUID: 66595f5a557545cca39de80a36e219d4-20200909
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 414397883; Wed, 09 Sep 2020 15:35:21 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 9 Sep 2020 15:35:20 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 9 Sep 2020 15:35:19 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Al Cooper <alcooperx@gmail.com>,
        Peter Chen <peter.chen@nxp.com>, Bin Liu <b-liu@ti.com>,
        Sasi Kumar <sasi.kumar@broadcom.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v3 11/11] usb: gadget: bdc: fix checkpatch.pl repeated word warning
Date:   Wed, 9 Sep 2020 15:33:02 +0800
Message-ID: <1599636782-7654-11-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1599636782-7654-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1599636782-7654-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 7351457B0BF9B100B31E285DFAF2B32DB4786900857DD269C1659C297629351B2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zml4IHRoZSB3YXJuaW5nOg0KV0FSTklORzpSRVBFQVRFRF9XT1JEOiBQb3NzaWJsZSByZXBlYXRl
ZCB3b3JkOiAnYW5kJw0KDQpDYzogRmxvcmlhbiBGYWluZWxsaSA8Zi5mYWluZWxsaUBnbWFpbC5j
b20+DQpTaWduZWQtb2ZmLWJ5OiBDaHVuZmVuZyBZdW4gPGNodW5mZW5nLnl1bkBtZWRpYXRlay5j
b20+DQpBY2tlZC1ieTogRmxvcmlhbiBGYWluZWxsaSA8Zi5mYWluZWxsaUBnbWFpbC5jb20+DQot
LS0NCnYzOiBhZGQgYWNrZWQtYnkgRmxvcmlhbg0KDQp2MjogYWRkIENjIEZsb3JpYW4NCi0tLQ0K
IGRyaXZlcnMvdXNiL2dhZGdldC91ZGMvYmRjL2JkY19lcC5jIHwgMiArLQ0KIDEgZmlsZSBjaGFu
Z2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy91c2IvZ2FkZ2V0L3VkYy9iZGMvYmRjX2VwLmMgYi9kcml2ZXJzL3VzYi9nYWRnZXQvdWRjL2Jk
Yy9iZGNfZXAuYw0KaW5kZXggZDIyN2QyNi4uOGUyZjIwYiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMv
dXNiL2dhZGdldC91ZGMvYmRjL2JkY19lcC5jDQorKysgYi9kcml2ZXJzL3VzYi9nYWRnZXQvdWRj
L2JkYy9iZGNfZXAuYw0KQEAgLTE0MDUsNyArMTQwNSw3IEBAIHN0YXRpYyBpbnQgZXAwX3NldF9z
ZWwoc3RydWN0IGJkYyAqYmRjLA0KIH0NCiANCiAvKg0KLSAqIFF1ZXVlIGEgMCBieXRlIGJkIG9u
bHkgaWYgd0xlbmd0aCBpcyBtb3JlIHRoYW4gdGhlIGxlbmd0aCBhbmQgYW5kIGxlbmd0aCBpcw0K
KyAqIFF1ZXVlIGEgMCBieXRlIGJkIG9ubHkgaWYgd0xlbmd0aCBpcyBtb3JlIHRoYW4gdGhlIGxl
bmd0aCBhbmQgbGVuZ3RoIGlzDQogICogYSBtdWx0aXBsZSBvZiBNYXhQYWNrZXQgdGhlbiBxdWV1
ZSAwIGJ5dGUgQkQNCiAgKi8NCiBzdGF0aWMgaW50IGVwMF9xdWV1ZV96bHAoc3RydWN0IGJkYyAq
YmRjKQ0KLS0gDQoxLjkuMQ0K

