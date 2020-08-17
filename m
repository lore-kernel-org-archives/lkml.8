Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B40C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 151DA204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597690328;
	bh=a7E2beN0GPmKTpYoQDTwY7mJKGFsxlXkNeufTEdGSfE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pFbe9L+JavONhpznpMwlpCqiZxJVeNCACHwug+gvTR2YNYL+KVu2Pyil4rl5h5vV7
	 XRYa4R/Y/T16FMvuxmAjjZbDDCjRQGMfJs7NfXE/jhEUHftw5tbYgMIJ0m94jmUBnS
	 6TnBYygNtoqF+9j4cwHau41mhjw24ZwR+5Jmbmzg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391765AbgHQSwG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 14:52:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:38840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387860AbgHQPwi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:52:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81F6820882;
        Mon, 17 Aug 2020 15:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597679557;
        bh=a7E2beN0GPmKTpYoQDTwY7mJKGFsxlXkNeufTEdGSfE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FPKOn4JfthbKw1hK45A5FplsT9PY/PDx4goVh1rHFNjymsgXWsZ6J+b27f9Hh4D6y
         ogQsylMOenq18qRuAaoFvMGV9jMf6eAw/ZkYBuy37HcRYGSCfj3RSQbNQ6robPtd+x
         XrtDzL1r0SZy80eLF43NGq3QLbPgK1cosoFgEPzo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, George Spelvin <lkml@sdf.org>,
        Johan Hovold <johan@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 224/393] USB: serial: iuu_phoenix: fix led-activity helpers
Date:   Mon, 17 Aug 2020 17:14:34 +0200
Message-Id: <20200817143830.489141489@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143819.579311991@linuxfoundation.org>
References: <20200817143819.579311991@linuxfoundation.org>
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
index b8dfeb4fb2ed6..ffbb2a8901b2b 100644
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
+		get_random_bytes(buf_ptr + 1, 6);
+		buf_ptr[7] = 1;
 	} else {
 		iuu_rgbf_fill_buffer(buf_ptr, 255, 255, 0, 0, 0, 0, 255);
 	}
@@ -374,13 +375,14 @@ static void iuu_led_activity_off(struct urb *urb)
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



