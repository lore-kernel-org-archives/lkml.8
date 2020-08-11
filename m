Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A85E0C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 18:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A72520768
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 18:00:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o057fgYf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbgHKSAH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 14:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbgHKSAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 14:00:06 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 216AFC061788
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 11:00:06 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id o13so7083341pgf.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 11:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=CR+eiQtbNEAKsIGNTaqTZuth1SOqcy9GKi63n0KrlZw=;
        b=o057fgYfDEjJ0vbSJiMNV9icULVWspiUDN6Ldhz0q8BiCO6RbMGnr6g7SkweCB8Y9u
         UJqcPL6eITRyUuT8cT1dr08aoRNcDVQCJQk3m/Bn+lg07eDggASjE/yOxqZwQow/bJB5
         lhesVXFNAIy76jv2487k0O36A8+JlN/Gm3h5o5NyWXwC4QRcRm07RxmHkrGy882iciLC
         ZA5dp5e4/atJjz2AS4ekt8zX3/JMo3hCHy8T8xHEzms6pdD4hlzX+QKeXdtaQ44bqEr/
         d7Cp0h8auRex2Q4MRmCoEyPBbGIsdNrw09N6zgYHGbLuP7Kt6fS+03B31Yb7wguXmXMM
         B/Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=CR+eiQtbNEAKsIGNTaqTZuth1SOqcy9GKi63n0KrlZw=;
        b=AU6swUW4O8wcM0N37DgXv3lYEf4kf1UAeyyWhkmdXpR04xk1/m4RhZ0WdVCXeLsrWO
         Pnn7g9nAUAEL/FILplUv6ZA3aXTGqwmgEx06FGfVtnsn+Ea1oDnw6KIs++3GJliOqtmG
         6cIS0lvuFg8p8hQVNp7WFV6jNmrLUi97c1nCG2Hn7pvA5aU8bf0fJfcDS0ggKPaRSo0b
         K/ll+KesGL0UmWlV+XcxYOV4BuQqFmnwVR8pE5X+lIA8Opu1B0QST33wHkEnsjJ94kXn
         KL3ZBTJR7yFmiaIwFnP9HMy+w/pzoFkimjHwNFQZ5Ng98T7t2pXj/10ZjfkwQOFggGYY
         79hw==
X-Gm-Message-State: AOAM532DCBLEXUZtt65236m3K/G/SEXMJpsIkm9GQy0xf03vPOVBzTwq
        EPO6LbaOtqJxmNKjjZesJJB4wjmZ
X-Google-Smtp-Source: ABdhPJzwBEVIdEsqoSZm1AUZoVHQ1b5QrIJR99R1pGj9dSpw0+ImxiwM4Seh8auvYk8dYEmbFVy1TA==
X-Received: by 2002:a65:68d5:: with SMTP id k21mr1716047pgt.71.1597168805715;
        Tue, 11 Aug 2020 11:00:05 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e9sm26519359pfh.151.2020.08.11.11.00.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Aug 2020 11:00:05 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH] genirq/PM: Always unlock IRQ descriptor in rearm_wake_irq
Date:   Tue, 11 Aug 2020 11:00:01 -0700
Message-Id: <20200811180001.80203-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rearm_wake_irq() does not unlock the irq descriptor if the interrupt
is not suspended or if wakeup is not enabled on it. Fix it.

Fixes: 3a79bc63d9075 ("PCI: irq: Introduce rearm_wake_irq()")
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 kernel/irq/pm.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/irq/pm.c b/kernel/irq/pm.c
index 8f557fa1f4fe..c6c7e187ae74 100644
--- a/kernel/irq/pm.c
+++ b/kernel/irq/pm.c
@@ -185,14 +185,18 @@ void rearm_wake_irq(unsigned int irq)
 	unsigned long flags;
 	struct irq_desc *desc = irq_get_desc_buslock(irq, &flags, IRQ_GET_DESC_CHECK_GLOBAL);
 
-	if (!desc || !(desc->istate & IRQS_SUSPENDED) ||
-	    !irqd_is_wakeup_set(&desc->irq_data))
+	if (!desc)
 		return;
 
+	if (!(desc->istate & IRQS_SUSPENDED) ||
+	    !irqd_is_wakeup_set(&desc->irq_data))
+		goto unlock;
+
 	desc->istate &= ~IRQS_SUSPENDED;
 	irqd_set(&desc->irq_data, IRQD_WAKEUP_ARMED);
 	__enable_irq(desc);
 
+unlock:
 	irq_put_desc_busunlock(desc, flags);
 }
 
-- 
2.17.1

