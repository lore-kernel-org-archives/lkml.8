Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A5BC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 09:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEA8321548
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 09:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592473405;
	bh=yKNoE9kIz+SpmVfbwoez1KYAhJZiTDr3kGLoGFMOyAY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gcSopTvK8CeroxwTFBjPAyMjQvTQ2EZQ/5MkeSSV/+aAy1RKbE5z5G/dnGDSwx76n
	 DQul+e1FwP0kvHSkED9UsPQ5gb8thpOh5cP+sNhH6I12QDBle1Dc0X42Ry+S49/izx
	 oH6jA0jEvpHSjfcC1hfyZYg1zDeI2Z1p4N+4MsmA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729278AbgFRJnY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 05:43:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:43714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729060AbgFRJnV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 05:43:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B79B21D6C;
        Thu, 18 Jun 2020 09:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592473399;
        bh=yKNoE9kIz+SpmVfbwoez1KYAhJZiTDr3kGLoGFMOyAY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CU/a0QcrGcik6KJE+PyYEk7ySyjV3ZfqT4YwCswKU86Eg1mPGtu2yFtV1lSzotLrW
         pCOMTzGJraB5FmFD8P0jvg0rvaV5zJjqq5XyQPX5jOtek7gYFQR7FcEbz4PTfOHhM7
         9gAulS8qujtJhXFuMOQW0yQZv9ZjAj548IGNWT4M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH 3/8] USB: OHCI: remove obsolete FIXME comment
Date:   Thu, 18 Jun 2020 11:42:55 +0200
Message-Id: <20200618094300.1887727-4-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200618094300.1887727-1-gregkh@linuxfoundation.org>
References: <20200618094300.1887727-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This comment has been present since the start of git.  Since no one is
going to do anything about it, and all seems to work well, just drop the
thing entirely.

Cc: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/host/ohci-pci.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/usb/host/ohci-pci.c b/drivers/usb/host/ohci-pci.c
index 585222af24ff..41efe927d8f3 100644
--- a/drivers/usb/host/ohci-pci.c
+++ b/drivers/usb/host/ohci-pci.c
@@ -232,10 +232,6 @@ static const struct pci_device_id ohci_pci_quirks[] = {
 		.driver_data	= (unsigned long)ohci_quirk_qemu,
 	},
 
-	/* FIXME for some of the early AMD 760 southbridges, OHCI
-	 * won't work at all.  blacklist them.
-	 */
-
 	{},
 };
 
-- 
2.27.0

