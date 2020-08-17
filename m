Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61732C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 09:03:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32C072063A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 09:03:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tFFetna8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728688AbgHQJDF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 05:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728574AbgHQJCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 05:02:49 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D08C061389;
        Mon, 17 Aug 2020 02:02:49 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id mt12so7496612pjb.4;
        Mon, 17 Aug 2020 02:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fyyx5l8JBWdsh/vzK9XkI9lqTabxVOq8Vrtc0Hw0vUw=;
        b=tFFetna8jRJGMqAQA4gg5CD4aJnfg7vJVX2XDgITV0TAHrZGa3EqUKCj9X6roVS5ua
         z/bDFWyUaKt5hZ8eLbEPXauBjLbr7vULyfh2HFpNOrOrHKQspo1GpKhj2CVYSiqlOz5C
         E1Ty/AgVyY+Jwc7oa/2GIpXxmmuWnm7GKDqOIB5MhOztkcPbFfDxayheFXZrohbg62XB
         3YGfCksc/u4epg7xhLM7TDqpQ+iPBG9DZ1GKR8YPry+Cy6xxc3eNwJo8i/lrFtKiW6jo
         cGlkep4oOA/E6A9HY5up7IdKcLTpd0CCE6MyIWeYwwaubVPlmp8tlZkmdmDxBBQDLqFu
         FnKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fyyx5l8JBWdsh/vzK9XkI9lqTabxVOq8Vrtc0Hw0vUw=;
        b=BXAMmPVCOir40gUPuEMm3xaPMSzHpjvk7YS/qHiGGQl4QPz5AerPZ6eLxDO3tvh749
         bVZoIjuP1hstUOHh6TjMfJWy1LiKGnAfB/Rl4HlRshwseh2lqj9TX6LluBil/8Lg61ha
         YLLJ+OIr6a/onDQ0VdXCycJ18f7hPXciruko3ImJwJ/H3L86uBLM7Ec1QfOIej+u1Rd2
         +1Ikf7lF1hUEcuHCRwiGOhKRtyHnbQeTYe+WqR3j2U1ca0j66ZCZSd/rZHgng5klofDJ
         R1S09bS/4PGOs/UltP8dwYzv0jrsMa53d6EBoRUFiz+wqYU/ZrwpEWTJNbb0ciRdt3lt
         v/Ug==
X-Gm-Message-State: AOAM5323KMiw/FiKY9bteKoYUZeKi+dRqlG2FQ+jhikfATtJ9r70g56F
        XT0NVBvJnAp9K2GGlP1mzW4=
X-Google-Smtp-Source: ABdhPJzhCkInkV1nfo/rOzX+w0Rb6oz49Qjtqes/TFI+PpxRKs02Pp4T3OSKhx5YtGjO6CHHY4rWlA==
X-Received: by 2002:a17:902:d715:: with SMTP id w21mr10488997ply.197.1597654968699;
        Mon, 17 Aug 2020 02:02:48 -0700 (PDT)
Received: from localhost.localdomain ([49.207.202.98])
        by smtp.gmail.com with ESMTPSA id f3sm19488238pfj.206.2020.08.17.02.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 02:02:48 -0700 (PDT)
From:   Allen Pais <allen.cryptic@gmail.com>
To:     duncan.sands@free.fr, gregkh@linuxfoundation.org,
        jacmet@sunsite.dk, balbi@kernel.org, leoyang.li@nxp.com,
        johan@kernel.org
Cc:     keescook@chromium.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Allen Pais <allen.lkml@gmail.com>,
        Romain Perier <romain.perier@gmail.com>
Subject: [PATCH 5/7] usb/gadget: fsl_qe_udc: convert tasklets to use new tasklet_setup() API
Date:   Mon, 17 Aug 2020 14:32:07 +0530
Message-Id: <20200817090209.26351-6-allen.cryptic@gmail.com>
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
 drivers/usb/gadget/udc/fsl_qe_udc.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/gadget/udc/fsl_qe_udc.c b/drivers/usb/gadget/udc/fsl_qe_udc.c
index 2707be628298..fa66449b3907 100644
--- a/drivers/usb/gadget/udc/fsl_qe_udc.c
+++ b/drivers/usb/gadget/udc/fsl_qe_udc.c
@@ -923,9 +923,9 @@ static int qe_ep_rxframe_handle(struct qe_ep *ep)
 	return 0;
 }
 
-static void ep_rx_tasklet(unsigned long data)
+static void ep_rx_tasklet(struct tasklet_struct *t)
 {
-	struct qe_udc *udc = (struct qe_udc *)data;
+	struct qe_udc *udc = from_tasklet(udc, t, rx_tasklet);
 	struct qe_ep *ep;
 	struct qe_frame *pframe;
 	struct qe_bd __iomem *bd;
@@ -2553,8 +2553,7 @@ static int qe_udc_probe(struct platform_device *ofdev)
 					DMA_TO_DEVICE);
 	}
 
-	tasklet_init(&udc->rx_tasklet, ep_rx_tasklet,
-			(unsigned long)udc);
+	tasklet_setup(&udc->rx_tasklet, ep_rx_tasklet);
 	/* request irq and disable DR  */
 	udc->usb_irq = irq_of_parse_and_map(np, 0);
 	if (!udc->usb_irq) {
-- 
2.17.1

