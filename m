Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33282C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 04:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CC7A20780
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 04:09:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="FQhz1hU9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732296AbgFWEJE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 00:09:04 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:36045 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732222AbgFWEJB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 00:09:01 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1592885340; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=LS4JnOpUAKsNo8Zt5QnpjhczJmn2rGcrdAVF8H4PvvE=; b=FQhz1hU9nKKldvdMHYHoUCDDClyNafiOnqUls5GrH3DCKJnYsqDdfLyWm1ARl786mdbKY7lH
 /qUxjXbJUAhx6YVz3zMw9OF+VerdSslG3zp/Pd+DgtVTt/vjvy2ri6doP1hdbKQ/8j995l8B
 xyHktRGVy/BF5QZiIM+9xVWFOwI=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n19.prod.us-east-1.postgun.com with SMTP id
 5ef1803f567385e8e794f61f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 23 Jun 2020 04:08:31
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id DC6A0C433A1; Tue, 23 Jun 2020 04:08:30 +0000 (UTC)
Received: from mdtipton-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mdtipton)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1977BC433CB;
        Tue, 23 Jun 2020 04:08:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1977BC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=mdtipton@codeaurora.org
From:   Mike Tipton <mdtipton@codeaurora.org>
To:     georgi.djakov@linaro.org
Cc:     bjorn.andersson@linaro.org, agross@kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mike Tipton <mdtipton@codeaurora.org>
Subject: [PATCH 2/4] interconnect: qcom: Only wait for completion in AMC/WAKE by default
Date:   Mon, 22 Jun 2020 21:08:12 -0700
Message-Id: <20200623040814.23791-3-mdtipton@codeaurora.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200623040814.23791-1-mdtipton@codeaurora.org>
References: <20200623040814.23791-1-mdtipton@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the default TCS wait behavior to only wait for completion in AMC
and WAKE. Waiting isn't necessary in the SLEEP TCS, since votes are only
being removed in this case. Resources can be safely disabled
asynchronously in parallel with the rest of the power collapse sequence.
This reduces the sleep entry latency.

Signed-off-by: Mike Tipton <mdtipton@codeaurora.org>
---
 drivers/interconnect/qcom/bcm-voter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/interconnect/qcom/bcm-voter.c b/drivers/interconnect/qcom/bcm-voter.c
index e9f66f5c8a91..bb83ce7554b7 100644
--- a/drivers/interconnect/qcom/bcm-voter.c
+++ b/drivers/interconnect/qcom/bcm-voter.c
@@ -345,7 +345,7 @@ static int qcom_icc_bcm_voter_probe(struct platform_device *pdev)
 	voter->np = np;
 
 	if (of_property_read_u32(np, "qcom,tcs-wait", &voter->tcs_wait))
-		voter->tcs_wait = QCOM_ICC_TAG_ALWAYS;
+		voter->tcs_wait = QCOM_ICC_TAG_ACTIVE_ONLY;
 
 	mutex_init(&voter->lock);
 	INIT_LIST_HEAD(&voter->commit_list);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

