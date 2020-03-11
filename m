Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A60DC5ACC2
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 23:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45D182074E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 23:14:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jRtnocXH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731551AbgCKXO3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 19:14:29 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42241 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731503AbgCKXOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 19:14:21 -0400
Received: by mail-pf1-f196.google.com with SMTP id x2so1840998pfn.9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 16:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mCMQ2OChqTGNObRkFX9H0wPC+5YSQubFFV/J730ew5s=;
        b=jRtnocXHHMUP3D+7tOmcprsy5ijnwFjDJ2i50lUH6gswsfBQnvJKVqfR5jpnGxFwWA
         ce1P1tv5x9Mli/4UNjaB5lE2ae20TKIRXhYPr4twa0iJ1ggbqNqpwjBcmQ2OG/7ZBSjR
         1y1aCxYUhYpaVcihAXvzY+Ycp2e/5Am4O665o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mCMQ2OChqTGNObRkFX9H0wPC+5YSQubFFV/J730ew5s=;
        b=mxgPpXaHQO/3lJUhxV7/pNXb7B/kC9l0iCQsMjCXm1jU3+2OrnnEUlfA/JOGONBTDh
         K3hMXFaqTrmXlw1YmfK59Og8/Mo2u8fV6wB4pDbTv2yZQH3Z+esuO9m39UHQDfkvgJEa
         jJ/utHcqb49i39z0ikdgE74HXedD8XIy7+VIJMjKKyO7Koe3PfhhSh7bZboIjCfQX8Z/
         6Am7TlUHk91Dcr+g7Eiz/oMteG7df90khcGwObr/hliBLl4bO+wh0Aw1lMlHGT2um5Us
         V1SbvSbBfiR/Em/XLnIt2VIXyqCIwdwE7V+a4SR0eDwLhDckwmk0Np6Tv7BhgNzse5ax
         vxxA==
X-Gm-Message-State: ANhLgQ1MzpiVkO84Dtc5OWrgZfvBun+y+xfTj38+UFW/tUDwREhx5mnw
        Dwfkdvh+WdTtmTHAESUAZpSVSJe3pik=
X-Google-Smtp-Source: ADFU+vtMFl8p/co8i8x5gkeIQK2jVDPcbsl/SIL1NLHshjUeTo67wxI9RgvSkAVSGhGTpySbG2k2Tg==
X-Received: by 2002:a63:4555:: with SMTP id u21mr4952213pgk.66.1583968460689;
        Wed, 11 Mar 2020 16:14:20 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id g75sm2606334pje.37.2020.03.11.16.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 16:14:20 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Maulik Shah <mkshah@codeaurora.org>
Cc:     mka@chromium.org, Rajendra Nayak <rnayak@codeaurora.org>,
        evgreen@chromium.org, Lina Iyer <ilina@codeaurora.org>,
        swboyd@chromium.org, Douglas Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFT PATCH v2 07/10] drivers: qcom: rpmh-rsc: Warning if tcs_write() used for non-active
Date:   Wed, 11 Mar 2020 16:13:45 -0700
Message-Id: <20200311161104.RFT.v2.7.I8e187cdfb7a31f5bb7724f1f937f2862ee464a35@changeid>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
In-Reply-To: <20200311231348.129254-1-dianders@chromium.org>
References: <20200311231348.129254-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tcs_write() is documented to only be useful for writing
RPMH_ACTIVE_ONLY_STATE.  Let's be loud if someone messes up.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2: None

 drivers/soc/qcom/rpmh-rsc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index 93f5d1fb71ca..ba489d18c20e 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -573,6 +573,12 @@ static int tcs_write(struct rsc_drv *drv, const struct tcs_request *msg)
 	unsigned long flags;
 	int ret;
 
+	/*
+	 * It only makes sense to grab a whole TCS for ourselves if we're
+	 * triggering right away, which we only do for ACTIVE_ONLY.
+	 */
+	WARN_ON(msg->state != RPMH_ACTIVE_ONLY_STATE);
+
 	/* TODO: get_tcs_for_msg() can return -EAGAIN and nobody handles */
 	tcs = get_tcs_for_msg(drv, msg);
 	if (IS_ERR(tcs))
-- 
2.25.1.481.gfbce0eb801-goog

