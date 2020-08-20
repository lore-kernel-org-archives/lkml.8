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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16CF3C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 11:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9B812054F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 11:36:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="WI3BQN4Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730832AbgHTLgV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 07:36:21 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:4403 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730642AbgHTLcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 07:32:51 -0400
X-UUID: 94bd5b9b326e41dd938cb80ab2badc11-20200820
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=m+feIzoxmVh/rpojFXIO/46K7IKQp577LdVaN5g9Kgk=;
        b=WI3BQN4Qm9TSHYIKutq+MOYyk0Fz44Z3gr3W4Ama0ArJza75oFXd8xbyYm0uU2G5zK/j31nK5o7a0ATUllYj+7R3TVufny51bI6v1CQcD9BSYJMFECukYxKEdvQt729xTy6hm1RmDFEHnnXypb/PmVqxYTtWXq8+PLj4F6IJurk=;
X-UUID: 94bd5b9b326e41dd938cb80ab2badc11-20200820
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 247379420; Thu, 20 Aug 2020 19:32:34 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 MTKMBS31DR.mediatek.inc (172.27.6.102) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 20 Aug 2020 19:32:32 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 20 Aug 2020 19:32:31 +0800
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
Subject: [PATCH v2 10/11] usb: gadget: bdc: fix checkpatch.pl spacing error
Date:   Thu, 20 Aug 2020 19:30:45 +0800
Message-ID: <1597923046-12535-10-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1597923046-12535-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1597923046-12535-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: DA0077A36905A036A6B1B690539D9BEF31E9E68607BF9D933E127EFEED5B6E202000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zml4IGNoZWNrcGF0Y2gucGwgZXJyb3I6DQpFUlJPUjpTUEFDSU5HOiBzcGFjZSBwcm9oaWJpdGVk
IGJlZm9yZSB0aGF0ICcsJw0KDQpDYzogRmxvcmlhbiBGYWluZWxsaSA8Zi5mYWluZWxsaUBnbWFp
bC5jb20+DQpTaWduZWQtb2ZmLWJ5OiBDaHVuZmVuZyBZdW4gPGNodW5mZW5nLnl1bkBtZWRpYXRl
ay5jb20+DQotLS0NCnYyOiBuZXcgcGF0Y2gNCi0tLQ0KIGRyaXZlcnMvdXNiL2dhZGdldC91ZGMv
YmRjL2JkY191ZGMuYyB8IDIgKy0NCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEg
ZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2dhZGdldC91ZGMvYmRjL2Jk
Y191ZGMuYyBiL2RyaXZlcnMvdXNiL2dhZGdldC91ZGMvYmRjL2JkY191ZGMuYw0KaW5kZXggMGMx
YWI5NS4uNWFjMGVmOCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvdXNiL2dhZGdldC91ZGMvYmRjL2Jk
Y191ZGMuYw0KKysrIGIvZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9iZGMvYmRjX3VkYy5jDQpAQCAt
NTMwLDcgKzUzMCw3IEBAIGludCBiZGNfdWRjX2luaXQoc3RydWN0IGJkYyAqYmRjKQ0KIA0KIAli
ZGMtPmdhZGdldC5uYW1lID0gQlJDTV9CRENfTkFNRTsNCiAJcmV0ID0gZGV2bV9yZXF1ZXN0X2ly
cShiZGMtPmRldiwgYmRjLT5pcnEsIGJkY191ZGNfaW50ZXJydXB0LA0KLQkJCQlJUlFGX1NIQVJF
RCAsIEJSQ01fQkRDX05BTUUsIGJkYyk7DQorCQkJCUlSUUZfU0hBUkVELCBCUkNNX0JEQ19OQU1F
LCBiZGMpOw0KIAlpZiAocmV0KSB7DQogCQlkZXZfZXJyKGJkYy0+ZGV2LA0KIAkJCSJmYWlsZWQg
dG8gcmVxdWVzdCBpcnEgIyVkICVkXG4iLA0KLS0gDQoxLjkuMQ0K

