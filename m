Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29CDDC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 17:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09DBE20899
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 17:43:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e0AkldCM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbgGCRnQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 13:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727062AbgGCRnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 13:43:03 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B924C08C5DD
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 10:43:03 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id 22so32763389wmg.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 10:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8mQF2FZ0jrrVdFBW6SrV/K5PDC372enpc401EmGJ4RU=;
        b=e0AkldCMprpPWh+rbnVgZVxtLG2y6OltUwnk8439ZxDnC/6jYt0uqjTtRQx/Zfn+tZ
         nZwYhZtVgJfVHRbI+zDxMYK30uzPBABrlnWYCO5TBFx8Ja+jSCZxw+jYI87lsm2y3xy9
         QxNGqinBdVqBcWPtpWsTduPgpEaxe4O9LOEpO7wvmc9DsueDiifOLfghcb/KulrhUqxf
         wqW3D4u1FpOkgd+198fconKRrhY2PlpFbZ7tRgjc+8sbucSyMdhhLxMddDMHSRsTiSrH
         pW1rKrPD0pEqCqMth1P2WdyD9ox3TMqkEkXTBSCnyAtV9BTy92b2xKgq3yRK+wVYMwCQ
         inCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8mQF2FZ0jrrVdFBW6SrV/K5PDC372enpc401EmGJ4RU=;
        b=elhN/zg5ddsG7b0rCozG0SdAKdprfrMijkDQpKzvC0JIIl/XrHog9f6jSvMAzv7jQB
         AxiIkJylOvmUujaQDTBNBDcpRK1FbrZqtujQvbtiYmMD9/FZUu/P5MEaiKuNwGL9hAL6
         edeBeiUe9c930LpI1hzNuOmeq6odBA1UwWbzoXEgpMjHu4Hfx919Fm/DHUXS1kflzzhr
         fkHgE4N7N11LsWQLIsmbNK5HJi0jJrqYLHXRHRL4iWvEkLWtgL8j+1OFCbTxPVkjTxAR
         2AfAaUXNUCujPH/8+2Ui/ehhwITsJcQklWGj8GuRaUfrc1q+eAnFJBjYzmOCFizjueRd
         C4Kg==
X-Gm-Message-State: AOAM532+51b2NF0CNwR8AMhK4Jp4DuIH8g4pQPjANbMXstQugLrzvtdU
        A3EveyQieQzj0btI6xyUbMKOpw==
X-Google-Smtp-Source: ABdhPJymDh7yO/0xPFzXc6z8/96jHurwQBojFV24c+PsUXFn1Um5Euz/ljx89ZFYhzbITSni3XCkHw==
X-Received: by 2002:a1c:f007:: with SMTP id a7mr37726297wmb.103.1593798181776;
        Fri, 03 Jul 2020 10:43:01 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id x11sm13625799wmc.26.2020.07.03.10.43.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 10:43:01 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Felipe Balbi <balbi@kernel.org>
Subject: [PATCH 29/30] usb: gadget: usbstring: Repair misspelled function argument 'langid'
Date:   Fri,  3 Jul 2020 18:41:47 +0100
Message-Id: <20200703174148.2749969-30-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200703174148.2749969-1-lee.jones@linaro.org>
References: <20200703174148.2749969-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An attempt was made to document the functions in 'usbstring',
but a simple spelling mistake was made.

Fixes the following W=1 kernel build warning(s):

 drivers/usb/gadget/usbstring.c:76: warning: Function parameter or member 'langid' not described in 'usb_validate_langid'
 drivers/usb/gadget/usbstring.c:76: warning: Excess function parameter 'lang' description in 'usb_validate_langid'

Cc: Felipe Balbi <balbi@kernel.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/usb/gadget/usbstring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/usbstring.c b/drivers/usb/gadget/usbstring.c
index 58a4d33250902..119505fac7776 100644
--- a/drivers/usb/gadget/usbstring.c
+++ b/drivers/usb/gadget/usbstring.c
@@ -68,7 +68,7 @@ EXPORT_SYMBOL_GPL(usb_gadget_get_string);
 
 /**
  * usb_validate_langid - validate usb language identifiers
- * @lang: usb language identifier
+ * @langid: usb language identifier
  *
  * Returns true for valid language identifier, otherwise false.
  */
-- 
2.25.1

