Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UPPERCASE_50_75,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F92CC352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 09:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCE612080C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 09:39:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbgBJJjZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 04:39:25 -0500
Received: from michel.telenet-ops.be ([195.130.137.88]:47254 "EHLO
        michel.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbgBJJjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 04:39:24 -0500
Received: from ramsan ([84.195.182.253])
        by michel.telenet-ops.be with bizsmtp
        id 0xfL2200G5USYZQ06xfLcQ; Mon, 10 Feb 2020 10:39:20 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1j15XE-00028x-Lw; Mon, 10 Feb 2020 10:39:20 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1j15XE-0001vO-Jq; Mon, 10 Feb 2020 10:39:20 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-m68k@lists.linux-m68k.org
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] m68k: defconfig: Update defconfigs for v5.6-rc1
Date:   Mon, 10 Feb 2020 10:39:19 +0100
Message-Id: <20200210093919.7357-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  - Disable CONFIG_BOOT_CONFIG (should default to n),
  - Enable modular build of the WireGuard secure network tunnel,
  - Drop CONFIG_CRYPTO_LIB_{BLAKE2S,CHACHA20POLY1305,CURVE25519}=m
    (auto-enabled by CONFIG_WIREGUARD).

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/m68k/configs/amiga_defconfig    | 5 ++---
 arch/m68k/configs/apollo_defconfig   | 5 ++---
 arch/m68k/configs/atari_defconfig    | 5 ++---
 arch/m68k/configs/bvme6000_defconfig | 5 ++---
 arch/m68k/configs/hp300_defconfig    | 5 ++---
 arch/m68k/configs/mac_defconfig      | 5 ++---
 arch/m68k/configs/multi_defconfig    | 5 ++---
 arch/m68k/configs/mvme147_defconfig  | 5 ++---
 arch/m68k/configs/mvme16x_defconfig  | 5 ++---
 arch/m68k/configs/q40_defconfig      | 5 ++---
 arch/m68k/configs/sun3_defconfig     | 5 ++---
 arch/m68k/configs/sun3x_defconfig    | 5 ++---
 12 files changed, 24 insertions(+), 36 deletions(-)

diff --git a/arch/m68k/configs/amiga_defconfig b/arch/m68k/configs/amiga_defconfig
index e1134c3e0b69d5d3..e470027050cfafa5 100644
--- a/arch/m68k/configs/amiga_defconfig
+++ b/arch/m68k/configs/amiga_defconfig
@@ -9,6 +9,7 @@ CONFIG_LOG_BUF_SHIFT=16
 # CONFIG_PID_NS is not set
 # CONFIG_NET_NS is not set
 CONFIG_BLK_DEV_INITRD=y
+# CONFIG_BOOT_CONFIG is not set
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_USERFAULTFD=y
 CONFIG_SLAB=y
@@ -369,6 +370,7 @@ CONFIG_TCM_FILEIO=m
 CONFIG_TCM_PSCSI=m
 CONFIG_NETDEVICES=y
 CONFIG_DUMMY=m
+CONFIG_WIREGUARD=m
 CONFIG_EQUALIZER=m
 CONFIG_NET_TEAM=m
 CONFIG_NET_TEAM_MODE_BROADCAST=m
@@ -613,9 +615,6 @@ CONFIG_CRYPTO_USER_API_HASH=m
 CONFIG_CRYPTO_USER_API_SKCIPHER=m
 CONFIG_CRYPTO_USER_API_RNG=m
 CONFIG_CRYPTO_USER_API_AEAD=m
-CONFIG_CRYPTO_LIB_BLAKE2S=m
-CONFIG_CRYPTO_LIB_CURVE25519=m
-CONFIG_CRYPTO_LIB_CHACHA20POLY1305=m
 # CONFIG_CRYPTO_HW is not set
 CONFIG_CRC32_SELFTEST=m
 CONFIG_CRC64=m
diff --git a/arch/m68k/configs/apollo_defconfig b/arch/m68k/configs/apollo_defconfig
index 484cb1643df1719d..afdd8fd472ede19b 100644
--- a/arch/m68k/configs/apollo_defconfig
+++ b/arch/m68k/configs/apollo_defconfig
@@ -9,6 +9,7 @@ CONFIG_LOG_BUF_SHIFT=16
 # CONFIG_PID_NS is not set
 # CONFIG_NET_NS is not set
 CONFIG_BLK_DEV_INITRD=y
+# CONFIG_BOOT_CONFIG is not set
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_USERFAULTFD=y
 CONFIG_SLAB=y
