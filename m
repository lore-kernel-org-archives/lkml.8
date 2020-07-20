Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CABAC433FB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BF1A20734
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595261603;
	bh=7P51UCwmsDPHCOOzmOfOEUc5JLZLUOM0bBwlUBhsPU4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YlyzYVJAnLD01NhHI0wCE+cyQQzZmX8mEcS6ubwmaqO9meb6ri8q1WpYBLq3H7MKt
	 suBcdY+q6PSPdt7xalxsWYuZoS+bBTXeeEpMhXbeqcdQBf9rZDpUQyQGBNJiyt6/4W
	 E0fSAqk55I+0wMX2oJr08broGNUHFN7fJ5dAjCKc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388106AbgGTQNW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:13:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:53090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388096AbgGTQNO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 12:13:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1527B20684;
        Mon, 20 Jul 2020 16:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595261594;
        bh=7P51UCwmsDPHCOOzmOfOEUc5JLZLUOM0bBwlUBhsPU4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iuRKB7qvR+dN192UlolRUZf/P+iCYCO3UBRFe6+CvJDa1irPVFCD/65l98BDYTSqp
         1lTmHunuzY/2kezP68G6gvGP6PFhSUS0CwQgE33/CKAx/KHUuljp2GDWZk0o98KABg
         wOzNMXveOrPeTbrpD5lTB3mQXULkonh/m76EEqVE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jan Kiszka <jan.kiszka@siemens.com>,
        Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH 5.7 171/244] Revert "tty: xilinx_uartps: Fix missing id assignment to the console"
Date:   Mon, 20 Jul 2020 17:37:22 +0200
Message-Id: <20200720152833.968753698@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152825.863040590@linuxfoundation.org>
References: <20200720152825.863040590@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Kiszka <jan.kiszka@siemens.com>

commit 76ed2e105796710cf5b8a4ba43c81eceed948b70 upstream.

This reverts commit 2ae11c46d5fdc46cb396e35911c713d271056d35.

It turned out to break the ultra96-rev1, e.g., which uses uart1 as
serial0 (and stdout-path = "serial0:115200n8").

Fixes: 2ae11c46d5fd ("tty: xilinx_uartps: Fix missing id assignment to the console")
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Reviewed-by: Michal Simek <michal.simek@xilinx.com>
Tested-by: Michal Simek <michal.simek@xilinx.com>
Link: https://lore.kernel.org/r/f4092727-d8f5-5f91-2c9f-76643aace993@siemens.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/serial/xilinx_uartps.c |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1459,7 +1459,6 @@ static int cdns_uart_probe(struct platfo
 		cdns_uart_uart_driver.nr = CDNS_UART_NR_PORTS;
 #ifdef CONFIG_SERIAL_XILINX_PS_UART_CONSOLE
 		cdns_uart_uart_driver.cons = &cdns_uart_console;
-		cdns_uart_console.index = id;
 #endif
 
 		rc = uart_register_driver(&cdns_uart_uart_driver);


