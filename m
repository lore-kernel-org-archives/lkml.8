Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E66C3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 00:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 488D2206D5
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 00:41:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R9oc37cK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbgCDAlu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 19:41:50 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44755 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727864AbgCDAlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 19:41:49 -0500
Received: by mail-pl1-f194.google.com with SMTP id d9so185477plo.11
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 16:41:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=YfVtEcj6UdX9MlLwkKce0a0SqEPxlr08M2BShSj6sz4=;
        b=R9oc37cKM6HR31dE+cdHh63uIXBkHcKj2SVq4onjdIGuhpm8Yit6zSuo6nOjn8Icz9
         y/KaaDFRYq7lNQhoGjDagk7808ClitDdB7h+KWKqJPzF2irJsCDeGRwA2BLXkdjUbPDv
         r9FgnQ6k5kFNrOKDG0dAblsDTNUMMw7edVUmo4WBc17QwVkzCdyIFxTjAYdESmhj8uKA
         ZLVnLL1ZBP7fCG4f7NxcQEZd4sGmtjv8OTGoaTJl92u0EGEgiEBp9agcCmuY0KwFSnQf
         0gCm5ZmH53ly8bmjStQah6mIbr1sHLJaS38TrRMSL+sxtvQdbZOOgOO4rsCyvYy2TDuQ
         5log==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YfVtEcj6UdX9MlLwkKce0a0SqEPxlr08M2BShSj6sz4=;
        b=oKFqI60zoAX8azaoCtklxcA2uHolcA3cc6uXGQMcrWwyXML9tOUYCpkKxlIPmlsjUw
         nYIFUDbExmRXw3v+O9qNqiuHBStqKK8SJlbEsW0L49gHTXd1l3Zkz6VnUY5mPssR6A6w
         9MW4SglKUgetSgA4gVmz5kBBXvkp/Cvvl9nyFgDmxyMvLk8CcS2EfV2QxgjMEOs/SRCd
         McMv6GCXvTk9KB02cDxNO8/5Fp9YPoutDG8K1DwLnnNU1GHjUuxprLXDlqNxCnM9tIlM
         AJQk6EnzeOcudYxJtiwBUx7RkShBkD5ikBn5PDTqSIor1rURiOElsQHJkaTaOqUCSJ78
         sTBw==
X-Gm-Message-State: ANhLgQ0GJCmC35PXPhi/cSBc7XTjXFUNBg3qBJgyDuHRM4Q1guNeB5m/
        3QUktdBP73E24vCvKQanBW4=
X-Google-Smtp-Source: ADFU+vt1gCahnrlQeMaYVKC5/bMhhu48XKBNXqUNxKizUN0ORK7QP6GixhG6CpGGLEHwP9buzORqfw==
X-Received: by 2002:a17:90a:da03:: with SMTP id e3mr233283pjv.57.1583282508819;
        Tue, 03 Mar 2020 16:41:48 -0800 (PST)
Received: from localhost.localdomain ([106.51.232.35])
        by smtp.gmail.com with ESMTPSA id x190sm26416523pfb.96.2020.03.03.16.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 16:41:48 -0800 (PST)
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     linux-c6x-dev@linux-c6x.org, linux-kernel@vger.kernel.org
Cc:     afzal mohammed <afzal.mohd.ma@gmail.com>,
        Mark Salter <msalter@redhat.com>,
        Aurelien Jacquiot <jacquiot.aurelien@gmail.com>
Subject: [PATCH v3] c6x: replace setup_irq() by request_irq()
Date:   Wed,  4 Mar 2020 06:11:43 +0530
Message-Id: <20200304004143.3960-1-afzal.mohd.ma@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

request_irq() is preferred over setup_irq(). Invocations of setup_irq()
occur after memory allocators are ready.

Per tglx[1], setup_irq() existed in olden days when allocators were not
ready by the time early interrupts were initialized.

Hence replace setup_irq() by request_irq().

[1] https://lkml.kernel.org/r/alpine.DEB.2.20.1710191609480.1971@nanos

Signed-off-by: afzal mohammed <afzal.mohd.ma@gmail.com>
---
Hi Mark Salter,

i believe you are the maintainer of c6x, if you are okay w/ this change,
please consider taking it thr' your tree, else please let me know.

Regards
afzal

Link to v2 & v1,
[v2] https://lkml.kernel.org/r/cover.1582471508.git.afzal.mohd.ma@gmail.com
[v1] https://lkml.kernel.org/r/cover.1581478323.git.afzal.mohd.ma@gmail.com

v3:
 * Split out from tree wide series, as Thomas suggested to get it thr'
	respective maintainers
 * Modify pr_err displayed in case of error
 * Re-arrange code & choose pr_err args as required to improve readability
 * Remove irrelevant parts from commit message & improve
 
v2:
 * Replace pr_err("request_irq() on %s failed" by
           pr_err("%s: request_irq() failed"
 * Commit message massage

 arch/c6x/platforms/timer64.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/c6x/platforms/timer64.c b/arch/c6x/platforms/timer64.c
index d98d94303498..661f4c7c6ef6 100644
--- a/arch/c6x/platforms/timer64.c
+++ b/arch/c6x/platforms/timer64.c
@@ -165,13 +165,6 @@ static irqreturn_t timer_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static struct irqaction timer_iact = {
-	.name		= "timer",
-	.flags		= IRQF_TIMER,
-	.handler	= timer_interrupt,
-	.dev_id		= &t64_clockevent_device,
-};
-
 void __init timer64_init(void)
 {
 	struct clock_event_device *cd = &t64_clockevent_device;
@@ -238,7 +231,9 @@ void __init timer64_init(void)
 	cd->cpumask		= cpumask_of(smp_processor_id());
 
 	clockevents_register_device(cd);
-	setup_irq(cd->irq, &timer_iact);
+	if (request_irq(cd->irq, timer_interrupt, IRQF_TIMER, "timer",
+			&t64_clockevent_device))
+		pr_err("Failed to request irq %d (timer)\n", cd->irq);
 
 out:
 	of_node_put(np);
-- 
2.25.1

