Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F12C4724C
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 03:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DAB120752
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 03:19:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbgEFDT6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 23:19:58 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3807 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726029AbgEFDT5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 23:19:57 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 1F04FAA9770614B36C3B;
        Wed,  6 May 2020 11:19:52 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Wed, 6 May 2020 11:19:43 +0800
From:   Samuel Zou <zou_wei@huawei.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <vkoul@kernel.org>, <sanyog.r.kale@intel.com>,
        <pierre-louis.bossart@linux.intel.com>
CC:     <linux-arm-msm@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, Samuel Zou <zou_wei@huawei.com>
Subject: [PATCH -next] soundwire: qcom: Use IRQF_ONESHOT
Date:   Wed, 6 May 2020 11:25:53 +0800
Message-ID: <1588735553-34219-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes coccicheck error:

drivers/soundwire/qcom.c:815:7-32: ERROR: Threaded IRQ with
no primary handler requested without IRQF_ONESHOT

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Samuel Zou <zou_wei@huawei.com>
---
 drivers/soundwire/qcom.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index e08a17c..a2a35f7 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -814,7 +814,8 @@ static int qcom_swrm_probe(struct platform_device *pdev)
 
 	ret = devm_request_threaded_irq(dev, ctrl->irq, NULL,
 					qcom_swrm_irq_handler,
-					IRQF_TRIGGER_RISING,
+					IRQF_TRIGGER_RISING |
+					IRQF_ONESHOT,
 					"soundwire", ctrl);
 	if (ret) {
 		dev_err(dev, "Failed to request soundwire irq\n");
-- 
2.6.2

