Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55457C433E7
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 356C220684
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595260973;
	bh=bTZfeAWR2pBaRtAlL/mVt3xpRqcquaU//lEAkN+K/r4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ronA8Lz2M6Jm6Py/i8x7GwGV8Nz1I8/zSfXBWgmKAfNYCR6zcCy5wAPFXxUE++8KT
	 VOB9AhVDVSj7fLTEYRYcmmEvphE2LUv1Kz/+qWhp9wG9OzzcinUbpq7PXsF4UfmraZ
	 FMy8A2s+GtuxfZLRiWamS9kl4645LhyzT/nn8N1A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732717AbgGTQCw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:02:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:36872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732372AbgGTQCt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 12:02:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02D0320773;
        Mon, 20 Jul 2020 16:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595260968;
        bh=bTZfeAWR2pBaRtAlL/mVt3xpRqcquaU//lEAkN+K/r4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mZR/A32xJgzcXca8yeS5vLIMXZm7Gi9/vV6KaLPerdNCN6Jkt/wkJlRCDplycZMqk
         KfB69+nkYqS9Xo0w63dYbC8lsPpK79b3Qg21dsBlMJh1ei98la6eUJcLph4z2TEy+z
         aWUZttBlFK5a+H0QszsHEzzFiYHcIui4mYIaO89U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, James Hilliard <james.hilliard1@gmail.com>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 5.4 160/215] USB: serial: cypress_m8: enable Simply Automated UPB PIM
Date:   Mon, 20 Jul 2020 17:37:22 +0200
Message-Id: <20200720152827.794324635@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152820.122442056@linuxfoundation.org>
References: <20200720152820.122442056@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Hilliard <james.hilliard1@gmail.com>

commit 5c45d04c5081c1830d674f4d22d4400ea2083afe upstream.

This is a UPB (Universal Powerline Bus) PIM (Powerline Interface Module)
which allows for controlling multiple UPB compatible devices from Linux
using the standard serial interface.

Based on vendor application source code there are two different models
of USB based PIM devices in addition to a number of RS232 based PIM's.

The vendor UPB application source contains the following USB ID's:

	#define USB_PCS_VENDOR_ID 0x04b4
	#define USB_PCS_PIM_PRODUCT_ID 0x5500

	#define USB_SAI_VENDOR_ID 0x17dd
	#define USB_SAI_PIM_PRODUCT_ID 0x5500

The first set of ID's correspond to the PIM variant sold by Powerline
Control Systems while the second corresponds to the Simply Automated
Incorporated PIM. As the product ID for both of these match the default
cypress HID->COM RS232 product ID it assumed that they both use an
internal variant of this HID->COM RS232 converter hardware. However
as the vendor ID for the Simply Automated variant is different we need
to also add it to the cypress_M8 driver so that it is properly
detected.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Link: https://lore.kernel.org/r/20200616220403.1807003-1-james.hilliard1@gmail.com
Cc: stable@vger.kernel.org
[ johan: amend VID define entry ]
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/serial/cypress_m8.c |    2 ++
 drivers/usb/serial/cypress_m8.h |    3 +++
 2 files changed, 5 insertions(+)

--- a/drivers/usb/serial/cypress_m8.c
+++ b/drivers/usb/serial/cypress_m8.c
@@ -59,6 +59,7 @@ static const struct usb_device_id id_tab
 
 static const struct usb_device_id id_table_cyphidcomrs232[] = {
 	{ USB_DEVICE(VENDOR_ID_CYPRESS, PRODUCT_ID_CYPHIDCOM) },
+	{ USB_DEVICE(VENDOR_ID_SAI, PRODUCT_ID_CYPHIDCOM) },
 	{ USB_DEVICE(VENDOR_ID_POWERCOM, PRODUCT_ID_UPS) },
 	{ USB_DEVICE(VENDOR_ID_FRWD, PRODUCT_ID_CYPHIDCOM_FRWD) },
 	{ }						/* Terminating entry */
@@ -73,6 +74,7 @@ static const struct usb_device_id id_tab
 	{ USB_DEVICE(VENDOR_ID_DELORME, PRODUCT_ID_EARTHMATEUSB) },
 	{ USB_DEVICE(VENDOR_ID_DELORME, PRODUCT_ID_EARTHMATEUSB_LT20) },
 	{ USB_DEVICE(VENDOR_ID_CYPRESS, PRODUCT_ID_CYPHIDCOM) },
+	{ USB_DEVICE(VENDOR_ID_SAI, PRODUCT_ID_CYPHIDCOM) },
 	{ USB_DEVICE(VENDOR_ID_POWERCOM, PRODUCT_ID_UPS) },
 	{ USB_DEVICE(VENDOR_ID_FRWD, PRODUCT_ID_CYPHIDCOM_FRWD) },
 	{ USB_DEVICE(VENDOR_ID_DAZZLE, PRODUCT_ID_CA42) },
--- a/drivers/usb/serial/cypress_m8.h
+++ b/drivers/usb/serial/cypress_m8.h
@@ -25,6 +25,9 @@
 #define VENDOR_ID_CYPRESS		0x04b4
 #define PRODUCT_ID_CYPHIDCOM		0x5500
 
+/* Simply Automated HID->COM UPB PIM (using Cypress PID 0x5500) */
+#define VENDOR_ID_SAI			0x17dd
+
 /* FRWD Dongle - a GPS sports watch */
 #define VENDOR_ID_FRWD			0x6737
 #define PRODUCT_ID_CYPHIDCOM_FRWD	0x0001


