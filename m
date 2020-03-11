Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75CCAC10F29
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 06:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F41920873
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 06:14:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=labau-com-tw.20150623.gappssmtp.com header.i=@labau-com-tw.20150623.gappssmtp.com header.b="ifvfOXs7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728225AbgCKGOp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 02:14:45 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42725 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbgCKGOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 02:14:45 -0400
Received: by mail-pf1-f195.google.com with SMTP id x2so328016pfn.9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 23:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=labau-com-tw.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=aqRB1ipP8pdB6p4pCG0uaJYVXRVTNhaWdbAUG12bd4w=;
        b=ifvfOXs7gSPHoC0g6CDbJI+XI/lz2kXJSnbyHO1pr/8L0pwdxlt9TsQdS/MOCujocu
         BffzEbSEpqsW9SlU/q+BOU9fvUK8iy1I0NSHCqv4fHk8jw904z956acdJaMIGjp+pALf
         syFr/laQ6rbgMxqj6tOLUq7RMEqUU3RsgWXV5z4fFsFMLrTm8FAcM7VZkzX9AB+guwAk
         kazkJxNiOXkw6oANx9Y2RGkGLt6MEXM9m9M9+cQdWKgHOuOd9mu5ujmA4BZWf+9oBIrX
         2ilaTHLPj+WY60Kf0xQvJ6Ddfkss/uLOIhLPkJUIcPkUpiaVAm7F1u/e93U71H26xLI8
         jq4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=aqRB1ipP8pdB6p4pCG0uaJYVXRVTNhaWdbAUG12bd4w=;
        b=MCRB04DBRPTa9aSUBKT/uEma5Ig6R2qf5nSszg9w+FGt22Hm/1DEdb99IkA5I9ox6k
         KV/flAVv0TDUycdvYWpd8z7SHhr5sSYtiYk/mjaaVre/L5LTLWkLfjEiWgfWpeaAtUup
         7+I0HEw+VDEvWm5w/X04c6KMhyZ25qeW9ZyQu0/wmpz+9GBczHWOG7Rnyv4QWooplLMc
         BlRnr6nSjr+8Ef9CKdgndv/BuXdgrmxa+pUeTfB5SlsAj7ZI1y8sKh/CsWsNe1mCwaTe
         1S+Z4x/iqIUPWaa8zEGXk4U+fqXE5VjMQRtl/ViLxS+8EUZKty+vkEnCAP2lw+hlWLNd
         fLPA==
X-Gm-Message-State: ANhLgQ1J7lD6S8XYZK0TT/RClwYOnBMwuPpTjJWfsf8l0qOszagjp5BA
        Hfr//Z7bmVPi8ogJzn85OJ9G5w==
X-Google-Smtp-Source: ADFU+vsOnDdfjoSn+srks/CyROEd5VUqKn+ZsIB9LDviWMCRsG9Wx/jzLnyCCULd9K2Yfj+jbgU7SQ==
X-Received: by 2002:aa7:8548:: with SMTP id y8mr1314503pfn.166.1583907284180;
        Tue, 10 Mar 2020 23:14:44 -0700 (PDT)
Received: from localhost.localdomain (60-251-64-13.HINET-IP.hinet.net. [60.251.64.13])
        by smtp.gmail.com with ESMTPSA id x4sm43602306pgi.76.2020.03.10.23.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 23:14:43 -0700 (PDT)
From:   Scott Chen <scott@labau.com.tw>
Cc:     young@labau.com.tw, jocelyn@labau.com.tw, larsm17@gmail.com,
        Scott Chen <scott@labau.com.tw>,
        Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] USB: serial: pl2303: add a new PID for HP
Date:   Wed, 11 Mar 2020 14:14:23 +0800
Message-Id: <20200311061423.20686-1-scott@labau.com.tw>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a device id for HP LD381 Display
LD381:   03f0:0f7f

Signed-off-by: Scott Chen <scott@labau.com.tw>
---
 Changes in v2:
  - keep HP entries sorted by PID

 drivers/usb/serial/pl2303.c | 1 +
 drivers/usb/serial/pl2303.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/usb/serial/pl2303.c b/drivers/usb/serial/pl2303.c
index aab737e1e7b6..c5a2995dfa2e 100644
--- a/drivers/usb/serial/pl2303.c
+++ b/drivers/usb/serial/pl2303.c
@@ -99,6 +99,7 @@ static const struct usb_device_id id_table[] = {
 	{ USB_DEVICE(SUPERIAL_VENDOR_ID, SUPERIAL_PRODUCT_ID) },
 	{ USB_DEVICE(HP_VENDOR_ID, HP_LD220_PRODUCT_ID) },
 	{ USB_DEVICE(HP_VENDOR_ID, HP_LD220TA_PRODUCT_ID) },
+	{ USB_DEVICE(HP_VENDOR_ID, HP_LD381_PRODUCT_ID) },
 	{ USB_DEVICE(HP_VENDOR_ID, HP_LD960_PRODUCT_ID) },
 	{ USB_DEVICE(HP_VENDOR_ID, HP_LD960TA_PRODUCT_ID) },
 	{ USB_DEVICE(HP_VENDOR_ID, HP_LCM220_PRODUCT_ID) },
diff --git a/drivers/usb/serial/pl2303.h b/drivers/usb/serial/pl2303.h
index a019ea7e6e0e..52db5519aaf0 100644
--- a/drivers/usb/serial/pl2303.h
+++ b/drivers/usb/serial/pl2303.h
@@ -130,6 +130,7 @@
 #define HP_LM920_PRODUCT_ID	0x026b
 #define HP_TD620_PRODUCT_ID	0x0956
 #define HP_LD960_PRODUCT_ID	0x0b39
+#define HP_LD381_PRODUCT_ID	0x0f7f
 #define HP_LCM220_PRODUCT_ID	0x3139
 #define HP_LCM960_PRODUCT_ID	0x3239
 #define HP_LD220_PRODUCT_ID	0x3524
-- 
2.17.1

