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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20888C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 15:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4BD620707
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 15:41:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HcOa46Bg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbgH0PlT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 11:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbgH0PlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 11:41:18 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33459C06121B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 08:41:18 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id u20so3821779pfn.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 08:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KAAg1wT74J1TPJUNvinItqB9ZDfNPLN786c1MlpJyJo=;
        b=HcOa46BgqN+2jqdrRcLqoGUNKCWiiC56FiwTZkCLIJQpGgLTSezUDkrs6g3rH3dvkK
         baaNuoyYgOtHoDWGgn9cwl83bP/Y7T+B2ksAhCsEj7XV98ZLGFv7t6Vailve/m+yykIn
         y/hJA/+Drd7ckQF7iuIEATvkgCIyNClTwOeGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KAAg1wT74J1TPJUNvinItqB9ZDfNPLN786c1MlpJyJo=;
        b=YOu3INUegnT1rnr31pq3GX/tK3qAlE61+v3SOqrSDBFJLFYZLiW2rcSCCAGbdeq6eL
         +MVuDabtH6iOHmaYAMe/krZHx5+y8lFigqM6COH8/yxH9tp4qEb6zy79YwpHiOpSqRWr
         v8BnY0sPlSQcdcnYljJFaWPG3TLvAVruKAg2beB49TsVwpkpFhvreHa8Z6ivY5p92YCR
         wNJBn4mutfMXFMnVWLCxrW/OFaLWUNxg8vUvFeQbDX8qlSXKiOP15wxJiPnZeA1Xb5Ov
         x/BJOT7sD5/dHfTLytxY6PnqBa3V5uo7oV1R/ESJvpTb4OuCiluu4AiG0+ENMkyrvpQr
         jp9w==
X-Gm-Message-State: AOAM533//DWt0diHNw7reUQb52UkJ8QB2mUg6BxhYCWpTVt6eurgIljH
        1uUGzrrRcxsL8Hbisc7t4drUrA==
X-Google-Smtp-Source: ABdhPJxt8TMgiAOegn4WkDsoSiNkpDn4sIcrWZ/XR6jPZbmFJWUQipH2JkHFxL3Vln+YLYuqX3HtXw==
X-Received: by 2002:a63:7018:: with SMTP id l24mr14452680pgc.55.1598542877503;
        Thu, 27 Aug 2020 08:41:17 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:42b0:34ff:fe3d:58e6])
        by smtp.gmail.com with ESMTPSA id q34sm2642066pgl.28.2020.08.27.08.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 08:41:17 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     vbadigan@codeaurora.org, Douglas Anderson <dianders@chromium.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
Subject: [PATCH] mmc: sdhci-msm: We need to restore_dll_config for sc7180
Date:   Thu, 27 Aug 2020 08:41:05 -0700
Message-Id: <20200827084102.1.I7a5f56b411071eeecae84b7e33981d39170ccf2a@changeid>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Although sc7180 is supposed to have a hardware fix that means that we
don't have to restore the DLL config like we did with sdm845,
apparently the hardware fix doesn't work in all cases.  Until it's
understood under exactly which cases we the hardware fix malfunctions,
let's go back to restoring the DLL config whenever we do runtime
resume.  This is safe and gets things working again.

NOTE: we don't need to introduce a whole new "struct
sdhci_msm_variant_info" for sc7180 since it would be exactly the same
as the sdm845 one.  We'll just refer to that one.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/mmc/host/sdhci-msm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index b7e47107a31a..a88db3f376bd 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -2148,6 +2148,7 @@ static const struct sdhci_msm_variant_info sm8250_sdhci_var = {
 static const struct of_device_id sdhci_msm_dt_match[] = {
 	{.compatible = "qcom,sdhci-msm-v4", .data = &sdhci_msm_mci_var},
 	{.compatible = "qcom,sdhci-msm-v5", .data = &sdhci_msm_v5_var},
+	{.compatible = "qcom,sc7180-sdhci", .data = &sdm845_sdhci_var},
 	{.compatible = "qcom,sdm845-sdhci", .data = &sdm845_sdhci_var},
 	{.compatible = "qcom,sm8250-sdhci", .data = &sm8250_sdhci_var},
 	{},
-- 
2.28.0.297.g1956fa8f8d-goog

