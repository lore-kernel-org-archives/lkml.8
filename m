Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D8D5C54FD0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 15:54:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 381EF20776
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 15:54:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ierhYQVQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728759AbgDXPyd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 11:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbgDXPyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 11:54:19 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 346B9C09B046
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 08:54:18 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id g13so11456544wrb.8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 08:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ANWXN+2Z3DDrWrVHhsInrxi4EvXPY/8IIalTrvooHG8=;
        b=ierhYQVQtu+peHFc42kGYjWb//BJX4HxUct5NT4NbIFrjxEH8CyvRdBn6tFBhqOmmb
         UZ9Z4We6ymLhwC+k6u7kLuDxlPVFOOQGvlAk+jPhjmdbCbjYVkCTzKw5zVCT4WE1l3l+
         swhcNCjbycHGW70kjoSWISiktdL9x1hDHAk6tBNdNnJsxMGQ4uEldlTRgEQh5IyTb5+U
         SM8pwVGCpglmLCRaWndJSlE80A10xg6vjnApxIpGL5/9aPpXdgx8QawNiSoyVf1jfWjp
         lXs+QzmVRTk35lbTdx27DwApHTGihQQBam8yyp/jRZk32rizTuYPTdWUu6rc46nUFTTk
         o51Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ANWXN+2Z3DDrWrVHhsInrxi4EvXPY/8IIalTrvooHG8=;
        b=BRC7fZllEccqZ8O/qQFgI2oe9Q6dpm3/YViZX7ojUMssHmvGbSygD1Z8RAQVXcFqBU
         cAazeLwr9O/6ZYsnWElomxY+EExI1cuj3fO3s6+DPj4qsQLoE0ao8G+lLFKwlO5j30QG
         G8eLbsre/JFBX3f/MQVZj8KOpt8BK8lM3HU/OINsAdlcoxeVMIurvj0w1vdGbH5/lpCp
         Orz8G+h5CAGRyqs+Dd/il9IJyZ+tbDtKLCuhcNP+2BrJQGLaK9hMya8n25+EdW6cqRM5
         v581sQ6NYSPN3AUygWPdYuAp0CZfdYXp6ndy/DAGN5ShVRPWm7+tnTwKYOMbhzP5fHhq
         eVkg==
X-Gm-Message-State: AGi0Pua1Q6Qf226bde+p/X/Exq5qz6Df4K/6xqquwjotdOw3YC+pRMeA
        2um/6QRp9Pj/dLwwU8i1kq94cw==
X-Google-Smtp-Source: APiQypKrt1I/vfpXrZmkPsz9dzLuK18NN6O8r2S9WWku5sLnMIaDkgNIXVxKYk9wDEbtIfT8TGH1QA==
X-Received: by 2002:adf:c109:: with SMTP id r9mr11837240wre.265.1587743656909;
        Fri, 24 Apr 2020 08:54:16 -0700 (PDT)
Received: from localhost.localdomain ([87.120.218.65])
        by smtp.googlemail.com with ESMTPSA id z76sm3923583wmc.9.2020.04.24.08.54.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Apr 2020 08:54:16 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        robh+dt@kernel.org, rjw@rjwysocki.net, saravanak@google.com,
        sibis@codeaurora.org
Cc:     rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        vincent.guittot@linaro.org, jcrouse@codeaurora.org,
        evgreen@chromium.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        georgi.djakov@linaro.org
Subject: [PATCH v7 7/7] cpufreq: dt: Add support for interconnect bandwidth scaling
Date:   Fri, 24 Apr 2020 18:54:04 +0300
Message-Id: <20200424155404.10746-8-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200424155404.10746-1-georgi.djakov@linaro.org>
References: <20200424155404.10746-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In addition to clocks and regulators, some devices can scale the bandwidth
of their on-chip interconnect - for example between CPU and DDR memory. Add
support for that, so that platforms which support it can make use of it.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
v7:
* Drop using dev_pm_opp_set_paths(), as it has been removed.
* Add Kconfig dependency on INTERCONNECT, as it can be module.


v2: https://lore.kernel.org/r/20190423132823.7915-6-georgi.djakov@linaro.org

 drivers/cpufreq/Kconfig      |  1 +
 drivers/cpufreq/cpufreq-dt.c | 15 +++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
index c3e6bd59e920..db2ad54ee67f 100644
--- a/drivers/cpufreq/Kconfig
+++ b/drivers/cpufreq/Kconfig
@@ -217,6 +217,7 @@ config CPUFREQ_DT
 
 config CPUFREQ_DT_PLATDEV
 	bool
+	depends on INTERCONNECT || !INTERCONNECT
 	help
 	  This adds a generic DT based cpufreq platdev driver for frequency
 	  management.  This creates a 'cpufreq-dt' platform device, on the
diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index 26fe8dfb9ce6..4ecef3257532 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -13,6 +13,7 @@
 #include <linux/cpufreq.h>
 #include <linux/cpumask.h>
 #include <linux/err.h>
+#include <linux/interconnect.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/pm_opp.h>
@@ -95,6 +96,7 @@ static int resources_available(void)
 	struct device *cpu_dev;
 	struct regulator *cpu_reg;
 	struct clk *cpu_clk;
+	struct icc_path *cpu_path;
 	int ret = 0;
 	const char *name;
 
@@ -121,6 +123,19 @@ static int resources_available(void)
 
 	clk_put(cpu_clk);
 
+	cpu_path = of_icc_get(cpu_dev, NULL);
+	ret = PTR_ERR_OR_ZERO(cpu_path);
+	if (ret) {
+		if (ret == -EPROBE_DEFER)
+			dev_dbg(cpu_dev, "defer icc path: %d\n", ret);
+		else
+			dev_err(cpu_dev, "failed to get icc path: %d\n", ret);
+
+		return ret;
+	}
+
+	icc_put(cpu_path);
+
 	name = find_supply_name(cpu_dev);
 	/* Platform doesn't require regulator */
 	if (!name)
