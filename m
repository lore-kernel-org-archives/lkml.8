Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF6A4C33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9544F2467C
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578996257;
	bh=cDMPHelRIw699s8iZylocwWEmrlu9aghmUsMlfUg4AE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ILITTXc6E20yz5upxEY6HGnIATct1gx6YhWP+UEsMbjyQgask5e1CYVF35iYwVn/m
	 OKhEAcoGBEMYbssEPfgBgQBkxryAYWv2XyT09aT+t/kIkWBKUihAMr+kS3m7vDlcXa
	 Pb8wfnjC/Cz9JVZszcg4PmT7lgluHqChsNEeueWI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729837AbgANKEQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 05:04:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:59692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729019AbgANKEP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 05:04:15 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21D6924676;
        Tue, 14 Jan 2020 10:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578996254;
        bh=cDMPHelRIw699s8iZylocwWEmrlu9aghmUsMlfUg4AE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TDip9DvbUelJZ49innsWP9yONYcLDRH/h2kjqCubgnQUSPCiJT/smQ52BB+DAog/k
         IAb9W2Cv3/q4js5Y72qWSvkNjopNt0nIMNB2P8AEClF1GQJO75pUy0EmbOkGEP7sYl
         phQaW/7PYcNekVzCJn0Eu7EMxFkaE5C34G1uTYxg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 5.4 33/78] can: gs_usb: gs_usb_probe(): use descriptors of current altsetting
Date:   Tue, 14 Jan 2020 11:01:07 +0100
Message-Id: <20200114094358.095193284@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200114094352.428808181@linuxfoundation.org>
References: <20200114094352.428808181@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Hovold <johan@kernel.org>

commit 2f361cd9474ab2c4ab9ac8db20faf81e66c6279b upstream.

Make sure to always use the descriptors of the current alternate setting
to avoid future issues when accessing fields that may differ between
settings.

Signed-off-by: Johan Hovold <johan@kernel.org>
Fixes: d08e973a77d1 ("can: gs_usb: Added support for the GS_USB CAN devices")
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/can/usb/gs_usb.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -918,7 +918,7 @@ static int gs_usb_probe(struct usb_inter
 			     GS_USB_BREQ_HOST_FORMAT,
 			     USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_INTERFACE,
 			     1,
-			     intf->altsetting[0].desc.bInterfaceNumber,
+			     intf->cur_altsetting->desc.bInterfaceNumber,
 			     hconf,
 			     sizeof(*hconf),
 			     1000);
@@ -941,7 +941,7 @@ static int gs_usb_probe(struct usb_inter
 			     GS_USB_BREQ_DEVICE_CONFIG,
 			     USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_INTERFACE,
 			     1,
-			     intf->altsetting[0].desc.bInterfaceNumber,
+			     intf->cur_altsetting->desc.bInterfaceNumber,
 			     dconf,
 			     sizeof(*dconf),
 			     1000);


