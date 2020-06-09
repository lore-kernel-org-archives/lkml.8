Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 980C4C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 19:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 777032072F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 19:42:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="EJ5I7b0p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389407AbgFITmY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 15:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbgFITkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 15:40:37 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18587C03E97C
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 12:40:37 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id b27so22021105qka.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 12:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0BqclPegqJok0tr1lg07n1QfpjQ6ftwveg7CVu5MR2U=;
        b=EJ5I7b0p5sm6fG2LVDGmZFIoyUoEMOuv8dVuO+rWpAYZVg5NR9bq0wHB8aFLqtXbzX
         /kFMTgm/V/5WvrVz2M2EsfKNKxHNUIvuVjvZQQQDkpY/UQkKY/ra/6hAunI0v+uMZh6D
         0KyD/4Dhe9OBRkY/jQJgLgoVpLI87OZ0IGfTFEWHdL7PLOyC44ojCz/6e56gNWKMbygt
         P/VR1yGt2c8lH2OKGfLR+JiNAgrHj3fP6Ta+Nf74YWvAjaQr9cjHFme5RcIbHePSjo7u
         pR7FioGemlKZlrSNpD1MePBLmBhnAR+uUWkMJq5msxpz/0yE240PEL6jgGrlNq8pbix5
         eC2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0BqclPegqJok0tr1lg07n1QfpjQ6ftwveg7CVu5MR2U=;
        b=NdA0gNC5ujAEK5Jeu4YOL94LQYeg0YXvE+uVtEyiglScjxAMm7B8QTbpLQ6jK6LQdI
         SFjG7xri7aB3oYp+lvaIVfdKh4bjYDBTcT07zeLjNcD2oJ4B1ikip2ffsv02LVWD5CwX
         SFuzmsqQjiEv82dfyqBF+VIE1PgT0O14aXIv8f92u9vreAO3VWi+4TR2ZC78tfzV4b5K
         NZm+bH2Ys92R9ExAC64fmT7qXJ0sCfSONuD6hSNblGCFuyufAnHWF3sbsBmvt1dzV9VN
         Gc+Chr+uZY8hBfwkmRxAB7O8Xv8/6R82nDu9bvLiJCvB3y9izE06Rdxq2IaePg6id1Gn
         zKRw==
X-Gm-Message-State: AOAM532LdJxuLUYBfSyfDx6SEr9ZWcNaRMh3LChahQdPWbbHwkR4ysdw
        BOYw1n2CramEu2T3BxvMtwd9rQ==
X-Google-Smtp-Source: ABdhPJyz/M9ZpkYSVQxPXiFgNuTI0QUGQCMuSuyLv9c8jT0hNZNxRz1VGjqEgkrwXdXTkx7A3ZM78w==
X-Received: by 2002:a37:6c2:: with SMTP id 185mr28950911qkg.95.1591731635916;
        Tue, 09 Jun 2020 12:40:35 -0700 (PDT)
Received: from localhost.localdomain ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id v8sm10513181qto.21.2020.06.09.12.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 12:40:35 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     linux-arm-msm@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM SMMU DRIVERS),
        iommu@lists.linux-foundation.org (open list:IOMMU DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 2/8] iommu: arm-smmu-impl: Use qcom impl for sm8150 and sm8250 compatibles
Date:   Tue,  9 Jun 2020 15:40:20 -0400
Message-Id: <20200609194030.17756-3-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200609194030.17756-1-jonathan@marek.ca>
References: <20200609194030.17756-1-jonathan@marek.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the qcom implementation for IOMMU hardware on sm8150 and sm8250 SoCs.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 drivers/iommu/arm-smmu-impl.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu-impl.c b/drivers/iommu/arm-smmu-impl.c
index c75b9d957b70..f5f6cab626be 100644
--- a/drivers/iommu/arm-smmu-impl.c
+++ b/drivers/iommu/arm-smmu-impl.c
@@ -172,7 +172,9 @@ struct arm_smmu_device *arm_smmu_impl_init(struct arm_smmu_device *smmu)
 		smmu->impl = &calxeda_impl;
 
 	if (of_device_is_compatible(np, "qcom,sdm845-smmu-500") ||
-	    of_device_is_compatible(np, "qcom,sc7180-smmu-500"))
+	    of_device_is_compatible(np, "qcom,sc7180-smmu-500") ||
+	    of_device_is_compatible(np, "qcom,sm8150-smmu-500") ||
+	    of_device_is_compatible(np, "qcom,sm8250-smmu-500"))
 		return qcom_smmu_impl_init(smmu);
 
 	return smmu;
-- 
2.26.1

