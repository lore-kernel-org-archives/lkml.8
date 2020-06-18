Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F14C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 00:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3E7621582
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 00:09:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VnoR/E42"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbgFRAJj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 20:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726815AbgFRAJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 20:09:39 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3067C06174E;
        Wed, 17 Jun 2020 17:09:38 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id r7so4208787wro.1;
        Wed, 17 Jun 2020 17:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8R1LXzgL/Jku2RTLPjYpyn8qjHIXbV3iavnSntXNbW8=;
        b=VnoR/E42tQ2qJJeifwDNYcYcUZBmGXc8eLsazQJbd8Zgyok+9zJOIfwTyixVT6h32X
         DfI+tdD2eXSmRXliZd9ekVPz0GMkEdPnvyFvh3k9Aog7LEeVWqOc3sKGfBqJCEcgo46s
         0pXJ6+qiBN/R+H39nH+KkkqQeF4PnA4UwI8N8ogo4WCWcvmOHWICvFIdaHyOhWdO6Fh6
         IUGce88QKgkESqQ0tVSnsMvhKMTSLWj2LnLweVW3Qvi0ZxrAT14yNosuuueuFUNauCIY
         Trl1Cdm3s+SJnJcRQFyvkXfMIuM7BZwCNVZxFS+i4qvW2MuTMjy/5ksvzmfhLQ2wB48M
         U9yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8R1LXzgL/Jku2RTLPjYpyn8qjHIXbV3iavnSntXNbW8=;
        b=JD6vWALFMCSEHi0EVExQxqrFxMOtnJTlCDD/vBNUBn2lYcUPnCXvaCZVC76eGVG5BJ
         VfBG5fuPJNTOmjfm9u22lengsANZQ8ZzqUHxpFOsWBu+D/s5TSaFUIk4FZJ5Xi5W78J3
         nn6eMYKz7BD3wwNDfgfeAf1P6IuoSvM6sHjBSGIOJY1os10tfa/WxH/104XC8cY1/6Sj
         M5W7dY6qL42BOzVBGnjoCsqFA12Aj3b/87J7QxqOZ4t5Pa/9K/XTOy3ZF7CjW8dVAPkW
         HPoPrajBND7lDFiB2ovMv6THDXAwlHcGsXGKK7z8afvcivmxotrFsFASy3jIr4Ceoayx
         Y1iQ==
X-Gm-Message-State: AOAM530Wj2S/g32bWwRr1sK1FQW21GEmKW3TQ0XvBXDPTtHKBMTkx2s0
        xd6d9ZrXhh65HAZ2nyJBbZ0=
X-Google-Smtp-Source: ABdhPJyM0vBU7tkYmBrSufZy5V8UC0SGXTKp6S5BUUZn+IzECEJeaUL/rjBRSNZFccJiGPm1od47sQ==
X-Received: by 2002:a5d:65cd:: with SMTP id e13mr1823668wrw.213.1592438977497;
        Wed, 17 Jun 2020 17:09:37 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:4cc:a210:8e70:5aff:fe7e:da0a])
        by smtp.gmail.com with ESMTPSA id h29sm1310295wrc.78.2020.06.17.17.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 17:09:36 -0700 (PDT)
From:   Antonio Borneo <borneo.antonio@gmail.com>
To:     Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>, matt mooney <mfm@muteddisk.com>,
        Greg Kroah-Hartman <gregkh@suse.de>, linux-usb@vger.kernel.org
Cc:     Antonio Borneo <borneo.antonio@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] usbip: tools: fix module name in man page
Date:   Thu, 18 Jun 2020 02:08:18 +0200
Message-Id: <20200618000818.1048203-1-borneo.antonio@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 64e62426f40d ("staging: usbip: edit Kconfig and rename
CONFIG options") renamed the module usbip as usbip-host, but the
example in the man page still reports the old module name.

Fix the module name in usbipd.8

Signed-off-by: Antonio Borneo <borneo.antonio@gmail.com>
Fixes: 64e62426f40d ("staging: usbip: edit Kconfig and rename CONFIG options")
---
 tools/usb/usbip/doc/usbipd.8 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/usb/usbip/doc/usbipd.8 b/tools/usb/usbip/doc/usbipd.8
index ac4635db3f03..fb62a756893b 100644
--- a/tools/usb/usbip/doc/usbipd.8
+++ b/tools/usb/usbip/doc/usbipd.8
@@ -73,7 +73,7 @@ USB/IP client can connect and use exported devices.
 
 .SH EXAMPLES
 
-    server:# modprobe usbip
+    server:# modprobe usbip-host
 
     server:# usbipd -D
         - Start usbip daemon.

base-commit: b3a9e3b9622ae10064826dccb4f7a52bd88c7407
-- 
2.27.0

