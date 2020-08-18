Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F9B9C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 11:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFE6B206B5
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 11:12:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="axe7Fqsp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbgHRLMB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 07:12:01 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:13403 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726639AbgHRLLx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 07:11:53 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597749112; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=8KsBPeNdTha9Z9PTeEoQRXtLXhQI+aaE8DyfZ+es9c4=; b=axe7Fqsp9BAVi0euD35V60k9dfBAHXzPyvtkx6NHmhpe8Hq/VaAiJ88BdCembI4zRb333SiS
 Vyb5iCkaIlQb307gU5Rx546M4ScOdTVHElb4AAAgYC3gA/vCLd1/gfKlwtycfQJq0qB9/3jE
 0zjNuNS5fJ1nrIujMahUgh69Of8=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n08.prod.us-east-1.postgun.com with SMTP id
 5f3bb75a91f8def8b2816f7d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 18 Aug 2020 11:11:22
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3329CC43387; Tue, 18 Aug 2020 11:11:21 +0000 (UTC)
Received: from tingweiz-gv.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tingwei)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 22014C433C6;
        Tue, 18 Aug 2020 11:11:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 22014C433C6
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
Subject: [PATCH] coresight: cti: remove pm_runtime_get_sync() from CPU hotplug
Date:   Tue, 18 Aug 2020 19:10:56 +0800
Message-Id: <20200818111057.19755-2-tingwei@codeaurora.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20200818111057.19755-1-tingwei@codeaurora.org>
References: <20200818111057.19755-1-tingwei@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Below BUG is triggered by call pm_runtime_get_sync() in
cti_cpuhp_enable_hw(). It's in CPU hotplug callback with interrupt
disabled. Pm_runtime_get_sync() calls clock driver to enable clock
which could sleep. Remove pm_runtime_get_sync() in cti_cpuhp_enable_hw()
since pm_runtime_get_sync() is called in cti_enabld and pm_runtime_put()
is called in cti_disabled. No need to increase pm count when CPU gets
online since it's not decreased when CPU is offline.

[  105.800279] BUG: scheduling while atomic: swapper/1/0/0x00000002
[  105.800290] Modules linked in:
[  105.800327] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G        W
5.9.0-rc1-gff1304be0a05-dirty #21
[  105.800337] Hardware name: Thundercomm Dragonboard 845c (DT)
[  105.800353] Call trace:
[  105.800414]  dump_backtrace+0x0/0x1d4
[  105.800439]  show_stack+0x14/0x1c
[  105.800462]  dump_stack+0xc0/0x100
[  105.800490]  __schedule_bug+0x58/0x74
[  105.800523]  __schedule+0x590/0x65c
[  105.800538]  schedule+0x78/0x10c
[  105.800553]  schedule_timeout+0x188/0x250
[  105.800585]  qmp_send.constprop.10+0x12c/0x1b0
[  105.800599]  qmp_qdss_clk_prepare+0x18/0x20
[  105.800622]  clk_core_prepare+0x48/0xd4
[  105.800639]  clk_prepare+0x20/0x34
[  105.800663]  amba_pm_runtime_resume+0x54/0x90
[  105.800695]  __rpm_callback+0xdc/0x138
[  105.800709]  rpm_callback+0x24/0x78
[  105.800724]  rpm_resume+0x328/0x47c
[  105.800739]  __pm_runtime_resume+0x50/0x74
[  105.800768]  cti_starting_cpu+0x40/0xa4
[  105.800795]  cpuhp_invoke_callback+0x84/0x1e0
[  105.800814]  notify_cpu_starting+0x9c/0xb8
[  105.800834]  secondary_start_kernel+0xd8/0x164
[  105.800933] CPU1: Booted secondary processor 0x0000000100 [0x517f803c]

Fixes: e9b880581d55 ("coresight: cti: Add CPU Hotplug handling to CTI driver")
Signed-off-by: Tingwei Zhang <tingwei@codeaurora.org>
---
 drivers/hwtracing/coresight/coresight-cti.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-cti.c b/drivers/hwtracing/coresight/coresight-cti.c
index 869569eb8c7f..baba6af83440 100644
--- a/drivers/hwtracing/coresight/coresight-cti.c
+++ b/drivers/hwtracing/coresight/coresight-cti.c
@@ -126,9 +126,7 @@ static int cti_enable_hw(struct cti_drvdata *drvdata)
 static void cti_cpuhp_enable_hw(struct cti_drvdata *drvdata)
 {
 	struct cti_config *config = &drvdata->config;
-	struct device *dev = &drvdata->csdev->dev;
 
-	pm_runtime_get_sync(dev->parent);
 	spin_lock(&drvdata->spinlock);
 	config->hw_powered = true;
 
@@ -148,7 +146,6 @@ static void cti_cpuhp_enable_hw(struct cti_drvdata *drvdata)
 	/* did not re-enable due to no claim / no request */
 cti_hp_not_enabled:
 	spin_unlock(&drvdata->spinlock);
-	pm_runtime_put(dev->parent);
 }
 
 /* disable hardware */
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

