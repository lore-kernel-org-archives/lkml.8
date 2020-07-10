Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CBCDC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 02:30:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29C522073A
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 02:30:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="rD3EhzO4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbgGJCas (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 22:30:48 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:47983 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726446AbgGJCar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 22:30:47 -0400
X-UUID: 593811f480164a9ea9c7c0c594f73d8b-20200710
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=Kd0C+S4Ayp+24088Gsa5JiqqukKJHb4/Z3Dk20GZNaA=;
        b=rD3EhzO4i+X+SbryJ8Nm4eTbBaXYYDXu/tvU8MWyfwbbt6SFX+bDQ7T9+y8sUZZt20w+Jy8gtnFuOU8S3pMx6rqZ9eMXUPRzIa6WbTT4zM5UTMUhQaqpFmfyB/b+o//4CTXqbSZ7hEUfRXKGtuKmJyhBt9EH/c688eN6j3rIG1s=;
X-UUID: 593811f480164a9ea9c7c0c594f73d8b-20200710
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 299434186; Fri, 10 Jul 2020 10:30:26 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 10 Jul 2020 10:30:19 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 10 Jul 2020 10:30:18 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Mathias Nyman <mathias.nyman@intel.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        stable <stable@vger.kernel.org>
Subject: [PATCH] usb: xhci-mtk: fix the failure of bandwidth allocation
Date:   Fri, 10 Jul 2020 10:29:42 +0800
Message-ID: <1594348182-431-1-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 3E47718F58DC4962AF1F31FFDB8BDCC6908A18FE5C4F4A0FE152DF2C456BC00A2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIHdNYXhQYWNrZXRTaXplIGZpZWxkIG9mIGVuZHBvaW50IGRlc2NyaXB0b3IgbWF5IGJlIHpl
cm8NCmFzIGRlZmF1bHQgdmFsdWUgaW4gYWx0ZXJuYXRlIGludGVyZmFjZSwgYW5kIHRoZXkgYXJl
IG5vdA0KYWN0dWFsbHkgc2VsZWN0ZWQgd2hlbiBzdGFydCBzdHJlYW0sIHNvIHNraXAgdGhlbSB3
aGVuIHRyeSB0bw0KYWxsb2NhdGUgYmFuZHdpZHRoLg0KDQpDYzogc3RhYmxlIDxzdGFibGVAdmdl
ci5rZXJuZWwub3JnPg0KU2lnbmVkLW9mZi1ieTogQ2h1bmZlbmcgWXVuIDxjaHVuZmVuZy55dW5A
bWVkaWF0ZWsuY29tPg0KLS0tDQogZHJpdmVycy91c2IvaG9zdC94aGNpLW10ay1zY2guYyB8IDQg
KysrKw0KIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvdXNiL2hvc3QveGhjaS1tdGstc2NoLmMgYi9kcml2ZXJzL3VzYi9ob3N0L3hoY2ktbXRr
LXNjaC5jDQppbmRleCBmZWE1NTU1Li40NWM1NGQ1NiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvdXNi
L2hvc3QveGhjaS1tdGstc2NoLmMNCisrKyBiL2RyaXZlcnMvdXNiL2hvc3QveGhjaS1tdGstc2No
LmMNCkBAIC01NTcsNiArNTU3LDEwIEBAIHN0YXRpYyBib29sIG5lZWRfYndfc2NoKHN0cnVjdCB1
c2JfaG9zdF9lbmRwb2ludCAqZXAsDQogCWlmIChpc19mc19vcl9scyhzcGVlZCkgJiYgIWhhc190
dCkNCiAJCXJldHVybiBmYWxzZTsNCiANCisJLyogc2tpcCBlbmRwb2ludCB3aXRoIHplcm8gbWF4
cGt0ICovDQorCWlmICh1c2JfZW5kcG9pbnRfbWF4cCgmZXAtPmRlc2MpID09IDApDQorCQlyZXR1
cm4gZmFsc2U7DQorDQogCXJldHVybiB0cnVlOw0KIH0NCiANCi0tIA0KMS45LjENCg==

