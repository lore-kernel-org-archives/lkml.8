Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EEEAC433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 23:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5733B20758
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 23:43:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Si7LqGms"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbgIBXnc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 19:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbgIBXn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 19:43:27 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16E29C061244
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 16:43:27 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id d22so677376pfn.5
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 16:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5PQLZP1Qz8JxBBrCvH3ODAjxLepZmxXcyVpXcrB89bk=;
        b=Si7LqGmssihn3d3s2I9Mo4GuAzBWNq77GAdmQUcK+JZNwW1IUQBFf3DntrMWGys0DA
         EJRmR/3bJ6BI5hyFGpR1ebZu6+Bqo+GgQEwf2kPNfGD7RJa+rshcYDBmXSUNL+9W9DX/
         w05LDlIC+77MlkeTr0iT2NnOzP9cQdv2T2+Ms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5PQLZP1Qz8JxBBrCvH3ODAjxLepZmxXcyVpXcrB89bk=;
        b=dxqotwJDyvdFFs3SlzkDCOhE1ECcStbQEp6PkCOyJyTSMiNWb15urs4ZbZ3VBhBgQx
         NqdzbDhv5XgM3B9QdgZ5UnQ1mdIyXST8dlOAByUFNV3/4gkNRVfTOjQHM9gYQrCifLEP
         uGVZBWC95ZSo+LP90XQOnj9GuFXu61R6LwNmsn7PCOvpB2tj/g2GKlZFEobbs0DH917n
         hzxGm1a2cCtrPE/g1KWSQCuSmlUyHah+W47U1ECPDh+9eChH1saJigzL3UE4/RL/1HTp
         jNU+vnQWTSLBaX8D+rQaG9o08l22AYlA0G5/rmoPo1JRW8FXYZMs863d5QAgEG8x/6xd
         kYlQ==
X-Gm-Message-State: AOAM530+KKIv5YYcUoWbgXOJIuRENwPKn7qnsRqg3XM8qOSM/EtSoruh
        sdc3qPIkCaJ7B5aMGJSNvOyQvA==
X-Google-Smtp-Source: ABdhPJyB+KmcwqeuAkYJZdNtmNa+iUiP8ezkepEkp25WOfYRYpBfVNpPZLgP0MZ78ERRcgKely0bxQ==
X-Received: by 2002:a62:cdc2:: with SMTP id o185mr809740pfg.170.1599090205522;
        Wed, 02 Sep 2020 16:43:25 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:42b0:34ff:fe3d:58e6])
        by smtp.gmail.com with ESMTPSA id q2sm426284pgh.48.2020.09.02.16.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2020 16:43:24 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     vbadigan@codeaurora.org, Douglas Anderson <dianders@chromium.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
Subject: [PATCH] mmc: sdhci-msm: Prefer asynchronous probe
Date:   Wed,  2 Sep 2020 16:43:15 -0700
Message-Id: <20200902164303.1.I5e598a25222b4534c0083b61dbfa4e0e76f66171@changeid>
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Turning on initcall debug on one system showed this:
  initcall sdhci_msm_driver_init+0x0/0x28 returned 0 after 34782 usecs

The lion's share of this time (~33 ms) was in mmc_power_up().  This
shouldn't be terribly surprising since there are a few calls to delay
based on "power_delay_ms" and the default delay there is 10 ms.

Because we haven't specified that we'd prefer asynchronous probe for
this driver then we'll wait for this driver to finish before we start
probes for more drivers.  While 33 ms doesn't sound like tons, every
little bit counts.

There should be little problem with turning on asynchronous probe for
this driver.  It's already possible that previous drivers may have
turned on asynchronous probe so we might already have other things
(that probed before us) probing at the same time we are anyway.  This
driver isn't really providing resources (clocks, regulators, etc) that
other drivers need to probe and even if it was they should be handling
-EPROBE_DEFER.

Let's turn this on and get a bit of boot speed back.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/mmc/host/sdhci-msm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index d4c02884cca8..9dd0dbb65382 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -2542,6 +2542,7 @@ static struct platform_driver sdhci_msm_driver = {
 		   .name = "sdhci_msm",
 		   .of_match_table = sdhci_msm_dt_match,
 		   .pm = &sdhci_msm_pm_ops,
+		   .probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 };
 
-- 
2.28.0.402.g5ffc5be6b7-goog

