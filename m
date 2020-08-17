Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22BEEC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 22:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE9FD20674
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 22:33:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729778AbgHQWdi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 18:33:38 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:45456 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbgHQWde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 18:33:34 -0400
Received: from [82.43.126.140] (helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1k7nh4-00080d-5A; Mon, 17 Aug 2020 22:33:30 +0000
From:   Colin King <colin.king@canonical.com>
To:     Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: Kconfig: remove duplicate "the the" phrase in Kconfig text
Date:   Mon, 17 Aug 2020 23:33:29 +0100
Message-Id: <20200817223329.5462-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are a couple of occurrences of "the the" in the Kconfig
help text. Fix these.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 arch/arm/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index e00d94b16658..9ac1be7390f9 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1791,7 +1791,7 @@ config ARM_ATAG_DTB_COMPAT_CMDLINE_EXTEND
 	bool "Extend with bootloader kernel arguments"
 	help
 	  The command-line arguments provided by the boot loader will be
-	  appended to the the device tree bootargs property.
+	  appended to the device tree bootargs property.
 
 endchoice
 
@@ -1948,7 +1948,7 @@ config DMI
 	  continue to boot on existing non-UEFI platforms.
 
 	  NOTE: This does *NOT* enable or encourage the use of DMI quirks,
-	  i.e., the the practice of identifying the platform via DMI to
+	  i.e., the practice of identifying the platform via DMI to
 	  decide whether certain workarounds for buggy hardware and/or
 	  firmware need to be enabled. This would require the DMI subsystem
 	  to be enabled much earlier than we do on ARM, which is non-trivial.
-- 
2.27.0

