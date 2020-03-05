Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E17C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 09:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ED702073D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 09:43:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=labau-com-tw.20150623.gappssmtp.com header.i=@labau-com-tw.20150623.gappssmtp.com header.b="RQ1TfrBX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgCEJnQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 04:43:16 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36392 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbgCEJnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 04:43:16 -0500
Received: by mail-pl1-f194.google.com with SMTP id g12so2411561plo.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 01:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=labau-com-tw.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=zM3coQP4jzTNu1UON2w3xTtkJ9MHKb1rTJhrWJXFY44=;
        b=RQ1TfrBXC3FKItT3TVdLN459ThKx1gJxpw/3NewcSfU1iTlcXJ7V1FRJ/Dzg3rHLoH
         +Ichle9zIYwjQiPlvN6w8BAXJqhDNggBtCxH4MF4I0yIbHV4bZu5xJeT/QHu0gFvL0RT
         M+yM+d6Az9lYu8ZEgUUHTiMIpbwPszybqOAMu5SBwUBb8tf1FZPyQv46TcX71xLhkWpA
         vY+6IcJCqXzUXIuZzV2pJSJHnBizL/joG54j7m9SkmXjFhXmedM6w/wSGHLBBTjzPe+t
         sSWCZj1DQJwZ8j65UJkhcdVSWicYcRJ+m4ls9ZQ+nTIpv8fEb7M6ntxaUQz+gKol+tbn
         T54Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zM3coQP4jzTNu1UON2w3xTtkJ9MHKb1rTJhrWJXFY44=;
        b=OIm7ZWkZIVjCqpqWwPyMEoZJyZPmWzBsYyrDzzANySHee2TiQGx5fhNtMEH03RKT37
         3nfmHFheNJ3BSu/IlhSLa1FIXiHSJgRS6yM8M4Vb6BbRIkzfTjfuZVwKLMH9/NzlFmRC
         JeudAh7viQTR3GNNdba3rhptQgQgRYDEkDBLoYU7k3+m/5MV6LRUn1jpO0tuoCISVV+D
         +GryyE0J4zQ2Wl0TEhXpd9fbyxOjtRpwN9dIbUS8mJma7PoLFpP3DqMk5xOaudGGd4Za
         ZA8F6tJRh5qFXPZSFh07LvWsYY70xBiU3dP4sqZrLfXUqaAMVLevEeyhKArjYEuJAcka
         AXUA==
X-Gm-Message-State: ANhLgQ1Xx28DDgmIXs/g8O9YUzKwvb7esr4zewfa1bN3Dpqpv+6R8Ron
        ooC44QnXVYa7AYUiYr3gJVmXug==
X-Google-Smtp-Source: ADFU+vuDr1dW8XFz9At4DuK0qmWO3ro/Out+khuYHLYmrrcLPMeAjsMZRHLEBNCDXcL8HuCgg2Tq/A==
X-Received: by 2002:a17:90a:9f98:: with SMTP id o24mr7456679pjp.172.1583401394791;
        Thu, 05 Mar 2020 01:43:14 -0800 (PST)
Received: from localhost.localdomain (60-251-64-13.HINET-IP.hinet.net. [60.251.64.13])
        by smtp.gmail.com with ESMTPSA id y14sm1728401pfp.59.2020.03.05.01.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 01:43:14 -0800 (PST)
From:   Scott Chen <scott@labau.com.tw>
Cc:     young@labau.com.tw, jocelyn@labau.com.tw,
        Scott Chen <scott@labau.com.tw>,
        Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Add device ids to pl2303 for the HP LD381 Display
Date:   Thu,  5 Mar 2020 17:42:15 +0800
Message-Id: <20200305094215.10105-1-scott@labau.com.tw>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

