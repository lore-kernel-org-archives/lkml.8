Return-Path: <SRS0=AKQz=7N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B81CC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 01:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36CB12070E
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 01:50:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vbFhq2ZB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729583AbgEaBuU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 21:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729026AbgEaBuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 21:50:19 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE7DEC03E969;
        Sat, 30 May 2020 18:50:17 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id d3so2831182pln.1;
        Sat, 30 May 2020 18:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=qY4wFUZZgX45Dp3bBb91Af1u6lqNrHI4U7Zm/ob1lZU=;
        b=vbFhq2ZBaz3WNkbWS14mUaNoQtvtvYAf0+gMprmfSiEsBno3MYWI2OgsGqaV36ji7B
         Z/WXMh+Ik8WrOL42S6Ib3ybTk9Us3qO0M3D2zirFlpUUlGR7m2QvcH3Z6lrYtAx7inxQ
         bl8EeK418BzyOApisSll47cf8ZH2Fv2UyJE10pvLKn/wAlbnehv+tJfm0Uah+K3MHpEQ
         ZFwiGoMjF4Bl1BFjrgT1qh9mqAZYxQqgK/q/zTknmTvfJXbkoNfV7ZYCcla4bbRhMZCp
         gmnFrgiqeEKVDIcxETP7lKcr/NediBQi2ZAG/3K+IAQ5KO4e88MPxVkTVuEh/blWC6DH
         sABg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qY4wFUZZgX45Dp3bBb91Af1u6lqNrHI4U7Zm/ob1lZU=;
        b=b8DU1cpiYox2U89UWLN4A7So9BHkLNiXkXDmCu3jzkg114wHIK/wTUB0gFTzzVSRtQ
         Qz4+1chLNh0LwV97kKqZE3gl+SIamFME+7fn3EAPDd8tMR7tQcylmkoPWRV+ZpAS/3x2
         tzZZ7C4Jiv+5tC+aBM0lQR1SzkW+0cPpAxqY2sLVb9Hc8zsEanFirT0EtvZoLPoS6ZDM
         Kxd1GjxlTEIiBgh5B6trx2e69Bzjb7B8OUbAhfdB2ZV5J7YexqMJLzwrYEm2sq9iGRQq
         15ntborHJFe/JhEirQEjj/KQp9c59ro4zFXchBOC+cfvNeWTJ6n0OLzq7hBRSyVAOi6a
         WpdA==
X-Gm-Message-State: AOAM53194zM+lDfNbafVCzglJLgGxCJONPxo5E3N7N/zaj9dsVNVnL4O
        4UC8xhJowgNg8bfpVLLjE70=
X-Google-Smtp-Source: ABdhPJxEW2YrFqa9mfxbTY6AjWTEr+rVpCwSCxOKxc6PJBeYAp2buVfC7ZIEAxUAwiEwk3S+FROQ2g==
X-Received: by 2002:a17:902:7786:: with SMTP id o6mr15154545pll.279.1590889817306;
        Sat, 30 May 2020 18:50:17 -0700 (PDT)
Received: from localhost.localdomain ([2409:4070:519:d594:7c5c:d9ff:75c1:5478])
        by smtp.gmail.com with ESMTPSA id f3sm3326141pjw.57.2020.05.30.18.50.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 May 2020 18:50:16 -0700 (PDT)
From:   Lokesh Chebrolu <lokeshch007@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hadess@hadess.net, stern@rowland.harvard.edu,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        lokeshch007 <lokeshch007@gmail.com>
Subject: [PATCH] drivers: usb: core: driver: fixed 80 line character length issue
Date:   Sun, 31 May 2020 07:20:06 +0530
Message-Id: <1590889806-13539-1-git-send-email-lokeshch007@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: lokeshch007 <lokeshch007@gmail.com>

Fixed a coding style issue

Signed-off-by: Lokesh Chebrolu <lokeshch007@gmail.com>
---
 drivers/usb/core/driver.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
index f81606c..83c3287 100644
--- a/drivers/usb/core/driver.c
+++ b/drivers/usb/core/driver.c
@@ -1796,7 +1796,9 @@ int usb_autopm_get_interface_async(struct usb_interface *intf)
 EXPORT_SYMBOL_GPL(usb_autopm_get_interface_async);
 
 /**
- * usb_autopm_get_interface_no_resume - increment a USB interface's PM-usage counter
+ * usb_autopm_get_interface_no_resume -
+ * increment a USB interface's PM-usage counter
+ *
  * @intf: the usb_interface whose counter should be incremented
  *
  * This routine increments @intf's usage counter but does not carry out an
-- 
2.7.4

