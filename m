Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4EE7C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 08:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A650207FC
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 08:06:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="VMtoT5tr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731195AbgFSIG1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 04:06:27 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:56863 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731182AbgFSIGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 04:06:10 -0400
X-UUID: 0ab067a9cefc4a51ace661c1274da56a-20200619
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=W1LOndusl+hI8qr6PnjPnMVG0Xt0LgOh2kjlUuxSIlM=;
        b=VMtoT5tr4JljExfIqY2eJH5+25Btl9MG9FUYvhtEhuBgPZ8oKVoN8pR1qzbQRvwK9MxB4I1pkv6433pUgRsVpZdqWcKLSvgRWWVPuUiyM5EC9hmVEyy1oVTGcuAoMwZ8PbUYu6rV7CeNi1QI8oTSD/7a61AZLo7m0kdVysoZBDA=;
X-UUID: 0ab067a9cefc4a51ace661c1274da56a-20200619
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <eastl.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 477579277; Fri, 19 Jun 2020 16:06:06 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 19 Jun 2020 16:05:08 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 19 Jun 2020 16:05:09 +0800
From:   EastL <EastL.Lee@mediatek.com>
To:     Sean Wang <sean.wang@mediatek.com>
CC:     <vkoul@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <matthias.bgg@gmail.com>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>, EastL <EastL.Lee@mediatek.com>
Subject: [PATCH v5 4/4] dmaengine: mediatek-cqdma: fix compatible
Date:   Fri, 19 Jun 2020 16:05:02 +0800
Message-ID: <1592553902-30592-5-git-send-email-EastL.Lee@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1592553902-30592-1-git-send-email-EastL.Lee@mediatek.com>
References: <1592553902-30592-1-git-send-email-EastL.Lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 58ED8B8D4A56CF4C1ECAA6613447FE08CC9F96345E443B1B0F182794823BBC192000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBwYXRjaCBhZGRzIGNvbW1vbiBjb21wYXRpYmxlICYgcGxhdGZvcm0gY29tcGF0aWFibGUu
DQoNClNpZ25lZC1vZmYtYnk6IEVhc3RMIDxFYXN0TC5MZWVAbWVkaWF0ZWsuY29tPg0KLS0tDQog
ZHJpdmVycy9kbWEvbWVkaWF0ZWsvbXRrLWNxZG1hLmMgfCAyICsrDQogMSBmaWxlIGNoYW5nZWQs
IDIgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9kbWEvbWVkaWF0ZWsvbXRr
LWNxZG1hLmMgYi9kcml2ZXJzL2RtYS9tZWRpYXRlay9tdGstY3FkbWEuYw0KaW5kZXggZWQzM2M2
NC4uZDcwMWViZiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZG1hL21lZGlhdGVrL210ay1jcWRtYS5j
DQorKysgYi9kcml2ZXJzL2RtYS9tZWRpYXRlay9tdGstY3FkbWEuYw0KQEAgLTU0Niw3ICs1NDYs
OSBAQCBzdGF0aWMgdm9pZCBtdGtfY3FkbWFfaHdfZGVpbml0KHN0cnVjdCBtdGtfY3FkbWFfZGV2
aWNlICpjcWRtYSkNCiB9DQogDQogc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgbXRr
X2NxZG1hX21hdGNoW10gPSB7DQorCXsgLmNvbXBhdGlibGUgPSAibWVkaWF0ZWssY29tbW9uLWNx
ZG1hIiB9LA0KIAl7IC5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10Njc2NS1jcWRtYSIgfSwNCisJ
eyAuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDY3NzktY3FkbWEiIH0sDQogCXsgLyogc2VudGlu
ZWwgKi8gfQ0KIH07DQogTU9EVUxFX0RFVklDRV9UQUJMRShvZiwgbXRrX2NxZG1hX21hdGNoKTsN
Ci0tIA0KMS45LjENCg==

