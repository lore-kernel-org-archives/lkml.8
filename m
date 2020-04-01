Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 887B5C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3071820658
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585759203;
	bh=NnPdleigmo/cA/VjQbdgKHuDwHFZNPrfkOgfkaKtv5Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=P47cCTXxzGmZZ8/WaPciFZD6X20q0A6FvHKLnR0YzuYvOpgDjMcPwgkjL5I7frdWx
	 ZHu6bvfVleqzNInDysyZvDRM72M3jjajq8ZnNUQWuuO0CWruGCchHiMOPkIZvTl4nA
	 04fNq2JhYrLzFLl7JyhzqQIR7M9DN3obRyWY4YMc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388679AbgDAQkC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:40:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:40144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388389AbgDAQkA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:40:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D4012063A;
        Wed,  1 Apr 2020 16:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585759200;
        bh=NnPdleigmo/cA/VjQbdgKHuDwHFZNPrfkOgfkaKtv5Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0F+/xxiUfbK8Xn/hrA5HDvRpN1Uf+GxUS5QCpU6XniQQTTPWnJRTSAcsYDBcGuHRF
         2ZsP9q67hZb45Y2RopM+Wru/Cv5scvL3mYxDV83pb11/pgpFfc183K/YWc4Iol8PAk
         8yf1IwDYEWnaccGDRhRtY575PzGiWMdv7i7J+ZVs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Johan Hovold <johan@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH 4.9 088/102] media: stv06xx: add missing descriptor sanity checks
Date:   Wed,  1 Apr 2020 18:18:31 +0200
Message-Id: <20200401161547.044728150@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200401161530.451355388@linuxfoundation.org>
References: <20200401161530.451355388@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Hovold <johan@kernel.org>

commit 485b06aadb933190f4bc44e006076bc27a23f205 upstream.

Make sure to check that we have two alternate settings and at least one
endpoint before accessing the second altsetting structure and
dereferencing the endpoint arrays.

This specifically avoids dereferencing NULL-pointers or corrupting
memory when a device does not have the expected descriptors.

Note that the sanity checks in stv06xx_start() and pb0100_start() are
not redundant as the driver is mixing looking up altsettings by index
and by number, which may not coincide.

Fixes: 8668d504d72c ("V4L/DVB (12082): gspca_stv06xx: Add support for st6422 bridge and sensor")
Fixes: c0b33bdc5b8d ("[media] gspca-stv06xx: support bandwidth changing")
Cc: stable <stable@vger.kernel.org>     # 2.6.31
Cc: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/usb/gspca/stv06xx/stv06xx.c        |   19 ++++++++++++++++++-
 drivers/media/usb/gspca/stv06xx/stv06xx_pb0100.c |    4 ++++
 2 files changed, 22 insertions(+), 1 deletion(-)

--- a/drivers/media/usb/gspca/stv06xx/stv06xx.c
+++ b/drivers/media/usb/gspca/stv06xx/stv06xx.c
@@ -293,6 +293,9 @@ static int stv06xx_start(struct gspca_de
 		return -EIO;
 	}
 
+	if (alt->desc.bNumEndpoints < 1)
+		return -ENODEV;
+
 	packet_size = le16_to_cpu(alt->endpoint[0].desc.wMaxPacketSize);
 	err = stv06xx_write_bridge(sd, STV_ISO_SIZE_L, packet_size);
 	if (err < 0)
@@ -317,11 +320,21 @@ out:
 
 static int stv06xx_isoc_init(struct gspca_dev *gspca_dev)
 {
+	struct usb_interface_cache *intfc;
 	struct usb_host_interface *alt;
 	struct sd *sd = (struct sd *) gspca_dev;
 
+	intfc = gspca_dev->dev->actconfig->intf_cache[0];
+
+	if (intfc->num_altsetting < 2)
+		return -ENODEV;
+
+	alt = &intfc->altsetting[1];
+
+	if (alt->desc.bNumEndpoints < 1)
+		return -ENODEV;
+
 	/* Start isoc bandwidth "negotiation" at max isoc bandwidth */
-	alt = &gspca_dev->dev->actconfig->intf_cache[0]->altsetting[1];
 	alt->endpoint[0].desc.wMaxPacketSize =
 		cpu_to_le16(sd->sensor->max_packet_size[gspca_dev->curr_mode]);
 
@@ -334,6 +347,10 @@ static int stv06xx_isoc_nego(struct gspc
 	struct usb_host_interface *alt;
 	struct sd *sd = (struct sd *) gspca_dev;
 
+	/*
+	 * Existence of altsetting and endpoint was verified in
+	 * stv06xx_isoc_init()
+	 */
 	alt = &gspca_dev->dev->actconfig->intf_cache[0]->altsetting[1];
 	packet_size = le16_to_cpu(alt->endpoint[0].desc.wMaxPacketSize);
 	min_packet_size = sd->sensor->min_packet_size[gspca_dev->curr_mode];
--- a/drivers/media/usb/gspca/stv06xx/stv06xx_pb0100.c
+++ b/drivers/media/usb/gspca/stv06xx/stv06xx_pb0100.c
@@ -198,6 +198,10 @@ static int pb0100_start(struct sd *sd)
 	alt = usb_altnum_to_altsetting(intf, sd->gspca_dev.alt);
 	if (!alt)
 		return -ENODEV;
+
+	if (alt->desc.bNumEndpoints < 1)
+		return -ENODEV;
+
 	packet_size = le16_to_cpu(alt->endpoint[0].desc.wMaxPacketSize);
 
 	/* If we don't have enough bandwidth use a lower framerate */


