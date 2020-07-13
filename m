Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74441C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 08:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F24C2067D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 08:32:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="C+V70yBj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729059AbgGMIcd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 04:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbgGMIcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 04:32:31 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D10C061755
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 01:32:31 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id f16so5894803pjt.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 01:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=do0EVSRhYwXWvYQE0QpCvGcNm4321TDk7C3/zMwSA+o=;
        b=C+V70yBj/ApmniBn0ppc0pMj++AoyBJpCWdsTQmKqGmy9px2OBUK/WeWHbzcrLcSkl
         x/jFOUbVTmuofDe3Z2UNTUD1rA6WhfyjVgu+SjoYLSMs/RhipvTUW6sxgbOsH4GIWuK0
         wfXI9lgbAq7jzbJyFIelA2QHxw8zWfaoCNpADloUCsYBVLGZ33CYO2glZNUBaDYy72iM
         zygrBzzXOIbtnna+ikduCz+ae0NIq9eJQyTSpEFJplbHsv2vdH/QYlJFBdaTnNQjYY3S
         RMeLUbCmWVt7j85uZxfoKLcHq9cWzNrjOltfgAQu4XEfH99lkoibIIVozlOXdXrfJWew
         PaRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=do0EVSRhYwXWvYQE0QpCvGcNm4321TDk7C3/zMwSA+o=;
        b=VVQ7aIJpTma5B7TArwNdxhX04Bhs0t0kzQI4UxD1eAG8Qx5y4CY2GAu5yIUq9T48J+
         pO7LQ9UmpG8zxZiIAMKRG0L7GXM2FWVVs2o1GtWJ1ERSV9AQgeCEp7r7x44mB/Nj5oWx
         XJa7rzM8iSPdZQP4YXcSlv6J5GDzrNn5US7+aszVd68vxiJDL886sdLPXq3FURmi4DMQ
         BCZpSmrBOVVIrs3Q7Bk3iyRFSftxYsKjsFBTw6w0T8LtkpAzjBeAo0Wt5aj8x5uLUNmW
         otV26L+7fwU/zYKoFiiXv8+NQXLidWHkUUEFrYD/83rWwLBLYR6RSSBxuyb4cXryPjao
         H7xw==
X-Gm-Message-State: AOAM532ydox9uNGZXupPgatutADPpdnqV8SfFcwB009OXEwBsY1iSdny
        M9vM02jcNuIt3Ez7bVOW9QjH2g==
X-Google-Smtp-Source: ABdhPJyWY/4DfB7JskEyEBofMSG32V0Yik7AVH9GtgHNoR+If9MXl5zqVwxatmpMqKw+u9TN7kSR1g==
X-Received: by 2002:a17:90a:cd01:: with SMTP id d1mr19147072pju.212.1594629150596;
        Mon, 13 Jul 2020 01:32:30 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id b4sm13603678pjn.38.2020.07.13.01.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 01:32:30 -0700 (PDT)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     greentime.hu@sifive.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, aou@eecs.berkeley.edu,
        palmer@dabbelt.com, paul.walmsley@sifive.com
Subject: [PATCH 2/2] riscv: Simplify the checking for SR_PP
Date:   Mon, 13 Jul 2020 16:32:16 +0800
Message-Id: <4bac52941700cd7b714a41606df7b53f4cf24824.1594629047.git.greentime.hu@sifive.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <742f0a82a9d4ab62d8616784db5a88a95d8b5389.1594629047.git.greentime.hu@sifive.com>
References: <742f0a82a9d4ab62d8616784db5a88a95d8b5389.1594629047.git.greentime.hu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch simplifies the checking for SR_MPP and SR_SPP. It uses SR_PP in the
code flow for both m-mode and s-mode then we can remove the ifdef here.

Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
---
 arch/riscv/kernel/entry.S | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index 000984695cd6..597beae0d238 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -210,13 +210,8 @@ ret_from_syscall_rejected:
 ret_from_exception:
 	REG_L s0, PT_STATUS(sp)
 	csrc CSR_STATUS, SR_IE
-#ifdef CONFIG_RISCV_M_MODE
-	/* the MPP value is too large to be used as an immediate arg for addi */
-	li t0, SR_MPP
+	li t0, SR_PP
 	and s0, s0, t0
-#else
-	andi s0, s0, SR_SPP
-#endif
 	bnez s0, resume_kernel
 
 resume_userspace:
-- 
2.27.0

