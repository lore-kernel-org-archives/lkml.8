Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F028C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 20:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E08221532
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 20:17:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PEF9ZsRV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728849AbgGGURM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 16:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728737AbgGGURH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 16:17:07 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C8D7C08C5DC
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 13:17:07 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id u18so3593812pfk.10
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 13:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZILeJ5BZkm/uJN5KrFNC9NBv85e8cyhdlG5Nb7NnKfw=;
        b=PEF9ZsRVchuRojCnoBR189XtTxSFN3+B4mXytX4tqxHyuQjt7rNIqVM/5BqhKAiMKh
         A2oE6hV+YU5K4Hk1Sem4UY+19X1f9l8eR7ZUDwqxDcGgGI1bWo0smuHyvggB7E52zjg8
         l17phmDc8cnnnKqPaM9NuguL7F1EBwKFpbxrM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZILeJ5BZkm/uJN5KrFNC9NBv85e8cyhdlG5Nb7NnKfw=;
        b=NKSyZfi4lBSQyBksjc/9p38kShNMVAX7V+0nzrBWHdwfFEwit6YIaOWk5BmT3MWq5x
         v8fBCIJh6cScTwrJMtKGBy986QAR+jgA2AhjSi7YW/1Yk0vkOf2S4dC/rFSGBRP3c/1g
         0++t7S/uKBCk83ocpyrcTEFsBqmVDKUrWqqQJfHwRBV5/yPzeeTohi/WwXf5i/3pHgfR
         cT5A09poAFs9XeSPkMU6/r833CtP3bNsvkU0jlPmjZ/sQACN5rxV2+c444TXgZHFyjg4
         cO1TUBuqMRmQQY7T6uuwRwkVjVsWrXiCkK3q3PNH6K+SgwodFKx7RB+jgKi8CbByu8wS
         JY3g==
X-Gm-Message-State: AOAM531UUcwQGyzAYalhcqtLIs1eJDNcATFuGlMlr1rkDZECXA/wl+TR
        jr3R7+G/fYNTJdBtS+8RqjycOZMIhV0=
X-Google-Smtp-Source: ABdhPJyzC6YhrCBBgLE/o37IuvPm7JwXJTU/H5+6wIN27ryUkGCqJ6FXjj4v1rsz8wks0fFAxQXGRA==
X-Received: by 2002:aa7:9575:: with SMTP id x21mr49762878pfq.140.1594153027176;
        Tue, 07 Jul 2020 13:17:07 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:42b0:34ff:fe3d:58e6])
        by smtp.gmail.com with ESMTPSA id i23sm7166097pfq.206.2020.07.07.13.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 13:17:06 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Mark Brown <broonie@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     mka@chromium.org, Akash Asthana <akashast@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>, swboyd@chromium.org,
        linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org,
        ctheegal@codeaurora.org, mkshah@codeaurora.org,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: [PATCH 2/2] spi: spi-qcom-qspi: Set an autosuspend delay of 250 ms
Date:   Tue,  7 Jul 2020 13:16:41 -0700
Message-Id: <20200707131607.2.I3c56d655737c89bd9b766567a04b0854db1a4152@changeid>
X-Mailer: git-send-email 2.27.0.383.g050319c2ae-goog
In-Reply-To: <20200707201641.2030532-1-dianders@chromium.org>
References: <20200707201641.2030532-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit cff80645d6d3 ("spi: spi-qcom-qspi: Add interconnect support")
the spi_geni_runtime_suspend() and spi_geni_runtime_resume()
became a bit slower.  Measuring on my hardware I see numbers in the
hundreds of microseconds now.

Let's use autosuspend to help avoid some of the overhead.  Now if
we're doing a bunch of transfers we won't need to be constantly
chruning.

The number 250 ms for the autosuspend delay was picked a bit
arbitrarily, so if someone has measurements showing a better value we
could easily change this.

Fixes: cff80645d6d3 ("spi: spi-qcom-qspi: Add interconnect support")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
This patch could go through the SPI tree or land in the Qualcomm tree.
The patch it Fixes is currently in the Qualcomm tree so if it lands in
the main SPI tree there'd be a bit of a perf regression in the
Qualcomm tree until things merge together in mainline.

 drivers/spi/spi-qcom-qspi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-qcom-qspi.c b/drivers/spi/spi-qcom-qspi.c
index 322b88c22a86..6c39b23222b8 100644
--- a/drivers/spi/spi-qcom-qspi.c
+++ b/drivers/spi/spi-qcom-qspi.c
@@ -553,6 +553,8 @@ static int qcom_qspi_probe(struct platform_device *pdev)
 		goto exit_probe_master_put;
 	}
 
+	pm_runtime_use_autosuspend(dev);
+	pm_runtime_set_autosuspend_delay(dev, 250);
 	pm_runtime_enable(dev);
 
 	ret = spi_register_master(master);
-- 
2.27.0.383.g050319c2ae-goog

