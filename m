Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA2C9C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 05:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6AF020724
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 05:47:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="Nyfk+hqC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbgHTFry (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 01:47:54 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:55879 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726956AbgHTFrq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 01:47:46 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597902466; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=awGFRa1c/LI9oXWKnZbTKZ4uqjnhLkrk0YY3yOEz6Wg=; b=Nyfk+hqCkeiUe1cMI29mWgP1xnzALM+SJLetcwSNH57qRGRL+7bZxbGLYxgO7chgX74rtzU0
 mRsYs72l5AZugs7jVzYUAU8w/MfnVfMu+qEXrmJSyB9SLe1PIhI8VwYTuDFgPw6jSDHCAz8k
 KjuuGnnl6/w/DfkuBN76EoVEO6A=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 5f3e0e82f32ee2c46a2584ce (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 20 Aug 2020 05:47:46
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id CAC97C433B1; Thu, 20 Aug 2020 05:47:44 +0000 (UTC)
Received: from tingweiz-gv.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tingwei)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A7C6BC433A0;
        Thu, 20 Aug 2020 05:47:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A7C6BC433A0
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
Subject: [PATCH v9 01/24] coresight: cpu_debug: add module name in Kconfig
Date:   Thu, 20 Aug 2020 13:46:55 +0800
Message-Id: <20200820054718.20115-2-tingwei@codeaurora.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20200820054718.20115-1-tingwei@codeaurora.org>
References: <20200820054718.20115-1-tingwei@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide name of cpu_debug module in Kconfig help section.

Signed-off-by: Tingwei Zhang <tingwei@codeaurora.org>
Tested-by: Mike Leach <mike.leach@linaro.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
index 02dbb5ca3bcf..4663fd1bbffc 100644
--- a/drivers/hwtracing/coresight/Kconfig
+++ b/drivers/hwtracing/coresight/Kconfig
@@ -110,6 +110,9 @@ config CORESIGHT_CPU_DEBUG
 	  properly, please refer Documentation/trace/coresight/coresight-cpu-debug.rst
 	  for detailed description and the example for usage.
 
+	  To compile this driver as a module, choose M here: the
+	  module will be called coresight-cpu-debug.
+
 config CORESIGHT_CTI
 	bool "CoreSight Cross Trigger Interface (CTI) driver"
 	depends on ARM || ARM64
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

