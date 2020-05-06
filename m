Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A63EC28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 07:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 403B020747
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 07:23:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="b6GeJ8UP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728335AbgEFHXi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 03:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727842AbgEFHXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 03:23:35 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF661C061A0F
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 00:23:35 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id hi11so434280pjb.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 00:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Fze5y+aKClh/oN5ITL+3asoB6Hf78k3jqX6stiIJKcY=;
        b=b6GeJ8UPMHmMtngVK6oP7jgFPERIM/MP+rQoEKWeDRP6IYT61AIk/DyPtbsELKkJjP
         NntpASpXHm/XVrfEFPd6iq0VNv4d7bhlHyBMQpbm7uq1Jg/VMi1K7cIBRrPNtMHAvDkt
         tB2YjES4xTYtAzvKwTUkasbONsz2/7ry000ck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fze5y+aKClh/oN5ITL+3asoB6Hf78k3jqX6stiIJKcY=;
        b=L1n+SS5JpcBb2CN1yUIJmC1s/v3d8XWuya1sD6udKKNWf33NgxCHrMM3zcUGkRXuJ+
         Rx58Cxs9n/JhkQH+xWxGNTn0lsuXvGSQgTOn8lFJswhvuzBalChzypmaOChVXwdkWM4F
         fRb1a0485q2nu+NJzuONkwAK4U1WcZJEaFcyB9B/CuPIpnjM/IWEWHp8vyud/8XvXgfX
         0KQ09/uobPnjuPHjIyqK+NSMZD7ObRuMEkojh+cQFc9pyNvXLyHEQAsmiYrq6uoJZU+z
         oFUjEZ+XzcZH10LB+XpZRzMktT8rUt8f/WD1bqI4UBKIGfLAa2uGN8VEEQe+XTMXZdio
         694A==
X-Gm-Message-State: AGi0PubCJKlXxh9TRrqyokWYY7KbGAolE2ea00I68qXQaluk3tNkhY7z
        7jP5bUOrk3lBRLKcmYe2WPEBwg==
X-Google-Smtp-Source: APiQypJEvMODLnMzIV3b0m4nrv11Ky4vgltOYbvUg4ZEskSuldeLgaEBh3RVHEyvggyqkyGztVJPAQ==
X-Received: by 2002:a17:90a:2949:: with SMTP id x9mr7656502pjf.33.1588749815268;
        Wed, 06 May 2020 00:23:35 -0700 (PDT)
Received: from localhost ([2401:fa00:1:10:3db2:76bf:938b:be05])
        by smtp.gmail.com with ESMTPSA id o7sm948044pgs.35.2020.05.06.00.23.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2020 00:23:34 -0700 (PDT)
From:   Claire Chang <tientzu@chromium.org>
To:     robh@kernel.org, gregkh@linuxfoundation.org, jslaby@suse.com,
        long.cheng@mediatek.com, changqi.hu@mediatek.com
Cc:     linux-serial@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org, Claire Chang <tientzu@chromium.org>
Subject: [PATCH 2/3] tty: serial_core: add wakeup_irq to support in-band wakeup
Date:   Wed,  6 May 2020 15:23:13 +0800
Message-Id: <20200506072314.112409-3-tientzu@chromium.org>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
In-Reply-To: <20200506072314.112409-1-tientzu@chromium.org>
References: <20200506072314.112409-1-tientzu@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since some uart controllers may be off in S3, we won't be able to use
the normal in-band wakeup.

Take 8250_mtk.c as an example. The driver needs to allocate an edge
sensitive interrupt as the wakeup_irq and use an addtional pinctrl to
reconfigure Rx pin to normal GPIO in sleep state. Once host detects Rx
falling, an interrupt is triggered, and the system leaves sleep state.

Add the wakeup_irq logic in core to simplify and make the code more
generic. Also, we can align with the original wakeup behavior and
power/wakeup node.

Signed-off-by: Claire Chang <tientzu@chromium.org>
---
 drivers/tty/serial/8250/8250_core.c | 1 +
 drivers/tty/serial/serial_core.c    | 8 +++++---
 include/linux/serial_core.h         | 1 +
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 45d9117cab680..06214e9fdc8ff 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -1001,6 +1001,7 @@ int serial8250_register_8250_port(struct uart_8250_port *up)
 		uart->port.membase      = up->port.membase;
 		uart->port.irq          = up->port.irq;
 		uart->port.irqflags     = up->port.irqflags;
+		uart->port.wakeup_irq	= up->port.wakeup_irq;
 		uart->port.uartclk      = up->port.uartclk;
 		uart->port.fifosize     = up->port.fifosize;
 		uart->port.regshift     = up->port.regshift;
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 66a5e2faf57ea..1796a33986613 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2165,12 +2165,13 @@ int uart_suspend_port(struct uart_driver *drv, struct uart_port *uport)
 	struct tty_port *port = &state->port;
 	struct device *tty_dev;
 	struct uart_match match = {uport, drv};
+	int irq = uport->wakeup_irq > 0 ? uport->wakeup_irq : uport->irq;
 
 	mutex_lock(&port->mutex);
 
 	tty_dev = device_find_child(uport->dev, &match, serial_match_port);
 	if (tty_dev && device_may_wakeup(tty_dev)) {
-		enable_irq_wake(uport->irq);
+		enable_irq_wake(irq);
 		put_device(tty_dev);
 		mutex_unlock(&port->mutex);
 		return 0;
@@ -2228,13 +2229,14 @@ int uart_resume_port(struct uart_driver *drv, struct uart_port *uport)
 	struct device *tty_dev;
 	struct uart_match match = {uport, drv};
 	struct ktermios termios;
+	int irq = uport->wakeup_irq > 0 ? uport->wakeup_irq : uport->irq;
 
 	mutex_lock(&port->mutex);
 
 	tty_dev = device_find_child(uport->dev, &match, serial_match_port);
 	if (!uport->suspended && device_may_wakeup(tty_dev)) {
-		if (irqd_is_wakeup_set(irq_get_irq_data((uport->irq))))
-			disable_irq_wake(uport->irq);
+		if (irqd_is_wakeup_set(irq_get_irq_data((irq))))
+			disable_irq_wake(irq);
 		put_device(tty_dev);
 		mutex_unlock(&port->mutex);
 		return 0;
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 92f5eba860528..5764687b90a36 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -136,6 +136,7 @@ struct uart_port {
 						  struct serial_iso7816 *iso7816);
 	unsigned int		irq;			/* irq number */
 	unsigned long		irqflags;		/* irq flags  */
+	unsigned int		wakeup_irq;		/* wakeup irq number */
 	unsigned int		uartclk;		/* base uart clock */
 	unsigned int		fifosize;		/* tx fifo size */
 	unsigned char		x_char;			/* xon/xoff char */
-- 
2.26.2.526.g744177e7f7-goog

