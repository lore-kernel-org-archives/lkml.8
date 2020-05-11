Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7884C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 08:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 983A72098B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 08:34:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="E8WLyDdo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729220AbgEKIej (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 04:34:39 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:62449 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728454AbgEKIej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 04:34:39 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1589186078; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=HW3utqtp4BWVdYE+diHc7x+j4fFpQqSh4h84hivsY/I=; b=E8WLyDdodDgc7S6IuSvJS8cIkv/kckGSrPw6cCtk33iyLD8FLFICArP0KIWHfNG08wLgp5RK
 3S8vfnpiwOO6bvaIsTfFdiGPhCRDw4MeQMKW939R5OWs+WREwPbsWwXmVrAWQwqv2obNn8jm
 OdKqR6hUyiH7ZGpAV9Hen6dgE94=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb90e0d.7f2e1fd9b880-smtp-out-n05;
 Mon, 11 May 2020 08:34:21 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id AF926C433BA; Mon, 11 May 2020 08:34:21 +0000 (UTC)
Received: from blr-ubuntu-311.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 54B11C432C2;
        Mon, 11 May 2020 08:34:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 54B11C432C2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>
Cc:     Stephen Boyd <swboyd@chromium.org>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: [PATCH] coresight: replicator: Reset replicator if context is lost
Date:   Mon, 11 May 2020 14:04:00 +0530
Message-Id: <20200511083400.26554-1-saiprakash.ranjan@codeaurora.org>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some QCOM SoCs, replicators in Always-On domain loses its
context as soon as the clock is disabled. Currently as a part
of pm_runtime workqueue, clock is disabled after the replicator
is initialized by amba_pm_runtime_suspend assuming that context
is not lost which is not true for replicators with such
limitations. Hence check the replicator idfilter registers
in dynamic_replicator_enable() and reset again.

Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
---

More info here - https://lore.kernel.org/patchwork/patch/1231182/

---
 drivers/hwtracing/coresight/coresight-replicator.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
index e7dc1c31d20d..11df63f51071 100644
--- a/drivers/hwtracing/coresight/coresight-replicator.c
+++ b/drivers/hwtracing/coresight/coresight-replicator.c
@@ -68,6 +68,17 @@ static int dynamic_replicator_enable(struct replicator_drvdata *drvdata,
 	int rc = 0;
 	u32 reg;
 
+	/*
+	 * On some QCOM SoCs with replicators in Always-On domain, disabling
+	 * clock will result in replicator losing its context. Currently
+	 * as a part of pm_runtime workqueue, amba_pm_runtime_suspend disables
+	 * clock assuming the context is not lost which is not true for cases
+	 * with hardware limitations as the above.
+	 */
+	if ((readl_relaxed(drvdata->base + REPLICATOR_IDFILTER0) == 0) &&
+	    (readl_relaxed(drvdata->base + REPLICATOR_IDFILTER1) == 0))
+		dynamic_replicator_reset(drvdata);
+
 	switch (outport) {
 	case 0:
 		reg = REPLICATOR_IDFILTER0;
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
