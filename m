Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37837C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 14:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CBAF2073E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 14:39:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LkB5f2KQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728669AbgGGOjA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 10:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728451AbgGGOiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 10:38:15 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8678EC061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 07:38:15 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id z13so45410213wrw.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 07:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d7oRUP6HHmbAXMILeJrpZWaXkV9JssFtTdyZGy/6dhk=;
        b=LkB5f2KQxj9RiMnUMCrnbNpyPWXlnW3De4WBuJl/2/6IHSiYFHZG9igGOCZ3Y6J6WK
         Gzbp0CjO+Hdh4zx8lZUoPUE8mjaqtR0sBqE1LDCGGIabjQW5F+fL8xcu83/lEJ5co343
         1/0T8okpQOpgFedcJf3DKAC0tvKA/FHXQuFyslmQPQhp8ilQDgShlhNi6h7Xvc3BeZFW
         FhGx4DjU3wuLtkjnmBDz31yplmbsKYm6QQ63skIPj0JOBDWZ6+2n4fkjip7zWgg0uq0V
         WTsR8iE1up41/dfHe6m3cLl5RdBzy45oImEPSvr+ABdZS47BW61TAjhXhJZjDOuR6RD/
         vyBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d7oRUP6HHmbAXMILeJrpZWaXkV9JssFtTdyZGy/6dhk=;
        b=R3/xYSShjbZqKHtcKpMJQaa2VmZ4SkUhCRmhtHMX/0M30FbnH2MOLMG2KqtAwdhPRG
         kNDibqzOmKDD3AB8q/zw0gH6SUYNDNbfAcdJAoDCPN46kAaKHs28gtXloTpBAbXy4kEJ
         5bFFe3d9MspofQ0xo78jWOH9OSJxcoBYvaffFYq5TlR/nqbV2Sx7VLqArSyTUi/Vl9FX
         +0k1J6+ibSUrx05p34QZQRbnCrr5mJ62JKeim2BFo1DhfuBWna45Z5i8zWyHqNrA3Gs4
         2tTsj3HNRSM1YfCcjCaCddQoK0AEbANTRhntPgtictGRSuNxZsL4Mi9/HSc/vrkFdOZm
         gehg==
X-Gm-Message-State: AOAM5307JCuqWTG9cLBBfCxgON9YQT73Y77aHZzAQ/xDTpIzBIkIdRwX
        PMpsMMeqg8q9vva2Ua7QyO2zvg==
X-Google-Smtp-Source: ABdhPJynXJwfY+EJdx1C+77hx2NiUZ2uZ+tqh66Q8vQrBf76qaoHLF9FMyXrc1gAY/AjtDJ4ELHvrA==
X-Received: by 2002:adf:c185:: with SMTP id x5mr59206892wre.403.1594132694312;
        Tue, 07 Jul 2020 07:38:14 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id y16sm1276131wro.71.2020.07.07.07.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 07:38:13 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, Lee Jones <lee.jones@linaro.org>,
        zhong jiang <zhongjiang@huawei.com>,
        Ola Lilja <ola.o.lilja@stericsson.com>,
        Roger Nilsson <roger.xr.nilsson@stericsson.com>,
        Sandeep Kaushik <sandeep.kaushik@st.com>
Subject: [PATCH v2 19/28] ASoC: ux500: ux500_msp_i2s: Remove unused variables 'reg_val_DR' and 'reg_val_TSTDR'
Date:   Tue,  7 Jul 2020 15:37:33 +0100
Message-Id: <20200707143742.2959960-20-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200707143742.2959960-1-lee.jones@linaro.org>
References: <20200707143742.2959960-1-lee.jones@linaro.org>
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

