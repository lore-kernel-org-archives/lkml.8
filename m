Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62622C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 11:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4176720838
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 11:47:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uaEmjOC2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbgG3Lrf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 07:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727914AbgG3LrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 07:47:18 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7233FC0619D6
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 04:47:18 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id l2so14045799wrc.7
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 04:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CTatHtGbJyhfIe07LyOFqsBAVFHXpCGvt0MRleoAwFM=;
        b=uaEmjOC2l9sHxKq7NHLH6ZQ/+FQ9P8LnKs3PJp993cAdhk0pREg2Wiryu6EtJVV4/t
         9PSq1/5a8rp94P/DPRkFKBMb44gE/F5+TSyztqX0OSRMKgsNABOl8UacD1ia2FwnxeLI
         YnpfZ9Wprk8Sq/Q3DWDoXEd1Ba0uBG+DmAhlk/4OEygcCkGPbpuEwtXdrgKRRd1kSuSM
         gv9WSizuUKm8a6VOGRTObtnR6vZ142SDrrbiGt7lxr1PnoU4Mk2pOsQ+DWQeClt6T7CD
         WVHny8bvWrDgog3DcOj4SD4/341IqiLTqEPzTSgyEeueBPtpyyrq5iZSu7DmuO7TUz+U
         ahhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CTatHtGbJyhfIe07LyOFqsBAVFHXpCGvt0MRleoAwFM=;
        b=ZnBkvzHH7akZKnj1LX08Ike/WP2+fB0DdjB48ipY0YIe6CFkWT6OFwcNGETYOLhF6F
         nhuXPzP6YJru2J3YLw/+uoZfbQm6Mc2/dvXYNgFuaukbsKvkW5H12bVpI6xPwfdYO6AB
         vAcQd4yhAVlfwLydFEowsnxUEs/GHvop3lfLcmcgeSGGHGqIV7lKN2LE3fzKfVFhMj3z
         bp3rHRFOVJ0wxFWUOLhS1brcO2es37fWHIy/ksHxfqXJzwnSg3JsP1AP3EzumtYZ2htO
         DHLMAjaYpo1RmdpfzQu3TH/xUgDdAAtisS89FWDh4m/wJNp7QsktOOX94XsEE9mihQyZ
         5KNg==
X-Gm-Message-State: AOAM5325qIxZyfl++h9sZYckUvVyynq0qTZg5EHkI9w7wD0LOM4imWZO
        67S4L0yPGBpC0bPh2L9y9+cBZA==
X-Google-Smtp-Source: ABdhPJxSRZkvCIm8Zm439FWlOxBqCLeYktGV8+YQ++3WfHvvEz+Xf5CpMovL50+ZyWyEAs/WLFhMuw==
X-Received: by 2002:adf:a192:: with SMTP id u18mr2704077wru.158.1596109637205;
        Thu, 30 Jul 2020 04:47:17 -0700 (PDT)
Received: from localhost.localdomain ([195.24.90.54])
        by smtp.gmail.com with ESMTPSA id 32sm9636691wrn.86.2020.07.30.04.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 04:47:16 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH 1/3] venus: parser: Prepare parser for multiple invocations
Date:   Thu, 30 Jul 2020 14:46:30 +0300
Message-Id: <20200730114632.6717-2-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200730114632.6717-1-stanimir.varbanov@linaro.org>
References: <20200730114632.6717-1-stanimir.varbanov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Presently the hfi_parser has been called only once during driver
probe. To prepare the parser function to be called multiple times
from recovery we need to initialize few variables which are used
during parsing time.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 drivers/media/platform/qcom/venus/hfi_parser.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/media/platform/qcom/venus/hfi_parser.c b/drivers/media/platform/qcom/venus/hfi_parser.c
index 7f515a4b9bd1..363ee2a65453 100644
--- a/drivers/media/platform/qcom/venus/hfi_parser.c
+++ b/drivers/media/platform/qcom/venus/hfi_parser.c
@@ -239,6 +239,9 @@ u32 hfi_parser(struct venus_core *core, struct venus_inst *inst, void *buf,
 
 	parser_init(inst, &codecs, &domain);
 
+	core->codecs_count = 0;
+	memset(core->caps, 0, sizeof(core->caps));
+
 	while (words_count) {
 		data = word + 1;
 
-- 
2.17.1

