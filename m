Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA356C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A3C5206C3
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:51:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rDkRS6zy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729675AbgHFRvY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728207AbgHFQcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 12:32:31 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3CB8C02B8C4
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 09:31:36 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id y3so44608925wrl.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 09:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K0z+nN4Q2Lop7WGeqT2R4X33dK+rJ9oWoUAFXO5nbng=;
        b=rDkRS6zy1V+kPfp+/a8fkd3XWxVI36H7Hci5dkKNDtqe7glv3N01cuhkrd9149KBrp
         KqkqRLtj4VFf4J5D2yIR5qFHExE+56hq+F86aoeNqR2YTFyg7+29Ftq/JxxICKK+t/uP
         4EPyBAPK3afS2C+RGssubuyDS1X2VmflQyupcqs/imRgPFfht4CL/pZM4ZF4AA1UXQGC
         c8Tnhq57i6SnofcJ0PgQ8/HJ/vTN3fSezs9s2+IHsj1Jk3e9KBmEQ6ODk4hf6J6NNrGc
         oWcMJ/dxevSCE/kW447IzlLPCiXDgDxe91/zr8mttDdVpDTbNrgVWUE09FqwZJr4IOoH
         sT5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K0z+nN4Q2Lop7WGeqT2R4X33dK+rJ9oWoUAFXO5nbng=;
        b=d7LPXVBYaYdD1t/75k87+JOVGsdjzW7BQ57b4PpY49H8yLmeBNg9gl/Xd7I4ZVI0M5
         EdBQN0gVRsm+32dM+GX5bPSytEQlLg0whORSm6EwOamcnfST1T4lwEtVBjupwR6/2oKT
         UkAtsydqHrneGW1b8jnd9fzaG2WuORHhl9LyQxyE717U0lbYXINHlhyqcABwRWEgZyq2
         sXvON8/Czq93aTyQnWm4kXC5u8PeorT5ce/REaQGtl44xWmNjVGX97HDGHDMRhg0Z2WF
         cMVSQAtCkFxn/BNxUciXPA3marAtcPczxJ+y0op40EFoQxCpDb8CInN+zt3s4hoQLg+a
         L2Aw==
X-Gm-Message-State: AOAM532NApTgW7Ng8b/y94isSSeM90sAbU4CjgWJAvmVOTnbA50Da3ep
        t/latE7w1L4zrjQWylaleq6Q8A==
X-Google-Smtp-Source: ABdhPJxEWkKxjmYT87kSQKI/wM2IQuf7tTYF26VwCw7rIKhm7CGMFJ0ShTSmBNzBxRiYEhaR4GamdA==
X-Received: by 2002:adf:dd4f:: with SMTP id u15mr8195593wrm.275.1596731495462;
        Thu, 06 Aug 2020 09:31:35 -0700 (PDT)
Received: from localhost.localdomain ([87.120.218.65])
        by smtp.googlemail.com with ESMTPSA id i66sm7468537wma.35.2020.08.06.09.31.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Aug 2020 09:31:34 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     robh+dt@kernel.org, bjorn.andersson@linaro.org,
        sibis@codeaurora.org, mka@chromium.org, dianders@chromium.org,
        georgi.djakov@linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/7] interconnect: qcom: sdm845: Replace xlate with xlate_extended
Date:   Thu,  6 Aug 2020 19:31:23 +0300
Message-Id: <20200806163126.22667-5-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200806163126.22667-1-georgi.djakov@linaro.org>
References: <20200806163126.22667-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the qcom_icc_xlate_extended() in order to parse tags, that are
specified as an additional arguments to the path endpoints in DT.

Tested-by: Sibi Sankar <sibis@codeaurora.org>
Reviewed-by: Sibi Sankar <sibis@codeaurora.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/interconnect/qcom/sdm845.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/interconnect/qcom/sdm845.c b/drivers/interconnect/qcom/sdm845.c
index f6c7b969520d..3b81dbb71b0b 100644
--- a/drivers/interconnect/qcom/sdm845.c
+++ b/drivers/interconnect/qcom/sdm845.c
@@ -469,7 +469,7 @@ static int qnoc_probe(struct platform_device *pdev)
 	provider->set = qcom_icc_set;
 	provider->pre_aggregate = qcom_icc_pre_aggregate;
 	provider->aggregate = qcom_icc_aggregate;
-	provider->xlate = of_icc_xlate_onecell;
+	provider->xlate_extended = qcom_icc_xlate_extended;
 	INIT_LIST_HEAD(&provider->nodes);
 	provider->data = data;
 
