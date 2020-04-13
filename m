Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E0BC2BA2B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 17:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6865720732
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 17:05:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XNf6xwbg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732437AbgDMRFW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 13:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732350AbgDMREw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 13:04:52 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72436C008749
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 10:04:52 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id z9so4034517pjd.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 10:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q26Dw+UqqTmrD1vcsVMRr6gyqYcT/KTjqknJbK7AfQQ=;
        b=XNf6xwbgBONOnkImsFWBfmWFc8KdGYTnaYt78DJD9x7/fcItmYDXVqk6GX6lTHibzF
         GDncNPi7K9FwrLKB8MGQJpsys+T2pOQWkfjZ7VQc/4m3TgLjGcJ+bDOvCzebwUHFTEan
         mi7L4ALKBh0nPBBknA2yfMAw2WzV+Ez23pugM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q26Dw+UqqTmrD1vcsVMRr6gyqYcT/KTjqknJbK7AfQQ=;
        b=AgwFF3VpfoxqFV9FENLHpodvs1Gw8ndAmdH20OllQYLS1BiCjIL8q7/vLLlXJ3CMg6
         dm52Fcue+/Wr/QAdLc1RnGPTEstBO2jfmOXgd6uDWAKRlfm0F0g6bnXQrtzXQy/WSNQe
         KM4AyMhgk9qpMHTRgHmxognQlDMW3IbhKwYgAEWjA7BtnsNTNvY0mlZX1hiFBXyQWEV4
         7t1WybAOaW5tBWHVI3wSOWaMwKTVeK8wYH2SwD+CUcE5tPd9jH330M1Y1YU5W3aEQAsq
         WaeiMrHTLAgbMNI9JmQiYY540ra91G+qu+TfvVq9UlX5HX9Zsi5zy91GDtv9P35ID9ww
         mdCg==
X-Gm-Message-State: AGi0PubzzJAUZcoGciia/H1HjpRe9/WdrmU5ucLfTroG/y+CsTNIKO2f
        4XCTkTAifC2oiWf32EscV306Ag==
X-Google-Smtp-Source: APiQypJDqUJlGkglxl+qk2Lxy1uexAWx4fRgGzrhe35cqkGX1PuIGC1QKhVodDnuDvGwdNgirB58Hw==
X-Received: by 2002:a17:902:b40e:: with SMTP id x14mr18999489plr.154.1586797491939;
        Mon, 13 Apr 2020 10:04:51 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id p62sm1634414pfb.93.2020.04.13.10.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 10:04:51 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Maulik Shah <mkshah@codeaurora.org>
Cc:     swboyd@chromium.org, mka@chromium.org,
        Rajendra Nayak <rnayak@codeaurora.org>, evgreen@chromium.org,
        Lina Iyer <ilina@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 09/10] drivers: qcom: rpmh-rsc: Caller handles tcs_invalidate() exclusivity
Date:   Mon, 13 Apr 2020 10:04:14 -0700
Message-Id: <20200413100321.v4.9.I07c1f70e0e8f2dc0004bd38970b4e258acdc773e@changeid>
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
In-Reply-To: <20200413170415.32463-1-dianders@chromium.org>
References: <20200413170415.32463-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Auditing tcs_invalidate() made me worried.  Specifically I saw that it
used spin_lock(), not spin_lock_irqsave().  That always worries me
unless I can trace for sure that I'm in the interrupt handler or that
someone else already disabled interrupts.

Looking more at it, there is actually no reason for these locks
anyway.  Specifically the only reason you'd ever call
rpmh_rsc_invalidate() is if you cared that the sleep/wake TCSes were
empty.  That means that they need to continue to be empty even after
rpmh_rsc_invalidate() returns.  The only way that can happen is if the
caller already has done something to keep all other RPMH users out.
It should be noted that even though the caller is only worried about
making sleep/wake TCSes empty, they also need to worry about stopping
active-only transfers if they need to handle the case where
active-only transfers might borrow the wake TCS.

At the moment rpmh_rsc_invalidate() is only called in PM code from the
last CPU.  If that later changes the caller will still need to solve
the above problems themselves, so these locks will never be useful.

