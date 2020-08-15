Return-Path: <SRS0=qJsj=BZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA2ECC433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 21:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90AFA2053B
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 21:57:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="obwP+SNY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729491AbgHOV5q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 17:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728979AbgHOVwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 17:52:03 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 377B2C0F26E3
        for <linux-kernel@vger.kernel.org>; Sat, 15 Aug 2020 10:59:47 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id 3so10542984wmi.1
        for <linux-kernel@vger.kernel.org>; Sat, 15 Aug 2020 10:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=OhIexcTtjYJfzajG9dXgRO1BqJUxWEmeHATQj6xzUXY=;
        b=obwP+SNYyCUUGOuHdbYyqG1MTTb7dGqUd/CxBjkoYwlKzBFkXWc7kmX1NNWyYQjErk
         iHc2DDDe87Hi15+7YL1RW90X8l4qMAKDXOXk/fNPlaBtZL84BjHTdvL9MFY1GZiYQWb6
         VAh//wQfGV1Krq5TFD9kleWRWeiTH1x+FBxidzoa5urbYI+KF5KMXaYGFzfY/KdV8WI5
         LOFBl4ffUivd/xYob9z/lXSxQAYGRarKQk9j97NyRMzNaZAkQozYrcYvryDAyDAcvPsx
         W/4cLnAOAG+jpNYoilgnLRQA42SBzXMMGQ/r2LWIfsa1bYhBqUUIGMs/CY4ZKnd19nvF
         Yi4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=OhIexcTtjYJfzajG9dXgRO1BqJUxWEmeHATQj6xzUXY=;
        b=Lm1MeztzpZ1PlO5eln/bFnIdKyPYtKiRVvs5vnTT3w4FxZwEsw6FNRwl277FSGXGks
         g47/LtImlQHUM1y+uSiBOZlsyL6yC4SbWbjPTcb9AgLO09MlWInaK6p+8MZsheCR5fev
         WfX3+meFxc5QLCSOPlSLFaY5jhY2eXpk6zvU3Hn1ffnd16ITIGBguY2jcBH/6B3rtxRw
         XRBWUr1+eWO521BkWf+bBJr6NGZtEyN8bSLrAxJHlau+9yZW1em0JrHCUwFppEF/6lW5
         PrGtjWiuWMPfw+VSjWzr1FA4Yk1MN3dxE2cBJKIgDVrI8KLpLlk/1gAdPbGrDYOGKz+J
         nebw==
X-Gm-Message-State: AOAM530nNh5Z3q8dAxf8cBzP2tcsopEsOhWUn1XVvEpnAIJ8jsqCW/Py
        4/7k6unbbcfRr+XIhXQwChkbRF0u3mY=
X-Google-Smtp-Source: ABdhPJxoB6uk0zhc0V6Oajv/Jvt5H2Hgm55STXstBF7N+H/KlAIOY2b1ppD9FDfZJsJhC9DmogWAyA==
X-Received: by 2002:a7b:cb47:: with SMTP id v7mr8141581wmj.129.1597514385593;
        Sat, 15 Aug 2020 10:59:45 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([213.57.90.10])
        by smtp.gmail.com with ESMTPSA id e5sm24460775wrc.37.2020.08.15.10.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2020 10:59:44 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, SW_Drivers@habana.ai
Subject: [PATCH 4/9] habanalabs: use standard BIT() and GENMASK()
Date:   Sat, 15 Aug 2020 20:59:33 +0300
Message-Id: <20200815175938.16619-4-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200815175938.16619-1-oded.gabbay@gmail.com>
References: <20200815175938.16619-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the standard macros to define bitmasks.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/gaudi/gaudiP.h | 44 +++++++++++++-------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudiP.h b/drivers/misc/habanalabs/gaudi/gaudiP.h
index 5dc99f6f0296..2eb5b9330275 100644
--- a/drivers/misc/habanalabs/gaudi/gaudiP.h
+++ b/drivers/misc/habanalabs/gaudi/gaudiP.h
@@ -141,28 +141,28 @@
 #define VA_HOST_SPACE_SIZE	(VA_HOST_SPACE_END - \
 					VA_HOST_SPACE_START) /* 767TB */
 
-#define HW_CAP_PLL		0x00000001
-#define HW_CAP_HBM		0x00000002
-#define HW_CAP_MMU		0x00000004
-#define HW_CAP_MME		0x00000008
-#define HW_CAP_CPU		0x00000010
-#define HW_CAP_PCI_DMA		0x00000020
-#define HW_CAP_MSI		0x00000040
-#define HW_CAP_CPU_Q		0x00000080
-#define HW_CAP_HBM_DMA		0x00000100
-#define HW_CAP_CLK_GATE		0x00000200
-#define HW_CAP_SRAM_SCRAMBLER	0x00000400
-#define HW_CAP_HBM_SCRAMBLER	0x00000800
-
-#define HW_CAP_TPC0		0x01000000
-#define HW_CAP_TPC1		0x02000000
-#define HW_CAP_TPC2		0x04000000
-#define HW_CAP_TPC3		0x08000000
-#define HW_CAP_TPC4		0x10000000
-#define HW_CAP_TPC5		0x20000000
-#define HW_CAP_TPC6		0x40000000
-#define HW_CAP_TPC7		0x80000000
-#define HW_CAP_TPC_MASK		0xFF000000
+#define HW_CAP_PLL		BIT(0)
+#define HW_CAP_HBM		BIT(1)
+#define HW_CAP_MMU		BIT(2)
+#define HW_CAP_MME		BIT(3)
+#define HW_CAP_CPU		BIT(4)
+#define HW_CAP_PCI_DMA		BIT(5)
+#define HW_CAP_MSI		BIT(6)
+#define HW_CAP_CPU_Q		BIT(7)
+#define HW_CAP_HBM_DMA		BIT(8)
+#define HW_CAP_CLK_GATE		BIT(9)
+#define HW_CAP_SRAM_SCRAMBLER	BIT(10)
+#define HW_CAP_HBM_SCRAMBLER	BIT(11)
+
+#define HW_CAP_TPC0		BIT(24)
+#define HW_CAP_TPC1		BIT(25)
+#define HW_CAP_TPC2		BIT(26)
+#define HW_CAP_TPC3		BIT(27)
+#define HW_CAP_TPC4		BIT(28)
+#define HW_CAP_TPC5		BIT(29)
+#define HW_CAP_TPC6		BIT(30)
+#define HW_CAP_TPC7		BIT(31)
+#define HW_CAP_TPC_MASK		GENMASK(31, 24)
 #define HW_CAP_TPC_SHIFT	24
 
 #define GAUDI_CPU_PCI_MSB_ADDR(addr)	(((addr) & GENMASK_ULL(49, 39)) >> 39)
-- 
2.17.1

