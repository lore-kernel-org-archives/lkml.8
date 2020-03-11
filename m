Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84395C5ACC1
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 23:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 801C32074F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 23:14:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ClKgrdpC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731537AbgCKXO0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 19:14:26 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35592 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731493AbgCKXOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 19:14:20 -0400
Received: by mail-pg1-f195.google.com with SMTP id 7so2032667pgr.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 16:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kG1+YVl0s8o9smr2trKOZ7NbvC55EDPcXtr8oUkRgXE=;
        b=ClKgrdpCmsvoy2gfXgwaLyaAM1AihCtYKyvZqzuy05EGgTbYcUN7uJ0SPLSwc4/4cw
         aR5se+RbOXCoyHSA33S+YdUlP0iiAd58cRs0M6QOrypjdzfoVRRp2d0QynUiBGxMZtd1
         54mJCAn4YFUnZWaGt34SJYmeqmweS894Ge5Uw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kG1+YVl0s8o9smr2trKOZ7NbvC55EDPcXtr8oUkRgXE=;
        b=ETfHakJGQg/Pjcc8CXQF2OVkz89ETz6ZBScGC2o9rzomZq4fHI3MP5TSjqrOOF8Wf4
         Cz6WKKJOfYcj1nASxAMabQxfB7sPUwS6dab56gJJ46M+3obqTd57uEd/N1igPCoQR3/L
         cX8nXFWckAKdqWHzPn3Obbv0jw7VPh0FnvXjNiWA5nhTs1Lpf84iKQ1BnwT9WgUDUu5o
         5LZyoac1R5yYvCKJXQOse4RgCTvB92dWQkINIJvUmMkVQEtURvIomZLas8NGIEr8LxPz
         2Vwa4w4CnjxBVp/qdwDb62mdyJolVSCHlpm1vxkpHogbP/FBR01G2EjBh9qm+HXjasSs
         J+4Q==
X-Gm-Message-State: ANhLgQ2dLsrRacwMFPORCLV1tj9wznbBT960LVhqmSpo+wiDgZ0rLq90
        UlvEJpI+GpoI7WRPXELPABDklQ==
X-Google-Smtp-Source: ADFU+vs/ReMVEIKJdAieZwzQ6Ome0PIMgPnHEZ2NECjwaMVYEiKRDwr2hM+QvF7yG/PvY4YndTe9tw==
X-Received: by 2002:a63:58a:: with SMTP id 132mr5025730pgf.216.1583968459378;
        Wed, 11 Mar 2020 16:14:19 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id g75sm2606334pje.37.2020.03.11.16.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 16:14:18 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Maulik Shah <mkshah@codeaurora.org>
Cc:     mka@chromium.org, Rajendra Nayak <rnayak@codeaurora.org>,
        evgreen@chromium.org, Lina Iyer <ilina@codeaurora.org>,
        swboyd@chromium.org, Douglas Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFT PATCH v2 06/10] drivers: qcom: rpmh-rsc: Comment tcs_is_free() + warn if state mismatch
Date:   Wed, 11 Mar 2020 16:13:44 -0700
Message-Id: <20200311161104.RFT.v2.6.Icf2213131ea652087f100129359052c83601f8b0@changeid>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
In-Reply-To: <20200311231348.129254-1-dianders@chromium.org>
References: <20200311231348.129254-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tcs_is_free() had two checks in it: does the software think that the
TCS is free and does the hardware think that the TCS is free.  Let's
comment this and also add a warning in the case that software and
hardware disagree, at least for ACTIVE_ONLY TCS.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- Comment tcs_is_free() new for v2; replaces old patch 6.

 drivers/soc/qcom/rpmh-rsc.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index 9d2669cbd994..93f5d1fb71ca 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -181,8 +181,27 @@ static void write_tcs_reg_sync(struct rsc_drv *drv, int reg, int tcs_id,
  */
 static bool tcs_is_free(struct rsc_drv *drv, int tcs_id)
 {
-	return !test_bit(tcs_id, drv->tcs_in_use) &&
-	       read_tcs_reg(drv, RSC_DRV_STATUS, tcs_id);
+	/* If software thinks it's in use then it's definitely in use */
+	if (test_bit(tcs_id, drv->tcs_in_use))
+		return false;
+
+	/* If hardware agrees it's free then it's definitely free */
+	if (read_tcs_reg(drv, RSC_DRV_STATUS, tcs_id) != 0)
+		return true;
+
+	/*
+	 * If we're here then software and hardware disagree about whether
+	 * the TCS is free.  Software thinks it is free and hardware thinks
+	 * it is not.
+	 *
+	 * Maybe this should be a warning in all cases, but it's almost
+	 * certainly a warning for the ACTIVE_TCS where nobody else should
+	 * be doing anything else behind our backs.  For now we'll just
+	 * warn there and then still return that we're in use.
+	 */
+	WARN(drv->tcs[tcs_id].type == ACTIVE_TCS,
+	     "Driver thought TCS was free but HW reported busy\n");
+	return false;
 }
 
 /**
-- 
2.25.1.481.gfbce0eb801-goog

