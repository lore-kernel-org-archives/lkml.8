Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B00FEC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 11:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 879CA2072D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 11:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597921780;
	bh=zJegssBL5sWlEC6bWS+r289ZmA8SWSWJcueRmy18HzU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IuvDvnpCgoW/zRZhSErbTAB/O+u6WdyVe3mCiLdrQrB5nfTxc8P9EkMYteyqmi3n9
	 1d7B32/fkp9sbrjJap1Vi+jiJ4565iQ5O5ucAXJNaCbQzlS0UcezIN6cKPpUou5+T4
	 nicbWXJz+qnD/hYAeuYYG8t8wtbQxCIoyz1HNxzE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728377AbgHTLJj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 07:09:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:49264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730939AbgHTKLI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:11:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB9D9206DA;
        Thu, 20 Aug 2020 10:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597918268;
        bh=zJegssBL5sWlEC6bWS+r289ZmA8SWSWJcueRmy18HzU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WJUGwH3oFFQhLZMz20ytgZsgDR9pnNwzaeCcqI+cQVgZ6hIhdgoOrQ+LVG53uUQ0c
         1tLvWGI4Z+8pwiqkMJIlzmX2rKf+xD3AcM5nV+jr33P7IrYeI3+YT7cjOsTAyonue8
         hQ1IZzN+/eRkOGUsV3w9kpf+U7jEUGVxyNE+iGU8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, George Spelvin <lkml@sdf.org>,
        Johan Hovold <johan@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 110/228] USB: serial: iuu_phoenix: fix led-activity helpers
Date:   Thu, 20 Aug 2020 11:21:25 +0200
Message-Id: <20200820091613.088371278@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091607.532711107@linuxfoundation.org>
References: <20200820091607.532711107@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Hovold <johan@kernel.org>

[ Upstream commit de37458f8c2bfc465500a1dd0d15dbe96d2a698c ]

The set-led command is eight bytes long and starts with a command byte
followed by six bytes of RGB data and ends with a byte encoding a
frequency (see iuu_led() and iuu_rgbf_fill_buffer()).

The led activity helpers had a few long-standing bugs which corrupted
the command packets by inserting a second command byte and thereby
offsetting the RGB data and dropping the frequency in non-xmas mode.

In xmas mode, a related off-by-one error left the frequency field
uninitialised.

Fixes: 60a8fc017103 ("USB: add iuu_phoenix driver")
Reported-by: George Spelvin <lkml@sdf.org>
Link: https://lore.kernel.org/r/20200716085056.31471-1-johan@kernel.org
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/serial/iuu_phoenix.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/serial/iuu_phoenix.c b/drivers/usb/serial/iuu_phoenix.c
index a1a11f8bb2a3d..0c9e24b217f7d 100644
--- a/drivers/usb/serial/iuu_phoenix.c
+++ b/drivers/usb/serial/iuu_phoenix.c
@@ -359,10 +359,11 @@ static void iuu_led_activity_on(struct urb *urb)
 	struct usb_serial_port *port = urb->context;
 	int result;
 	char *buf_ptr = port->write_urb->transfer_buffer;
-	*buf_ptr++ = IUU_SET_LED;
+
 	if (xmas) {
-		get_random_bytes(buf_ptr, 6);
-		*(buf_ptr+7) = 1;
+		buf_ptr[0] = IUU_SET_LED;
+		get_random_bytes(buf_ptr + 1, 6);
+		buf_ptr[7] = 1;
 	} else {
 		iuu_rgbf_fill_buffer(buf_ptr, 255, 255, 0, 0, 0, 0, 255);
 	}
@@ -380,13 +381,14 @@ static void iuu_led_activity_off(struct urb *urb)
 	struct usb_serial_port *port = urb->context;
 	int result;
 	char *buf_ptr = port->write_urb->transfer_buffer;
+
 	if (xmas) {
 		iuu_rxcmd(urb);
 		return;
-	} else {
-		*buf_ptr++ = IUU_SET_LED;
-		iuu_rgbf_fill_buffer(buf_ptr, 0, 0, 255, 255, 0, 0, 255);
 	}
+
+	iuu_rgbf_fill_buffer(buf_ptr, 0, 0, 255, 255, 0, 0, 255);
+
 	usb_fill_bulk_urb(port->write_urb, port->serial->dev,
 			  usb_sndbulkpipe(port->serial->dev,
 					  port->bulk_out_endpointAddress),
-- 
2.25.1



