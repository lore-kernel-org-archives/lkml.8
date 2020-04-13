Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3106C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 17:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B03F02063A
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 17:05:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GgM06dNn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732472AbgDMRFv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 13:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732361AbgDMREq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 13:04:46 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 413B7C008748
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 10:04:46 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id i3so680820pgk.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 10:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G1C9cYygROwcdB+bdyaotBkigEG8W7Qz/WT7Sqd2jQY=;
        b=GgM06dNnb/HF2lWUMTa/Sh7aCApPmK5Isbt8fzX1llhZQrcEZjo3RQNAdtewm+exPj
         MM+dXbeAPsGRAiXGqy+VD+1Oc0vl7GHQQYAn5FsOUX5BEXLn3lNMpG5GmSQz++Mj0jWH
         DR9QuUup+GLxJWi7nrGhW191Jwoc/BX/U4gaI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G1C9cYygROwcdB+bdyaotBkigEG8W7Qz/WT7Sqd2jQY=;
        b=M3+BrUceB4sOFP7M7xT4BAwdx/gbn0exAcfpRpDlx8I+nR49WjP9mymcyCKAX19+cv
         mzojVIaEdfKzpafK9TqI3ToJypDaX0ISDtSYj2452gXU1LrRIocZ2FfcZurLEJTuZiO4
         s9IKvR8A3joT7wPsA1O6EmCZbonQkyF1lWXfVlzLGZowjGPYk3sJVR85izdA12jDOJtH
         RuuunsTRz+kMHaacT75KV/EpcMMdyyUmUCn8NnEYhO4rRvUsy50nyQguT4LsFn3kuvQR
         Pi9pZn+Huxe3hB3jtNuli+EIDO+S4YTtj6GhXT45h7VSFie3cFxolPQXqWyjhKUq0X1a
         ASZg==
X-Gm-Message-State: AGi0PuZW6LKLZcVYB4EamuLi/z6436f/DrUUGAqjmz8R7lq51Mu8Bfyl
        OVVlW1H/tELSocrNqLp5yRxWsawohdH0zQ==
X-Google-Smtp-Source: APiQypJsdNI69RZEIChzgAH/1VncKohdU4FrKkW87ZmmJ/KYPQvWwjDZUnP8L1l80kg+O3d+STeteg==
X-Received: by 2002:aa7:9703:: with SMTP id a3mr11361283pfg.318.1586797485782;
        Mon, 13 Apr 2020 10:04:45 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id p62sm1634414pfb.93.2020.04.13.10.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 10:04:45 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Maulik Shah <mkshah@codeaurora.org>
Cc:     swboyd@chromium.org, mka@chromium.org,
        Rajendra Nayak <rnayak@codeaurora.org>, evgreen@chromium.org,
        Lina Iyer <ilina@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 04/10] drivers: qcom: rpmh-rsc: Remove get_tcs_of_type() abstraction
Date:   Mon, 13 Apr 2020 10:04:09 -0700
Message-Id: <20200413100321.v4.4.Ia348ade7c6ed1d0d952ff2245bc854e5834c8d9a@changeid>
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
In-Reply-To: <20200413170415.32463-1-dianders@chromium.org>
References: <20200413170415.32463-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The get_tcs_of_type() function doesn't provide any value.  It's not
conceptually difficult to access a value in an array, even if that
value is in a structure and we want a pointer to the value.  Having
the function in there makes me feel like it's doing something fancier
like looping or searching.  Remove it.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Maulik Shah <mkshah@codeaurora.org>
Tested-by: Maulik Shah <mkshah@codeaurora.org>
---

Changes in v4: None
Changes in v3:
- Rebased atop v16 ('Invoke rpmh_flush...') series.

Changes in v2: None

 drivers/soc/qcom/rpmh-rsc.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index d9177324c6a2..d0c187c17ce1 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -177,17 +177,10 @@ static bool tcs_is_free(struct rsc_drv *drv, int tcs_id)
 	       read_tcs_reg(drv, RSC_DRV_STATUS, tcs_id);
 }
 
-static struct tcs_group *get_tcs_of_type(struct rsc_drv *drv, int type)
-{
-	return &drv->tcs[type];
-}
-
 static int tcs_invalidate(struct rsc_drv *drv, int type)
 {
 	int m;
-	struct tcs_group *tcs;
-
-	tcs = get_tcs_of_type(drv, type);
+	struct tcs_group *tcs = &drv->tcs[type];
 
 	spin_lock(&tcs->lock);
 	if (bitmap_empty(tcs->slots, MAX_TCS_SLOTS)) {
@@ -250,9 +243,9 @@ static struct tcs_group *get_tcs_for_msg(struct rsc_drv *drv,
 	 * dedicated TCS for active state use, then re-purpose a wake TCS to
 	 * send active votes.
 	 */
-	tcs = get_tcs_of_type(drv, type);
+	tcs = &drv->tcs[type];
 	if (msg->state == RPMH_ACTIVE_ONLY_STATE && !tcs->num_tcs)
-		tcs = get_tcs_of_type(drv, WAKE_TCS);
+		tcs = &drv->tcs[WAKE_TCS];
 
 	return tcs;
 }
@@ -643,7 +636,7 @@ int rpmh_rsc_write_ctrl_data(struct rsc_drv *drv, const struct tcs_request *msg)
 static bool rpmh_rsc_ctrlr_is_busy(struct rsc_drv *drv)
 {
 	int m;
-	struct tcs_group *tcs = get_tcs_of_type(drv, ACTIVE_TCS);
+	struct tcs_group *tcs = &drv->tcs[ACTIVE_TCS];
 
 	/*
 	 * If we made an active request on a RSC that does not have a
@@ -655,7 +648,7 @@ static bool rpmh_rsc_ctrlr_is_busy(struct rsc_drv *drv)
 	 * lock before checking tcs_is_free().
 	 */
 	if (!tcs->num_tcs)
-		tcs = get_tcs_of_type(drv, WAKE_TCS);
+		tcs = &drv->tcs[WAKE_TCS];
 
 	for (m = tcs->offset; m < tcs->offset + tcs->num_tcs; m++) {
 		if (!tcs_is_free(drv, m))
-- 
2.26.0.110.g2183baf09c-goog

