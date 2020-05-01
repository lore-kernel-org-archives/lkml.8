Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DFF0C47257
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 16:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88F0D2064C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 16:28:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730022AbgEAQ2U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 12:28:20 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:58194 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728947AbgEAQ2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 12:28:19 -0400
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 01 May 2020 09:28:19 -0700
Received: from sivaprak-linux.qualcomm.com ([10.201.3.202])
  by ironmsg05-sd.qualcomm.com with ESMTP; 01 May 2020 09:28:16 -0700
Received: by sivaprak-linux.qualcomm.com (Postfix, from userid 459349)
        id 0412B21693; Fri,  1 May 2020 21:58:14 +0530 (IST)
From:   Sivaprakash Murugesan <sivaprak@codeaurora.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, ohad@wizery.com,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Sivaprakash Murugesan <sivaprak@codeaurora.org>
Subject: [PATCH] remoteproc: wcss: add support for rpmsg communication
Date:   Fri,  1 May 2020 21:58:12 +0530
Message-Id: <1588350492-4663-1-git-send-email-sivaprak@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add glink and ssr subdevices for wcss rproc to enable rpmsg
communication.

Signed-off-by: Sivaprakash Murugesan <sivaprak@codeaurora.org>
---
 drivers/remoteproc/qcom_q6v5_wcss.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/remoteproc/qcom_q6v5_wcss.c b/drivers/remoteproc/qcom_q6v5_wcss.c
index f1924b7..48d16d8 100644
--- a/drivers/remoteproc/qcom_q6v5_wcss.c
+++ b/drivers/remoteproc/qcom_q6v5_wcss.c
@@ -91,6 +91,9 @@ struct q6v5_wcss {
 	phys_addr_t mem_reloc;
 	void *mem_region;
 	size_t mem_size;
+
+	struct qcom_rproc_glink glink_subdev;
+	struct qcom_rproc_ssr ssr_subdev;
 };
 
 static int q6v5_wcss_reset(struct q6v5_wcss *wcss)
@@ -557,6 +560,9 @@ static int q6v5_wcss_probe(struct platform_device *pdev)
 	if (ret)
 		goto free_rproc;
 
+	qcom_add_glink_subdev(rproc, &wcss->glink_subdev);
+	qcom_add_ssr_subdev(rproc, &wcss->ssr_subdev, "q6wcss");
+
 	ret = rproc_add(rproc);
 	if (ret)
 		goto free_rproc;
-- 
2.7.4

