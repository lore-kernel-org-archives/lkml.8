Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90234C2BA2B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 17:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F91D2063A
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 17:06:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PAWFK6hy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732483AbgDMRGB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 13:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732352AbgDMREo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 13:04:44 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C323BC0A3BDC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 10:04:44 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id k15so4761531pfh.6
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 10:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tzydfxNpFyQ37xWSVbnHjBlq3rGsJWK4NEoeBYdHSGE=;
        b=PAWFK6hyUJ2FMAEd5m1yBDd9/wMCyVdsdeGo/pb+0IWz1bN+ACGpK6RiQ1OjnlHCDW
         wg+3p3F/+xGKw5jAdn2vh9hDmUFAgpGqGeWKPpPAQ0hLNihu9ykfgagxoTXeFWXyFqrK
         JZiT2I/pmITimBBh5qz/X06OMc+Un5+ZZUTMg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tzydfxNpFyQ37xWSVbnHjBlq3rGsJWK4NEoeBYdHSGE=;
        b=lE4bgRzw4has90WwS1OYjfNdB//KieTJhv6Pu1Mjds3fAE3+7DaaJEq1ZWS5nDefkz
         Ve3vhkrX+lzlQ4rQ2mmxKELO4MMVe/lIFIaHTxKfFWAF1IrBCE0i1aQNZnU7RS4lJ26x
         vU9/Wqra1w6pc++fWyhUZuGO2I3pEcSNtwqcsQroBuXce0rCAYLqaUK6fxGIz0DFqIKj
         bdRQ2oVQl1wCFKA/Wx3OM48/c1iFFGL82muciVz5/abLF0ef2cIz2firWPGylF/Hb/C+
         FnTPKBzyKsM9fsWVEgxw7HcR46upC0va7lFZZlKtXxJv8p4D6jDaRz17fPao9qRAUVna
         /02A==
X-Gm-Message-State: AGi0PuYKMAHCFV42YweNnjHyCufANW12nkbx35az4pVzD2tlvGypc0WV
        A5FCLieMJDfl0RN1/52T2kDU1EG9GL5q3A==
X-Google-Smtp-Source: APiQypIjV881eF9Wj1nHGTP+Z56sK4PbX5r1Hs7Wq0wemPIScGv1u2J9wLQNTzsPos6dMrVHgXhSWw==
X-Received: by 2002:aa7:94b5:: with SMTP id a21mr18448612pfl.290.1586797484336;
        Mon, 13 Apr 2020 10:04:44 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id p62sm1634414pfb.93.2020.04.13.10.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 10:04:43 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Maulik Shah <mkshah@codeaurora.org>
Cc:     swboyd@chromium.org, mka@chromium.org,
        Rajendra Nayak <rnayak@codeaurora.org>, evgreen@chromium.org,
        Lina Iyer <ilina@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 03/10] drivers: qcom: rpmh-rsc: Fold tcs_ctrl_write() into its single caller
Date:   Mon, 13 Apr 2020 10:04:08 -0700
Message-Id: <20200413100321.v4.3.Ie88ce5ccfc0c6055903ccca5286ae28ed3b85ed3@changeid>
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
In-Reply-To: <20200413170415.32463-1-dianders@chromium.org>
References: <20200413170415.32463-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I was trying to write documentation for the functions in rpmh-rsc and
I got to tcs_ctrl_write().  The documentation for the function would
have been: "This is the core of rpmh_rsc_write_ctrl_data(); all the
caller does is error-check and then call this".

Having the error checks in a separate function doesn't help for
anything since:
- There are no other callers that need to bypass the error checks.
- It's less documenting.  When I read tcs_ctrl_write() I kept
  wondering if I need to handle cases other than ACTIVE_ONLY or cases
  with more commands than could fit in a TCS.  This is obvious when
  the error checks and code are together.
- The function just isn't that long, so there's no problem
  understanding the combined function.

Things were even more confusing because the two functions names didn't
make obvious (at least to me) their relationship.

Simplify by folding one function into the other.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Maulik Shah <mkshah@codeaurora.org>
Tested-by: Maulik Shah <mkshah@codeaurora.org>
---

Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/soc/qcom/rpmh-rsc.c | 39 ++++++++++++++++---------------------
 1 file changed, 17 insertions(+), 22 deletions(-)

diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index 439a0eadabf1..d9177324c6a2 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -587,27 +587,6 @@ static int find_slots(struct tcs_group *tcs, const struct tcs_request *msg,
 	return 0;
 }
 
-static int tcs_ctrl_write(struct rsc_drv *drv, const struct tcs_request *msg)
-{
-	struct tcs_group *tcs;
-	int tcs_id = 0, cmd_id = 0;
-	unsigned long flags;
-	int ret;
-
-	tcs = get_tcs_for_msg(drv, msg);
-	if (IS_ERR(tcs))
-		return PTR_ERR(tcs);
-
-	spin_lock_irqsave(&tcs->lock, flags);
-	/* find the TCS id and the command in the TCS to write to */
-	ret = find_slots(tcs, msg, &tcs_id, &cmd_id);
-	if (!ret)
-		__tcs_buffer_write(drv, tcs_id, cmd_id, msg);
-	spin_unlock_irqrestore(&tcs->lock, flags);
-
-	return ret;
-}
-
 /**
  * rpmh_rsc_write_ctrl_data: Write request to the controller
  *
@@ -618,6 +597,11 @@ static int tcs_ctrl_write(struct rsc_drv *drv, const struct tcs_request *msg)
  */
 int rpmh_rsc_write_ctrl_data(struct rsc_drv *drv, const struct tcs_request *msg)
 {
+	struct tcs_group *tcs;
+	int tcs_id = 0, cmd_id = 0;
+	unsigned long flags;
+	int ret;
+
 	if (!msg || !msg->cmds || !msg->num_cmds ||
 	    msg->num_cmds > MAX_RPMH_PAYLOAD) {
 		pr_err("Payload error\n");
@@ -628,7 +612,18 @@ int rpmh_rsc_write_ctrl_data(struct rsc_drv *drv, const struct tcs_request *msg)
 	if (msg->state == RPMH_ACTIVE_ONLY_STATE)
 		return -EINVAL;
 
-	return tcs_ctrl_write(drv, msg);
+	tcs = get_tcs_for_msg(drv, msg);
+	if (IS_ERR(tcs))
+		return PTR_ERR(tcs);
+
+	spin_lock_irqsave(&tcs->lock, flags);
+	/* find the TCS id and the command in the TCS to write to */
+	ret = find_slots(tcs, msg, &tcs_id, &cmd_id);
+	if (!ret)
+		__tcs_buffer_write(drv, tcs_id, cmd_id, msg);
+	spin_unlock_irqrestore(&tcs->lock, flags);
+
+	return ret;
 }
 
 /**
-- 
2.26.0.110.g2183baf09c-goog

