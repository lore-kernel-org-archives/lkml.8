Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F553C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 07:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5ECFE21D7E
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 07:36:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="SwZ089TQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730021AbgIIHgM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 03:36:12 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:28291 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729971AbgIIHf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 03:35:26 -0400
X-UUID: d7f1e20e2c6043af8e2ee9b264d8d204-20200909
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=kYSGke9KlqBn4Imn3VxXZ1Ao1jgfddQziSV2EmrSBz4=;
        b=SwZ089TQAmCan6kSIv73VHMvwT2I66CAOuGuHAq/kPoRSuqvumzBxpHWOWN3gt5G3LIUS/nWx2OSMtmAf7vpHsvkm7ErB5IcpSmoCbpYRqvM01MvpXWAoxuTSsMdxpLEZiU+rsDiktzoS7Mv37+3hvDRZEChll7bZuc7ofIZsi4=;
X-UUID: d7f1e20e2c6043af8e2ee9b264d8d204-20200909
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1162846398; Wed, 09 Sep 2020 15:35:20 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 9 Sep 2020 15:35:18 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 9 Sep 2020 15:35:17 +0800
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
Subject: [PATCH v3 10/11] usb: gadget: bdc: fix checkpatch.pl spacing error
Date:   Wed, 9 Sep 2020 15:33:01 +0800
Message-ID: <1599636782-7654-10-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1599636782-7654-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1599636782-7654-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 3EC7F3F1EA99057C5B01C47FFF25288EE5244D33AFA4D21629A34C6A59D474342000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zml4IGNoZWNrcGF0Y2gucGwgZXJyb3I6DQpFUlJPUjpTUEFDSU5HOiBzcGFjZSBwcm9oaWJpdGVk
IGJlZm9yZSB0aGF0ICcsJw0KDQpDYzogRmxvcmlhbiBGYWluZWxsaSA8Zi5mYWluZWxsaUBnbWFp
bC5jb20+DQpTaWduZWQtb2ZmLWJ5OiBDaHVuZmVuZyBZdW4gPGNodW5mZW5nLnl1bkBtZWRpYXRl
ay5jb20+DQpBY2tlZC1ieTogRmxvcmlhbiBGYWluZWxsaSA8Zi5mYWluZWxsaUBnbWFpbC5jb20+
DQotLS0NCnYzOiBhZGQgYWNrZWQtYnkgRmxvcmlhbg0KDQp2MjogYWRkIENjIEZsb3JpYW4NCi0t
LQ0KIGRyaXZlcnMvdXNiL2dhZGdldC91ZGMvYmRjL2JkY191ZGMuYyB8IDIgKy0NCiAxIGZpbGUg
Y2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvdXNiL2dhZGdldC91ZGMvYmRjL2JkY191ZGMuYyBiL2RyaXZlcnMvdXNiL2dhZGdldC91
ZGMvYmRjL2JkY191ZGMuYw0KaW5kZXggMGMxYWI5NS4uNWFjMGVmOCAxMDA2NDQNCi0tLSBhL2Ry
aXZlcnMvdXNiL2dhZGdldC91ZGMvYmRjL2JkY191ZGMuYw0KKysrIGIvZHJpdmVycy91c2IvZ2Fk
Z2V0L3VkYy9iZGMvYmRjX3VkYy5jDQpAQCAtNTMwLDcgKzUzMCw3IEBAIGludCBiZGNfdWRjX2lu
aXQoc3RydWN0IGJkYyAqYmRjKQ0KIA0KIAliZGMtPmdhZGdldC5uYW1lID0gQlJDTV9CRENfTkFN
RTsNCiAJcmV0ID0gZGV2bV9yZXF1ZXN0X2lycShiZGMtPmRldiwgYmRjLT5pcnEsIGJkY191ZGNf
aW50ZXJydXB0LA0KLQkJCQlJUlFGX1NIQVJFRCAsIEJSQ01fQkRDX05BTUUsIGJkYyk7DQorCQkJ
CUlSUUZfU0hBUkVELCBCUkNNX0JEQ19OQU1FLCBiZGMpOw0KIAlpZiAocmV0KSB7DQogCQlkZXZf
ZXJyKGJkYy0+ZGV2LA0KIAkJCSJmYWlsZWQgdG8gcmVxdWVzdCBpcnEgIyVkICVkXG4iLA0KLS0g
DQoxLjkuMQ0K

