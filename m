Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49FEBC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 07:32:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 185652075E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 07:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597735933;
	bh=2CdVodKumI00uNZaCEshR5tnnKeAEtLl1Aw0pwokYGU=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=1+vIw6iUBapcS5qjnsUiCfdAl8P2Hlc+2gbTjRcBsS/d0mzL+uaz5Bc31fAtDMkjm
	 CQMk3R0/rdKQaYKmMGCV/wF0NI+BPSrUYcepUnl6kRCogvocrEle/UmYUSYN8+l42a
	 Jfee50iFaij40nz7PHIhy7N6s2Z3+I7phvP0wYEE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbgHRHcL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 03:32:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:58378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726043AbgHRHcK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 03:32:10 -0400
Received: from localhost.localdomain (unknown [42.120.72.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56E6B206B5;
        Tue, 18 Aug 2020 07:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597735930;
        bh=2CdVodKumI00uNZaCEshR5tnnKeAEtLl1Aw0pwokYGU=;
        h=From:To:Cc:Subject:Date:From;
        b=jCpu7cW16x/OotQzMdmTcZA2KCpx23fWGLuaNHc9tUS3SgulxjvcEVYVaaKVVWpl/
         H1yrrgLnMjWFB90s+WofI1qGlMNG0Z+kJX8T+btw4oAtjxBlTPqL/cGInhFqxvmiy3
         oPylsV8dQPtIpyPHdOL/XV1JBixhch+cysvATqxk=
From:   guoren@kernel.org
To:     guoren@kernel.org
Cc:     linux-csky@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] clocksource/drivers/timer-gx6605s: Fixup counter reload
Date:   Tue, 18 Aug 2020 07:31:17 +0000
Message-Id: <1597735877-71115-1-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

When the timer counts to the upper limit, an overflow interrupt is
generated, and the count is reset with the value in the TIME_INI
register. But the software expects to start counting from 0 when
the count overflows, so it forces TIME_INI to 0 to solve the
potential interrupt storm problem.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Tested-by: Xu Kai <xukai@nationalchip.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/clocksource/timer-gx6605s.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clocksource/timer-gx6605s.c b/drivers/clocksource/timer-gx6605s.c
index 80d0939..8d386ad 100644
--- a/drivers/clocksource/timer-gx6605s.c
+++ b/drivers/clocksource/timer-gx6605s.c
@@ -28,6 +28,7 @@ static irqreturn_t gx6605s_timer_interrupt(int irq, void *dev)
 	void __iomem *base = timer_of_base(to_timer_of(ce));
 
 	writel_relaxed(GX6605S_STATUS_CLR, base + TIMER_STATUS);
+	writel_relaxed(0, base + TIMER_INI);
 
 	ce->event_handler(ce);
 
-- 
2.7.4

