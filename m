Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 747F5C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 19:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48181205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 19:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580412100;
	bh=m+EcIgQC/GofOlRY1TMJm7R9R/KYSOFSVU2IHy53unw=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=jSTbEeQknstMlDXkMYaiGfTpr+EMvp82LqfvBYk9yz863rpJ9qOHWDSrG0S4djH35
	 hFYAFFDxJpwQPurs/VLo8jTumkncAoCaIBsnV/D8O0K98sUKWUdV2KkW+AjoIp4Ghi
	 AG9ICMPs18KS6THS2LPF/tfexPKi7HuMetkqBDeQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbgA3TVj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 14:21:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:45080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727538AbgA3TVj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 14:21:39 -0500
Received: from localhost.localdomain (unknown [194.230.155.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 280B8205F4;
        Thu, 30 Jan 2020 19:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580412098;
        bh=m+EcIgQC/GofOlRY1TMJm7R9R/KYSOFSVU2IHy53unw=;
        h=From:To:Cc:Subject:Date:From;
        b=TeR/acdNh5Noqc2Es+qT+b9HGWRosSlSMU8mUiozMxhuzAIdJ5EQ17HhYMHlcreQj
         Sx7MlxG0vgBYF9VKwLGSxdMlaXE7/MqGiFuwHW8PYZ2DrxEEz+qgo5Q+0WkDcxhFnU
         +6IO4vop1tYpftmnbnKaKWhFc3asjH9yUNulAGMo=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] xtensa: configs: Cleanup old Kconfig IO scheduler options
Date:   Thu, 30 Jan 2020 20:21:29 +0100
Message-Id: <20200130192129.2677-1-krzk@kernel.org>
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
 arch/xtensa/configs/audio_kc705_defconfig   | 2 --
 arch/xtensa/configs/cadence_csp_defconfig   | 2 --
 arch/xtensa/configs/generic_kc705_defconfig | 2 --
 arch/xtensa/configs/iss_defconfig           | 2 --
 arch/xtensa/configs/nommu_kc705_defconfig   | 2 --
 arch/xtensa/configs/smp_lx200_defconfig     | 2 --
 6 files changed, 12 deletions(-)

diff --git a/arch/xtensa/configs/audio_kc705_defconfig b/arch/xtensa/configs/audio_kc705_defconfig
index b6367af71d65..eeb4c5383c83 100644
--- a/arch/xtensa/configs/audio_kc705_defconfig
+++ b/arch/xtensa/configs/audio_kc705_defconfig
@@ -21,8 +21,6 @@ CONFIG_PROFILING=y
 CONFIG_OPROFILE=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
-# CONFIG_IOSCHED_DEADLINE is not set
-# CONFIG_IOSCHED_CFQ is not set
 CONFIG_XTENSA_VARIANT_CUSTOM=y
 CONFIG_XTENSA_VARIANT_CUSTOM_NAME="test_kc705_hifi"
 CONFIG_XTENSA_UNALIGNED_USER=y
diff --git a/arch/xtensa/configs/cadence_csp_defconfig b/arch/xtensa/configs/cadence_csp_defconfig
index f4eef6decd2a..fc240737b14d 100644
--- a/arch/xtensa/configs/cadence_csp_defconfig
+++ b/arch/xtensa/configs/cadence_csp_defconfig
@@ -27,8 +27,6 @@ CONFIG_MODULES=y
 CONFIG_MODULE_FORCE_LOAD=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_MODULE_FORCE_UNLOAD=y
-# CONFIG_IOSCHED_DEADLINE is not set
-# CONFIG_IOSCHED_CFQ is not set
 CONFIG_XTENSA_VARIANT_CUSTOM=y
 CONFIG_XTENSA_VARIANT_CUSTOM_NAME="csp"
 CONFIG_XTENSA_UNALIGNED_USER=y
diff --git a/arch/xtensa/configs/generic_kc705_defconfig b/arch/xtensa/configs/generic_kc705_defconfig
index c925165cf760..412f611033cc 100644
--- a/arch/xtensa/configs/generic_kc705_defconfig
+++ b/arch/xtensa/configs/generic_kc705_defconfig
@@ -21,8 +21,6 @@ CONFIG_PROFILING=y
 CONFIG_OPROFILE=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
-# CONFIG_IOSCHED_DEADLINE is not set
-# CONFIG_IOSCHED_CFQ is not set
 CONFIG_XTENSA_VARIANT_DC233C=y
 CONFIG_XTENSA_UNALIGNED_USER=y
 CONFIG_PREEMPT=y
diff --git a/arch/xtensa/configs/iss_defconfig b/arch/xtensa/configs/iss_defconfig
index d1c01742baf4..32ce8fb068f0 100644
--- a/arch/xtensa/configs/iss_defconfig
+++ b/arch/xtensa/configs/iss_defconfig
@@ -1,8 +1,6 @@
 CONFIG_SYSVIPC=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_EXPERT=y
-# CONFIG_IOSCHED_DEADLINE is not set
-# CONFIG_IOSCHED_CFQ is not set
 # CONFIG_PCI is not set
 CONFIG_CMDLINE_BOOL=y
 CONFIG_CMDLINE="console=ttyS0,38400 eth0=tuntap,,tap0 ip=192.168.168.5:192.168.168.1 root=nfs nfsroot=192.168.168.1:/opt/montavista/pro/devkit/xtensa/linux_be/target memmap=128M@0"
diff --git a/arch/xtensa/configs/nommu_kc705_defconfig b/arch/xtensa/configs/nommu_kc705_defconfig
index 380e366730d5..88b2e222d4bf 100644
--- a/arch/xtensa/configs/nommu_kc705_defconfig
+++ b/arch/xtensa/configs/nommu_kc705_defconfig
@@ -25,8 +25,6 @@ CONFIG_KALLSYMS_ALL=y
 CONFIG_PERF_EVENTS=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
-# CONFIG_IOSCHED_DEADLINE is not set
-# CONFIG_IOSCHED_CFQ is not set
 CONFIG_XTENSA_VARIANT_CUSTOM=y
 CONFIG_XTENSA_VARIANT_CUSTOM_NAME="de212"
 # CONFIG_XTENSA_VARIANT_MMU is not set
diff --git a/arch/xtensa/configs/smp_lx200_defconfig b/arch/xtensa/configs/smp_lx200_defconfig
index d46b58f34098..8b3bc92a079c 100644
--- a/arch/xtensa/configs/smp_lx200_defconfig
+++ b/arch/xtensa/configs/smp_lx200_defconfig
@@ -21,8 +21,6 @@ CONFIG_PROFILING=y
 CONFIG_OPROFILE=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
-# CONFIG_IOSCHED_DEADLINE is not set
-# CONFIG_IOSCHED_CFQ is not set
 CONFIG_XTENSA_VARIANT_CUSTOM=y
 CONFIG_XTENSA_VARIANT_CUSTOM_NAME="test_mmuhifi_c3"
 CONFIG_XTENSA_UNALIGNED_USER=y
-- 
2.17.1

