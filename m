Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F227CC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 14:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD5EA20732
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 14:28:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S8TezEvu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729825AbgFVO17 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 10:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729816AbgFVO1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 10:27:55 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8DE0C061573
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 07:27:55 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id p3so5532953pgh.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 07:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JRSHvl6U+IZL0NsvNZuwTx0bEAhR9MBQN7axB8epcUs=;
        b=S8TezEvuiSh9r4tBiJ8Y0oZfklqL3bPKvd/7r3OyPqXHHov7Otay0asDWDli0VDaTF
         KFKyvZN2KacrOaS0MVEXkb9jRAT3dQ4+Cf6+zAfEvJedm3lyOYDDTqLOfN/36anHjr9r
         KsqPKjJzOfSAwUn3oO5oleQ5ofNvOhbgSz8gIHtWYPg+o2u7HtyH8K3QJE5pq3xfJxCf
         709Ko3xFJDv3Pq4cJf9abD0OkIiy+mcEygCEca/dxQTzzLvArfOFqQzOToCln2rtZ7F3
         ckoSN05a+EOUNIWgO9ziPfaAC+soDU1jlx1wKcwKemwABOOuuzqjb6b6ae8iByzjA2HG
         bZ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JRSHvl6U+IZL0NsvNZuwTx0bEAhR9MBQN7axB8epcUs=;
        b=SZzEvk+kIh7Vyj0sVKisXoY6Oglp+iCejEwEUgH5/TTPjEYUeeQ7WDv3sGXK/EvWV0
         tDwbuT/RFgCzuj3A0MNXV+JVM9chsKme0Ffo0VUYc0ymfyLYHJQ5J1KmcpxQKJfbl16g
         I7RzcLRweOWbJ4dH+VDJmHWEv6AreiLI9jaE67OOpAVi9IFOhvZvlb8//R68l/6+B7P1
         avFv8lTnZ8VdalYrdCMuuot3CBJ0O3P3g62zTx6DLb61vvuGGyZT9cuOhzlddbAswo7E
         U9YEg5/4owQ1lEEnVZHs4t646AXSvrmdhfS2vw8uTY1mKlC3UGBZZ5MMyzowC46cSjhT
         vVcQ==
X-Gm-Message-State: AOAM532cY1KFXHZSHwoaDJS8cHxNjONZ4Csw8+oCbeyw0wdnkAVoullM
        uzBD93fTJIUMr5K+BG1hU83jxQ==
X-Google-Smtp-Source: ABdhPJyMPNkXvDSph4eqALLF9WLDlS7kA1v1tH/G8OVD2Popzc1/lGc77i3S8lr2qBs9cq2g8vL/bQ==
X-Received: by 2002:a63:d652:: with SMTP id d18mr13372987pgj.164.1592836075366;
        Mon, 22 Jun 2020 07:27:55 -0700 (PDT)
Received: from localhost.localdomain ([117.252.67.186])
        by smtp.gmail.com with ESMTPSA id d6sm14547939pjh.5.2020.06.22.07.27.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jun 2020 07:27:54 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, daniel.thompson@linaro.org,
        jason.wessel@windriver.com, dianders@chromium.org, jslaby@suse.com,
        linux@armlinux.org.uk, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH 7/7] serial: kgdb_nmi: Replace hrtimer with irq_work ping
Date:   Mon, 22 Jun 2020 19:56:24 +0530
Message-Id: <1592835984-28613-8-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592835984-28613-1-git-send-email-sumit.garg@linaro.org>
References: <1592835984-28613-1-git-send-email-sumit.garg@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Thompson <daniel.thompson@linaro.org>

Currently kgdb_nmi relies on a 100Hz timer to "defer" work from an NMI
handler. This is essentially doing the job that irq_work is designed to
do but in an odd and inefficient manner. Remove the timer code and
replace it with more appropriate irq_work related APIs.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 drivers/tty/serial/kgdb_nmi.c | 35 ++++++++++-------------------------
 1 file changed, 10 insertions(+), 25 deletions(-)

