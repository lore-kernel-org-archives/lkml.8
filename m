Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98840C433EC
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 13:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7499A2065F
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 13:28:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="bJ5kL+i0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbgGXN2A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 09:28:00 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:11628 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbgGXN17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 09:27:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1595597279; x=1627133279;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=jiBED/qU0WfrVe5JHqH3esduDiXycmbKiIlVxb/Xlso=;
  b=bJ5kL+i0Adepzm88MRfM3Hb9ShU4CWHMEPkmLCaqQPEfs0p84ZKcBqvy
   wtQHcXDRiEze6CG45WyYbSI6d4Q/X8miBElGaMmVUdBqmnXN2kgLHEi/O
   VO4vlaeOGVIVaQ34HWJES+yZemJbeI653muJYSD4abRec+2lSf7ROgStZ
   Y=;
IronPort-SDR: OrL5WHGwaC06TpkOgdvHva1W9WG3kf1ybkYWVccDs5SFowNQZ7aNHHyJZTWeGUUCvar9HrZth2
 yY3BnT1bfSxw==
X-IronPort-AV: E=Sophos;i="5.75,390,1589241600"; 
   d="scan'208";a="43707813"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2a-60ce1996.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 24 Jul 2020 13:27:57 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2a-60ce1996.us-west-2.amazon.com (Postfix) with ESMTPS id D7C7BA3994;
        Fri, 24 Jul 2020 13:27:55 +0000 (UTC)
Received: from EX13D19EUB001.ant.amazon.com (10.43.166.229) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 24 Jul 2020 13:27:55 +0000
Received: from u8a88181e7b2355.ant.amazon.com (10.43.160.65) by
 EX13D19EUB001.ant.amazon.com (10.43.166.229) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 24 Jul 2020 13:27:47 +0000
From:   Hanna Hawa <hhhawa@amazon.com>
To:     <arnd@arndb.de>, <robh+dt@kernel.org>, <tsahee@annapurnalabs.com>,
        <antoine.tenart@bootlin.com>, <mchehab+huawei@kernel.org>,
        <davem@davemloft.net>
List-Id: <soc.lore.kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <arm@kernel.org>,
        <soc@kernel.org>, <dwmw@amazon.co.uk>, <benh@amazon.com>,
        <ronenk@amazon.com>, <talel@amazon.com>, <jonnyc@amazon.com>,
        <hanochu@amazon.com>, <eitan@amazon.com>, <hhhawa@amazon.com>
Subject: [PATCH v6 2/6] arm64: dts: amazon: rename al folder to be amazon
Date:   Fri, 24 Jul 2020 16:26:50 +0300
Message-ID: <20200724132654.16549-3-hhhawa@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200724132654.16549-1-hhhawa@amazon.com>
References: <20200724132654.16549-1-hhhawa@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.65]
X-ClientProxiedBy: EX13D32UWA004.ant.amazon.com (10.43.160.193) To
 EX13D19EUB001.ant.amazon.com (10.43.166.229)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As preparation to add device tree binding for Amazon's Annapurna Labs
Alpine v3 support. Rename al device tree folder to be amazon.

Signed-off-by: Hanna Hawa <hhhawa@amazon.com>
Acked-by: Antoine Tenart <antoine.tenart@bootlin.com>
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
index d53db30d1365..55f7c4526a1b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1617,7 +1617,7 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	arch/arm/boot/dts/alpine*
 F:	arch/arm/mach-alpine/
-F:	arch/arm64/boot/dts/al/
+F:	arch/arm64/boot/dts/amazon/
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

