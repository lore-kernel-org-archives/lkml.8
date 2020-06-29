Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A7CC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 03:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1D2120774
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 03:19:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="ftT4z8T6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbgF2DTk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 23:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbgF2DTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 23:19:30 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D15C03E979
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 20:19:30 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id j12so7277002pfn.10
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 20:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZKfMrSfh/1bie8cySquwojH2PxFPR3ZK3HqOY75MLbE=;
        b=ftT4z8T6YJu06KMqRVdlMDg2q4w/wVXqKAQsM+8ujaw7OMn1HVy6rapb4tpakMEMW7
         nJO4wGpe2sOpbE4oBN8gex/K+LetkiMYiUaLjpjm6NCLaeJugrqNgMXgAjNzYFhD/QCu
         eYzaonWZAkFovEnY6dm+slwZj8kLH3NiR5Ub033AauyRghFnYo6dE1yyQaN1tNf6QHmx
         LvROSBlaYU6tmtfyCAD7RNgvBaZNigsS1PnlCMtcApJaJTLSJsZG5eLPQvA6NlmEgxYn
         1kLcsTLwOP5rlMBvArdJ0OMpEiLx4OFOWNT7GZN48Pdsnx3popYDLD83rbZ9HnKz1ej+
         Ph/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZKfMrSfh/1bie8cySquwojH2PxFPR3ZK3HqOY75MLbE=;
        b=YfVJfNg5cW1t+qVOmWHi8sF2FiEn0HnWN764W8s2CNjiClOLferd6mWwFy5hk/bn1w
         mvmoUCyFPaMYy6J1+rnCXn27p6azQl9PwGGVRfCem59V/HO6FI9oQL2wXp38pDblm4Tb
         ZLRfWzaPBY1GUNnY7erKbp0ZTEdKCBhjnIvb590GkLFvFUAVda4ohgE+velJK32scKXW
         bi5xc9Bfa/42QrbXFMml0cfOExiA3H04EVTaYhh5r180jEcXxqMjGjm6wsjvVi7wH9hZ
         I/IMrmHgNxO88eLoa3gVvPbveTZ+Si7EJU0nxYI0jdsMOOrxoW3rbsp7p7rTbDYeRrR5
         ABuA==
X-Gm-Message-State: AOAM532AItF5Lje9admt473jMtW4kkrhnAN5FnxIuu/TcjepzcbRYMIQ
        rz6o5CPgDMrOEeeIDNC5W8VTYw==
X-Google-Smtp-Source: ABdhPJwq3Jh47y19VyyQgPItpKzVqNI4nRh3QCg+GTyihkO1sAimafJfqtC/3470fFtDP3xOa8zeWA==
X-Received: by 2002:a05:6a00:22c2:: with SMTP id f2mr13386684pfj.187.1593400770097;
        Sun, 28 Jun 2020 20:19:30 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id j70sm12876254pfd.208.2020.06.28.20.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2020 20:19:29 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [RFC PATCH 6/6] riscv: remove PMU menu of Kconfig
Date:   Mon, 29 Jun 2020 11:19:15 +0800
Message-Id: <f704db6a46b6c4d89fcff28433900d1357ba4f26.1593397455.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1593397455.git.zong.li@sifive.com>
References: <cover.1593397455.git.zong.li@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We only one instance of riscv_pmu now, and use DT file to describe the
platform-specific information, so drop the dependency and menu of
RISCV_BASE_PMU.

Signed-off-by: Zong Li <zong.li@sifive.com>
---
 arch/riscv/Kconfig                  | 13 -------------
 arch/riscv/include/asm/perf_event.h |  2 --
 arch/riscv/kernel/Makefile          |  2 +-
 3 files changed, 1 insertion(+), 16 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 128192e14ff2..deec11e924ce 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -292,19 +292,6 @@ config RISCV_ISA_C
 
 	   If you don't know what to do here, say Y.
 
-menu "supported PMU type"
-	depends on PERF_EVENTS
-
-config RISCV_BASE_PMU
-	bool "Base Performance Monitoring Unit"
-	def_bool y
-	help
-	  A base PMU that serves as a reference implementation and has limited
-	  feature of perf.  It can run on any RISC-V machines so serves as the
-	  fallback, but this option can also be disable to reduce kernel size.
-
-endmenu
-
 config FPU
 	bool "FPU support"
 	default y
diff --git a/arch/riscv/include/asm/perf_event.h b/arch/riscv/include/asm/perf_event.h
index e95d3bbaae3e..9ee654381d8c 100644
--- a/arch/riscv/include/asm/perf_event.h
+++ b/arch/riscv/include/asm/perf_event.h
@@ -12,7 +12,6 @@
 #include <linux/ptrace.h>
 #include <linux/interrupt.h>
 
-#ifdef CONFIG_RISCV_BASE_PMU
 #define RISCV_BASE_COUNTERS	2
 #define RISCV_EVENT_COUNTERS	29
 #define RISCV_TOTAL_COUNTERS	(RISCV_BASE_COUNTERS + RISCV_EVENT_COUNTERS)
@@ -79,7 +78,6 @@
 #define CSR_MHPMEVENT7	0x327
 #define CSR_MHPMEVENT8	0x328
 
-#endif
 #ifdef CONFIG_PERF_EVENTS
 #define perf_arch_bpf_user_pt_regs(regs) (struct user_regs_struct *)regs
 #endif
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index b355cf485671..1f5736e996fd 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -43,7 +43,7 @@ obj-$(CONFIG_MODULE_SECTIONS)	+= module-sections.o
 obj-$(CONFIG_FUNCTION_TRACER)	+= mcount.o ftrace.o
 obj-$(CONFIG_DYNAMIC_FTRACE)	+= mcount-dyn.o
 
-obj-$(CONFIG_RISCV_BASE_PMU)	+= perf_event.o
+obj-$(CONFIG_PERF_EVENTS)	+= perf_event.o
 obj-$(CONFIG_PERF_EVENTS)	+= perf_callchain.o
 obj-$(CONFIG_HAVE_PERF_REGS)	+= perf_regs.o
 obj-$(CONFIG_RISCV_SBI)		+= sbi.o
-- 
2.27.0

