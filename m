Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88EC4C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 22:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 604942098B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 22:04:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nlTNk9uF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbgFPWEV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 18:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgFPWEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 18:04:20 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A02C061573;
        Tue, 16 Jun 2020 15:04:20 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id j19so87201ilk.9;
        Tue, 16 Jun 2020 15:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8YvR3KOM2+UZcgNgTkLEwMZFvasq6WqgYL2ECzZJc0w=;
        b=nlTNk9uFvhANOGMZLtZLbE7jzXGMu0dJUAPNYNMRD9P2+cyhwqeKDAWH4/mdBfiSwl
         wSoksVgqe1lpj+IkHblVp0CJTEwq1I2qqstXaY84kUwUVTVtsNfDT27lgKhNF4mvCzgC
         EJvWgLJOC0Zkf6Prw5FWYXJuHRtTV2KGF7+f5rj95RvMt0WYsRKtoMgNub/z9HRMSH9K
         y/2GO5kFph3kW1pazugHxDMliIZTedwQ0rWQy7tcXVQUsEnf2WD4NRroVzpZ4v+rOKU3
         HDCb+i5Ugnbj2BuszGHdCSFOzIqJ7Va+k8uK0k1QUzU+dtTPH+Y7AhGeHxCyxJYurC4B
         TT6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8YvR3KOM2+UZcgNgTkLEwMZFvasq6WqgYL2ECzZJc0w=;
        b=TlHJpE7BKXGDOWGMgjNlb2H2Ez0lflh45CDzXeL1Mq3VO5t2VPiK5tXSRRc4xV+WPU
         hxnPeVNrEVaKioZ3HqEVQrbgy3usjrIYxnGzWTlWU2zkY+fCwmvtZjzQOPLE00n++YAn
         Kf7Nw3OBrphcMFYb2kh1BjrYsRd96apt6UDH5dFZAGEtoL0dHU5m/ghpXWt1BTGe69fp
         anDeGCuYQ4GiZb1yVMsH2LY7+50ubIeRQhp8GVQRpRorTWcQj2qNtegwisZ3uTTrbQKs
         sGuRQIrBcTl1pUciCFI8pGow/YGZZlqLsypzRuNb9bUn2pY3Zy4pP9ONpakA+FGrK3wK
         uIwA==
X-Gm-Message-State: AOAM531xZwBOFy33Ll+4P13pIvkZGTu2dkWqTwQWz0n+QXgNBYvkqgPt
        bFmnJcZuirfPx57waueCxwiBfV96JRg=
X-Google-Smtp-Source: ABdhPJyUCfOMuYDsR1gSHzPDSfFEAqkteNoF++Vl+LHEvELEpAVS3jnBoM7lG/MxZNIiRQwXurvIYA==
X-Received: by 2002:a92:5e4a:: with SMTP id s71mr5214475ilb.119.1592345059173;
        Tue, 16 Jun 2020 15:04:19 -0700 (PDT)
Received: from james-x399.localdomain (71-218-100-23.hlrn.qwest.net. [71.218.100.23])
        by smtp.gmail.com with ESMTPSA id p12sm8571158ioj.37.2020.06.16.15.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 15:04:18 -0700 (PDT)
From:   James Hilliard <james.hilliard1@gmail.com>
To:     linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>,
        James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH v2] USB: Serial: cypress_M8: Enable Simply Automated UPB PIM
Date:   Tue, 16 Jun 2020 16:04:03 -0600
Message-Id: <20200616220403.1807003-1-james.hilliard1@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a UPB(Universal Powerline Bus) PIM(Powerline Interface Module)
which allows for controlling multiple UPB compatible devices from
Linux using the standard serial interface.

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
---
Changes v1 -> v2:
  - Add more detailed commit message.
---
 drivers/usb/serial/cypress_m8.c | 2 ++
 drivers/usb/serial/cypress_m8.h | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/drivers/usb/serial/cypress_m8.c b/drivers/usb/serial/cypress_m8.c
index 216edd5826ca..ecda82198798 100644
--- a/drivers/usb/serial/cypress_m8.c
+++ b/drivers/usb/serial/cypress_m8.c
@@ -59,6 +59,7 @@ static const struct usb_device_id id_table_earthmate[] = {
 
 static const struct usb_device_id id_table_cyphidcomrs232[] = {
 	{ USB_DEVICE(VENDOR_ID_CYPRESS, PRODUCT_ID_CYPHIDCOM) },
+	{ USB_DEVICE(VENDOR_ID_SAI, PRODUCT_ID_CYPHIDCOM) },
 	{ USB_DEVICE(VENDOR_ID_POWERCOM, PRODUCT_ID_UPS) },
 	{ USB_DEVICE(VENDOR_ID_FRWD, PRODUCT_ID_CYPHIDCOM_FRWD) },
 	{ }						/* Terminating entry */
@@ -73,6 +74,7 @@ static const struct usb_device_id id_table_combined[] = {
 	{ USB_DEVICE(VENDOR_ID_DELORME, PRODUCT_ID_EARTHMATEUSB) },
 	{ USB_DEVICE(VENDOR_ID_DELORME, PRODUCT_ID_EARTHMATEUSB_LT20) },
 	{ USB_DEVICE(VENDOR_ID_CYPRESS, PRODUCT_ID_CYPHIDCOM) },
+	{ USB_DEVICE(VENDOR_ID_SAI, PRODUCT_ID_CYPHIDCOM) },
 	{ USB_DEVICE(VENDOR_ID_POWERCOM, PRODUCT_ID_UPS) },
 	{ USB_DEVICE(VENDOR_ID_FRWD, PRODUCT_ID_CYPHIDCOM_FRWD) },
 	{ USB_DEVICE(VENDOR_ID_DAZZLE, PRODUCT_ID_CA42) },
diff --git a/drivers/usb/serial/cypress_m8.h b/drivers/usb/serial/cypress_m8.h
index 35e223751c0e..ca2d951ee238 100644
--- a/drivers/usb/serial/cypress_m8.h
+++ b/drivers/usb/serial/cypress_m8.h
@@ -25,6 +25,9 @@
 #define VENDOR_ID_CYPRESS		0x04b4
 #define PRODUCT_ID_CYPHIDCOM		0x5500
 
+/* Simply Automated HID->COM UPB PIM */
+#define VENDOR_ID_SAI		0x17dd
+
 /* FRWD Dongle - a GPS sports watch */
 #define VENDOR_ID_FRWD			0x6737
 #define PRODUCT_ID_CYPHIDCOM_FRWD	0x0001
-- 
2.25.1

