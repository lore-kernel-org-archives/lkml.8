Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DED2C52D51
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C15C20801
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582813023;
	bh=bYKAWCj7wZo3bsAIb6e0JlxfyLzbRVASan1lMyEV94I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dA+Ro2kiOOcEWmoXG/TSMipAJWUIZGzpdp+WjsINaXzg5AqlQNG7S2dxU6+0sEbpw
	 4vLILF0+Kv89ONPfzh8hEOxqzqgXAlj7cvbdeOuuIGUC6c07MP3k6HVzQuOWTOf6Hp
	 GrcFsfRn3zhLTR4nE5xqZgLGzT419W8q7jsjOpI4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389156AbgB0ORC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:17:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:57266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389601AbgB0OQ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 09:16:57 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20FEE246A0;
        Thu, 27 Feb 2020 14:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582813016;
        bh=bYKAWCj7wZo3bsAIb6e0JlxfyLzbRVASan1lMyEV94I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K6BHbgZnyoMrdCPy5CQQfz6BvJ3JQUWb+z7m9WtpTgcByyjBwSqxMqiQC2f3JUPcM
         cQmbqd9cFccX1dA4fbg7EeqC11cQGGEu7tfqRWT8Ko7cOVLstabaD0smiRO7fuj3my
         Wsrw11Yt2eTP854rNC5v5hGb/16FUNx/graP03Ls=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: [PATCH 5.5 065/150] tty/serial: atmel: manage shutdown in case of RS485 or ISO7816 mode
Date:   Thu, 27 Feb 2020 14:36:42 +0100
Message-Id: <20200227132242.600717549@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132232.815448360@linuxfoundation.org>
References: <20200227132232.815448360@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolas Ferre <nicolas.ferre@microchip.com>

commit 04b5bfe3dc94e64d0590c54045815cb5183fb095 upstream.

In atmel_shutdown() we call atmel_stop_rx() and atmel_stop_tx() functions.
Prevent the rx restart that is implemented in RS485 or ISO7816 modes when
calling atmel_stop_tx() by using the atomic information tasklet_shutdown
that is already in place for this purpose.

Fixes: 98f2082c3ac4 ("tty/serial: atmel: enforce tasklet init and termination sequences")
Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: stable <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20200210152053.8289-1-nicolas.ferre@microchip.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/serial/atmel_serial.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -574,7 +574,8 @@ static void atmel_stop_tx(struct uart_po
 	atmel_uart_writel(port, ATMEL_US_IDR, atmel_port->tx_done_mask);
 
 	if (atmel_uart_is_half_duplex(port))
-		atmel_start_rx(port);
+		if (!atomic_read(&atmel_port->tasklet_shutdown))
+			atmel_start_rx(port);
 
 }
 


