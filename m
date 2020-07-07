Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A7BC433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 10:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1176820702
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 10:18:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tCYSjXuU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728441AbgGGKSP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 06:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbgGGKRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 06:17:13 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A2FC061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 03:17:13 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id w3so33432477wmi.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 03:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d7oRUP6HHmbAXMILeJrpZWaXkV9JssFtTdyZGy/6dhk=;
        b=tCYSjXuURlwgjreX0Ebq0a2Q23GCLXJ9ADPRqI9ys1VeUMctC69cJNaP8QTx38oG4/
         G/CvUacR2s5NWT9H85WTs8wjAHTeI5sYNvDO2tOx2a9ohVWrbgNr/YRR7NbYflcn8iJB
         1nDzhvSjUAeyDQ8WX00jokbXUyChwf4iVxhdJ+fX5iKVekqBwr1tUYhe99XCtpLHkWNt
         j/7sOrH2fBcl0o//lBbkhztFByYhe1pPAp1fvuolQFS3bbFLWD6OQWrOFV3qoOn8EmIJ
         eOenFNQIFMj2OchrK0q//ZaAftRPDArUIUH/zS8ZIdH5x5KzGeqSV0ezQmk0uAnHMHv9
         4Uiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d7oRUP6HHmbAXMILeJrpZWaXkV9JssFtTdyZGy/6dhk=;
        b=JtBP6rVMtVmhm0GFfS3wAroLArmTKSw/o//1CjM3jUtwAHQrIaNDh/25mNbLufLXhP
         sIyICFnH0vEFjimJqisMGE7dirCjvjkMX9np1wP5ZG1RcRcH+Uv5vLHZGtXPT4dc0EzN
         0AvBvedFTWPNxWr6BMLS53B5klbhasmrZPABkzj2oO2TGrwU/jznxKjzAJ89kp188u+L
         czKsVFGMG2AgIAdR16vyurwIjRTqryuuGJDOM/jrNw2HPokKU0X5TqG0Qg17ccQxWvdf
         ohfV1QaVFXaG5pSlHt/FqnGWQpt50+9BWdZHfjAjif7RaugRs//xdUoPo3FRVmjbZaOE
         6G2Q==
X-Gm-Message-State: AOAM533O/1XrhSiN9RCapr/K6AyXGTn13qDWcjrpqukbjZFSL6vjXJ31
        v0GOxei3Pcu4LSLTh93igTYblQ==
X-Google-Smtp-Source: ABdhPJx2P1TjQfKulF9kQvC3Rl1oKv0T6tweHznyPHPtYx+jkOMqb0z4kGRg8v3Or+e4ue4AewQEsA==
X-Received: by 2002:a7b:c38c:: with SMTP id s12mr3391563wmj.136.1594117031692;
        Tue, 07 Jul 2020 03:17:11 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id z8sm469409wmg.39.2020.07.07.03.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 03:17:10 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, Lee Jones <lee.jones@linaro.org>,
        zhong jiang <zhongjiang@huawei.com>,
        Ola Lilja <ola.o.lilja@stericsson.com>,
        Roger Nilsson <roger.xr.nilsson@stericsson.com>,
        Sandeep Kaushik <sandeep.kaushik@st.com>
Subject: [PATCH 19/28] ASoC: ux500: ux500_msp_i2s: Remove unused variables 'reg_val_DR' and 'reg_val_TSTDR'
Date:   Tue,  7 Jul 2020 11:16:33 +0100
Message-Id: <20200707101642.1747944-20-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200707101642.1747944-1-lee.jones@linaro.org>
References: <20200707101642.1747944-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like these have been unchecked since the driver's inception in 2012.

Fixes the following W=1 kernel build warning(s):

 sound/soc/ux500/ux500_msp_i2s.c: In function ‘flush_fifo_rx’:
 sound/soc/ux500/ux500_msp_i2s.c:398:6: warning: variable ‘reg_val_DR’ set but not used [-Wunused-but-set-variable]
 sound/soc/ux500/ux500_msp_i2s.c: In function ‘flush_fifo_tx’:
 sound/soc/ux500/ux500_msp_i2s.c:415:6: warning: variable ‘reg_val_TSTDR’ set but not used [-Wunused-but-set-variable]

Cc: zhong jiang <zhongjiang@huawei.com>
Cc: Ola Lilja <ola.o.lilja@stericsson.com>
Cc: Roger Nilsson <roger.xr.nilsson@stericsson.com>
Cc: Sandeep Kaushik <sandeep.kaushik@st.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 sound/soc/ux500/ux500_msp_i2s.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/ux500/ux500_msp_i2s.c b/sound/soc/ux500/ux500_msp_i2s.c
index 394d8b2a4a161..fd0b88bb79212 100644
--- a/sound/soc/ux500/ux500_msp_i2s.c
+++ b/sound/soc/ux500/ux500_msp_i2s.c
@@ -395,7 +395,7 @@ static int enable_msp(struct ux500_msp *msp, struct ux500_msp_config *config)
 
 static void flush_fifo_rx(struct ux500_msp *msp)
 {
-	u32 reg_val_DR, reg_val_GCR, reg_val_FLR;
+	u32 reg_val_GCR, reg_val_FLR;
 	u32 limit = 32;
 
 	reg_val_GCR = readl(msp->registers + MSP_GCR);
@@ -403,7 +403,7 @@ static void flush_fifo_rx(struct ux500_msp *msp)
 
 	reg_val_FLR = readl(msp->registers + MSP_FLR);
 	while (!(reg_val_FLR & RX_FIFO_EMPTY) && limit--) {
-		reg_val_DR = readl(msp->registers + MSP_DR);
+		readl(msp->registers + MSP_DR);
 		reg_val_FLR = readl(msp->registers + MSP_FLR);
 	}
 
@@ -412,7 +412,7 @@ static void flush_fifo_rx(struct ux500_msp *msp)
 
 static void flush_fifo_tx(struct ux500_msp *msp)
 {
-	u32 reg_val_TSTDR, reg_val_GCR, reg_val_FLR;
+	u32 reg_val_GCR, reg_val_FLR;
 	u32 limit = 32;
 
 	reg_val_GCR = readl(msp->registers + MSP_GCR);
@@ -421,7 +421,7 @@ static void flush_fifo_tx(struct ux500_msp *msp)
 
 	reg_val_FLR = readl(msp->registers + MSP_FLR);
 	while (!(reg_val_FLR & TX_FIFO_EMPTY) && limit--) {
-		reg_val_TSTDR = readl(msp->registers + MSP_TSTDR);
+		readl(msp->registers + MSP_TSTDR);
 		reg_val_FLR = readl(msp->registers + MSP_FLR);
 	}
 	writel(0x0, msp->registers + MSP_ITCR);
-- 
2.25.1

