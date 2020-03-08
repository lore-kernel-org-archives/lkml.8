Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DATE_IN_PAST_96_XX,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A7AC2D0E5
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 16:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F797206F6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 16:43:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbgC1Qnm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 12:43:42 -0400
Received: from mx.sdf.org ([205.166.94.20]:50129 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727591AbgC1QnY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 12:43:24 -0400
Received: from sdf.org (IDENT:lkml@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id 02SGhKRh017492
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits) verified NO);
        Sat, 28 Mar 2020 16:43:21 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id 02SGhKg2024958;
        Sat, 28 Mar 2020 16:43:20 GMT
Message-Id: <202003281643.02SGhKg2024958@sdf.org>
From:   George Spelvin <lkml@sdf.org>
Date:   Sun, 8 Mar 2020 05:04:08 -0400
Subject: [RFC PATCH v1 35/50] USB: serial: iuu_phoenix: Use pseudorandom for
 xmas mode
To:     linux-kernel@vger.kernel.org, lkml@sdf.org
Cc:     Johan Hovold <johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I also fixed a couple of buffer overrun bugs in iuu_led_activity_on,
based on code not expecting the "*buf_ptr++" to have been incremented.

- In xmas mode, the final setting of the period byte to 1 was
  done to buf_ptr[7], which was past the end of the buffer.
- In non-xmas mode, iuu_rgbf_fill_buffer() fills in 8 bytes starting
  with the IUU_SET_LED command.  The net result is duplicating the
  command and writing an extra byte off the end of the buffer.

I rewrote the code to omit the ++, which is more legible.

Not tested because I don't have the hardware, but I don't think
this code has been exercised much anyway.

Signed-off-by: George Spelvin <lkml@sdf.org>
Cc: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/iuu_phoenix.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/serial/iuu_phoenix.c b/drivers/usb/serial/iuu_phoenix.c
index d5bff69b1769b..7aeea7b5ba8db 100644
--- a/drivers/usb/serial/iuu_phoenix.c
+++ b/drivers/usb/serial/iuu_phoenix.c
@@ -353,10 +353,11 @@ static void iuu_led_activity_on(struct urb *urb)
 	struct usb_serial_port *port = urb->context;
 	int result;
 	char *buf_ptr = port->write_urb->transfer_buffer;
-	*buf_ptr++ = IUU_SET_LED;
+
 	if (xmas) {
-		get_random_bytes(buf_ptr, 6);
-		*(buf_ptr+7) = 1;
+		buf_ptr[0] = IUU_SET_LED;
+		prandom_bytes(buf_ptr+1, 6);
+		buf_ptr[7] = 1;
 	} else {
 		iuu_rgbf_fill_buffer(buf_ptr, 255, 255, 0, 0, 0, 0, 255);
 	}
-- 
2.26.0

