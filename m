Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E156C43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 09:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F495206F4
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 09:50:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jw0gTeZW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725848AbgIKJuI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 05:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbgIKJuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 05:50:06 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ADF4C061756
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 02:50:06 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id t14so6250463pgl.10
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 02:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tHCqsvIu83bEFNo3aLaW7H1ltiqU0PztIdRU2no/+cM=;
        b=jw0gTeZW0bWZxDIXwLvslEr5ZIIGkuQxyY55djRUdIv0TVBVhA9eg8l0oiY0IFZ4qU
         rqQpUp+K8YRyJ15dM0t0nYuu5Uo7pwwy7hYhCWRiwh4ccwtXk/ZmFVPn3ctKWVQQ3uFV
         HoOhtbhScxSjxCz3FQQz2oKfKiopcy3CUfEh11Gq/6m4zUmtiykpqhLc4VpYDqQhB5/K
         DU1m2eAikF7/Y0VQAzsGAZcisMa2cwhdh6KCVJzVxJKHi+3B0DyQEXQwHBMWsXYNegZ5
         ehFYOpYHAyLswbNng7PAkR0k0wWapxP4Y+LPWgkS81SkRF9FsUBU9spWkpGgVHLblgFy
         +d9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tHCqsvIu83bEFNo3aLaW7H1ltiqU0PztIdRU2no/+cM=;
        b=Ni5VTFEZGPWxjluGMalIKcfRhN32uTQToQ2rVD6EUD6SM1o9YLeaNwB+JdpcaUBHZJ
         sG3/AZvgoMuS99vVd4v1FbizxPYf5r65Qkk/T7ZgvwK8FtIQ1qlWejk/nbzz6BUP3p5b
         BXNbKJUHbvGg5l8J9GDxibgGNU0mc2V4/7y0yHC8mDjvhJzg579KhTYrM8sXiFSWcU1O
         IzH9U5YaH17o4SaDgAgLIdGEdt0sbAYqZgDY3oj/Sa0rt0yXlZlMwFUST6QfHv2XqZhb
         UHK92OrZG3WTlmC8Oacre/K/RPQh0zrDrPmHGEV7M8AZhwqbqwbJqUY9hQIzfBAF8/Jb
         AwSQ==
X-Gm-Message-State: AOAM532ESxyanhmq4V/TvgquWlW2xLLvRcyN/MABK4hz3pPhqMe6p08W
        nlGqg+Jjko4y2EyW2W/kK7geyg==
X-Google-Smtp-Source: ABdhPJzYJ/xW4JtUp2MxDCxTT79XTEM3qazhysGxIWXTlnn624vpjeODDqtu+dUu6PQGfItgaUbTDg==
X-Received: by 2002:a62:108:: with SMTP id 8mr1491790pfb.36.1599817805535;
        Fri, 11 Sep 2020 02:50:05 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id e14sm1364788pgu.47.2020.09.11.02.50.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Sep 2020 02:50:04 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Stephan Gerhold <stephan@gerhold.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] opp: Allow opp-level to be set to 0
Date:   Fri, 11 Sep 2020 15:19:53 +0530
Message-Id: <40b676a1e261d1cfd12788d88e0d2026dbbe226b.1599817789.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DT bindings don't put such a constraint, nor should the kernel. It
is perfectly fine for opp-level to be set to 0, if we need to put the
performance state votes for a domain for a particular OPP.

Reported-by: Stephan Gerhold <stephan@gerhold.net>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c |  3 ---
 drivers/opp/of.c   | 20 +++++++-------------
 2 files changed, 7 insertions(+), 16 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 214c1619b445..2483e765318a 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -2117,9 +2117,6 @@ int dev_pm_opp_xlate_performance_state(struct opp_table *src_table,
 	int dest_pstate = -EINVAL;
 	int i;
 
-	if (!pstate)
-		return 0;
-
 	/*
 	 * Normally the src_table will have the "required_opps" property set to
 	 * point to one of the OPPs in the dst_table, but in some cases the
diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index e72753be7dc7..87f839a1899a 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -842,7 +842,7 @@ static struct dev_pm_opp *_opp_add_static_v2(struct opp_table *opp_table,
 static int _of_add_opp_table_v2(struct device *dev, struct opp_table *opp_table)
 {
 	struct device_node *np;
-	int ret, count = 0, pstate_count = 0;
+	int ret, count = 0;
 	struct dev_pm_opp *opp;
 
 	/* OPP table is already initialized for the device */
@@ -876,20 +876,14 @@ static int _of_add_opp_table_v2(struct device *dev, struct opp_table *opp_table)
 		goto remove_static_opp;
 	}
 
-	list_for_each_entry(opp, &opp_table->opp_list, node)
-		pstate_count += !!opp->pstate;
-
-	/* Either all or none of the nodes shall have performance state set */
-	if (pstate_count && pstate_count != count) {
-		dev_err(dev, "Not all nodes have performance state set (%d: %d)\n",
-			count, pstate_count);
-		ret = -ENOENT;
-		goto remove_static_opp;
+	list_for_each_entry(opp, &opp_table->opp_list, node) {
+		/* Any non-zero performance state would enable the feature */
+		if (opp->pstate) {
+			opp_table->genpd_performance_state = true;
+			break;
+		}
 	}
 
-	if (pstate_count)
-		opp_table->genpd_performance_state = true;
-
 	return 0;
 
 remove_static_opp:
-- 
2.25.0.rc1.19.g042ed3e048af

