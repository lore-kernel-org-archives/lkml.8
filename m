Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B1E9C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 04:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 358B120768
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 04:29:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iPOv0PAO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbgHME3S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 00:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbgHME3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 00:29:17 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70EBAC061757
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 21:29:16 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id d22so2163470pfn.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 21:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=EmYcMBFXduhCjGSSeOrt+gv2BnfjO/m6pxI+pucShxg=;
        b=iPOv0PAOwGrizFxzdFf9t/4kn5i+QSHq+MB1/7/E3KmAWZydvSEm9crZyK1GDeKqn7
         /INLfrfZNWy6yZvtzwawmgA8kajj/4viTNR9HS8kR9wKHePKh97qIZqVJAFTyK9GQp7+
         jDg5Fvzwb3NMb41ZAcoMd7zN3BOffp3hN0qPbQ1SjX9H0x/HAWeYpbA+O84xCJ9spPIF
         tlt+8cVEnDJ0DDpskXmrRjAOGmUp5669+QmD7fLAr0Xh9R3XwRmVOc2TrPjoiufiSiqv
         BZnFfrjRDHm/c6Lo0dl4RdIEYzFHizFjUOBxvEjDvvn2jG5oW/NB6XtnhVx+K/HOZR1e
         roKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=EmYcMBFXduhCjGSSeOrt+gv2BnfjO/m6pxI+pucShxg=;
        b=eRTHVAXL6I3mB3XIT4VMTpHAA1j3C8F48wxF2hrpsuye6hlJUCMuoqbPXpuFza4T4t
         krdD9YLfoq+JeEkqF3ayNAeyRlLz9HbO9wLl7koOTnMv4IMB6WU6hXmZJ16yvOBDXmN+
         IovkeSgrOQOk6umo8OOhJKOZdMKNNWdLTpkeMy10KRZJ3AnOxh86UCyaesXoKTso5C5x
         Abi2qTL7IWX1bWWhz77mGkVyafaGd1kqRkOe1JN9MipPCFLw/7vUOTPLuY42tfqj/7+M
         rnPm6WMpCsrqJTYHlZtNvrR4P/OOZEenGLbblbd4Dokwu7E3JY125wTmNgkyGQEJgPGA
         73dQ==
X-Gm-Message-State: AOAM532bxuCmHme0Ul5JCKqKn/6IkY9mF90r9kPJPFA8ybyXurpfFX7a
        OeMETmCYsusMpyFqPOQ7MlCsog==
X-Google-Smtp-Source: ABdhPJzODPFHAqWtboOMEMett8hu9BBsAIi3bVplg9YbNaau3YXbRuJT8Xz5EMlvOj5mGIEVF2KpBQ==
X-Received: by 2002:aa7:9468:: with SMTP id t8mr2530895pfq.182.1597292955865;
        Wed, 12 Aug 2020 21:29:15 -0700 (PDT)
Received: from localhost ([171.79.32.211])
        by smtp.gmail.com with ESMTPSA id f195sm3837538pfa.96.2020.08.12.21.29.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Aug 2020 21:29:15 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>, mka@chromium.org,
        sibis@codeaurora.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] opp: Track device's resources configuration status
Date:   Thu, 13 Aug 2020 09:58:59 +0530
Message-Id: <453b3897507838e95359d891ef967165bd167a4e.1597292833.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <c6bba235a9a6fd777255bb4f1d16492fdcabc847.1597292833.git.viresh.kumar@linaro.org>
References: <1597043179-17903-1-git-send-email-rnayak@codeaurora.org>
 <c6bba235a9a6fd777255bb4f1d16492fdcabc847.1597292833.git.viresh.kumar@linaro.org>
In-Reply-To: <c6bba235a9a6fd777255bb4f1d16492fdcabc847.1597292833.git.viresh.kumar@linaro.org>
References: <c6bba235a9a6fd777255bb4f1d16492fdcabc847.1597292833.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The OPP core needs to track if the resources of devices are enabled or
configured or not, as it disables the resources when target_freq is set
to 0.

Handle that with a separate variable to make it easy to maintain.

Also note that we will unconditionally call clk_set_rate() in the case
where the resources are getting enabled again. This shouldn't have any
side effects anyway.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c | 37 ++++++++++++++++++-------------------
 drivers/opp/opp.h  |  2 ++
 2 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 9668ea04cc80..e8882e7fd8a5 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -888,22 +888,18 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
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
@@ -915,6 +911,9 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 		}
 
 		ret = _set_required_opps(dev, opp_table, NULL);
+		if (!ret)
+			opp_table->enabled = false;
+
 		goto put_opp_table;
 	}
 
@@ -933,14 +932,11 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
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
@@ -1001,8 +997,11 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 			dev_err(dev, "Failed to set required opps: %d\n", ret);
 	}
 
-	if (!ret)
+	if (!ret) {
 		ret = _set_opp_bw(opp_table, opp, dev, false);
+		if (!ret)
+			opp_table->enabled = true;
+	}
 
 put_opp:
 	dev_pm_opp_put(opp);
diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
index e51646ff279e..bd35802acc6e 100644
--- a/drivers/opp/opp.h
+++ b/drivers/opp/opp.h
@@ -152,6 +152,7 @@ enum opp_table_access {
  * property).
  * @paths: Interconnect path handles
  * @path_count: Number of interconnect paths
+ * @enabled: Set to true if the device's resources are enabled/configured.
  * @genpd_performance_state: Device's power domain support performance state.
  * @is_genpd: Marks if the OPP table belongs to a genpd.
  * @set_opp: Platform specific set_opp callback
@@ -198,6 +199,7 @@ struct opp_table {
 	bool regulator_enabled;
 	struct icc_path **paths;
 	unsigned int path_count;
+	bool enabled;
 	bool genpd_performance_state;
 	bool is_genpd;
 
-- 
2.14.1

