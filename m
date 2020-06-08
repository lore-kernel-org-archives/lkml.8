Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42511C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 01:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EE0120760
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 01:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591664663;
	bh=a7t4fStzPG3m+Up+iFgKY9RcL2ZlUDwF9z2e11dlUNg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=K3qeB1ST0y3/+1sP5ldRUgVcWx6hM8Dh0yxqQNpphw5ymN4PcfjT17u+vnOss4YC6
	 gulgxtv9b8gvfu6L4s6iHKZyCv3uR4asP+nOKRoF9JQOiFoj2s094jzWBBn5MHPMcD
	 AGSYh7sM6ROuFvgWmjOmCoSmrVflUn+II693tLCE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388137AbgFIBEV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 21:04:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:51738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727907AbgFHXH2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:07:28 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 763BC20885;
        Mon,  8 Jun 2020 23:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591657648;
        bh=a7t4fStzPG3m+Up+iFgKY9RcL2ZlUDwF9z2e11dlUNg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=abR3F+p/nCT5iEkISgY0CdHMVwKunteYVFPFRaktVNFedWObq8KkwlUltMEqBTfOO
         Iljwlp+56tWPbbKKIDJQTHYQjUAffYWzMMCWYy0wbkcsAwFB0Kif7DSAMxKptNdaia
         I8tABKf7RNUG36YnE91pVcqtFO731x9DA5RHw7rE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Saravana Kannan <saravanak@google.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.7 063/274] clocksource/drivers/timer-versatile: Clear OF_POPULATED flag
Date:   Mon,  8 Jun 2020 19:02:36 -0400
Message-Id: <20200608230607.3361041-63-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608230607.3361041-1-sashal@kernel.org>
References: <20200608230607.3361041-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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

