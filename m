Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CE97C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 14:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4413920767
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 14:52:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WkTWta+y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728006AbgGIOwF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 10:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbgGIOwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 10:52:01 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 439CCC08E6DC
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 07:52:01 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id p3so1087403pgh.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 07:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wCNwMOLhre6TIcq+xE46mgH66EUQUlkzmi0iFanIr+c=;
        b=WkTWta+ygkvsjDeZrol+0SHhzLZKtwtnb673F6gAaZMkqleJ8hiEXTNVtZz0D5wm35
         HIiDkEuL8lED8JHA1IRt2pWRlS0BU4poa+UoVJ9MFyPpuYrBGbwLf3DtpNv0iflVbEyW
         RL/AP0progn0ni332mJbpS8NZX0+9QA5viaQI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wCNwMOLhre6TIcq+xE46mgH66EUQUlkzmi0iFanIr+c=;
        b=ihUnDDxSwFAJpzmdZaVT5Mc7/h2OVFuMwriwaYWoJ8b7/vq8uHmYvbb/xtl5NfwHz9
         i7GlTEcLfaO+ZTgZ1MwWYbWeRMoLEPHl6DkdDrMoWSuPo2zwvaPb0/xPbQUcfkdQ5pzS
         pz7gheDKm8XlCZcgKEdUmFuLGI03ODt38N8UEJMJaAUSUXSeiz2UxqLBEOvvBJHOt2Gh
         NP+1ntcQVxYeCxTgdihNp/ocLCFV4Ca2MDtmvrnswjyazYSW290kMRQUxTGutGVXKVdS
         wgF8keNUZSWyzqTLr7twT2Ygj7YP+5yeiY/FwwTdncvlXc3uanZuN8QHSt5+jdZQ5TkO
         t50w==
X-Gm-Message-State: AOAM533PUiEyJ5C2+KPlOpsQUzzSFJc3CVMXmimF0fkazRCtEj6A/9Nt
        jbnUcVDE4IjUzZZw2mx8QiTdfw==
X-Google-Smtp-Source: ABdhPJxldIWJwLmpIX2peiSkmv54/xjNeufkBsdu52lnXuDQk24y73KFZqffxuh+HiL7VvA/bCniyg==
X-Received: by 2002:aa7:8ac3:: with SMTP id b3mr61856209pfd.45.1594306320783;
        Thu, 09 Jul 2020 07:52:00 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:42b0:34ff:fe3d:58e6])
        by smtp.gmail.com with ESMTPSA id m1sm2791322pjy.0.2020.07.09.07.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 07:52:00 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Mark Brown <broonie@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     swboyd@chromium.org, linux-arm-msm@vger.kernel.org,
        ctheegal@codeaurora.org, mkshah@codeaurora.org, mka@chromium.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        akashast@codeaurora.org, georgi.djakov@linaro.org,
        Douglas Anderson <dianders@chromium.org>,
        Mukesh Kumar Savaliya <msavaliy@codeaurora.org>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: [PATCH v2 2/2] spi: spi-qcom-qspi: Set an autosuspend delay of 250 ms
Date:   Thu,  9 Jul 2020 07:51:45 -0700
Message-Id: <20200709075113.v2.2.I3c56d655737c89bd9b766567a04b0854db1a4152@changeid>
X-Mailer: git-send-email 2.27.0.383.g050319c2ae-goog
In-Reply-To: <20200709145145.4055619-1-dianders@chromium.org>
References: <20200709145145.4055619-1-dianders@chromium.org>
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
Acked-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Rajendra Nayak <rnayak@codeaurora.org>
Tested-by: Rajendra Nayak <rnayak@codeaurora.org>
Reviewed-by: Mukesh Kumar Savaliya <msavaliy@codeaurora.org>
---
This patch could go through the SPI tree or land in the Qualcomm tree.
The patch it Fixes is currently in the Qualcomm tree so if it lands in
the main SPI tree there'd be a bit of a perf regression in the
Qualcomm tree until things merge together in mainline.

Changes in v2: None

 drivers/spi/spi-qcom-qspi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-qcom-qspi.c b/drivers/spi/spi-qcom-qspi.c
index 8fedc605ab7f..b8857a97f40a 100644
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

