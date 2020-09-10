Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA49FC43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 08:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C36420829
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 08:17:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="azD4MkWS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730203AbgIJIRs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 04:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729005AbgIJIMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 04:12:48 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A4DC061573
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 01:12:47 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id z19so4176335pfn.8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 01:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jTWmtcACzAQn5qJ6Bhs/uGk8LJx7IP1Lqtl0V+UVL/4=;
        b=azD4MkWSBr7dTIgX/UNno4IJiwn9U8nNOQ8s9HUsHeqnVRrnURFEzjZT9lcM7D6ZOq
         Qtcc/XgUcCXx5yOWHr6ZYbTQZK2EeBLqP0tpb+W1pNeStoC/bSIkPpzGx1XrIyqLqznI
         gOFGvz0fzvDQz7GnULmd9o5cgBDmnznWPBC0m5hrBiHSLGB0tJkMkw7ssJphBfpR1M5/
         V4NnYVTumV+zc09YMyI1kzZbm5p7yFtT6lBfbgdXfOavjjpkDvJwOA7LH0x4vt92Uw0F
         9KPhlH1QLoaP06XBpwzq26j/x2hd1QT1GdvCmVSMWcjkFlbHk1R9YpVI+YGgKa6wDUeR
         +QWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jTWmtcACzAQn5qJ6Bhs/uGk8LJx7IP1Lqtl0V+UVL/4=;
        b=pfWHFu8WX3DppAP1C/9UoDCAfzankNV6srN8fWg4u5N294xSq5mWa86iwe2Q3EfffH
         PVEImW4fDQCIWbXqpymFOoZvILnzgQYJ+3F5aPR8wZp4AOZDF+GzldQ62RNr4kQl+Fkq
         ywja15AGolM93HbGz2YylCV4CdKMRIRU3B+1sT6iu7dV3ijPfSrj+RE7SAwVvnOUQNRI
         A/6UZP/xv+5zO/EajWk9f3YN6Ubq5smUxlUw+L/ro3QGOY6RgGU8USAShpOZzV3pbf1f
         hS8aA0AkPQ3Ad3AG2qvzELnCsy61gFYr6uYiJFh5NY8zZdgD4cIJmKm9uaUKOugFez8f
         5/xA==
X-Gm-Message-State: AOAM532iSRWBIaW0wZJLywz4cpD6NfalfkFo3pyHO604Qpi92se3haLz
        henHBEP1wT1EpcgXyrH8ASAGdg==
X-Google-Smtp-Source: ABdhPJxKgW/VRNPprSjSiwbdDxz6nC0HICvtgnXwr9m2q/8ztRXpjt6uqMgZy5wNQsaju/4R2qnk4Q==
X-Received: by 2002:aa7:9aa9:: with SMTP id x9mr2832162pfi.67.1599725567281;
        Thu, 10 Sep 2020 01:12:47 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id e1sm2196056pfl.162.2020.09.10.01.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 01:12:46 -0700 (PDT)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     greentime.hu@sifive.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, aou@eecs.berkeley.edu,
        palmer@dabbelt.com, paul.walmsley@sifive.com
Cc:     Guo Ren <guoren@linux.alibaba.com>
Subject: [RFC PATCH v7 05/21] riscv: Add vector feature to compile
Date:   Thu, 10 Sep 2020 16:12:00 +0800
Message-Id: <a9f3a84d3dc7d66b36f10a68c49d6cb75a648a08.1599719352.git.greentime.hu@sifive.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1599719352.git.greentime.hu@sifive.com>
References: <cover.1599719352.git.greentime.hu@sifive.com>
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
Reviewed-by: Greentime Hu <greentime.hu@sifive.com>
---
 arch/riscv/Kconfig  | 9 +++++++++
 arch/riscv/Makefile | 1 +
 2 files changed, 10 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index df18372861d8..58673089c900 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -327,6 +327,15 @@ config FPU
 
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
2.28.0

