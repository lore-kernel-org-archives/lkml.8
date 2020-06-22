Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D446C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 06:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A0BE25431
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 06:53:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="a+LxpvPe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731291AbgFVGxo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 02:53:44 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:14677 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726759AbgFVGxo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 02:53:44 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1592808823; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=o2YYaXC6PIfOD5o+rRYmzT173G08up0bWdnLaswSdXE=; b=a+LxpvPescNrRM07marw8UpPLmfjny0Ym+9wDaCeCrzrTfG6PJAPFj+HEAsH9cTcisj3tEJn
 fbyPAKKr308WYvvGDurykGyiMy7nAqfGExlTxVwPh6Nn43EhkffR2hrkNIUjZ/zifDy4jb9G
 tcWxE0+BPUlAQW9qi8XYITo5/BY=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 5ef05577c4bb4f886da5285e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 22 Jun 2020 06:53:43
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 58A58C433C8; Mon, 22 Jun 2020 06:53:42 +0000 (UTC)
Received: from mkshah-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mkshah)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 00A36C433C6;
        Mon, 22 Jun 2020 06:53:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 00A36C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=mkshah@codeaurora.org
From:   Maulik Shah <mkshah@codeaurora.org>
To:     bjorn.andersson@linaro.org, agross@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dianders@chromium.org, swboyd@chromium.org, rnayak@codeaurora.org,
        ilina@codeaurora.org, lsrao@codeaurora.org,
        Maulik Shah <mkshah@codeaurora.org>
Subject: [PATCH] soc: qcom: rpmh-rsc: Set suppress_bind_attrs flag
Date:   Mon, 22 Jun 2020 12:23:25 +0530
Message-Id: <1592808805-2437-1-git-send-email-mkshah@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rpmh-rsc driver is fairly core to system and should not be removable
once its probed. However it allows to unbind driver from sysfs using
below command which results into a crash on sc7180.

echo 18200000.rsc > /sys/bus/platform/drivers/rpmh/unbind

Lets prevent unbind at runtime by setting suppress_bind_attrs flag.

Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
---
 drivers/soc/qcom/rpmh-rsc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index 076fd27..752a561 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -1023,6 +1023,7 @@ static struct platform_driver rpmh_driver = {
 	.driver = {
 		  .name = "rpmh",
 		  .of_match_table = rpmh_drv_match,
+		  .suppress_bind_attrs = true,
 	},
 };
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

