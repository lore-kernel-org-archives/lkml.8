Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5053DC2BB1D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 23:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E5272074E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 23:14:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jSndEF9A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731526AbgCKXOX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 19:14:23 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34429 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731473AbgCKXOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 19:14:16 -0400
Received: by mail-pf1-f196.google.com with SMTP id 23so2226175pfj.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 16:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pz+R6/bajFiKzuDg21R/p73E7Dnb/exoWqB7bjIzotw=;
        b=jSndEF9AasufRC8A5cwEtAu5taaitC5tcTcTjAKzjbTOxXxNypnb1Rg3xMWdy37RS0
         8iiZD5NEjCF03LnN64o4uY/Y71JVnxTuCWxxjs2hYDK3QT1w00LSO6HlBi7YRBd6eAvj
         Glo0pEBnllScOhYw0fKkSCvSp1JVRzHvZx5tQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pz+R6/bajFiKzuDg21R/p73E7Dnb/exoWqB7bjIzotw=;
        b=So22tFCyN4VNSJz5T7KSUCVFlBLMQHp4xx1tjp4lxLXWKSoUf/wgFt8+BEpAkycfMN
         19QNKcPSky7CX8ks9yXEKeZ68rnexd/ynU0ALLl2dcWAj6SBNAQoK/G7itR/puNOE4Gd
         Ql+R+/ET9fmTr1F8o3GyW0+YOPWVazOaUV3YfuZbjPoipXKzwMWf3MeVRIwnfuOBDOUZ
         THzlHDW4d9HOVMejmtwKy35p0dQQ3OMDSorzfjx1ZcAuCZUG3DLmAl0fGEjUAFaswkXh
         OuYKb8B7eks0M4ELKzarBKt/KaHOypzOt8XmYyAqniU8qEqCB1FR5O43MLaNycAPuqUA
         c6Ew==
X-Gm-Message-State: ANhLgQ2EmTNYd6fFxGe4tYyPogVBB2B4w0jtCgzGHrr6/w4RP9OHTwFS
        4P2hIkgdO3Eum+R0RWNeuatzjg==
X-Google-Smtp-Source: ADFU+vu3hctvPwyWe4hOmGeRglVH3FlBt2UmhtU0gyCwNzZZICUwyFSB2Itc1xN7oobQquYNQgeR4Q==
X-Received: by 2002:aa7:8711:: with SMTP id b17mr2845654pfo.315.1583968455549;
        Wed, 11 Mar 2020 16:14:15 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id g75sm2606334pje.37.2020.03.11.16.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 16:14:15 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Maulik Shah <mkshah@codeaurora.org>
Cc:     mka@chromium.org, Rajendra Nayak <rnayak@codeaurora.org>,
        evgreen@chromium.org, Lina Iyer <ilina@codeaurora.org>,
        swboyd@chromium.org, Douglas Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFT PATCH v2 03/10] drivers: qcom: rpmh-rsc: Fold tcs_ctrl_write() into its single caller
Date:   Wed, 11 Mar 2020 16:13:41 -0700
Message-Id: <20200311161104.RFT.v2.3.Ie88ce5ccfc0c6055903ccca5286ae28ed3b85ed3@changeid>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
In-Reply-To: <20200311231348.129254-1-dianders@chromium.org>
References: <20200311231348.129254-1-dianders@chromium.org>
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
---

Changes in v2: None

 drivers/soc/qcom/rpmh-rsc.c | 39 ++++++++++++++++---------------------
 1 file changed, 17 insertions(+), 22 deletions(-)

diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index 02c8e0ffbbe4..799847b08038 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -550,27 +550,6 @@ static int find_slots(struct tcs_group *tcs, const struct tcs_request *msg,
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
@@ -581,6 +560,11 @@ static int tcs_ctrl_write(struct rsc_drv *drv, const struct tcs_request *msg)
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
@@ -591,7 +575,18 @@ int rpmh_rsc_write_ctrl_data(struct rsc_drv *drv, const struct tcs_request *msg)
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
 
 static int rpmh_probe_tcs_config(struct platform_device *pdev,
-- 
2.25.1.481.gfbce0eb801-goog

