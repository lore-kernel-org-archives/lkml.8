Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3C5CC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 17:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D39812088E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 17:42:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="puwTBHNe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbgGCRmi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 13:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbgGCRmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 13:42:35 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F281C08C5DF
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 10:42:34 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id l17so32762734wmj.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 10:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=friu7Jy2tbGy4d1jkwCWtPbcYZ7luQZlKvwgWbPNKHg=;
        b=puwTBHNe/kKkCwFXmN8z3mDpSXWfiQead8Enhc8NAveHB7gPPpt7FdFAXjUpGKqRzB
         5UCtk2MkA/aOAi6ZLSNSue9EVSnABo8Bar7fdGElfaNvOVIxa6hYraT6+FwH8zCkKuLD
         D0JYQtlRicpA3up3Bg/z46LJD9lLCKBo0RA6Tbe/TR1br6YxNhgJuwc7aqueQusdxSPb
         hcp50co1fGmITC2AKrpJLLcxXraOWoPk3cxehodDCbNn4rDK41bGFXvUuMBT+EXct2Wp
         72BK4A6l39lw/1nZInaeNeFhqmsZdnIxwJEvlFDnyKyU9M7PeM4E6oy811xI3BB+2b/m
         VMKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=friu7Jy2tbGy4d1jkwCWtPbcYZ7luQZlKvwgWbPNKHg=;
        b=J0U1cW7fesRXefnqdV3Yn9HP43u7CbKlfLpksthciAhI1QtS0nkWiNPJJFTsmyhbxh
         hba5IbIvucRnJ3WvVdKt9afgyS+Uo3N3plUU+A9nuGK14CLyx3cABnbyLcRlklNq1FQq
         Mm9E3lVGsKoW4q1169NFT283DBd6ee3Ro3eYxkLrQKAWg713IzPPrAmxDteMLItPDu16
         5xPchCx/GxFTD5T38VDls+4nxkMoNv9vocWMpDyplQBkEGboOL9yMilWA26REVAPC+Cb
         Gt4a7sNCT7kmdFQTDI3DiaT8HknguZM/c/N/vdASxwlgdzKBELaZvle8L+L4BrGVaUqL
         ceYw==
X-Gm-Message-State: AOAM5310X9qF/kCdZr8J618nr89ZTYnFqJJ0sjG+D2jyApLyGBkkVCak
        RjWGtq8CysGGWBfyN76ed7B9yA==
X-Google-Smtp-Source: ABdhPJzXpNP74qpR3EeiVntXOr7SPzrzUEG4ppyJ5gSdCrYd4MG9xzn0OnsJRyIkwygTnHOUwNwQtQ==
X-Received: by 2002:a1c:1d46:: with SMTP id d67mr40352418wmd.152.1593798153264;
        Fri, 03 Jul 2020 10:42:33 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id x11sm13625799wmc.26.2020.07.03.10.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 10:42:32 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Peter Chen <Peter.Chen@nxp.com>
Subject: [PATCH 12/30] usb: chipidea: udc: Help out kerneldoc headers that have tried, demote the others
Date:   Fri,  3 Jul 2020 18:41:30 +0100
Message-Id: <20200703174148.2749969-13-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200703174148.2749969-1-lee.jones@linaro.org>
References: <20200703174148.2749969-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Help with adding the odd description where they have been omitted or
where the format isn't quite right.  Demote all function headers which
are lacking any attempt of describing their arguments.

