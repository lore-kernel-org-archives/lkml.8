Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB75DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 17:03:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C59B220829
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 17:03:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fgjWW21a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730206AbgEURDj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 13:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730183AbgEURDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 13:03:38 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB0CC061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 10:03:37 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id k22so3062101pls.10
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 10:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vYjy0uW4Z1rFpb7dTtSnnnsAluREbI2WTlefusKUfGI=;
        b=fgjWW21amdZXKgAhhGjuyUMOb/ZKAf7txzX5Yr/GLelgDqSO1NuYoFFEnRj/KZqi7O
         X1h7e/tbBRNbk+/wwyIE1Kg35mEFQ39Y2esUvGyXFJYTNPicr+32JQ1QerhtSQfwbF0l
         2Re4TE65ggsh8q8RFD/83+hrkPrf/8bZtsw20TUr5CaSKneqk/cGY+W7s26avnoSTJxa
         mSslm23Oit7P9P7XR8cBlztH6upzoK54ov1pAjeGTDw235ykSNyoel6wN8E6x3n4/oZk
         0ihk7GOWtjJb+ZWH4gjsxS8OBZf6O3LKdf5Erf25WDSY7rIRXvhdhp2vd+uJxHBrX++f
         /Vhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vYjy0uW4Z1rFpb7dTtSnnnsAluREbI2WTlefusKUfGI=;
        b=ig3OKK5HsihxD7M9e0ytIjitXyDneupREYJU+4q0P06SAodolysc+lFlPKt3U7XSs5
         QMbbdS257xQLnsq3HKc2NlqIFQ7Q8xVaq9EKxIQWNyp4wR/klF64BBFKMZiGd27tuX+M
         oyYorbgdVNIiF9XHTIx3u321KpVonhNUKmLEjAiprccKxibPqCgWjam9/ynJ4MObHeVP
         DLsmd3Fj7TcK9C+7TNBeOomJ4kFCpB7XBnF66VfWVqzJxBTRhA2O2riq+meuuvBowM01
         XdrY0VfqejllLWjlMP7pNdShAQU9VB1kaLg+mO/voBMBGIbO/8bWewAaaK3f3IY8VhdK
         t65A==
X-Gm-Message-State: AOAM530t9yhxFQZ2ftYxDMwQbC+ctlHiSAQnLoVT2a7nW3i6gO0ruFaW
        V26rsW9vlANNYvulX0picTHaZUlPxA==
X-Google-Smtp-Source: ABdhPJydrSovOKQloa+WdqVCS5izZWXSACEEfVD4ii2XewHVQRyNhD/IaTpP9UJVkAXJ4X6By89jAw==
X-Received: by 2002:a17:90b:1492:: with SMTP id js18mr13085733pjb.212.1590080616468;
        Thu, 21 May 2020 10:03:36 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:69f:45f2:3d8d:3719:f568:7ee9])
        by smtp.gmail.com with ESMTPSA id e26sm4874693pff.137.2020.05.21.10.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 10:03:35 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     hemantk@codeaurora.org, jhugo@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bhaumik Bhatt <bbhatt@codeaurora.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [RESEND PATCH 08/14] bus: mhi: core: Ensure non-zero session or sequence ID values are used
Date:   Thu, 21 May 2020 22:32:43 +0530
Message-Id: <20200521170249.21795-9-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200521170249.21795-1-manivannan.sadhasivam@linaro.org>
References: <20200521170249.21795-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bhaumik Bhatt <bbhatt@codeaurora.org>

While writing any sequence or session identifiers, it is possible that
the host could write a zero value, whereas only non-zero values should
be supported writes to those registers. Ensure that the host does not
write a non-zero value for them and also log them in debug messages. A
macro is introduced to simplify this check and the existing checks are
also converted to use this macro.

Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
Reviewed-by: Jeffrey Hugo <jhugo@codeaurora.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/core/boot.c     | 15 +++++++--------
 drivers/bus/mhi/core/internal.h |  1 +
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/bus/mhi/core/boot.c b/drivers/bus/mhi/core/boot.c
index 80e4d7609aaa..0b38014d040e 100644
--- a/drivers/bus/mhi/core/boot.c
+++ b/drivers/bus/mhi/core/boot.c
@@ -43,10 +43,7 @@ void mhi_rddm_prepare(struct mhi_controller *mhi_cntrl,
 		      lower_32_bits(mhi_buf->dma_addr));
 
 	mhi_write_reg(mhi_cntrl, base, BHIE_RXVECSIZE_OFFS, mhi_buf->len);