@@ -348,6 +349,7 @@ CONFIG_TCM_FILEIO=m
 CONFIG_TCM_PSCSI=m
 CONFIG_NETDEVICES=y
 CONFIG_DUMMY=m
+CONFIG_WIREGUARD=m
 CONFIG_EQUALIZER=m
 CONFIG_NET_TEAM=m
 CONFIG_NET_TEAM_MODE_BROADCAST=m
@@ -569,9 +571,6 @@ CONFIG_CRYPTO_USER_API_HASH=m
 CONFIG_CRYPTO_USER_API_SKCIPHER=m
 CONFIG_CRYPTO_USER_API_RNG=m
 CONFIG_CRYPTO_USER_API_AEAD=m
-CONFIG_CRYPTO_LIB_BLAKE2S=m
-CONFIG_CRYPTO_LIB_CURVE25519=m
-CONFIG_CRYPTO_LIB_CHACHA20POLY1305=m
 # CONFIG_CRYPTO_HW is not set
 CONFIG_CRC32_SELFTEST=m
 CONFIG_CRC64=m
diff --git a/arch/m68k/configs/atari_defconfig b/arch/m68k/configs/atari_defconfig
index c372f00c4a1f0797..a354a540046a9b9b 100644
--- a/arch/m68k/configs/atari_defconfig
+++ b/arch/m68k/configs/atari_defconfig
@@ -9,6 +9,7 @@ CONFIG_LOG_BUF_SHIFT=16
 # CONFIG_PID_NS is not set
 # CONFIG_NET_NS is not set
 CONFIG_BLK_DEV_INITRD=y
+# CONFIG_BOOT_CONFIG is not set
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_USERFAULTFD=y
 CONFIG_SLAB=y
@@ -364,6 +365,7 @@ CONFIG_TCM_FILEIO=m
 CONFIG_TCM_PSCSI=m
 CONFIG_NETDEVICES=y
 CONFIG_DUMMY=m
+CONFIG_WIREGUARD=m
 CONFIG_EQUALIZER=m
 CONFIG_NET_TEAM=m
 CONFIG_NET_TEAM_MODE_BROADCAST=m
@@ -602,9 +604,6 @@ CONFIG_CRYPTO_USER_API_HASH=m
 CONFIG_CRYPTO_USER_API_SKCIPHER=m
 CONFIG_CRYPTO_USER_API_RNG=m
 CONFIG_CRYPTO_USER_API_AEAD=m
-CONFIG_CRYPTO_LIB_BLAKE2S=m
-CONFIG_CRYPTO_LIB_CURVE25519=m
-CONFIG_CRYPTO_LIB_CHACHA20POLY1305=m
 # CONFIG_CRYPTO_HW is not set
 CONFIG_CRC32_SELFTEST=m
 CONFIG_CRC64=m
diff --git a/arch/m68k/configs/bvme6000_defconfig b/arch/m68k/configs/bvme6000_defconfig
index bee9263a409c4e18..520260d921b6a1e1 100644
--- a/arch/m68k/configs/bvme6000_defconfig
+++ b/arch/m68k/configs/bvme6000_defconfig
@@ -9,6 +9,7 @@ CONFIG_LOG_BUF_SHIFT=16
 # CONFIG_PID_NS is not set
 # CONFIG_NET_NS is not set
 CONFIG_BLK_DEV_INITRD=y
+# CONFIG_BOOT_CONFIG is not set
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_USERFAULTFD=y
 CONFIG_SLAB=y
@@ -346,6 +347,7 @@ CONFIG_TCM_FILEIO=m
 CONFIG_TCM_PSCSI=m
 CONFIG_NETDEVICES=y
 CONFIG_DUMMY=m
+CONFIG_WIREGUARD=m
 CONFIG_EQUALIZER=m
 CONFIG_NET_TEAM=m
 CONFIG_NET_TEAM_MODE_BROADCAST=m
@@ -562,9 +564,6 @@ CONFIG_CRYPTO_USER_API_HASH=m
 CONFIG_CRYPTO_USER_API_SKCIPHER=m
 CONFIG_CRYPTO_USER_API_RNG=m
 CONFIG_CRYPTO_USER_API_AEAD=m
-CONFIG_CRYPTO_LIB_BLAKE2S=m
-CONFIG_CRYPTO_LIB_CURVE25519=m
-CONFIG_CRYPTO_LIB_CHACHA20POLY1305=m
 # CONFIG_CRYPTO_HW is not set
 CONFIG_CRC32_SELFTEST=m
 CONFIG_CRC64=m
