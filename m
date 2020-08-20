Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C22A1C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 07:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CEE42076E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 07:57:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="djA1hgKE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbgHTH5X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 03:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726841AbgHTH4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 03:56:47 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07515C061343
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 00:56:46 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id k13so544438plk.13
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 00:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7cAYVPl8VrNuz/qq2w1qboUHzBiXW9tB7aHazhnx+PM=;
        b=djA1hgKEGskSmARq3FIBrHUsYkkRYcjjVOCAopzAHSM3DdER8yOHcbaeLUYu5OrdvX
         29WLW6jF8w82pw3sGSWKV4gumuYQhCXS4+Uo4wB648aMj1oTtl9KY8tJIO2c6MlCAz4H
         XIkYwISLFxGmNwkmqb+OiuqROpFTHyyt33+A1MmQy3ItCODZx5ppQSlVAieEW8ahhIlX
         OhsoT3yiRmkfL2VoIorrNcAF64tNwrUkhFBh3gtPNX6a1XkdAB50b0NjhU/iZryBEP+p
         QYSe8XvJkTtiE6bt5CsFiWpW3o6QXx3WpQl+Yma5Qmee4izygCJael6hkfcplCxDECYN
         moKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7cAYVPl8VrNuz/qq2w1qboUHzBiXW9tB7aHazhnx+PM=;
        b=eBFouqwD9UhncYcV1wY8VHP+47Zl/Nu+AgkgvUCZ4/6t0gGmgZ8jnbkBOg2ZvRTIYt
         WOce218gBPjjmp9eyZJBZQ/X0aoz1vhdUIAhGw8iUtuKXAA3BJ3pf2rmH5sWmqNNyVOh
         YaHaukntPDfyvWBzC5fvv+ueGDKB+lOzYdJ/Bo3JsZ6lXDvnJ7FVh659ptwIbT/NqFOK
         mPlQu7u5awU9J46CbOSSDD+MMmnHMHwTR5hLDUYtwULqoELf8U+LQGEcrA4ROtmwMLyj
         dYdULWionMsbWBfqtGOgGBgLwEUgw9Q4rPxH5YDESxXXhCdSo1pOadFYip78J5W5/6il
         JTbQ==
X-Gm-Message-State: AOAM530zKiDTIBSlti+b8rBc2RUAXLamTabbOwN85TSlC2biNgh3v7zT
        QWVVbZo0waQp46DLnHA7BZ/yKg==
X-Google-Smtp-Source: ABdhPJzRSKZYVMfP9/tr8oO0UXvoRbzfFJJfmGeZ3SD9CPHnYC/ddojFEpND02X48Kp8mtP708SYyQ==
X-Received: by 2002:a17:902:be0f:: with SMTP id r15mr156256pls.84.1597910206510;
        Thu, 20 Aug 2020 00:56:46 -0700 (PDT)
Received: from localhost ([122.172.43.13])
        by smtp.gmail.com with ESMTPSA id v10sm21351892pjy.3.2020.08.20.00.56.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Aug 2020 00:56:45 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     rnayak@codeaurora.org, Viresh Kumar <vireshk@kernel.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>, sibis@codeaurora.org,
        sbhanu@codeaurora.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3 2/4] opp: Reuse the enabled flag in !target_freq path
Date:   Thu, 20 Aug 2020 13:26:32 +0530
Message-Id: <9cefccfbf124c49f32c905549aad9ab284957065.1597909885.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <cover.1597909885.git.viresh.kumar@linaro.org>
References: <cover.1597909885.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The OPP core needs to track if the resources of devices are
enabled/configured or not, as it disables the resources when target_freq
is set to 0.

Handle that with the new enabled flag and remove otherwise complex
conditional statements.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c | 29 +++++++++++------------------
 1 file changed, 11 insertions(+), 18 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 6f43ef4945b7..0b437d483b75 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -886,22 +886,18 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 	}
 
 	if (unlikely(!target_freq)) {
+		ret = 0;
+
+		if (!opp_table->enabled)
+			goto put_opp_table;
+
 		/*
 		 * Some drivers need to support cases where some platforms may
 		 * have OPP table for the device, while others don't and
 		 * opp_set_rate() just needs to behave like clk_set_rate().
 		 */
-		if (!_get_opp_count(opp_table)) {
-			ret = 0;
-			goto put_opp_table;
-		}
-
-		if (!opp_table->required_opp_tables && !opp_table->regulators &&
-		    !opp_table->paths) {
-			dev_err(dev, "target frequency can't be 0\n");
-			ret = -EINVAL;
+		if (!_get_opp_count(opp_table))
 			goto put_opp_table;
-		}
 
 		ret = _set_opp_bw(opp_table, NULL, dev, true);
 		if (ret)
@@ -931,14 +927,11 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 	old_freq = clk_get_rate(clk);
 
 	/* Return early if nothing to do */
-	if (old_freq == freq) {
-		if (!opp_table->required_opp_tables && !opp_table->regulators &&
-		    !opp_table->paths) {
-			dev_dbg(dev, "%s: old/new frequencies (%lu Hz) are same, nothing to do\n",
-				__func__, freq);
-			ret = 0;
-			goto put_opp_table;
-		}
+	if (opp_table->enabled && old_freq == freq) {
+		dev_dbg(dev, "%s: old/new frequencies (%lu Hz) are same, nothing to do\n",
+			__func__, freq);
+		ret = 0;
+		goto put_opp_table;
 	}
 
 	/*
-- 
2.25.0.rc1.19.g042ed3e048af

