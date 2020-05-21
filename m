Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C249C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 06:04:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF9C7207FB
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 06:04:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZjBqJIj+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbgEUGEc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 02:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728122AbgEUGEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 02:04:30 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA214C061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 23:04:29 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id t11so2690770pgg.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 23:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QsFgZCQYiGd02jQB+0kUCpkl8vSmF6BrKXNQ2LyTe9A=;
        b=ZjBqJIj+DFJWEXekQgE1YVAqSplCEZIpxb/CyIuEdaGlv2s+PoF1X6hpOG7/2RT31d
         +cM6/c8UDx2VjzL10zBqA2qSC6EG8XEvsfxLMyr8DNP7Pua2gR9xoEkNgUsaawyhBQu+
         G2DQZp60J5GjmDaUoLpGamF14x7SkvzbhyyPQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QsFgZCQYiGd02jQB+0kUCpkl8vSmF6BrKXNQ2LyTe9A=;
        b=e0RtiABHnEMy+BsFzaGfVF6fM2prYg55oJ/FWpeWXL/vQ93Uo2LWNEze1nQYvI8peP
         Rx5NXFX2iJxZQ4YaMrNU/UmQnn9LnzIdI2MAHZOElzIYxdze1cnRJWWRqKIcTgTGLmax
         t6zbNSOchcyk5eEzl4WOM48v6KN53eQ4ugxjbVD/Z/mh/8CUPXmNg3FYICoOkPsS7c9H
         Na1uyHGjgv+FX32sU+Q2vjDxFAEO5VcqQZFmQeWlL6lbEcvRs4WQ63XQv4BlEST/h1Mm
         1tM1fMeenU9llzPLVab4yOUNa9XiSG7warEwJvv0EExQgV4nolaO8fioqT/KQ0mmczCs
         Tn4g==
X-Gm-Message-State: AOAM531z9XHn5fK/9npINCqqMME8+WfC4OIDx8AAB53nfmYhzH4INCoM
        uwc+k00IEiKy9SbVUMb0sJT+K0uWte4=
X-Google-Smtp-Source: ABdhPJw7h0cO/lwWzSoBMq4DftUajsJ8LdblbBiLE+kfoVbbtVMf6LRDQYwCwEFQWCmD6GrfjqGe6w==
X-Received: by 2002:a62:34c1:: with SMTP id b184mr7649598pfa.73.1590041069176;
        Wed, 20 May 2020 23:04:29 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id k18sm3590146pfg.217.2020.05.20.23.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 23:04:28 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Maulik Shah <mkshah@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCHv3/RESEND 1/3] soc: qcom: rpmh-rsc: Remove tcs_is_free() API
Date:   Wed, 20 May 2020 23:04:23 -0700
Message-Id: <20200521060425.24285-2-swboyd@chromium.org>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
In-Reply-To: <20200521060425.24285-1-swboyd@chromium.org>
References: <20200521060425.24285-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This API does very little. Let's replace all the callsites with the
normal operations that would be done on top of the bitmap that
tcs_in_use is. This simplifies and reduces the code size.

Cc: Maulik Shah <mkshah@codeaurora.org>
Cc: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/soc/qcom/rpmh-rsc.c | 59 +++++++++++++------------------------
 1 file changed, 20 insertions(+), 39 deletions(-)

diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index 076fd27f3081..60fc56987659 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -184,22 +184,6 @@ static void write_tcs_reg_sync(const struct rsc_drv *drv, int reg, int tcs_id,
 		       data, tcs_id, reg);
 }
 
