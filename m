Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E5B1C352A5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 17:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77EEA20715
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 17:18:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ida80gId"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbgBJRSc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 12:18:32 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44496 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728076AbgBJRSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 12:18:31 -0500
Received: by mail-pf1-f196.google.com with SMTP id y5so4000184pfb.11
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 09:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v1m3szixNNxqjJUkavyYJIqiPZ7qr/6fxUicwspS2io=;
        b=Ida80gId7m9pRTcadNu1W/yKqwdtw5HjP69hchYyNRMQBGhdtRVz5RU2Qn3LzcVjsN
         O7mjhrKWpBoAk3U5Lb8uaaNL5A7ZQJh6GPq/NkBYpYDXbaMasKse5Vx6y4WCnsERhGBG
         D4ge1l4m66JEAfEs4kQajXzWp6YGfHOM7EdKAefI7TFWIcaI0aaVEkQnp2XMvz4dFh0E
         eITuZeCX6Vh0hFuZVwqeDV7e8nwjsLKsGkbjDCUFyvYp/K5ewyvbfmlwVEmR/3EFH3R4
         DYrbch5xhMIeYtSE9RC5rpkVm+Fz9uQ1Ma2q/8OtINR2aMztLUn76HEODyv0xKkfhJeL
         5J6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v1m3szixNNxqjJUkavyYJIqiPZ7qr/6fxUicwspS2io=;
        b=fcq7jaH5LAkH03paoOTS00asYO9qReFA99lh3mVvU5cnJwngSwVKJssURRt0YguaY0
         KQV3F6X8uB/1WoKXDOo76qicpsb5sRg23UFnWaoUq85U0XKkXkWQbjrjI9UfQ+uk58/W
         w9DJl/AHBDkQjHn/Wn95oVumY7nFOL4WGamBrwq3APkrviMotW52DzZaJyR5CLHEFSZS
         b8B2zLNbY/sNLD3uiqsbvYiXfTVXGWVCrD+ZtMfLUfY3W/Ehl2KuuIVIVcnbUEAtAEeV
         /EirEFGw+amI1SR36Z/VH5sZyaLoEjXe5X2ed1ldzAETNVTIFOllKQP2km3YHyC4KEak
         Ig4Q==
X-Gm-Message-State: APjAAAX3QZJmrdXWfqnyfIE+4kFFG+BX8vKNQNFkZNAq4dIA3JDWYg/u
        JainSKuJtx6i30cvGm0pXMrzMw==
X-Google-Smtp-Source: APXvYqw/ziNSHg8r1MM+SH4sKafoKXakim4EOt5afmfAk2LloHapG11eVkwxVMeDNH0OQNwK4CLHEg==
X-Received: by 2002:a62:53c3:: with SMTP id h186mr2089100pfb.118.1581355110168;
        Mon, 10 Feb 2020 09:18:30 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id u12sm927912pfm.165.2020.02.10.09.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 09:18:29 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     stable@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [stable 4.19][PATCH 1/3] serial: uartps: Add a timeout to the tx empty wait
Date:   Mon, 10 Feb 2020 10:18:25 -0700
Message-Id: <20200210171827.29693-2-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200210171827.29693-1-mathieu.poirier@linaro.org>
References: <20200210171827.29693-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>

commit 277375b864e8147975b064b513f491e2a910e66a upstream

In case the cable is not connected then the target gets into
an infinite wait for tx empty.
Add a timeout to the tx empty wait.

Reported-by: Jean-Francois Dagenais <jeff.dagenais@gmail.com>
Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable <stable@vger.kernel.org> # 4.19
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/tty/serial/xilinx_uartps.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 66d49d511885..7cbee19ea93d 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -26,6 +26,7 @@
 #include <linux/of.h>
 #include <linux/module.h>
 #include <linux/pm_runtime.h>
+#include <linux/iopoll.h>
 
 #define CDNS_UART_TTY_NAME	"ttyPS"
 #define CDNS_UART_NAME		"xuartps"
@@ -34,6 +35,7 @@
 #define CDNS_UART_NR_PORTS	2
 #define CDNS_UART_FIFO_SIZE	64	/* FIFO size */
 #define CDNS_UART_REGISTER_SPACE	0x1000
+#define TX_TIMEOUT		500000
 
 /* Rx Trigger level */
 static int rx_trigger_level = 56;
@@ -681,16 +683,20 @@ static void cdns_uart_set_termios(struct uart_port *port,
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
 
-- 
2.20.1