diff --git a/arch/m68k/configs/hp300_defconfig b/arch/m68k/configs/hp300_defconfig
index c8847a8bcbd6d23f..1956a36a0b0b8d5c 100644
--- a/arch/m68k/configs/hp300_defconfig
+++ b/arch/m68k/configs/hp300_defconfig
@@ -9,6 +9,7 @@ CONFIG_LOG_BUF_SHIFT=16
 # CONFIG_PID_NS is not set
 # CONFIG_NET_NS is not set
 CONFIG_BLK_DEV_INITRD=y
+# CONFIG_BOOT_CONFIG is not set
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_USERFAULTFD=y
 CONFIG_SLAB=y
@@ -347,6 +348,7 @@ CONFIG_TCM_FILEIO=m
 CONFIG_TCM_PSCSI=m
 CONFIG_NETDEVICES=y
 CONFIG_DUMMY=m
+CONFIG_WIREGUARD=m
 CONFIG_EQUALIZER=m
 CONFIG_NET_TEAM=m
 CONFIG_NET_TEAM_MODE_BROADCAST=m
@@ -571,9 +573,6 @@ CONFIG_CRYPTO_USER_API_HASH=m
 CONFIG_CRYPTO_USER_API_SKCIPHER=m
 CONFIG_CRYPTO_USER_API_RNG=m
 CONFIG_CRYPTO_USER_API_AEAD=m
-CONFIG_CRYPTO_LIB_BLAKE2S=m
-CONFIG_CRYPTO_LIB_CURVE25519=m
-CONFIG_CRYPTO_LIB_CHACHA20POLY1305=m
 # CONFIG_CRYPTO_HW is not set
 CONFIG_CRC32_SELFTEST=m
 CONFIG_CRC64=m
diff --git a/arch/m68k/configs/mac_defconfig b/arch/m68k/configs/mac_defconfig
index 303ffafd9cad0d60..681f66f1c66d393a 100644
--- a/arch/m68k/configs/mac_defconfig
+++ b/arch/m68k/configs/mac_defconfig
@@ -9,6 +9,7 @@ CONFIG_LOG_BUF_SHIFT=16
 # CONFIG_PID_NS is not set
 # CONFIG_NET_NS is not set
 CONFIG_BLK_DEV_INITRD=y
+# CONFIG_BOOT_CONFIG is not set
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_USERFAULTFD=y
 CONFIG_SLAB=y
@@ -363,6 +364,7 @@ CONFIG_INPUT_ADBHID=y
 CONFIG_MAC_EMUMOUSEBTN=y
 CONFIG_NETDEVICES=y
 CONFIG_DUMMY=m
+CONFIG_WIREGUARD=m
 CONFIG_EQUALIZER=m
 CONFIG_NET_TEAM=m
 CONFIG_NET_TEAM_MODE_BROADCAST=m
@@ -593,9 +595,6 @@ CONFIG_CRYPTO_USER_API_HASH=m
 CONFIG_CRYPTO_USER_API_SKCIPHER=m
 CONFIG_CRYPTO_USER_API_RNG=m
 CONFIG_CRYPTO_USER_API_AEAD=m
-CONFIG_CRYPTO_LIB_BLAKE2S=m
-CONFIG_CRYPTO_LIB_CURVE25519=m
-CONFIG_CRYPTO_LIB_CHACHA20POLY1305=m
 # CONFIG_CRYPTO_HW is not set
 CONFIG_CRC32_SELFTEST=m
 CONFIG_CRC64=m
diff --git a/arch/m68k/configs/multi_defconfig b/arch/m68k/configs/multi_defconfig
index 89a704226cd9e4e5..114ef55692427e0c 100644
--- a/arch/m68k/configs/multi_defconfig
+++ b/arch/m68k/configs/multi_defconfig
@@ -9,6 +9,7 @@ CONFIG_LOG_BUF_SHIFT=16
 # CONFIG_PID_NS is not set
 # CONFIG_NET_NS is not set
 CONFIG_BLK_DEV_INITRD=y
+# CONFIG_BOOT_CONFIG is not set
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_USERFAULTFD=y
 CONFIG_SLAB=y
@@ -407,6 +408,7 @@ CONFIG_INPUT_ADBHID=y
 CONFIG_MAC_EMUMOUSEBTN=y
 CONFIG_NETDEVICES=y
 CONFIG_DUMMY=m
+CONFIG_WIREGUARD=m
 CONFIG_EQUALIZER=m
 CONFIG_NET_TEAM=m
 CONFIG_NET_TEAM_MODE_BROADCAST=m
@@ -679,9 +681,6 @@ CONFIG_CRYPTO_USER_API_HASH=m
 CONFIG_CRYPTO_USER_API_SKCIPHER=m
 CONFIG_CRYPTO_USER_API_RNG=m
 CONFIG_CRYPTO_USER_API_AEAD=m
