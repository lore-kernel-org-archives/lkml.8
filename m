Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44038C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 19:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09EC72082E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 19:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580412457;
	bh=TZ2YQmQqvfzk64TrrHyrrAVuvqNTPoqAfJ4u9CxoiQI=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Qk6qN7Jj+coJjRuAICBviCtptXYLhwuJGvvpa059bodlVyLyahGZ0BAAm5uV3SZ+6
	 FsJQD/Vf/hgAP6WttS2jq0ODnEz6VcbdYQdvb5svqbBCY7mkAyIOwoUdYT8MZlHXqW
	 EuHu29UkWxzq8JFlNlJTTMf/sbMT31K+QeHYJJJA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727545AbgA3T1g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 14:27:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:48704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726267AbgA3T1g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 14:27:36 -0500
Received: from localhost.localdomain (unknown [194.230.155.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D83BD205F4;
        Thu, 30 Jan 2020 19:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580412454;
        bh=TZ2YQmQqvfzk64TrrHyrrAVuvqNTPoqAfJ4u9CxoiQI=;
        h=From:To:Cc:Subject:Date:From;
        b=S4C/RU0xlkQYMldZNZlso4aYg8E9VzeekMvTPZVx0OB0mK2BwCuVFb/a+84WKn1pL
         xpU8vheLDv6PPqfMDHut0xyhxI0IbRcjtJIuj5NUNTSmrSksRgy/Q2WGpwlBZMSidg
         dcdBAZW4563qu3fkFKDhQzzxeoFu0UL9BFCtFbj0=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] sh: configs: Cleanup old Kconfig IO scheduler options
Date:   Thu, 30 Jan 2020 20:27:28 +0100
Message-Id: <20200130192728.3398-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_IOSCHED_DEADLINE and CONFIG_IOSCHED_CFQ are gone since
commit f382fb0bcef4 ("block: remove legacy IO schedulers").

The IOSCHED_DEADLINE was replaced by MQ_IOSCHED_DEADLINE and it will be
now enabled by default (along with MQ_IOSCHED_KYBER).

The BFQ_GROUP_IOSCHED is the only multiqueue scheduler which comes with
group scheduling so select it in configs previously choosing
CFQ_GROUP_IOSCHED.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/sh/configs/apsh4ad0a_defconfig    | 3 ++-
 arch/sh/configs/kfr2r09_defconfig      | 2 --
 arch/sh/configs/magicpanelr2_defconfig | 2 --
 arch/sh/configs/polaris_defconfig      | 1 -
 arch/sh/configs/r7780mp_defconfig      | 2 --
 arch/sh/configs/r7785rp_defconfig      | 2 --
 arch/sh/configs/rsk7201_defconfig      | 2 --
 arch/sh/configs/rsk7203_defconfig      | 2 --
 arch/sh/configs/rsk7264_defconfig      | 2 --
 arch/sh/configs/rsk7269_defconfig      | 2 --
 arch/sh/configs/sdk7786_defconfig      | 3 ++-
 arch/sh/configs/se7206_defconfig       | 2 --
 arch/sh/configs/se7343_defconfig       | 1 -
 arch/sh/configs/se7619_defconfig       | 2 --
 arch/sh/configs/se7705_defconfig       | 2 --
 arch/sh/configs/se7712_defconfig       | 2 --
 arch/sh/configs/se7721_defconfig       | 2 --
 arch/sh/configs/se7722_defconfig       | 2 --
 arch/sh/configs/se7780_defconfig       | 1 -
 arch/sh/configs/sh7710voipgw_defconfig | 1 -
 arch/sh/configs/shmin_defconfig        | 2 --
 arch/sh/configs/ul2_defconfig          | 2 --
 22 files changed, 4 insertions(+), 38 deletions(-)

diff --git a/arch/sh/configs/apsh4ad0a_defconfig b/arch/sh/configs/apsh4ad0a_defconfig
index 6dd0da73ca5a..6abd9bd70106 100644
--- a/arch/sh/configs/apsh4ad0a_defconfig
+++ b/arch/sh/configs/apsh4ad0a_defconfig
@@ -20,7 +20,8 @@ CONFIG_PROFILING=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
-CONFIG_CFQ_GROUP_IOSCHED=y
+CONFIG_IOSCHED_BFQ=y
+CONFIG_BFQ_GROUP_IOSCHED=y
 CONFIG_CPU_SUBTYPE_SH7786=y
 CONFIG_MEMORY_SIZE=0x10000000
 CONFIG_HUGETLB_PAGE_SIZE_1MB=y
diff --git a/arch/sh/configs/kfr2r09_defconfig b/arch/sh/configs/kfr2r09_defconfig
index 1dc3f670c481..833404490cfe 100644
--- a/arch/sh/configs/kfr2r09_defconfig
+++ b/arch/sh/configs/kfr2r09_defconfig
@@ -10,8 +10,6 @@ CONFIG_SLAB=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
-# CONFIG_IOSCHED_DEADLINE is not set
-# CONFIG_IOSCHED_CFQ is not set
 CONFIG_CPU_SUBTYPE_SH7724=y
 CONFIG_MEMORY_SIZE=0x08000000
 CONFIG_FLATMEM_MANUAL=y
diff --git a/arch/sh/configs/magicpanelr2_defconfig b/arch/sh/configs/magicpanelr2_defconfig
index 664c4dee6e6a..0989ed929540 100644
--- a/arch/sh/configs/magicpanelr2_defconfig
+++ b/arch/sh/configs/magicpanelr2_defconfig
@@ -14,8 +14,6 @@ CONFIG_MODULE_UNLOAD=y
 CONFIG_MODVERSIONS=y
 CONFIG_MODULE_SRCVERSION_ALL=y
 # CONFIG_BLK_DEV_BSG is not set
-# CONFIG_IOSCHED_DEADLINE is not set
-# CONFIG_IOSCHED_CFQ is not set
 CONFIG_CPU_SUBTYPE_SH7720=y
 CONFIG_MEMORY_START=0x0C000000
 CONFIG_MEMORY_SIZE=0x03F00000
diff --git a/arch/sh/configs/polaris_defconfig b/arch/sh/configs/polaris_defconfig
index e3a1d3d2694a..246408ec7462 100644
--- a/arch/sh/configs/polaris_defconfig
+++ b/arch/sh/configs/polaris_defconfig
@@ -12,7 +12,6 @@ CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_MODVERSIONS=y
 # CONFIG_BLK_DEV_BSG is not set
-# CONFIG_IOSCHED_DEADLINE is not set
 CONFIG_CPU_SUBTYPE_SH7709=y
 CONFIG_MEMORY_START=0x0C000000
 CONFIG_FLATMEM_MANUAL=y
diff --git a/arch/sh/configs/r7780mp_defconfig b/arch/sh/configs/r7780mp_defconfig
index 0a18f8011c55..c97ec60cff27 100644
--- a/arch/sh/configs/r7780mp_defconfig
+++ b/arch/sh/configs/r7780mp_defconfig
@@ -12,8 +12,6 @@ CONFIG_OPROFILE=m
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
-# CONFIG_IOSCHED_DEADLINE is not set
-# CONFIG_IOSCHED_CFQ is not set
 CONFIG_CPU_SUBTYPE_SH7780=y
 CONFIG_MEMORY_SIZE=0x08000000
 CONFIG_FLATMEM_MANUAL=y
diff --git a/arch/sh/configs/r7785rp_defconfig b/arch/sh/configs/r7785rp_defconfig
index 7226ac5a1d44..55fce65eb454 100644
--- a/arch/sh/configs/r7785rp_defconfig
+++ b/arch/sh/configs/r7785rp_defconfig
@@ -15,8 +15,6 @@ CONFIG_KPROBES=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
-# CONFIG_IOSCHED_DEADLINE is not set
-# CONFIG_IOSCHED_CFQ is not set
 CONFIG_CPU_SUBTYPE_SH7785=y
 CONFIG_MEMORY_SIZE=0x08000000
 CONFIG_HUGETLB_PAGE_SIZE_1MB=y
diff --git a/arch/sh/configs/rsk7201_defconfig b/arch/sh/configs/rsk7201_defconfig
index 9f4f474705b7..841809b5c2dc 100644
--- a/arch/sh/configs/rsk7201_defconfig
+++ b/arch/sh/configs/rsk7201_defconfig
@@ -15,8 +15,6 @@ CONFIG_PROFILING=y
 CONFIG_OPROFILE=y
 CONFIG_MODULES=y
 # CONFIG_BLK_DEV_BSG is not set
-# CONFIG_IOSCHED_DEADLINE is not set
-# CONFIG_IOSCHED_CFQ is not set
 CONFIG_CPU_SUBTYPE_SH7201=y
 CONFIG_MEMORY_SIZE=0x01000000
 CONFIG_FLATMEM_MANUAL=y
diff --git a/arch/sh/configs/rsk7203_defconfig b/arch/sh/configs/rsk7203_defconfig
index 10a32bd4cf66..0055031664ad 100644
--- a/arch/sh/configs/rsk7203_defconfig
+++ b/arch/sh/configs/rsk7203_defconfig
@@ -16,8 +16,6 @@ CONFIG_PROFILING=y
 CONFIG_OPROFILE=y
 CONFIG_MODULES=y
 # CONFIG_BLK_DEV_BSG is not set
-# CONFIG_IOSCHED_DEADLINE is not set
-# CONFIG_IOSCHED_CFQ is not set
 CONFIG_CPU_SUBTYPE_SH7203=y
 CONFIG_MEMORY_START=0x0c000000
 CONFIG_MEMORY_SIZE=0x01000000
diff --git a/arch/sh/configs/rsk7264_defconfig b/arch/sh/configs/rsk7264_defconfig
index 78643191c99e..f7b9c528c6df 100644
--- a/arch/sh/configs/rsk7264_defconfig
+++ b/arch/sh/configs/rsk7264_defconfig
@@ -17,8 +17,6 @@ CONFIG_MMAP_ALLOW_UNINITIALIZED=y
 CONFIG_PROFILING=y
 # CONFIG_BLK_DEV_BSG is not set
 CONFIG_PARTITION_ADVANCED=y
-# CONFIG_IOSCHED_DEADLINE is not set
-# CONFIG_IOSCHED_CFQ is not set
 CONFIG_CPU_SUBTYPE_SH7264=y
 CONFIG_MEMORY_START=0x0c000000
 CONFIG_FLATMEM_MANUAL=y
diff --git a/arch/sh/configs/rsk7269_defconfig b/arch/sh/configs/rsk7269_defconfig
index fb9fa7faf635..4bff14fb185d 100644
--- a/arch/sh/configs/rsk7269_defconfig
+++ b/arch/sh/configs/rsk7269_defconfig
@@ -4,8 +4,6 @@ CONFIG_EMBEDDED=y
 # CONFIG_VM_EVENT_COUNTERS is not set
 CONFIG_SLAB=y
 # CONFIG_BLK_DEV_BSG is not set
-# CONFIG_IOSCHED_DEADLINE is not set
-# CONFIG_IOSCHED_CFQ is not set
 CONFIG_SWAP_IO_SPACE=y
 CONFIG_CPU_SUBTYPE_SH7269=y
 CONFIG_MEMORY_START=0x0c000000
diff --git a/arch/sh/configs/sdk7786_defconfig b/arch/sh/configs/sdk7786_defconfig
index 7fa116b436c3..61bec46ebd66 100644
--- a/arch/sh/configs/sdk7786_defconfig
+++ b/arch/sh/configs/sdk7786_defconfig
@@ -39,7 +39,8 @@ CONFIG_OPROFILE=m
 CONFIG_KPROBES=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
-CONFIG_CFQ_GROUP_IOSCHED=y
+CONFIG_IOSCHED_BFQ=y
+CONFIG_BFQ_GROUP_IOSCHED=y
 CONFIG_CPU_SUBTYPE_SH7786=y
 CONFIG_MEMORY_START=0x40000000
 CONFIG_MEMORY_SIZE=0x20000000
diff --git a/arch/sh/configs/se7206_defconfig b/arch/sh/configs/se7206_defconfig
index a93402b3a319..21a43f14ffac 100644
--- a/arch/sh/configs/se7206_defconfig
+++ b/arch/sh/configs/se7206_defconfig
@@ -28,8 +28,6 @@ CONFIG_OPROFILE=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
-# CONFIG_IOSCHED_DEADLINE is not set
-# CONFIG_IOSCHED_CFQ is not set
 CONFIG_CPU_SUBTYPE_SH7206=y
 CONFIG_MEMORY_START=0x0c000000
 CONFIG_FLATMEM_MANUAL=y
diff --git a/arch/sh/configs/se7343_defconfig b/arch/sh/configs/se7343_defconfig
index 06d067c842cd..4e794e719a28 100644
--- a/arch/sh/configs/se7343_defconfig
+++ b/arch/sh/configs/se7343_defconfig
@@ -11,7 +11,6 @@ CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_MODULE_FORCE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
-# CONFIG_IOSCHED_CFQ is not set
 CONFIG_CPU_SUBTYPE_SH7343=y
 CONFIG_MEMORY_START=0x0c000000
 CONFIG_MEMORY_SIZE=0x01000000
diff --git a/arch/sh/configs/se7619_defconfig b/arch/sh/configs/se7619_defconfig
index f54722dbc8f5..3264415a5931 100644
--- a/arch/sh/configs/se7619_defconfig
+++ b/arch/sh/configs/se7619_defconfig
@@ -11,8 +11,6 @@ CONFIG_LOG_BUF_SHIFT=14
 # CONFIG_VM_EVENT_COUNTERS is not set
 CONFIG_SLAB=y
 # CONFIG_BLK_DEV_BSG is not set
-# CONFIG_IOSCHED_DEADLINE is not set
-# CONFIG_IOSCHED_CFQ is not set
 CONFIG_MEMORY_START=0x0c000000
 CONFIG_FLATMEM_MANUAL=y
 CONFIG_CPU_BIG_ENDIAN=y
diff --git a/arch/sh/configs/se7705_defconfig b/arch/sh/configs/se7705_defconfig
index ddfc69841955..4496b94b7d88 100644
--- a/arch/sh/configs/se7705_defconfig
+++ b/arch/sh/configs/se7705_defconfig
@@ -8,8 +8,6 @@ CONFIG_BLK_DEV_INITRD=y
 CONFIG_SLAB=y
 CONFIG_MODULES=y
 # CONFIG_BLK_DEV_BSG is not set
-# CONFIG_IOSCHED_DEADLINE is not set
-# CONFIG_IOSCHED_CFQ is not set
 CONFIG_CPU_SUBTYPE_SH7705=y
 CONFIG_MEMORY_START=0x0c000000
 CONFIG_MEMORY_SIZE=0x02000000
diff --git a/arch/sh/configs/se7712_defconfig b/arch/sh/configs/se7712_defconfig
index 9a527f978106..ee6d28ae08de 100644
--- a/arch/sh/configs/se7712_defconfig
+++ b/arch/sh/configs/se7712_defconfig
@@ -12,8 +12,6 @@ CONFIG_KALLSYMS_ALL=y
 CONFIG_SLAB=y
 CONFIG_MODULES=y
 # CONFIG_BLK_DEV_BSG is not set
-# CONFIG_IOSCHED_DEADLINE is not set
-# CONFIG_IOSCHED_CFQ is not set
 CONFIG_CPU_SUBTYPE_SH7712=y
 CONFIG_MEMORY_START=0x0c000000
 CONFIG_MEMORY_SIZE=0x02000000
diff --git a/arch/sh/configs/se7721_defconfig b/arch/sh/configs/se7721_defconfig
index 3b0e1eb6e874..bad921bc10f8 100644
--- a/arch/sh/configs/se7721_defconfig
+++ b/arch/sh/configs/se7721_defconfig
@@ -12,8 +12,6 @@ CONFIG_KALLSYMS_ALL=y
 CONFIG_SLAB=y
 CONFIG_MODULES=y
 # CONFIG_BLK_DEV_BSG is not set
-# CONFIG_IOSCHED_DEADLINE is not set
-# CONFIG_IOSCHED_CFQ is not set
 CONFIG_CPU_SUBTYPE_SH7721=y
 CONFIG_MEMORY_START=0x0c000000
 CONFIG_MEMORY_SIZE=0x02000000
diff --git a/arch/sh/configs/se7722_defconfig b/arch/sh/configs/se7722_defconfig
index 88bf9e849008..09e455817447 100644
--- a/arch/sh/configs/se7722_defconfig
+++ b/arch/sh/configs/se7722_defconfig
@@ -8,8 +8,6 @@ CONFIG_PROFILING=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
-# CONFIG_IOSCHED_DEADLINE is not set
-# CONFIG_IOSCHED_CFQ is not set
 CONFIG_CPU_SUBTYPE_SH7722=y
 CONFIG_MEMORY_START=0x0c000000
 CONFIG_NUMA=y
diff --git a/arch/sh/configs/se7780_defconfig b/arch/sh/configs/se7780_defconfig
index ec32c82646ed..dcd85b858ac8 100644
--- a/arch/sh/configs/se7780_defconfig
+++ b/arch/sh/configs/se7780_defconfig
@@ -9,7 +9,6 @@ CONFIG_LOG_BUF_SHIFT=14
 CONFIG_SLAB=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
-# CONFIG_IOSCHED_CFQ is not set
 CONFIG_CPU_SUBTYPE_SH7780=y
 CONFIG_MEMORY_SIZE=0x08000000
 CONFIG_SH_7780_SOLUTION_ENGINE=y
diff --git a/arch/sh/configs/sh7710voipgw_defconfig b/arch/sh/configs/sh7710voipgw_defconfig
index c86f28442a80..08426913c0e3 100644
--- a/arch/sh/configs/sh7710voipgw_defconfig
+++ b/arch/sh/configs/sh7710voipgw_defconfig
@@ -11,7 +11,6 @@ CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_MODULE_FORCE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
-# CONFIG_IOSCHED_CFQ is not set
 CONFIG_CPU_SUBTYPE_SH7710=y
 CONFIG_MEMORY_START=0x0c000000
 CONFIG_MEMORY_SIZE=0x00800000
diff --git a/arch/sh/configs/shmin_defconfig b/arch/sh/configs/shmin_defconfig
index d589cfdfb7eb..a27b129b93c5 100644
--- a/arch/sh/configs/shmin_defconfig
+++ b/arch/sh/configs/shmin_defconfig
@@ -12,8 +12,6 @@ CONFIG_LOG_BUF_SHIFT=14
 # CONFIG_SHMEM is not set
 CONFIG_SLOB=y
 # CONFIG_BLK_DEV_BSG is not set
-# CONFIG_IOSCHED_DEADLINE is not set
-# CONFIG_IOSCHED_CFQ is not set
 CONFIG_CPU_SUBTYPE_SH7706=y
 CONFIG_MEMORY_START=0x0c000000
 CONFIG_MEMORY_SIZE=0x00800000
diff --git a/arch/sh/configs/ul2_defconfig b/arch/sh/configs/ul2_defconfig
index dc2e3061130f..103b81ec1ffb 100644
--- a/arch/sh/configs/ul2_defconfig
+++ b/arch/sh/configs/ul2_defconfig
@@ -8,8 +8,6 @@ CONFIG_PROFILING=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
-# CONFIG_IOSCHED_DEADLINE is not set
-# CONFIG_IOSCHED_CFQ is not set
 CONFIG_CPU_SUBTYPE_SH7366=y
 CONFIG_MEMORY_SIZE=0x01f00000
 CONFIG_NUMA=y
-- 
2.17.1

