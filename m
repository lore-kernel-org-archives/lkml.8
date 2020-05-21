Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D327FC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 01:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B9D12075F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 01:21:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MCKg7cxq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbgEUBVa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 21:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbgEUBVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 21:21:23 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 294D9C061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 18:21:23 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id t16so2118604plo.7
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 18:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QsFgZCQYiGd02jQB+0kUCpkl8vSmF6BrKXNQ2LyTe9A=;
        b=MCKg7cxqhpTvrRbNfLEPSawIoI+7okAQoZYS1xQCU5F6aHO2uxj8hrDzdpc9etUwkU
         3R4z8YrIJm+WUWTvsh+UICpt8JeGFP5cKYLkHQXam8T3ZlqUnNWJi3mmcNOP3HAjj3O9
         MoBXaETLmd1K6/mERLZEvuGhG2F8ZatCDHSws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QsFgZCQYiGd02jQB+0kUCpkl8vSmF6BrKXNQ2LyTe9A=;
        b=tJfFZDVVWNxvs/fs83FNKIfFtM80j5zZLvIXb1rq+Qpk9xej8J1E+OeureNpbBnKaN
         U1StUzFb4YlaEBbkSgZu9aRjvDr6OmNJm82D2HX/gUnYmYTVN1GI2k9Gq+Sy7hCluGm/
         ulsgtTppT0sayhK/RyIMkE/nw0KFWoWjcy8mWvH4XjLfI9KI4HaNtRdDPvMmn8NJT7EF
         D76o7UbamdoAYE7Aii5ujYs0YYQRaDSJ7yEK9pfsKyEcJ+JTykbazUoQ/pju+r7zCTWs
         P80zUmIoD/bP/JSfDvIl21dsfs2jpyA+QTQJaN4RXPUhM2cjd0UicDdjG//qu9LtO6UR
         XNKg==
X-Gm-Message-State: AOAM530jWUvY3/+OZw2gDurN8tT7UV6IFI0YjGPeMCaf3lI+oPf2DgzN
        EBzRJ/oPx7o+0mEtYoc7yfSMUE5QIwE=
X-Google-Smtp-Source: ABdhPJzDkSo/XF1qoCLuiceQ+fHFg/Qgnp/0wwOFHjlFDyT5ahcH8uur5zkF1IXflp7HTa/sKG7v0A==
X-Received: by 2002:a17:90a:da05:: with SMTP id e5mr681735pjv.211.1590024082084;
        Wed, 20 May 2020 18:21:22 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id a6sm3081020pfa.111.2020.05.20.18.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 18:21:21 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Maulik Shah <mkshah@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH v3 1/3] soc: qcom: rpmh-rsc: Remove tcs_is_free() API
Date:   Wed, 20 May 2020 18:21:17 -0700
Message-Id: <20200521012119.238270-2-swboyd@chromium.org>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
In-Reply-To: <20200521012119.238270-1-swboyd@chromium.org>
References: <20200521012119.238270-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
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

