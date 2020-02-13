Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA772C3B18B
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88A90217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581608421;
	bh=LkzOpvLNFl2lEwT/T4BDYoR8AVuZdWX6UF//DtE/FSU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TRWhHJi8xohCmZrt5wnQs4MKcKxA1mL3ImFf48+7cgXlhhNcOyxWH8q6jQb9S0EiT
	 cA38/9tEYIxqB+4bUzvdVjjbPLZMhvwx21MuBKnyxF8sRyVQTw+sN2Es2YFHHsh/Pr
	 9PUvBVxXMy4vA1JdyBOvokf7TCsPSnSiTz6YYnDM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387693AbgBMP2p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:28:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:44220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729192AbgBMP0O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:26:14 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F9CC20848;
        Thu, 13 Feb 2020 15:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607573;
        bh=LkzOpvLNFl2lEwT/T4BDYoR8AVuZdWX6UF//DtE/FSU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fal4O9kGRV3d5bibcBmI7oHM6rUkSHOWsxBZKHfTlOB1DfLYLpYTdCRMY6+K7JMia
         JBTAO+x4JRUBbeGOvxGbQOECcVYZVLYufn4ysAbYYqfQehhQx7FtArcFuj9k3VTzbH
         FwEKbG0C4F9xqmxYYFqeQ3yWWZT55K6iJF9w+bzI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jean-Francois Dagenais <jeff.dagenais@gmail.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 150/173] serial: uartps: Add a timeout to the tx empty wait
Date:   Thu, 13 Feb 2020 07:20:53 -0800
Message-Id: <20200213152009.387256080@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151931.677980430@linuxfoundation.org>
References: <20200213151931.677980430@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>

[ Upstream commit 277375b864e8147975b064b513f491e2a910e66a ]

In case the cable is not connected then the target gets into
an infinite wait for tx empty.
Add a timeout to the tx empty wait.

Reported-by: Jean-Francois Dagenais <jeff.dagenais@gmail.com>
Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/xilinx_uartps.c |   14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -31,6 +31,7 @@
 #include <linux/of.h>
 #include <linux/module.h>
 #include <linux/pm_runtime.h>
+#include <linux/iopoll.h>
 
 #define CDNS_UART_TTY_NAME	"ttyPS"
 #define CDNS_UART_NAME		"xuartps"
@@ -39,6 +40,7 @@
 #define CDNS_UART_NR_PORTS	2
 #define CDNS_UART_FIFO_SIZE	64	/* FIFO size */
 #define CDNS_UART_REGISTER_SPACE	0x1000
+#define TX_TIMEOUT		500000
 
 /* Rx Trigger level */
 static int rx_trigger_level = 56;
@@ -685,16 +687,20 @@ static void cdns_uart_set_termios(struct
 	unsigned int cval = 0;
 	unsigned int baud, minbaud, maxbaud;
 	unsigned long flags;
-	unsigned int ctrl_reg, mode_reg;
+	unsigned int ctrl_reg, mode_reg, val;
+	int err;
 
 	spin_lock_irqsave(&port->lock, flags);
 
 	/* Wait for the transmit FIFO to empty before making changes */
 	if (!(readl(port->membase + CDNS_UART_CR) &
 				CDNS_UART_CR_TX_DIS)) {
-		while (!(readl(port->membase + CDNS_UART_SR) &
-				CDNS_UART_SR_TXEMPTY)) {
-			cpu_relax();
+		err = readl_poll_timeout(port->membase + CDNS_UART_SR,
+					 val, (val & CDNS_UART_SR_TXEMPTY),
+					 1000, TX_TIMEOUT);
+		if (err) {
+			dev_err(port->dev, "timed out waiting for tx empty");
+			return;
 		}
 	}
 


