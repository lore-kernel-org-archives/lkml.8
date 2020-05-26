Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E3FC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 07:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B372C20870
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 07:03:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="fwaOu56E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731470AbgEZHDI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 03:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731454AbgEZHDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 03:03:02 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B56C03E97E
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 00:03:02 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id 124so3363622pgi.9
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 00:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=6Km2JD+kQ/unmKeqzGOP9FqhZeNEC29tSKtvmTopBc0=;
        b=fwaOu56EhTEG9FMN1o3rnteEalY/8bArnEbtZVxAabyRBu+r/nABZ7epDBo4p8MDD+
         cA2gNedzetSmiwvuO4vALFAW/vq38SF4XR+zCqJZwgup7qFTFD6R2bnKCwzXFPWUxBzG
         05rxVQ/AFibFBkSd3yp17SxnzMu2A6dSpCMPD5TwPc5r2+uanG2P6a3vz7Ywwo8eTwCD
         MOYFUQUQqj27+a7Jf7VbtqzWEA4wjN9LPmLXelUFv1HKvK8ro0WiNHELP7jWGWlzuoRX
         C3CSTaFGuxW4wljnZ3wtz5BYBewgnYxDfqkqPW2vdGQAuTNwndB3uBT4l6ZU1QQhIds6
         n6sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6Km2JD+kQ/unmKeqzGOP9FqhZeNEC29tSKtvmTopBc0=;
        b=nXGCTr7uiE/shGAPL05RuH0YyX8byWppKrBenRm32SOtVmjnySNEtJVsAzY2h+UANe
         vkjyMZh/Lk+luqynCJ0ShsToKt+IuaiQ3OmVh/u7UvvnOYyPE5hpQESj+0j93IXZfxvt
         E3bIS64RzoLo/Z59dfr4mYdNeR0YriWJEpPflZfLZ6LRCFZGef5LnhnvQL2hYmc1avxO
         Liinuppz03gHIlvXvGYbUk5qOIvGBGkRN56NADLwGam6OShPUgVVK81ziunjeRVWfFCE
         KbU7GUqU80HebS/vzRUVmvfkx6I04BBQHQQkcb+QQjbuUZCp5Cewb4If8TRCCihcVZUT
         Rm5w==
X-Gm-Message-State: AOAM531bG4+sorJof6OT/b7b8qs0kfWw+FVADiPkQ3xbucsCdSuGQm00
        zQ+zczod1+/V18T1BpERdfH5lw==
X-Google-Smtp-Source: ABdhPJxjkNufIEkiK3P///fheqfCPFylQAY0wlVg55u5yq6ThiUNFXgAZMzHeSWEHAJ4K6Ub1zbPwQ==
X-Received: by 2002:a65:52c3:: with SMTP id z3mr30156648pgp.146.1590476582354;
        Tue, 26 May 2020 00:03:02 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id q34sm15167431pja.22.2020.05.26.00.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 00:03:01 -0700 (PDT)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     greentime.hu@sifive.com, guoren@linux.alibaba.com,
        vincent.chen@sifive.com, paul.walmsley@sifive.com,
        palmerdabbelt@google.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, oleg@redhat.com
Subject: [RFC PATCH v4 06/13] riscv: Add vector feature to compile
Date:   Tue, 26 May 2020 15:02:35 +0800
Message-Id: <ee6f466ce3f12e65f6fcc686e19e7e956a88f324.1590474856.git.greentime.hu@sifive.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1590474856.git.greentime.hu@sifive.com>
References: <cover.1590474856.git.greentime.hu@sifive.com>
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
2.26.2

