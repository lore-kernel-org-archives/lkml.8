Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CABFDC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 07:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE6552067B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 07:55:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728702AbgFOHzE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 03:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728260AbgFOHzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 03:55:04 -0400
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E62DC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 00:55:02 -0700 (PDT)
Received: from ramsan ([IPv6:2a02:1810:ac12:ed20:2191:9276:807:82c1])
        by andre.telenet-ops.be with bizsmtp
        id rKv02200L4zira501Kv0dR; Mon, 15 Jun 2020 09:55:00 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jkjxM-0002D7-AE; Mon, 15 Jun 2020 09:55:00 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jkjxM-0005l0-6L; Mon, 15 Jun 2020 09:55:00 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-m68k@lists.linux-m68k.org
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] m68k: defconfig: Update defconfigs for v5.8-rc1
Date:   Mon, 15 Jun 2020 09:54:58 +0200
Message-Id: <20200615075458.22088-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable modular build of prime numbers and bitops test modules.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/m68k/configs/amiga_defconfig    | 2 ++
 arch/m68k/configs/apollo_defconfig   | 2 ++
 arch/m68k/configs/atari_defconfig    | 2 ++
 arch/m68k/configs/bvme6000_defconfig | 2 ++
 arch/m68k/configs/hp300_defconfig    | 2 ++
 arch/m68k/configs/mac_defconfig      | 2 ++
 arch/m68k/configs/multi_defconfig    | 2 ++
 arch/m68k/configs/mvme147_defconfig  | 2 ++
 arch/m68k/configs/mvme16x_defconfig  | 2 ++
 arch/m68k/configs/q40_defconfig      | 2 ++
 arch/m68k/configs/sun3_defconfig     | 2 ++
 arch/m68k/configs/sun3x_defconfig    | 2 ++
 12 files changed, 24 insertions(+)

diff --git a/arch/m68k/configs/amiga_defconfig b/arch/m68k/configs/amiga_defconfig
index 888b75e7fd79071f..28831ed23a1a8918 100644
--- a/arch/m68k/configs/amiga_defconfig
+++ b/arch/m68k/configs/amiga_defconfig
@@ -615,6 +615,7 @@ CONFIG_CRYPTO_USER_API_SKCIPHER=m
 CONFIG_CRYPTO_USER_API_RNG=m
 CONFIG_CRYPTO_USER_API_AEAD=m
 # CONFIG_CRYPTO_HW is not set
+CONFIG_PRIME_NUMBERS=m
 CONFIG_CRC32_SELFTEST=m
 CONFIG_CRC64=m
 CONFIG_XZ_DEC_TEST=m
@@ -643,6 +644,7 @@ CONFIG_TEST_OVERFLOW=m
 CONFIG_TEST_RHASHTABLE=m
 CONFIG_TEST_HASH=m
 CONFIG_TEST_IDA=m
+CONFIG_TEST_BITOPS=m
 CONFIG_TEST_VMALLOC=m
 CONFIG_TEST_USER_COPY=m
 CONFIG_TEST_BPF=m
diff --git a/arch/m68k/configs/apollo_defconfig b/arch/m68k/configs/apollo_defconfig
index 45303846b65950e3..821ee9afcb2d29f0 100644
--- a/arch/m68k/configs/apollo_defconfig
+++ b/arch/m68k/configs/apollo_defconfig
@@ -571,6 +571,7 @@ CONFIG_CRYPTO_USER_API_SKCIPHER=m
 CONFIG_CRYPTO_USER_API_RNG=m
 CONFIG_CRYPTO_USER_API_AEAD=m
 # CONFIG_CRYPTO_HW is not set
+CONFIG_PRIME_NUMBERS=m
 CONFIG_CRC32_SELFTEST=m
 CONFIG_CRC64=m
 CONFIG_XZ_DEC_TEST=m
@@ -599,6 +600,7 @@ CONFIG_TEST_OVERFLOW=m
 CONFIG_TEST_RHASHTABLE=m
 CONFIG_TEST_HASH=m
 CONFIG_TEST_IDA=m
