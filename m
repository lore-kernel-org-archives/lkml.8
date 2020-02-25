Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7CEDC35DF9
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 11:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C68A2176D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 11:30:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ZXwc9La5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730522AbgBYLab (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 06:30:31 -0500
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:10394 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730080AbgBYLa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 06:30:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1582630229; x=1614166229;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=Y18lRdpyXiwYObjGQvYRFfjRCEL3pvNNrmgKJkofLnA=;
  b=ZXwc9La5crbl8NtmmnnNIiqdIBeVjvJnXdu/fyxQWOBf9owe/QhWb3jZ
   V4GqdrkSNdPdCA0pzDOdd4FMGBSgl4ASwPA1anaGVrtq7gDtm43fuR1UX
   aF/6RylXXwPH2ZRuyPxYegbAeJoba4zbJvxtp3tiheTWNj77IqV/p1PDa
   g=;
IronPort-SDR: f2KkIDTUHo+ElgMxhkhQO3mKtxttw/b3GGHKq1YjxHDbYHXAUx5+1jjm3d8DiAH//dcJJ8cVJY
 2oUb6Tys7Dfw==
X-IronPort-AV: E=Sophos;i="5.70,483,1574121600"; 
   d="scan'208";a="18764774"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1d-37fd6b3d.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 25 Feb 2020 11:30:17 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1d-37fd6b3d.us-east-1.amazon.com (Postfix) with ESMTPS id 21B892854B7;
        Tue, 25 Feb 2020 11:30:12 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Tue, 25 Feb 2020 11:30:12 +0000
Received: from u8a88181e7b2355.ant.amazon.com (10.43.162.50) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 25 Feb 2020 11:30:02 +0000
From:   Hanna Hawa <hhhawa@amazon.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <tsahee@annapurnalabs.com>, <antoine.tenart@bootlin.com>,
        <hhhawa@amazon.com>, <mchehab+samsung@kernel.org>,
        <davem@davemloft.net>, <gregkh@linuxfoundation.org>,
        <Jonathan.Cameron@huawei.com>, <tglx@linutronix.de>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <dwmw@amazon.co.uk>,
        <benh@amazon.com>, <ronenk@amazon.com>, <talel@amazon.com>,
        <jonnyc@amazon.com>, <hanochu@amazon.com>, <eitan@amazon.com>
Subject: [PATCH v4 2/6] arm64: dts: amazon: rename al folder to be amazon
Date:   Tue, 25 Feb 2020 13:29:22 +0200
Message-ID: <20200225112926.16518-3-hhhawa@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200225112926.16518-1-hhhawa@amazon.com>
References: <20200225112926.16518-1-hhhawa@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.50]
X-ClientProxiedBy: EX13D02UWB002.ant.amazon.com (10.43.161.160) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As preparation to add device tree binding for Amazon's Annapurna Labs
Alpine v3 support. Rename al device tree folder to be amazon.

Signed-off-by: Hanna Hawa <hhhawa@amazon.com>
---
 MAINTAINERS                                          | 2 +-
 arch/arm64/boot/dts/Makefile                         | 2 +-
 arch/arm64/boot/dts/{al => amazon}/Makefile          | 0
 arch/arm64/boot/dts/{al => amazon}/alpine-v2-evp.dts | 0
 arch/arm64/boot/dts/{al => amazon}/alpine-v2.dtsi    | 0
 5 files changed, 2 insertions(+), 2 deletions(-)
 rename arch/arm64/boot/dts/{al => amazon}/Makefile (100%)
 rename arch/arm64/boot/dts/{al => amazon}/alpine-v2-evp.dts (100%)
 rename arch/arm64/boot/dts/{al => amazon}/alpine-v2.dtsi (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index a0d86490c2c6..2ddb1b9d3a8f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1553,7 +1553,7 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	arch/arm/mach-alpine/
 F:	arch/arm/boot/dts/alpine*
-F:	arch/arm64/boot/dts/al/
+F:	arch/arm64/boot/dts/amazon/*
 F:	drivers/*/*alpine*
 
 ARM/ARTPEC MACHINE SUPPORT
diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
index f19b762c008d..6f3e1556ce42 100644
--- a/arch/arm64/boot/dts/Makefile
+++ b/arch/arm64/boot/dts/Makefile
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 subdir-y += actions
-subdir-y += al
 subdir-y += allwinner
 subdir-y += altera
+subdir-y += amazon
 subdir-y += amd
 subdir-y += amlogic
 subdir-y += apm
diff --git a/arch/arm64/boot/dts/al/Makefile b/arch/arm64/boot/dts/amazon/Makefile
similarity index 100%
rename from arch/arm64/boot/dts/al/Makefile
rename to arch/arm64/boot/dts/amazon/Makefile
diff --git a/arch/arm64/boot/dts/al/alpine-v2-evp.dts b/arch/arm64/boot/dts/amazon/alpine-v2-evp.dts
similarity index 100%
rename from arch/arm64/boot/dts/al/alpine-v2-evp.dts
rename to arch/arm64/boot/dts/amazon/alpine-v2-evp.dts
diff --git a/arch/arm64/boot/dts/al/alpine-v2.dtsi b/arch/arm64/boot/dts/amazon/alpine-v2.dtsi
similarity index 100%
rename from arch/arm64/boot/dts/al/alpine-v2.dtsi
rename to arch/arm64/boot/dts/amazon/alpine-v2.dtsi
-- 
2.17.1

