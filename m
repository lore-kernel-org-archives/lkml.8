Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C863AC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B12E21556
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:10:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x5/6z0oM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730569AbgIIQKl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 12:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730588AbgIIQHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 12:07:55 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 114ECC061369
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 07:12:04 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id l126so2276992pfd.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 07:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QEpsLMY/SzXPuKyd94ggDGQBM1KAJawGy/J+J7m+TbM=;
        b=x5/6z0oMFgBrDNTOE56l/HJqO2aTwjfjoshWHmkKERda91T4n+E4jltXDNGvp39j5m
         rhZJBpvky0khJwsP9tjvtfns5MaCTeqq//9eqwJ65H+KOW5edNOfJejeAmd0nbkPosam
         EGXc3U3xvAlN+UrjDnqy2CWOfK83GxFuXrLwsUyU/Du7Bjz0usbzz+PGvFjMumqUz44O
         3HqD2u2pM/vQ6gSW4R2b1XFoC3raAOYcQpqu5zvXgHSQY3/v+D42dFAeTgYZEH0N52Uq
         vvltyYvWZTOWzqaMHWPmST62gS5CurJ9d4o44UL+npL5lJBdyuqD6mMYdn41nBbVKbtF
         zuag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QEpsLMY/SzXPuKyd94ggDGQBM1KAJawGy/J+J7m+TbM=;
        b=ls8ex2TL1GZ12OEQbbWF7VVPbS0RdIEPnj+kMiR+0GxHtfy2H2B/aPKORbpXI0A5hQ
         v0IBaKFR1Tx0QA+hR2s8Nos7G5GZB3sxDbiKlWbcCzC1Bfc8fz/P/6yOnLOhLNqrgUT8
         2Hw6b27iTMB29NUZO7hNrjK2t+It+B167/e5uqy9V5uXlSLrpaNSYvEsuRuvyMqAiBBu
         oRbYWW4odP+FjRbgYZqej8Hg9w9CLsKc5a+4j71rGlytzmfBSvB27aqOpsXn2lMgaF7G
         FMonUE1VmmVYR0xtB2I5ePARqFtSukM833WFHQYmegQ8Txg4/PyuQyZs+KEBzHS3Zp5D
         vbwg==
X-Gm-Message-State: AOAM532Y9ZUoiWnPB54wwIC7s7Nud3V0rkEDn98CnR3HSQZm0SvuZ3s6
        24U9lj0Pon2q1OXATKpEVtcafg==
X-Google-Smtp-Source: ABdhPJzO5eLyiP0IbrquTJ2zVRcTiM/Yj6JzZ0urfYY4aED3CS9F/9RjcGXeqX0eB5yE1hS7Ikupgg==
X-Received: by 2002:a63:64c2:: with SMTP id y185mr764751pgb.125.1599660723422;
        Wed, 09 Sep 2020 07:12:03 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id s20sm3003970pfu.112.2020.09.09.07.12.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Sep 2020 07:12:02 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        naresh.kamboju@linaro.org, anders.roxell@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 resend] mmc: sdhci-msm: Unconditionally call dev_pm_opp_of_remove_table()
Date:   Wed,  9 Sep 2020 19:41:53 +0530
Message-Id: <890ae5601594fca5de104695a682f4b6efbc631b.1599660554.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dev_pm_opp_of_remove_table() doesn't report any errors when it fails to
find the OPP table with error -ENODEV (i.e. OPP table not present for
the device). And we can call dev_pm_opp_of_remove_table()
unconditionally here.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

---
V2:
- Compare with -ENODEV only for failures.
- Create new label to put clkname.
- Based on 5.9-rc4
---
 drivers/mmc/host/sdhci-msm.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 5a33389037cd..f7beaec6412e 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -263,7 +263,6 @@ struct sdhci_msm_host {
 	unsigned long clk_rate;
 	struct mmc_host *mmc;
 	struct opp_table *opp_table;
-	bool has_opp_table;
 	bool use_14lpp_dll_reset;
 	bool tuning_done;
 	bool calibration_done;
@@ -2285,11 +2284,9 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 
 	/* OPP table is optional */
 	ret = dev_pm_opp_of_add_table(&pdev->dev);
-	if (!ret) {
-		msm_host->has_opp_table = true;
-	} else if (ret != -ENODEV) {
+	if (ret && ret != -ENODEV) {
 		dev_err(&pdev->dev, "Invalid OPP table in Device tree\n");
-		goto opp_cleanup;
+		goto opp_put_clkname;
 	}
 
 	/* Vote for maximum clock rate for maximum performance */
@@ -2453,8 +2450,8 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 	clk_bulk_disable_unprepare(ARRAY_SIZE(msm_host->bulk_clks),
 				   msm_host->bulk_clks);
 opp_cleanup:
-	if (msm_host->has_opp_table)
-		dev_pm_opp_of_remove_table(&pdev->dev);
+	dev_pm_opp_of_remove_table(&pdev->dev);
+opp_put_clkname:
 	dev_pm_opp_put_clkname(msm_host->opp_table);
 bus_clk_disable:
 	if (!IS_ERR(msm_host->bus_clk))
@@ -2474,8 +2471,7 @@ static int sdhci_msm_remove(struct platform_device *pdev)
 
 	sdhci_remove_host(host, dead);
 
-	if (msm_host->has_opp_table)
-		dev_pm_opp_of_remove_table(&pdev->dev);
+	dev_pm_opp_of_remove_table(&pdev->dev);
 	dev_pm_opp_put_clkname(msm_host->opp_table);
 	pm_runtime_get_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-- 
2.25.0.rc1.19.g042ed3e048af

