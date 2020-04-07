Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E3EC2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 23:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26CF720747
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 23:51:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TRU2IUEK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgDGXvU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 19:51:20 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:35379 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbgDGXvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 19:51:07 -0400
Received: by mail-pj1-f66.google.com with SMTP id g9so423448pjp.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 16:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VRUQrpcD0mEX27IehvT81s6G5+K5gT9dnSht2dkEZpg=;
        b=TRU2IUEK918o7xqwDAoCm+4WtSXS1dYsrfNx3LZ8JbV1HpgRAaEUzqpbyampK0QrtU
         Db11PrZl6NGiZ8eVN/cUS1S4X2gU9Koc5S+/axgQ+IjaKoQq8bgWjwpTw5DW2iTYrvtM
         4Gpa8fwA5huSGgBju4rMG6JBqTIWo6pS0RP8w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VRUQrpcD0mEX27IehvT81s6G5+K5gT9dnSht2dkEZpg=;
        b=fRgPPdlyjJuGTz9I+zWywl0EPXIHn44mVqkUjkz55gFFIthtdOSk7CuGHmKGwuU0IP
         PZHCQaQ36YnnK6lvqsW4lPm0b4IvlLZX6g/DIqmDLMyei43dkQTO0oJ3FiKTpm2nT1Ob
         eX5XQJIdlXhaSDm8g+kx5LY85ZXe/HQLappVBKae1Wm0V5kkxP+4SycGVB35hh9Bj2vQ
         yEWU/nk28IpK/SCAbd+1a3arr0u1I2BANVNsrctlwBgWyjH+b9oWvrKHAJz9s7zTdCOC
         4S9g/qlO8lxEMQ3Ya+B5MB486GtBpcr1OUinc/qwiXeIauAvIS4c0ri9Zdhk7N3Ah6yl
         2ssg==
X-Gm-Message-State: AGi0PuaxiwRf17CuHduWGmta74u+/T6MJ0/VEDOcw//YF0DnjgN8vXjS
        eyiiw4VThrLEjywV5dR6QyReVw==
X-Google-Smtp-Source: APiQypKPQQKTt1fbSqZ+dufZ8A2LJWt8q3h7go+/iYg3uKe9hPHT51Hit+FaMfteemESmbO5JyVjsw==
X-Received: by 2002:a17:902:be14:: with SMTP id r20mr4715305pls.270.1586303466383;
        Tue, 07 Apr 2020 16:51:06 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id s27sm14467165pgn.90.2020.04.07.16.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 16:51:05 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Maulik Shah <mkshah@codeaurora.org>
Cc:     mka@chromium.org, Lina Iyer <ilina@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>, swboyd@chromium.org,
        evgreen@chromium.org, Douglas Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 09/10] drivers: qcom: rpmh-rsc: Caller handles tcs_invalidate() exclusivity
Date:   Tue,  7 Apr 2020 16:50:23 -0700
Message-Id: <20200407164915.v3.9.I07c1f70e0e8f2dc0004bd38970b4e258acdc773e@changeid>
X-Mailer: git-send-email 2.26.0.292.g33ef6b2f38-goog
In-Reply-To: <20200407235024.260460-1-dianders@chromium.org>
References: <20200407235024.260460-1-dianders@chromium.org>
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
need to make sure that make sure the active-only transfers are quiet
before calling too.  The one way tcs_invalidate() gets called today is
through rpmh_rsc_cpu_pm_callback() which calls
rpmh_rsc_ctrlr_is_busy() to handle this.  When we have another path to
get to tcs_invalidate() it will also need to come up with something
similar and it won't need this extra check either.  If we later find
some code path that actually needs this check back in (and somehow
manages to be race free) we can always add it back in.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

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
index 10c026b2e1bc..a3b015196f15 100644
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
index 88f88015ef03..02171c192aa1 100644
--- a/drivers/soc/qcom/rpmh.c
+++ b/drivers/soc/qcom/rpmh.c
@@ -439,7 +439,6 @@ static int send_single(struct rpmh_ctrlr *ctrlr, enum rpmh_state state,
  *
  * Return:
  * * 0          - Success
- * * -EAGAIN    - Retry again
  * * Error code - Otherwise
  */
 int rpmh_flush(struct rpmh_ctrlr *ctrlr)
@@ -453,9 +452,7 @@ int rpmh_flush(struct rpmh_ctrlr *ctrlr)
 	}
 
 	/* Invalidate the TCSes first to avoid stale data */
-	ret = rpmh_rsc_invalidate(ctrlr_to_drv(ctrlr));
-	if (ret)
-		return ret;
+	rpmh_rsc_invalidate(ctrlr_to_drv(ctrlr));
 
 	/* First flush the cached batch requests */
 	ret = flush_batch(ctrlr);
-- 
2.26.0.292.g33ef6b2f38-goog

