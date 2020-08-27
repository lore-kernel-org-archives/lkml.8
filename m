Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E006C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 09:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39DCA2177B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 09:25:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f+pTmgDm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbgH0JZL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 05:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728555AbgH0JZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 05:25:06 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B75C06121B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 02:25:05 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id k15so875298wrn.10
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 02:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rGqT7srmFAjxM5njBGX2TMqgn+GAvNxXqSd+GHPZX9A=;
        b=f+pTmgDm/DKMlxPbeJzbk9Hif87pYsP3omG0gPyVr9mgLkGJdniqShJ83UPveG/GDz
         o46myXYaeLLS16hwT7cLTN9x+CitiSttF1ldsRTbG5M9MJAYp7jTmlFjXbCeIGkORPY7
         vxN8WYmg9B8ztxNylLjLLok+HiBWesI2wYh/8bTmlIUHI2EUFz9CyKP+cQiYtUAtmS8K
         LUbe+v67RgK2LFR1pzghN/DYExSNrrLbV6jnRMGlSWSFOVWosvNTbFDZSK65XPmb6rTH
         7u0XvnJaY6rPITBn8kK5hVNVkacJA6b5CY6JrO9RkibYyxz8BQRLbvgKGzKb9YDMu8qQ
         pU1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rGqT7srmFAjxM5njBGX2TMqgn+GAvNxXqSd+GHPZX9A=;
        b=JL2gMk2abA5v4CxwOYtq77JtdKrwsD61IxKUFnNPt0ZqVB+78HWeg5N14Yg4GoUCsp
         tg8rSBZek7crB4nAbLmYP8xf5TuxEG1LkdBNsWBWtVuwAAgJo5zBS2vD5EbJ+m/OHLeu
         4YIpZDDt92iCfMheLYdz5eYW3xwcSxIcvtOzbBTmRZCIwk8viTVfGlXtAW4XnlNB7S70
         Nm6ew7oYHhX/eC2EX0OUZ14q/qHngX7B7X3pddHw0P+h/B/soy5X0xZ8ia9zdGc8Yya8
         pgIv/Ulr/bTkMTg5fFKZjPyXmJrr/u4OQSwdkjPwH9hyCfB/DyYG4un1XzG72mLMPvcc
         pAjw==
X-Gm-Message-State: AOAM5338H86vONeb2M3E+15yH+Y6HrBxT60Bktn7GjZck4idTH2AQxLZ
        Vy5qClh/DgAxNkJ4LNMboKx0fG4tdr2iYfTH
X-Google-Smtp-Source: ABdhPJzUjrlZ6nfXQRs00k+sxlWe8Lcdhud3RXEWA9JgMHa2dZw/NBbQAuBjMVabv+Y8CBD4XemJyg==
X-Received: by 2002:adf:dfc8:: with SMTP id q8mr18516222wrn.231.1598520304235;
        Thu, 27 Aug 2020 02:25:04 -0700 (PDT)
Received: from localhost.localdomain ([195.24.90.54])
        by smtp.gmail.com with ESMTPSA id z203sm4357330wmc.31.2020.08.27.02.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 02:25:03 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     Dikshita Agarwal <dikshita@codeaurora.org>,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH 05/13] venus: hfi_plat: Add codecs and capabilities ops
Date:   Thu, 27 Aug 2020 12:24:09 +0300
Message-Id: <20200827092417.16040-6-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200827092417.16040-1-stanimir.varbanov@linaro.org>
References: <20200827092417.16040-1-stanimir.varbanov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ops to get the supported by the platform codecs and capabilities.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 drivers/media/platform/qcom/venus/hfi_platform.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/platform/qcom/venus/hfi_platform.h b/drivers/media/platform/qcom/venus/hfi_platform.h
index 174428e97b86..8084d092d5d1 100644
--- a/drivers/media/platform/qcom/venus/hfi_platform.h
+++ b/drivers/media/platform/qcom/venus/hfi_platform.h
@@ -46,6 +46,8 @@ struct hfi_platform_codec_freq_data {
 struct hfi_platform {
 	unsigned long (*codec_vpp_freq)(u32 session_type, u32 codec);
 	unsigned long (*codec_vsp_freq)(u32 session_type, u32 codec);
+	void (*codecs)(u32 *enc_codecs, u32 *dec_codecs, u32 *count);
+	const struct hfi_plat_caps *(*capabilities)(unsigned int *entries);
 };
 
 extern const struct hfi_platform hfi_plat_v4;
-- 
2.17.1

