Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF9FC433E4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 05:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B9C52067D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 05:48:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y73DZiGC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbgGPFsU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 01:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbgGPFsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 01:48:19 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E20C061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 22:48:19 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id ls15so4256986pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 22:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GcjGMlvxaLvf+5Qx9y70nhyWvIrGkWz3MBzmHdjFud4=;
        b=Y73DZiGCNXSiY//N6sNgC0Yv9LqzR32T9dyDXTCVjQrypbaV0JpeZJAsu4K2MS/iA4
         tVRE4rgZq3p+sKM19YapD+CGtv0fD/DxwQe94rgpGqHG+ZOtE8DRH5ue2hgEx6RvjZq9
         Eac2HuNPK/go9BP0k3m2crj1jUADiUZKf/SrnENfyrHMFLBJBCSXGFkozGOxZjl/iyBA
         KelrTBPlLFxTWKNTtRsPXEuVBTbuwIonBER9lQVad7DoZ543VttTXpnNVAoHJc2U1FST
         z7PECvJpjoiHRVAtBuQpssgp38dzC1XrsrK3aGkFeMcUZZACKXMfk7y5gu5PtjBKUF1h
         Op3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GcjGMlvxaLvf+5Qx9y70nhyWvIrGkWz3MBzmHdjFud4=;
        b=sF6N4KgKGcZOtErKM4exIn3f6vRBR5Ifi3dqP9JFnA06CDgiKtcROCFPRwQxkjicvb
         wdpbTsz6msym0uNr11Ko4NkRrEPzLMLcykX1AzPhuwzK9+kgsxuVCE2pWp5bZXUlMsJJ
         8Act/a9ZAzer9KmMAhuk4IPHzxqkvisLDi6OWoCV8UdGBo0VKBGghHUHqcWKjQbP4/Uz
         7cq9yHztfgsihyTCaTQ/d+wnVcciX97nttOokXAMHnYqwTimQcLZtpep9/w+c3YOSkAJ
         nVt70/j5Aw0woSic2o//bB+88Vy3/HWX23vW1pAc1kgnJjkK48P4KRlfIO2zLlf3UpWr
         PMIw==
X-Gm-Message-State: AOAM533wSlzUWhiyq5dfkGrPStSFar5zCVOL7WMOCQ3XjLdwWldkMcOj
        bMDjIM6/b1Skn/ycdIEG9yjBhVqiysM=
X-Google-Smtp-Source: ABdhPJxgSNsrdonyiZ4TpMu5c5IjfTLUQbvfXYif2dVLhugs3juB7O3pgeWaVE3XdMP26ZR+yCp79Q==
X-Received: by 2002:a17:90b:8d7:: with SMTP id ds23mr3267380pjb.148.1594878498322;
        Wed, 15 Jul 2020 22:48:18 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id o4sm3707657pjo.16.2020.07.15.22.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 22:48:17 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] remoteproc: qcom: pil-info: Fix shift overflow
Date:   Wed, 15 Jul 2020 22:48:17 -0700
Message-Id: <20200716054817.157608-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On platforms with 32-bit phys_addr_t the shift to get the upper word of
the base address of the memory region is invalid. Cast the base to 64
bit to resolv this.

Fixes: 549b67da660d ("remoteproc: qcom: Introduce helper to store pil info in IMEM")
Reported-by: Lee Jones <lee.jones@linaro.org>
Reported-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/remoteproc/qcom_pil_info.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/remoteproc/qcom_pil_info.c b/drivers/remoteproc/qcom_pil_info.c
index 0536e3904669..5521c4437ffa 100644
--- a/drivers/remoteproc/qcom_pil_info.c
+++ b/drivers/remoteproc/qcom_pil_info.c
@@ -108,7 +108,7 @@ int qcom_pil_info_store(const char *image, phys_addr_t base, size_t size)
 found_existing:
 	/* Use two writel() as base is only aligned to 4 bytes on odd entries */
 	writel(base, entry + PIL_RELOC_NAME_LEN);
-	writel(base >> 32, entry + PIL_RELOC_NAME_LEN + 4);
+	writel((u64)base >> 32, entry + PIL_RELOC_NAME_LEN + 4);
 	writel(size, entry + PIL_RELOC_NAME_LEN + sizeof(__le64));
 	mutex_unlock(&pil_reloc_lock);
 
-- 
2.26.2

