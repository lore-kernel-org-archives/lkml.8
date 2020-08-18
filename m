Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC80FC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 11:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D25620706
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 11:11:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="PwUufyCw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbgHRLLf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 07:11:35 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:13403 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726552AbgHRLL1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 07:11:27 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597749086; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=8Qw+tTYKmfo+R51gAXm+p/w4gZaBki6khK//GZ/Ewxw=; b=PwUufyCwAM/MtWK1ACUxVkkvBU8NhLkFb7tlgieFSkrC8+wboCl9cLk2UWw24b+VIrH8k8un
 Up5PWgAlA4UhmT1psnYc9fiw0km/xjd75VPCxh/8dXUPALhHDaXU7SYybaAf49dQnDUY4h+K
 t/MnPphJg2T27hecSuJ+PVgqS5w=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n08.prod.us-east-1.postgun.com with SMTP id
 5f3bb753440a07969aff9f7a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 18 Aug 2020 11:11:15
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6C410C43391; Tue, 18 Aug 2020 11:11:13 +0000 (UTC)
Received: from tingweiz-gv.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tingwei)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3D692C433CA;
        Tue, 18 Aug 2020 11:11:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3D692C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=tingwei@codeaurora.org
From:   Tingwei Zhang <tingwei@codeaurora.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mike Leach <mike.leach@linaro.org>
Cc:     Tingwei Zhang <tingwei@codeaurora.org>, tsoni@codeaurora.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Mao Jinlong <jinlmao@codeaurora.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] coresight: cti: disclaim device only when it's claimed
Date:   Tue, 18 Aug 2020 19:10:55 +0800
Message-Id: <20200818111057.19755-1-tingwei@codeaurora.org>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Coresight_claim_device() is called in cti_starting_cpu() only
when CTI is enabled while coresight_disclaim_device() is called
uncontionally in cti_dying_cpu(). This triggered below WARNING.
Only call disclaim device when CTI device is enabled to fix it.

[   75.989643] WARNING: CPU: 1 PID: 14 at
kernel/drivers/hwtracing/coresight/coresight.c:209
coresight_disclaim_device_unlocked+0x10/0x24
[   75.989697] CPU: 1 PID: 14 Comm: migration/1 Not tainted
5.9.0-rc1-gff1304be0a05-dirty #21
[   75.989709] Hardware name: Thundercomm Dragonboard 845c (DT)
[   75.989737] pstate: 80c00085 (Nzcv daIf +PAN +UAO BTYPE=--)
[   75.989758] pc : coresight_disclaim_device_unlocked+0x10/0x24
[   75.989775] lr : coresight_disclaim_device+0x24/0x38
[   75.989783] sp : ffff800011cd3c90
.
[   75.990018] Call trace:
[   75.990041]  coresight_disclaim_device_unlocked+0x10/0x24
[   75.990066]  cti_dying_cpu+0x34/0x4c
[   75.990101]  cpuhp_invoke_callback+0x84/0x1e0
[   75.990121]  take_cpu_down+0x90/0xe0
[   75.990154]  multi_cpu_stop+0x134/0x160
[   75.990171]  cpu_stopper_thread+0xb0/0x13c
[   75.990196]  smpboot_thread_fn+0x1c4/0x270
[   75.990222]  kthread+0x128/0x154
[   75.990251]  ret_from_fork+0x10/0x18

Fixes: e9b880581d55 ("coresight: cti: Add CPU Hotplug handling to CTI driver")
Signed-off-by: Tingwei Zhang <tingwei@codeaurora.org>
---
 drivers/hwtracing/coresight/coresight-cti.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-cti.c b/drivers/hwtracing/coresight/coresight-cti.c
index 3ccc703dc940..d6fea6efec71 100644
--- a/drivers/hwtracing/coresight/coresight-cti.c
+++ b/drivers/hwtracing/coresight/coresight-cti.c
@@ -742,7 +742,8 @@ static int cti_dying_cpu(unsigned int cpu)
 
 	spin_lock(&drvdata->spinlock);
 	drvdata->config.hw_powered = false;
-	coresight_disclaim_device(drvdata->base);
+	if (drvdata->config.hw_enabled)
+		coresight_disclaim_device(drvdata->base);
 	spin_unlock(&drvdata->spinlock);
 	return 0;
 }
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

