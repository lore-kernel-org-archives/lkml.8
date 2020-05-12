Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70491C54E4A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 12:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DE122075E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 12:54:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="scW+/E3V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729243AbgELMyR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 08:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729964AbgELMyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 08:54:07 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3C6C061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 05:54:06 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id e16so15231713wra.7
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 05:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3LiHGYQJdrfKidREPKcP85nvhchSzlTD7vf2JY+btAU=;
        b=scW+/E3VOhb7ANMkVGJAkt7I46OvXaM5bUd9N0yFWjWVfeIAu2lIjkgtUMGJUGqT2v
         o87Z65cKvS6wBr1IJmeiic/ITKuZXfTMO3Lrvxc+/WHFSUoyB3/mx0JGmHF+vOoXEUs2
         rHpa0IRoHt2Epz3mA1yq70MMy1zH25WqxYc0aOfgnhc7UqNR8SVfQ2uPac0T6QUdzCGs
         PlYJ3NC9syl5LHu9dZstEPrZLF7cd70ILMfQDuoG1KDEUlQSpD7WVvDF3Yh7rF8t0Oc4
         lnXedUVI+mIg2DOvSe5eL9UBRK16w9fSAzbzQ+nAG3nbu7hrkh8Fu5IvXKUNoKZCwCAN
         4E/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3LiHGYQJdrfKidREPKcP85nvhchSzlTD7vf2JY+btAU=;
        b=HuQ5orhtLtTz8zChO5tGewkmwF241fRb5MWNUSjBHjckW1TCbwR0FPw0x0LBlmAIMT
         AZPpFFj6dZeYzQJwOJpKh0B5W/ifNbPcC7PUhrneY2PnPgI3yeYUq2mPBM7S2+Py2eee
         yIGNblul6XE0vx5LnjLpL+wnkU53+M1iNUN7zKwYU1xLQ76Y+8CXtlvbeBYaPnViuiTH
         oJTq6HTzejVgi9Aj1/g3nNbO+D2TSAKECLC+YthrTDK2aGpO4w6SVjet8uNxtUSdgnJ1
         MrZJBH94j1IwdIOIuSWUe5GjsNfbMnrhm3iP/xwMO7YM8dpVf/uh6fSmqdRwwGd9k/zh
         LV1A==
X-Gm-Message-State: AGi0Puberw3YihcpxEhS/ihpm7devgAiKsOiZk1n5YiK9w/qupSrO4+w
        kHAq4NFTgTsRKlSyP/wUNhySHg==
X-Google-Smtp-Source: APiQypLWnsIijAZkCoIPv0Yw0p6DgOwRj7KRO6OOZp0lKCb8xAu9CIukABYCZLAyYnm8VEBr1P0w2w==
X-Received: by 2002:adf:b30f:: with SMTP id j15mr26775441wrd.394.1589288045298;
        Tue, 12 May 2020 05:54:05 -0700 (PDT)
Received: from localhost.localdomain (212-39-89-66.ip.btc-net.bg. [212.39.89.66])
        by smtp.googlemail.com with ESMTPSA id n13sm2433938wrs.2.2020.05.12.05.54.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 May 2020 05:54:04 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org, rjw@rjwysocki.net,
        saravanak@google.com, sibis@codeaurora.org, mka@chromium.org
Cc:     robh+dt@kernel.org, rnayak@codeaurora.org,
        bjorn.andersson@linaro.org, vincent.guittot@linaro.org,
        jcrouse@codeaurora.org, evgreen@chromium.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, georgi.djakov@linaro.org
Subject: [PATCH v8 06/10] OPP: Update the bandwidth on OPP frequency changes
Date:   Tue, 12 May 2020 15:53:23 +0300
Message-Id: <20200512125327.1868-7-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200512125327.1868-1-georgi.djakov@linaro.org>
References: <20200512125327.1868-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the OPP bandwidth values are populated, we want to switch also the
interconnect bandwidth in addition to frequency and voltage.

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Sibi Sankar <sibis@codeaurora.org>
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
v8:
* Picked reviewed-by tags.

 drivers/opp/core.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index a3dd0bc9b9f6..b4cc4b12d57b 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -808,7 +808,7 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 	unsigned long freq, old_freq, temp_freq;
 	struct dev_pm_opp *old_opp, *opp;
 	struct clk *clk;
-	int ret;
+	int ret, i;
 
 	opp_table = _find_opp_table(dev);
 	if (IS_ERR(opp_table)) {
@@ -909,6 +909,17 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 			dev_err(dev, "Failed to set required opps: %d\n", ret);
 	}
 
+	if (!ret && opp_table->paths) {
+		for (i = 0; i < opp_table->path_count; i++) {
+			ret = icc_set_bw(opp_table->paths[i],
+					 opp->bandwidth[i].avg,
+					 opp->bandwidth[i].peak);
+			if (ret)
+				dev_err(dev, "Failed to set bandwidth[%d]: %d\n",
+					i, ret);
+		}
+	}
+
 put_opp:
 	dev_pm_opp_put(opp);
 put_old_opp:
