Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEEFAC43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 08:17:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8506D2067C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 08:17:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="fjlnvVWE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730068AbgIJIRR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 04:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729251AbgIJIMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 04:12:51 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D753BC061795
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 01:12:49 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id s2so2658247pjr.4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 01:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ce1Cr9HrV3tBJGJ0t9KLA6wLyDwM2Je7xNmtW+DthqA=;
        b=fjlnvVWETnC+6Y+qjfA5cxp2pSO4p5quXLwSt7u3BYt+UpJjIXCpGJQmpHNlRoe1Ur
         ReGCCHDG3eDrCXAQ1qnd5gdIE6XCEF/gapf59sQtveWzp7tNInNhAY1U4bMK6sWzumtr
         DDtgf+qvTGdCucfNwSsjTLc3s8wqEJE+hZXFBjQ2rVOkSBUW1ETC2ySxxtq42/oTB3l0
         usTlGg1s8IBGDQPk0k5sCnY9u8FNYOICnBP3bbLXDhwqJITXqrLKOe90QRha1Zdf30wg
         BDuqVBNo3u0KEvuu0lTHInAAeceh3u5NgZLwzxeSsX/E2FOslICQvLbHwxNmsVUFTpKj
         czsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ce1Cr9HrV3tBJGJ0t9KLA6wLyDwM2Je7xNmtW+DthqA=;
        b=ba4w8wFex9TQjzrJ55aixpuub5P4yV8OJpxkLqkVYbDYm8PqSH3x9QLFQzjeJJLhkE
         oVOROyzdHbOkAtORMtqOkQYgUbktl1fcBrC4pddpmTwsbhZf+lMXkZeMMbNWg1dhP10x
         OPYcYCuI5WAQsElm+HjxVcZRwhzyki5F0Vjv0MmS1o4BC8AQMo1Tmtf0+FluZrlaphpT
         vCbmLtJGzRTcnXWueUSVWejlst6B0OjdrvK0DbH2kTcLrSToFAeCAvPGf6PWuLDnovOx
         ymQRUa/D679GCsrY8n5b+Y94mEG8MBWz4BDvXZl8+krWL4ccQ9M0Ysu3vVeiLbKcwQqr
         a3xg==
X-Gm-Message-State: AOAM532JR4yqCYcnn6S74bqM9tFDIwcFiUZaqSr/OyNXgLFR5zVJhwUR
        EWRpjyKTvosD+SnCLnk9fxmUkA==
X-Google-Smtp-Source: ABdhPJyai65Py1TqV8L/FUFi7cDFWoYRXd06+l/aYPNz2PTenCCc6YnHYzuHIjhwTD/+WiZw9JWlmg==
X-Received: by 2002:a17:90b:20d1:: with SMTP id ju17mr3970913pjb.134.1599725569405;
        Thu, 10 Sep 2020 01:12:49 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id e1sm2196056pfl.162.2020.09.10.01.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 01:12:48 -0700 (PDT)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     greentime.hu@sifive.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, aou@eecs.berkeley.edu,
        palmer@dabbelt.com, paul.walmsley@sifive.com
Cc:     Guo Ren <guoren@linux.alibaba.com>
Subject: [RFC PATCH v7 06/21] riscv: Add has_vector/riscv_vsize to save vector features.
Date:   Thu, 10 Sep 2020 16:12:01 +0800
Message-Id: <d5aedcd12c8a2f777063fec8926ee396d1e263a7.1599719352.git.greentime.hu@sifive.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1599719352.git.greentime.hu@sifive.com>
References: <cover.1599719352.git.greentime.hu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is used to detect vector support status of CPU and use
riscv_vsize to save the size of all the vector registers. It assumes
all harts has the same capabilities in SMP system.

[guoren@linux.alibaba.com: add has_vector checking]
Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
---
 arch/riscv/kernel/cpufeature.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index f11ada3fa906..4d4f78f6a5db 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -21,6 +21,10 @@ static DECLARE_BITMAP(riscv_isa, RISCV_ISA_EXT_MAX) __read_mostly;
 #ifdef CONFIG_FPU
 bool has_fpu __read_mostly;
 #endif
+#ifdef CONFIG_VECTOR
+bool has_vector __read_mostly;
+unsigned long riscv_vsize __read_mostly;
+#endif
 
 /**
  * riscv_isa_extension_base() - Get base extension word
@@ -149,4 +153,12 @@ void riscv_fill_hwcap(void)
 	if (elf_hwcap & (COMPAT_HWCAP_ISA_F | COMPAT_HWCAP_ISA_D))
 		has_fpu = true;
 #endif
+
+#ifdef CONFIG_VECTOR
+	if (elf_hwcap & COMPAT_HWCAP_ISA_V) {
+		has_vector = true;
+		/* There are 32 vector registers with vlenb length. */
+		riscv_vsize = csr_read(CSR_VLENB) * 32;
+	}
+#endif
 }
-- 
2.28.0

