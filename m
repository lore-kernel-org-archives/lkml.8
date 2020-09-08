Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFF23C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADBB520658
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:52:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MjtH2eoL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732395AbgIHTwC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730727AbgIHPtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:49:39 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 055DEC061347
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 05:33:30 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id y1so2737977ejq.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 05:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=U/ytzC+Xy3Xxbn3dWyObssuKdvhh3djXX6G5KrguHpw=;
        b=MjtH2eoLRl2Yx7RGtVGNBFgZha7XbJDmTzJ4JjTcvphGudl1klnSeOMryTbu+Ily37
         14AklWjovAy63brJ/GgEQIDkKrs/31qaZdDaaUTOc7blnCecsjH9LGMxMWo25+EQ/mJB
         MXuU3RBSzuDcC/KTnmqaYkvIrQLkgDbd4vdBW+3YRA+66uX2cNSZNvUWsqWytxCyZRUc
         XAK49sYqHBftaE3lz8/C8T5JtXldioVXGC78H2KCRFYlExr6qU/Co8K8+6dYMX3uXG8E
         mbfvO6nTM6/YTMqq2Oyl5p2FVdLxtGH8nsY2MUNe1JuQxigIbKnx5yUlCMnhSVOp0PKr
         yBTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=U/ytzC+Xy3Xxbn3dWyObssuKdvhh3djXX6G5KrguHpw=;
        b=bbAD/Z3OaRl1zUikk2b4+So6Pc/ySjrjXksUwx5YYt77C6LKJsOymfuaPJXWMR8UYp
         QYfzaulaP5uQ2WQY8qNDX7PmOdvDZQxNNADluFruRdaRQuroNWYyKwlMRxwJU4iwG3RV
         FAmpon6xrrvQn77dSD6/K+81Uco7euIfyaNwv2xLll2gKmIsTe8BvSRQe2PIzkxEpe0o
         GF+Qrk3dpKJzGVdhrC5Hs+LFhIIo2omaZlFNd2LQUezLeDhBWYO2kT4iNwVkpRLZGj6x
         Hf8Taw3pOKFUoopUchiT3c0cdgqad1ciOdQCy3e5w9O0Qr7pAa1ZZrCZbbKi1YOc/SZE
         /4gg==
X-Gm-Message-State: AOAM5309WKMRjCLapelZRehciZA7uu6RueQpXzzU3ONo/q9CGjXQip5T
        txtzdGoeRmKErTcEFWzIO6jT4CCpvKSlBki4
X-Google-Smtp-Source: ABdhPJwP5Dtyk6XvdHyWoAeIATGo0/jTovJF2dUFA4ZnMyr0o1/OZvHbiVUU4RhBjHgXEBsTQ81vLg==
X-Received: by 2002:a17:907:37b:: with SMTP id rs27mr27158410ejb.0.1599568408830;
        Tue, 08 Sep 2020 05:33:28 -0700 (PDT)
Received: from localhost.localdomain ([195.24.90.54])
        by smtp.gmail.com with ESMTPSA id y9sm17499744edo.37.2020.09.08.05.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 05:33:28 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Cc:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        nicolas.dufresne@collabora.com,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v3 2/6] venus: hfi_helper: Add VP9 profile and levels
Date:   Tue,  8 Sep 2020 15:32:17 +0300
Message-Id: <20200908123221.2793-3-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200908123221.2793-1-stanimir.varbanov@linaro.org>
References: <20200908123221.2793-1-stanimir.varbanov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add HFI defines for VP9 codec profile and levels.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 drivers/media/platform/qcom/venus/hfi_helper.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/media/platform/qcom/venus/hfi_helper.h b/drivers/media/platform/qcom/venus/hfi_helper.h
index 758c70ac26fd..60ee2479f7a6 100644
--- a/drivers/media/platform/qcom/venus/hfi_helper.h
+++ b/drivers/media/platform/qcom/venus/hfi_helper.h
@@ -364,6 +364,24 @@
 #define HFI_HEVC_TIER_MAIN			0x1
 #define HFI_HEVC_TIER_HIGH0			0x2
 
+/* VP9 Profile 0, 8-bit */
+#define HFI_VP9_PROFILE_P0			0x00000001
+/* VP9 Profile 2, 10-bit */
+#define HFI_VP9_PROFILE_P2_10B			0x00000004
+
+#define HFI_VP9_LEVEL_1				0x00000001
+#define HFI_VP9_LEVEL_11			0x00000002
+#define HFI_VP9_LEVEL_2				0x00000004
+#define HFI_VP9_LEVEL_21			0x00000008
+#define HFI_VP9_LEVEL_3				0x00000010
+#define HFI_VP9_LEVEL_31			0x00000020
+#define HFI_VP9_LEVEL_4				0x00000040
+#define HFI_VP9_LEVEL_41			0x00000080
+#define HFI_VP9_LEVEL_5				0x00000100
+#define HFI_VP9_LEVEL_51			0x00000200
+#define HFI_VP9_LEVEL_6				0x00000400
+#define HFI_VP9_LEVEL_61			0x00000800
+
 #define HFI_BUFFER_INPUT			0x1
 #define HFI_BUFFER_OUTPUT			0x2
 #define HFI_BUFFER_OUTPUT2			0x3
-- 
2.17.1

