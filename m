Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED3EAC5518A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 08:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB58820724
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 08:15:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U+zdC02v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbgDXIPA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 04:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbgDXIO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 04:14:59 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58281C09B046
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 01:14:59 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id h12so2508243pjz.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 01:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=mD/kfPP0LJg4RaHAfHE48TNR0vDMyG0NIvrIYBVARm4=;
        b=U+zdC02vPpa+dW82b5konrmLSoLeQfS1bxJbZyxDYPtJKTL3/ZyaLfUT22Gh6Hb+yQ
         vdpuVUFR5Mj1U4PSuIHGD9vUt25BRP+1dzf9tl3AD96LnDwcN6PcX2bO0PjuUsRDonzE
         9d6O9Ud5RgNBiAloHqRMT9G9djQlKWVxNbQzxSkyu0cFFZIapMhibJhxYCmCumNEy2l0
         RU4FIW+Ag6a1rTMYezFeBuu0zZiNE2Iakx8gDg2vyuxt8qajobywkK6QL1duo3J9Ai35
         IqnNw40CcBuZ0757a4pwrHuhSXUQeHr+vz39ybQUYZ4+1/vvaVA5kjFpoC/7I/hYcvSs
         Enig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mD/kfPP0LJg4RaHAfHE48TNR0vDMyG0NIvrIYBVARm4=;
        b=n1otj2MmiwjZwErZP8uNoK7dUUHZUBtals1UKajDfr/9U+GjjeylwdP41U8bt1Oe+P
         hUEHZHI8Fduo5BxdMoxzP8VBXUkOj2VB+1TeBdmat4TZzvB8+EJITVLIdbXJJ2wBP7mZ
         c+UGskx2NobOqQsrw8L9Wyh/72+agg6PsKdUGSvBjskYYUYKt+UR3DjVOi+qI770c1b/
         WWOX1eAw27DRojUdzFbbRnYJhrt0jNHbYUi5x2kD+T7457X8wV6HxxtK8QLWVtIjyBq/
         RN4Z0ZwOUPd8O/OCeN1BiAWD8oYzHv+qpYm7wNAclzVzAqDk2sX3usy/EOyY/dcWSkJa
         /8vA==
X-Gm-Message-State: AGi0PuZqOhvGsFVcsbW52tAt0jweZov154Jdy50sq/72QGvaKtcASulJ
        11oHb5EYq7z6hZZDvfMaoIOJxg==
X-Google-Smtp-Source: APiQypJghaVt/q6zmxXTjSbtQU6fVWfz/4mYcA8lUSSczTk75+y04uRfK5Ppid1rBINUIfxzC7tJRg==
X-Received: by 2002:a17:902:7593:: with SMTP id j19mr8125373pll.62.1587716098746;
        Fri, 24 Apr 2020 01:14:58 -0700 (PDT)
Received: from localhost.localdomain ([117.252.71.186])
        by smtp.gmail.com with ESMTPSA id q201sm5080005pfq.40.2020.04.24.01.14.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Apr 2020 01:14:57 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     dianders@chromium.org, linux-serial@vger.kernel.org
Cc:     linux@armlinux.org.uk, gregkh@linuxfoundation.org, jslaby@suse.com,
        daniel.thompson@linaro.org, jason.wessel@windriver.com,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH] serial: amba-pl011: Support earlycon_kgdboc
Date:   Fri, 24 Apr 2020 13:43:51 +0530
Message-Id: <1587716031-28199-1-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement the read() function in the early console driver. With
recently added earlycon_kgdboc feature, this allows you to use kgdb
to debug fairly early into the system boot.

We only bother implementing this if polling is enabled since kgdb can't
be enabled without that.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---

Depends on kgdb patch series: https://lkml.org/lkml/2020/4/21/1179

 drivers/tty/serial/amba-pl011.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 2296bb0..c010f63 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2435,6 +2435,37 @@ static void pl011_early_write(struct console *con, const char *s, unsigned n)
 	uart_console_write(&dev->port, s, n, pl011_putc);
 }
 
+#ifdef CONFIG_CONSOLE_POLL
+static int pl011_getc(struct uart_port *port)
+{
+	if (readl(port->membase + UART01x_FR) & UART01x_FR_RXFE)
+		return NO_POLL_CHAR;
+
+	if (port->iotype == UPIO_MEM32)
+		return readl(port->membase + UART01x_DR);
+	else
+		return readb(port->membase + UART01x_DR);
+}
+
+static int pl011_early_read(struct console *con, char *s, unsigned int n)
+{
+	struct earlycon_device *dev = con->data;
+	int ch, num_read = 0;
+
+	while (num_read < n) {
+		ch = pl011_getc(&dev->port);
+		if (ch == NO_POLL_CHAR)
+			break;
+
+		s[num_read++] = ch;
+	}
+
+	return num_read;
+}
+#else
+#define pl011_early_read NULL
+#endif
+
 /*
  * On non-ACPI systems, earlycon is enabled by specifying
  * "earlycon=pl011,<address>" on the kernel command line.
@@ -2454,6 +2485,7 @@ static int __init pl011_early_console_setup(struct earlycon_device *device,
 		return -ENODEV;
 
 	device->con->write = pl011_early_write;
+	device->con->read = pl011_early_read;
 
 	return 0;
 }
-- 
2.7.4

