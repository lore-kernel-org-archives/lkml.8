Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E162C55194
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 14:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 213152070A
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 14:37:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="A81Nss2X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbgDZOhk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 10:37:40 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:35430 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726140AbgDZOhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 10:37:40 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1587911858; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=ui6MOHK4ycwTBeNfWOrKG5eJnPzmTryDDwOQywkBnZM=; b=A81Nss2XN/W0OWppPjxBIDbwqu275bYo1FqJYTPDtmdAHhjsp0BifSa4xGuHFpsd1GJsJMxw
 9SISYwInOUBuH/oBaubK+33yxpIUdQWoCSzemSme1eplt7UgbzE2N4SZEUExPPbHUsceH9Vr
 YZKEC+2IuMzn8FNBe5N6iNfVNas=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ea59cb2.7f47d0539f80-smtp-out-n01;
 Sun, 26 Apr 2020 14:37:38 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 06938C432C2; Sun, 26 Apr 2020 14:37:37 +0000 (UTC)
Received: from blr-ubuntu-311.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BDF9AC433D2;
        Sun, 26 Apr 2020 14:37:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BDF9AC433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>
Cc:     Stephen Boyd <swboyd@chromium.org>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: [PATCH] coresight: dynamic-replicator: Fix handling of multiple connections
Date:   Sun, 26 Apr 2020 20:07:25 +0530
Message-Id: <20200426143725.18116-1-saiprakash.ranjan@codeaurora.org>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 30af4fb619e5 ("coresight: dynamic-replicator:
Handle multiple connections"), we do not make sure that
the other port is disabled when the dynamic replicator is
enabled. This is seen to cause the CPU hardlockup atleast
on SC7180 SoC with the following topology when enabling ETM
with ETR as the sink via sysfs. Since there is no trace id
logic in coresight yet to make use of multiple sinks in
parallel for different trace sessions, disable the other
port when one port is turned on.

       etm0_out
	  |
   apss_funnel_in0
          |
  apss_merge_funnel_in
          |
      funnel1_in4
	  |
   merge_funnel_in1
	  |
    swao_funnel_in
          |
        etf_in
	  |
  swao_replicator_in
          |
   replicator_in
	  |
        etr_in

  Kernel panic - not syncing: Watchdog detected hard LOCKUP on cpu 0
  CPU: 7 PID: 0 Comm: swapper/7 Tainted: G S  B             5.4.25 #100
  Hardware name: Qualcomm Technologies, Inc. SC7180 IDP (DT)
  Call trace:
   dump_backtrace+0x0/0x188
   show_stack+0x20/0x2c
   dump_stack+0xdc/0x144
   panic+0x168/0x370
   arch_seccomp_spec_mitigate+0x0/0x14
   watchdog_timer_fn+0x68/0x290
   __hrtimer_run_queues+0x264/0x498
   hrtimer_interrupt+0xf0/0x22c
   arch_timer_handler_phys+0x40/0x50
   handle_percpu_devid_irq+0x8c/0x158
   __handle_domain_irq+0x84/0xc4
   gic_handle_irq+0x100/0x1c4
   el1_irq+0xbc/0x180
   arch_cpu_idle+0x3c/0x5c
   default_idle_call+0x1c/0x38
   do_idle+0x100/0x280
   cpu_startup_entry+0x24/0x28
   secondary_start_kernel+0x15c/0x170
  SMP: stopping secondary CPUs

Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Tested-by: Stephen Boyd <swboyd@chromium.org>
---
Changes since RFC:
 * Reworded commit text and included the topology on SC7180.
---
 .../hwtracing/coresight/coresight-replicator.c    | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
index e7dc1c31d20d..f4eaa38f8f43 100644
--- a/drivers/hwtracing/coresight/coresight-replicator.c
+++ b/drivers/hwtracing/coresight/coresight-replicator.c
@@ -66,14 +66,16 @@ static int dynamic_replicator_enable(struct replicator_drvdata *drvdata,
 				     int inport, int outport)
 {
 	int rc = 0;
-	u32 reg;
+	u32 reg0, reg1;
 
 	switch (outport) {
 	case 0:
-		reg = REPLICATOR_IDFILTER0;
+		reg0 = REPLICATOR_IDFILTER0;
+		reg1 = REPLICATOR_IDFILTER1;
 		break;
 	case 1:
-		reg = REPLICATOR_IDFILTER1;
+		reg0 = REPLICATOR_IDFILTER1;
+		reg1 = REPLICATOR_IDFILTER0;
 		break;
 	default:
 		WARN_ON(1);
@@ -87,8 +89,11 @@ static int dynamic_replicator_enable(struct replicator_drvdata *drvdata,
 		rc = coresight_claim_device_unlocked(drvdata->base);
 
 	/* Ensure that the outport is enabled. */
-	if (!rc)
-		writel_relaxed(0x00, drvdata->base + reg);
+	if (!rc) {
+		writel_relaxed(0x00, drvdata->base + reg0);
+		writel_relaxed(0xff, drvdata->base + reg1);
+	}
+
 	CS_LOCK(drvdata->base);
 
 	return rc;
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
