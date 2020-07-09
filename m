Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50171C433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 08:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33FC820720
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 08:17:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbgGIIRO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 04:17:14 -0400
Received: from foss.arm.com ([217.140.110.172]:41840 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726124AbgGIIRN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 04:17:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CE78F31B;
        Thu,  9 Jul 2020 01:17:12 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CD7EA3F887;
        Thu,  9 Jul 2020 01:17:11 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Dien Pham <dien.pham.ry@renesas.com>
Subject: [PATCH v2 1/2] firmware: arm_scmi: Keep the discrete clock rates sorted
Date:   Thu,  9 Jul 2020 09:17:04 +0100
Message-Id: <20200709081705.46084-1-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of relying on the firmware to keep the clock rates sorted, let
us sort the list. This is not essential for clock layer but it helps
to find the min and max rates easily from the list.

Link: https://lore.kernel.org/r/20200708110725.18017-1-sudeep.holla@arm.com
Fixes: 5f6c6430e904 ("firmware: arm_scmi: add initial support for clock protocol")
Reported-by: Dien Pham <dien.pham.ry@renesas.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_scmi/clock.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)


Hi Dien-san,

If you could review/test these patches, I can queue them ASAP.
I am planning to send the PR for ARM SoC later this week, so I need
your tested-by.

v1[1]->v2:
	- Fixed the warning, sent the wrong version earlier

Regards,
Sudeep

[1] https://lore.kernel.org/r/20200708110725.18017-1-sudeep.holla@arm.com

diff --git a/drivers/firmware/arm_scmi/clock.c b/drivers/firmware/arm_scmi/clock.c
index 4c2227662b26..c90f23a812f5 100644
--- a/drivers/firmware/arm_scmi/clock.c
+++ b/drivers/firmware/arm_scmi/clock.c
@@ -5,6 +5,8 @@
  * Copyright (C) 2018 ARM Ltd.
  */

+#include <linux/sort.h>
+
 #include "common.h"

 enum scmi_clock_protocol_cmd {
@@ -121,6 +123,13 @@ static int scmi_clock_attributes_get(const struct scmi_handle *handle,
 	return ret;
 }

+static int rate_cmp_func(const void *_r1, const void *_r2)
+{
+	const u64 *r1 = _r1, *r2 = _r2;
+
+	return r1 - r2;
+}
+
 static int
 scmi_clock_describe_rates_get(const struct scmi_handle *handle, u32 clk_id,
 			      struct scmi_clock_info *clk)
@@ -184,8 +193,10 @@ scmi_clock_describe_rates_get(const struct scmi_handle *handle, u32 clk_id,
 		 */
 	} while (num_returned && num_remaining);

-	if (rate_discrete)
+	if (rate_discrete) {
 		clk->list.num_rates = tot_rate_cnt;
+		sort(rate, tot_rate_cnt, sizeof(*rate), rate_cmp_func, NULL);
+	}

 	clk->rate_discrete = rate_discrete;

--
2.17.1

