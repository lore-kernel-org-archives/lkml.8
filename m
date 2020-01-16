Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0201FC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C287120663
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579194520;
	bh=k8GReeyE90iWoxw6ZmMi4YPvCx8AKmgbeGlh4ZYDKyk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Uu/FEf/PYrLLefwgABQvWWNLDAfk42RiuTYewKgqUkgA1jrRy/Zk877qCZvRCHzRx
	 FDgKSnYzGTjR3nH3TZXc2siXD/tDc9CApcuz/hYM9s8MdW9HKpjQ+vwWSi+oD+9YlY
	 DlRUYtLG7oOfcw+lEimNtiZq5lV7ol6LefDP1Jh4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389462AbgAPRIk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:08:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:42574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389443AbgAPRIf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:08:35 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28F58205F4;
        Thu, 16 Jan 2020 17:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579194514;
        bh=k8GReeyE90iWoxw6ZmMi4YPvCx8AKmgbeGlh4ZYDKyk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VJniDalO1pbCuRUQLJg0M74UQn+KjrgEgmJGqwJoeCiDu4yCPchJ6A3LL9cet2Lvm
         r2LoYsP7ox3xtyt7yVt8p6rEc6cf5p4piHjg9lZhryh8BmQSXGIXDhuvN2VgccNV3a
         lYyI/sIuiq50w4/lxnhqIp5srS/AwTV+R8HAbgtM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Peng Fan <peng.fan@nxp.com>, Sudeep Holla <sudeep.holla@arm.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 408/671] firmware: arm_scmi: update rate_discrete in clock_describe_rates_get
Date:   Thu, 16 Jan 2020 12:00:46 -0500
Message-Id: <20200116170509.12787-145-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116170509.12787-1-sashal@kernel.org>
References: <20200116170509.12787-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

[ Upstream commit c0759b9b5d411ab27c479125cee9bae391a96436 ]

The boolean rate_discrete needs to be assigned to clk->rate_discrete,
so that clock driver can distinguish between the continuous range and
discrete rates. It uses this in scmi_clk_round_rate could get the
rounded value if it's a continuous range.

Fixes: 5f6c6430e904 ("firmware: arm_scmi: add initial support for clock protocol")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
[sudeep.holla: updated commit message]
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/arm_scmi/clock.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/firmware/arm_scmi/clock.c b/drivers/firmware/arm_scmi/clock.c
index 30fc04e28431..0a194af92438 100644
--- a/drivers/firmware/arm_scmi/clock.c
+++ b/drivers/firmware/arm_scmi/clock.c
@@ -185,6 +185,8 @@ scmi_clock_describe_rates_get(const struct scmi_handle *handle, u32 clk_id,
 	if (rate_discrete)
 		clk->list.num_rates = tot_rate_cnt;
 
+	clk->rate_discrete = rate_discrete;
+
 err:
 	scmi_xfer_put(handle, t);
 	return ret;
-- 
2.20.1