-CONFIG_CRYPTO_LIB_BLAKE2S=m
-CONFIG_CRYPTO_LIB_CURVE25519=m
-CONFIG_CRYPTO_LIB_CHACHA20POLY1305=m
 # CONFIG_CRYPTO_HW is not set
 CONFIG_CRC32_SELFTEST=m
 CONFIG_CRC64=m
diff --git a/arch/m68k/configs/mvme147_defconfig b/arch/m68k/configs/mvme147_defconfig
index f62c1f4d03a0330e..505a0ac80b3b041f 100644
--- a/arch/m68k/configs/mvme147_defconfig
+++ b/arch/m68k/configs/mvme147_defconfig
@@ -9,6 +9,7 @@ CONFIG_LOG_BUF_SHIFT=16
 # CONFIG_PID_NS is not set
 # CONFIG_NET_NS is not set
 CONFIG_BLK_DEV_INITRD=y
+# CONFIG_BOOT_CONFIG is not set
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_USERFAULTFD=y
 CONFIG_SLAB=y
@@ -345,6 +346,7 @@ CONFIG_TCM_FILEIO=m
 CONFIG_TCM_PSCSI=m
 CONFIG_NETDEVICES=y
 CONFIG_DUMMY=m
+CONFIG_WIREGUARD=m
 CONFIG_EQUALIZER=m
 CONFIG_NET_TEAM=m
 CONFIG_NET_TEAM_MODE_BROADCAST=m
@@ -561,9 +563,6 @@ CONFIG_CRYPTO_USER_API_HASH=m
 CONFIG_CRYPTO_USER_API_SKCIPHER=m
 CONFIG_CRYPTO_USER_API_RNG=m
 CONFIG_CRYPTO_USER_API_AEAD=m
-CONFIG_CRYPTO_LIB_BLAKE2S=m
-CONFIG_CRYPTO_LIB_CURVE25519=m
-CONFIG_CRYPTO_LIB_CHACHA20POLY1305=m
 # CONFIG_CRYPTO_HW is not set
 CONFIG_CRC32_SELFTEST=m
 CONFIG_CRC64=m
diff --git a/arch/m68k/configs/mvme16x_defconfig b/arch/m68k/configs/mvme16x_defconfig
index 58dcad26a7513222..0376deba137f6bd7 100644
--- a/arch/m68k/configs/mvme16x_defconfig
+++ b/arch/m68k/configs/mvme16x_defconfig
@@ -9,6 +9,7 @@ CONFIG_LOG_BUF_SHIFT=16
 # CONFIG_PID_NS is not set
 # CONFIG_NET_NS is not set
 CONFIG_BLK_DEV_INITRD=y
+# CONFIG_BOOT_CONFIG is not set
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_USERFAULTFD=y
 CONFIG_SLAB=y
@@ -346,6 +347,7 @@ CONFIG_TCM_FILEIO=m
 CONFIG_TCM_PSCSI=m
 CONFIG_NETDEVICES=y
 CONFIG_DUMMY=m
+CONFIG_WIREGUARD=m
 CONFIG_EQUALIZER=m
 CONFIG_NET_TEAM=m
 CONFIG_NET_TEAM_MODE_BROADCAST=m
@@ -562,9 +564,6 @@ CONFIG_CRYPTO_USER_API_HASH=m
 CONFIG_CRYPTO_USER_API_SKCIPHER=m
 CONFIG_CRYPTO_USER_API_RNG=m
 CONFIG_CRYPTO_USER_API_AEAD=m
-CONFIG_CRYPTO_LIB_BLAKE2S=m
-CONFIG_CRYPTO_LIB_CURVE25519=m
-CONFIG_CRYPTO_LIB_CHACHA20POLY1305=m
 # CONFIG_CRYPTO_HW is not set
 CONFIG_CRC32_SELFTEST=m
 CONFIG_CRC64=m
diff --git a/arch/m68k/configs/q40_defconfig b/arch/m68k/configs/q40_defconfig
index 5d3c28d1d545b4a0..b205f86b1d11a3ea 100644
--- a/arch/m68k/configs/q40_defconfig
+++ b/arch/m68k/configs/q40_defconfig
@@ -9,6 +9,7 @@ CONFIG_LOG_BUF_SHIFT=16
 # CONFIG_PID_NS is not set
 # CONFIG_NET_NS is not set
 CONFIG_BLK_DEV_INITRD=y
+# CONFIG_BOOT_CONFIG is not set
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_USERFAULTFD=y
 CONFIG_SLAB=y
