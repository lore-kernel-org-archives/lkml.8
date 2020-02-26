Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D22FC4BA24
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 21:04:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 422BD21D7E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 21:04:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i/MIoEkI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727744AbgBZVEc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 16:04:32 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33411 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727701AbgBZVE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 16:04:29 -0500
Received: by mail-pl1-f196.google.com with SMTP id ay11so200361plb.0;
        Wed, 26 Feb 2020 13:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xAl1x+LpHJ0/VGX33EY28LK5EWDI6zzFinArxJkf/Us=;
        b=i/MIoEkIkUelCWWx6h02qcZVRrQclgV7C5pVM14h6peF/Ryl4gGu6eXes/xJT1aE6E
         mq+oM2W8jWqREiUFdm5SsrqNGQ8hnfXOZP2MrZxKwP9bCwAMoROzYXl2H6/XHKP6PZpj
         FsBlJyU97lfwxT0sxx+SwL0eYdtK4+ZuFrT2mBVSHAov8oi4NKrG4jwLQJmYEvLqqsdf
         6eaJhdFFEVINUGhxVi/AkY09abXyerQ9GcwFjRUUIA1DGA110o3rqtIsvbG2O0AesPWo
         5NClYjADavsoI9fj6GiVslYvq1mASMgXVTJIA5lT0G800a3UNXGVqOEKnq7y/Kg2XpKb
         Wt+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=xAl1x+LpHJ0/VGX33EY28LK5EWDI6zzFinArxJkf/Us=;
        b=OUS0nIlp1cjVKTQhZ1h7EYiI36cedIz/FKom6wt3Jk4jWuV7dpHYezvApR5dvXWFed
         8lfE/LsrWclmtljd6hD5sp0E/RBu0ZhuZGPjiIpLZm/93wDfm414eeHCgjHkV21rGlWd
         jpCHuW14+4AXlKGoChmyltyhbyxpX3+g6N6pqDNBO9bne8+omuu+6MjbmflkP00CH5yq
         ma06dbZ08skoo/6qsDpQQ7aSmOM3ajMkEMXoIcl5YkWqmoga+pTmrsKL6NlRSxZmxQYP
         cdn51FODVavVHG5oweYSGk00+XYiNVYolcecKnQaHOPd6P9qe+PLPpdrQJmdi0FdRGrP
         nivQ==
X-Gm-Message-State: APjAAAV2iRI3XrDkdEky/Y8ftkgQZsvulE9DXUwvWk3tnF9PqSqmz2c3
        NWgUfGzG2590YiWt4aclPXA=
X-Google-Smtp-Source: APXvYqzmRD/mrN418qWZD5WexJgskKTDafa05gVsZZkbQReTFmVojqc2qHVQsWNNEWytgCR8y1/gLA==
X-Received: by 2002:a17:902:7589:: with SMTP id j9mr1169794pll.312.1582751068697;
        Wed, 26 Feb 2020 13:04:28 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q8sm3966221pfs.161.2020.02.26.13.04.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Feb 2020 13:04:28 -0800 (PST)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Minas Harutyunyan <hminas@synopsys.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Antti=20Sepp=C3=A4l=C3=A4?= <a.seppala@gmail.com>,
        Boris ARZUR <boris@konbu.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [RFT PATCH 4/4] usb: dwc2: Make "trimming xfer length" a debug message
Date:   Wed, 26 Feb 2020 13:04:14 -0800
Message-Id: <20200226210414.28133-5-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200226210414.28133-1-linux@roeck-us.net>
References: <20200226210414.28133-1-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With some USB network adapters, such as DM96xx, the following message
is seen for each maximum size receive packet.

dwc2 ff540000.usb: dwc2_update_urb_state(): trimming xfer length

This happens because the packet size requested by the driver is 1522
bytes, wMaxPacketSize is 64, the dwc2 driver configures the chip to
receive 24*64 = 1536 bytes, and the chip does indeed send more than
1522 bytes of data. Since the event does not indicate an error condition,
the message is just noise. Demote it to debug level.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/usb/dwc2/hcd_intr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/dwc2/hcd_intr.c b/drivers/usb/dwc2/hcd_intr.c
index 12819e019e13..d5f4ec1b73b1 100644
--- a/drivers/usb/dwc2/hcd_intr.c
+++ b/drivers/usb/dwc2/hcd_intr.c
@@ -500,7 +500,7 @@ static int dwc2_update_urb_state(struct dwc2_hsotg *hsotg,
 						      &short_read);
 
 	if (urb->actual_length + xfer_length > urb->length) {
-		dev_warn(hsotg->dev, "%s(): trimming xfer length\n", __func__);
+		dev_dbg(hsotg->dev, "%s(): trimming xfer length\n", __func__);
 		xfer_length = urb->length - urb->actual_length;
 	}
 
-- 
2.17.1

