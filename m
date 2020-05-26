Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC43C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 12:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47B9A207CB
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 12:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590496722;
	bh=7sWwvbTO9gBNQda3V8EVFgpQp6LmhL2AYXbcceYmj/4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CaI0B6kYp0kxxNd3BeuAf9PDcYXeV82uqkG4QWX6v04/KJYQVkV8VN1tHtAwJBBvS
	 IYYF4uSF4gc7pYgv1PcmNzszpbredmvZkXuA3NCBVYqp+/C1CFdyDzWWDTtfFx1qNx
	 ijhwau5fsVQ5c2r+nQHHP539ss1aquAQKSQ7Q2QQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389163AbgEZMil (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 08:38:41 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:39428 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388497AbgEZMik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 08:38:40 -0400
Received: from oscar.flets-west.jp (softbank126090202047.bbtec.net [126.90.202.47]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id 04QCcC2t029236;
        Tue, 26 May 2020 21:38:14 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 04QCcC2t029236
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1590496695;
        bh=mIdbxavok04+TKKVUbbzIeHuMzoZETrO8wGd76j+Sz8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nxb2d5cYIcSoLep1eWb2d51KTjH7dV2pw6w3ci9BfxhEKySSG0wPanfrIMqcbtRpy
         WPOfNqpF6oxuMK4YQcRHRehioW+KnyooO4K8cHDo6kqTKDai6CGIkIwMACC7IDDOsn
         QqqelZvXT7nV9AYMEZtgIYsuaDs/bUw64oO4rgWQi1XzBgYUPIjNzeQzD7TFLE1XBN
         m0ojF6uVwBawgSBZGAzLlWvWBs+RZF2IyUJW+NxYKsvEKQwTd5E9sdwk+R2RJcLRk3
         zrLfKfaE5w/9hyjQZ74zo0YVKAV21QylrBdecqFd89j+RU8NVVDsNtQ6w3efZI8Nhl
         3IotbvE3ViiJQ==
X-Nifty-SrcIP: [126.90.202.47]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] m68k: optimize cc-option calls for cpuflags-y
Date:   Tue, 26 May 2020 21:38:09 +0900
Message-Id: <20200526123810.301667-3-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200526123810.301667-1-masahiroy@kernel.org>
References: <20200526123810.301667-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arch/m68k/Makefile computes lots of unneeded cc-option calls.

For example, if CONFIG_M5441x is not defined, there is not point in
evaluating the following compiler flag.

 cpuflags-$(CONFIG_M5441x)      := $(call cc-option,-mcpu=54455,-mcfv4e)

The result is set to cpuflags-, then thrown away.

The right hand side of ':=' is immediately expanded. Hence, all of the
16 calls for cc-option are evaluated. This is expensive since cc-option
invokes the compiler. This occurs even if you are not attempting to
build anything, like 'make ARCH=m68k help'.

Use '=' to expand the value _lazily_. The evaluation for cc-option is
delayed until $(cpuflags-y) is expanded. So, the cc-option test happens
just once at most.

This commit mimics tune-y of arch/arm/Makefile.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/m68k/Makefile | 45 ++++++++++++++++++++++++---------------------
 1 file changed, 24 insertions(+), 21 deletions(-)

diff --git a/arch/m68k/Makefile b/arch/m68k/Makefile
index 88d4d8bbecd6..ae6e29da3a3e 100644
--- a/arch/m68k/Makefile
+++ b/arch/m68k/Makefile
@@ -32,30 +32,33 @@ endif
 #	compiler cpu type flag.
 #
 ifndef CONFIG_M68040
-cpuflags-$(CONFIG_M68060)	:= -m68060
+cpuflags-$(CONFIG_M68060)	= -m68060
 endif
 ifndef CONFIG_M68060
-cpuflags-$(CONFIG_M68040)	:= -m68040
+cpuflags-$(CONFIG_M68040)	= -m68040
 endif
-cpuflags-$(CONFIG_M68030)	:=
-cpuflags-$(CONFIG_M68020)	:=
-cpuflags-$(CONFIG_M68000)	:= -m68000
-cpuflags-$(CONFIG_M5441x)	:= $(call cc-option,-mcpu=54455,-mcfv4e)
-cpuflags-$(CONFIG_M54xx)	:= $(call cc-option,-mcpu=5475,-m5200)
-cpuflags-$(CONFIG_M5407)	:= $(call cc-option,-mcpu=5407,-m5200)
-cpuflags-$(CONFIG_M532x)	:= $(call cc-option,-mcpu=532x,-m5307)
-cpuflags-$(CONFIG_M537x)	:= $(call cc-option,-mcpu=537x,-m5307)
-cpuflags-$(CONFIG_M5307)	:= $(call cc-option,-mcpu=5307,-m5200)
-cpuflags-$(CONFIG_M528x)	:= $(call cc-option,-mcpu=528x,-m5307)
-cpuflags-$(CONFIG_M5275)	:= $(call cc-option,-mcpu=5275,-m5307)
-cpuflags-$(CONFIG_M5272)	:= $(call cc-option,-mcpu=5272,-m5307)
-cpuflags-$(CONFIG_M5271)	:= $(call cc-option,-mcpu=5271,-m5307)
-cpuflags-$(CONFIG_M523x)	:= $(call cc-option,-mcpu=523x,-m5307)
-cpuflags-$(CONFIG_M525x)	:= $(call cc-option,-mcpu=5253,-m5200)
-cpuflags-$(CONFIG_M5249)	:= $(call cc-option,-mcpu=5249,-m5200)
-cpuflags-$(CONFIG_M520x)	:= $(call cc-option,-mcpu=5208,-m5200)
-cpuflags-$(CONFIG_M5206e)	:= $(call cc-option,-mcpu=5206e,-m5200)
-cpuflags-$(CONFIG_M5206)	:= $(call cc-option,-mcpu=5206,-m5200)
+cpuflags-$(CONFIG_M68030)	=
+cpuflags-$(CONFIG_M68020)	=
+cpuflags-$(CONFIG_M68000)	= -m68000
+cpuflags-$(CONFIG_M5441x)	= $(call cc-option,-mcpu=54455,-mcfv4e)
+cpuflags-$(CONFIG_M54xx)	= $(call cc-option,-mcpu=5475,-m5200)
+cpuflags-$(CONFIG_M5407)	= $(call cc-option,-mcpu=5407,-m5200)
+cpuflags-$(CONFIG_M532x)	= $(call cc-option,-mcpu=532x,-m5307)
+cpuflags-$(CONFIG_M537x)	= $(call cc-option,-mcpu=537x,-m5307)
+cpuflags-$(CONFIG_M5307)	= $(call cc-option,-mcpu=5307,-m5200)
+cpuflags-$(CONFIG_M528x)	= $(call cc-option,-mcpu=528x,-m5307)
+cpuflags-$(CONFIG_M5275)	= $(call cc-option,-mcpu=5275,-m5307)
+cpuflags-$(CONFIG_M5272)	= $(call cc-option,-mcpu=5272,-m5307)
+cpuflags-$(CONFIG_M5271)	= $(call cc-option,-mcpu=5271,-m5307)
+cpuflags-$(CONFIG_M523x)	= $(call cc-option,-mcpu=523x,-m5307)
+cpuflags-$(CONFIG_M525x)	= $(call cc-option,-mcpu=5253,-m5200)
+cpuflags-$(CONFIG_M5249)	= $(call cc-option,-mcpu=5249,-m5200)
+cpuflags-$(CONFIG_M520x)	= $(call cc-option,-mcpu=5208,-m5200)
+cpuflags-$(CONFIG_M5206e)	= $(call cc-option,-mcpu=5206e,-m5200)
+cpuflags-$(CONFIG_M5206)	= $(call cc-option,-mcpu=5206,-m5200)
+
+# Evaluate tune cc-option calls now
+cpuflags-y := $(cpuflags-y)
 
 KBUILD_AFLAGS += $(cpuflags-y)
 KBUILD_CFLAGS += $(cpuflags-y)
-- 
2.25.1

