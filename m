Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74EF7C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 04:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53042206D5
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 04:13:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yc9MHRKH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728637AbgE0ENd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 00:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728626AbgE0ENd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 00:13:33 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC66CC03E97B
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 21:13:32 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id 124so4984713pgi.9
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 21:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AfGrQhANyY91hXOGSpuo1mwaEcVmt3M+OaE9Tl+XS5Y=;
        b=yc9MHRKHZBNnZOmxUrGmqU+Z+7ZywJkjcbhb96l70OeshyTattGt2KB+DO5GOfMS9q
         0dUP/f4JiyU+qJq1zXgDQWJkJcqE0HCu3Rme/QapoxmAQf/6iJMbZgQ7Fxzwr6G1+Rft
         MW4+9dTfS6xhmJk349y9xRFKkfD2Q61CnFLkZAaeI2d02s5EqwSwylsetVlMhNhmbCz3
         V1iD+MrvsmQxsCmhHwSAZwUiIa7HrMzVYaO0nJZvrxHlHhrISjTqSlguqfVgD18MEHnw
         jKkUJNkUs/UMWRCiR4dGUdK68aw6sQKfKeTZY1Bqs/LetHNcrlZIqLAXI1+Gsci6sh/N
         k5GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AfGrQhANyY91hXOGSpuo1mwaEcVmt3M+OaE9Tl+XS5Y=;
        b=O9NSP+cv7u1m/ned1TrvF5LCOUZlomwN6NPjNAtXuO6ND2Q9JExqBJLI5qoy+Q1Eqj
         oh5gJ9RQbzlDMlVmKeQImGqSNhFm/i5K1Kvv4xP31RFa0HIanX+j2nQcjafzR499uKR2
         NQlpDBjHCtSOWe5PxL0PJQJz0JIxXMNvODY5kLYbjp4OT+F6LHaa1WS5YgBmpC5mE1ym
         enqnnbURTVTE4EymYPa4n7ifg9JPmWbtgBlL4ThiM8Cofr+UEmVYuO7hSe2adN3tvl/z
         4BwM3zvISsGMTTS0hv04+uuXE5l0AEA5/noNynRf+xMbtG4lOmW3mzbOpZUp6NoooxYE
         qrCA==
X-Gm-Message-State: AOAM53164+9AieXAlueJ7SBWZE8sw2jbvREZTf7OFFjcAcu2eyzbqysB
        AldLQYFRPYS1RpPfajSOLI+qsg==
X-Google-Smtp-Source: ABdhPJzmmNzofmSQKXXkiLwVh283U0hXbNZue0aNKNZCZ8WLJSKaHQuIFhwfg9UwS2ZESJKgLXFaPw==
X-Received: by 2002:a63:f502:: with SMTP id w2mr2061317pgh.321.1590552812239;
        Tue, 26 May 2020 21:13:32 -0700 (PDT)
Received: from localhost ([122.172.60.59])
        by smtp.gmail.com with ESMTPSA id 192sm823471pfu.202.2020.05.26.21.13.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 May 2020 21:13:31 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>, georgi.djakov@linaro.org,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2] opp: Remove bandwidth votes when target_freq is zero
Date:   Wed, 27 May 2020 09:43:26 +0530
Message-Id: <3aa3870d71b536127bb6af88c1dbfb4672ba4173.1590552778.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <20200512125327.1868-1-georgi.djakov@linaro.org>
References: <20200512125327.1868-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We already drop several votes when target_freq is set to zero, drop
bandwidth votes as well.

Reported-by: Sibi Sankar <sibis@codeaurora.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
V2: Some changes left uncommited in my tree by mistake.

 drivers/opp/core.c | 49 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 37 insertions(+), 12 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 56d3022c1ca2..df12c3804533 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -725,6 +725,34 @@ static int _generic_set_opp_regulator(struct opp_table *opp_table,
 	return ret;
 }
 
+static int _set_opp_bw(const struct opp_table *opp_table,
+		       struct dev_pm_opp *opp, struct device *dev, bool remove)
+{
+	u32 avg, peak;
+	int i, ret;
+
+	if (!opp_table->paths)
+		return 0;
+
+	for (i = 0; i < opp_table->path_count; i++) {
+		if (remove) {
+			avg = 0;
+			peak = 0;
+		} else {
+			avg = opp->bandwidth[i].avg;
+			peak = opp->bandwidth[i].peak;
+		}
+		ret = icc_set_bw(opp_table->paths[i], avg, peak);
+		if (ret) {
+			dev_err(dev, "Failed to %s bandwidth[%d]: %d\n",
+				remove ? "remove" : "set", i, ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
 static int _set_opp_custom(const struct opp_table *opp_table,
 			   struct device *dev, unsigned long old_freq,
 			   unsigned long freq,
@@ -820,7 +848,7 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 	unsigned long freq, old_freq, temp_freq;
 	struct dev_pm_opp *old_opp, *opp;
 	struct clk *clk;
-	int ret, i;
+	int ret;
 
 	opp_table = _find_opp_table(dev);
 	if (IS_ERR(opp_table)) {
@@ -837,12 +865,17 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 		if (!_get_opp_count(opp_table))
 			return 0;
 
-		if (!opp_table->required_opp_tables && !opp_table->regulators) {
+		if (!opp_table->required_opp_tables && !opp_table->regulators &&
+		    !opp_table->paths) {
 			dev_err(dev, "target frequency can't be 0\n");
 			ret = -EINVAL;
 			goto put_opp_table;
 		}
 
+		ret = _set_opp_bw(opp_table, opp, dev, true);
+		if (ret)
+			return ret;
+
 		if (opp_table->regulator_enabled) {
 			regulator_disable(opp_table->regulators[0]);
 			opp_table->regulator_enabled = false;
@@ -932,16 +965,8 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 			dev_err(dev, "Failed to set required opps: %d\n", ret);
 	}
 
-	if (!ret && opp_table->paths) {
-		for (i = 0; i < opp_table->path_count; i++) {
-			ret = icc_set_bw(opp_table->paths[i],
-					 opp->bandwidth[i].avg,
-					 opp->bandwidth[i].peak);
-			if (ret)
-				dev_err(dev, "Failed to set bandwidth[%d]: %d\n",
-					i, ret);
-		}
-	}
+	if (!ret)
+		ret = _set_opp_bw(opp_table, opp, dev, false);
 
 put_opp:
 	dev_pm_opp_put(opp);
-- 
2.25.0.rc1.19.g042ed3e048af

