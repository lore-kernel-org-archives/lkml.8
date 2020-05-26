Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5490C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 12:38:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B39B72084C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 12:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590496720;
	bh=osBh4zVQIh4ah+88vINfhsb5MnXLR2rS+dPWGxjmg28=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=CEuq4bANaRAPA1b2XMmRalaCYnWo2A9kASewgFtDt/69JoPgiBRh9ajK6p7r35DWF
	 LF6HBFSols+GN2YX7+uP6q49Vg760yxsuO0piqSjkvJCNsZu5y0Cjm9cbytePbqSFP
	 bKsOM9X16eEqfKvaw2dsgcoC8uHl5x+YFNPNeaxc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389153AbgEZMij (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 08:38:39 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:39344 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388946AbgEZMii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 08:38:38 -0400
Received: from oscar.flets-west.jp (softbank126090202047.bbtec.net [126.90.202.47]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id 04QCcC2r029236;
        Tue, 26 May 2020 21:38:13 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 04QCcC2r029236
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1590496693;
        bh=muAvqASTjgzmWxG2DbaZN+wdfT+dce4XSn882r2oWRs=;
        h=From:To:Cc:Subject:Date:From;
        b=VJg1R87s7vS7WjizCR1Gp0bWNSYDCpcuA/7ccATL5Xk5jh5WeXB+uPZys/Ih0AkKU
         QTr9hDlzqtDSobfOkGWJAQNG0mm1HpfIGxEpg2Yl6QHA/DKAQlhv2OoN1d8U9Ae3KV
         4J/4nNdRm772kgfidsnariTHGQ8BPZi9bhDjbi/XFwPGrquvPBkLlH3nIkjzWEC/i1
         Hht1NnHWvKZbRzmofO4k3Zpg35T8sVa1UzQlPiFZW05zqfX7vG2QKiX/TTouVBq0l9
         QcANO2bY7+UgP8AR7IHL2mAjco3pZCPkl0V4yv73PuaRCmTEGToO1Iyl9etIF7fgS3
         acTCBj3AipLDQ==
X-Nifty-SrcIP: [126.90.202.47]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] m68k: add arch/m68k/Kbuild
Date:   Tue, 26 May 2020 21:38:07 +0900
Message-Id: <20200526123810.301667-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the standard obj-y form to specify the sub-directories under
arch/m68k/. No functional change intended.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/m68k/Kbuild   | 19 +++++++++++++++++++
 arch/m68k/Makefile | 20 +-------------------
 2 files changed, 20 insertions(+), 19 deletions(-)
 create mode 100644 arch/m68k/Kbuild

diff --git a/arch/m68k/Kbuild b/arch/m68k/Kbuild
new file mode 100644
index 000000000000..7dc1398dd188
--- /dev/null
+++ b/arch/m68k/Kbuild
@@ -0,0 +1,19 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-y				+= kernel/ mm/
+obj-$(CONFIG_Q40)		+= q40/
+obj-$(CONFIG_AMIGA)		+= amiga/
+obj-$(CONFIG_ATARI)		+= atari/
+obj-$(CONFIG_MAC)		+= mac/
+obj-$(CONFIG_HP300)		+= hp300/
+obj-$(CONFIG_APOLLO)		+= apollo/
+obj-$(CONFIG_MVME147)		+= mvme147/
+obj-$(CONFIG_MVME16x)		+= mvme16x/
+obj-$(CONFIG_BVME6000)		+= bvme6000/
+obj-$(CONFIG_SUN3X)		+= sun3x/ sun3/
+obj-$(CONFIG_SUN3)		+= sun3/ sun3/prom/
+obj-$(CONFIG_NATFEAT)		+= emu/
+obj-$(CONFIG_M68040)		+= fpsp040/
+obj-$(CONFIG_M68060)		+= ifpsp060/
+obj-$(CONFIG_M68KFPU_EMU)	+= math-emu/
+obj-$(CONFIG_M68000)		+= 68000/
+obj-$(CONFIG_COLDFIRE)		+= coldfire/
diff --git a/arch/m68k/Makefile b/arch/m68k/Makefile
index 5d9288384096..88d4d8bbecd6 100644
--- a/arch/m68k/Makefile
+++ b/arch/m68k/Makefile
@@ -97,27 +97,9 @@ head-$(CONFIG_SUN3)		:= arch/m68k/kernel/sun3-head.o
 head-$(CONFIG_M68000)		:= arch/m68k/68000/head.o
 head-$(CONFIG_COLDFIRE)		:= arch/m68k/coldfire/head.o
 
-core-y				+= arch/m68k/kernel/	arch/m68k/mm/
+core-y				+= arch/m68k/
 libs-y				+= arch/m68k/lib/
 
-core-$(CONFIG_Q40)		+= arch/m68k/q40/
-core-$(CONFIG_AMIGA)		+= arch/m68k/amiga/
-core-$(CONFIG_ATARI)		+= arch/m68k/atari/
-core-$(CONFIG_MAC)		+= arch/m68k/mac/
-core-$(CONFIG_HP300)		+= arch/m68k/hp300/
-core-$(CONFIG_APOLLO)		+= arch/m68k/apollo/
-core-$(CONFIG_MVME147)		+= arch/m68k/mvme147/
-core-$(CONFIG_MVME16x)		+= arch/m68k/mvme16x/
-core-$(CONFIG_BVME6000)		+= arch/m68k/bvme6000/
-core-$(CONFIG_SUN3X)		+= arch/m68k/sun3x/	arch/m68k/sun3/
-core-$(CONFIG_SUN3)		+= arch/m68k/sun3/	arch/m68k/sun3/prom/
-core-$(CONFIG_NATFEAT)		+= arch/m68k/emu/
-core-$(CONFIG_M68040)		+= arch/m68k/fpsp040/
-core-$(CONFIG_M68060)		+= arch/m68k/ifpsp060/
-core-$(CONFIG_M68KFPU_EMU)	+= arch/m68k/math-emu/
-core-$(CONFIG_M68000)		+= arch/m68k/68000/
-core-$(CONFIG_COLDFIRE)		+= arch/m68k/coldfire/
-
 
 all:	zImage
 
-- 
2.25.1

