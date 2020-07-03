Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C9ACC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 17:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 577E4208C7
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 17:44:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vxZsHJwv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbgGCRm2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 13:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbgGCRmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 13:42:06 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CF23C061794
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 10:42:06 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id 22so32760834wmg.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 10:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=As8A0RVzBKjotvgXeoxk2ZtBQ/Bg0sCNtYggCVfAltY=;
        b=vxZsHJwvvgk09IRk1MBBvInd06xDFaXaJSvUjtd1st5QBwE7HyMKZH7jepYLljpcQg
         zUHRMk04EnmsYB1tHOAEOToKbahfZNCxa2IgNpGUJzAY8RUNWCNGf5YJiWejTxgPu1E/
         0DNDIRZTdlSOPBhE42KiXRHEn84U1+zcJqILDik1LWMAVQR4OwHllAkevRZJAAxCxPdY
         Yrs0IHBWbngpyzHbb5g2+htPJdQxKakwoR0jr3Mtt3yPL6c8ag7wc5DkOdqUDX/rJBUU
         oD+k+3a0jVUSk5VbS3zeYPCF2xo/5RD7A7aQnMB21Z+a6om5KhL9zryyYKpkaJlLrsFB
         AacA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=As8A0RVzBKjotvgXeoxk2ZtBQ/Bg0sCNtYggCVfAltY=;
        b=ZEwxAT2yAqvOPWWc1pnl8rrCIQGJmFrCdPThyrZJ/JkBUV4iqlLNg1iBLreyzXRXK6
         48BjJHNRP6aE7r8ZahLKdDe6Q5uYVhqkxzS1KK9hjwnahoMz6tyTWo0TEu46T+U8ZwfM
         i7AOV7hAO50f04mUYGEMeJG0sVpLziOof8cAuWTw5vGc44/W4TUNiQ6U163o9SgLaJvj
         7gZx3/Gexs8VKqP6KUIrOt/wNRcW9mq6TVopCt6qVWF3tsBGIstCv2P8i2zClhpIMsxc
         WmCaP/TlxKh04TrSjmmLdRtzIchA4K1foU0IHqoZGQL2hKsEzQGq/lZDFzd443xVIQG3
         7GJg==
X-Gm-Message-State: AOAM530GySFvKbBR11U0Gd+FHS5L/b1RyydmUYEYfuOJECrsYqTHC3fc
        SVV376isTRNOH0zZ5bKush3upA==
X-Google-Smtp-Source: ABdhPJwolAxrC9FaOIOAI5J97mqd3etXuXAGwhxu+GQ5gnBfEv/QxrYF0gQrtBPhDn4CwIqSE6hE0g==
X-Received: by 2002:a1c:398b:: with SMTP id g133mr36495525wma.76.1593798125273;
        Fri, 03 Jul 2020 10:42:05 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id x11sm13625799wmc.26.2020.07.03.10.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 10:42:04 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Matthieu CASTET <castet.matthieu@free.fr>,
        Stanislaw Gruszka <stf_xl@wp.pl>,
        Damien Bergamini <damien.bergamini@free.fr>
Subject: [PATCH 05/30] usb: atm: ueagle-atm: Demote obvious misuse of kerneldoc to standard comment blocks
Date:   Fri,  3 Jul 2020 18:41:23 +0100
Message-Id: <20200703174148.2749969-6-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200703174148.2749969-1-lee.jones@linaro.org>
References: <20200703174148.2749969-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No attempt has been made to document any of the functions here.

Fixes the following W=1 kernel build warning(s):

 drivers/usb/atm/ueagle-atm.c:578: warning: Function parameter or member 'usb' not described in 'uea_send_modem_cmd'
 drivers/usb/atm/ueagle-atm.c:578: warning: Function parameter or member 'addr' not described in 'uea_send_modem_cmd'
 drivers/usb/atm/ueagle-atm.c:578: warning: Function parameter or member 'size' not described in 'uea_send_modem_cmd'
 drivers/usb/atm/ueagle-atm.c:578: warning: Function parameter or member 'buff' not described in 'uea_send_modem_cmd'
 drivers/usb/atm/ueagle-atm.c:679: warning: Function parameter or member 'usb' not described in 'uea_load_firmware'
 drivers/usb/atm/ueagle-atm.c:679: warning: Function parameter or member 'ver' not described in 'uea_load_firmware'

Cc: Matthieu CASTET <castet.matthieu@free.fr>
Cc: Stanislaw Gruszka <stf_xl@wp.pl>
Cc: Damien Bergamini <damien.bergamini@free.fr>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/usb/atm/ueagle-atm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/atm/ueagle-atm.c b/drivers/usb/atm/ueagle-atm.c
index e9fed9a887377..786299892c7f4 100644
--- a/drivers/usb/atm/ueagle-atm.c
+++ b/drivers/usb/atm/ueagle-atm.c
@@ -570,7 +570,7 @@ MODULE_PARM_DESC(annex,
 #define LOAD_INTERNAL     0xA0
 #define F8051_USBCS       0x7f92
 
-/**
+/*
  * uea_send_modem_cmd - Send a command for pre-firmware devices.
  */
 static int uea_send_modem_cmd(struct usb_device *usb,
@@ -672,7 +672,7 @@ static void uea_upload_pre_firmware(const struct firmware *fw_entry,
 	uea_leaves(usb);
 }
 
-/**
+/*
  * uea_load_firmware - Load usb firmware for pre-firmware devices.
  */
 static int uea_load_firmware(struct usb_device *usb, unsigned int ver)
-- 
2.25.1

