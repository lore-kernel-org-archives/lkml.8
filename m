Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A072C38A2B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 21:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BC722083E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 21:16:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="c3/NOVC1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727925AbgDQVQN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 17:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbgDQVQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 17:16:12 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C41C061A0F
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 14:16:12 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id nu11so1576471pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 14:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CUWz5jl2NcFu804QLjVaZT2+TkRuNEMWlXQJjNhqhNA=;
        b=c3/NOVC10A815WixHHHUkc1FXRRX3qF7MyRUpowbpKYoKiWFbmFAhuR3Y6wAi52z0h
         NqIQzCas8SOrrDBb83sfqbxrMnMDXxpYZ6g1l9hIWcOhtCdct3PG5EWNXr91JKQIDRNC
         XdXZbiv3ZZyTFgH15L3ZGe+jEPzZ9yH0XNhCc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CUWz5jl2NcFu804QLjVaZT2+TkRuNEMWlXQJjNhqhNA=;
        b=fJGn8sp7CJhqOPzSi5pXONaPtX+rpMrfQO5BcTXFtiI5B2mPRzgxft7STEspFIlRSv
         3vNL93VRbDB0sPIghcpsS11L1MtpSvQO2e5ayHwabLuOwyoe5ja4bIhjFPwJOnyPrOnA
         1orzGwyTMtag/bteFtVOUGkw37cFiAg9/ksN2N7tIzXpp1JJ1qJfBkVUqsmKp5r+qJEI
         UxtR4sft1EpJxJwupEpjWqTmvcl5e7RQq3p/ZX9VIOzLiBrIhCndXpLONTa2C01K+cSC
         eO6Dmj1DI8pnWUoExdwqx+TSiSRLJiGqdw2f8eSvTRFYwLmnBKSRtg2qrAn/LK2Tqz2d
         coAA==
X-Gm-Message-State: AGi0Pua+hjCJX6V8u8oSgdun+/ykjoxQBDvdsjgclNU2MDlzils4/VRl
        XERpbKLMVJfoiHFedE51XvlmUw==
X-Google-Smtp-Source: APiQypJkVy+nPYJWRl5GKjbYknb2uyZkEUhRrZjepNSDbbsG/l7ZLi1Egiy2xmvH8wqS8GQjRD8SZQ==
X-Received: by 2002:a17:902:44d:: with SMTP id 71mr5628244ple.123.1587158172061;
        Fri, 17 Apr 2020 14:16:12 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id 3sm9582439pgh.75.2020.04.17.14.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 14:16:11 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     bjorn.andersson@linaro.org, agross@kernel.org
Cc:     swboyd@chromium.org, mkshah@codeaurora.org,
        Douglas Anderson <dianders@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        Srinivas Rao L <lsrao@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] soc: qcom: rpmh: Dirt can only make you dirtier, not cleaner
Date:   Fri, 17 Apr 2020 14:15:47 -0700
Message-Id: <20200417141531.1.Ia4b74158497213eabad7c3d474c50bfccb3f342e@changeid>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding an item into the cache should never be able to make the cache
cleaner.  Use "|=" rather than "=" to update the dirty flag.

Fixes: bb7000677a1b ("soc: qcom: rpmh: Update dirty flag only when data changes")
Reported-by: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/soc/qcom/rpmh.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
index 3abbb08cd6e1..d1626a1328d7 100644
--- a/drivers/soc/qcom/rpmh.c
+++ b/drivers/soc/qcom/rpmh.c
@@ -151,10 +151,10 @@ static struct cache_req *cache_rpm_request(struct rpmh_ctrlr *ctrlr,
 		break;
 	}
 
-	ctrlr->dirty = (req->sleep_val != old_sleep_val ||
-			req->wake_val != old_wake_val) &&
-			req->sleep_val != UINT_MAX &&
-			req->wake_val != UINT_MAX;
+	ctrlr->dirty |= (req->sleep_val != old_sleep_val ||
+			 req->wake_val != old_wake_val) &&
+			 req->sleep_val != UINT_MAX &&
+			 req->wake_val != UINT_MAX;
 
 unlock:
 	spin_unlock_irqrestore(&ctrlr->cache_lock, flags);
-- 
2.26.1.301.g55bc3eb7cb9-goog

