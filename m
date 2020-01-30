Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E918C35240
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 19:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73624205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 19:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580412327;
	bh=5fNT68kPy8RNwnjQLwz5EOoO7buIik390o24nm066/0=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=CW4ICB+Q05A3gzv95ATa6+zAN16TjSWeH1jSXCDh/RtS6tJSpQMe8kBO5iyKPQJ9L
	 wNOLJvWq3t+DNrk1bQs0u5FYoQXQzcdXoxR1MC9bF2lEY55VnM/zfHrUEH1aCDZrVl
	 9YZHT4z5mtxxUiqpKfCya6di7Cuo+8oc1tIv5LIQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbgA3TZ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 14:25:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:47806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727438AbgA3TZ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 14:25:26 -0500
Received: from localhost.localdomain (unknown [194.230.155.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2AA2F206D3;
        Thu, 30 Jan 2020 19:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580412325;
        bh=5fNT68kPy8RNwnjQLwz5EOoO7buIik390o24nm066/0=;
        h=From:To:Cc:Subject:Date:From;
        b=QQ+/36ZMxzLyi4WPwTlbwS3NoGe14JcjXcXOHTa4iukPqTaFm++fNoO1VZthUYnp7
         zPgyU/qvFoAk/0fKvZ7bOIqbpiOoRzGc4OokpE5UJO+O4WC5Y7xVruiZkHplqiXe9D
         7nbUvaIDweb1vae60rRsva2Ky0fo7j+tVss97IJM=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] m68k: configs: Cleanup old Kconfig IO scheduler options
Date:   Thu, 30 Jan 2020 20:25:20 +0100
Message-Id: <20200130192520.3202-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_IOSCHED_DEADLINE and CONFIG_IOSCHED_CFQ are gone since
commit f382fb0bcef4 ("block: remove legacy IO schedulers").

The IOSCHED_DEADLINE was replaced by MQ_IOSCHED_DEADLINE and it will be
now enabled by default (along with MQ_IOSCHED_KYBER).

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/m68k/configs/amcore_defconfig   | 1 -
 arch/m68k/configs/m5208evb_defconfig | 2 --
 arch/m68k/configs/m5249evb_defconfig | 2 --
 arch/m68k/configs/m5272c3_defconfig  | 2 --
 arch/m68k/configs/m5275evb_defconfig | 2 --
 arch/m68k/configs/m5307c3_defconfig  | 2 --
 arch/m68k/configs/m5407c3_defconfig  | 2 --
 arch/m68k/configs/m5475evb_defconfig | 2 --
 8 files changed, 15 deletions(-)

diff --git a/arch/m68k/configs/amcore_defconfig b/arch/m68k/configs/amcore_defconfig
index d5e683dd885d..3a84f24d41c8 100644
--- a/arch/m68k/configs/amcore_defconfig
+++ b/arch/m68k/configs/amcore_defconfig
@@ -13,7 +13,6 @@ CONFIG_EMBEDDED=y
 # CONFIG_SLUB_DEBUG is not set
 # CONFIG_COMPAT_BRK is not set
 # CONFIG_BLK_DEV_BSG is not set
-# CONFIG_IOSCHED_CFQ is not set
 # CONFIG_MMU is not set
 CONFIG_M5307=y
 CONFIG_AMCORE=y
diff --git a/arch/m68k/configs/m5208evb_defconfig b/arch/m68k/configs/m5208evb_defconfig
index a3102ff7e5ed..0ee3079f6ca9 100644
--- a/arch/m68k/configs/m5208evb_defconfig
+++ b/arch/m68k/configs/m5208evb_defconfig
@@ -10,8 +10,6 @@ CONFIG_EXPERT=y
 # CONFIG_VM_EVENT_COUNTERS is not set
 # CONFIG_COMPAT_BRK is not set
 # CONFIG_BLK_DEV_BSG is not set
-# CONFIG_IOSCHED_DEADLINE is not set
-# CONFIG_IOSCHED_CFQ is not set
 # CONFIG_MMU is not set
 # CONFIG_4KSTACKS is not set
 CONFIG_RAMBASE=0x40000000
diff --git a/arch/m68k/configs/m5249evb_defconfig b/arch/m68k/configs/m5249evb_defconfig
index f7bb9ed3efa8..f84f68c04065 100644
--- a/arch/m68k/configs/m5249evb_defconfig
+++ b/arch/m68k/configs/m5249evb_defconfig
@@ -10,8 +10,6 @@ CONFIG_EXPERT=y
 # CONFIG_VM_EVENT_COUNTERS is not set
 # CONFIG_SLUB_DEBUG is not set
 # CONFIG_BLK_DEV_BSG is not set
-# CONFIG_IOSCHED_DEADLINE is not set
-# CONFIG_IOSCHED_CFQ is not set
 # CONFIG_MMU is not set
 CONFIG_M5249=y
 CONFIG_M5249C3=y
diff --git a/arch/m68k/configs/m5272c3_defconfig b/arch/m68k/configs/m5272c3_defconfig
index 1e679f6a400f..eca65020aae3 100644
--- a/arch/m68k/configs/m5272c3_defconfig
+++ b/arch/m68k/configs/m5272c3_defconfig
@@ -10,8 +10,6 @@ CONFIG_EXPERT=y
 # CONFIG_VM_EVENT_COUNTERS is not set
 # CONFIG_SLUB_DEBUG is not set
 # CONFIG_BLK_DEV_BSG is not set
-# CONFIG_IOSCHED_DEADLINE is not set
-# CONFIG_IOSCHED_CFQ is not set
 # CONFIG_MMU is not set
 CONFIG_M5272=y
 CONFIG_M5272C3=y
diff --git a/arch/m68k/configs/m5275evb_defconfig b/arch/m68k/configs/m5275evb_defconfig
index d2987b40423e..9402c7a3e9c7 100644
--- a/arch/m68k/configs/m5275evb_defconfig
+++ b/arch/m68k/configs/m5275evb_defconfig
@@ -10,8 +10,6 @@ CONFIG_EXPERT=y
 # CONFIG_VM_EVENT_COUNTERS is not set
 # CONFIG_SLUB_DEBUG is not set
 # CONFIG_BLK_DEV_BSG is not set
-# CONFIG_IOSCHED_DEADLINE is not set
-# CONFIG_IOSCHED_CFQ is not set
 # CONFIG_MMU is not set
 CONFIG_M5275=y
 # CONFIG_4KSTACKS is not set
diff --git a/arch/m68k/configs/m5307c3_defconfig b/arch/m68k/configs/m5307c3_defconfig
index 97a78c99eeee..bb8b0eb4bdfc 100644
--- a/arch/m68k/configs/m5307c3_defconfig
+++ b/arch/m68k/configs/m5307c3_defconfig
@@ -10,8 +10,6 @@ CONFIG_EXPERT=y
 # CONFIG_VM_EVENT_COUNTERS is not set
 # CONFIG_SLUB_DEBUG is not set
 # CONFIG_BLK_DEV_BSG is not set
-# CONFIG_IOSCHED_DEADLINE is not set
-# CONFIG_IOSCHED_CFQ is not set
 # CONFIG_MMU is not set
 CONFIG_M5307=y
 CONFIG_M5307C3=y
diff --git a/arch/m68k/configs/m5407c3_defconfig b/arch/m68k/configs/m5407c3_defconfig
index 766a97f39a3a..ce9ccf13c7c0 100644
--- a/arch/m68k/configs/m5407c3_defconfig
+++ b/arch/m68k/configs/m5407c3_defconfig
@@ -11,8 +11,6 @@ CONFIG_EXPERT=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
-# CONFIG_IOSCHED_DEADLINE is not set
-# CONFIG_IOSCHED_CFQ is not set
 # CONFIG_MMU is not set
 CONFIG_M5407=y
 CONFIG_M5407C3=y
diff --git a/arch/m68k/configs/m5475evb_defconfig b/arch/m68k/configs/m5475evb_defconfig
index 579fd98afed6..93f7c7a07553 100644
--- a/arch/m68k/configs/m5475evb_defconfig
+++ b/arch/m68k/configs/m5475evb_defconfig
@@ -11,8 +11,6 @@ CONFIG_LOG_BUF_SHIFT=14
 CONFIG_EMBEDDED=y
 CONFIG_MODULES=y
 # CONFIG_BLK_DEV_BSG is not set
-# CONFIG_IOSCHED_DEADLINE is not set
-# CONFIG_IOSCHED_CFQ is not set
 CONFIG_COLDFIRE=y
 # CONFIG_4KSTACKS is not set
 CONFIG_RAMBASE=0x0
-- 
2.17.1