diff --git a/drivers/tty/serial/kgdb_nmi.c b/drivers/tty/serial/kgdb_nmi.c
index 2580f39..ad84eef 100644
--- a/drivers/tty/serial/kgdb_nmi.c
+++ b/drivers/tty/serial/kgdb_nmi.c
@@ -21,7 +21,7 @@
 #include <linux/tty_flip.h>
 #include <linux/serial_core.h>
 #include <linux/interrupt.h>
-#include <linux/hrtimer.h>
+#include <linux/irq_work.h>
 #include <linux/tick.h>
 #include <linux/kfifo.h>
 #include <linux/kgdb.h>
@@ -127,7 +127,7 @@ static struct console kgdb_nmi_console = {
 
 struct kgdb_nmi_tty_priv {
 	struct tty_port port;
-	struct timer_list timer;
+	struct irq_work work;
 	STRUCT_KFIFO(char, KGDB_NMI_FIFO_SIZE) fifo;
 };
 
@@ -141,13 +141,12 @@ static void kgdb_tty_recv(int ch)
 	if (!kgdb_nmi_port || ch < 0)
 		return;
 	/*
-	 * Can't use port->tty->driver_data as tty might be not there. Timer
-	 * will check for tty and will get the ref, but here we don't have to
-	 * do that, and actually, we can't: we're in NMI context, no locks are
-	 * possible.
+	 * Can't use port->tty->driver_data as tty might be not there. Also, we
+	 * can't even do that as we're in NMI context, no locks are possible.
 	 */
 	priv = container_of(kgdb_nmi_port, struct kgdb_nmi_tty_priv, port);
 	kfifo_in(&priv->fifo, &c, 1);
+	irq_work_queue(&priv->work);
 }
 
 static int kgdb_nmi_poll_one_knock(void)
@@ -222,18 +221,12 @@ bool kgdb_nmi_poll_knock(void)
 	return true;
 }
 
-/*
- * The tasklet is cheap, it does not cause wakeups when reschedules itself,
- * instead it waits for the next tick.
- */
-static void kgdb_nmi_tty_receiver(struct timer_list *t)
+static void kgdb_nmi_tty_receiver(struct irq_work *work)
 {
-	struct kgdb_nmi_tty_priv *priv = from_timer(priv, t, timer);
+	struct kgdb_nmi_tty_priv *priv =
+	    container_of(work, struct kgdb_nmi_tty_priv, work);
 	char ch;
 
-	priv->timer.expires = jiffies + (HZ/100);
-	add_timer(&priv->timer);
-
 	if (likely(!atomic_read(&kgdb_nmi_num_readers) ||
 		   !kfifo_len(&priv->fifo)))
 		return;
@@ -245,22 +238,13 @@ static void kgdb_nmi_tty_receiver(struct timer_list *t)
 
 static int kgdb_nmi_tty_activate(struct tty_port *port, struct tty_struct *tty)
 {
-	struct kgdb_nmi_tty_priv *priv =
-	    container_of(port, struct kgdb_nmi_tty_priv, port);
-
 	kgdb_nmi_port = port;
-	priv->timer.expires = jiffies + (HZ/100);
-	add_timer(&priv->timer);
 
 	return 0;
 }
 
 static void kgdb_nmi_tty_shutdown(struct tty_port *port)
 {
-	struct kgdb_nmi_tty_priv *priv =
-	    container_of(port, struct kgdb_nmi_tty_priv, port);
-
-	del_timer(&priv->timer);
 	kgdb_nmi_port = NULL;
 }
 
@@ -279,7 +263,8 @@ static int kgdb_nmi_tty_install(struct tty_driver *drv, struct tty_struct *tty)
 		return -ENOMEM;
 
 	INIT_KFIFO(priv->fifo);
-	timer_setup(&priv->timer, kgdb_nmi_tty_receiver, 0);
+	init_irq_work(&priv->work, kgdb_nmi_tty_receiver);
+	atomic_set(&priv->work.flags, IRQ_WORK_LAZY);
 	tty_port_init(&priv->port);
 	priv->port.ops = &kgdb_nmi_tty_port_ops;
 	tty->driver_data = priv;
-- 
2.7.4