+CONFIG_TEST_BITOPS=m
 CONFIG_TEST_VMALLOC=m
 CONFIG_TEST_USER_COPY=m
 CONFIG_TEST_BPF=m
diff --git a/arch/m68k/configs/atari_defconfig b/arch/m68k/configs/atari_defconfig
index 62430e40e8599463..a4aec77d38086ec3 100644
--- a/arch/m68k/configs/atari_defconfig
+++ b/arch/m68k/configs/atari_defconfig
@@ -603,6 +603,7 @@ CONFIG_CRYPTO_USER_API_SKCIPHER=m
 CONFIG_CRYPTO_USER_API_RNG=m
 CONFIG_CRYPTO_USER_API_AEAD=m
 # CONFIG_CRYPTO_HW is not set
+CONFIG_PRIME_NUMBERS=m
 CONFIG_CRC32_SELFTEST=m
 CONFIG_CRC64=m
 CONFIG_XZ_DEC_TEST=m
@@ -632,6 +633,7 @@ CONFIG_TEST_OVERFLOW=m
 CONFIG_TEST_RHASHTABLE=m
 CONFIG_TEST_HASH=m
 CONFIG_TEST_IDA=m
+CONFIG_TEST_BITOPS=m
 CONFIG_TEST_VMALLOC=m
 CONFIG_TEST_USER_COPY=m
 CONFIG_TEST_BPF=m
diff --git a/arch/m68k/configs/bvme6000_defconfig b/arch/m68k/configs/bvme6000_defconfig
index 071839ca6a5955a8..4ecea1bd1491b24f 100644
--- a/arch/m68k/configs/bvme6000_defconfig
+++ b/arch/m68k/configs/bvme6000_defconfig
@@ -564,6 +564,7 @@ CONFIG_CRYPTO_USER_API_SKCIPHER=m
 CONFIG_CRYPTO_USER_API_RNG=m
 CONFIG_CRYPTO_USER_API_AEAD=m
 # CONFIG_CRYPTO_HW is not set
+CONFIG_PRIME_NUMBERS=m
 CONFIG_CRC32_SELFTEST=m
 CONFIG_CRC64=m
 CONFIG_XZ_DEC_TEST=m
@@ -592,6 +593,7 @@ CONFIG_TEST_OVERFLOW=m
 CONFIG_TEST_RHASHTABLE=m
 CONFIG_TEST_HASH=m
 CONFIG_TEST_IDA=m
+CONFIG_TEST_BITOPS=m
 CONFIG_TEST_VMALLOC=m
 CONFIG_TEST_USER_COPY=m
 CONFIG_TEST_BPF=m
diff --git a/arch/m68k/configs/hp300_defconfig b/arch/m68k/configs/hp300_defconfig
index 37ac7b019ec162e3..dbb561d2fd3e0af3 100644
--- a/arch/m68k/configs/hp300_defconfig
+++ b/arch/m68k/configs/hp300_defconfig
@@ -573,6 +573,7 @@ CONFIG_CRYPTO_USER_API_SKCIPHER=m
 CONFIG_CRYPTO_USER_API_RNG=m
 CONFIG_CRYPTO_USER_API_AEAD=m
 # CONFIG_CRYPTO_HW is not set
+CONFIG_PRIME_NUMBERS=m
 CONFIG_CRC32_SELFTEST=m
 CONFIG_CRC64=m
 CONFIG_XZ_DEC_TEST=m
@@ -601,6 +602,7 @@ CONFIG_TEST_OVERFLOW=m
 CONFIG_TEST_RHASHTABLE=m
 CONFIG_TEST_HASH=m
 CONFIG_TEST_IDA=m
+CONFIG_TEST_BITOPS=m
 CONFIG_TEST_VMALLOC=m
 CONFIG_TEST_USER_COPY=m
 CONFIG_TEST_BPF=m
diff --git a/arch/m68k/configs/mac_defconfig b/arch/m68k/configs/mac_defconfig
index 60877986626013be..06d6fbfc4b996257 100644
--- a/arch/m68k/configs/mac_defconfig
+++ b/arch/m68k/configs/mac_defconfig
@@ -595,6 +595,7 @@ CONFIG_CRYPTO_USER_API_SKCIPHER=m
 CONFIG_CRYPTO_USER_API_RNG=m
 CONFIG_CRYPTO_USER_API_AEAD=m
 # CONFIG_CRYPTO_HW is not set
