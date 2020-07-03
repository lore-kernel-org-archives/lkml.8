Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39445C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 17:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1ED8320C56
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 17:42:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oiU0dmtO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgGCRmQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 13:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbgGCRmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 13:42:11 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7310BC08C5DD
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 10:42:11 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id 17so34829821wmo.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 10:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xjIIWeYNclz40pA7bk2Qh3oqQG2tAVOyN4aYQkn6OiY=;
        b=oiU0dmtOVMkBf6TzSeh/ny3md+5yRm4OM/IM4zkiiOFwgo/Qi47cQKLIay8N30COvv
         nFCgi9+MuTJUdQoM+EYjFAVSSXHFDahthwfrL2L0uG8tX9INuhlJ7/cmRhrmdxrLtuFz
         oJKhV9g+/B0+eQoFWwl2PcOTlD1idbOo5vbWQavXnyYORLwCMEqSIw3W8buDHcalnHaF
         MERyReX3fR+NEYYYVX4PHBzMSPy0uiKfTR+qpcIAq0s5oyM5UQiVkJVZ3hVqKAq+kN3d
         XFrtBQe2kaUyEK2PovU4zqVElnVtkGu+bfCfgt47nCsd0sAKqBjbKOLLmRrOqVDszAd0
         jxjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xjIIWeYNclz40pA7bk2Qh3oqQG2tAVOyN4aYQkn6OiY=;
        b=dv0hZozidwNGmXyV9M8OilbSb27jcNRwITYlsM4KdWXCy6ibwA2qFkTFTHIoxUFaCY
         uFmUlN8zYzfB2dM1uM9YbJPGneAQwJ+LvxAztmZFqc7MTgMazx1KsP+wfQ4LE/yLNge3
         DTFRliBsPXk61H09rKw1G8L6sFp36PptYleS3KuhNhaZgM3B3Yoq0JWsW4Gl2nJn4js+
         8NsBiAXOOvQgis7mEz8zIpfi3lTop92NoWrPO4ECTLhRqpV5KmNiTB6F6mxNgyPvef7d
         GD4Sj0JvgI0Gn+/AvWqdGY8D4jMlHsrav/DH6dz8N3Z10lNwMurV48E2qUWYJd0wm770
         W6dA==
X-Gm-Message-State: AOAM533+wMeAqNnrcFtt32+JL2eRsW5C/c/t27l4FIVbUmg4AHO9RTi9
        SvGa5S9eeDmG/3+vouG2rOSpBw==
X-Google-Smtp-Source: ABdhPJw4mjZPthdniRStWHtZC5npFeRT01E/oMZEzrllITbRXHeQCaCUndaY9yDxanGEL4ylb/oaYg==
X-Received: by 2002:a7b:c14a:: with SMTP id z10mr36486119wmi.19.1593798130185;
        Fri, 03 Jul 2020 10:42:10 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id x11sm13625799wmc.26.2020.07.03.10.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 10:42:09 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Felipe Balbi <balbi@kernel.org>
Subject: [PATCH 08/30] usb: gadget: udc: core: Fix a bunch of kerneldoc misdemeanours
Date:   Fri,  3 Jul 2020 18:41:26 +0100
Message-Id: <20200703174148.2749969-9-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200703174148.2749969-1-lee.jones@linaro.org>
References: <20200703174148.2749969-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Firstly, file headers should not be in kerneldoc format.  Function
args should be in the format '@.*: '.  We also take the time to
add some descriptions for various argument which have been
previously left out.  Finally we remove descriptions for absent
arguments.

Fixes the following W=1 kernel build warning(s):

 drivers/usb/gadget/udc/core.c:25: warning: Incorrect use of kernel-doc format:  * struct usb_udc - describes one usb device controller
 drivers/usb/gadget/udc/core.c:36: warning: cannot understand function prototype: 'struct usb_udc '
 drivers/usb/gadget/udc/core.c:901: warning: Function parameter or member 'ep' not described in 'usb_gadget_giveback_request'
 drivers/usb/gadget/udc/core.c:901: warning: Function parameter or member 'req' not described in 'usb_gadget_giveback_request'
 drivers/usb/gadget/udc/core.c:1098: warning: Function parameter or member 'udc' not described in 'usb_gadget_udc_stop'
 drivers/usb/gadget/udc/core.c:1098: warning: Excess function parameter 'gadget' description in 'usb_gadget_udc_stop'
 drivers/usb/gadget/udc/core.c:1098: warning: Excess function parameter 'driver' description in 'usb_gadget_udc_stop'

Cc: Felipe Balbi <balbi@kernel.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/usb/gadget/udc/core.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
index 2e28dde8376f6..16790c02a530c 100644
--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/**
+/*
  * udc.c - Core UDC Framework
  *
  * Copyright (C) 2010 Texas Instruments
@@ -23,11 +23,11 @@
 
 /**
  * struct usb_udc - describes one usb device controller
- * @driver - the gadget driver pointer. For use by the class code
- * @dev - the child device to the actual controller
- * @gadget - the gadget. For use by the class code
- * @list - for use by the udc class driver
- * @vbus - for udcs who care about vbus status, this value is real vbus status;
+ * @driver: the gadget driver pointer. For use by the class code
+ * @dev: the child device to the actual controller
+ * @gadget: the gadget. For use by the class code
+ * @list: for use by the udc class driver
+ * @vbus: for udcs who care about vbus status, this value is real vbus status;
  * for udcs who do not care about vbus status, this value is always true
  *
  * This represents the internal data structure which is used by the UDC-class
@@ -891,6 +891,9 @@ EXPORT_SYMBOL_GPL(usb_gadget_unmap_request);
 
 /**
  * usb_gadget_giveback_request - give the request back to the gadget layer
+ * @ep: the endpoint to be used with with the request
+ * @req: the request being given back
+ *
  * Context: in_interrupt()
  *
  * This is called by device controller drivers in order to return the
@@ -1084,8 +1087,7 @@ static inline int usb_gadget_udc_start(struct usb_udc *udc)
 
 /**
  * usb_gadget_udc_stop - tells usb device controller we don't need it anymore
- * @gadget: The device we want to stop activity
- * @driver: The driver to unbind from @gadget
+ * @udc: The UDC to be stopped
  *
  * This call is issued by the UDC Class driver after calling
  * gadget driver's unbind() method.
-- 
2.25.1