-/**
- * tcs_is_free() - Return if a TCS is totally free.
- * @drv:    The RSC controller.
- * @tcs_id: The global ID of this TCS.
- *
- * Returns true if nobody has claimed this TCS (by setting tcs_in_use).
- *
- * Context: Must be called with the drv->lock held.
- *
- * Return: true if the given TCS is free.
- */
-static bool tcs_is_free(struct rsc_drv *drv, int tcs_id)
-{
-	return !test_bit(tcs_id, drv->tcs_in_use);
-}
-
 /**
  * tcs_invalidate() - Invalidate all TCSes of the given type (sleep or wake).
  * @drv:  The RSC controller.
@@ -512,7 +496,7 @@ static void __tcs_buffer_write(struct rsc_drv *drv, int tcs_id, int cmd_id,
  *
  * Return: 0 if nothing in flight or -EBUSY if we should try again later.
  *         The caller must re-enable interrupts between tries since that's
- *         the only way tcs_is_free() will ever return true and the only way
+ *         the only way tcs_in_use will ever be updated and the only way
  *         RSC_DRV_CMD_ENABLE will ever be cleared.
  */
 static int check_for_req_inflight(struct rsc_drv *drv, struct tcs_group *tcs,
@@ -520,17 +504,14 @@ static int check_for_req_inflight(struct rsc_drv *drv, struct tcs_group *tcs,
 {
 	unsigned long curr_enabled;
 	u32 addr;
-	int i, j, k;
-	int tcs_id = tcs->offset;
+	int j, k;
+	int i = tcs->offset;
 
-	for (i = 0; i < tcs->num_tcs; i++, tcs_id++) {
-		if (tcs_is_free(drv, tcs_id))
-			continue;
-
-		curr_enabled = read_tcs_reg(drv, RSC_DRV_CMD_ENABLE, tcs_id);
+	for_each_set_bit_from(i, drv->tcs_in_use, tcs->offset + tcs->num_tcs) {
+		curr_enabled = read_tcs_reg(drv, RSC_DRV_CMD_ENABLE, i);
 
 		for_each_set_bit(j, &curr_enabled, MAX_CMDS_PER_TCS) {
-			addr = read_tcs_cmd(drv, RSC_DRV_CMD_ADDR, tcs_id, j);
+			addr = read_tcs_cmd(drv, RSC_DRV_CMD_ADDR, i, j);
 			for (k = 0; k < msg->num_cmds; k++) {
 				if (addr == msg->cmds[k].addr)
 					return -EBUSY;
@@ -548,18 +529,19 @@ static int check_for_req_inflight(struct rsc_drv *drv, struct tcs_group *tcs,
  *
  * Must be called with the drv->lock held since that protects tcs_in_use.
  *
- * Return: The first tcs that's free.
+ * Return: The first tcs that's free or -EBUSY if all in use.
  */
 static int find_free_tcs(struct tcs_group *tcs)
 {
-	int i;
+	const struct rsc_drv *drv = tcs->drv;
+	unsigned long i;
+	unsigned long max = tcs->offset + tcs->num_tcs;
 
-	for (i = 0; i < tcs->num_tcs; i++) {
-		if (tcs_is_free(tcs->drv, tcs->offset + i))
-			return tcs->offset + i;
-	}
+	i = find_next_zero_bit(drv->tcs_in_use, max, tcs->offset);
+	if (i >= max)
+		return -EBUSY;
 
-	return -EBUSY;
+	return i;
 }
 
 /**
@@ -757,8 +739,9 @@ int rpmh_rsc_write_ctrl_data(struct rsc_drv *drv, const struct tcs_request *msg)
  */
 static bool rpmh_rsc_ctrlr_is_busy(struct rsc_drv *drv)
 {
-	int m;
-	struct tcs_group *tcs = &drv->tcs[ACTIVE_TCS];
+	unsigned long set;
+	const struct tcs_group *tcs = &drv->tcs[ACTIVE_TCS];
+	unsigned long max;
 
 	/*
 	 * If we made an active request on a RSC that does not have a
@@ -769,12 +752,10 @@ static bool rpmh_rsc_ctrlr_is_busy(struct rsc_drv *drv)
 	if (!tcs->num_tcs)
 		tcs = &drv->tcs[WAKE_TCS];
 
-	for (m = tcs->offset; m < tcs->offset + tcs->num_tcs; m++) {
-		if (!tcs_is_free(drv, m))
-			return true;
-	}
+	max = tcs->offset + tcs->num_tcs;
+	set = find_next_bit(drv->tcs_in_use, max, tcs->offset);
 
-	return false;
+	return set < max;
 }
 
 /**
-- 
Sent by a computer, using git, on the internet

