Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 823A2C54FDA
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5054C24656
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582813811;
	bh=Y+oO0v4pPjWCM/PYx1KrCQTKLulyQAEUeZpbuxHDaAE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JNTMqaq7Je+yOWIGCIt1vm52GJtkYZwrBKonsBJ4Ry9wG7t01x0xQP3lgdHYS/khg
	 lvyqvrA5KjSb16Ca8mo6DTvP93JB1NF0ljcQu+N3VS7NbkaRALsQPJo5iFOW9SC2iP
	 2da10zGVr6l0QTb7DO0q7uAnvNs5Gx1k9RwV1fQY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387737AbgB0OFR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:05:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:41570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732980AbgB0OFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 09:05:04 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9CE7C20801;
        Thu, 27 Feb 2020 14:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582812304;
        bh=Y+oO0v4pPjWCM/PYx1KrCQTKLulyQAEUeZpbuxHDaAE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XOp+olOMerIQstBNrUzZrhlLrSOoOGg913fi3eXeJlWT26BQM2owIsSm+ZxFFOX3i
         5IEf7UIuiaUm+FXiywdSfiPTyR5kKG8bUH4TPeDDHZvpkBiKFhwOzPF4zAXoV16BOT
         IpdTzGh6HSd4A3iuXtI/l6NDo/OOMeT26nCWJXMU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Richard Dodd <richard.o.dodd@gmail.com>
Subject: [PATCH 4.19 26/97] USB: Fix novation SourceControl XL after suspend
Date:   Thu, 27 Feb 2020 14:36:34 +0100
Message-Id: <20200227132218.850608981@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132214.553656188@linuxfoundation.org>
References: <20200227132214.553656188@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Dodd <richard.o.dodd@gmail.com>

commit b692056db8ecc7f452b934f016c17348282b7699 upstream.

Currently, the SourceControl will stay in power-down mode after resuming
from suspend. This patch resets the device after suspend to power it up.

Signed-off-by: Richard Dodd <richard.o.dodd@gmail.com>
Cc: stable <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20200212142220.36892-1-richard.o.dodd@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/core/quirks.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -449,6 +449,9 @@ static const struct usb_device_id usb_qu
 	/* INTEL VALUE SSD */
 	{ USB_DEVICE(0x8086, 0xf1a5), .driver_info = USB_QUIRK_RESET_RESUME },
 
+	/* novation SoundControl XL */
+	{ USB_DEVICE(0x1235, 0x0061), .driver_info = USB_QUIRK_RESET_RESUME },
+
 	{ }  /* terminating entry must be last */
 };
 


