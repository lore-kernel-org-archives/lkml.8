Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED9EC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 09:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 084CE2068F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 09:19:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WOfTQDCk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbgHYJTg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 05:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbgHYJTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 05:19:35 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F127CC061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 02:19:34 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id f7so11997282wrw.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 02:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0ERb1UGJKdJwjiGp+CEUiQ78DEvQjOblZZuZAofFpZg=;
        b=WOfTQDCkQTW+xXen4ZdsYcGvw0ZWjuT0pyUcCIgkwIHz/NwtflUvcZpwN4Ax2fLZMO
         RETL/s4sbj0RKdUHhfuUBC7iPEUK7ikaLfWaE7P8DqB4uGErqgXv8SaM3RSty6aKLUOb
         SXEfTLTTf6WAQ2nVfYI9R4c/HC56eNE/vQC4YFl+m7on7JgVa9KsrsXcGyJEEtBtRv50
         rR+kRBgEVVlvnFUN5eddM5RUaVXx8ReBDNDVvZHc7x2CHxT2sJEywII6is35QpW13yPh
         dre1uo3e1qzbL4LVPflF4fYpP7cwTn/qccI4HiM5vNGFdRXMR6w1s4GiN34YI88L5KyN
         4p/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0ERb1UGJKdJwjiGp+CEUiQ78DEvQjOblZZuZAofFpZg=;
        b=nv7ztu6rovTJV9Mg/eeWgoYvF96r7YuUqXqXwiQvn/R0XnIieWt+JwkQxIUkNBojan
         pIFtb+hxEf2molrjI81pKnD8DS+m8zsHq9Ut95KxrKCAzpDzEddxMNepIQcRhIJfVR9n
         f+rOwRts8tIq83p/NgMO0AUpJinNeXi/93KC8WuZEMSW7KEmV8nTjCP2BphBTREhTZQI
         DsIIrewIlSjda2cZxbY1G5ZsvBxihxE7hkOzwLa41JUvkbdzrupVNUNoRtJv/MJQ/JTS
         Qe/qdb6jFv4RwhXFCo8c/TMhwAoCeIvt/lJsYDVXo7wAPb3eDGFz7xCVdxSpNlPYqCTA
         lEaw==
X-Gm-Message-State: AOAM533wM5shoFylXjWHOGqJyH87HlF3MDeR9K7ypDA4YL76m13JetIb
        i4Nrd+f8+hBph2V9cMjAPBk=
X-Google-Smtp-Source: ABdhPJxAojHXzDH991BwUL+A3oGhvwJa39rmKGzXMDPYF/LVVbq4UeNgbt+6Ap3ApQEQ98SK828lPw==
X-Received: by 2002:adf:ee11:: with SMTP id y17mr9617948wrn.294.1598347173695;
        Tue, 25 Aug 2020 02:19:33 -0700 (PDT)
Received: from localhost.localdomain (cpc83661-brig20-2-0-cust443.3-3.cable.virginm.net. [82.28.105.188])
        by smtp.gmail.com with ESMTPSA id 202sm4964274wmb.10.2020.08.25.02.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 02:19:33 -0700 (PDT)
From:   Alex Dewar <alex.dewar90@gmail.com>
To:     dan.carpenter@oracle.com
Cc:     alex.dewar90@gmail.com, damm+renesas@opensource.se,
        devel@driverdev.osuosl.org, frank@generalsoftwareinc.com,
        gregkh@linuxfoundation.org, horms+renesas@verge.net.au,
        jarias.linux@gmail.com, linux-kernel@vger.kernel.org,
        saiyamdoshi.in@gmail.com, yuehaibing@huawei.com
Subject: [PATCH v2] staging: emxx_udc: Fix passing of NULL to dma_alloc_coherent()
Date:   Tue, 25 Aug 2020 10:19:28 +0100
Message-Id: <20200825091928.55794-1-alex.dewar90@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200825082846.GR5493@kadam>
References: <20200825082846.GR5493@kadam>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In nbu2ss_eq_queue() memory is allocated with dma_alloc_coherent(),
though, strangely, NULL is passed as the struct device* argument. Pass
the UDC's device instead. Fix up the corresponding call to
dma_free_coherent() in the same way.

Build-tested on x86 only.

Fixes: 33aa8d45a4fe ("staging: emxx_udc: Add Emma Mobile USB Gadget driver")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>
---
v2: also fix call to dma_free_coherent() (Dan)

@Magnus: I noticed you contributed this code back in 2014... I don't
suppose you happen to have the hardware lying around to test this so we
can get a Tested-by....? :)
---
 drivers/staging/emxx_udc/emxx_udc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/emxx_udc/emxx_udc.c b/drivers/staging/emxx_udc/emxx_udc.c
index 03929b9d3a8bc..d0725bc8b48a4 100644
--- a/drivers/staging/emxx_udc/emxx_udc.c
+++ b/drivers/staging/emxx_udc/emxx_udc.c
@@ -2593,7 +2593,7 @@ static int nbu2ss_ep_queue(struct usb_ep *_ep,
 
 	if (req->unaligned) {
 		if (!ep->virt_buf)
-			ep->virt_buf = dma_alloc_coherent(NULL, PAGE_SIZE,
+			ep->virt_buf = dma_alloc_coherent(udc->dev, PAGE_SIZE,
 							  &ep->phys_buf,
 							  GFP_ATOMIC | GFP_DMA);
 		if (ep->epnum > 0)  {
@@ -3148,7 +3148,7 @@ static int nbu2ss_drv_remove(struct platform_device *pdev)
 	for (i = 0; i < NUM_ENDPOINTS; i++) {
 		ep = &udc->ep[i];
 		if (ep->virt_buf)
-			dma_free_coherent(NULL, PAGE_SIZE, (void *)ep->virt_buf,
+			dma_free_coherent(udc->dev, PAGE_SIZE, (void *)ep->virt_buf,
 					  ep->phys_buf);
 	}
 
-- 
2.28.0