+CONFIG_PRIME_NUMBERS=m
 CONFIG_CRC32_SELFTEST=m
 CONFIG_CRC64=m
 CONFIG_XZ_DEC_TEST=m
@@ -623,6 +624,7 @@ CONFIG_TEST_OVERFLOW=m
 CONFIG_TEST_RHASHTABLE=m
 CONFIG_TEST_HASH=m
 CONFIG_TEST_IDA=m
+CONFIG_TEST_BITOPS=m
 CONFIG_TEST_VMALLOC=m
 CONFIG_TEST_USER_COPY=m
 CONFIG_TEST_BPF=m
diff --git a/arch/m68k/configs/multi_defconfig b/arch/m68k/configs/multi_defconfig
index 0abb53c38c20da1e..09fd5a8c58210829 100644
--- a/arch/m68k/configs/multi_defconfig
+++ b/arch/m68k/configs/multi_defconfig
@@ -681,6 +681,7 @@ CONFIG_CRYPTO_USER_API_SKCIPHER=m
 CONFIG_CRYPTO_USER_API_RNG=m
 CONFIG_CRYPTO_USER_API_AEAD=m
 # CONFIG_CRYPTO_HW is not set
+CONFIG_PRIME_NUMBERS=m
 CONFIG_CRC32_SELFTEST=m
 CONFIG_CRC64=m
 CONFIG_XZ_DEC_TEST=m
@@ -709,6 +710,7 @@ CONFIG_TEST_OVERFLOW=m
 CONFIG_TEST_RHASHTABLE=m
 CONFIG_TEST_HASH=m
 CONFIG_TEST_IDA=m
+CONFIG_TEST_BITOPS=m
 CONFIG_TEST_VMALLOC=m
 CONFIG_TEST_USER_COPY=m
 CONFIG_TEST_BPF=m
diff --git a/arch/m68k/configs/mvme147_defconfig b/arch/m68k/configs/mvme147_defconfig
index cb14c234d3adb335..487d8c3202514f5a 100644
--- a/arch/m68k/configs/mvme147_defconfig
+++ b/arch/m68k/configs/mvme147_defconfig
@@ -563,6 +563,7 @@ CONFIG_CRYPTO_USER_API_SKCIPHER=m
 CONFIG_CRYPTO_USER_API_RNG=m
 CONFIG_CRYPTO_USER_API_AEAD=m
 # CONFIG_CRYPTO_HW is not set
+CONFIG_PRIME_NUMBERS=m
 CONFIG_CRC32_SELFTEST=m
 CONFIG_CRC64=m
 CONFIG_XZ_DEC_TEST=m
@@ -591,6 +592,7 @@ CONFIG_TEST_OVERFLOW=m
 CONFIG_TEST_RHASHTABLE=m
 CONFIG_TEST_HASH=m
 CONFIG_TEST_IDA=m
+CONFIG_TEST_BITOPS=m
 CONFIG_TEST_VMALLOC=m
 CONFIG_TEST_USER_COPY=m
 CONFIG_TEST_BPF=m
diff --git a/arch/m68k/configs/mvme16x_defconfig b/arch/m68k/configs/mvme16x_defconfig
index e8a1920aded799b0..ed4c8f3b5bdcc553 100644
--- a/arch/m68k/configs/mvme16x_defconfig
+++ b/arch/m68k/configs/mvme16x_defconfig
@@ -564,6 +564,7 @@ CONFIG_CRYPTO_USER_API_SKCIPHER=m
 CONFIG_CRYPTO_USER_API_RNG=m
 CONFIG_CRYPTO_USER_API_AEAD=m
 # CONFIG_CRYPTO_HW is not set
+CONFIG_PRIME_NUMBERS=m
 CONFIG_CRC32_SELFTEST=m
 CONFIG_CRC64=m
 CONFIG_XZ_DEC_TEST=m
