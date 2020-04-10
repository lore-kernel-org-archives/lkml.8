Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A2D7C2D0EC
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 22:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D8CD20936
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 22:18:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A8zixFy3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbgDJWSd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 18:18:33 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41901 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726806AbgDJWSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 18:18:30 -0400
Received: by mail-pl1-f195.google.com with SMTP id d24so1083171pll.8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Apr 2020 15:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7A6FUrEihYonXIpPhnCErlWl+4ZFT4mvYVljlFWGAP4=;
        b=A8zixFy38mun90CDAXlagVbAIIVwh9/25A/e43Q9RCFDEn+rOp9ZVO0j0mSlXrQ8vT
         YYiCKZpKJT2bIMJS9e7wnmEAtxwvF+vg9K8vHguKd7KWs8bmd0/ZXCQbNchlmGQ6f5id
         QXT8w0UcQ7ThQOglUn/LWks0X9xwLGASWJRQM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7A6FUrEihYonXIpPhnCErlWl+4ZFT4mvYVljlFWGAP4=;
        b=Br/pWC6PW0qZ94tV23Vz6sHd0utK3OevHsj/ye2+KKYes8a2Xv04sl37HDP+FTx5kV
         4Cz8WRl88lrhMNZcRs5BdW+P5V3MiBF+TB/2rSLqJekXMkDHmU1YS7/dRLDhmAbbENbz
         jmi3XhUIi/7VHqZlqfsZME5uj0iBSPf4yea+JcGhKCw8p70BtwLZkW/pfGIphMBxrdYv
         cTKMLTJHwgf82ta+rX+e7Lw/JmB7B9r6X184Ibij4rT7OpVPE2LcVDSORTpIFC+LeO6L
         Vyp60pzmwXrsSYPyUG73e7GDL5WQ/c5cnZEN6oQ9b4uoFgebX5KIK95nMDV/low61BuE
         2usg==
X-Gm-Message-State: AGi0PuaYq3BBEBO7fbtZ1+R0BQhgd1PR/CxECu0fvAHs2IblPebrlTex
        3bFD3H7j9mRDMHFokjnQTXns2g==
X-Google-Smtp-Source: APiQypJBkfxcG7ETfLq/uX0qKEMzrTaauzB9axhptLbpfS46Oj3ffr4yc5nX4ePFLIoum7gB6Llgbg==
X-Received: by 2002:a17:90b:4902:: with SMTP id kr2mr5571773pjb.152.1586557108150;
        Fri, 10 Apr 2020 15:18:28 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id x2sm2646600pfq.92.2020.04.10.15.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 15:18:27 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     jason.wessel@windriver.com, daniel.thompson@linaro.org,
        gregkh@linuxfoundation.org
Cc:     hpa@zytor.com, kgdb-bugreport@lists.sourceforge.net,
        corbet@lwn.net, frowand.list@gmail.com, tglx@linutronix.de,
        jslaby@suse.com, linux-serial@vger.kernel.org, mingo@redhat.com,
        will@kernel.org, bjorn.andersson@linaro.org, agross@kernel.org,
        bp@alien8.de, catalin.marinas@arm.com,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] serial: 8250_early: Support earlycon_kgdboc
Date:   Fri, 10 Apr 2020 15:17:26 -0700
Message-Id: <20200410151632.7.I8f668556c244776523320a95b09373a86eda11b7@changeid>
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
In-Reply-To: <20200410221726.36442-1-dianders@chromium.org>
References: <20200410221726.36442-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement the read() function in the early console driver.  With
recent kgdb patches this allows you to use kgdb to debug fairly early
into the system boot.

We only bother implementing this if polling is enabled since kgdb
can't be enabled without that.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/tty/serial/8250/8250_early.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_early.c b/drivers/tty/serial/8250/8250_early.c
index 5cd8c36c8fcc..70d7826788f5 100644
--- a/drivers/tty/serial/8250/8250_early.c
+++ b/drivers/tty/serial/8250/8250_early.c
@@ -109,6 +109,28 @@ static void early_serial8250_write(struct console *console,
 	uart_console_write(port, s, count, serial_putc);
 }
 
+#ifdef CONFIG_CONSOLE_POLL
+static int early_serial8250_read(struct console *console,
+				 char *s, unsigned int count)
+{
+	struct earlycon_device *device = console->data;
+	struct uart_port *port = &device->port;
+	unsigned int status;
+	int num_read = 0;
+
+	while (num_read < count) {
+		status = serial8250_early_in(port, UART_LSR);
+		if (!(status & UART_LSR_DR))
+			break;
+		s[num_read++] = serial8250_early_in(port, UART_RX);
+	}
+
+	return num_read;
+}
+#else
+#define early_serial8250_read NULL
+#endif
+
 static void __init init_port(struct earlycon_device *device)
 {
 	struct uart_port *port = &device->port;
@@ -149,6 +171,7 @@ int __init early_serial8250_setup(struct earlycon_device *device,
 		init_port(device);
 
 	device->con->write = early_serial8250_write;
+	device->con->read = early_serial8250_read;
 	return 0;
 }
 EARLYCON_DECLARE(uart8250, early_serial8250_setup);
-- 
2.26.0.110.g2183baf09c-goog

