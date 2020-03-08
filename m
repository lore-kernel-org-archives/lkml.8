Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A033FC10F28
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 09:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78FC12084E
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 09:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583661204;
	bh=a+fEawxUrmRXxmSzSy/C7nojpkQvXf9neNEOdNooh+Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BuBrd8M/B8ISJ4qTgh43EdDJ7lZKNbhtJ6axnRizwpxXjcr++982yeP5GcAtYHUM7
	 zKyBlqk0B8YR2OnhgG5HOTPPXPGmLVXp5/tMqBfCQRuo6p98rUYGpSmIZCtss7oSQI
	 daO7qpVb+aMgjQA8wG9wVeXSAKyOROR5otYUn5fg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbgCHJxX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 05:53:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:37156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725306AbgCHJxW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 05:53:22 -0400
Received: from localhost.localdomain (unknown [89.208.247.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3A3220828;
        Sun,  8 Mar 2020 09:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583661202;
        bh=a+fEawxUrmRXxmSzSy/C7nojpkQvXf9neNEOdNooh+Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eowOCkteI7Hf21jyWkewxxreP87MDWIRPPkAP3C2tqj0EycanQMnp9TkLmAWqCEd+
         cD8rWoNCZh+kj2Z6JktJW/B08sqaeCspHXpHIFhdK+sm8zgMF0mNSqO81Mdk4vswHQ
         TLTKMuNiSgGkvBNzRu5YPu1lQEC7MnJ6t4JCP+D4=
From:   guoren@kernel.org
To:     paul.walmsley@sifive.com, palmer@dabbelt.com, Anup.Patel@wdc.com,
        greentime.hu@sifive.com
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        arnd@arndb.de, linux-csky@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Dave Martin <Dave.Martin@arm.com>
Subject: [RFC PATCH V3 01/11] riscv: Separate patch for cflags and aflags
Date:   Sun,  8 Mar 2020 17:49:44 +0800
Message-Id: <20200308094954.13258-2-guoren@kernel.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20200308094954.13258-1-guoren@kernel.org>
References: <20200308094954.13258-1-guoren@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

From: Guo Ren <ren_guo@c-sky.com>

Use "subst fd" in Makefile is a hack way and it's not convenient
to add new ISA feature. Just separate them into riscv-march-cflags
and riscv-march-aflags.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
---
 arch/riscv/Makefile | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index b9009a2fbaf5..6d09b53cf106 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -35,12 +35,18 @@ else
 endif
 
 # ISA string setting
-riscv-march-$(CONFIG_ARCH_RV32I)	:= rv32ima
-riscv-march-$(CONFIG_ARCH_RV64I)	:= rv64ima
-riscv-march-$(CONFIG_FPU)		:= $(riscv-march-y)fd
-riscv-march-$(CONFIG_RISCV_ISA_C)	:= $(riscv-march-y)c
-KBUILD_CFLAGS += -march=$(subst fd,,$(riscv-march-y))
-KBUILD_AFLAGS += -march=$(riscv-march-y)
+riscv-march-cflags-$(CONFIG_ARCH_RV32I)		:= rv32ima
+riscv-march-cflags-$(CONFIG_ARCH_RV64I)		:= rv64ima
+riscv-march-$(CONFIG_FPU)			:= $(riscv-march-y)fd
+riscv-march-cflags-$(CONFIG_RISCV_ISA_C)	:= $(riscv-march-cflags-y)c
+
+riscv-march-aflags-$(CONFIG_ARCH_RV32I)		:= rv32ima
+riscv-march-aflags-$(CONFIG_ARCH_RV64I)		:= rv64ima
+riscv-march-aflags-$(CONFIG_FPU)		:= $(riscv-march-aflags-y)fd
+riscv-march-aflags-$(CONFIG_RISCV_ISA_C)	:= $(riscv-march-aflags-y)c
+
+KBUILD_CFLAGS += -march=$(riscv-march-cflags-y)
+KBUILD_AFLAGS += -march=$(riscv-march-aflags-y)
 
 KBUILD_CFLAGS += -mno-save-restore
 KBUILD_CFLAGS += -DCONFIG_PAGE_OFFSET=$(CONFIG_PAGE_OFFSET)
-- 
2.17.0

