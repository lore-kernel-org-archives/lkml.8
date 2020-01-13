Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 849B7C33CA9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 02:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 623492187F
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 02:09:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733162AbgAMCJO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jan 2020 21:09:14 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9161 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733125AbgAMCJN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jan 2020 21:09:13 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 2FB32D2DFCEFBE24D5B2;
        Mon, 13 Jan 2020 10:09:12 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Mon, 13 Jan 2020
 10:09:01 +0800
From:   Zheng Bin <zhengbin13@huawei.com>
To:     <gregkh@linuxfoundation.org>, <jslaby@suse.com>,
        <linux-kernel@vger.kernel.org>
CC:     <zhengbin13@huawei.com>
Subject: [PATCH RESEND 3/4] tty/serial: atmel: use true,false for bool variable
Date:   Mon, 13 Jan 2020 10:16:16 +0800
Message-ID: <1578881777-65475-4-git-send-email-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1578881777-65475-1-git-send-email-zhengbin13@huawei.com>
References: <1578881777-65475-1-git-send-email-zhengbin13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes coccicheck warning:

drivers/tty/serial/atmel_serial.c:1062:1-23: WARNING: Assignment of 0/1 to bool variable
drivers/tty/serial/atmel_serial.c:1261:1-23: WARNING: Assignment of 0/1 to bool variable
drivers/tty/serial/atmel_serial.c:1688:3-25: WARNING: Assignment of 0/1 to bool variable

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zheng Bin <zhengbin13@huawei.com>
---
 drivers/tty/serial/atmel_serial.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index fa19eb3..181da0c 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -1059,7 +1059,7 @@ static int atmel_prepare_tx_dma(struct uart_port *port)

 chan_err:
 	dev_err(port->dev, "TX channel not available, switch to pio\n");
-	atmel_port->use_dma_tx = 0;
+	atmel_port->use_dma_tx = false;
 	if (atmel_port->chan_tx)
 		atmel_release_tx_dma(port);
 	return -EINVAL;
@@ -1258,7 +1258,7 @@ static int atmel_prepare_rx_dma(struct uart_port *port)

 chan_err:
 	dev_err(port->dev, "RX channel not available, switch to pio\n");
-	atmel_port->use_dma_rx = 0;
+	atmel_port->use_dma_rx = false;
 	if (atmel_port->chan_rx)
 		atmel_release_rx_dma(port);
 	return -EINVAL;
@@ -1685,7 +1685,7 @@ static int atmel_prepare_rx_pdc(struct uart_port *port)
 					DMA_FROM_DEVICE);
 				kfree(atmel_port->pdc_rx[0].buf);
 			}
-			atmel_port->use_pdc_rx = 0;
+			atmel_port->use_pdc_rx = false;
 			return -ENOMEM;
 		}
 		pdc->dma_addr = dma_map_single(port->dev,
--
2.7.4

