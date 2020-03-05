Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC33C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 17:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95A1224655
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 17:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583428410;
	bh=qeSR8s+xjYKgRtoXDhAo+RN2PMmTP5CX+CKt41Yu3xQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=B0uE8Twi0h+o6hYDQR3vu3Fj5x6VInXCzc5HYAgtiYgSPPxulMqQLho7VXZ6zXbHk
	 oiPBDrJzVwzBVrpkQFHtWIFGBu0NkTPTjvuoY2nRM6zKLZi0NvO4qzhoyBjXfncUBV
	 MMBL/wal5J3DY6YTV+ORDuUZLWU8NESYcc41tLkk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbgCERN3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 12:13:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:38874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726846AbgCERNZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 12:13:25 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B35252166E;
        Thu,  5 Mar 2020 17:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583428405;
        bh=qeSR8s+xjYKgRtoXDhAo+RN2PMmTP5CX+CKt41Yu3xQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gCgsaGCNXbb+2j/PbE5Zzb+j1oApB6P4z0MPovpsN1sivbjbce4Nm/RSi76li7GgV
         cV2i/6SPDRK+l6Rhw93iOHdHwYYZO4qynMU0FNg3qW/GCWU0hiSLypDGJ74XyE4DII
         4ftnWr08bIvpK7XIMBzhIZw+MtD407KDITi5C/2E=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Paul Burton <paulburton@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-mips@vger.kernel.org
Subject: [PATCH AUTOSEL 5.5 11/67] MIPS: Disable VDSO time functionality on microMIPS
Date:   Thu,  5 Mar 2020 12:12:12 -0500
Message-Id: <20200305171309.29118-11-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200305171309.29118-1-sashal@kernel.org>
References: <20200305171309.29118-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Burton <paulburton@kernel.org>

[ Upstream commit 07015d7a103c4420b69a287b8ef4d2535c0f4106 ]

A check we're about to add to pick up on function calls that depend on
bogus use of the GOT in the VDSO picked up on instances of such function
calls in microMIPS builds. Since the code appears genuinely problematic,
and given the relatively small amount of use & testing that microMIPS
sees, go ahead & disable the VDSO for microMIPS builds.

Signed-off-by: Paul Burton <paulburton@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/vdso/Makefile | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/arch/mips/vdso/Makefile b/arch/mips/vdso/Makefile
index 96afd73c94e8a..e8585a22b925c 100644
--- a/arch/mips/vdso/Makefile
+++ b/arch/mips/vdso/Makefile
@@ -48,6 +48,8 @@ endif
 
 CFLAGS_REMOVE_vgettimeofday.o = -pg
 
+DISABLE_VDSO := n
+
 #
 # For the pre-R6 code in arch/mips/vdso/vdso.h for locating
 # the base address of VDSO, the linker will emit a R_MIPS_PC32
@@ -61,11 +63,24 @@ CFLAGS_REMOVE_vgettimeofday.o = -pg
 ifndef CONFIG_CPU_MIPSR6
   ifeq ($(call ld-ifversion, -lt, 225000000, y),y)
     $(warning MIPS VDSO requires binutils >= 2.25)
-    obj-vdso-y := $(filter-out vgettimeofday.o, $(obj-vdso-y))
-    ccflags-vdso += -DDISABLE_MIPS_VDSO
+    DISABLE_VDSO := y
   endif
 endif
 
+#
+# GCC (at least up to version 9.2) appears to emit function calls that make use
+# of the GOT when targeting microMIPS, which we can't use in the VDSO due to
+# the lack of relocations. As such, we disable the VDSO for microMIPS builds.
+#
+ifdef CONFIG_CPU_MICROMIPS
+  DISABLE_VDSO := y
+endif
+
+ifeq ($(DISABLE_VDSO),y)
+  obj-vdso-y := $(filter-out vgettimeofday.o, $(obj-vdso-y))
+  ccflags-vdso += -DDISABLE_MIPS_VDSO
+endif
+
 # VDSO linker flags.
 VDSO_LDFLAGS := \
 	-Wl,-Bsymbolic -Wl,--no-undefined -Wl,-soname=linux-vdso.so.1 \
-- 
2.20.1

