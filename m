Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 375D5C10DCE
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 00:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A51F206E2
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 00:00:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="R90gTXiG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbgCGAAn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 19:00:43 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37468 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727005AbgCGAAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 19:00:30 -0500
Received: by mail-pg1-f193.google.com with SMTP id z12so1804165pgl.4
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 16:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gZyZntHsdjoBeCJtjOQp+OOLTX7DtTYf5YMcuIO3+bY=;
        b=R90gTXiG7ER3y25trfX0EcpADXPxxKJhr+jAG6qxSEzfinMu8uRLlrpWR0KH+iYYI2
         Tlv2KDoK0QDo7IHf31XUEB8Bfuvmv/py4PBwG30rT3SY/RXHEszHudEua9dqmLwMlD7S
         0I6ZmXEElzg+agnr1ovCXuIkUt1xv6mKUx4H0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gZyZntHsdjoBeCJtjOQp+OOLTX7DtTYf5YMcuIO3+bY=;
        b=i5TrtUCSiQWnU+TdqI8V7DfN3a3ZxlKpcwYDIRYuSpBtNmJ7+XE2gDwJ6sVYLq5LTh
         ojH85fCnvrOwfqPFHSU4P8KL5ROA8nYq4A43CHY+/NMQOLdrEjuyqDDIMEgwbbNDDx2w
         yWpMifpZkkdNjPFZXfmt+QUUyCtfSspYzCKHHTZl9SF28eRxODPj82CWBazs3SU4/lHD
         XZsbBZNqLxgurIFWGySSn4NVJEp690P7DUfbmqBzAhcLSDHtUQVtGskUt5exWCJ63TTA
         rHKMJUGMkTpg1RqrrsPMFLF3Wx3mUgWopNwMiFytshPhIXXAEk3DmWgJU0vJ982UuD6y
         UOnQ==
X-Gm-Message-State: ANhLgQ30cYNwF4ZpLGVEd3CE6o/lxmpm4jgq34xViBs00vo/JUGrxI7D
        qLChRuWIlnaBYyllLVS7YLOAE1ds4qw=
X-Google-Smtp-Source: ADFU+vvslJDBpHZyNAxmwmn8XTe/pFo8A1pJmFpIX/3VBPxSC36ub6HVQCqVsJtQPMWEiDp5V8HusQ==
X-Received: by 2002:a63:f010:: with SMTP id k16mr5502683pgh.328.1583539227860;
        Fri, 06 Mar 2020 16:00:27 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id 9sm32302246pge.65.2020.03.06.16.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2020 16:00:27 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Maulik Shah <mkshah@codeaurora.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>, mka@chromium.org,
        evgreen@chromium.org, swboyd@chromium.org,
        Lina Iyer <ilina@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFT PATCH 6/9] drivers: qcom: rpmh-rsc: Only use "tcs_in_use" for ACTIVE_ONLY
Date:   Fri,  6 Mar 2020 15:59:48 -0800
Message-Id: <20200306155707.RFT.6.Icf2213131ea652087f100129359052c83601f8b0@changeid>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
In-Reply-To: <20200306235951.214678-1-dianders@chromium.org>
References: <20200306235951.214678-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From trawling through the code (see the "A lot of comments" change) I
found that "tcs_in_use" was only kept up-to-date for ACTIVE_ONLY TCSs.
...yet tcs_is_free() was checking the variable called from
tcs_invalidate() and tcs_invalidate() is only used for non-ACTIVE_ONLY
TCSs.

Let's change tcs_invalidate() to just check the "RSC_DRV_STATUS"
register, which was presumably the important part.

It also feels like for ACTIVE_ONLY TCSs that it probably wasn't
important to check the "RSC_DRV_STATUS".  We'll keep doing it just in
case but we'll add a warning if it ever actually mattered.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/soc/qcom/rpmh-rsc.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index 190226151029..c63441182358 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -164,7 +164,7 @@ static void write_tcs_reg_sync(struct rsc_drv *drv, int reg, int tcs_id,
 }
 
 /**
- * tcs_is_free() - Return if a TCS is totally free.
+ * tcs_is_free() - Return if an ACTIVE_ONLY TCS is totally free.
  * @drv:    The RSC controller.
  * @tcs_id: The global ID of this TCS.
  *
@@ -177,8 +177,23 @@ static void write_tcs_reg_sync(struct rsc_drv *drv, int reg, int tcs_id,
  */
 static bool tcs_is_free(struct rsc_drv *drv, int tcs_id)
 {
-	return !test_bit(tcs_id, drv->tcs_in_use) &&
-	       read_tcs_reg(drv, RSC_DRV_STATUS, tcs_id);
+	if (test_bit(tcs_id, drv->tcs_in_use))
+		return false;
+
+	if (read_tcs_reg(drv, RSC_DRV_STATUS, tcs_id) != 0)
+		return true;
+
+	/*
+	 * If this warning never ever hits then we can change this function
+	 * to just look at "tcs_in_use" and skip the read of the
+	 * RSC_DRV_STATUS register.
+	 *
+	 * If this warning _does_ hit, we should figure out if this is just
+	 * the way the hardware works or if there is some bug being pointed
+	 * out.
+	 */
+	WARN(1, "Driver thought TCS was free but HW reported busy\n");
+	return false;
 }
 
 /**
@@ -204,7 +219,7 @@ static int tcs_invalidate(struct rsc_drv *drv, int type)
 	}
 
 	for (m = tcs->offset; m < tcs->offset + tcs->num_tcs; m++) {
-		if (!tcs_is_free(drv, m)) {
+		if (read_tcs_reg(drv, RSC_DRV_STATUS, m) == 0) {
 			spin_unlock(&tcs->lock);
 			return -EAGAIN;
 		}
-- 
2.25.1.481.gfbce0eb801-goog

