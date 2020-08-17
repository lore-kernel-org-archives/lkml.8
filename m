Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0632AC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 09:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEC4C207DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 09:02:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jyoKi+zL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728152AbgHQJCc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 05:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbgHQJC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 05:02:27 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15904C06138A;
        Mon, 17 Aug 2020 02:02:27 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id f193so7899654pfa.12;
        Mon, 17 Aug 2020 02:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2vTu6UftF7cQJbJWPsIkFjwuCpKR0DhP9J5zcRGrqoI=;
        b=jyoKi+zL9LSuhOPQ80fRIjLL7JLJHMk+jLLKWZWpDdCply4xhhtYwfiLo+v9Gmd2HB
         MoafH47E2/qeJ3o2/fhNpyesUHbHtqfSjtNFfI680LssZHCLaakpecGrN8t2GiXyVYKC
         U3YqdYATtpfP0z4bvmCdcmaXgeHyeh3N+B2Ry1cg1RYmTwAWLlEQUKP2f5ItyZ8Y0QKK
         MJ5ISgtHIBDE9WMLkRMfUB9u/usIIFGRwKHPqdpsRqbCg70JlN7uj5wcW1vruY98BiKD
         POnKmfAz4wNjunOokWZ/ePwWAZgvXkfvv40q2M2wXRYwrnj+kDNIzuB7thZaxu1p0Kz8
         LSqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2vTu6UftF7cQJbJWPsIkFjwuCpKR0DhP9J5zcRGrqoI=;
        b=kK2OG8YtlFlqVrPsR9v1KK+RY8TKXDOYNaGXRbsJDaF2J1U82qjKqq0olVmvAWJGuJ
         qAXL7xL6kJR64GPQMDlp7I9L80w8EQafguScXF1in7+OYYkSW6V/8gLax3NRoL1a1FKi
         E+dletdi8A+pZBSFoxM4REC97/sWDQOP5a+ZcqyrONckcZ+v/oscDuNpTnOZ8C6dJc4e
         7I8yOqVm1cLLnoxCfMz2YvJj8b0W/gPCHW9UepwpSDvZx831OH8K875IYruOittse2hZ
         VxwaWHt9l17TaEHdcB4cvPtmwRyHz78pIhE25zDIB3sAwIWt2ngxXkfEQ9wkF3SP5vAS
         3wiA==
X-Gm-Message-State: AOAM531ocEjI7YwzUEDgmJd1lqsTjdqiBfxDbRUFNjWeoccdKbyR/F/Z
        iGPUapcx2pM4VO3zAbmRTXE=
X-Google-Smtp-Source: ABdhPJw+NUVlFHmHuq0xLyJ9Qs3O4JjM2hTVZcFUlYoIH6k59c4k+FO8V6iZ+byK1cCoIzwPNcFOEg==
X-Received: by 2002:a62:8141:: with SMTP id t62mr10236273pfd.282.1597654946593;
        Mon, 17 Aug 2020 02:02:26 -0700 (PDT)
Received: from localhost.localdomain ([49.207.202.98])
        by smtp.gmail.com with ESMTPSA id f3sm19488238pfj.206.2020.08.17.02.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 02:02:26 -0700 (PDT)
From:   Allen Pais <allen.cryptic@gmail.com>
To:     duncan.sands@free.fr, gregkh@linuxfoundation.org,
        jacmet@sunsite.dk, balbi@kernel.org, leoyang.li@nxp.com,
        johan@kernel.org
Cc:     keescook@chromium.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Allen Pais <allen.lkml@gmail.com>,
        Romain Perier <romain.perier@gmail.com>
Subject: [PATCH 1/7] usb: atm: convert tasklets to use new tasklet_setup() API
Date:   Mon, 17 Aug 2020 14:32:03 +0530
Message-Id: <20200817090209.26351-2-allen.cryptic@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200817090209.26351-1-allen.cryptic@gmail.com>
References: <20200817090209.26351-1-allen.cryptic@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Allen Pais <allen.lkml@gmail.com>

In preparation for unconditionally passing the
struct tasklet_struct pointer to all tasklet
callbacks, switch to using the new tasklet_setup()
and from_tasklet() to pass the tasklet pointer explicitly.

Signed-off-by: Romain Perier <romain.perier@gmail.com>
Signed-off-by: Allen Pais <allen.lkml@gmail.com>
---
 drivers/usb/atm/usbatm.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/atm/usbatm.c b/drivers/usb/atm/usbatm.c
index 4e12a32ca392..56fe30d247da 100644
--- a/drivers/usb/atm/usbatm.c
+++ b/drivers/usb/atm/usbatm.c
@@ -511,9 +511,10 @@ static unsigned int usbatm_write_cells(struct usbatm_data *instance,
 **  receive  **
 **************/
 
-static void usbatm_rx_process(unsigned long data)
+static void usbatm_rx_process(struct tasklet_struct *t)
 {
-	struct usbatm_data *instance = (struct usbatm_data *)data;
+	struct usbatm_data *instance = from_tasklet(instance, t,
+						    rx_channel.tasklet);
 	struct urb *urb;
 
 	while ((urb = usbatm_pop_urb(&instance->rx_channel))) {
@@ -564,9 +565,10 @@ static void usbatm_rx_process(unsigned long data)
 **  send  **
 ***********/
 
-static void usbatm_tx_process(unsigned long data)
+static void usbatm_tx_process(struct tasklet_struct *t)
 {
-	struct usbatm_data *instance = (struct usbatm_data *)data;
+	struct usbatm_data *instance = from_tasklet(instance, t,
+						    tx_channel.tasklet);
 	struct sk_buff *skb = instance->current_skb;
 	struct urb *urb = NULL;
 	const unsigned int buf_size = instance->tx_channel.buf_size;
@@ -1069,8 +1071,8 @@ int usbatm_usb_probe(struct usb_interface *intf, const struct usb_device_id *id,
 
 	usbatm_init_channel(&instance->rx_channel);
 	usbatm_init_channel(&instance->tx_channel);
-	tasklet_init(&instance->rx_channel.tasklet, usbatm_rx_process, (unsigned long)instance);
-	tasklet_init(&instance->tx_channel.tasklet, usbatm_tx_process, (unsigned long)instance);
+	tasklet_setup(&instance->rx_channel.tasklet, usbatm_rx_process);
+	tasklet_setup(&instance->tx_channel.tasklet, usbatm_tx_process);
 	instance->rx_channel.stride = ATM_CELL_SIZE + driver->rx_padding;
 	instance->tx_channel.stride = ATM_CELL_SIZE + driver->tx_padding;
 	instance->rx_channel.usbatm = instance->tx_channel.usbatm = instance;
-- 
2.17.1

