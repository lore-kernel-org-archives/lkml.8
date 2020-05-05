Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89BABC47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6177C20735
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588687804;
	bh=+ZwqiwiMx8jxlKUZJYOMUJycGuiHRy7wNsvP4B07hlw=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=DJFEwqMSYmo+Jq86syuHDjTSnJZEBrZNFcbEKCa9O7aL7iSpl2wGmNRW0ors2+uST
	 xOiLnJLnYWUApIzrkiSenOMXxKEHm7VJZmUlTHx+Vu+fUfJ/3jaMmduDBuht03Q01I
	 GphXldCUr/1w+nZpZ09Sm2PMOmajQ8IfYChG846g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729246AbgEEOKD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 10:10:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:59084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727857AbgEEOKD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:10:03 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D067320675;
        Tue,  5 May 2020 14:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588687803;
        bh=+ZwqiwiMx8jxlKUZJYOMUJycGuiHRy7wNsvP4B07hlw=;
        h=From:To:Cc:Subject:Date:From;
        b=Sco2qe2R6ULZ0SG6dvab5wjtqNs6aked0vMbvTuR+m+qIBsvXrCx9eJM9Q7C8h2MF
         U/U3m9j/HYZ0Er5vmTzB97OsjuzpUTgrnjKnH8jDR7inGl3ndoVlq0e44jac6OefvM
         mBWxHmrStp81eePzVALLr0ZM3qwU/Vh2jufHiV38=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jVyGm-009TGk-U9; Tue, 05 May 2020 15:10:01 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Subject: [PATCH] clk: Unlink clock if failed to prepare or enable
Date:   Tue,  5 May 2020 15:09:53 +0100
Message-Id: <20200505140953.409430-1-maz@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux@roeck-us.net, sboyd@kernel.org, mturquette@baylibre.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On failing to prepare or enable a clock, remove the core structure
from the list it has been inserted as it is about to be freed.

This otherwise leads to random crashes when subsequent clocks get
registered, during which parsing of the clock tree becomes adventurous.

Observed with QEMU's RPi-3 emulation.

Fixes: 12ead77432f2 ("clk: Don't try to enable critical clocks if prepare failed")
Signed-off-by: Marc Zyngier <maz@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>
---
 drivers/clk/clk.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index b34fc1d3a594..752e8eef3f55 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -3522,6 +3522,9 @@ static int __clk_core_init(struct clk_core *core)
 out:
 	clk_pm_runtime_put(core);
 unlock:
+	if (ret)
+		hlist_del_init(&core->child_node);
+
 	clk_prepare_unlock();
 
 	if (!ret)
-- 
2.20.1

