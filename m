Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1742EC47256
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 06:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E757820714
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 06:18:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbgEFGSX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 02:18:23 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3855 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725873AbgEFGSW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 02:18:22 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 03D1039169515BAFE5D3;
        Wed,  6 May 2020 14:18:19 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Wed, 6 May 2020
 14:18:13 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <jirislaby@gmail.com>, <gregkh@linuxfoundation.org>,
        <shawnguo@kernel.org>, <s.hauer@pengutronix.de>,
        <kernel@pengutronix.de>, <festevam@gmail.com>, <linux-imx@nxp.com>,
        <yanaijie@huawei.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] tty: mxser: make mxser_change_speed() return void
Date:   Wed, 6 May 2020 14:17:35 +0800
Message-ID: <20200506061735.19369-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No other functions use the return value of mxser_change_speed() and the
return value is always 0 now. Make it return void. This fixes the
following coccicheck warning:

drivers/tty/mxser.c:645:5-8: Unneeded variable: "ret". Return "0" on
line 650

Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/tty/mxser.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index 9d00ff5ef961..3703987c4666 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -638,16 +638,15 @@ static int mxser_set_baud(struct tty_struct *tty, long newspd)
  * This routine is called to set the UART divisor registers to match
  * the specified baud rate for a serial port.
  */
-static int mxser_change_speed(struct tty_struct *tty)
+static void mxser_change_speed(struct tty_struct *tty)
 {
 	struct mxser_port *info = tty->driver_data;
 	unsigned cflag, cval, fcr;
-	int ret = 0;
 	unsigned char status;
 
 	cflag = tty->termios.c_cflag;
 	if (!info->ioaddr)
-		return ret;
+		return;
 
 	if (mxser_set_baud_method[tty->index] == 0)
 		mxser_set_baud(tty, tty_get_baud_rate(tty));
@@ -803,8 +802,6 @@ static int mxser_change_speed(struct tty_struct *tty)
 
 	outb(fcr, info->ioaddr + UART_FCR);	/* set fcr */
 	outb(cval, info->ioaddr + UART_LCR);
-
-	return ret;
 }
 
 static void mxser_check_modem_status(struct tty_struct *tty,
-- 
2.21.1

