Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB39CC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 15:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B15D32074D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 15:23:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UPZAHY3a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbgHXPX0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 11:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727943AbgHXPWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 11:22:07 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19633C061573
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 08:22:07 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id x5so8746167wmi.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 08:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=41TxyHICC+s6aQeo0YedfhOUY4gGQOiE3/gzLfTmhK8=;
        b=UPZAHY3aoz5wOk5QeAlrKi4lHHftgu9RkgR4o5Ya9tKmdXZ5uBTVvic6ApMuVDqhyB
         XR68EpCvZpY4FuaAZxe9b83xADELgF314JDi4j9vwEaC9F7Aztuff0iAx3Hk8HOmVG1q
         4F5/cr83HCraOS/Zj/RsLDTYZ5R137s/z7gAXSeuyMD7PZc/tHHAywxp0Ze6/J+tv78S
         gvw0ZaXBMg3urwDUFTmw7oawTx/teDC7UYe9e0O+lWAhKF4Luf/UYk9lMUv7AeqEyrR0
         KU8/yMYTs+s89yq1xx0RhHJ1c1g+ORsrPhq/BltLM1EOAyK5See4M7vf8kJZrJHyhW1U
         rD9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=41TxyHICC+s6aQeo0YedfhOUY4gGQOiE3/gzLfTmhK8=;
        b=lIXCXv13BnjbDInh/uIFp65CmBh+VjQXn8UMCgL7mH8CnTTgN8S6GheJkFcKK/8fyT
         vOPrK66Oh5j6/jEVhaAdHuyEVpJi5TH4u/bgVVNNYZc/JOxYDurkXRJgPy+m+x6i9oXa
         KMAVBE/K5NS03Rub05Tjn2XLOLWPu8h2F9uJNuYV0w7+x9PHTdc7Mymhku+ly4ZKs3YE
         HvaugQTMjNvrTv4pt6BG2D+V1e/13zfi76idHMW7XNyTWiWft71oyueKfDd845L/y4kY
         jW5rCJvicGpDjLU0UnKPiQYGd83RwxioEW37mmpbj4vX8Mv6mKvSbxCdqUY4PyjOzy0H
         VLKQ==
X-Gm-Message-State: AOAM533tVBtQEdX8cApWiOU0bmSbEYeFwlpPysIqkK00ofGeBGsOQLpD
        4YM1pdCehdMRA07vRC4kvQWoH9pbSfGeGn2r
X-Google-Smtp-Source: ABdhPJwaPewrMNTaq5Qrv5GNb5FK9hQRs4NjNir76JWm9MAnYpHF5q6XegcWvQM597rRBLoVeX1WyA==
X-Received: by 2002:a7b:c8da:: with SMTP id f26mr6315877wml.126.1598282525798;
        Mon, 24 Aug 2020 08:22:05 -0700 (PDT)
Received: from localhost.localdomain (cpc83661-brig20-2-0-cust443.3-3.cable.virginm.net. [82.28.105.188])
        by smtp.gmail.com with ESMTPSA id l7sm23730928wmh.15.2020.08.24.08.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 08:22:05 -0700 (PDT)
From:   Alex Dewar <alex.dewar90@gmail.com>
To:     dan.carpenter@oracle.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alex Dewar <alex.dewar90@gmail.com>,
        "Javier F. Arias" <jarias.linux@gmail.com>,
        YueHaibing <yuehaibing@huawei.com>,
        "Frank A. Cancio Bello" <frank@generalsoftwareinc.com>,
        Saiyam Doshi <saiyamdoshi.in@gmail.com>,
        Magnus Damm <damm+renesas@opensource.se>,
        Simon Horman <horms+renesas@verge.net.au>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: emxx_udc: Fix passing of NULL to dma_alloc_coherent()
Date:   Mon, 24 Aug 2020 16:19:17 +0100
Message-Id: <20200824151920.251446-1-alex.dewar90@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824142118.GA223827@mwanda>
References: <20200824142118.GA223827@mwanda>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In nbu2ss_eq_queue() memory is allocated with dma_alloc_coherent(),
though, strangely, NULL is passed as the struct device* argument. Pass
the UDC's device instead.

Build-tested on x86 only.

Fixes: 33aa8d45a4fe ("staging: emxx_udc: Add Emma Mobile USB Gadget driver")
Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>
---

So I *think* this is the right fix, but I don't have the hardware so
I've only been able to build-test it. My worry is that I could be
passing in the wrong struct device* here, which would squelch the
warning without fixing the breakage.

Can someone cleverer than me tell me if this makes sense?

- Alex
---
 drivers/staging/emxx_udc/emxx_udc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/emxx_udc/emxx_udc.c b/drivers/staging/emxx_udc/emxx_udc.c
index 03929b9d3a8b..09e91449c08c 100644
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
-- 
2.28.0

