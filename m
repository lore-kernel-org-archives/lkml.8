Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B8DC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:22:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02FCB20B80
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592580163;
	bh=a7t4fStzPG3m+Up+iFgKY9RcL2ZlUDwF9z2e11dlUNg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RasCQoZkQe9+AscIZ/xli1VCdFJR3cX/Liz4Ap3aXpYB+vcZw9U2NLd5fJbN7meGs
	 kOWXdTSom4rkDD42RQ3/A/Unb+D6hwiQtz2D4whqGijpRyCMS5DsFiJher+UHn04oF
	 y01+Zdri/YJ4QuHSctW3AU+zbcZzC+zwhU3aXChA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390708AbgFSPWk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:22:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:49204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392597AbgFSPSx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:18:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A566F218AC;
        Fri, 19 Jun 2020 15:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592579932;
        bh=a7t4fStzPG3m+Up+iFgKY9RcL2ZlUDwF9z2e11dlUNg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G1JHG8CzYuqaLVyItvuBm4f7gcLUL3LavJ6ScZJNo7La2Zk4z4m9Eb5M+XtoDQxV7
         7j4lstvepP7z5UxEF095qUTYHH6TBie79LJaOEGtnFeXhakkAyrgrOfK1u3BVfcVbS
         ao4nVvtDp9iLcxUDaqek2OnyRwzJUFOt6cGWbTCE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Saravana Kannan <saravanak@google.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 059/376] clocksource/drivers/timer-versatile: Clear OF_POPULATED flag
Date:   Fri, 19 Jun 2020 16:29:37 +0200
Message-Id: <20200619141713.147241749@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141710.350494719@linuxfoundation.org>
References: <20200619141710.350494719@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Saravana Kannan <saravanak@google.com>

[ Upstream commit 7a3768c206a006525afc090f92d4d618d8356b92 ]

The commit 4f41fe386a94 ("clocksource/drivers/timer-probe: Avoid
creating dead devices") broke the handling of arm,vexpress-sysreg [1].

The arm,vexpress-sysreg device is handled by both timer-versatile.c and
drivers/mfd/vexpress-sysreg.c. While the timer driver doesn't use the
device, the mfd driver still needs a device to probe.

So, this patch clears the OF_POPULATED flag to continue creating the
device.

[1] - https://lore.kernel.org/lkml/20200324175955.GA16972@arm.com/

Fixes: 4f41fe386a94 ("clocksource/drivers/timer-probe: Avoid creating dead devices")
Signed-off-by: Saravana Kannan <saravanak@google.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20200324195302.203115-1-saravanak@google.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clocksource/timer-versatile.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clocksource/timer-versatile.c b/drivers/clocksource/timer-versatile.c
index e4ebb656d005..f5d017b31afa 100644
--- a/drivers/clocksource/timer-versatile.c
+++ b/drivers/clocksource/timer-versatile.c
@@ -6,6 +6,7 @@
 
 #include <linux/clocksource.h>
 #include <linux/io.h>
+#include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/sched_clock.h>
 
@@ -22,6 +23,8 @@ static int __init versatile_sched_clock_init(struct device_node *node)
 {
 	void __iomem *base = of_iomap(node, 0);
 
+	of_node_clear_flag(node, OF_POPULATED);
+
 	if (!base)
 		return -ENXIO;
 
-- 
2.25.1



