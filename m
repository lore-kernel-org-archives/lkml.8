Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4406AC2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 17:05:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BED420692
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 17:05:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="U/e6j/f2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732455AbgDMRFj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 13:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732378AbgDMREv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 13:04:51 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A4BC0A3BDC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 10:04:51 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id h11so3589516plr.11
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 10:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xNVrx/cI7Cu2aF2a/gD7IMs8PmBNgX56QvuSL2GOgsU=;
        b=U/e6j/f2nuhIpQcM4lGNm4mG6gg2uZF/vFx/YsAipQh6wEYucIh8IJxvdNhsijNsNK
         HhJKGyfUZB1pZWPO9vCaxin77wWWMyy+bNJhuxIwmZhmQlCJoegvL2+SQdR03DnDvS3f
         A1drOrlR1tfi/taZdfgTcK7q3+JQbvSmRnfOI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xNVrx/cI7Cu2aF2a/gD7IMs8PmBNgX56QvuSL2GOgsU=;
        b=ZYDcOld3CpOqjb7DyAa8yOmvAW462mrgD06zn+2NF0BS3fMgtvwD3WtWK8tB8rCUaJ
         +elcEuVrHxh/EkCzXl+9XmNCEZJv0cJj84W0zpP7YKxPHHbfAN2ibsxIiMVvmMKev5dC
         Bd4h+xiho5CCnMx36s4iYMFYEPvbQGg3BQxWG4GO4moJswTg10So0+w1mElEC0r1xxTd
         JeiEnL0BzzIe7lfkXBXLwODsPGhKYRrM6Gio7GLm3DKwsabjleXC6CrD2hycWmrjelsx
         +WgFoHJL6F+OEKcIg2tFzB9X5hURHRVYTYs7gV/HvYNrqdyct5hAHSsJNm3V5IDxMHNJ
         g8yg==
X-Gm-Message-State: AGi0PuYlT/BvPgYWSnDfSuF+d7qNJINIehF6XgIdmEqIVezY7vAaZXq7
        DIVAv7qemOiYcE8z+lZDQbb1QQ==
X-Google-Smtp-Source: APiQypIi0psKyslevtOfZ9WzW7UTKWqNYR8/2uGXcyDi3BKC73uBASSVCF3GMo2wooVKUt7nJO6Dtg==
X-Received: by 2002:a17:902:8b87:: with SMTP id ay7mr18674684plb.281.1586797490877;
        Mon, 13 Apr 2020 10:04:50 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id p62sm1634414pfb.93.2020.04.13.10.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 10:04:50 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Maulik Shah <mkshah@codeaurora.org>
Cc:     swboyd@chromium.org, mka@chromium.org,
        Rajendra Nayak <rnayak@codeaurora.org>, evgreen@chromium.org,
        Lina Iyer <ilina@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 08/10] drivers: qcom: rpmh-rsc: Don't double-check rpmh payload
Date:   Mon, 13 Apr 2020 10:04:13 -0700
Message-Id: <20200413100321.v4.8.I8e187cdfb7a31f5bb7724f1f937f2862ee464a35@changeid>
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
In-Reply-To: <20200413170415.32463-1-dianders@chromium.org>
References: <20200413170415.32463-1-dianders@chromium.org>
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
Reviewed-by: Maulik Shah <mkshah@codeaurora.org>
Tested-by: Maulik Shah <mkshah@codeaurora.org>
---

Changes in v4:
- Add "payload" to end of ("Don't double-check rpmh") patch subject

Changes in v3:
- ("Don't double-check rpmh") replaces ("Warning if tcs_write...")

Changes in v2: None

 drivers/soc/qcom/rpmh-rsc.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index 4e76e5349c44..4f2a72fdac2c 100644
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
2.26.0.110.g2183baf09c-goog

