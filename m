Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC43C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 06:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3D32207D3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 06:41:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="bmB1UJf8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbgE1GlO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 02:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726459AbgE1GlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 02:41:11 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C3EC05BD1E
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 23:41:11 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id ci23so2576421pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 23:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=82NB9lCPMwXynDeXK6u4yXJsBZGIDVjhoL3cA6mdRsQ=;
        b=bmB1UJf8gpuxPRCB+XRx67sSBKWiEBE/R42DEzA16KYeAq+ifi6W6BVWNSYpIefiYJ
         7RN8ZZJFBEbGfW/JCCMgkkUvSZMeP73CDEa7jWyI5U7pPXSv7HUGq4aBNuKAJjg7Ku8I
         goPQSW/uLYwP1PxWl1Vpq6FAcda4NJDG7Pfi939kYjkC6jlyJJRnFMv7r1Cy9MILKKyV
         oTyMne95DQOxrtjoJcxe+2xsaJhk96jUPjuWqvWWwGOWoprpY/siIqHrBqnPuLT6Z1VA
         rc/fNcT+2Wj3VTdlb4OQgHEhOtvC9VpA+zOfEghDLbpHc0xHaKd9g3T+NrKrA8yzDbro
         TjgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=82NB9lCPMwXynDeXK6u4yXJsBZGIDVjhoL3cA6mdRsQ=;
        b=qX3m/9QljaMSy0oIeAvnu6dlVx0ovWfZ/vevC0VdE7iGeEYipqhhdBb84uiSjh9ykm
         YHDDz2S/e6j7ODzeD9O1X/GV9wSEF/dvFbEd8N1+b6y1S+u0pBS5wv0h5n8zbFXkHVZH
         NoisgvQfnHwBq08IGB5H+Bza/ItbzbMcBtmgJ7Ad3TE3W9ZCXJqls5O4/haGtddMB3Ls
         MLIXuXoyrfhQUua5dw65utmdIvA3XVDEhBq0lo2ixG6j2j3OUlV67xA5U65Uoq64vVQI
         yMO3QrEZSRGlT9wCpxmDJev4BqxZO+k3/O2GxqaIa74Q6SeZ4Kt1fuKRsWw63gWk533n
         j8ug==
X-Gm-Message-State: AOAM532XrXJCBtoJDVA/EbfgMXH2SUK2M9BZW8EPCmCNIvYMgIvtRDqK
        5KK4HuF9jfJgiUbm0BiF1gqvxQ==
X-Google-Smtp-Source: ABdhPJwJxYGvMR1o+/BSgiQ889SGEkiIRZp44iAixVFd5RbTS+e+kjD7BYVeV/PDAFwFmuWjgHrBPw==
X-Received: by 2002:a17:902:7002:: with SMTP id y2mr2053163plk.94.1590648070946;
        Wed, 27 May 2020 23:41:10 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id q29sm3773366pfg.79.2020.05.27.23.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 23:41:10 -0700 (PDT)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     greentime.hu@sifive.com, guoren@linux.alibaba.com,
        vincent.chen@sifive.com, paul.walmsley@sifive.com,
        palmerdabbelt@google.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, oleg@redhat.com
Subject: [RFC PATCH v5 02/13] riscv: Separate patch for cflags and aflags
Date:   Thu, 28 May 2020 14:40:50 +0800
Message-Id: <c4e9f2ffc5b60c208e7c35d250dbc0f0cfde8bac.1590646208.git.greentime.hu@sifive.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1590646208.git.greentime.hu@sifive.com>
References: <cover.1590646208.git.greentime.hu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index fb6e37db836d..957d064bead0 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -37,12 +37,18 @@ else
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
2.26.2

