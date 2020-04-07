Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C20FCC2BB55
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 23:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A9E520719
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 23:51:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="c6dpUU2p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbgDGXvK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 19:51:10 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:33337 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbgDGXvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 19:51:07 -0400
Received: by mail-pj1-f66.google.com with SMTP id cp9so1572887pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 16:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E1QDZq4xExPVunZ2u5Z6vV2KVUCthnGgNSWt9YeCsSE=;
        b=c6dpUU2pbYj0TXrMFLWPx0itaCWwmlzgy7tfj7AHLGPuYI9CTi24kTSQxrzbgdKETU
         xixpHB8+EaF92Y9CN02swLIhiLLRAPIgKHXwOS9wcq0jpXGVXuik+G1sJLFS0GvwFmf7
         6pXzV+xt2+wjrnOmytjESiC/rkWHVJ7Ab1skk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E1QDZq4xExPVunZ2u5Z6vV2KVUCthnGgNSWt9YeCsSE=;
        b=Frb+XVnP6pQ8ZoqYd0Jc2uwlQYJNsuSG2uniUDdRd343j3nRkBcep+4uFlz0unepvD
         DDNdsgyeKgRuyhINAlxLoN1B430njKpnTfVjoVrc+vItWh0CABcJAjmqluOHkKToDft8
         IfaadTnKkmZQo+a4X/Xx31dWRUlFfO6s3G+RJa/cfWQ4thevuy9SKeKuPskgrUI+YBa/
         4gNvPRMSwyMPM4i0idYPataV4O2HfLFbm4JAtShDn0z6UT8mB7Rm1nuff+au2dWAmB1r
         plwxzHUozk4v9INy+wUrL0aLUre1Bvfyi04xQc1iaTD4gBG63olWDZ5R0u2xWpnnS39D
         UIQA==
X-Gm-Message-State: AGi0PuaI2RpY4+l8v8caRtIYvcth8tfdXfZQ16DTGt7MqlXSisvxwkyI
        IiVT2xltgYVBAQitFTFg8qqDAQ==
X-Google-Smtp-Source: APiQypLiJgVmpJnjgPsInfIFUwVcKlpxnpvBZRxDLCi4Q4Bua/FXHbakZOVQZiF/gJ8A9hGpq4seWg==
X-Received: by 2002:a17:90b:384c:: with SMTP id nl12mr1905517pjb.87.1586303465390;
        Tue, 07 Apr 2020 16:51:05 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id s27sm14467165pgn.90.2020.04.07.16.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 16:51:04 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Maulik Shah <mkshah@codeaurora.org>
Cc:     mka@chromium.org, Lina Iyer <ilina@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>, swboyd@chromium.org,
        evgreen@chromium.org, Douglas Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 08/10] drivers: qcom: rpmh-rsc: Don't double-check rpmh
Date:   Tue,  7 Apr 2020 16:50:22 -0700
Message-Id: <20200407164915.v3.8.I8e187cdfb7a31f5bb7724f1f937f2862ee464a35@changeid>
X-Mailer: git-send-email 2.26.0.292.g33ef6b2f38-goog
In-Reply-To: <20200407235024.260460-1-dianders@chromium.org>
References: <20200407235024.260460-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The calls rpmh_rsc_write_ctrl_data() and rpmh_rsc_send_data() are only
ever called from rpmh.c.  We know that rpmh.c already error checked
the message.  There's no reason to do it again in rpmh-rsc.

Suggested-by: Maulik Shah <mkshah@codeaurora.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v3:
- ("Don't double-check rpmh") replaces ("Warning if tcs_write...")

Changes in v2: None

 drivers/soc/qcom/rpmh-rsc.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index 9502e7ea96be..10c026b2e1bc 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -633,7 +633,7 @@ static int tcs_write(struct rsc_drv *drv, const struct tcs_request *msg)
 }
 
 /**
- * rpmh_rsc_send_data() - Validate the incoming message + write to TCS block.
+ * rpmh_rsc_send_data() - Write / trigger active-only message.
  * @drv: The controller.
  * @msg: The data to be sent.
  *
@@ -658,12 +658,6 @@ int rpmh_rsc_send_data(struct rsc_drv *drv, const struct tcs_request *msg)
 {
 	int ret;
 
-	if (!msg || !msg->cmds || !msg->num_cmds ||
-	    msg->num_cmds > MAX_RPMH_PAYLOAD) {
-		WARN_ON(1);
-		return -EINVAL;
-	}
-
 	do {
 		ret = tcs_write(drv, msg);
 		if (ret == -EBUSY) {
@@ -734,16 +728,6 @@ int rpmh_rsc_write_ctrl_data(struct rsc_drv *drv, const struct tcs_request *msg)
 	unsigned long flags;
 	int ret;
 
-	if (!msg || !msg->cmds || !msg->num_cmds ||
-	    msg->num_cmds > MAX_RPMH_PAYLOAD) {
-		pr_err("Payload error\n");
-		return -EINVAL;
-	}
-
-	/* Data sent to this API will not be sent immediately */
-	if (msg->state == RPMH_ACTIVE_ONLY_STATE)
-		return -EINVAL;
-
 	tcs = get_tcs_for_msg(drv, msg);
 	if (IS_ERR(tcs))
 		return PTR_ERR(tcs);
-- 
2.26.0.292.g33ef6b2f38-goog

