Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DACDAC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 17:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B462A2084C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 17:43:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xDC8fIaK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbgGCRnM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 13:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727070AbgGCRnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 13:43:05 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF20C08C5DD
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 10:43:05 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id g75so32750154wme.5
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 10:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4V6rwO8B/5QxcmzyBtTB5IourUHauOiv8oEVPOqaOuQ=;
        b=xDC8fIaK5cyXv1Gyh3x1BMrLUIzhbFutpqYYDoz2u726Z3VIgmmNR2ruE04GGXEcAw
         aGuTq6k4zQfmgqsuNecc1AG3AGrqxgz7l8lcO+CqOTX55bno5XRVwTM5wnkCiTK1KGRo
         4cqhlQ46ZFHiMQ7ZlM2U2vJJsxIMnKQarCojzcguzEY+pM0zog//2dDTrJy+XJZjw3eX
         K638g22lJj5Iykle0Hv+fOitBoF+mba79KsRLj+046IA0MlGRNZdpvJ+EqOf1Q9WLWUB
         T7+DNb/QGE+zN8ST8O7KBKPI9lw81iVVqMhvWMk28t2EV4PdVxkGc7ie2+B/1Vwctkjf
         hMFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4V6rwO8B/5QxcmzyBtTB5IourUHauOiv8oEVPOqaOuQ=;
        b=anJEjQHtHcF8MAgfKh/f8MvpBZ5lCPEnN5Icqr5yFCj5b4PVkil1pn4JL753Wm/yvN
         C5u0usrdkPRXvmN5KXq6Biy7DWQkO5QbVZLKXT1/4x2KDjCZjnguTUd+6Ca317JaKaif
         AfDH2gNl5fVY1lkzCvfiXuEr8/73jFEMHJMCK/FVkL6BRXSSRjFO6kJYVDZUH90GWCrl
         0oep8K0IyBFt8u8zqOOLEhz94KA0PlP4aY8EgVdFBwF58YV722NiLTTd5lM41PGLGOMM
         iGCNloJfY+f05ISjnTfUtKjdB1f4tWJFn0olZRcVplOpKgOZE9YyV8zHdVpZS4/4s4nh
         wOLw==
X-Gm-Message-State: AOAM530+pNCSgKHct8NimIMbphJ87PcdRfVIn7JsekDdsMVMDbabmkc/
        4xcBYEARtKBha0W2rNr/Zmkj9Q==
X-Google-Smtp-Source: ABdhPJyWZ41PNKg/DEnuOx29cG3N8Pn3AUS9iFQCLEigdnAYIlm7v8dyg3JZ2T2lM88Cbh0PxNRO4g==
X-Received: by 2002:a05:600c:2154:: with SMTP id v20mr40914551wml.185.1593798183818;
        Fri, 03 Jul 2020 10:43:03 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id x11sm13625799wmc.26.2020.07.03.10.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 10:43:03 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH 30/30] usb: gadget: udc: dummy_hcd: Repair misspelled function argument 'dummy_hcd'
Date:   Fri,  3 Jul 2020 18:41:48 +0100
Message-Id: <20200703174148.2749969-31-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200703174148.2749969-1-lee.jones@linaro.org>
References: <20200703174148.2749969-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An attempt was made to document the functions in 'dummy_hcd',
but a simple spelling mistake was made.

Fixes the following W=1 kernel build warning(s):

 drivers/usb/gadget/udc/dummy_hcd.c:1597: warning: Function parameter or member 'dum_hcd' not described in 'handle_control_request'
 drivers/usb/gadget/udc/dummy_hcd.c:1597: warning: Excess function parameter 'dum' description in 'handle_control_request'

Cc: Felipe Balbi <balbi@kernel.org>
Cc: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/usb/gadget/udc/dummy_hcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/dummy_hcd.c b/drivers/usb/gadget/udc/dummy_hcd.c
index 0eeaead5acea3..ac3db28fd7779 100644
--- a/drivers/usb/gadget/udc/dummy_hcd.c
+++ b/drivers/usb/gadget/udc/dummy_hcd.c
@@ -1581,7 +1581,7 @@ static struct dummy_ep *find_endpoint(struct dummy *dum, u8 address)
 
 /**
  * handle_control_request() - handles all control transfers
- * @dum: pointer to dummy (the_controller)
+ * @dum_hcd: pointer to dummy (the_controller)
  * @urb: the urb request to handle
  * @setup: pointer to the setup data for a USB device control
  *	 request
-- 
2.25.1

