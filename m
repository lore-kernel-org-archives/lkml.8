Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73402C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 20:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BCB62070A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 20:07:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BRtgwGCc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbgEOUHu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 16:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726585AbgEOUHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 16:07:43 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CB41C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 13:07:43 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id l1so3079026qtp.6
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 13:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3r8s7zaQa/KQl7hgw/M/WA+lgPX3mns2yHevK22z30k=;
        b=BRtgwGCcFo61RZsb2/I16jAiD4ENgLTywxJXh2NnUISr13acvjJOUE5nvgRKZkmM90
         wPV5jZALMt7CP2iveEOhtfs9XLAXOEPv2kijmh70T3xT/vcJ2//ofZVVy+PoCIH6l2OS
         E8j1OoCnwnuzIMqxwYf1ojxbGe5Wu74wMojaB0xOvgzMvmT5Xq+fvwXbkXg7f73FoyO6
         3mDSEY11pCdeQ4ZTBVjlgLFBTB3xtPmbsx8Ww7y6u6HbxKNQGbok/SOT06yTQDAW7Y3v
         /5//7Xd92KriSkL0nhQXTlbbgFjB2iC1CAjD37fekwyOeBe8lt2OoVX4ULr/8U1YklFh
         P9Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3r8s7zaQa/KQl7hgw/M/WA+lgPX3mns2yHevK22z30k=;
        b=KNq0P7dm/5Tlaxa/QSQwX211DECnGkRQhg0smOB5C+f6CJh4bJNUvQNegm2/KW7cv5
         hmLyimlX83Wo0ipzhbdQrxlz5xcyvjoueUUvTQ4OV6qemsQ+aUqKYq846JD3zhu05cDS
         lCSDmaDQCsUO+ERIraKDfd4IXxZFmi0U9vV/FTIfZI0Pw6LpLCUkgZirjhyVKRbuyYMm
         SmkcF+HxW8Zb1jlhWjj0A39rmGDW6hoxcPTtm9POoH4uURYmH8XAyoMLnMCRWXpN2TYq
         /z6jzp1OlIemDKpL+/9fu/N2WAuMhjJOJnfG3LRtUWk+M71Z/bxlAEctr9RuMTT9SQkv
         kMtw==
X-Gm-Message-State: AOAM531fzH1Ojz9acLKeqSL9ytwdcCT9g6KAhbqcW5yTgTwJCQOoyWlY
        R/ukRs2HTs+m3Un3ZBpzQBzhJQ==
X-Google-Smtp-Source: ABdhPJz+54fAQNJEeoaeaQPLvewzy1S/LrjWypbertBQ0Kd9eVZQrPTcNc5266QmcNbbuxxQ/rpHEQ==
X-Received: by 2002:ac8:e8f:: with SMTP id v15mr5246054qti.391.1589573262634;
        Fri, 15 May 2020 13:07:42 -0700 (PDT)
Received: from beast.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id 132sm2328246qkj.117.2020.05.15.13.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 13:07:42 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net
Cc:     evgreen@chromium.org.net, subashab@codeaurora.org,
        cpratapa@codeaurora.org, bjorn.andersson@linaro.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/2] net: ipa: do not clear interrupt in gsi_channel_start()
Date:   Fri, 15 May 2020 15:07:31 -0500
Message-Id: <20200515200731.2931-3-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200515200731.2931-1-elder@linaro.org>
References: <20200515200731.2931-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In gsi_channel_start() there is harmless-looking comment "Clear the
channel's event ring interrupt in case it's pending".  The intent
was to avoid getting spurious interrupts when first bringing up a
channel.

However we now use channel stop/start to implement suspend and
resume, and an interrupt pending at the time we resume is actually
something we don't want to ignore.

The very first time we bring up the channel we do not expect an
interrupt to be pending, and even if it were, the effect would
simply be to schedule NAPI on that channel, which would find nothing
to do, which is not a problem.

Stop clearing any pending IEOB interrupt in gsi_channel_start().
That leaves one caller of the trivial function gsi_isr_ieob_clear().
Get rid of that function and just open-code it in gsi_isr_ieob()
instead.

This fixes a problem where suspend/resume IPA v4.2 would get stuck
when resuming after a suspend.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/gsi.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/net/ipa/gsi.c b/drivers/net/ipa/gsi.c
index 66570609c845..d343dc94cb48 100644
--- a/drivers/net/ipa/gsi.c
+++ b/drivers/net/ipa/gsi.c
@@ -238,11 +238,6 @@ static void gsi_irq_ieob_enable(struct gsi *gsi, u32 evt_ring_id)
 	iowrite32(val, gsi->virt + GSI_CNTXT_SRC_IEOB_IRQ_MSK_OFFSET);
 }
 
-static void gsi_isr_ieob_clear(struct gsi *gsi, u32 mask)
-{
-	iowrite32(mask, gsi->virt + GSI_CNTXT_SRC_IEOB_IRQ_CLR_OFFSET);
-}
-
 static void gsi_irq_ieob_disable(struct gsi *gsi, u32 evt_ring_id)
 {
 	u32 val;
@@ -777,7 +772,6 @@ static void gsi_channel_deprogram(struct gsi_channel *channel)
 int gsi_channel_start(struct gsi *gsi, u32 channel_id)
 {
 	struct gsi_channel *channel = &gsi->channel[channel_id];
-	u32 evt_ring_id = channel->evt_ring_id;
 	int ret;
 
 	mutex_lock(&gsi->mutex);
@@ -786,9 +780,6 @@ int gsi_channel_start(struct gsi *gsi, u32 channel_id)
 
 	mutex_unlock(&gsi->mutex);
 
-	/* Clear the channel's event ring interrupt in case it's pending */
-	gsi_isr_ieob_clear(gsi, BIT(evt_ring_id));
-
 	gsi_channel_thaw(channel);
 
 	return ret;
@@ -1093,7 +1084,7 @@ static void gsi_isr_ieob(struct gsi *gsi)
 	u32 event_mask;
 
 	event_mask = ioread32(gsi->virt + GSI_CNTXT_SRC_IEOB_IRQ_OFFSET);
-	gsi_isr_ieob_clear(gsi, event_mask);
+	iowrite32(event_mask, gsi->virt + GSI_CNTXT_SRC_IEOB_IRQ_CLR_OFFSET);
 
 	while (event_mask) {
 		u32 evt_ring_id = __ffs(event_mask);
-- 
2.20.1

