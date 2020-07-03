Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7DABC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 17:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B9492084C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 17:44:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V678svqB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbgGCRmG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 13:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbgGCRmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 13:42:03 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB55C08C5DD
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 10:42:02 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id b6so33551641wrs.11
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 10:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oUjHYg6XEDC1PONs5ecYCAMD6hQ6HUyQ5SfKo5ZoAoI=;
        b=V678svqBj5ZEzdGJKB69Vodq9pQ31EIwBoLQP1As6lWOXIP/1kJzIqJLjtOvblSkXy
         MGxl0iGDkHU0uljNJKGH03hr+d07Q2Snp4haL9GaJ2ECnEqfljKwL6ibxma86kajreu8
         TA9jvVxRARz9NQU8MvUH+6tDKzsNjuSpnqk6vImwQ4hXw35BuvZcyA+zSVh6APrv+3AX
         gmXxT3q/ZYNpFS1sGomuuZ5QRj5DfnK67GvuVpvUsP0YzvhguEnTqDR0J/QZNL57ZKIP
         TYqim9pcfdfTLug72OqEjJojTk83E5F+sCUgu8ZcofVXsYiA6JFIbxmSDf8sHNsVMx8a
         K4oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oUjHYg6XEDC1PONs5ecYCAMD6hQ6HUyQ5SfKo5ZoAoI=;
        b=jCJVKzjHGZtf71IuJWGOb8jaNjO6VX6Mh6kWABNFdiO9dIGkJrb1QdeW9dzX23oiwT
         DxNdWqLzVC5Yi2YAvDBIde3U/IVHSxP2bTXNXjdV7LjSl2Sm8gCNE7mgULN8FTGAs9Vv
         KBbUw/eivxkzg/rWVx9Gl4idz0+JaTn8yf7LYWTc7gL75jrpmVy674oBPHK5pG8pCE1D
         ogt4NFIWbwfGqijzL3DYZDWo94pmXHIdsPhuxbrq/N/xnAYW8z/0Z5ai88o2OCddWaAH
         z0/VdKQVZERJMQdsBL3C1BSOqnqfTCFP6yci2UXWUgKov9gNV7bUTAmCcpFzCwwrXpoE
         SsFg==
X-Gm-Message-State: AOAM531/LyxTlv6qH8cj/kXFv2jKVmNUfj6pnKubriHmw+B6PfJ9BQIw
        9sdQyA6dwdEJ6Kw4ss8y/PTzYg==
X-Google-Smtp-Source: ABdhPJzGvTblYJ7UXyonhX71xr+CGK3bV2MNNRAwpzZl2DyxwAc9szCyt2n/Ezh4sar6tAoDQOPNeA==
X-Received: by 2002:adf:f2c5:: with SMTP id d5mr38704827wrp.96.1593798121551;
        Fri, 03 Jul 2020 10:42:01 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id x11sm13625799wmc.26.2020.07.03.10.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 10:42:00 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH 03/30] usb: core: ledtrig-usbport: Demote obvious misuse of kerneldoc to standard comment blocks
Date:   Fri,  3 Jul 2020 18:41:21 +0100
Message-Id: <20200703174148.2749969-4-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200703174148.2749969-1-lee.jones@linaro.org>
References: <20200703174148.2749969-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No attempt has been made to document any of the functions here.

Fixes the following W=1 kernel build warning(s):

 drivers/usb/core/ledtrig-usbport.c:42: warning: Function parameter or member 'usbport_data' not described in 'usbport_trig_usb_dev_observed'
 drivers/usb/core/ledtrig-usbport.c:42: warning: Function parameter or member 'usb_dev' not described in 'usbport_trig_usb_dev_observed'
 drivers/usb/core/ledtrig-usbport.c:71: warning: Function parameter or member 'usbport_data' not described in 'usbport_trig_update_count'
 drivers/usb/core/ledtrig-usbport.c:131: warning: Function parameter or member 'usbport_data' not described in 'usbport_trig_port_observed'
 drivers/usb/core/ledtrig-usbport.c:131: warning: Function parameter or member 'usb_dev' not described in 'usbport_trig_port_observed'
 drivers/usb/core/ledtrig-usbport.c:131: warning: Function parameter or member 'port1' not described in 'usbport_trig_port_observed'

Cc: Rafał Miłecki <rafal@milecki.pl>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/usb/core/ledtrig-usbport.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/core/ledtrig-usbport.c b/drivers/usb/core/ledtrig-usbport.c
index c12ac56606c3f..ba371a24ff781 100644
--- a/drivers/usb/core/ledtrig-usbport.c
+++ b/drivers/usb/core/ledtrig-usbport.c
@@ -34,7 +34,7 @@ struct usbport_trig_port {
  * Helpers
  ***************************************/
 
-/**
+/*
  * usbport_trig_usb_dev_observed - Check if dev is connected to observed port
  */
 static bool usbport_trig_usb_dev_observed(struct usbport_trig_data *usbport_data,
@@ -64,7 +64,7 @@ static int usbport_trig_usb_dev_check(struct usb_device *usb_dev, void *data)
 	return 0;
 }
 
-/**
+/*
  * usbport_trig_update_count - Recalculate amount of connected matching devices
  */
 static void usbport_trig_update_count(struct usbport_trig_data *usbport_data)
@@ -123,7 +123,7 @@ static const struct attribute_group ports_group = {
  * Adding & removing ports
  ***************************************/
 
-/**
+/*
  * usbport_trig_port_observed - Check if port should be observed
  */
 static bool usbport_trig_port_observed(struct usbport_trig_data *usbport_data,
-- 
2.25.1

