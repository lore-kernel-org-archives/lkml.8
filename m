Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47E29C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 11:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E816204EA
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 11:34:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="JHB29HqJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730703AbgHTLek (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 07:34:40 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:28876 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730644AbgHTLcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 07:32:51 -0400
X-UUID: 4b3863a1b24a441f852a3a7e30223cf4-20200820
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=njMU5VLie19Pssvi8+YgppuDMCXfmQYubWzISF4gV9Y=;
        b=JHB29HqJeuONQDk4mRL0MZeIudsGcDE6G6+Kbw/6yfT96wsm4leIUu5X9bUK6el/6BSRlu/dV6fCcjxLIcnCK0uYWRiiWBFmYw/ee4lX+sHGwUGWDf9jQhBgPzrmQVoxRKhKCTU/JEW7RYJCvU+NOoWqv9xKLEKiUJxxQengucM=;
X-UUID: 4b3863a1b24a441f852a3a7e30223cf4-20200820
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1629179673; Thu, 20 Aug 2020 19:32:35 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 20 Aug 2020 19:32:35 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 20 Aug 2020 19:32:32 +0800
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
Subject: [PATCH v2 11/11] usb: gadget: bdc: fix checkpatch.pl repeated word warning
Date:   Thu, 20 Aug 2020 19:30:46 +0800
Message-ID: <1597923046-12535-11-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1597923046-12535-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1597923046-12535-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: B3585BA57539BB1FE94948FEBFECC89BEB16E80F879A3BED4E0C2E2CE777E7A62000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zml4IHRoZSB3YXJuaW5nOg0KV0FSTklORzpSRVBFQVRFRF9XT1JEOiBQb3NzaWJsZSByZXBlYXRl
ZCB3b3JkOiAnYW5kJw0KDQpDYzogRmxvcmlhbiBGYWluZWxsaSA8Zi5mYWluZWxsaUBnbWFpbC5j
b20+DQpTaWduZWQtb2ZmLWJ5OiBDaHVuZmVuZyBZdW4gPGNodW5mZW5nLnl1bkBtZWRpYXRlay5j
b20+DQotLS0NCnYyOiBuZXcgcGF0Y2gNCi0tLQ0KIGRyaXZlcnMvdXNiL2dhZGdldC91ZGMvYmRj
L2JkY19lcC5jIHwgMiArLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxl
dGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9iZGMvYmRjX2Vw
LmMgYi9kcml2ZXJzL3VzYi9nYWRnZXQvdWRjL2JkYy9iZGNfZXAuYw0KaW5kZXggZDIyN2QyNi4u
OGUyZjIwYiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvdXNiL2dhZGdldC91ZGMvYmRjL2JkY19lcC5j
DQorKysgYi9kcml2ZXJzL3VzYi9nYWRnZXQvdWRjL2JkYy9iZGNfZXAuYw0KQEAgLTE0MDUsNyAr
MTQwNSw3IEBAIHN0YXRpYyBpbnQgZXAwX3NldF9zZWwoc3RydWN0IGJkYyAqYmRjLA0KIH0NCiAN
CiAvKg0KLSAqIFF1ZXVlIGEgMCBieXRlIGJkIG9ubHkgaWYgd0xlbmd0aCBpcyBtb3JlIHRoYW4g
dGhlIGxlbmd0aCBhbmQgYW5kIGxlbmd0aCBpcw0KKyAqIFF1ZXVlIGEgMCBieXRlIGJkIG9ubHkg
aWYgd0xlbmd0aCBpcyBtb3JlIHRoYW4gdGhlIGxlbmd0aCBhbmQgbGVuZ3RoIGlzDQogICogYSBt
dWx0aXBsZSBvZiBNYXhQYWNrZXQgdGhlbiBxdWV1ZSAwIGJ5dGUgQkQNCiAgKi8NCiBzdGF0aWMg
aW50IGVwMF9xdWV1ZV96bHAoc3RydWN0IGJkYyAqYmRjKQ0KLS0gDQoxLjkuMQ0K

