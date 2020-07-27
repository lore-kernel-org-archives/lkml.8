Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8419FC433E8
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 06:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5ADBD20759
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 06:08:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="UcRTVpSt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbgG0GIJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 02:08:09 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:49077 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726272AbgG0GIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 02:08:09 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1595830089; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=SdcmaivCbgx/EWFdy+61EjwpmapmcsR2LcYkxL9I74c=; b=UcRTVpSt7wnn4VjhS8zqrxzEuUF5nHAGAs+W0LB2bp+fqUizrP0aHvEd8PqbJGifRwkBjQYR
 56w8jz0B4fMqJUYLv211RhjOAYPesVfKJIjOnCAQ/PoEBZn5Jgc8ePmCPYZ86TUUpiS5iV2F
 WNyrri66snzG7vx7JUdNB/eruqk=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 5f1e6f31ca57a65d473553fc (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 27 Jul 2020 06:07:45
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id DD741C433A0; Mon, 27 Jul 2020 06:07:44 +0000 (UTC)
Received: from blr-ubuntu-253.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8BE03C433CB;
        Mon, 27 Jul 2020 06:07:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8BE03C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: [PATCH] coresight: etm4x: Fix etm4_count race using atomic variable
Date:   Mon, 27 Jul 2020 11:37:28 +0530
Message-Id: <20200727060728.15027-1-saiprakash.ranjan@codeaurora.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

etm4_count keeps track of number of ETMv4 registered and on some
systems, a race is observed on etm4_count variable which can
lead to multiple calls to cpuhp_setup_state_nocalls_cpuslocked().
This function internally calls cpuhp_store_callbacks() which
prevents multiple registrations of callbacks for a given state
and due to this race, it returns -EBUSY leading to ETM probe
failures like below.

 coresight-etm4x: probe of 7040000.etm failed with error -16

This race can easily be triggered with async probe by setting
probe type as PROBE_PREFER_ASYNCHRONOUS and with ETM power
management property "arm,coresight-loses-context-with-cpu".

Prevent this race by converting etm4_count variable to atomic.

Fixes: 9b6a3f3633a5 ("coresight: etmv4: Fix CPU power management setup in probe() function")
Fixes: 58eb457be028 ("hwtracing/coresight-etm4x: Convert to hotplug state machine")
Suggested-by: Mike Leach <mike.leach@linaro.org>
(Mike: Rootcause and context for commit message)
Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
---
 drivers/hwtracing/coresight/coresight-etm4x.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
index 6d7d2169bfb2..f256ea744c51 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x.c
@@ -49,7 +49,7 @@ MODULE_PARM_DESC(pm_save_enable,
 	"Save/restore state on power down: 1 = never, 2 = self-hosted");
 
 /* The number of ETMv4 currently registered */
-static int etm4_count;
+static atomic_t etm4_count;
 static struct etmv4_drvdata *etmdrvdata[NR_CPUS];
 static void etm4_set_default_config(struct etmv4_config *config);
 static int etm4_set_event_filters(struct etmv4_drvdata *drvdata,
@@ -1403,7 +1403,7 @@ static int etm4_pm_setup_cpuslocked(void)
 {
 	int ret;
 
-	if (etm4_count++)
+	if (atomic_inc_return(&etm4_count))
 		return 0;
 
 	ret = cpu_pm_register_notifier(&etm4_cpu_pm_nb);
@@ -1434,13 +1434,13 @@ static int etm4_pm_setup_cpuslocked(void)
 	cpu_pm_unregister_notifier(&etm4_cpu_pm_nb);
 
 reduce_count:
-	--etm4_count;
+	atomic_dec(&etm4_count);
 	return ret;
 }
 
 static void etm4_pm_clear(void)
 {
-	if (--etm4_count != 0)
+	if (atomic_dec_return(&etm4_count) != 0)
 		return;
 
 	cpu_pm_unregister_notifier(&etm4_cpu_pm_nb);
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

