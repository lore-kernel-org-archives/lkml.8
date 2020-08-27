Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93627C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 09:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A36A2177B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 09:25:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hnbPjqc5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728544AbgH0JZE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 05:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728432AbgH0JYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 05:24:54 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D5AFC06121B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 02:24:54 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id b18so4651729wrs.7
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 02:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=y6eC9FLONwMHdn6Vk0cNJPGbuy8ijaSCojAKxgZZyGI=;
        b=hnbPjqc5lM+2ivWPWllQVpQjADKutPYchKe3HF5YZEtqdQv5wcsgAsTa4QRucC7KXm
         Fu0kESFc2qZknb+X0Rv98VLtHjG6hEw9sVXLN0Uhu/Jwf8srK+lEFy1gl0o/PNKM7TSi
         S/pYjYrB1fZerg/uae81FFQKOdK1/DEKvXyvoNlslFdEHJT7u8RmjKyhzWbP83BqUGpU
         nixwNth8eI+fGKSYvBKP6+9x55Sgd9bLhcNrJ7Axst+6u2Xl5MPzx1l0Y0Wrvnr8vTSc
         WHUmuWpHE2OG+j5ZwAH3oOJsFFmzZQJ3VGzYpgUZpDACYU0vdfwOw0JHhQNVY95KCzrq
         Uxtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=y6eC9FLONwMHdn6Vk0cNJPGbuy8ijaSCojAKxgZZyGI=;
        b=fqHa0mEoj4vJD0eseDWt5WxHsqHEiD+3QV1Uji2fT/+0KZoWXzJ1fd0ctnPlnD55KD
         k/2J3XaESz/pcnq/OO00d7mF3Lwhs8g7pJMinZISIpWN0ecKppBSdRm0kIbqDkII4RWg
         uiti5vfe/uwA/RBpHpgZGfOcTouc8yvSypcKwnKmHjuKcH7X3O/wtJC8QWMEQdbBwtFo
         /x82P/FK93f8fCWdE2pul3XKVarDiQCXIV6XpTfk5K/HIZRKLIbjSvndLqeAFhcPH2KY
         /nTdcgJMZYXCQInSOAdMS7Hfvcvo8qLmneZMBp6LfhedPt0h6CW5oI5ZJ+ly+mLoW9Os
         cmVg==
X-Gm-Message-State: AOAM53020R2M7qPR6M6ooqpf4CO0H27xKDTDBPXmH0YyPdIZAkIvImiI
        npWsh7Bh1FefTIdZZJIzpD57KxQJQhFf52xM
X-Google-Smtp-Source: ABdhPJzhjGcMcaab0JBm7YKdkEeQjDzX8SevME+a/8lFxMocA/bRceA4s3D9XxUWxvQN3fyah0kthw==
X-Received: by 2002:a5d:6944:: with SMTP id r4mr20635784wrw.132.1598520292764;
        Thu, 27 Aug 2020 02:24:52 -0700 (PDT)
Received: from localhost.localdomain ([195.24.90.54])
        by smtp.gmail.com with ESMTPSA id z203sm4357330wmc.31.2020.08.27.02.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 02:24:52 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     Dikshita Agarwal <dikshita@codeaurora.org>,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH 01/13] venus: Delete not used core caps
Date:   Thu, 27 Aug 2020 12:24:05 +0300
Message-Id: <20200827092417.16040-2-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200827092417.16040-1-stanimir.varbanov@linaro.org>
References: <20200827092417.16040-1-stanimir.varbanov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The core caps are filled but not used, delete them. In case we
need them we can re-introduce.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 drivers/media/platform/qcom/venus/core.h      | 6 ------
 drivers/media/platform/qcom/venus/hfi_venus.c | 3 ---
 2 files changed, 9 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
index a9a52e29312d..18cf5b329a2b 100644
--- a/drivers/media/platform/qcom/venus/core.h
+++ b/drivers/media/platform/qcom/venus/core.h
@@ -143,7 +143,6 @@ struct venus_caps {
  * @enc_codecs:	encoders supported by this core
  * @dec_codecs:	decoders supported by this core
  * @max_sessions_supported:	holds the maximum number of sessions
- * @core_caps:	core capabilities
  * @priv:	a private filed for HFI operations
  * @ops:		the core HFI operations
  * @work:	a delayed work for handling system fatal error
@@ -189,11 +188,6 @@ struct venus_core {
 	unsigned long enc_codecs;
 	unsigned long dec_codecs;
 	unsigned int max_sessions_supported;
-#define ENC_ROTATION_CAPABILITY		0x1
-#define ENC_SCALING_CAPABILITY		0x2
-#define ENC_DEINTERLACE_CAPABILITY	0x4
-#define DEC_MULTI_STREAM_CAPABILITY	0x8
-	unsigned int core_caps;
 	void *priv;
 	const struct hfi_ops *ops;
 	struct delayed_work work;
diff --git a/drivers/media/platform/qcom/venus/hfi_venus.c b/drivers/media/platform/qcom/venus/hfi_venus.c
index 4be4a75ddcb6..cb0e657b7649 100644
--- a/drivers/media/platform/qcom/venus/hfi_venus.c
+++ b/drivers/media/platform/qcom/venus/hfi_venus.c
@@ -1591,9 +1591,6 @@ int venus_hfi_create(struct venus_core *core)
 	hdev->suspended = true;
 	core->priv = hdev;
 	core->ops = &venus_hfi_ops;
-	core->core_caps = ENC_ROTATION_CAPABILITY | ENC_SCALING_CAPABILITY |
-			  ENC_DEINTERLACE_CAPABILITY |
-			  DEC_MULTI_STREAM_CAPABILITY;
 
 	ret = venus_interface_queues_init(hdev);
 	if (ret)
-- 
2.17.1

