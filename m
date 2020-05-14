Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CAD2C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 07:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EA65206DC
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 07:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589439965;
	bh=zoMZaEVVVEIwmZ+S1/itjB0dnqs+eSv+WZKePqF91qk=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=WLkG4frgixvLgudInXTltd4qMOFlVHboPas6uayQg3RyjN0NNq0a6s91IMbxs4YCA
	 FEeu8QKlMh5sJQVqcEdpQh2DYTG8OHVMM+n7jZSZJX85lG1HHEUp4c8lVZ7YhDXH/+
	 LF+OkfqMLpeemjjXYxU25gnSs0mRxgrLkeiIEZQk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbgENHGE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 03:06:04 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33970 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbgENHGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 03:06:03 -0400
Received: by mail-lf1-f67.google.com with SMTP id s9so1696137lfp.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 00:06:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AkkqkBerykie1YrDXFBzsGueOMJwtySKBnmKIyb/rqw=;
        b=WE+klpoKcOXD3a4VUHFmT0tEl2b2PVW8Vr/ynoKAqm7nZcJST5xNNN5GYuJC5klXsa
         0liRidKyEhe3OcZyBDqucwoq21qPwctSdLtITsP4juf0zwpV3fnm/9uxxnptklXF7kTX
         aVadQ2d0s/nA0AI8HIw2sSzBqiaRMpmBCUeZkSUedLnBIsd0ZNlbvmkDq2HQShOeIGlA
         Z3pTEh7RvwsBoOkXPxMPTtdTxdPB4QC/L4re0MTMTwkU0AD3v5UtZ/g2AWZ/rcD/8VX0
         mCafuBL+eMMqsXJ8wJK9/o8FDWwqUsVQMLbTWLnF6QiW079csTs7LcI2uH54ivofgSzX
         hPFw==
X-Gm-Message-State: AOAM531oyE2u55zKIlCagmlVjTvoAnopiUKFApjvyx+RbWFcgiCvLGxr
        7H1PuKGUNmd+PpIxjcxcR+Q=
X-Google-Smtp-Source: ABdhPJz8HCH9ZpQl9l+RruScNIJF1fFDO1Ykv1t0+vZomr5Soo9N7qsIOBMEwdNO/Dwx0UEqrebWGQ==
X-Received: by 2002:a19:ad49:: with SMTP id s9mr2292027lfd.9.1589439961465;
        Thu, 14 May 2020 00:06:01 -0700 (PDT)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id k24sm911175ljg.92.2020.05.14.00.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 00:06:00 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.92.3)
        (envelope-from <johan@xi.terra>)
        id 1jZ7wQ-0001AB-Ut; Thu, 14 May 2020 09:06:03 +0200
From:   Johan Hovold <johan@kernel.org>
To:     David Lin <dtwlin@gmail.com>, Johan Hovold <johan@kernel.org>,
        Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: greybus: uart: replace driver line-coding struct
Date:   Thu, 14 May 2020 09:05:48 +0200
Message-Id: <20200514070548.4423-1-johan@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the driver version of the line-coding request and use the protocol
definition directly as was originally intended instead.

This specifically avoids having the two versions of what is supposed to
be the same struct ever getting out of sync.

Note that this has in fact already happened once when the protocol
definition had its implicit padding removed while the driver struct
wasn't updated. The fact that we used the size of the then larger driver
struct when memcpying its content to the stack didn't exactly make
things better. A later addition of a flow-control field incidentally
made the structures match again.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/staging/greybus/uart.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/greybus/uart.c b/drivers/staging/greybus/uart.c
index 55c51143bb09..84de56800a21 100644
--- a/drivers/staging/greybus/uart.c
+++ b/drivers/staging/greybus/uart.c
@@ -40,14 +40,6 @@
 #define GB_UART_FIRMWARE_CREDITS	4096
 #define GB_UART_CREDIT_WAIT_TIMEOUT_MSEC	10000
 
-struct gb_tty_line_coding {
-	__le32	rate;
-	__u8	format;
-	__u8	parity;
-	__u8	data_bits;
-	__u8	flow_control;
-};
-
 struct gb_tty {
 	struct gbphy_device *gbphy_dev;
 	struct tty_port port;
@@ -66,7 +58,7 @@ struct gb_tty {
 	struct mutex mutex;
 	u8 ctrlin;	/* input control lines */
 	u8 ctrlout;	/* output control lines */
-	struct gb_tty_line_coding line_coding;
+	struct gb_uart_set_line_coding_request line_coding;
 	struct work_struct tx_work;
 	struct kfifo write_fifo;
 	bool close_pending;
@@ -288,12 +280,9 @@ static void  gb_uart_tx_write_work(struct work_struct *work)
 
 static int send_line_coding(struct gb_tty *tty)
 {
-	struct gb_uart_set_line_coding_request request;
-
-	memcpy(&request, &tty->line_coding,
-	       sizeof(tty->line_coding));
 	return gb_operation_sync(tty->connection, GB_UART_TYPE_SET_LINE_CODING,
-				 &request, sizeof(request), NULL, 0);
+				 &tty->line_coding, sizeof(tty->line_coding),
+				 NULL, 0);
 }
 
 static int send_control(struct gb_tty *gb_tty, u8 control)
@@ -493,9 +482,9 @@ static int gb_tty_break_ctl(struct tty_struct *tty, int state)
 static void gb_tty_set_termios(struct tty_struct *tty,
 			       struct ktermios *termios_old)
 {
+	struct gb_uart_set_line_coding_request newline;
 	struct gb_tty *gb_tty = tty->driver_data;
 	struct ktermios *termios = &tty->termios;
-	struct gb_tty_line_coding newline;
 	u8 newctrl = gb_tty->ctrlout;
 
 	newline.rate = cpu_to_le32(tty_get_baud_rate(tty));
-- 
2.26.2

