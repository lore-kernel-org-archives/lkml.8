Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 328C4C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 12:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02F662070A
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 12:02:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="q3fvqii+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728778AbgGTMCc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 08:02:32 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:30306 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728058AbgGTMCb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 08:02:31 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1595246550; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=queCfgOJI3AAE09b/o9QMvwXMlpczM7BLcztMQjytbU=; b=q3fvqii+vzY/Vuoc1EzdEg2zpgPkCKKKcc/glT8T0UcK/KZAhYDDIUuwWdAdYk/WQvnbN8hE
 nzBJd57eciOV+VBTijWWqZnCjZhh2Qt0cUmpmP1+/rgMUxGrqa9LJIeQpOBkwszt1UrCvIHP
 z8WH/SjvEVsK/H/OTNKswFEgmBE=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n15.prod.us-west-2.postgun.com with SMTP id
 5f1587c0cf983e60a86a734f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 20 Jul 2020 12:02:08
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E7F7AC43395; Mon, 20 Jul 2020 12:02:07 +0000 (UTC)
Received: from blr-ubuntu-173.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 862B1C433CA;
        Mon, 20 Jul 2020 12:02:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 862B1C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
From:   Rajendra Nayak <rnayak@codeaurora.org>
To:     robdclark@gmail.com, sean@poorly.run
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH] drm/msm: dsi: dev_pm_opp_put_clkname() only when an opp_table exists
Date:   Mon, 20 Jul 2020 17:31:49 +0530
Message-Id: <1595246509-6584-1-git-send-email-rnayak@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Its possible for msm_dsi_host_init() to fail early, before
dev_pm_opp_set_clkname() is called. In such cases, unconditionally
calling dev_pm_opp_put_clkname() in msm_dsi_host_destroy() results
in a crash. Put an additional check so that dev_pm_opp_put_clkname()
is called only when an opp_table exists.

Fixes: f99131fa7a23 ("drm/msm: dsi: Use OPP API to set clk/perf state")
Reported-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
---
 drivers/gpu/drm/msm/dsi/dsi_host.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
index 0a14c4a..4f580f7 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_host.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
@@ -1936,7 +1936,8 @@ void msm_dsi_host_destroy(struct mipi_dsi_host *host)
 
 	if (msm_host->has_opp_table)
 		dev_pm_opp_of_remove_table(&msm_host->pdev->dev);
-	dev_pm_opp_put_clkname(msm_host->opp_table);
+	if (msm_host->opp_table)
+		dev_pm_opp_put_clkname(msm_host->opp_table);
 	pm_runtime_disable(&msm_host->pdev->dev);
 }
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

