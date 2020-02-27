Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E5AC3F348
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E73C521D7E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582811040;
	bh=Z1DU4+Um6gFHn8qnTTuXqBgAJpwCBlWICAXSJKZeCko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=K13XjorU0lBRA7olTswOKtIX/9b034tWKckVMfpxG7dhJZ5PjSJk6dvp12FAQu6vo
	 1ETZHPRblZ4cw6tylxTI4JPW+bTKASxs23eb3DTqjNnslTmkLtBGjDzDQ8dH5j3Vqf
	 rA98d4cToSwRawkOuV3iepKLdKssidtg/56XNnD0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729735AbgB0Nn6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 08:43:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:39198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730051AbgB0Nnv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:43:51 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BCF321D7E;
        Thu, 27 Feb 2020 13:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582811031;
        bh=Z1DU4+Um6gFHn8qnTTuXqBgAJpwCBlWICAXSJKZeCko=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=az4wyxlhacciP1qg1P0PQD1HvyjM2rmw6IVGmgUA4lyDwA6FYSjrszMie/0K1JMQr
         e/ujDM4w+xyXp4U4ytdtdArAY/0/kBbylvbWCg7UeeBQyyS1CF6UwqLNv8bmb1E6Rm
         HsiKvMdeANcf0ErNqgnzowTueiTYvtixRnp3D4HU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Richard Dodd <richard.o.dodd@gmail.com>
Subject: [PATCH 4.4 089/113] USB: Fix novation SourceControl XL after suspend
Date:   Thu, 27 Feb 2020 14:36:45 +0100
Message-Id: <20200227132225.999273787@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132211.791484803@linuxfoundation.org>
References: <20200227132211.791484803@linuxfoundation.org>
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
@@ -291,6 +291,9 @@ static const struct usb_device_id usb_qu
 	/* INTEL VALUE SSD */
 	{ USB_DEVICE(0x8086, 0xf1a5), .driver_info = USB_QUIRK_RESET_RESUME },
 
+	/* novation SoundControl XL */
+	{ USB_DEVICE(0x1235, 0x0061), .driver_info = USB_QUIRK_RESET_RESUME },
+
 	{ }  /* terminating entry must be last */
 };
 


