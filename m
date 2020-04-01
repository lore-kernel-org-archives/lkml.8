Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0351C2D0F3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A99062063A
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585759678;
	bh=2ylRiHjtK90gxi61cOd673GSv59weoK+DS/Xe0pyLX8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uLrNdf1WqGljpT5R1qerjmAOfNqYFQGQSWziW+5ZC/IDKid+7GpFudYmI1RU9Hnse
	 7fMBwf6F4sc57StiC3MFNITN6+9kd0V61q9nnGRGRAFjpNKcuBcyw8hvuVN4GFKo/d
	 dnRO1bJIkQaEbTL4dvxk+E7voh3eafNl7c0b/mX0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390103AbgDAQr5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:47:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:49818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389677AbgDAQry (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:47:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 132522063A;
        Wed,  1 Apr 2020 16:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585759673;
        bh=2ylRiHjtK90gxi61cOd673GSv59weoK+DS/Xe0pyLX8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qnx09vuTLgJJ57e5NuFtc4Zs+VrQ4CAz2lM5gXosMp0MyVI235PH8apwUcE6wG7p7
         D0y3uTBUm3pVAZvDTyETa/WRLB/k4iLtEGSDbarhIG8gyEUaiO/LL8FojBOGEbvUXy
         MULABzy9PpOWcChlBhqAEKVXh5FKquBPvTGe6Rpw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Johan Hovold <johan@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH 4.14 126/148] media: ov519: add missing endpoint sanity checks
Date:   Wed,  1 Apr 2020 18:18:38 +0200
Message-Id: <20200401161604.489452271@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200401161552.245876366@linuxfoundation.org>
References: <20200401161552.245876366@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Hovold <johan@kernel.org>

commit 998912346c0da53a6dbb71fab3a138586b596b30 upstream.

Make sure to check that we have at least one endpoint before accessing
the endpoint array to avoid dereferencing a NULL-pointer on stream
start.

Note that these sanity checks are not redundant as the driver is mixing
looking up altsettings by index and by number, which need not coincide.

Fixes: 1876bb923c98 ("V4L/DVB (12079): gspca_ov519: add support for the ov511 bridge")
Fixes: b282d87332f5 ("V4L/DVB (12080): gspca_ov519: Fix ov518+ with OV7620AE (Trust spacecam 320)")
Cc: stable <stable@vger.kernel.org>     # 2.6.31
Cc: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/usb/gspca/ov519.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/drivers/media/usb/gspca/ov519.c
+++ b/drivers/media/usb/gspca/ov519.c
@@ -3478,6 +3478,11 @@ static void ov511_mode_init_regs(struct
 		return;
 	}
 
+	if (alt->desc.bNumEndpoints < 1) {
+		sd->gspca_dev.usb_err = -ENODEV;
+		return;
+	}
+
 	packet_size = le16_to_cpu(alt->endpoint[0].desc.wMaxPacketSize);
 	reg_w(sd, R51x_FIFO_PSIZE, packet_size >> 5);
 
@@ -3604,6 +3609,11 @@ static void ov518_mode_init_regs(struct
 		return;
 	}
 
+	if (alt->desc.bNumEndpoints < 1) {
+		sd->gspca_dev.usb_err = -ENODEV;
+		return;
+	}
+
 	packet_size = le16_to_cpu(alt->endpoint[0].desc.wMaxPacketSize);
 	ov518_reg_w32(sd, R51x_FIFO_PSIZE, packet_size & ~7, 2);
 


