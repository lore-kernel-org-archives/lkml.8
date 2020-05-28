Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EDF9C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 06:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E19BB207E8
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 06:41:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="V4n+MZXQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgE1GlZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 02:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbgE1GlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 02:41:23 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D82C05BD1E
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 23:41:22 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id t7so11115890plr.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 23:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Q8iHAnjKh91djitETlf/VgG+9uuO5Xz5Jn9NWjplsUA=;
        b=V4n+MZXQQuQeWiFHgTBOlDbJDNpfhZEJuAybcm5J9js85hkXIAlvWwBjYo6FCsIusd
         /OMqLUHPDRTPQSofk4aVUFDy00qVQ/wWJ3rnq6ZeQBZIEI8G8bvpuNRTwj3Jz+LR0bSx
         9jWOa1/jyePW18Tusn9/ll2zPl3YpL0/xbMK1gPKTL8VsXwiMC7zrLCKDxG9ZxpD3Inf
         kgUy9l44b+DEmzKnEoGQLXuzKeHvNaY2d1hpAHSfltS/3rGqo41DrlkUxcDYUaWfIyT+
         5MfE4zV24PMxpHh6RjxNYHcSlceF7zZ9HEA7sxmtjlE4+Bb4jTkGZuljcuf9aFX07r3j
         2KGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q8iHAnjKh91djitETlf/VgG+9uuO5Xz5Jn9NWjplsUA=;
        b=WKCjIdKPZLiEwWXpqCf8kopl3DlQvVLem8lWg+eP6dMFV64T4vPcrA3ogCiSqtfuzh
         fUNUonczxkTiEHSU2Imrcqwn9erK4IdBunfJM8q9PhRERHwF1owaaD9+bUiEP9Ifdb41
         aJFPIVUVGRqXnBQ5nYv/aI+3TDw7Kzcc7RnakMyHCuVHMJOGzgGdoHQzfXS4NAnQs1nj
         1QAxVIB7KCqtkWVkpXBRA+wk/bSVv5UwWsuD85B1WgOqtoR7MMUcwNJZB8oxrAAQwvdm
         gWsLTAUkp+03QU7eMW8yF0Up/A+1k1EBMVYZdHfNjLmdAT4JAYIFapbQBregTRq7FR7H
         J3jA==
X-Gm-Message-State: AOAM533nnPECOSx3Du2RpPkblmTTZNywK5UJAPPyqpnItOn0fTIgR8Ki
        pdOcMwVLmOKpwJAaCPhJA4Nx7g==
X-Google-Smtp-Source: ABdhPJy1zwXsZStCzwDaCuBrK+lkcL9Jm4ubqAdW1OomcTthZiiEPoBjM82lKF+LTdo48FWtnKymFg==
X-Received: by 2002:a17:902:b601:: with SMTP id b1mr2128010pls.39.1590648082243;
        Wed, 27 May 2020 23:41:22 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id q29sm3773366pfg.79.2020.05.27.23.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 23:41:21 -0700 (PDT)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     greentime.hu@sifive.com, guoren@linux.alibaba.com,
        vincent.chen@sifive.com, paul.walmsley@sifive.com,
        palmerdabbelt@google.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, oleg@redhat.com
Subject: [RFC PATCH v5 07/13] riscv: Add has_vector/riscv_vsize to save vector features.
Date:   Thu, 28 May 2020 14:40:55 +0800
Message-Id: <e699220610dd3f114d1216c46e0930632d73a0e2.1590646208.git.greentime.hu@sifive.com>
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

This patch is used to detect vector support status of CPU and use
riscv_vsize to save the size of all the vector registers. It assumes
all harts has the same capabilities in SMP system.

[greentime.hu@sifive.com: add support for dynamic vlen]
Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
---
 arch/riscv/kernel/cpufeature.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index c8527d770c98..5a68a926da68 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -16,6 +16,10 @@ unsigned long elf_hwcap __read_mostly;
 #ifdef CONFIG_FPU
 bool has_fpu __read_mostly;
 #endif
+#ifdef CONFIG_VECTOR
+bool has_vector __read_mostly;
+unsigned long riscv_vsize __read_mostly;
+#endif
 
 void riscv_fill_hwcap(void)
 {
@@ -73,4 +77,11 @@ void riscv_fill_hwcap(void)
 	if (elf_hwcap & (COMPAT_HWCAP_ISA_F | COMPAT_HWCAP_ISA_D))
 		has_fpu = true;
 #endif
+
+#ifdef CONFIG_VECTOR
+	if (elf_hwcap & COMPAT_HWCAP_ISA_V) {
+		has_vector = true;
+		riscv_vsize = csr_read(CSR_VLENB) * 32;
+	}
+#endif
 }
-- 
2.26.2

