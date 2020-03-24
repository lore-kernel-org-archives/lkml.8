Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97EA6C54FD0
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 669622076E
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585056647;
	bh=OOHQbU1RbTHQ1Ma7XU0Q9tWR+VuZggUaN4Rhmo7+W4I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lJ8HmyjCIxqPSDAnzARhVuLxWCu8MWAF8bJazInd3K2yqHQI3Ea3ssMrAhAZj56so
	 GXCmdzPUU9YIDJrEDo63ztuB/lNcO2W1voTM6Wrd14d2+tzZLGPZpDPx01R6Ym+V0U
	 y3V1YjzPSqsDP4qnl89EVebwruQ2EMNG+H2g94Q4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728827AbgCXNVp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 09:21:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:43538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729060AbgCXNVh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 09:21:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10C7920775;
        Tue, 24 Mar 2020 13:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585056097;
        bh=OOHQbU1RbTHQ1Ma7XU0Q9tWR+VuZggUaN4Rhmo7+W4I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O6F81Yq+rjVFPcGdkQ2kSff4aLHud9sCkqYn0gcY/PBDuOw8l65xACHLBSMSnR0HN
         yDbQlnRlFcU3nZpCYLONNnXoxTWsAN5vpFzGo+tDIyEZJCtrRuhEbRXa7s2BoSF3WI
         RbPPH75B1+57g2InmNPIOF3maoIy6SwOuoQA79RE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Joakim Zhang <qiangqing.zhang@nxp.com>,
        Will Deacon <will@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.5 020/119] drivers/perf: fsl_imx8_ddr: Correct the CLEAR bit definition
Date:   Tue, 24 Mar 2020 14:10:05 +0100
Message-Id: <20200324130810.453209877@linuxfoundation.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200324130808.041360967@linuxfoundation.org>
References: <20200324130808.041360967@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joakim Zhang <qiangqing.zhang@nxp.com>

[ Upstream commit 049d919168458ac54e7fad27cd156a958b042d2f ]

When disabling a counter from ddr_perf_event_stop(), the counter value
is reset to 0 at the same time.

Preserve the counter value by performing a read-modify-write of the
PMU register and clearing only the enable bit.

Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/perf/fsl_imx8_ddr_perf.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/perf/fsl_imx8_ddr_perf.c b/drivers/perf/fsl_imx8_ddr_perf.c
index 95dca2cb52650..90884d14f95fa 100644
--- a/drivers/perf/fsl_imx8_ddr_perf.c
+++ b/drivers/perf/fsl_imx8_ddr_perf.c
@@ -388,9 +388,10 @@ static void ddr_perf_counter_enable(struct ddr_pmu *pmu, int config,
 
 	if (enable) {
 		/*
-		 * must disable first, then enable again
-		 * otherwise, cycle counter will not work
-		 * if previous state is enabled.
+		 * cycle counter is special which should firstly write 0 then
+		 * write 1 into CLEAR bit to clear it. Other counters only
+		 * need write 0 into CLEAR bit and it turns out to be 1 by
+		 * hardware. Below enable flow is harmless for all counters.
 		 */
 		writel(0, pmu->base + reg);
 		val = CNTL_EN | CNTL_CLEAR;
@@ -398,7 +399,8 @@ static void ddr_perf_counter_enable(struct ddr_pmu *pmu, int config,
 		writel(val, pmu->base + reg);
 	} else {
 		/* Disable counter */
-		writel(0, pmu->base + reg);
+		val = readl_relaxed(pmu->base + reg) & CNTL_EN_MASK;
+		writel(val, pmu->base + reg);
 	}
 }
 
-- 
2.20.1



