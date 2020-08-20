Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D47C7C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 07:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B34112076E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 07:56:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mf3rBwfB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbgHTH4z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 03:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726968AbgHTH4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 03:56:50 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C2CC061757
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 00:56:49 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id r11so611879pfl.11
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 00:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iqN+JRqBcM9sNS/bUUY7pxB30ldKatY72VtpGF2V5es=;
        b=mf3rBwfBi0yKumSxP8KE3wv22MrRq2xvrN50piShKy6hP8xLXV3o5c16JSMPtHIuy9
         +HGYFuxUtPOQIAee5skPIxdRSp80RPp98Qx6YwSDRviMIhgkE82sV9+XsVzIUBMIGU2e
         lkZcKh7JmQg9xjbLnH9GRK+c0hnXZDbtIKuTMOZ3W57PY29jgpHVO/nMynDjGZGJIrHE
         K+YfMWeOJij4utbSUAv5OX9S+m1BpIwcShog7ZvylOCusbSalofndd2qgQ4SeOiXiyMG
         OuXv/60JgKFcucPFV41z8wupsn3Qp0MuPSHYvbPdYjVV6ld3eHhT9ofkMZeqrFjVqJ5z
         J7tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iqN+JRqBcM9sNS/bUUY7pxB30ldKatY72VtpGF2V5es=;
        b=b8K0Kcbz96aXjr74HdJjbhh5/j9AipdJ9K2yX35qjBIwXR+iLnJhR11Bv4lrJ/Qm7O
         GlbYcTV74SIIIF/vi2bZToSWLDMgwej/gpGCmQeR6K5Z0PK7X5/+S0mMGQckjfI0OExy
         41o8NwgV3uC21f/Gizdto2geQU/JBfcHHy+oZyLmbe1NPqDLSzRYf12VG6qFeypb78Ax
         Y5E7u1q5VWbUHnzWkmmhpKWGckPQACYgIEGH5gNdM9w2HwjEkQxw+nBwGr/8S4N5C69o
         myVAzfL1UqO/1iWLC8R+/xSarToXrj+EBSCsZ8yAgBbchVY8g/ivUQsNN3Ap4tB5blr5
         nVjw==
X-Gm-Message-State: AOAM5326UyVt0RrMUqU0kmu47ns2aRCcVqKERHmT33KgAUGpYNaPv5OF
        vKwQhGUEAHzWq3yAieM2lXxQHw==
X-Google-Smtp-Source: ABdhPJxQ7U6EWVfkoD2z5UQBGCWPgueMB34snJzWDFh8s4UoEucOWlQWof69mlCJK0R6lO73TdPodw==
X-Received: by 2002:a63:4b61:: with SMTP id k33mr1583047pgl.195.1597910209384;
        Thu, 20 Aug 2020 00:56:49 -0700 (PDT)
Received: from localhost ([122.172.43.13])
        by smtp.gmail.com with ESMTPSA id n17sm1570767pgg.6.2020.08.20.00.56.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Aug 2020 00:56:48 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     rnayak@codeaurora.org, Viresh Kumar <vireshk@kernel.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>, sibis@codeaurora.org,
        sbhanu@codeaurora.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3 3/4] opp: Split out _opp_set_rate_zero()
Date:   Thu, 20 Aug 2020 13:26:33 +0530
Message-Id: <5a0183fa0b61cf70839fa90aa70f79e33ab4f60a.1597909885.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <cover.1597909885.git.viresh.kumar@linaro.org>
References: <cover.1597909885.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create separate routine _opp_set_rate_zero() to handle !target_freq
case.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c | 52 ++++++++++++++++++++++++++--------------------
 1 file changed, 29 insertions(+), 23 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 0b437d483b75..4edd2c3d6d91 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -860,6 +860,34 @@ int dev_pm_opp_set_bw(struct device *dev, struct dev_pm_opp *opp)
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_set_bw);
 
+static int _opp_set_rate_zero(struct device *dev, struct opp_table *opp_table)
+{
+	int ret;
+
+	if (!opp_table->enabled)
+		return 0;
+
+	/*
+	 * Some drivers need to support cases where some platforms may
+	 * have OPP table for the device, while others don't and
+	 * opp_set_rate() just needs to behave like clk_set_rate().
+	 */
+	if (!_get_opp_count(opp_table))
+		return 0;
+
+	ret = _set_opp_bw(opp_table, NULL, dev, true);
+	if (ret)
+		return ret;
+
+	if (opp_table->regulators)
+		regulator_disable(opp_table->regulators[0]);
+
+	ret = _set_required_opps(dev, opp_table, NULL);
+
+	opp_table->enabled = false;
+	return ret;
+}
+
 /**
  * dev_pm_opp_set_rate() - Configure new OPP based on frequency
  * @dev:	 device for which we do this operation
@@ -886,29 +914,7 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 	}
 
 	if (unlikely(!target_freq)) {
-		ret = 0;
-
-		if (!opp_table->enabled)
-			goto put_opp_table;
-
-		/*
-		 * Some drivers need to support cases where some platforms may
-		 * have OPP table for the device, while others don't and
-		 * opp_set_rate() just needs to behave like clk_set_rate().
-		 */
-		if (!_get_opp_count(opp_table))
-			goto put_opp_table;
-
-		ret = _set_opp_bw(opp_table, NULL, dev, true);
-		if (ret)
-			goto put_opp_table;
-
-		if (opp_table->regulators)
-			regulator_disable(opp_table->regulators[0]);
-
-		ret = _set_required_opps(dev, opp_table, NULL);
-
-		opp_table->enabled = false;
+		ret = _opp_set_rate_zero(dev, opp_table);
 		goto put_opp_table;
 	}
 
-- 
2.25.0.rc1.19.g042ed3e048af

