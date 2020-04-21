Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 545FCC54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 13:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 338DF206F4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 13:30:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GRnYtEeO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729013AbgDUNa5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 09:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728519AbgDUNay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 09:30:54 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2196EC061A10;
        Tue, 21 Apr 2020 06:30:54 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id f18so7960431lja.13;
        Tue, 21 Apr 2020 06:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bgo1WtDZJHunFa+yhy85H4AIQIVTj/8VWY76XmnbQBU=;
        b=GRnYtEeONLvvoVc1ef0Kpq0lMb32t7csIvw7Se/As/ZfXI3+JuI5czBjUat1w9qJOl
         JM0YK0TG5T8XKaKgrrvLq0nJdmh/NMaBFmb2r2QKVYFfxCzKkLF5r7Ctoa/BHOv98+eP
         7z/hWXgoRyG8Gw+SGJE21toTcCfmPgRQ5+fp4i5LiFWwG3KY9AVlqGrkp1/cLu3urmTI
         QfJM2MCmEg/fvBhupHUplzRxFH/oPcyXg2lksDQwrtW9Rn9hfWZhhj4MAcTotjuiF2JL
         tuXrvRnAA+mfm3yI5ooAsOXDLd4uiQUHc4Cbe25lVexo0k9o/fWC0+7LvPOUwxKYDqxI
         MlCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bgo1WtDZJHunFa+yhy85H4AIQIVTj/8VWY76XmnbQBU=;
        b=ijiOHaalM+GRdREPPMcGiMaeB+l8KWi/4Krjr6PcIoZA/M0prNNHhMRED8l/Xuxg/y
         XjdNCnWgd6mYQ3m7k8rRPKTus6C9fEF/LoxgJt347cOAgxiVwgI9mGnhbvtt51pq6oIt
         H/QZ9CNtaS5Z4vX6r/lAWbVSqEgHwUus29hvedJrheKKLKcwC4rjPHhaxWv3Di2lGfy7
         ImrR1ffGQwLVWrJEXaB632Ixxajv65HrLlhpQarnkbGFeE/Ic2JEphHA+hYaP+Rq+H6b
         lnghd/4Kid5wA4vVmewcYZSEaHFd+mPA86ifaPhmXmuMyDCbGnLQRlxivxH16IZ8miJg
         kt9A==
X-Gm-Message-State: AGi0PubSQ1GGK1wAGwgeR3lgoz6ENE1uBa12t6lM4vyr+YLFa1Ka8UNU
        gDQVTPP6YDx/vAzcvYZ/LEM=
X-Google-Smtp-Source: APiQypK9fSvBhTJgIjP8o0BhTuc9sNIjj/DxPG1Y8jO7V2tr1fj/yXmechc3mHCsZHHSiSouw5ajPg==
X-Received: by 2002:a05:651c:32e:: with SMTP id b14mr13252615ljp.277.1587475852459;
        Tue, 21 Apr 2020 06:30:52 -0700 (PDT)
Received: from oak.local ([188.123.231.141])
        by smtp.gmail.com with ESMTPSA id v17sm2031456lfi.49.2020.04.21.06.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 06:30:51 -0700 (PDT)
From:   matwey.kornilov@gmail.com
To:     stern@rowland.harvard.edu, Bin Liu <b-liu@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org (open list:MUSB MULTIPOINT HIGH SPEED
        DUAL-ROLE CONTROLLER), linux-kernel@vger.kernel.org (open list)
Cc:     "Matwey V. Kornilov" <matwey@sai.msu.ru>,
        linux-usb@vger.kernel.org (open list:MUSB MULTIPOINT HIGH SPEED
        DUAL-ROLE CONTROLLER), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 2/6] usb: musb: Introduce musb_qh_empty() helper function
Date:   Tue, 21 Apr 2020 16:30:15 +0300
Message-Id: <20200421133019.27167-3-matwey.kornilov@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200421133019.27167-1-matwey.kornilov@gmail.com>
References: <20200421133019.27167-1-matwey.kornilov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matwey V. Kornilov" <matwey@sai.msu.ru>

Use musb_qh_empty() instead of &qh->hep->urb_list to avoid code
duplicating.

Signed-off-by: Matwey V. Kornilov <matwey@sai.msu.ru>
---
 drivers/usb/musb/musb_host.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
index b0614c59e0e5..af906f072cb3 100644
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -80,6 +80,11 @@ static void musb_ep_program(struct musb *musb, u8 epnum,
 			struct urb *urb, int is_out,
 			u8 *buf, u32 offset, u32 len);
 
+static bool musb_qh_empty(struct musb_qh *qh)
+{
+	return list_empty(&qh->hep->urb_list);
+}
+
 /*
  * Clear TX fifo. Needed to avoid BABBLE errors.
  */
@@ -324,7 +329,7 @@ static void musb_advance_schedule(struct musb *musb, struct urb *urb,
 	/* reclaim resources (and bandwidth) ASAP; deschedule it, and
 	 * invalidate qh as soon as list_empty(&hep->urb_list)
 	 */
-	if (list_empty(&qh->hep->urb_list)) {
+	if (musb_qh_empty(qh)) {
 		struct list_head	*head;
 		struct dma_controller	*dma = musb->dma_controller;
 
@@ -2397,7 +2402,7 @@ static int musb_urb_dequeue(struct usb_hcd *hcd, struct urb *urb, int status)
 		/* If nothing else (usually musb_giveback) is using it
 		 * and its URB list has emptied, recycle this qh.
 		 */
-		if (ready && list_empty(&qh->hep->urb_list)) {
+		if (ready && musb_qh_empty(qh)) {
 			qh->hep->hcpriv = NULL;
 			list_del(&qh->ring);
 			kfree(qh);
@@ -2442,7 +2447,7 @@ musb_h_disable(struct usb_hcd *hcd, struct usb_host_endpoint *hep)
 		/* Then nuke all the others ... and advance the
 		 * queue on hw_ep (e.g. bulk ring) when we're done.
 		 */
-		while (!list_empty(&hep->urb_list)) {
+		while (!musb_qh_empty(qh)) {
 			urb = next_urb(qh);
 			urb->status = -ESHUTDOWN;
 			musb_advance_schedule(musb, urb, qh->hw_ep, is_in);
@@ -2452,7 +2457,7 @@ musb_h_disable(struct usb_hcd *hcd, struct usb_host_endpoint *hep)
 		 * other transfers, and since !qh->is_ready nothing
 		 * will activate any of these as it advances.
 		 */
-		while (!list_empty(&hep->urb_list))
+		while (!musb_qh_empty(qh))
 			musb_giveback(musb, next_urb(qh), -ESHUTDOWN);
 
 		hep->hcpriv = NULL;
-- 
2.25.0