Fixes the following W=1 kernel build warning(s):

 drivers/usb/chipidea/udc.c:645: warning: Function parameter or member 'hwreq' not described in '_hardware_dequeue'
 drivers/usb/chipidea/udc.c:645: warning: Excess function parameter 'gadget' description in '_hardware_dequeue'
 drivers/usb/chipidea/udc.c:1326: warning: Function parameter or member 'ep' not described in 'ep_enable'
 drivers/usb/chipidea/udc.c:1326: warning: Function parameter or member 'desc' not described in 'ep_enable'
 drivers/usb/chipidea/udc.c:1393: warning: Function parameter or member 'ep' not described in 'ep_disable'
 drivers/usb/chipidea/udc.c:1433: warning: Function parameter or member 'ep' not described in 'ep_alloc_request'
 drivers/usb/chipidea/udc.c:1433: warning: Function parameter or member 'gfp_flags' not described in 'ep_alloc_request'
 drivers/usb/chipidea/udc.c:1454: warning: Function parameter or member 'ep' not described in 'ep_free_request'
 drivers/usb/chipidea/udc.c:1454: warning: Function parameter or member 'req' not described in 'ep_free_request'
 drivers/usb/chipidea/udc.c:1488: warning: Function parameter or member 'ep' not described in 'ep_queue'
 drivers/usb/chipidea/udc.c:1488: warning: Function parameter or member 'req' not described in 'ep_queue'
 drivers/usb/chipidea/udc.c:1488: warning: Function parameter or member 'gfp_flags' not described in 'ep_queue'
 drivers/usb/chipidea/udc.c:1512: warning: Function parameter or member 'ep' not described in 'ep_dequeue'
 drivers/usb/chipidea/udc.c:1512: warning: Function parameter or member 'req' not described in 'ep_dequeue'
 drivers/usb/chipidea/udc.c:1556: warning: Function parameter or member 'ep' not described in 'ep_set_halt'
 drivers/usb/chipidea/udc.c:1556: warning: Function parameter or member 'value' not described in 'ep_set_halt'
 drivers/usb/chipidea/udc.c:1566: warning: Function parameter or member 'ep' not described in 'ep_set_wedge'
 drivers/usb/chipidea/udc.c:1586: warning: Function parameter or member 'ep' not described in 'ep_fifo_flush'
 drivers/usb/chipidea/udc.c:1610: warning: cannot understand function prototype: 'const struct usb_ep_ops usb_ep_ops = '
 drivers/usb/chipidea/udc.c:1629: warning: Function parameter or member '_gadget' not described in 'ci_hdrc_gadget_connect'
 drivers/usb/chipidea/udc.c:1629: warning: Function parameter or member 'is_active' not described in 'ci_hdrc_gadget_connect'
 drivers/usb/chipidea/udc.c:1780: warning: cannot understand function prototype: 'const struct usb_gadget_ops usb_gadget_ops = '
 drivers/usb/chipidea/udc.c:1931: warning: Function parameter or member 'gadget' not described in 'ci_udc_stop'
 drivers/usb/chipidea/udc.c:1965: warning: Function parameter or member 'ci' not described in 'udc_irq'
 drivers/usb/chipidea/udc.c:2095: warning: Function parameter or member 'ci' not described in 'ci_hdrc_gadget_destroy'
 drivers/usb/chipidea/udc.c:2144: warning: Function parameter or member 'ci' not described in 'ci_hdrc_gadget_init'