@@ -592,6 +593,7 @@ CONFIG_TEST_OVERFLOW=m
 CONFIG_TEST_RHASHTABLE=m
 CONFIG_TEST_HASH=m
 CONFIG_TEST_IDA=m
+CONFIG_TEST_BITOPS=m
 CONFIG_TEST_VMALLOC=m
 CONFIG_TEST_USER_COPY=m
 CONFIG_TEST_BPF=m
diff --git a/arch/m68k/configs/q40_defconfig b/arch/m68k/configs/q40_defconfig
index 2cbf416fc725b6ca..83b98f9aa72c8554 100644
--- a/arch/m68k/configs/q40_defconfig
+++ b/arch/m68k/configs/q40_defconfig
@@ -582,6 +582,7 @@ CONFIG_CRYPTO_USER_API_SKCIPHER=m
 CONFIG_CRYPTO_USER_API_RNG=m
 CONFIG_CRYPTO_USER_API_AEAD=m
 # CONFIG_CRYPTO_HW is not set
+CONFIG_PRIME_NUMBERS=m
 CONFIG_CRC32_SELFTEST=m
 CONFIG_CRC64=m
 CONFIG_XZ_DEC_TEST=m
@@ -610,6 +611,7 @@ CONFIG_TEST_OVERFLOW=m
 CONFIG_TEST_RHASHTABLE=m
 CONFIG_TEST_HASH=m
 CONFIG_TEST_IDA=m
+CONFIG_TEST_BITOPS=m
 CONFIG_TEST_VMALLOC=m
 CONFIG_TEST_USER_COPY=m
 CONFIG_TEST_BPF=m
diff --git a/arch/m68k/configs/sun3_defconfig b/arch/m68k/configs/sun3_defconfig
index fed3cc7abcc447f5..5baadb7a98b22557 100644
--- a/arch/m68k/configs/sun3_defconfig
+++ b/arch/m68k/configs/sun3_defconfig
@@ -566,6 +566,7 @@ CONFIG_CRYPTO_USER_API_SKCIPHER=m
 CONFIG_CRYPTO_USER_API_RNG=m
 CONFIG_CRYPTO_USER_API_AEAD=m
 # CONFIG_CRYPTO_HW is not set
+CONFIG_PRIME_NUMBERS=m
 CONFIG_CRC32_SELFTEST=m
 CONFIG_CRC64=m
 CONFIG_XZ_DEC_TEST=m
@@ -593,6 +594,7 @@ CONFIG_TEST_OVERFLOW=m
 CONFIG_TEST_RHASHTABLE=m
 CONFIG_TEST_HASH=m
 CONFIG_TEST_IDA=m
+CONFIG_TEST_BITOPS=m
 CONFIG_TEST_VMALLOC=m
 CONFIG_TEST_USER_COPY=m
 CONFIG_TEST_BPF=m
diff --git a/arch/m68k/configs/sun3x_defconfig b/arch/m68k/configs/sun3x_defconfig
index 0954fde256e6a5b5..3c54035283e6d5da 100644
--- a/arch/m68k/configs/sun3x_defconfig
+++ b/arch/m68k/configs/sun3x_defconfig
@@ -565,6 +565,7 @@ CONFIG_CRYPTO_USER_API_SKCIPHER=m
 CONFIG_CRYPTO_USER_API_RNG=m
 CONFIG_CRYPTO_USER_API_AEAD=m
 # CONFIG_CRYPTO_HW is not set
+CONFIG_PRIME_NUMBERS=m
 CONFIG_CRC32_SELFTEST=m
 CONFIG_CRC64=m
 CONFIG_XZ_DEC_TEST=m
@@ -593,6 +594,7 @@ CONFIG_TEST_OVERFLOW=m
 CONFIG_TEST_RHASHTABLE=m
 CONFIG_TEST_HASH=m
 CONFIG_TEST_IDA=m
+CONFIG_TEST_BITOPS=m
 CONFIG_TEST_VMALLOC=m
 CONFIG_TEST_USER_COPY=m
 CONFIG_TEST_BPF=m
-- 
2.17.1

