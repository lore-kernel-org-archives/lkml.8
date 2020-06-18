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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C560BC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 00:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A110B21527
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 00:09:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zdu19YZ9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbgFRAJy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 20:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726815AbgFRAJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 20:09:53 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14357C06174E;
        Wed, 17 Jun 2020 17:09:52 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id t18so4183501wru.6;
        Wed, 17 Jun 2020 17:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J6tcTVaxshTLylBeirccLnjtixsqSNNU/JpjVsvryDA=;
        b=Zdu19YZ9n2RxZd+1wtT1x1caA1VWog4bsg+1UrnnVD6k2PpetDUWgZT42fCe1FZY8L
         S3ypRrYyL40n41HcUNQqbrS+UvGtZzjTJOt+RiYOgQWQvkJE2FI8uppWVNZDI/gWghjP
         RV2BpBKwybgr6JvTXU3Q/hutf7Rud44t2MBjO3JvmOHui9zBI4oUWFjcBD4UR7KfftzH
         esmLPEORGUO5bznqmVparYHvS2bqet9BzrLh/FNXz3G7x5XHLquCxlX7gxrbqVn2E0bv
         eOiqONRwO5CeNeU4vNn5UGz/1ugyVc2Jt7bckYRDInWcE+uF1qAbPzBTqxl1v0hC5F74
         sRDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J6tcTVaxshTLylBeirccLnjtixsqSNNU/JpjVsvryDA=;
        b=fckMEuj6QuAJy8U/dcQGnGOn077+zEBbpw6ef4v0myHzq4ifFAYXcHOLc5RGvvYtsH
         sPycANMBvUWf6FARET2e/ZDhOAOg47HAPXNDTQOrLiEEkADvgdK/MiehA3yOdI+plKJk
         oW9nM98ZtfmEckTvvtVKHRLCETeY/bNol8rLbnj7nI7hkncStQOXoHWQ+G6iHzpo4xYO
         NBo67GkASCggPpmznJ5A2Gr+xngcQwud9Ms3y/ARJ4/8kOgu+8yOoT8G7ar1xPn4HPuU
         2ATgpkZ+ao21gqxAikQTvPZV1gGE0HuhkMbBJgYdv8w8v328t20KQC69rPglv/FbNWf7
         UV9Q==
X-Gm-Message-State: AOAM531whqm56HWtFpiNhn7PNm7iFN7hy6Tj5r1F/SPvx04QbIMu955C
        eocRX0cwDVDlJMM8HXujUjnkRKQQj9802g==
X-Google-Smtp-Source: ABdhPJyc/I5Hrx7+o9kLCPe1siTl01D3kZ2hLu10yX7sGNPbOrQauh/GjYvtLkV9mDja2DD5WcSOWQ==
X-Received: by 2002:adf:f5ca:: with SMTP id k10mr1621344wrp.305.1592438990770;
        Wed, 17 Jun 2020 17:09:50 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:4cc:a210:8e70:5aff:fe7e:da0a])
        by smtp.gmail.com with ESMTPSA id u13sm1280223wrp.53.2020.06.17.17.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 17:09:50 -0700 (PDT)
From:   Antonio Borneo <borneo.antonio@gmail.com>
To:     Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>, linux-usb@vger.kernel.org
Cc:     Antonio Borneo <borneo.antonio@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] usbip: tools: add in man page how to load the client's module
Date:   Thu, 18 Jun 2020 02:08:31 +0200
Message-Id: <20200618000831.1048255-1-borneo.antonio@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While the man page usbipd.8 already informs the user on which
kernel module has to be used on server side, the man page usbip.8
does not provide any equivalent information on client side.
Also, it could be hard for a newby to identify the proper usbip
client kernel module, due to the name "vhci-hcd" that has no
immediate assonance with usbip.

Add in usbip.8 the command to add the module vhci-hcd, similarly
as it's already present in usbipd.8 for usbip-host.

Signed-off-by: Antonio Borneo <borneo.antonio@gmail.com>
---
 tools/usb/usbip/doc/usbip.8 | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/usb/usbip/doc/usbip.8 b/tools/usb/usbip/doc/usbip.8
index a6097be25d28..81313f4913b4 100644
--- a/tools/usb/usbip/doc/usbip.8
+++ b/tools/usb/usbip/doc/usbip.8
@@ -85,6 +85,8 @@ List local USB devices.
     client:# usbip list --remote=server
         - List exportable usb devices on the server.
 
+    client:# modprobe vhci-hcd
+
     client:# usbip attach --remote=server --busid=1-2
         - Connect the remote USB device.
 
-- 
2.27.0

