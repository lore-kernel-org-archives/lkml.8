Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 731B3C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 12:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5057B2080D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 12:21:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="ok0JDRix"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728788AbgGTMVs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 08:21:48 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:60894 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728460AbgGTMVr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 08:21:47 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1595247707; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=GDx0nZdKB25CRIUyjKxQQDbAK/QAtU1kBJYtFizHoOM=; b=ok0JDRixPb88LL+tXmg+BfCITQZs4tLbSjRqOR5nutj10N2WCpc+n7kI/Hp9Fwm7u8v844+D
 TIpobhMCDdVMOBtgUmalSAM7LmJ+V/o4GwqSEtLP1VHkezOe+OyKgbctk3IGXgzoKnSgVfZ7
 MPbMuNz94zSMYkdRxgaHn8xSjtQ=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 5f158b89cf983e60a87591ab (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 20 Jul 2020 12:18:17
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E1450C433CB; Mon, 20 Jul 2020 12:18:16 +0000 (UTC)
Received: from blr-ubuntu-173.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8710EC433C9;
        Mon, 20 Jul 2020 12:18:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8710EC433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
From:   Rajendra Nayak <rnayak@codeaurora.org>
To:     robdclark@gmail.com, sean@poorly.run
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH] drm/msm/dpu: dev_pm_opp_put_clkname() only when an opp_table exists
Date:   Mon, 20 Jul 2020 17:47:56 +0530
Message-Id: <1595247476-12968-1-git-send-email-rnayak@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Its possible that dpu_bind() fails early enough before
dev_pm_opp_set_clkname() is called. In such cases, unconditionally
calling dev_pm_opp_put_clkname() in dpu_unbind() can result in
a crash. Put an additional check so that dev_pm_opp_put_clkname()
is called only when an opp_table exists.

Fixes: aa3950767d05 ("drm/msm/dpu: Use OPP API to set clk/perf state")
Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
index f2bbce4..843a1c1 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
@@ -1079,7 +1079,8 @@ static void dpu_unbind(struct device *dev, struct device *master, void *data)
 
 	if (dpu_kms->has_opp_table)
 		dev_pm_opp_of_remove_table(dev);
-	dev_pm_opp_put_clkname(dpu_kms->opp_table);
+	if (dpu_kms->opp_table)
+		dev_pm_opp_put_clkname(dpu_kms->opp_table);
 }
 
 static const struct component_ops dpu_ops = {
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

