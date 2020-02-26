Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC5BDC4BA24
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 21:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C0FD21D7E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 21:04:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZFpUXwgX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727700AbgBZVE3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 16:04:29 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34667 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727553AbgBZVE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 16:04:27 -0500
Received: by mail-pl1-f195.google.com with SMTP id j7so196725plt.1;
        Wed, 26 Feb 2020 13:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=O2R0xv9L03iHVU8fcy0iMduIxJYTTX4YSCNR8788OZI=;
        b=ZFpUXwgXzxzsdK06WKBmBhm9sVDb1CcjViRzCFz1d0TmLYgH4x/uGQwRipAnzOrin/
         nfOHwt5B5Z1YcDMbt2ullGh/jzWOOq+Unh8OuxyKvuBqIQoh8i4kPVTjMmSY5ZTZv/wa
         MSH1Phve2N5EFli0hNKk+OaL24HoCP+p2vhoNX2uQAVFHu6tcjzNmo103Gr8ibLbxbfG
         QZ5f/fixwGtXX0eLu9NBSBTpYkAcHdcd+5VDEzQIutrl15RBL8Rlx+KO5YaZBi//65FJ
         VW0jfEAAO6msbk8csosVgxtLW/Bon88pmcj6ZplBNhpQC8i5vagiUlyLEuGmqduGRCbs
         6kiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=O2R0xv9L03iHVU8fcy0iMduIxJYTTX4YSCNR8788OZI=;
        b=hs87xWgSmPoAtJOJYjPF9BIzTWf4x3HsiNY7sPxXBkagRxro1Ycxc6s9Z75OL4xchf
         Vl8ahSnw6Uw1dJ1pHcftD3lSZDszKEiJ1RocABBBujhJucVZ5N4tTBX5fsSFo7T4vfXl
         p+0GHGBU2JI5TBtEYOyy+brLHTpg8anke6ANY+9dPmzX/D7czxacwWqOM1/RV+GVov7s
         TpPkgrE/a94aP+0SPZZOpiuyR1J6crOuMHeHjJOFv9A3RVcLg+mYiF+tHx4BAvolc19b
         PJaXIi2zRdTKRoENnRMF62fy2t2kEdvSqCtTTUK6jkEHJDfrogtnF1rAga5CAupIz6Ei
         5jiQ==
X-Gm-Message-State: APjAAAU1tcVYJUKqml/9/gtUFm65A44BFjkkEI2eX6Mu0DsMswSdIL3s
        sO8rfZB2fRqw53D0C7PdP30=
X-Google-Smtp-Source: APXvYqxggiQoe2ew7pSQ4cHEaegNrujnyAJVfCPiG0j+4IZz9M7i2zUIxdS7oJjZ2B2cC2/OyW4+Tw==
X-Received: by 2002:a17:90a:cf08:: with SMTP id h8mr1015158pju.81.1582751065860;
        Wed, 26 Feb 2020 13:04:25 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o6sm4344756pfg.180.2020.02.26.13.04.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Feb 2020 13:04:25 -0800 (PST)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Minas Harutyunyan <hminas@synopsys.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Antti=20Sepp=C3=A4l=C3=A4?= <a.seppala@gmail.com>,
        Boris ARZUR <boris@konbu.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [RFT PATCH 2/4] usb: dwc2: Do not update data length if it is 0 on inbound transfers
Date:   Wed, 26 Feb 2020 13:04:12 -0800
Message-Id: <20200226210414.28133-3-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200226210414.28133-1-linux@roeck-us.net>
References: <20200226210414.28133-1-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DWC2 documentation states that transfers with zero data length should
set the number of packets to 1 and the transfer length to 0. This is not
currently the case for inbound transfers: the transfer length is set to
the maximum packet length. This can have adverse effects if the chip
actually does transfer data as it is programmed to do. Follow chip
documentation and keep the transfer length set to 0 in that situation.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/usb/dwc2/hcd.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
index f6d8cc9cee34..506fdffd82ab 100644
--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -1313,19 +1313,20 @@ static void dwc2_hc_start_transfer(struct dwc2_hsotg *hsotg,
 			if (num_packets > max_hc_pkt_count) {
 				num_packets = max_hc_pkt_count;
 				chan->xfer_len = num_packets * chan->max_packet;
+			} else if (chan->ep_is_in) {
+				/*
+				 * Always program an integral # of max packets
+				 * for IN transfers.
+				 * Note: This assumes that the input buffer is
+				 * aligned and sized accordingly.
+				 */
+				chan->xfer_len = num_packets * chan->max_packet;
 			}
 		} else {
 			/* Need 1 packet for transfer length of 0 */
 			num_packets = 1;
 		}
 
-		if (chan->ep_is_in)
-			/*
-			 * Always program an integral # of max packets for IN
-			 * transfers
-			 */
-			chan->xfer_len = num_packets * chan->max_packet;
-
 		if (chan->ep_type == USB_ENDPOINT_XFER_INT ||
 		    chan->ep_type == USB_ENDPOINT_XFER_ISOC)
 			/*
-- 
2.17.1

