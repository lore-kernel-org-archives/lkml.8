Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE84CC433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 14:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89951206EB
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 14:42:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vOSGEgf6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729324AbgICOmM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 10:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729298AbgICOiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 10:38:22 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA19C0619EE
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 06:31:43 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id w5so3243510wrp.8
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 06:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K0z+nN4Q2Lop7WGeqT2R4X33dK+rJ9oWoUAFXO5nbng=;
        b=vOSGEgf6njBXHejEOPLRHy4TZAUQbPHyzsizQv5UbjVey2hgli2PPE3iNmgeVMMFs0
         meXBmX3GehNJYf3Ml6pbsP2w+4GF+P6VawqJTS1rRAj2/4oGepg1b1xG2XaSI+e7RWit
         8HUcIb5RhAPVg5TvwMbJZEM/MIjDq/fbCrqfS6Y053rTcS1XYTsuVRGfBIvafn9rNkmi
         JEwAseO17PL7oWFMSA4A66UwSwyoHr2SapFY34R7ouYM7Gj0Ukfc4mWUoe51kB+Gc+MZ
         cN+Ql6/5tuaw74VyLSTTKCj6J2l3AVXNMioaOfqFNUGt1QtHYWuOnVdgucewh50lSBBR
         KCIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K0z+nN4Q2Lop7WGeqT2R4X33dK+rJ9oWoUAFXO5nbng=;
        b=Ewm0B8OQrJZkXteL6qArzi3rQGdCEWbpFi+bbxTbNzwXRB61pfBxYi9oss5mxMKQ81
         7K26Gtt/bsTXal8HgCloEBHiRHgq1eP7sbYo3uhGzWZUvWqcSNE8K8q/F/Pmy5nHmy7p
         i8eSNa41FyT1ozhoJKY64YNBLfiw2uMXaHxMjBxqXG09sOxRVrPZJRggTWuuzHTLyZ8B
         mXM8irsm8u/90DR5rKEhA7EPk5I2V19pFUAsVJ9SRWxAbg4oyLa9wc/Ll83DID4NsqP2
         mfaVQlCxtdRg7bHvUn7f81iXHNr9ZF5hboH3QIoS0cFH774Q/Z/K1NG7sUvtzzqnliVQ
         wrtA==
X-Gm-Message-State: AOAM533gf0hoYQz2R8eXSeKNOwHMJZe07EhdEC55k1PBNzG7g5eAw5FS
        UmaoeHUBlVXqvfKLXciA6SeaRg==
X-Google-Smtp-Source: ABdhPJxTxGCfwDBn+/7V1YSvROvPT1ttvkiv0uIYlja7weTTbnepk4txpD42uCKrL8YHil8kIzqmkQ==
X-Received: by 2002:adf:fe42:: with SMTP id m2mr2451454wrs.367.1599139902154;
        Thu, 03 Sep 2020 06:31:42 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id b2sm4310768wmh.47.2020.09.03.06.31.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Sep 2020 06:31:41 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org, bjorn.andersson@linaro.org
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        sibis@codeaurora.org, mka@chromium.org, dianders@chromium.org,
        georgi.djakov@linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/7] interconnect: qcom: sdm845: Replace xlate with xlate_extended
Date:   Thu,  3 Sep 2020 16:31:31 +0300
Message-Id: <20200903133134.17201-5-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200903133134.17201-1-georgi.djakov@linaro.org>
References: <20200903133134.17201-1-georgi.djakov@linaro.org>
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
 
