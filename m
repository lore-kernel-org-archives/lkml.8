Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44CBAC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 17:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C7A22084C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 17:43:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PqlMQ+89"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbgGCRnE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 13:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727046AbgGCRm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 13:42:59 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D00AC08C5E1
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 10:42:59 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id z13so33572889wrw.5
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 10:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VAH0h+7DeZ3eQjU7VALJC/mf2qMz8anOgwTIw8YZObw=;
        b=PqlMQ+89zMViNPk7JL5130tgUlbfPGYO64AK9MX0N4n06iS4TcAGsDGRMlCqj/pLc4
         J7LXAhiaUeGsjyG6alIrflqs8cE9EUzRJxrzjIgV4Yn8DOhedEbVURZIu8RG6k3K0+k1
         vDuR7IPN3O/ymZb5dVv1YzrGrTJwsbIF/ioCS5GI0RU1XrxXvWedyGPmAP4IhR/CuSjo
         itAnCnYz27iOwJdYedBW9z+9UFp06jyHOZAY5e9JzO2IDH2ldJlKr6OPo2600mUwNwY+
         +4RWwtan+5aC8XkRvuarA9Nrm5tJYS29s4fJWjGzdwrw6u2kCnRtykuQ1yQzyQOYA+Is
         hRlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VAH0h+7DeZ3eQjU7VALJC/mf2qMz8anOgwTIw8YZObw=;
        b=MGTYBwiJkv5f3wfOw3qrV3MjlFhbWKysAZ/rCOBV9EJpSk205nk9VdgjClj+0Ql3rj
         3krnSzr6ApcCL7Sicuag14Zxx7h9e8p195SVMX7XldueOljA8G48xP8ky9zaK54TSO8n
         pDqQWmp3TRXY0zhULKQzJSkTDb1kIqR8LgtPZ5xmE+YHviVku0qCm0XgUEoopsU/RrnN
         Nj4djp3tmQba1SdVgH3WbPTnXUlUQSTQQ1EZcQa2XvycrkpMOE4i5MIB1WsKalKxC0LJ
         7QWZoqG//EmWu6smm7hNfGCNkZpvJVgpxLG5rAqt7TdVs5czlBJylQXiRtRH1A5hCNdw
         KJzQ==
X-Gm-Message-State: AOAM533e10BmVJtYhKtHDSUIDR/S4RoF+KrLKjD1PDUf8G0dr5vutgLJ
        PiZTmGSK6Yf7Ktw1Du9LYKHrcw==
X-Google-Smtp-Source: ABdhPJwvENXbvIfsvJuGeCkbqKnfV/8/YK5NLdOwN0orSzzJI2mmMqY6taVoPjgC6b3Rw9Xggnm+pA==
X-Received: by 2002:a5d:6748:: with SMTP id l8mr42092231wrw.347.1593798178228;
        Fri, 03 Jul 2020 10:42:58 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id x11sm13625799wmc.26.2020.07.03.10.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 10:42:57 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Johan Hovold <johan@kernel.org>,
        Michael Hund <mhund@ld-didactic.de>,
        David Glance <advidgsf@sourceforge.net>,
        Juergen Stuber <starblue@users.sourceforge.net>
Subject: [PATCH 27/30] usb: misc: ldusb: Demote obvious misuse of kerneldoc to standard comment blocks
Date:   Fri,  3 Jul 2020 18:41:45 +0100
Message-Id: <20200703174148.2749969-28-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200703174148.2749969-1-lee.jones@linaro.org>
References: <20200703174148.2749969-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No attempt has been made to document any of the demoted functions here.

Fixes the following W=1 kernel build warning(s):

 drivers/usb/misc/ldusb.c:192: warning: Function parameter or member 'dev' not described in 'ld_usb_abort_transfers'
 drivers/usb/misc/ldusb.c:206: warning: Function parameter or member 'dev' not described in 'ld_usb_delete'
 drivers/usb/misc/ldusb.c:220: warning: Function parameter or member 'urb' not described in 'ld_usb_interrupt_in_callback'
 drivers/usb/misc/ldusb.c:281: warning: Function parameter or member 'urb' not described in 'ld_usb_interrupt_out_callback'
 drivers/usb/misc/ldusb.c:301: warning: Function parameter or member 'inode' not described in 'ld_usb_open'
 drivers/usb/misc/ldusb.c:301: warning: Function parameter or member 'file' not described in 'ld_usb_open'
 drivers/usb/misc/ldusb.c:372: warning: Function parameter or member 'inode' not described in 'ld_usb_release'
 drivers/usb/misc/ldusb.c:372: warning: Function parameter or member 'file' not described in 'ld_usb_release'
 drivers/usb/misc/ldusb.c:414: warning: Function parameter or member 'file' not described in 'ld_usb_poll'
 drivers/usb/misc/ldusb.c:414: warning: Function parameter or member 'wait' not described in 'ld_usb_poll'
 drivers/usb/misc/ldusb.c:439: warning: Function parameter or member 'file' not described in 'ld_usb_read'
 drivers/usb/misc/ldusb.c:439: warning: Function parameter or member 'buffer' not described in 'ld_usb_read'
 drivers/usb/misc/ldusb.c:439: warning: Function parameter or member 'count' not described in 'ld_usb_read'
 drivers/usb/misc/ldusb.c:439: warning: Function parameter or member 'ppos' not described in 'ld_usb_read'
 drivers/usb/misc/ldusb.c:526: warning: Function parameter or member 'file' not described in 'ld_usb_write'
 drivers/usb/misc/ldusb.c:526: warning: Function parameter or member 'buffer' not described in 'ld_usb_write'
 drivers/usb/misc/ldusb.c:526: warning: Function parameter or member 'count' not described in 'ld_usb_write'
 drivers/usb/misc/ldusb.c:526: warning: Function parameter or member 'ppos' not described in 'ld_usb_write'
 drivers/usb/misc/ldusb.c:651: warning: Function parameter or member 'intf' not described in 'ld_usb_probe'
 drivers/usb/misc/ldusb.c:651: warning: Function parameter or member 'id' not described in 'ld_usb_probe'
 drivers/usb/misc/ldusb.c:754: warning: Function parameter or member 'intf' not described in 'ld_usb_disconnect'