Continuing to audit tcs_invalidate(), I found a bug.  The function
didn't properly check for a borrowed TCS if we hadn't recently written
anything into the TCS.  Specifically, if we've never written to the
WAKE_TCS (or we've flushed it recently) then tcs->slots is empty.
We'll early-out and we'll never call tcs_is_free().

I thought about fixing this bug by either deleting the early check for
bitmap_empty() or possibly only doing it if we knew we weren't on a
TCS that could be borrowed.  However, I think it's better to just
delete the checks.

As argued above it's up to the caller to make sure that all other
users of RPMH are quiet before tcs_invalidate() is called.  Since
callers need to handle the zero-active-TCS case anyway that means they
need to make sure that the active-only transfers are quiet before
calling too.  The one way tcs_invalidate() gets called today is
through rpmh_rsc_cpu_pm_callback() which calls
rpmh_rsc_ctrlr_is_busy() to handle this.  When we have another path to
get to tcs_invalidate() it will also need to come up with something
similar and it won't need this extra check either.  If we later find
some code path that actually needs this check back in (and somehow
manages to be race free) we can always add it back in.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Maulik Shah <mkshah@codeaurora.org>
Tested-by: Maulik Shah <mkshah@codeaurora.org>
---

Changes in v4:
- Removed extra "make sure" in commit message.

Changes in v3:
- Replaced ("irqsave()...") + ("...never -EBUSY") w/ ("Caller handles...")

Changes in v2: None

 drivers/soc/qcom/rpmh-internal.h |  2 +-
 drivers/soc/qcom/rpmh-rsc.c      | 38 +++++++++++---------------------
 drivers/soc/qcom/rpmh.c          |  5 +----
 3 files changed, 15 insertions(+), 30 deletions(-)

diff --git a/drivers/soc/qcom/rpmh-internal.h b/drivers/soc/qcom/rpmh-internal.h
index f06350cbc9a2..dba8510c0669 100644
--- a/drivers/soc/qcom/rpmh-internal.h
+++ b/drivers/soc/qcom/rpmh-internal.h
@@ -132,7 +132,7 @@ struct rsc_drv {
 int rpmh_rsc_send_data(struct rsc_drv *drv, const struct tcs_request *msg);
 int rpmh_rsc_write_ctrl_data(struct rsc_drv *drv,
 			     const struct tcs_request *msg);
-int rpmh_rsc_invalidate(struct rsc_drv *drv);
+void rpmh_rsc_invalidate(struct rsc_drv *drv);
 
 void rpmh_tx_done(const struct tcs_request *msg, int r);
 int rpmh_flush(struct rpmh_ctrlr *ctrlr);
diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index 4f2a72fdac2c..9bd0c7c3db7c 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -198,50 +198,38 @@ static bool tcs_is_free(struct rsc_drv *drv, int tcs_id)
  * This will clear the "slots" variable of the given tcs_group and also
  * tell the hardware to forget about all entries.
  *
- * Return: 0 if no problem, or -EAGAIN if the caller should try again in a
- *         bit. Caller should make sure to enable interrupts between tries.
+ * The caller must ensure that no other RPMH actions are happening when this
+ * function is called, since otherwise the device may immediately become
+ * used again even before this function exits.
  */
-static int tcs_invalidate(struct rsc_drv *drv, int type)
+static void tcs_invalidate(struct rsc_drv *drv, int type)
 {
 	int m;
 	struct tcs_group *tcs = &drv->tcs[type];
 
-	spin_lock(&tcs->lock);
-	if (bitmap_empty(tcs->slots, MAX_TCS_SLOTS)) {
-		spin_unlock(&tcs->lock);
-		return 0;
-	}
+	/* Caller ensures nobody else is running so no lock */
+	if (bitmap_empty(tcs->slots, MAX_TCS_SLOTS))
+		return;
 
 	for (m = tcs->offset; m < tcs->offset + tcs->num_tcs; m++) {
-		if (!tcs_is_free(drv, m)) {
-			spin_unlock(&tcs->lock);
-			return -EAGAIN;
-		}
 		write_tcs_reg_sync(drv, RSC_DRV_CMD_ENABLE, m, 0);
 		write_tcs_reg_sync(drv, RSC_DRV_CMD_WAIT_FOR_CMPL, m, 0);
 	}
 	bitmap_zero(tcs->slots, MAX_TCS_SLOTS);
-	spin_unlock(&tcs->lock);
-
-	return 0;
 }
 
 /**
  * rpmh_rsc_invalidate() - Invalidate sleep and wake TCSes.
  * @drv: The RSC controller.
  *
- * Return: 0 if no problem, or -EAGAIN if the caller should try again in a
- *         bit. Caller should make sure to enable interrupts between tries.
+ * The caller must ensure that no other RPMH actions are happening when this
+ * function is called, since otherwise the device may immediately become
+ * used again even before this function exits.
  */
-int rpmh_rsc_invalidate(struct rsc_drv *drv)
+void rpmh_rsc_invalidate(struct rsc_drv *drv)
 {
-	int ret;
-
-	ret = tcs_invalidate(drv, SLEEP_TCS);
-	if (!ret)
-		ret = tcs_invalidate(drv, WAKE_TCS);
-
-	return ret;
+	tcs_invalidate(drv, SLEEP_TCS);
+	tcs_invalidate(drv, WAKE_TCS);
 }
 
 /**
diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
index e6a453759abd..aab6cc6bba4f 100644
--- a/drivers/soc/qcom/rpmh.c
+++ b/drivers/soc/qcom/rpmh.c
@@ -440,7 +440,6 @@ static int send_single(struct rpmh_ctrlr *ctrlr, enum rpmh_state state,
  *
  * Return:
  * * 0          - Success
- * * -EAGAIN    - Retry again
  * * Error code - Otherwise
  */
 int rpmh_flush(struct rpmh_ctrlr *ctrlr)
@@ -456,9 +455,7 @@ int rpmh_flush(struct rpmh_ctrlr *ctrlr)
 	}
 
 	/* Invalidate the TCSes first to avoid stale data */
-	ret = rpmh_rsc_invalidate(ctrlr_to_drv(ctrlr));
-	if (ret)
-		return ret;
+	rpmh_rsc_invalidate(ctrlr_to_drv(ctrlr));
 
 	/* First flush the cached batch requests */
 	ret = flush_batch(ctrlr);
-- 
2.26.0.110.g2183baf09c-goog