Cc: Peter Chen <Peter.Chen@nxp.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/usb/chipidea/udc.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/usb/chipidea/udc.c b/drivers/usb/chipidea/udc.c
index c42b98c84f2f1..0dfbc31843fc8 100644
--- a/drivers/usb/chipidea/udc.c
+++ b/drivers/usb/chipidea/udc.c
@@ -647,7 +647,7 @@ static int reprime_dtd(struct ci_hdrc *ci, struct ci_hw_ep *hwep,
 /**
  * _hardware_dequeue: handles a request at hardware level
  * @gadget: gadget
- * @hwep:   endpoint
+ * @hwreq:  request
  *
  * This function returns an error code
  */
@@ -1326,7 +1326,7 @@ __acquires(ci->lock)
 /******************************************************************************
  * ENDPT block
  *****************************************************************************/
-/**
+/*
  * ep_enable: configure endpoint, making it usable
  *
  * Check usb_ep_enable() at "usb_gadget.h" for details
@@ -1394,7 +1394,7 @@ static int ep_enable(struct usb_ep *ep,
 	return retval;
 }
 
-/**
+/*
  * ep_disable: endpoint is no longer usable
  *
  * Check usb_ep_disable() at "usb_gadget.h" for details
@@ -1434,7 +1434,7 @@ static int ep_disable(struct usb_ep *ep)
 	return retval;
 }
 
-/**
+/*
  * ep_alloc_request: allocate a request object to use with this endpoint
  *
  * Check usb_ep_alloc_request() at "usb_gadget.h" for details
@@ -1455,7 +1455,7 @@ static struct usb_request *ep_alloc_request(struct usb_ep *ep, gfp_t gfp_flags)
 	return (hwreq == NULL) ? NULL : &hwreq->req;
 }
 
-/**
+/*
  * ep_free_request: frees a request object
  *
  * Check usb_ep_free_request() at "usb_gadget.h" for details
@@ -1488,7 +1488,7 @@ static void ep_free_request(struct usb_ep *ep, struct usb_request *req)
 	spin_unlock_irqrestore(hwep->lock, flags);
 }
 
-/**
+/*
  * ep_queue: queues (submits) an I/O request to an endpoint
  *
  * Check usb_ep_queue()* at usb_gadget.h" for details
@@ -1513,7 +1513,7 @@ static int ep_queue(struct usb_ep *ep, struct usb_request *req,
 	return retval;
 }
 
-/**
+/*
  * ep_dequeue: dequeues (cancels, unlinks) an I/O request from an endpoint
  *
  * Check usb_ep_dequeue() at "usb_gadget.h" for details
@@ -1557,7 +1557,7 @@ static int ep_dequeue(struct usb_ep *ep, struct usb_request *req)
 	return 0;
 }
 
-/**
+/*
  * ep_set_halt: sets the endpoint halt feature
  *
  * Check usb_ep_set_halt() at "usb_gadget.h" for details
@@ -1567,7 +1567,7 @@ static int ep_set_halt(struct usb_ep *ep, int value)
 	return _ep_set_halt(ep, value, true);
 }
 
-/**
+/*
  * ep_set_wedge: sets the halt feature and ignores clear requests
  *
  * Check usb_ep_set_wedge() at "usb_gadget.h" for details
@@ -1587,7 +1587,7 @@ static int ep_set_wedge(struct usb_ep *ep)
 	return usb_ep_set_halt(ep);
 }
 
-/**
+/*
  * ep_fifo_flush: flushes contents of a fifo
  *
  * Check usb_ep_fifo_flush() at "usb_gadget.h" for details
@@ -1613,7 +1613,7 @@ static void ep_fifo_flush(struct usb_ep *ep)
 	spin_unlock_irqrestore(hwep->lock, flags);
 }
 
-/**
+/*
  * Endpoint-specific part of the API to the USB controller hardware
  * Check "usb_gadget.h" for details
  */
@@ -1632,7 +1632,7 @@ static const struct usb_ep_ops usb_ep_ops = {
 /******************************************************************************
  * GADGET block
  *****************************************************************************/
-/**
+/*
  * ci_hdrc_gadget_connect: caller makes sure gadget driver is binded
  */
 static void ci_hdrc_gadget_connect(struct usb_gadget *_gadget, int is_active)
@@ -1782,7 +1782,7 @@ static struct usb_ep *ci_udc_match_ep(struct usb_gadget *gadget,
 	return NULL;
 }
 
-/**
+/*
  * Device operations part of the API to the USB controller hardware,
  * which don't involve endpoints (or i/o)
  * Check  "usb_gadget.h" for details
@@ -1934,7 +1934,7 @@ static void ci_udc_stop_for_otg_fsm(struct ci_hdrc *ci)
 	mutex_unlock(&ci->fsm.lock);
 }
 
-/**
+/*
  * ci_udc_stop: unregister a gadget driver
  */
 static int ci_udc_stop(struct usb_gadget *gadget)
@@ -1965,7 +1965,7 @@ static int ci_udc_stop(struct usb_gadget *gadget)
 /******************************************************************************
  * BUS block
  *****************************************************************************/
-/**
+/*
  * udc_irq: ci interrupt handler
  *
  * This function returns IRQ_HANDLED if the IRQ has been handled
@@ -2096,7 +2096,7 @@ static int udc_start(struct ci_hdrc *ci)
 	return retval;
 }
 
-/**
+/*
  * ci_hdrc_gadget_destroy: parent remove must call this to remove UDC
  *
  * No interrupts active, the IRQ has been released
@@ -2146,7 +2146,7 @@ static void udc_id_switch_for_host(struct ci_hdrc *ci)
 
 /**
  * ci_hdrc_gadget_init - initialize device related bits
- * ci: the controller
+ * @ci: the controller
  *
  * This function initializes the gadget, if the device is "device capable".
  */
-- 
2.25.1

