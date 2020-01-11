Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A16C33C9E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 05:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87EBF2072E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 05:21:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EfLNcTrA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbgAKFVe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 00:21:34 -0500
Received: from mail-pg1-f202.google.com ([209.85.215.202]:39764 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbgAKFVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 00:21:33 -0500
Received: by mail-pg1-f202.google.com with SMTP id v2so2561348pgv.6
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 21:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=akStK7cAQ1K40w8QqJEEzvrlAYC6BEPLaA78AG3pM3c=;
        b=EfLNcTrAXh/gBFWOy/gII1NLW7dRm7gbI2I/wTLJpbxCYZmibQJfGJ2SiLIzBO7MOj
         NQY967j8uHyXwE8P1QX1o28ld8XXHEFiSwCkV6fE85bt8ut6bLSEPMGQkJHjT0RC4lZo
         XSe5YYQsS00wunej07dbAIkFcS8zLRrXFopTpPx8SA2vvRsxNiQEo9vj1LchyoiKUROt
         lC6aJcIdxiEviPYKnrckkZAB+bJBYUMIsccfeO1ZMGmRARGLQa7cMmkS3vIfyE2pIt/Z
         uoLpmhLsT8fTQq37D9osD2GD6LFhSaRemkxB9iMR3zgEj6iKVpy/+nKccnSht34PVDZA
         7nyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=akStK7cAQ1K40w8QqJEEzvrlAYC6BEPLaA78AG3pM3c=;
        b=ew4k8B0ClaSlQzC4kAl/hJvbVkOyjUoDDEi89oqdi77gOQl3SbGfpCHEPeFvp8DEMU
         I6CLiCR0Sb+ZaXteNej9sTYMAffqmXSetpMHToFF30WPAJxHMRATmEfmoBxs4/S0jkAI
         vNJo63uB//2n7Uxc0VonHldMfgfrP1Hyi1IfM0b1q/M1X9UQyv+TGCjr16Qe/VPhJUHi
         TF2i2JLxpBCdcelsqGDemPrBIq6oICWaaf6pXTEjN3Mn79FVdFRU1duqT32bt4hxYZwG
         sPQhc2GLPcdeDwd22osP4zhJynfzKHsFWRQuqjq9wHWDYTYpORix+qzvtKmMEbC0OZ+h
         zaxw==
X-Gm-Message-State: APjAAAWSXtxaTWJCnZtw6tcksIxQfNIZTCNNYczakLIoWWSan+tVqi4c
        s79tHkMjIKDFT3jqafitox2BUniioVw+qCA=
X-Google-Smtp-Source: APXvYqxrcAZKAOCmlJkcK00pEZ1ULraOQ25v9oaNtJVmR1a9xAwuh5cvtTe4RR9EFA0ve0lSU2kt4O9GCO4Q4w0=
X-Received: by 2002:a63:5807:: with SMTP id m7mr8296993pgb.83.1578720092840;
 Fri, 10 Jan 2020 21:21:32 -0800 (PST)
Date:   Fri, 10 Jan 2020 21:21:25 -0800
Message-Id: <20200111052125.238212-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.rc1.283.g88dfdc4193-goog
Subject: [PATCH v1] clocksource: Avoid creating dead devices
From:   Saravana Kannan <saravanak@google.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Saravana Kannan <saravanak@google.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Timer initialization is done during early boot way before the driver
core starts processing devices and drivers. Timers initialized during
this early boot period don't really need or use a struct device.

However, for timers represented as device tree nodes, the struct devices
are still created and sit around unused and wasting memory. This change
avoid this by marking the device tree nodes as "populated" if the
corresponding timer is successfully initialized.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/clocksource/timer-probe.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clocksource/timer-probe.c b/drivers/clocksource/timer-probe.c
index ee9574da53c0..a10f28d750a9 100644
--- a/drivers/clocksource/timer-probe.c
+++ b/drivers/clocksource/timer-probe.c
@@ -27,8 +27,10 @@ void __init timer_probe(void)
 
 		init_func_ret = match->data;
 
+		of_node_set_flag(np, OF_POPULATED);
 		ret = init_func_ret(np);
 		if (ret) {
+			of_node_clear_flag(np, OF_POPULATED);
 			if (ret != -EPROBE_DEFER)
 				pr_err("Failed to initialize '%pOF': %d\n", np,
 				       ret);
-- 
2.25.0.rc1.283.g88dfdc4193-goog

