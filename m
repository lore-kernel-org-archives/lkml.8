Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F83EC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 07:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A61F2081A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 07:10:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="f1Z7wn8O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbgFLHK3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 03:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbgFLHKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 03:10:24 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5462AC03E96F
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 00:10:24 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id l63so1466753pge.12
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 00:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=4+NJ3t8NefDvMBlOVrpO6HJOHxIomSxMyV3y0MN34qw=;
        b=f1Z7wn8ODMszNV5yRo5L00AOwSuvcWankDXBey/J0QSLJG9bar/NSgUX25Wf91d1YQ
         5jTTw17cQ1hw7xOBPBBQ9dTwf/asfw6P4tueUtHCjF6xfDYqvxV+RbjLrEf3JSYufQrq
         SVFqIwb6LJdn0xkyOOzidLm8X73EuPp9qtXWZORQIpHfsKWED3a62HM+Y6vnNy8R9OYX
         mZnTkDgGWrW/CVOneAPhCKGFArrxn/ktvFFwvSZppc2iPRm8nHWorVISFKCnohdbsYEc
         xMtJi/eOG58tRvohlc9pV8PNIPF5KlTlxs79VRmAmjTH/CXwVma5BI1Ymc36kILlHImI
         D+0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4+NJ3t8NefDvMBlOVrpO6HJOHxIomSxMyV3y0MN34qw=;
        b=EaDgv2H854pZBZN1lFsneBQkq6buYxj2xmKhb3kgJpPuUIxrFjV5sHJi5MFFNUcfTz
         daAHz5tAmmIiNQlXKM0Yux20quxaALkbphdcuXCn0toUIrLWNVqEfE/pMUr0TB5P+2ib
         Z3P/DxSVofeJiMKpVcFQ7W++7ZH21cRqcCTKsM+DTZcy5EzSfbVCz4mccCaJLzPcvHKJ
         DrJ47OFEEaMR4OiVH2cidhi6/aird0gBFXvC1MOABnSjju5qt2fXRU1w2OZ7KHdT55FT
         P752abbNZYuqLnUvKH3Q/5Xowac7lphc6SrtBoWIJWu3HEHP0mem+BMaKCqrWOfYDaov
         iBNg==
X-Gm-Message-State: AOAM531SElBbY3rzswXrUSLASi0qgkZPduaDAoFWteCkQIWS8bzC3Li2
        UzILYeYZR8kvBxEB7Yc7sPlcoA==
X-Google-Smtp-Source: ABdhPJxIEogp+RWDoHXMgGJLewWmgiLwJtVEzXgBro7HgtTSJx6CPinawDSwZAjC+NoKJKtLZwdlng==
X-Received: by 2002:aa7:9439:: with SMTP id y25mr10621687pfo.268.1591945823802;
        Fri, 12 Jun 2020 00:10:23 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id d2sm4336919pgp.56.2020.06.12.00.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 00:10:23 -0700 (PDT)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     greentime.hu@sifive.com, oleg@redhat.com, guoren@linux.alibaba.com,
        vincent.chen@sifive.com, paul.walmsley@sifive.com,
        palmerdabbelt@google.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 06/13] riscv: Add vector feature to compile
Date:   Fri, 12 Jun 2020 15:09:55 +0800
Message-Id: <cd64796afb84d9f3d97168fbfead633c15f68ce3.1591344965.git.greentime.hu@sifive.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1591344965.git.greentime.hu@sifive.com>
References: <cover.1591344965.git.greentime.hu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

This patch adds a new config option which could enable assembler's
vector feature.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
---
 arch/riscv/Kconfig  | 9 +++++++++
 arch/riscv/Makefile | 1 +
 2 files changed, 10 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 74f82cf4f781..3b742d949a09 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -305,6 +305,15 @@ config FPU
 
 	  If you don't know what to do here, say Y.
 
+config VECTOR
+	bool "VECTOR support"
+	default n
+	help
+	  Say N here if you want to disable all vector related procedure
+	  in the kernel.
+
+	  If you don't know what to do here, say Y.
+
 endmenu
 
 menu "Kernel features"
diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index 957d064bead0..7c80c95582e3 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -46,6 +46,7 @@ riscv-march-aflags-$(CONFIG_ARCH_RV32I)		:= rv32ima
 riscv-march-aflags-$(CONFIG_ARCH_RV64I)		:= rv64ima
 riscv-march-aflags-$(CONFIG_FPU)		:= $(riscv-march-aflags-y)fd
 riscv-march-aflags-$(CONFIG_RISCV_ISA_C)	:= $(riscv-march-aflags-y)c
+riscv-march-aflags-$(CONFIG_VECTOR)		:= $(riscv-march-aflags-y)v
 
 KBUILD_CFLAGS += -march=$(riscv-march-cflags-y)
 KBUILD_AFLAGS += -march=$(riscv-march-aflags-y)
-- 
2.27.0

