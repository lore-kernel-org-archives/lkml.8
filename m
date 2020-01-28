Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3410FC2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC0BF24688
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580221513;
	bh=/cA7iSoeVM5FONILaLkKCjkBM4NgGuoRopRvuv6YagM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ivl32+vlHRO+WQMdofNd6R06zZK2KxoQUqJ2HuXHkRHO8uQwK+6WROK+uBS4rpUs1
	 c6r+XOH/lQitV42atsbVdxb9ceC3Hr1TaQU62XirCXWB4nNEvD8lWLGsGkT/wRltvx
	 VwGjyIcwb+3DJiO1rFvr9Dkq4iuBPVoCeENkksLE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbgA1OZM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:25:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:52052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732471AbgA1OZI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:25:08 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5EB912071E;
        Tue, 28 Jan 2020 14:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580221507;
        bh=/cA7iSoeVM5FONILaLkKCjkBM4NgGuoRopRvuv6YagM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xGccPpF3+d2xJQhmQTz7gzy/RZPRxFZ5iqMPra7O5Np3iBeAqW5hOllAF+cQ6X6G9
         xJRjcLqkICh0erqZDNST3EllNJkiWPhaBs6JWgV6fAXCVt32ZpRVky74LIQvjWrfXU
         pwcu69jA6hzPRMeYCnF39J6/DJjj8CmHs4lPYUP4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Vladis Dronov <vdronov@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4.9 252/271] Input: sur40 - fix interface sanity checks
Date:   Tue, 28 Jan 2020 15:06:41 +0100
Message-Id: <20200128135911.333062482@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128135852.449088278@linuxfoundation.org>
References: <20200128135852.449088278@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Hovold <johan@kernel.org>

commit 6b32391ed675827f8425a414abbc6fbd54ea54fe upstream.

Make sure to use the current alternate setting when verifying the
interface descriptors to avoid binding to an invalid interface.

This in turn could cause the driver to misbehave or trigger a WARN() in
usb_submit_urb() that kernels with panic_on_warn set would choke on.

Fixes: bdb5c57f209c ("Input: add sur40 driver for Samsung SUR40 (aka MS Surface 2.0/Pixelsense)")
Signed-off-by: Johan Hovold <johan@kernel.org>
Acked-by: Vladis Dronov <vdronov@redhat.com>
Link: https://lore.kernel.org/r/20191210113737.4016-8-johan@kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/input/touchscreen/sur40.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/input/touchscreen/sur40.c
+++ b/drivers/input/touchscreen/sur40.c
@@ -523,7 +523,7 @@ static int sur40_probe(struct usb_interf
 	int error;
 
 	/* Check if we really have the right interface. */
-	iface_desc = &interface->altsetting[0];
+	iface_desc = interface->cur_altsetting;
 	if (iface_desc->desc.bInterfaceClass != 0xFF)
 		return -ENODEV;
 


