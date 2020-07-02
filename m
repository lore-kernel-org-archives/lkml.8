Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03691C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 14:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB5862067D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 14:47:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fmzINiOY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730159AbgGBOr3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 10:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730094AbgGBOrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 10:47:07 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2398EC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 07:47:07 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id f7so25785160wrw.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 07:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iWzVZz/7UdELZYlP3FhiTP4gcXKvtcBfoc9CQcE8FIc=;
        b=fmzINiOYDHpN5/coulur/6WfMZq1rarCvkcLJwqIc1Y/vuMXSWLwF+MLPBxRgaKlQK
         4Ji78wYEgQDaVwbW+4aRXxTfZHJm77A0AyZrWNa8iwJEB939IQCZ3ynS6uLTOiB1a9I2
         4IxSgs+zF3yxBmJD+DssJh5yua5pBPdkwPunbhnQf1J3GyvfXFXkW96zLVRS7zZMabR8
         ez3irtf10ueuJ+NkEVZeYLDkvDyEzRDUV9dqwNeV0UJKx0GjdO/0nuaBTDtHbguY/KLw
         w9sj5TX+PniKeuvfQirEYAfhKEOWP1kIfpkYj8uGLXc46IX1tnBfuHJbgybJsR6P9RS+
         yfeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iWzVZz/7UdELZYlP3FhiTP4gcXKvtcBfoc9CQcE8FIc=;
        b=FtKSSYRCuE7pg0uDuzkJIYxUs0zq8ee3CiBPKggoq2suSo3pW4qtc9Z1FkK1ctLfBc
         OvIBBMo7w/7Kexe04Vi9tL2bm2cvHz0NwnfIXLMGCzD3ndoQim70HpIZesxB75WoFb4n
         3mz8U+Jt86lXN60F4W/rlEvpL9mKR9qxu4m52pEshQTTBgGQdkKGmxZ+cmlMwmBNY8q2
         EILB524v6m0T6tLzq9POVUci0/lySMbFlKeAwqNol0iqFuvk4XyME+NCdjj3+E0KeufQ
         jDU2NINhDQkyfP4+9OgKlFRD7NA/kaU1GNOpSyBoHhl9GRoRzm3lHrKDmGiRtK6n5k8c
         rEYw==
X-Gm-Message-State: AOAM533+ECCrLKVOEe7VbNVi8UvJ2zTUad64d9qzkYYBS5H2OxAH7jBq
        gNN9dJQ7+bpLM+JZfW90z9cHdg==
X-Google-Smtp-Source: ABdhPJyebZwL479ANazYAPU87dJ7Xv2lt4Tl/LxXMiJfnCK83vmeGTFhFdEYRoQEiRdz8686JpwKIw==
X-Received: by 2002:a5d:4984:: with SMTP id r4mr31222396wrq.215.1593701225820;
        Thu, 02 Jul 2020 07:47:05 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id g14sm7002737wrw.83.2020.07.02.07.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 07:47:05 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Peter Korsgaard <jacmet@sunsite.dk>,
        Oliver Neukum <oneukum@suse.com>
Subject: [PATCH 28/30] usb: c67x00: c67x00-hcd: Demote obvious misuse of kerneldoc to standard comment blocks
Date:   Thu,  2 Jul 2020 15:46:23 +0100
Message-Id: <20200702144625.2533530-29-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200702144625.2533530-1-lee.jones@linaro.org>
References: <20200702144625.2533530-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No attempt has been made to document any of the functions here.

Fixes the following W=1 kernel build warning(s):

 drivers/usb/c67x00/c67x00-hcd.c:237: warning: Function parameter or member 'sie' not described in 'c67x00_hcd_irq'
 drivers/usb/c67x00/c67x00-hcd.c:237: warning: Function parameter or member 'int_status' not described in 'c67x00_hcd_irq'
 drivers/usb/c67x00/c67x00-hcd.c:237: warning: Function parameter or member 'msg' not described in 'c67x00_hcd_irq'
 drivers/usb/c67x00/c67x00-hcd.c:267: warning: Function parameter or member 'hcd' not described in 'c67x00_hcd_start'
 drivers/usb/c67x00/c67x00-hcd.c:279: warning: Function parameter or member 'hcd' not described in 'c67x00_hcd_stop'

Cc: Peter Korsgaard <jacmet@sunsite.dk>
Cc: Oliver Neukum <oneukum@suse.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/usb/c67x00/c67x00-hcd.c | 6 +++---
 drivers/usb/class/cdc-wdm.c     | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/c67x00/c67x00-hcd.c b/drivers/usb/c67x00/c67x00-hcd.c
index c39eee17c0e46..39f2376663314 100644
--- a/drivers/usb/c67x00/c67x00-hcd.c
+++ b/drivers/usb/c67x00/c67x00-hcd.c
@@ -228,7 +228,7 @@ static int c67x00_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
  * Main part of host controller driver
  */
 
-/**
+/*
  * c67x00_hcd_irq
  *
  * This function is called from the interrupt handler in c67x00-drv.c
@@ -260,7 +260,7 @@ static void c67x00_hcd_irq(struct c67x00_sie *sie, u16 int_status, u16 msg)
 	}
 }
 
-/**
+/*
  * c67x00_hcd_start: Host controller start hook
  */
 static int c67x00_hcd_start(struct usb_hcd *hcd)
@@ -272,7 +272,7 @@ static int c67x00_hcd_start(struct usb_hcd *hcd)
 	return 0;
 }
 
-/**
+/*
  * c67x00_hcd_stop: Host controller stop hook
  */
 static void c67x00_hcd_stop(struct usb_hcd *hcd)
diff --git a/drivers/usb/class/cdc-wdm.c b/drivers/usb/class/cdc-wdm.c
index 4dceaeca46e73..7f5de956a2fc8 100644
--- a/drivers/usb/class/cdc-wdm.c
+++ b/drivers/usb/class/cdc-wdm.c
@@ -941,7 +941,7 @@ static int wdm_probe(struct usb_interface *intf, const struct usb_device_id *id)
  * @ep: interrupt endpoint to monitor for notifications
  * @bufsize: maximum message size to support for read/write
  * @manage_power: call-back invoked during open and release to
- *                manage the device's power 
+ *                manage the device's power
  * Create WDM usb class character device and associate it with intf
  * without binding, allowing another driver to manage the interface.
  *
-- 
2.25.1

