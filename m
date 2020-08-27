Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB6AC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 23:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8A7820848
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 23:40:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="olTw5uPh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbgH0Xkc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 19:40:32 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:46951 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbgH0Xkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 19:40:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1598571632; x=1630107632;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=Cs2ZQj4gcpB8a/CsXzZ7m8JUSEj83/h21y0J9OJknlQ=;
  b=olTw5uPhtTUMzF3HMKAuL/Opo4fw3husdW5XuEF4kC3ucm4rKdrtY57q
   d+ingJliJGg2O8THUdKKAOsaANY+nFTpcrev55vDGR8gmkMV1Jn8cOLbe
   G8t2OLEp9hNqFeYZZQR38Oih/mTcuav+y12J0w+e5HvqOfpC9/AqwArtX
   4=;
X-IronPort-AV: E=Sophos;i="5.76,361,1592870400"; 
   d="scan'208";a="50350075"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2c-168cbb73.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 27 Aug 2020 23:40:14 +0000
Received: from EX13MTAUWA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2c-168cbb73.us-west-2.amazon.com (Postfix) with ESMTPS id C1C7DA0827;
        Thu, 27 Aug 2020 23:40:13 +0000 (UTC)
Received: from EX13D13UWA004.ant.amazon.com (10.43.160.251) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.58) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 27 Aug 2020 23:40:13 +0000
Received: from EX13MTAUEE002.ant.amazon.com (10.43.62.24) by
 EX13D13UWA004.ant.amazon.com (10.43.160.251) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 27 Aug 2020 23:40:13 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.62.224) with Microsoft SMTP
 Server id 15.0.1497.2 via Frontend Transport; Thu, 27 Aug 2020 23:40:12 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id 08602C153F; Thu, 27 Aug 2020 23:40:12 +0000 (UTC)
From:   Frank van der Linden <fllinden@amazon.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>
CC:     Frank van der Linden <fllinden@amazon.com>
Subject: [PATCH] arm64: vdso32: make vdso32 install conditional
Date:   Thu, 27 Aug 2020 23:40:12 +0000
Message-ID: <20200827234012.19757-1-fllinden@amazon.com>
X-Mailer: git-send-email 2.16.6
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vdso32 should only be installed if CONFIG_COMPAT_VDSO is enabled,
since it's not even supposed to be compiled otherwise, and arm64
builds without a 32bit crosscompiler will fail.

Signed-off-by: Frank van der Linden <fllinden@amazon.com>
Fixes: 8d75785a8142 ("ARM64: vdso32: Install vdso32 from vdso_install")
Cc: stable@vger.kernel.org [5.4+]
---
 arch/arm64/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index b45f0124cc16..100abbb19e0b 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -165,7 +165,8 @@ zinstall install:
 PHONY += vdso_install
 vdso_install:
 	$(Q)$(MAKE) $(build)=arch/arm64/kernel/vdso $@
-	$(Q)$(MAKE) $(build)=arch/arm64/kernel/vdso32 $@
+	$(if $(CONFIG_COMPAT_VDSO),$(Q)$(MAKE) \
+		$(build)=arch/arm64/kernel/vdso32 $@)
 
 # We use MRPROPER_FILES and CLEAN_FILES now
 archclean:
-- 
2.16.6

