Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FBCAC2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 21:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 750FE214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 21:13:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YACiuw3I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbgA3VN1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 16:13:27 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39090 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727881AbgA3VNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 16:13:01 -0500
Received: by mail-pl1-f196.google.com with SMTP id g6so1822461plp.6
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 13:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EhLkjJnc7Tvg6c+D+i1atdDK7ul7OoMcFLbEV57smwA=;
        b=YACiuw3I6aQW0okCZOZkbpI2LnSUUT86cYe3PTxGtY1G13lrknoeNOR2rW5w5eOray
         ZZ2JTVB/LmgPEBfvXGBqo39b8Qkg6WJIwUB+a9Yube+JSCvieaBgBoPpPfRoshZiJ6Xt
         Z7qK51vcg20SjzF2Bx9aXYpj5/suCssdR4bZ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EhLkjJnc7Tvg6c+D+i1atdDK7ul7OoMcFLbEV57smwA=;
        b=rp1t74aDAFzYKjElBOeNxwzLpuBUKJwwNDaoJBNAUMdchZLul7YV+QSNpw0qJBAX1L
         Zcswq87szXJ6IvViuPE3qnytJlicwyJ7Eosb0Cs4c7Y5dQEpSn17TrGzJ/5S4LfFnkCr
         d7WVK8bex3xKQlw/4J5NFIJF6OJ6Hf/PDCIRUGjuoGf0CyngZkkCugknnp2hh9CyX3Tz
         IA2e4/EE2c55BqMJ+Rz3NBWOxjX9/lZ7hHhYWh6S9WOBDa8TZh1wKOT7XjVKB2FMUeCh
         4NXw9Az+0ftGa21Ggk4REhEp9DgKx5yGietUYB57KFLItTXyubUrSEBPZ3WYRdeQ8zdo
         R/9w==
X-Gm-Message-State: APjAAAUyMUgnpSqkGkeu6yXrf+ZDSEAsXao+GQcNcC0YQ4JkX1IgwMUM
        Qjal1cyQKRy+vdW7JSavLnhn0g==
X-Google-Smtp-Source: APXvYqyNswtUeRfxu8pkGT+lb94+9OrthlA8QLayMFGUxze8/lozqOfD3iWfnthyHmjjkmKqN5OnLQ==
X-Received: by 2002:a17:90a:8915:: with SMTP id u21mr8226951pjn.87.1580418780837;
        Thu, 30 Jan 2020 13:13:00 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id ci5sm4343871pjb.5.2020.01.30.13.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 13:13:00 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Rob Herring <robh@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Jeffrey Hugo <jhugo@codeaurora.org>,
        Taniya Das <tdas@codeaurora.org>, jeffrey.l.hugo@gmail.com,
        linux-arm-msm@vger.kernel.org, harigovi@codeaurora.org,
        devicetree@vger.kernel.org, mka@chromium.org,
        kalyan_t@codeaurora.org, Mark Rutland <mark.rutland@arm.com>,
        linux-clk@vger.kernel.org, hoegsberg@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 10/15] clk: qcom: Use ARRAY_SIZE in gpucc-sc7180 for parent clocks
Date:   Thu, 30 Jan 2020 13:12:26 -0800
Message-Id: <20200130131220.v3.10.I3bf44e33f4dc7ecca10a50dbccb7dc082894fa59@changeid>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
In-Reply-To: <20200130211231.224656-1-dianders@chromium.org>
References: <20200130211231.224656-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's nicer to use ARRAY_SIZE instead of hardcoding.  Had we always
been doing this it would have prevented a previous bug.  See commit
74c31ff9c84a ("clk: qcom: gpu_cc_gmu_clk_src has 5 parents, not 6").

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v3:
- Patch ("clk: qcom: Use ARRAY_SIZE in gpucc-sc7180...") split out for v3.

Changes in v2: None

 drivers/clk/qcom/gpucc-sc7180.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/gpucc-sc7180.c b/drivers/clk/qcom/gpucc-sc7180.c
index c88f00125775..a96c0b945de2 100644
--- a/drivers/clk/qcom/gpucc-sc7180.c
+++ b/drivers/clk/qcom/gpucc-sc7180.c
@@ -84,7 +84,7 @@ static struct clk_rcg2 gpu_cc_gmu_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gpu_cc_gmu_clk_src",
 		.parent_data = gpu_cc_parent_data_0,
-		.num_parents = 4,
+		.num_parents = ARRAY_SIZE(gpu_cc_parent_data_0),
 		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_rcg2_shared_ops,
 	},
-- 
2.25.0.341.g760bfbb309-goog