-	sequence_id = prandom_u32() & BHIE_RXVECSTATUS_SEQNUM_BMSK;
-
-	if (unlikely(!sequence_id))
-		sequence_id = 1;
+	sequence_id = MHI_RANDOM_U32_NONZERO(BHIE_RXVECSTATUS_SEQNUM_BMSK);
 
 	mhi_write_reg_field(mhi_cntrl, base, BHIE_RXVECDB_OFFS,
 			    BHIE_RXVECDB_SEQNUM_BMSK, BHIE_RXVECDB_SEQNUM_SHFT,
@@ -189,7 +186,9 @@ static int mhi_fw_load_amss(struct mhi_controller *mhi_cntrl,
 		return -EIO;
 	}
 
-	dev_dbg(dev, "Starting AMSS download via BHIe\n");
+	sequence_id = MHI_RANDOM_U32_NONZERO(BHIE_TXVECSTATUS_SEQNUM_BMSK);
+	dev_dbg(dev, "Starting AMSS download via BHIe. Sequence ID:%u\n",
+		sequence_id);
 	mhi_write_reg(mhi_cntrl, base, BHIE_TXVECADDR_HIGH_OFFS,
 		      upper_32_bits(mhi_buf->dma_addr));
 
@@ -198,7 +197,6 @@ static int mhi_fw_load_amss(struct mhi_controller *mhi_cntrl,
 
 	mhi_write_reg(mhi_cntrl, base, BHIE_TXVECSIZE_OFFS, mhi_buf->len);
 
-	sequence_id = prandom_u32() & BHIE_TXVECSTATUS_SEQNUM_BMSK;
 	mhi_write_reg_field(mhi_cntrl, base, BHIE_TXVECDB_OFFS,
 			    BHIE_TXVECDB_SEQNUM_BMSK, BHIE_TXVECDB_SEQNUM_SHFT,
 			    sequence_id);
@@ -246,14 +244,15 @@ static int mhi_fw_load_sbl(struct mhi_controller *mhi_cntrl,
 		goto invalid_pm_state;
 	}
 
-	dev_dbg(dev, "Starting SBL download via BHI\n");
+	session_id = MHI_RANDOM_U32_NONZERO(BHI_TXDB_SEQNUM_BMSK);
+	dev_dbg(dev, "Starting SBL download via BHI. Session ID:%u\n",
+		session_id);
 	mhi_write_reg(mhi_cntrl, base, BHI_STATUS, 0);
 	mhi_write_reg(mhi_cntrl, base, BHI_IMGADDR_HIGH,
 		      upper_32_bits(dma_addr));
 	mhi_write_reg(mhi_cntrl, base, BHI_IMGADDR_LOW,
 		      lower_32_bits(dma_addr));
 	mhi_write_reg(mhi_cntrl, base, BHI_IMGSIZE, size);
-	session_id = prandom_u32() & BHI_TXDB_SEQNUM_BMSK;
 	mhi_write_reg(mhi_cntrl, base, BHI_IMGTXDB, session_id);
 	read_unlock_bh(pm_lock);
 
diff --git a/drivers/bus/mhi/core/internal.h b/drivers/bus/mhi/core/internal.h
index 0965ca3c9632..80b32c20149c 100644
--- a/drivers/bus/mhi/core/internal.h
+++ b/drivers/bus/mhi/core/internal.h
@@ -452,6 +452,7 @@ enum mhi_pm_state {
 #define PRIMARY_CMD_RING		0
 #define MHI_DEV_WAKE_DB			127
 #define MHI_MAX_MTU			0xffff
+#define MHI_RANDOM_U32_NONZERO(bmsk)	(prandom_u32_max(bmsk) + 1)
 
 enum mhi_er_type {
 	MHI_ER_TYPE_INVALID = 0x0,
-- 
2.17.1

