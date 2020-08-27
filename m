Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E70C7C433E4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 09:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C716A22BEA
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 09:26:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H5LzqCfe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728679AbgH0J0B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 05:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728593AbgH0JZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 05:25:22 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16648C061232
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 02:25:21 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id c18so120861wrm.9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 02:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IjADWSzCT4tmeYYeqMnXWFvGOJch/PV6F9uHmYRiMqE=;
        b=H5LzqCfeFZyNCB8pFfEUZDJVEbwg3Q4f9eQe6thXzFWYdZdONwgHO86GMtBhyn8IL5
         0RER+QCmlz5nDZEkIgPsvGJOARpWjuFRNK5xy6qg0AqcnVrcJRHQAn1sC9hRWR/MZoo1
         FbDpQZvuJ4FNVgV2C6lI6+DIoTtxlvBAeJuPzj4X8a+w/qyW3b5YJ9AecYk1EoDyhUH2
         kccxfi8L5RvDEPwdipli08No/B+MVkIiI8Sa7Hy3kZpeCGoZEPeSPvIjKKQpI/7Nuen8
         8hMdO3deTxfFBQiEcBkHjSdMGHOXS/+wi+ZPyeROthYZFCMXuItg2DTE40Y09PygkQbL
         OH4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IjADWSzCT4tmeYYeqMnXWFvGOJch/PV6F9uHmYRiMqE=;
        b=j4NCK3UTu8KtVMw/fqNy0Sv+rn5QWSZP5ugCYPgqfsjYaBFXwvdTVj3ncAlXBRupTp
         p5kfmwdOZ2zldIArCRC9cOF5pZVzx+FZj9YmHW2uwYO1qavwQcPBUteZ54+N7hme3w9j
         0f28t2+aCIAA9K3fm9k5gy7YadLidpGJZtPqVCvrXcpnp0mdO0eMMJHn6qcifbCw0MFU
         IsKyudUrDcZd4tidR+PueuK3f1vUNf6ImZI/QYVzZiMmXro8TNmPc5CiwwgZ9p+tHouQ
         CdGsaQ0dUnwHHJg9DcSY6YtLgKLQQhdyDsOGjxgO17fppymyNJQpXqqWqxN09ZW9uZIG
         f5MQ==
X-Gm-Message-State: AOAM531FKeTVwnLoVkv7gwUXhfR9W2XQs2maY+UDLwEoYUhVgOk08I1Z
        AtiJrHc4p4eXGrqyRRxbsq6JmjQFA8gIZuaq
X-Google-Smtp-Source: ABdhPJyXdByp/QY4jGTTdz9nkVjI6RE0Le5Q5fbmhmL4aoKfdL8/G0zUINvAzbXXR5CY9KntS2YWzA==
X-Received: by 2002:adf:f20b:: with SMTP id p11mr13232088wro.388.1598520319384;
        Thu, 27 Aug 2020 02:25:19 -0700 (PDT)
Received: from localhost.localdomain ([195.24.90.54])
        by smtp.gmail.com with ESMTPSA id z203sm4357330wmc.31.2020.08.27.02.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 02:25:18 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     Dikshita Agarwal <dikshita@codeaurora.org>,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH 11/13] venus: Get codecs and capabilities from hfi platform
Date:   Thu, 27 Aug 2020 12:24:15 +0300
Message-Id: <20200827092417.16040-12-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200827092417.16040-1-stanimir.varbanov@linaro.org>
References: <20200827092417.16040-1-stanimir.varbanov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wire up hfi platform codec and capabilities instead of
getting them from firmware.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 .../media/platform/qcom/venus/hfi_parser.c    | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/media/platform/qcom/venus/hfi_parser.c b/drivers/media/platform/qcom/venus/hfi_parser.c
index ecf68852c680..f0c9f73f842d 100644
--- a/drivers/media/platform/qcom/venus/hfi_parser.c
+++ b/drivers/media/platform/qcom/venus/hfi_parser.c
@@ -228,11 +228,48 @@ static void parser_fini(struct venus_inst *inst, u32 codecs, u32 domain)
 	}
 }
 
+static int hfi_platform_parser(struct venus_core *core, struct venus_inst *inst)
+{
+	const struct hfi_platform *plat;
+	const struct hfi_plat_caps *caps = NULL;
+	u32 enc_codecs, dec_codecs, count;
+	unsigned int entries;
+
+	if (inst)
+		return 0;
+
+	plat = hfi_platform_get(core->res->hfi_version);
+	if (!plat)
+		return -EINVAL;
+
+	if (plat->codecs)
+		plat->codecs(&enc_codecs, &dec_codecs, &count);
+
+	if (plat->capabilities)
+		caps = plat->capabilities(&entries);
+
+	if (!caps || !entries || !count)
+		return -EINVAL;
+
+	core->enc_codecs = enc_codecs;
+	core->dec_codecs = dec_codecs;
+	core->codecs_count = count;
+	memset(core->caps, 0, sizeof(*caps) * MAX_CODEC_NUM);
+	memcpy(core->caps, caps, sizeof(*caps) * entries);
+
+	return 0;
+}
+
 u32 hfi_parser(struct venus_core *core, struct venus_inst *inst, void *buf,
 	       u32 size)
 {
 	unsigned int words_count = size >> 2;
 	u32 *word = buf, *data, codecs = 0, domain = 0;
+	int ret;
+
+	ret = hfi_platform_parser(core, inst);
+	if (!ret)
+		return HFI_ERR_NONE;
 
 	if (size % 4)
 		return HFI_ERR_SYS_INSUFFICIENT_RESOURCES;
-- 
2.17.1

