Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5459FC4BA21
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 21:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 262A72468B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 21:04:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lvi+D2mw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727730AbgBZVEb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 16:04:31 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35534 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727708AbgBZVE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 16:04:29 -0500
Received: by mail-pf1-f196.google.com with SMTP id i19so405054pfa.2;
        Wed, 26 Feb 2020 13:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=A4q0wYqlu/YQUGaARulHVZ/TOwBHToENqiembaxCOww=;
        b=Lvi+D2mwGNM7GfCWgU1gIb0xLX76x9S5DhlQKZTseMwAa4FO8r0uyRyuTvQSD/eUWl
         JyCLgnQyA3OCAVi+YfZ0TGIJ2uNDlHCTnqMpvGolFqz2AHwfcS21a7K1DPf9/qEVnSA+
         ULgB9KbXtjiADHvWYbRlr7acFc8hBxDNznhORM4AjLbFdsR2trDVpIfP7IeNql8ncfNw
         Bt0br7O8Q0yvjBKN/JlmYkENG1PBiMIpVMmo0Efmaelu7IDN5q8W6JWSFwaFOq4OMo53
         SAMEaS7sq/gjXBkZZdkfWwA5CKAsiptwaxrn/8mj2yDGbzskixvAV53LC9b1BYWrCHB0
         iMmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=A4q0wYqlu/YQUGaARulHVZ/TOwBHToENqiembaxCOww=;
        b=q/r47hkh2OotBnBpwvHocGVeT1jA7N3wzYtfGDHlKSwOUQqsIzn/iNTz6frOsaQWQ9
         dLg5B3hXQU5mcT7PV6NQC/eo8WZJFosbqgVfXS07TKWhMWcLR6RjkP+Q5B6GVQYVs8d7
         6Em5sCssQJxFXtWcrnsQS3O16NJh9sI7sg0REUKHWhWoVsLVIFy5vlEd+/V2owQhPkVH
         JzIANOlee36xLZwnReLHmu03Q8j+TvoZVniYo6jTsZJEDJm95OSp4tE/vuqwx3lU6Pj6
         FCUXhf790TpMY+XeEuIkp849TZ4Co385B1oYH3HzUObHfo07Fpt+JqKk5a0rVDr91ayd
         bsjQ==
X-Gm-Message-State: APjAAAXaoaLKqTBV0Mz5qzzpoeCTyMMSk5xpfFE2JXVueSnmarGO/ZuC
        5otLB6wC6/EY1pkxOodtFxw=
X-Google-Smtp-Source: APXvYqwC5kq+b0yRdWwFkFck1KqmaSIApjaRzd+GDEbmWy8kVOo/wDLxBJik1HZ29d23D5lDQkX+AQ==
X-Received: by 2002:a63:ec0c:: with SMTP id j12mr694167pgh.78.1582751067307;
        Wed, 26 Feb 2020 13:04:27 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g19sm4014393pfh.134.2020.02.26.13.04.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Feb 2020 13:04:26 -0800 (PST)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Minas Harutyunyan <hminas@synopsys.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Antti=20Sepp=C3=A4l=C3=A4?= <a.seppala@gmail.com>,
        Boris ARZUR <boris@konbu.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [RFT PATCH 3/4] usb: dwc2: Abort transaction after errors with unknown reason
Date:   Wed, 26 Feb 2020 13:04:13 -0800
Message-Id: <20200226210414.28133-4-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200226210414.28133-1-linux@roeck-us.net>
References: <20200226210414.28133-1-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some situations, the following error messages are reported.

dwc2 ff540000.usb: dwc2_hc_chhltd_intr_dma: Channel 1 - ChHltd set, but reason is unknown
dwc2 ff540000.usb: hcint 0x00000002, intsts 0x04000021

This is sometimes followed by:

dwc2 ff540000.usb: dwc2_update_urb_state_abn(): trimming xfer length

and then:

WARNING: CPU: 0 PID: 0 at kernel/v4.19/drivers/usb/dwc2/hcd.c:2913
			dwc2_assign_and_init_hc+0x98c/0x990

The warning suggests that an odd buffer address is to be used for DMA.

After an error is observed, the receive buffer may be full
(urb->actual_length >= urb->length). However, the urb is still left in
the queue unless three errors were observed in a row. When it is queued
again, the dwc2 hcd code translates this into a 1-block transfer.
If urb->actual_length (ie the total expected receive length) is not
DMA-aligned, the buffer pointer programmed into the chip will be
unaligned. This results in the observed warning.

To solve the problem, abort input transactions after an error with
unknown cause if the entire packet was already received. This may be
a bit drastic, but we don't really know why the transfer was aborted
even though the entire packet was received. Aborting the transfer in
this situation is less risky than accepting a potentially corrupted
packet.

With this patch in place, the 'ChHltd set' and 'trimming xfer length'
messages are still observed, but there are no more transfer attempts
with odd buffer addresses.

Cc: Boris ARZUR <boris@konbu.org>
Cc: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/usb/dwc2/hcd_intr.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/usb/dwc2/hcd_intr.c b/drivers/usb/dwc2/hcd_intr.c
index a052d39b4375..12819e019e13 100644
--- a/drivers/usb/dwc2/hcd_intr.c
+++ b/drivers/usb/dwc2/hcd_intr.c
@@ -1977,6 +1977,18 @@ static void dwc2_hc_chhltd_intr_dma(struct dwc2_hsotg *hsotg,
 		qtd->error_count++;
 		dwc2_update_urb_state_abn(hsotg, chan, chnum, qtd->urb,
 					  qtd, DWC2_HC_XFER_XACT_ERR);
+		/*
+		 * We can get here after a completed transaction
+		 * (urb->actual_length >= urb->length) which was not reported
+		 * as completed. If that is the case, and we do not abort
+		 * the transfer, a transfer of size 0 will be enqueued
+		 * subsequently. If urb->actual_length is not DMA-aligned,
+		 * the buffer will then point to an unaligned address, and
+		 * the resulting behavior is undefined. Bail out in that
+		 * situation.
+		 */
+		if (qtd->urb->actual_length >= qtd->urb->length)
+			qtd->error_count = 3;
 		dwc2_hcd_save_data_toggle(hsotg, chan, chnum, qtd);
 		dwc2_halt_channel(hsotg, chan, qtd, DWC2_HC_XFER_XACT_ERR);
 	}
-- 
2.17.1