Cc: Johan Hovold <johan@kernel.org>
Cc: Michael Hund <mhund@ld-didactic.de>
Cc: David Glance <advidgsf@sourceforge.net>
Cc: Juergen Stuber <starblue@users.sourceforge.net>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/usb/misc/ldusb.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/misc/ldusb.c b/drivers/usb/misc/ldusb.c
index 8f86b4ebca898..670e4d91e9cae 100644
--- a/drivers/usb/misc/ldusb.c
+++ b/drivers/usb/misc/ldusb.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0+
-/**
+/*
  * Generic USB driver for report based interrupt in/out devices
  * like LD Didactic's USB devices. LD Didactic's USB devices are
  * HID devices which do not use HID report definitons (they use
@@ -184,7 +184,7 @@ struct ld_usb {
 
 static struct usb_driver ld_usb_driver;
 
-/**
+/*
  *	ld_usb_abort_transfers
  *      aborts transfers and frees associated data structures
  */
@@ -199,7 +199,7 @@ static void ld_usb_abort_transfers(struct ld_usb *dev)
 		usb_kill_urb(dev->interrupt_out_urb);
 }
 
-/**
+/*
  *	ld_usb_delete
  */
 static void ld_usb_delete(struct ld_usb *dev)
@@ -213,7 +213,7 @@ static void ld_usb_delete(struct ld_usb *dev)
 	kfree(dev);
 }
 
-/**
+/*
  *	ld_usb_interrupt_in_callback
  */
 static void ld_usb_interrupt_in_callback(struct urb *urb)
@@ -274,7 +274,7 @@ static void ld_usb_interrupt_in_callback(struct urb *urb)
 	wake_up_interruptible(&dev->read_wait);
 }
 
-/**
+/*
  *	ld_usb_interrupt_out_callback
  */
 static void ld_usb_interrupt_out_callback(struct urb *urb)
@@ -294,7 +294,7 @@ static void ld_usb_interrupt_out_callback(struct urb *urb)
 	wake_up_interruptible(&dev->write_wait);
 }
 
-/**
+/*
  *	ld_usb_open
  */
 static int ld_usb_open(struct inode *inode, struct file *file)
@@ -365,7 +365,7 @@ static int ld_usb_open(struct inode *inode, struct file *file)
 	return retval;
 }
 
-/**
+/*
  *	ld_usb_release
  */
 static int ld_usb_release(struct inode *inode, struct file *file)
@@ -407,7 +407,7 @@ static int ld_usb_release(struct inode *inode, struct file *file)
 	return retval;
 }
 
-/**
+/*
  *	ld_usb_poll
  */
 static __poll_t ld_usb_poll(struct file *file, poll_table *wait)
@@ -431,7 +431,7 @@ static __poll_t ld_usb_poll(struct file *file, poll_table *wait)
 	return mask;
 }
 
-/**
+/*
  *	ld_usb_read
  */
 static ssize_t ld_usb_read(struct file *file, char __user *buffer, size_t count,
@@ -518,7 +518,7 @@ static ssize_t ld_usb_read(struct file *file, char __user *buffer, size_t count,
 	return retval;
 }
 
-/**
+/*
  *	ld_usb_write
  */
 static ssize_t ld_usb_write(struct file *file, const char __user *buffer,
@@ -641,7 +641,7 @@ static struct usb_class_driver ld_usb_class = {
 	.minor_base =	USB_LD_MINOR_BASE,
 };
 
-/**
+/*
  *	ld_usb_probe
  *
  *	Called by the usb core when a new device is connected that it thinks
@@ -745,7 +745,7 @@ static int ld_usb_probe(struct usb_interface *intf, const struct usb_device_id *
 	return retval;
 }
 
-/**
+/*
  *	ld_usb_disconnect
  *
  *	Called by the usb core when the device is removed from the system.
-- 
2.25.1

