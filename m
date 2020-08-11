Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AEABC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 18:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3097E20656
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 18:00:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZwrZBYZV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgHKSAS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 14:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbgHKSAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 14:00:17 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2894EC061788
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 11:00:17 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id c6so2265275pje.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 11:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=YlHjag65VttMM+YfhOohrfqL+EJ+OVADu+FKwDrWXSY=;
        b=ZwrZBYZVmpoNRK2PkVq1VD5vilGx+9Hns21575W2SHegdw01CF/V3BhQCkFOtv3aLG
         5QAwr/Xcm2yNDAAxrk7xsSbbvf0afvFVES6kj1iRIhooJxQNHiBjAOt3wBbhn9q0djhB
         V9PGIWVpCErOBVoGjbaS5FUi2ob4wILXVU6sIn+0fYm7B8/JH+GRcttUkH+fSnKTwDKR
         Dnk+c/bgG5eFmd1HPtEmGGa6Q6S4/zOeTiFoliS5I+bK8dNMglmzvkMg/3y+pG+H0/i2
         tl6XmSuo81gqZpi3oA9kLCoznXHT0bTPM7sR0mT736ndKeWPKzy5SJJPmXuFZ38/FLBs
         3wCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=YlHjag65VttMM+YfhOohrfqL+EJ+OVADu+FKwDrWXSY=;
        b=NHBS+VQEW1DXnYgzMagRw5cuJme0caL6y1c5KhcVjpAjUq8ZgBi50Z5SdXnbZzoFfY
         u9cxTYsQ34EyzxT/rUGZUxAbTgzO+m33iT4Q1j5Ewq14ABLsJzIxb8ZYjcCVSqOgvFVM
         z1ELAkKLlDcr2l+lW5yAgPey0H1+/ZjjiduO2GMsMXYFXli57/+nSfTrtVbZtRZvcb1r
         2uRZLoN5iGEQ8H9jAzYbSKqgIOWmXdDv6E///xRD02LXCsmpxZZ0Z0wOEC8LJRHBOVjj
         Ex4w2fDiGCB+93TbYIWPRBlwcOkceMDqhQLl2BbcRekkrC+yGaQh7om4pXuXalUFeNqD
         kuhA==
X-Gm-Message-State: AOAM5336e29bf5XHlhd4f6rZyn9qZx9De0GRWQFbIbQcv5SXVkRbWxDw
        KYFSEn12bJ/E3/9Shi+mQP4=
X-Google-Smtp-Source: ABdhPJxVpD/PTZH8BRSAhobDQKzGhi0L29kprRKIL8hyyk8cyRXeIKAhThCKywbk0F9IHFQgSHPJtA==
X-Received: by 2002:a17:90a:1d0f:: with SMTP id c15mr2367806pjd.180.1597168816740;
        Tue, 11 Aug 2020 11:00:16 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t63sm21777754pgt.50.2020.08.11.11.00.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Aug 2020 11:00:16 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Marek Vasut <marex@denx.de>
Subject: [PATCH] genirq: Unlock irq descriptor after errors
Date:   Tue, 11 Aug 2020 11:00:12 -0700
Message-Id: <20200811180012.80269-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In irq_set_irqchip_state(), the irq descriptor is not unlocked
after an error is encountered. While that should never happen
in practice, a buggy driver may trigger it. This would result
in a lockup, so let's fix it.

Fixes: 1d0326f352bb ("genirq: Check irq_data_get_irq_chip() return value before use")
Cc: Marek Vasut <marex@denx.de>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 kernel/irq/manage.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index d55ba625d426..52ac5391dcc6 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -2731,8 +2731,10 @@ int irq_set_irqchip_state(unsigned int irq, enum irqchip_irq_state which,
 
 	do {
 		chip = irq_data_get_irq_chip(data);
-		if (WARN_ON_ONCE(!chip))
-			return -ENODEV;
+		if (WARN_ON_ONCE(!chip)) {
+			err = -ENODEV;
+			goto out_unlock;
+		}
 		if (chip->irq_set_irqchip_state)
 			break;
 #ifdef CONFIG_IRQ_DOMAIN_HIERARCHY
@@ -2745,6 +2747,7 @@ int irq_set_irqchip_state(unsigned int irq, enum irqchip_irq_state which,
 	if (data)
 		err = chip->irq_set_irqchip_state(data, which, val);
 
+out_unlock:
 	irq_put_desc_busunlock(desc, flags);
 	return err;
 }
-- 
2.17.1

