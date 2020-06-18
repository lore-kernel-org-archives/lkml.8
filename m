Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E22D2C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B08EA221F8
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592445864;
	bh=jMKMGH9oLq4ZwU2DuxOlSu/A8eXbglr0iWQy84qeamc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ATL+6jMrzM9bZOG6ccezhNhlf1zLe7sre7D/pPR01szKUbLylZIYrY1upqe1IyPES
	 3s/QgnVog6tZKbnxd6091tanPtO3MUPlWgGXfFknNoJu1UCD4NRIzJTcjSiBuw1x0z
	 e7XB65pvUsEFEOSTsVM4WDShnQ/iWmbtACcn04OM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731300AbgFRCEX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 22:04:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:56350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729388AbgFRBXE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:23:04 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE97320776;
        Thu, 18 Jun 2020 01:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592443383;
        bh=jMKMGH9oLq4ZwU2DuxOlSu/A8eXbglr0iWQy84qeamc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lk7ZE6kIPGk4UCsyEtdXJrqoLb2rfPl4Fp4JOY1arHJZ7UCWJ3Wu/C1Svdii1OKTS
         DGupGcoIFTHrCKgOik+oq7bMIeismTA6qlCudtFfcZ4MzWsY5s5P/Dpqhpp8rLnfW5
         dqxUMy11BelzY4e7xx9pcWpm/3RuY2ThJJyhjuhk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alain Volmat <avolmat@me.com>,
        Patrice Chotard <patrice.chotard@st.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-clk@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 034/172] clk: clk-flexgen: fix clock-critical handling
Date:   Wed, 17 Jun 2020 21:20:00 -0400
Message-Id: <20200618012218.607130-34-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618012218.607130-1-sashal@kernel.org>
References: <20200618012218.607130-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alain Volmat <avolmat@me.com>

[ Upstream commit a403bbab1a73d798728d76931cab3ff0399b9560 ]

Fixes an issue leading to having all clocks following a critical
clocks marked as well as criticals.

Fixes: fa6415affe20 ("clk: st: clk-flexgen: Detect critical clocks")
Signed-off-by: Alain Volmat <avolmat@me.com>
Link: https://lkml.kernel.org/r/20200322140740.3970-1-avolmat@me.com
Reviewed-by: Patrice Chotard <patrice.chotard@st.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/st/clk-flexgen.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/st/clk-flexgen.c b/drivers/clk/st/clk-flexgen.c
index 918ba3164da9..cd856210db58 100644
--- a/drivers/clk/st/clk-flexgen.c
+++ b/drivers/clk/st/clk-flexgen.c
@@ -373,6 +373,7 @@ static void __init st_of_flexgen_setup(struct device_node *np)
 			break;
 		}
 
+		flex_flags &= ~CLK_IS_CRITICAL;
 		of_clk_detect_critical(np, i, &flex_flags);
 
 		/*
-- 
2.25.1

