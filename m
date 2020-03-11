Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5607DC10F27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 09:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32A8A20828
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 09:29:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728855AbgCKJ3e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 05:29:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:58292 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728263AbgCKJ3d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 05:29:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 256BEAB7F;
        Wed, 11 Mar 2020 09:29:32 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] tty: serial: pch_uart: Use scnprintf() for avoiding potential buffer overflow
Date:   Wed, 11 Mar 2020 10:29:30 +0100
Message-Id: <20200311092930.24433-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since snprintf() returns the would-be-output size instead of the
actual output size, the succeeding calls may go beyond the given
buffer limit.  Fix it by replacing with scnprintf().

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/tty/serial/pch_uart.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_uart.c
index 0a96217dba67..40fa7a27722d 100644
--- a/drivers/tty/serial/pch_uart.c
+++ b/drivers/tty/serial/pch_uart.c
@@ -310,32 +310,32 @@ static ssize_t port_show_regs(struct file *file, char __user *user_buf,
 	if (!buf)
 		return 0;
 
-	len += snprintf(buf + len, PCH_REGS_BUFSIZE - len,
+	len += scnprintf(buf + len, PCH_REGS_BUFSIZE - len,
 			"PCH EG20T port[%d] regs:\n", priv->port.line);
 
-	len += snprintf(buf + len, PCH_REGS_BUFSIZE - len,
+	len += scnprintf(buf + len, PCH_REGS_BUFSIZE - len,
 			"=================================\n");
-	len += snprintf(buf + len, PCH_REGS_BUFSIZE - len,
+	len += scnprintf(buf + len, PCH_REGS_BUFSIZE - len,
 			"IER: \t0x%02x\n", ioread8(priv->membase + UART_IER));
-	len += snprintf(buf + len, PCH_REGS_BUFSIZE - len,
+	len += scnprintf(buf + len, PCH_REGS_BUFSIZE - len,
 			"IIR: \t0x%02x\n", ioread8(priv->membase + UART_IIR));
-	len += snprintf(buf + len, PCH_REGS_BUFSIZE - len,
+	len += scnprintf(buf + len, PCH_REGS_BUFSIZE - len,
 			"LCR: \t0x%02x\n", ioread8(priv->membase + UART_LCR));
-	len += snprintf(buf + len, PCH_REGS_BUFSIZE - len,
+	len += scnprintf(buf + len, PCH_REGS_BUFSIZE - len,
 			"MCR: \t0x%02x\n", ioread8(priv->membase + UART_MCR));
-	len += snprintf(buf + len, PCH_REGS_BUFSIZE - len,
+	len += scnprintf(buf + len, PCH_REGS_BUFSIZE - len,
 			"LSR: \t0x%02x\n", ioread8(priv->membase + UART_LSR));
-	len += snprintf(buf + len, PCH_REGS_BUFSIZE - len,
+	len += scnprintf(buf + len, PCH_REGS_BUFSIZE - len,
 			"MSR: \t0x%02x\n", ioread8(priv->membase + UART_MSR));
-	len += snprintf(buf + len, PCH_REGS_BUFSIZE - len,
+	len += scnprintf(buf + len, PCH_REGS_BUFSIZE - len,
 			"BRCSR: \t0x%02x\n",
 			ioread8(priv->membase + PCH_UART_BRCSR));
 
 	lcr = ioread8(priv->membase + UART_LCR);
 	iowrite8(PCH_UART_LCR_DLAB, priv->membase + UART_LCR);
-	len += snprintf(buf + len, PCH_REGS_BUFSIZE - len,
+	len += scnprintf(buf + len, PCH_REGS_BUFSIZE - len,
 			"DLL: \t0x%02x\n", ioread8(priv->membase + UART_DLL));
-	len += snprintf(buf + len, PCH_REGS_BUFSIZE - len,
+	len += scnprintf(buf + len, PCH_REGS_BUFSIZE - len,
 			"DLM: \t0x%02x\n", ioread8(priv->membase + UART_DLM));
 	iowrite8(lcr, priv->membase + UART_LCR);
 
-- 
2.16.4

