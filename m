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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A56C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 09:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 055A92063A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 09:02:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FyHA8htL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728600AbgHQJCv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 05:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbgHQJCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 05:02:39 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF49CC061389;
        Mon, 17 Aug 2020 02:02:39 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id h12so7799994pgm.7;
        Mon, 17 Aug 2020 02:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UYpUeS1hP1RQ+3Csy0p0MaiO+KURPCHIrOFJB/W4BNg=;
        b=FyHA8htLUZywOn857O2b3757Cv66ivSRPc9IwjTSfcapfKLmK/RelgXCNMaP5JGqBO
         i38uxESUktlsz8xJ19dO5x7CAsjIPLSKuwA7DDKokU7BwobiC/Hy55dTY2JN+Tv1DXlS
         5QSARaroOX/vXTWtoibB02nZwqnjFgBnywEZmGbdZase0SJmPcAssSaXt2USCpsaUddM
         U27muHcVhsL/ZkkJxXOUtSzG1E/o91SCNKqbtP6Z1ReiQlRrZxr7yMxHXmrCrNPf/oWy
         am/DkNreNiPdfDEjWL/BAVSqViWlaub13YdRcoFpNIuFAFp8ryxD9uEx7wFoEJChMQOm
         UGDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UYpUeS1hP1RQ+3Csy0p0MaiO+KURPCHIrOFJB/W4BNg=;
        b=gZciw+3bU03U/V168W7RENyfxt8r6zb6K8K8WwY8QCTArCcVmX8T2pcXkO9bB3Cdzt
         2gMlXzmWu/k/WgPc1xfMNnhdvfZx/lnSh0wyRVrwL6Kt7Uls0/peRuBaeqnS7MpXJnvn
         uwCixYb/zfouG+v5ZGdBV/DgDufDqXSzD/RHiByN7ZSPVxVz7PV4bpQcFxBjqb8yoc5G
         d5wZ9XyyFjMHi/AWm9KvqqXCvThm1tApv/peCimUD9Vr4nSv5GqUGOZ957dYzMnub84d
         46c3S01lpAxl/aawz4H9u4kd+MxnbwNfwVVi5jfAwZ1sC97tk0metJECNHCym5SNr08Y
         DoJA==
X-Gm-Message-State: AOAM5315P9lrB69O6fXHzAKdLyv/dA6Y9XK7zzcYHZ5OCXARalhp2aN5
        NDqJpzv1iEN/J1VJi3cFF8Q=
X-Google-Smtp-Source: ABdhPJwBt3uRtZb0Uwa2zvB/TmNBTn5F7lU3QEhTXBnLLn/CWY0XT3yl+T3g4A+fKIl3zsP4X/N1hQ==
X-Received: by 2002:a62:1c86:: with SMTP id c128mr10680948pfc.78.1597654959309;
        Mon, 17 Aug 2020 02:02:39 -0700 (PDT)
Received: from localhost.localdomain ([49.207.202.98])
        by smtp.gmail.com with ESMTPSA id f3sm19488238pfj.206.2020.08.17.02.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 02:02:38 -0700 (PDT)
From:   Allen Pais <allen.cryptic@gmail.com>
To:     duncan.sands@free.fr, gregkh@linuxfoundation.org,
        jacmet@sunsite.dk, balbi@kernel.org, leoyang.li@nxp.com,
        johan@kernel.org
Cc:     keescook@chromium.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Allen Pais <allen.lkml@gmail.com>,
        Romain Perier <romain.perier@gmail.com>
Subject: [PATCH 3/7] usb: hcd: convert tasklets to use new tasklet_setup() API
Date:   Mon, 17 Aug 2020 14:32:05 +0530
Message-Id: <20200817090209.26351-4-allen.cryptic@gmail.com>
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
 drivers/usb/core/hcd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index a33b849e8beb..2c6b9578a7d3 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -1657,9 +1657,9 @@ static void __usb_hcd_giveback_urb(struct urb *urb)
 	usb_put_urb(urb);
 }
 
-static void usb_giveback_urb_bh(unsigned long param)
+static void usb_giveback_urb_bh(struct tasklet_struct *t)
 {
-	struct giveback_urb_bh *bh = (struct giveback_urb_bh *)param;
+	struct giveback_urb_bh *bh = from_tasklet(bh, t, bh);
 	struct list_head local_list;
 
 	spin_lock_irq(&bh->lock);
@@ -2403,7 +2403,7 @@ static void init_giveback_urb_bh(struct giveback_urb_bh *bh)
 
 	spin_lock_init(&bh->lock);
 	INIT_LIST_HEAD(&bh->head);
-	tasklet_init(&bh->bh, usb_giveback_urb_bh, (unsigned long)bh);
+	tasklet_setup(&bh->bh, usb_giveback_urb_bh);
 }
 
 struct usb_hcd *__usb_create_hcd(const struct hc_driver *driver,
-- 
2.17.1

