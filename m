Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2187BC3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 02:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5CE620726
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 02:42:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=labau-com-tw.20150623.gappssmtp.com header.i=@labau-com-tw.20150623.gappssmtp.com header.b="qLzIGmeB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbgCFCmz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 21:42:55 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:50183 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbgCFCmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 21:42:55 -0500
Received: by mail-pj1-f65.google.com with SMTP id nm6so429305pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 18:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=labau-com-tw.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=X2iAqyMliBeJxX/WhSjVx//gMdFh6+oYc5QUw0Fxo34=;
        b=qLzIGmeBwnujzG/8YvCvI7zU1vM+wXG8Iv7KS5wYQ0Q3jgVd2Ze6/RCjKYbcBVDLog
         JHI8WYYo9LbJ6fLtaouJPTgPRoTSwMFEjUQ2kpniF6F0ZdxJFMLaYeVKAvdhbluo0UI0
         e9oMMF3odmsw+vd6A+rWIAmaJVfhxyuHq6eqnpguxelF9/Wl6kWfMEm8+RFNnzb0ylAi
         fIVtowr0XH5Bq61bJBtqe7nrDe6hW5f0jPl8TeHxIE/qvbDhWpnfYl1z1FxG1n0YK2zM
         h/ix3auQW+oeaHtDajSzQwDNNXPlOuqZvX6ylyXrdnrsQYFnArFj68GkGeKDJer+S39f
         IiZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=X2iAqyMliBeJxX/WhSjVx//gMdFh6+oYc5QUw0Fxo34=;
        b=rPDXKQ7F/ViApJEU+biTFuM+jbBxKepwJhrkcbTTQXf+NQQkDtNcjjHWcvIw1fXZch
         axfyDd8DM4Ia4jpemM1dP20vuPFAIiTAtjp7EPukmk7efAjcuu7Ale3mLxsWJG525Doy
         V9ZE7DJMRYLRDZDwTtaK+DG99A2JZVNjZlaSg2tA4zHtIV4NVmFH9SjwHMnvr+YSqNHv
         gP1ieBJ3IeykvLu3bsKITPJVmcuUw6V1x5kGec/niz+upUvzooFaWiU+9Z912fTjN5LP
         Cv1PyYqhyWl2RWYmYywKhjf5aTNAYbV+hg/eRPwhs8y5E9cBQ8NXYbVbpKZPOEjKH6LZ
         gANw==
X-Gm-Message-State: ANhLgQ2NEBYRGY3kS33oiCiS9CRnnz13JwTX2zFk/57erkwDmnctR8tE
        /J9erPOaDyZii7oH7Iek5WzF6A==
X-Google-Smtp-Source: ADFU+vsk3liOQkmtNF2K7LUtaWRZwQMJJnfXKTuYjW511Ti2qEiKj2FfCJN00oqlB2pKWAXOhbwmMg==
X-Received: by 2002:a17:90b:1a8b:: with SMTP id ng11mr1252999pjb.194.1583462573915;
        Thu, 05 Mar 2020 18:42:53 -0800 (PST)
Received: from localhost.localdomain (60-251-64-13.HINET-IP.hinet.net. [60.251.64.13])
        by smtp.gmail.com with ESMTPSA id q9sm32609064pgs.89.2020.03.05.18.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 18:42:53 -0800 (PST)
From:   Scott Chen <scott@labau.com.tw>
Cc:     young@labau.com.tw, jocelyn@labau.com.tw, roger@labau.com.tw,
        Scott Chen <scott@labau.com.tw>,
        Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Add a new PID for HP
Date:   Fri,  6 Mar 2020 10:40:47 +0800
Message-Id: <20200306024048.11408-1-scott@labau.com.tw>
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
 drivers/usb/serial/pl2303.c | 1 +
 drivers/usb/serial/pl2303.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/usb/serial/pl2303.c b/drivers/usb/serial/pl2303.c
index aab737e1e7b6..5cb1c63295f5 100644
--- a/drivers/usb/serial/pl2303.c
+++ b/drivers/usb/serial/pl2303.c
@@ -97,6 +97,7 @@ static const struct usb_device_id id_table[] = {
 	{ USB_DEVICE(COREGA_VENDOR_ID, COREGA_PRODUCT_ID) },
 	{ USB_DEVICE(YCCABLE_VENDOR_ID, YCCABLE_PRODUCT_ID) },
 	{ USB_DEVICE(SUPERIAL_VENDOR_ID, SUPERIAL_PRODUCT_ID) },
+	{ USB_DEVICE(HP_VENDOR_ID, HP_LD381_PRODUCT_ID) },
 	{ USB_DEVICE(HP_VENDOR_ID, HP_LD220_PRODUCT_ID) },
 	{ USB_DEVICE(HP_VENDOR_ID, HP_LD220TA_PRODUCT_ID) },
 	{ USB_DEVICE(HP_VENDOR_ID, HP_LD960_PRODUCT_ID) },
diff --git a/drivers/usb/serial/pl2303.h b/drivers/usb/serial/pl2303.h
index a019ea7e6e0e..80b20e980064 100644
--- a/drivers/usb/serial/pl2303.h
+++ b/drivers/usb/serial/pl2303.h
@@ -127,6 +127,7 @@
 
 /* Hewlett-Packard POS Pole Displays */
 #define HP_VENDOR_ID		0x03f0
+#define HP_LD381_PRODUCT_ID	0x0f7f
 #define HP_LM920_PRODUCT_ID	0x026b
 #define HP_TD620_PRODUCT_ID	0x0956
 #define HP_LD960_PRODUCT_ID	0x0b39
-- 
2.17.1

