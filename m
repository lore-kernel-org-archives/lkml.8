Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE84C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 06:04:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 013B52070A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 06:04:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DkXKFqyf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728218AbgEUGEe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 02:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728136AbgEUGEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 02:04:30 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C49C05BD43
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 23:04:30 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id c75so2689895pga.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 23:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BrczHrPxmDimhB0/0NhkdkJAAqMI1FXR2cfHE8LPPuw=;
        b=DkXKFqyffhopz4NwbPl/fCxYBCpjpkQxwbDhRe0RUw/0i3pGXZNj5k9ckrmZ6QPsFQ
         V9rj/yOL43qEhl9wMacg4mtbJoXeNHfw9/bOHy2t6JwOqWI4WIcYNTWFX4XiNPblmCCW
         Tv5wCnrNEk90bcB8j30HJ/LC1oKhJUUlhuV+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BrczHrPxmDimhB0/0NhkdkJAAqMI1FXR2cfHE8LPPuw=;
        b=SRMpLPNn4cHPhqN1BTxcABZhtvmVUvBiavxu60aTTS0gWDrYA313HSvUnZxLQHx7Bi
         4zSUBHkcYzpOoaV+sGYka4CPBEdeH+8cH7pAzIzW0kSnEbwTaqYpWq3RkfkWlo1p1ov0
         0gRTncljaFPu6W26d/9dAKWevWF9d1C8a31FWbMyoeJXOUbK0G7M3l7EdDXwdhp9SAfM
         BEW+xVL8pOyRbIaMMoE64eCQXIDyaf5AH6NfqJ8ZFTMGzvpbq5uzlpRsStUEbKRatYY7
         koHQPQeMjxshRLvjIAaBMm+IjfCDx78AEDv74Boja4Oq44X8eFTnexvUHnoYDMC+n+Ak
         7sPA==
X-Gm-Message-State: AOAM531YQ4pfByi8/eN7PBUeYV6pLCPhKHGVAeqKqNRNlQSbZWwwyhPc
        2qkTouT47zAykAdHjk99xHJZPg==
X-Google-Smtp-Source: ABdhPJzHcQpJ2Uhf5/nuD8OHTpeaxu6Fxj7Zae/4TDavTQ4WzKGzxsX8Csvylbok0M8FpG1epS82KQ==
X-Received: by 2002:a62:ddd6:: with SMTP id w205mr7790955pff.291.1590041070323;
        Wed, 20 May 2020 23:04:30 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id k18sm3590146pfg.217.2020.05.20.23.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 23:04:29 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Maulik Shah <mkshah@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCHv3/RESEND 2/3] soc: qcom: rpmh-rsc: Loop over fewer bits in irq handler
Date:   Wed, 20 May 2020 23:04:24 -0700
Message-Id: <20200521060425.24285-3-swboyd@chromium.org>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
In-Reply-To: <20200521060425.24285-1-swboyd@chromium.org>
References: <20200521060425.24285-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

readl() returns a u32, and BITS_PER_LONG is different on 32-bit vs.
64-bit architectures. Let's loop over the possible bits set in that type
instead of looping over more bits than we ever may need to.

Cc: Maulik Shah <mkshah@codeaurora.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/soc/qcom/rpmh-rsc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index 60fc56987659..ce725d4ff097 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -383,7 +383,7 @@ static irqreturn_t tcs_tx_done(int irq, void *p)
 
 	irq_status = readl_relaxed(drv->tcs_base + RSC_DRV_IRQ_STATUS);
 
-	for_each_set_bit(i, &irq_status, BITS_PER_LONG) {
+	for_each_set_bit(i, &irq_status, BITS_PER_TYPE(u32)) {
 		req = get_req_from_tcs(drv, i);
 		if (!req) {
 			WARN_ON(1);
-- 
Sent by a computer, using git, on the internet

