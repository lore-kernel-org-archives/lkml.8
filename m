Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B15C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 14:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4837A207EA
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 14:04:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbgGQOEN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 10:04:13 -0400
Received: from foss.arm.com ([217.140.110.172]:52782 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726210AbgGQOEM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 10:04:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5614930E;
        Fri, 17 Jul 2020 07:04:12 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 81FE13F66E;
        Fri, 17 Jul 2020 07:04:11 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
List-Id: <soc.lore.kernel.org>
To:     linux-kernel@vger.kernel.org, arm@kernel.org, soc@kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] firmware: arm_scmi: Use NULL instead of integer 0 for rate pointer
Date:   Fri, 17 Jul 2020 15:04:05 +0100
Message-Id: <20200717140405.17905-1-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kbuild test robot reports the following sparse warning:

drivers/firmware/arm_scmi/clock.c:142:21:
	sparse: Using plain integer as NULL pointer

Use NULL pointer instead of integer 0 for rate pointer and fix the
warning.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_scmi/clock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Hi Arnd,

Kbuild test robot reported this warning from the soc tree. Can you apply
this directly or do you prefer pull request. Let me know.

Regards,
Sudeep

diff --git a/drivers/firmware/arm_scmi/clock.c b/drivers/firmware/arm_scmi/clock.c
index 6593ce87f420..75e39882746e 100644
--- a/drivers/firmware/arm_scmi/clock.c
+++ b/drivers/firmware/arm_scmi/clock.c
@@ -139,7 +139,7 @@ static int
 scmi_clock_describe_rates_get(const struct scmi_handle *handle, u32 clk_id,
 			      struct scmi_clock_info *clk)
 {
-	u64 *rate = 0;
+	u64 *rate = NULL;
 	int ret, cnt;
 	bool rate_discrete = false;
 	u32 tot_rate_cnt = 0, rates_flag;
--
2.17.1

