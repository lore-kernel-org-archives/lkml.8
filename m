Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3210C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 19:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D95520753
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 19:53:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sxvls+XP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbgCXTxK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 15:53:10 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:55597 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbgCXTxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 15:53:09 -0400
Received: by mail-pf1-f202.google.com with SMTP id 78so14837727pfy.22
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 12:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=1yB0CYPrzQ4Yl04wZfzYWlJ24CZkmQCx7EKSiot+wr8=;
        b=sxvls+XPSQ2VIqzbPGi7E7p//gwKfNCz6cvV+XdQmEN9a39woGfEKfZYgXkDwW8YXj
         bKfVNGD3ohruJb1mErLEEkQnptEAid0Ue3EPBCA2/uZEjwke5XhQynBR5DWVRcAl7uMZ
         xqWqYy94F51UQgAmGfgKcZ/SUJCj7ESgeaNKnxHFubWP4q/Uno3VhUx3pAuSJSGG+MlX
         mzPBvMqZy2tLc+bh8EiHTVwqtYF2m7nwbAk6Gk/MOwVW/Dp7wac4ccGRzv56eHjXweKa
         jwRcQ3SnU1WB5HNTp+3E2YI7vAvt0Cm0n5BWTDIjm6HD5dcgQbleoea7+pc3YXEqWh/8
         ULVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=1yB0CYPrzQ4Yl04wZfzYWlJ24CZkmQCx7EKSiot+wr8=;
        b=FX7nkWVW/lt3WeplP9O/QT8vIQNEEp2I89yiCPrnIuRbSQrBR4Cw2LhTNRr9ATNpJj
         Dau7B0zGgD1YHzjufy1Yj3DzAqyq0dLN0X4GzfsYbVs5QvbGRfce8tZo9HPQevIYuPny
         CU7ivIl7RC60u5H0IcatgQeC+dz2gI1paDKrXp1QCCKtlefJWA96CDNPolPKAOBLL3b8
         ZcmoY4E1LdoX3Qg+rMSAUfeie1rNkYJqq+IneNd5rOQ52a2tyup6juUmTxyS+c7A3u61
         qO5gnyM/t99DYy+NlyXYUunAfsEqomIhA1uhUaWJCGLcSV5HtvodmVBvJblD9MEQsq25
         QwQw==
X-Gm-Message-State: ANhLgQ1oWk9J8S8/NGNU/FTaOSYteD/iDTnleK8O6+64hL/boPca43hc
        EvPIWJagehBBckag5sGgXChd/CDCS9VdpZk=
X-Google-Smtp-Source: ADFU+vt9AUzxHCZt+lQUhNSQMtyJprTXre/WTxRnr5Ff+RI/UhKS5xFaEQxJRW9i6WOI2gCuHTFU9l3TsJYnxww=
X-Received: by 2002:a17:90a:228c:: with SMTP id s12mr7332521pjc.68.1585079588430;
 Tue, 24 Mar 2020 12:53:08 -0700 (PDT)
Date:   Tue, 24 Mar 2020 12:53:02 -0700
Message-Id: <20200324195302.203115-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
Subject: [PATCH v1] clocksource/drivers/timer-versatile: Clear OF_POPULATED flag
From:   Saravana Kannan <saravanak@google.com>
To:     Ionela Voinescu <ionela.voinescu@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Saravana Kannan <saravanak@google.com>
Cc:     kernel-team@android.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 4f41fe386a94 ("clocksource/drivers/timer-probe: Avoid
creating dead devices") broke the handling of arm,vexpress-sysreg [1].

The arm,vexpress-sysreg device is handled by both timer-versatile.c and
drivers/mfd/vexpress-sysreg.c. While the timer driver doesn't use the
device, the mfd driver still needs a device to probe.

So, this patch clears the OF_POPULATED flag to continue creating the
device.

[1] - https://lore.kernel.org/lkml/20200324175955.GA16972@arm.com/
Fixes: 4f41fe386a94
Signed-off-by: Saravana Kannan <saravanak@google.com>
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
2.25.1.696.g5e7596f4ac-goog

