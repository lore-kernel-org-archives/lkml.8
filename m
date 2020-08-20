Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47248C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 07:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D9112076E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 07:57:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JOhKqnxX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbgHTH5A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 03:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbgHTH4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 03:56:54 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E0DC061757
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 00:56:53 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id t6so636051pjr.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 00:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MKa/l++NJX3mb6HDqlPH9HCmk5UKEoj8jJyL9pAVlUc=;
        b=JOhKqnxXyMfppUBIxlmvtEQlY5wB7zlwWW93yYoleBojKtOVakJwUIYj1ZKu4hzmZb
         EKEtrRsslpuOJ6lZJaqD+bqa4AbhVNuOyzF8abrRSlnfiLB1UstLmeV0AgLrLqMr7frF
         jZ7/sXrCNYPogK/+ohFMy/NlW0bTZ6dNRT/FIFnee66X/ZhU1eWzEPe7CqQ21fxnvvIo
         lJWQ5fdhyFNVMMVIGukrmECNfz/6JlWWOepDnc0ODoCBVC7C7ZnSP3D81+RgzZM3r2Fa
         NCf25h2gHBexgANYvR4Vsdbt3TNddA4eotdZtqvTC+OO+NpvXmNWzvPp8l2vAs0WNGWd
         Uqsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MKa/l++NJX3mb6HDqlPH9HCmk5UKEoj8jJyL9pAVlUc=;
        b=c7IuBNDhFs5+CEc61GzoWffucc5bMzuAVw39wW4hd2/2l37lYzaQxPxyzvEShu2RU2
         BjKqIC9FBz7NcHHWYvR9n3/ucjjtEb+UpqEtCJD1+4iTCOj0ZpmsIeVtO/16i8TwGwY4
         oeCM5XyTwzqBboCN4azgmcZZUdeb1cvu9DfirRptTvRJEcDosCs60piihd5foH45vHD6
         BJ+Hs5Sc/CRWhNlnTD7BjAZlz8hhjFaQUugUMi5Patjc/v3D8zMWxcLHm+VKHmo8ppLL
         hiXx/+NxFUJNd1h1bcVDnBp1Ar/CtNy+sF8nvhEpxl8OJD5Jt1WMmNbpjVYJ54GEdSfn
         v8eg==
X-Gm-Message-State: AOAM5302iw8vhF/YSgV4mC50s+iRABbvbYbHynH30XIo/PMBOkNai597
        WpC3PUi3MznJ6e1/vqe9PmirkQ==
X-Google-Smtp-Source: ABdhPJzWB+4yLlGmmwE4dywCJsMU0wuwok6h4p35XzVgwJJe1xwVCWD/kbQ46Cz8LSqBcayxXRk5gw==
X-Received: by 2002:a17:902:868b:: with SMTP id g11mr1739808plo.9.1597910212779;
        Thu, 20 Aug 2020 00:56:52 -0700 (PDT)
Received: from localhost ([122.172.43.13])
        by smtp.gmail.com with ESMTPSA id m19sm1596343pgd.21.2020.08.20.00.56.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Aug 2020 00:56:52 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     rnayak@codeaurora.org, Viresh Kumar <vireshk@kernel.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>, sibis@codeaurora.org,
        sbhanu@codeaurora.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3 4/4] opp: Remove _dev_pm_opp_find_and_remove_table() wrapper
Date:   Thu, 20 Aug 2020 13:26:34 +0530
Message-Id: <ac1b1206c290a677921b55a4e94e18b12264208e.1597909885.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <cover.1597909885.git.viresh.kumar@linaro.org>
References: <cover.1597909885.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the unnecessary wrapper and merge
_dev_pm_opp_find_and_remove_table() with dev_pm_opp_remove_table().

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c | 21 ++++++++-------------
 drivers/opp/cpu.c  |  2 +-
 drivers/opp/of.c   |  2 +-
 drivers/opp/opp.h  |  1 -
 4 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 4edd2c3d6d91..6978b9218c6e 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -2395,7 +2395,14 @@ int dev_pm_opp_unregister_notifier(struct device *dev,
 }
 EXPORT_SYMBOL(dev_pm_opp_unregister_notifier);
 
-void _dev_pm_opp_find_and_remove_table(struct device *dev)
+/**
+ * dev_pm_opp_remove_table() - Free all OPPs associated with the device
+ * @dev:	device pointer used to lookup OPP table.
+ *
+ * Free both OPPs created using static entries present in DT and the
+ * dynamically added entries.
+ */
+void dev_pm_opp_remove_table(struct device *dev)
 {
 	struct opp_table *opp_table;
 
@@ -2420,16 +2427,4 @@ void _dev_pm_opp_find_and_remove_table(struct device *dev)
 	/* Drop reference taken while the OPP table was added */
 	dev_pm_opp_put_opp_table(opp_table);
 }
-
-/**
- * dev_pm_opp_remove_table() - Free all OPPs associated with the device
- * @dev:	device pointer used to lookup OPP table.
- *
- * Free both OPPs created using static entries present in DT and the
- * dynamically added entries.
- */
-void dev_pm_opp_remove_table(struct device *dev)
-{
-	_dev_pm_opp_find_and_remove_table(dev);
-}
 EXPORT_SYMBOL_GPL(dev_pm_opp_remove_table);
diff --git a/drivers/opp/cpu.c b/drivers/opp/cpu.c
index b5055cc886ef..5004335cf0de 100644
--- a/drivers/opp/cpu.c
+++ b/drivers/opp/cpu.c
@@ -124,7 +124,7 @@ void _dev_pm_opp_cpumask_remove_table(const struct cpumask *cpumask,
 			continue;
 		}
 
-		_dev_pm_opp_find_and_remove_table(cpu_dev);
+		dev_pm_opp_remove_table(cpu_dev);
 	}
 }
 
diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 0430290670ab..7d9d4455a59e 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -616,7 +616,7 @@ static int opp_parse_supplies(struct dev_pm_opp *opp, struct device *dev,
  */
 void dev_pm_opp_of_remove_table(struct device *dev)
 {
-	_dev_pm_opp_find_and_remove_table(dev);
+	dev_pm_opp_remove_table(dev);
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_of_remove_table);
 
diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
index 0c3de3f6db5c..78e876ec803e 100644
--- a/drivers/opp/opp.h
+++ b/drivers/opp/opp.h
@@ -217,7 +217,6 @@ void _get_opp_table_kref(struct opp_table *opp_table);
 int _get_opp_count(struct opp_table *opp_table);
 struct opp_table *_find_opp_table(struct device *dev);
 struct opp_device *_add_opp_dev(const struct device *dev, struct opp_table *opp_table);
-void _dev_pm_opp_find_and_remove_table(struct device *dev);
 struct dev_pm_opp *_opp_allocate(struct opp_table *opp_table);
 void _opp_free(struct dev_pm_opp *opp);
 int _opp_compare_key(struct dev_pm_opp *opp1, struct dev_pm_opp *opp2);
-- 
2.25.0.rc1.19.g042ed3e048af