@@ -353,6 +354,7 @@ CONFIG_TCM_FILEIO=m
 CONFIG_TCM_PSCSI=m
 CONFIG_NETDEVICES=y
 CONFIG_DUMMY=m
+CONFIG_WIREGUARD=m
 CONFIG_EQUALIZER=m
 CONFIG_NET_TEAM=m
 CONFIG_NET_TEAM_MODE_BROADCAST=m
@@ -580,9 +582,6 @@ CONFIG_CRYPTO_USER_API_HASH=m
 CONFIG_CRYPTO_USER_API_SKCIPHER=m
 CONFIG_CRYPTO_USER_API_RNG=m
 CONFIG_CRYPTO_USER_API_AEAD=m
-CONFIG_CRYPTO_LIB_BLAKE2S=m
-CONFIG_CRYPTO_LIB_CURVE25519=m
-CONFIG_CRYPTO_LIB_CHACHA20POLY1305=m
 # CONFIG_CRYPTO_HW is not set
 CONFIG_CRC32_SELFTEST=m
 CONFIG_CRC64=m
diff --git a/arch/m68k/configs/sun3_defconfig b/arch/m68k/configs/sun3_defconfig
index 5ef9e17dcd51788a..82f2da175b5412a4 100644
--- a/arch/m68k/configs/sun3_defconfig
+++ b/arch/m68k/configs/sun3_defconfig
@@ -9,6 +9,7 @@ CONFIG_LOG_BUF_SHIFT=16
 # CONFIG_PID_NS is not set
 # CONFIG_NET_NS is not set
 CONFIG_BLK_DEV_INITRD=y
+# CONFIG_BOOT_CONFIG is not set
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_USERFAULTFD=y
 CONFIG_SLAB=y
@@ -343,6 +344,7 @@ CONFIG_TCM_FILEIO=m
 CONFIG_TCM_PSCSI=m
 CONFIG_NETDEVICES=y
 CONFIG_DUMMY=m
+CONFIG_WIREGUARD=m
 CONFIG_EQUALIZER=m
 CONFIG_NET_TEAM=m
 CONFIG_NET_TEAM_MODE_BROADCAST=m
@@ -564,9 +566,6 @@ CONFIG_CRYPTO_USER_API_HASH=m
 CONFIG_CRYPTO_USER_API_SKCIPHER=m
 CONFIG_CRYPTO_USER_API_RNG=m
 CONFIG_CRYPTO_USER_API_AEAD=m
-CONFIG_CRYPTO_LIB_BLAKE2S=m
-CONFIG_CRYPTO_LIB_CURVE25519=m
-CONFIG_CRYPTO_LIB_CHACHA20POLY1305=m
 # CONFIG_CRYPTO_HW is not set
 CONFIG_CRC32_SELFTEST=m
 CONFIG_CRC64=m
diff --git a/arch/m68k/configs/sun3x_defconfig b/arch/m68k/configs/sun3x_defconfig
index 22e1accc60a3e110..2cdc17b9ee8eb184 100644
--- a/arch/m68k/configs/sun3x_defconfig
+++ b/arch/m68k/configs/sun3x_defconfig
@@ -9,6 +9,7 @@ CONFIG_LOG_BUF_SHIFT=16
 # CONFIG_PID_NS is not set
 # CONFIG_NET_NS is not set
 CONFIG_BLK_DEV_INITRD=y
+# CONFIG_BOOT_CONFIG is not set
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_USERFAULTFD=y
 CONFIG_SLAB=y
@@ -343,6 +344,7 @@ CONFIG_TCM_FILEIO=m
 CONFIG_TCM_PSCSI=m
 CONFIG_NETDEVICES=y
 CONFIG_DUMMY=m
+CONFIG_WIREGUARD=m
 CONFIG_EQUALIZER=m
 CONFIG_NET_TEAM=m
 CONFIG_NET_TEAM_MODE_BROADCAST=m
@@ -563,9 +565,6 @@ CONFIG_CRYPTO_USER_API_HASH=m
 CONFIG_CRYPTO_USER_API_SKCIPHER=m
 CONFIG_CRYPTO_USER_API_RNG=m
 CONFIG_CRYPTO_USER_API_AEAD=m
-CONFIG_CRYPTO_LIB_BLAKE2S=m
-CONFIG_CRYPTO_LIB_CURVE25519=m
-CONFIG_CRYPTO_LIB_CHACHA20POLY1305=m
 # CONFIG_CRYPTO_HW is not set
 CONFIG_CRC32_SELFTEST=m
 CONFIG_CRC64=m
-- 
2.17.1

