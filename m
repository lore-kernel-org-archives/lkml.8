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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1E97C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 05:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C087F206DB
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 05:31:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="coHOgwnX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbgFPFbp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 01:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbgFPFbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 01:31:45 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6184C05BD43;
        Mon, 15 Jun 2020 22:31:44 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id c75so17634093ila.8;
        Mon, 15 Jun 2020 22:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vNrZSk1BNxvGmkzA5HV5T4wgysnOkc6TWySqTow+ilw=;
        b=coHOgwnXZorOZdKwwycOKzDXVwrks/h95MI/pzkQkzbcn1Yg+JB7q7Lg7D+ZaylgBO
         tsEiY0bTqBEDRrVb6Gu8z6j/Fk6Z/u1ya4NC/UoVu5rU5HuZ0vY1BrsYyi78ma0Nnl0/
         FpesvUh/BlL1+90tMMGfJ0T2al05jCEuEmVfo7Wx6e43NkzIWaGhpgYZ4nQ3GpMPVknA
         h3tH3ASFw1KmxDd61otYU6jmk1AKeu+7wJCW7Z4Yra6Cg8ZYas7Frg2uQhNKnwVu+PAx
         umXwLZsFMmY1f84ig8+HqNxQUiak+ely92CGnSRURaaHaDeqd2D1neG9FoM6so8HWdwY
         C8og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vNrZSk1BNxvGmkzA5HV5T4wgysnOkc6TWySqTow+ilw=;
        b=GW8BT9yK/U0YwKcDS6uClT53FpPXHt+El5jvWGAlWMjIej4PiVeY1DuD9+kDNrR3De
         j8gruv8AU6FmlcosnQn7EjrSJeRrzqR/+Wz71cjV0qf/NVpujm6rJsAJJZbtpgg9Rq2x
         D1DUuX8jBJdJzsfs4g/b6eTZgNA3zz5Vc60Fye5PYs8bXxupDT/aJfPRPreFOuHkfGBy
         Pz/ASxyF1NgZRIKFBNQSfHp1AqHUNgSdbCKgGPtf51ayJPyFkfHQZMVIs5HiZ8AKKCbh
         QKJ+XOQ9rBwr16Cu7L+yrlQNAJNwT7fSz2hGa4+55eRppBDqu55HrE6MMIHMh+Blh5bj
         Aihw==
X-Gm-Message-State: AOAM532LzYOwAQpShetI+eJ3SbMjaRHLnCxvJCGFU46aopk5KMYY3ZkE
        +Nq90kxaewJ1kwlbEKnTeaIOI2fZuCo=
X-Google-Smtp-Source: ABdhPJyIfjq+WLaCs9A+AKdCSCbl4o8wSfYkqHGps+xUbtM2MYbOARPhy6iQ+LJzBS9MsSOhY+DeSQ==
X-Received: by 2002:a92:a1d1:: with SMTP id b78mr1494407ill.164.1592285503741;
        Mon, 15 Jun 2020 22:31:43 -0700 (PDT)
Received: from james-x399.localdomain (71-218-100-23.hlrn.qwest.net. [71.218.100.23])
        by smtp.gmail.com with ESMTPSA id y12sm9089077ili.83.2020.06.15.22.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 22:31:43 -0700 (PDT)
From:   James Hilliard <james.hilliard1@gmail.com>
To:     linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>,
        James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH] USB: Serial: cypress_M8: Enable Simply Automated UPB PIM
Date:   Mon, 15 Jun 2020 23:31:13 -0600
Message-Id: <20200616053113.1792598-1-james.hilliard1@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is UPB(Universal Powerline Bus) PIM(Powerline Interface Module)
which allows for controlling multiple UPB comaptible devices from
Linux.

This device internally uses a Cypress HID->COM interface.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
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

