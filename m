Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC1BC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 03:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB3CB20855
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 03:48:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="OKwkvFPJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbgHUDsv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 23:48:51 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:30017 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727074AbgHUDsu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 23:48:50 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597981729; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=NR00TQF2Q5NvhlGOYyoA7Yqsrftx/gbgVvITw5cWsW0=; b=OKwkvFPJI/x/jg7U6tvTCqx86hzi2driJIUzfb7LgukUFIr4koLEOy8K7fEY/0nWxnnt2OLS
 PzUqp7lBvQOgrkGlQs7qyPKtsN+LTBpxoz8RJXiOfpwTF/Lr/2qeMU7RB35+yk827XMa4DdW
 KX72voDHimZecAXUgwed/2DtEcY=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 5f3f44130dab4fdee212e817 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 21 Aug 2020 03:48:35
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8B504C433A0; Fri, 21 Aug 2020 03:48:35 +0000 (UTC)
Received: from tingweiz-gv.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tingwei)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4C208C433C6;
        Fri, 21 Aug 2020 03:48:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4C208C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=tingwei@codeaurora.org
From:   Tingwei Zhang <tingwei@codeaurora.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mike Leach <mike.leach@linaro.org>
Cc:     Tingwei Zhang <tingwei@codeaurora.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Leo Yan <leo.yan@linaro.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Kim Phillips <kim.phillips@arm.com>,
        Mian Yousaf Kaukab <ykaukab@suse.de>, tsoni@codeaurora.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Mao Jinlong <jinlmao@codeaurora.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v10 20/24] coresight: cti: increase reference count when enabling cti
Date:   Fri, 21 Aug 2020 11:44:41 +0800
Message-Id: <20200821034445.967-21-tingwei@codeaurora.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20200821034445.967-1-tingwei@codeaurora.org>
References: <20200821034445.967-1-tingwei@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CTI device is enabled when associated coresight device is enabled.
Increase the module and device reference count for CTI device
when it's enabled. This can prevent CTI device be removed or
module be unloaded when CTI device is enabled by an active trace
session.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
Signed-off-by: Tingwei Zhang <tingwei@codeaurora.org>
---
 drivers/hwtracing/coresight/coresight.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index d354fd57474e..6c9f6930b8b8 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -241,19 +241,30 @@ coresight_control_assoc_ectdev(struct coresight_device *csdev, bool enable)
 {
 	int ect_ret = 0;
 	struct coresight_device *ect_csdev = csdev->ect_dev;
+	struct module *mod;
 
 	if (!ect_csdev)
 		return 0;
 	if ((!ect_ops(ect_csdev)->enable) || (!ect_ops(ect_csdev)->disable))
 		return 0;
 
+	mod = ect_csdev->dev.parent->driver->owner;
 	if (enable) {
-		ect_ret = ect_ops(ect_csdev)->enable(ect_csdev);
-		if (!ect_ret)
-			csdev->ect_enabled = true;
+		if (try_module_get(mod)) {
+			ect_ret = ect_ops(ect_csdev)->enable(ect_csdev);
+			if (ect_ret) {
+				module_put(mod);
+			} else {
+				get_device(ect_csdev->dev.parent);
+				csdev->ect_enabled = true;
+			}
+		} else
+			ect_ret = -ENODEV;
 	} else {
 		if (csdev->ect_enabled) {
 			ect_ret = ect_ops(ect_csdev)->disable(ect_csdev);
+			put_device(ect_csdev->dev.parent);
+			module_put(mod);
 			csdev->ect_enabled = false;
 		}
 	}
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

