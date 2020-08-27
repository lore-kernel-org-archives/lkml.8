Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E44C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 15:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 402D52177B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 15:33:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BkSNnJtZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727964AbgH0Pdn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 11:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727827AbgH0Pdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 11:33:41 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB561C061233
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 08:33:40 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id o13so3640308pgf.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 08:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CLogCY9snthkks89Ea8CnKQB+BmwpQEsk4ur1DM2HdU=;
        b=BkSNnJtZWr1nebAVtZFleChfEIZX1Ul2Ahd6LQna22QOuwjvS4znFuCi9Rk5uCwoAo
         wsweWskmO00ZS9A+jlYlaoiiuhf1RG6P3uYkNM+xWSd6b++ZfHGc5fkClqFv1mH8aEUK
         nlb5HA7p159z1jRabNuNV/qxS6WRAP55aadI8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CLogCY9snthkks89Ea8CnKQB+BmwpQEsk4ur1DM2HdU=;
        b=Au1V0uuahXhtgEf2DKwhb/Njh9lsOPehhOJc5QrrFD1Fnuao8HWDjZWTDqsA6824X5
         2AWn7fQ+J9MkmxB3um8KqhsnympX5OcWMjR4GxezTvuxEMRS79p8hcAM5bUSEQiTjNdf
         7ULJUglXNMCUNIWfrqD4K6AdxLshRem/TE6rbvaYmsfhp77/lzCvRLpJL/jgxWLIKEk7
         e0/p1tjOiAMsgU7Ly9osVEiV1v33+GjYibtfHXjHw1mbJMGk3h5XhaV9BooCD58oTmwN
         qTmAR1KLgU9Oy20ObnT9xfJX0jZczjrrw/iFJAe/gAgZ465ZGAM659PtcZY51LiaFZXd
         5y0Q==
X-Gm-Message-State: AOAM532E76a03Z7CKgyELxASpeEJUOtiP/trURr18Oz5MztqjHZM1e/p
        XCP2akj/OsLzvpVqo1kQVKDxTQ==
X-Google-Smtp-Source: ABdhPJwbYpqy+gzLGlY7DU9mHynPfbjLpramh455uzAwuYGrfuMQFSgWKylzRDRhuQdd5ch+5tlRkg==
X-Received: by 2002:a65:52c5:: with SMTP id z5mr15387187pgp.105.1598542419246;
        Thu, 27 Aug 2020 08:33:39 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:42b0:34ff:fe3d:58e6])
        by smtp.gmail.com with ESMTPSA id y7sm3192105pfm.68.2020.08.27.08.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 08:33:38 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     arnd@arndb.de, naresh.kamboju@linaro.org, vbadigan@codeaurora.org,
        rnayak@codeaurora.org, Douglas Anderson <dianders@chromium.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
Subject: [PATCH] mmc: sdhci-msm: When dev_pm_opp_of_add_table() returns 0 it's not an error
Date:   Thu, 27 Aug 2020 08:33:34 -0700
Message-Id: <20200827083330.1.I669bb4dc3d92bd04e9a695f97904797dc8241b79@changeid>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit d05a7238fe1c ("mmc: sdhci-msm: Unconditionally call
dev_pm_opp_of_remove_table()") works fine in the case where there is
no OPP table.  However, if there is an OPP table then
dev_pm_opp_of_add_table() will return 0.  Since 0 != -ENODEV then the
"if (ret != -ENODEV)" will evaluate to true and we'll fall into the
error case.  Oops.

Let's fix this.

Fixes: d05a7238fe1c ("mmc: sdhci-msm: Unconditionally call dev_pm_opp_of_remove_table()")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/mmc/host/sdhci-msm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index b7e47107a31a..55101dba42bd 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -2284,7 +2284,7 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 
 	/* OPP table is optional */
 	ret = dev_pm_opp_of_add_table(&pdev->dev);
-	if (ret != -ENODEV) {
+	if (ret && ret != -ENODEV) {
 		dev_err(&pdev->dev, "Invalid OPP table in Device tree\n");
 		goto opp_cleanup;
 	}
-- 
2.28.0.297.g1956fa8f8d-goog

