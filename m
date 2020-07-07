Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73366C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 21:31:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D7D220771
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 21:31:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y0V7o8t1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729286AbgGGVbU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 17:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729244AbgGGVbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 17:31:17 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E10C08C5DC
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 14:31:17 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id a14so14404850pfi.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 14:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UOLpDhUaI5YvggRlgo01SV+Tf6RdV3ahOTchedkHuLg=;
        b=Y0V7o8t1H3YTMhZ4TUkXy4GVXShzOzSWSy21TEMMRnDoyvbmw6ulB1nneFGbHQhnWb
         RPVS9cocqmq+TNSkG85TTyWEE2Jvhr0FOaNEuLMKvEBOgGqwAlIFCiRO7P5+6MoaL0uG
         8HCWa1qK/+LHGT/He2W6vUvyrI5u6qTLp9zkVr2okLWa6liHBbcNigt79AIfQuEjqrz9
         f47iVafujZXEtxF8vZ/fxYccBGemuFiWA7z5Fz3BZrXY9fHSYHZMgl+R0P0dIibDlRjr
         jlyASpnXRxua+C8hzcs+DmecRTXzjtjJ0Lv9LRe42PI1qGOJJmnGRl+snWS1dAD9h+Jj
         Lf8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UOLpDhUaI5YvggRlgo01SV+Tf6RdV3ahOTchedkHuLg=;
        b=jhjGN11YrITNBN4uz4RTnIAJ2+WqFEHWSw2SIHIvkswh6gLX5lb8q+uifV3on70UKj
         IjCK311Mklq0t14pi18OmUO1IdhMrPRm9eYXXPvzN3/YG4PvO13ng0jUJ1bEyjoEhLha
         RnyHkLISzxzfRAE51f1wHXxmUGWCYrrzlpfQB8B9z+piRR90VPu7en0ndXrsyVNk2WyW
         Ef+ZsHTJ1QbI/olysF6lRWKYWJxaoj7IU8SWyjDshWGaGpISXedwvB37JDbAcFVU1+Sj
         ZuLVJzrVp2IThATYfrIV4Eb8bcx60l7TJqNlEmHY/RupCjDJgIe88xejtbormROtLY0X
         ZFvQ==
X-Gm-Message-State: AOAM532lUnDRAMiaHJiGtRbOBDMM6C4d3FBm/DtEFE2I38E6WDBcmR5B
        M8ksvXjTWcqcAzPdP3sOHEYdfw==
X-Google-Smtp-Source: ABdhPJw484OOouijNAC2XAXKCPThV6Q8AEvN1qz4ZshbZhJQxomJ//VywcwrkYKw9PtyBst7CC9J8g==
X-Received: by 2002:aa7:9a92:: with SMTP id w18mr7887844pfi.233.1594157476994;
        Tue, 07 Jul 2020 14:31:16 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id o128sm23560832pfg.127.2020.07.07.14.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 14:31:16 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, loic.pallardy@st.com,
        arnaud.pouliquen@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v5 02/11] remoteproc: stm32: Request IRQ with platform device
Date:   Tue,  7 Jul 2020 15:31:03 -0600
Message-Id: <20200707213112.928383-3-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200707213112.928383-1-mathieu.poirier@linaro.org>
References: <20200707213112.928383-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Request IRQ with platform device rather than remote proc in order to
call stm32_rproc_parse_dt() before rproc_alloc().  That way we can
know whether we need to synchronise with the MCU or not.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Loic Pallardy <loic.pallardy@st.com>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/remoteproc/stm32_rproc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32_rproc.c
index 2973ba201c1d..c00f60d42ab6 100644
--- a/drivers/remoteproc/stm32_rproc.c
+++ b/drivers/remoteproc/stm32_rproc.c
@@ -262,7 +262,8 @@ static int stm32_rproc_parse_fw(struct rproc *rproc, const struct firmware *fw)
 
 static irqreturn_t stm32_rproc_wdg(int irq, void *data)
 {
-	struct rproc *rproc = data;
+	struct platform_device *pdev = data;
+	struct rproc *rproc = platform_get_drvdata(pdev);
 
 	rproc_report_crash(rproc, RPROC_WATCHDOG);
 
@@ -554,7 +555,7 @@ static int stm32_rproc_parse_dt(struct platform_device *pdev)
 
 	if (irq > 0) {
 		err = devm_request_irq(dev, irq, stm32_rproc_wdg, 0,
-				       dev_name(dev), rproc);
+				       dev_name(dev), pdev);
 		if (err) {
 			dev_err(dev, "failed to request wdg irq\n");
 			return err;
-- 
2.25.1

