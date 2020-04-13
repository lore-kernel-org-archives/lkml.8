Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 398F1C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 17:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17D9C2073E
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 17:05:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XJLmHV8B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732420AbgDMRFO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 13:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732373AbgDMREu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 13:04:50 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11340C00860D
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 10:04:50 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id mn19so4041517pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 10:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PZM04ZbYiFIjAv7GG0eoywCOXLJ3nJU1dPqZFxYiM54=;
        b=XJLmHV8BFPN0w3ZfFbumxZ5ivffYLzBB2I/hFasM9oUCz+J/Z1p1Y3lZskM7mUBlEV
         7DOstP44n7DScCdKRw7ufvv87lmSyV79jUEOBRPTLxHWQ5VTsYomoRv24xbc0HRSMO3L
         elWJHOLz8DcVaZ5PAkF003zQ1smXOFLl6vTuA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PZM04ZbYiFIjAv7GG0eoywCOXLJ3nJU1dPqZFxYiM54=;
        b=KFZPbxvHnp+1xvqZSDXO2Yd2LV/XyWyYyPglJxuaac+7VlP7g0DCyKbTiKrRxoalRV
         bwz7uC3uVPp3J10iut6Rrh0hnJG5x+LJyJE9qDgKTXYEbZ4zjGABNRxLn63S5r0iCF6G
         ykFYGWy6Tyq/kIr34vTHYAdPet+V3YPaWqMwM1Kbxirok8s4uKE4F8nX1AR07VoRqrxG
         DkDD50iR/4CFgDO3Ic9TfboyqkbcgBKdEyD0MbemE9Gmjmema9ui4Fg/Z9sZz75kfN7o
         sh+OtkJMrPUgpxxSnlkAWmySIkkqio91XuvALo/wU1cIFjBekxI+lDMe9n4A+U1IuiIt
         Tabw==
X-Gm-Message-State: AGi0PubLAhA2DBdzkGxSeoXq99NXXtPHt5g4K6P3qqfaCBZ6lVG43jZn
        kHdjrpK311q4yJNHQ6pKeMznGw==
X-Google-Smtp-Source: APiQypL8k44Hgn+x9Kq4HREdWFg0ANCXjwLr3IPByI5U0qYV5QOldcYjbs2kvYAgiX1LJolO03zlwA==
X-Received: by 2002:a17:90b:f16:: with SMTP id br22mr5759322pjb.89.1586797489556;
        Mon, 13 Apr 2020 10:04:49 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id p62sm1634414pfb.93.2020.04.13.10.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 10:04:49 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Maulik Shah <mkshah@codeaurora.org>
Cc:     swboyd@chromium.org, mka@chromium.org,
        Rajendra Nayak <rnayak@codeaurora.org>, evgreen@chromium.org,
        Lina Iyer <ilina@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 07/10] drivers: qcom: rpmh-rsc: tcs_is_free() can just check tcs_in_use
Date:   Mon, 13 Apr 2020 10:04:12 -0700
Message-Id: <20200413100321.v4.7.Icf2213131ea652087f100129359052c83601f8b0@changeid>
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
In-Reply-To: <20200413170415.32463-1-dianders@chromium.org>
References: <20200413170415.32463-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tcs_is_free() had two checks in it: does the software think that the
TCS is free and does the hardware think that the TCS is free.  I
couldn't figure out in which case the hardware could think that a TCS
was in-use but software thought it was free.  Apparently there is no
case and the extra check can be removed.  This apparently has already
been done in a downstream patch.

Suggested-by: Maulik Shah <mkshah@codeaurora.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Maulik Shah <mkshah@codeaurora.org>
Tested-by: Maulik Shah <mkshah@codeaurora.org>
---

Changes in v4: None
Changes in v3:
- Replace ("...warn if state mismatch") w/ ("...just check tcs_in_use")

Changes in v2:
- Comment tcs_is_free() new for v2; replaces old patch 6.

 drivers/soc/qcom/rpmh-rsc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index f0a7ada0c16f..4e76e5349c44 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -177,7 +177,6 @@ static void write_tcs_reg_sync(struct rsc_drv *drv, int reg, int tcs_id,
  * @tcs_id: The global ID of this TCS.
  *
  * Returns true if nobody has claimed this TCS (by setting tcs_in_use).
- * If the TCS looks free, checks that the hardware agrees.
  *
  * Must be called with the drv->lock held or the tcs_lock for the TCS being
  * tested. If only the tcs_lock is held then it is possible that this
@@ -188,8 +187,7 @@ static void write_tcs_reg_sync(struct rsc_drv *drv, int reg, int tcs_id,
  */
 static bool tcs_is_free(struct rsc_drv *drv, int tcs_id)
 {
-	return !test_bit(tcs_id, drv->tcs_in_use) &&
-	       read_tcs_reg(drv, RSC_DRV_STATUS, tcs_id);
+	return !test_bit(tcs_id, drv->tcs_in_use);
 }
 
 /**
-- 
2.26.0.110.g2183baf09c-goog

