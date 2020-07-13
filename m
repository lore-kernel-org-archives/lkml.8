Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE62DC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 07:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99646207E8
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 07:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C0PYldk8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbgGMHWx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 03:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbgGMHWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 03:22:52 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC809C061794
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 00:22:52 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id m22so5648836pgv.9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 00:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ek3hOAU51MorgAYYNSHv5t2bQW5itsnExdz3EPoDeyk=;
        b=C0PYldk8dZezqouTVrRZ018RuoGciSKR0fZ2eXkh611mLLpJ5nOc4T5aruIxONgAak
         CraIrSmID6UqWt+gurnTG8wsM27DBj8akTE8zaDFVcS1pztM5dFng8/l8iDhABrAfEWC
         X7Kq+BkSgk2Cjk1D8/sH5rb5TZzZlV/a1PQaSn+QDsMAiSLeQG+QHzqGkPPhhBGhP2VI
         f9oKz2MljC6FJ6EXo9QaHUso3cBR3qBWeMkszAuvwql90fJMVVdLlAUljfqtKhoW2r2i
         S5fHOU3supaud1SRJt0tzY++hXJR9ZuFGTFD16IXrBqxTmbJaU20LpyTzKKwr6IxRE26
         iH2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ek3hOAU51MorgAYYNSHv5t2bQW5itsnExdz3EPoDeyk=;
        b=WxHXllZ81i4pV374aacPqNkLEgKCYs7Kf0ExBh05Nxsdp5nUcPqJfwRwMXLIyJIObj
         dHmHFmFES1iOSqxLuKmpj2IKJFouduv7udB0kWgCGMKVXE1ln2pGc0D2WJ1MaZE7gImd
         Kil1IpfzME9FNVyjQSMCbFAnOiDQWjy+x3t+tZ0iMLJ7s5kSPAggz1P/il4rfubipoZb
         8aJ1ybmrjQ0Irzpf2LOjXQsAmg4dpQ2BmSYqsIaut0v1WNlUGmcMlOHWdcCA23HZaa2x
         W3cJB8uDzdHrALY+Xe5orLuvaVtzHmWtCD277MTnlOaozlcrbtz4Q0JuACaxZdg04PKO
         +xpQ==
X-Gm-Message-State: AOAM532/HuWDi7KXdIWURHeng/ucdKdIAwPAxaMHwh+ihN/dL5qcUniZ
        9RzBwsIQJdynX/sZ3gTq2TI=
X-Google-Smtp-Source: ABdhPJyPm4JwA+d74QboOp30GD9lyRMqj+MPUVgAA9tF3zwFpO1b3v+QJxTnLOtU84/23OMxInRnjw==
X-Received: by 2002:a63:5a54:: with SMTP id k20mr66661537pgm.226.1594624972273;
        Mon, 13 Jul 2020 00:22:52 -0700 (PDT)
Received: from localhost.localdomain ([103.225.58.132])
        by smtp.googlemail.com with ESMTPSA id q13sm14345074pjc.21.2020.07.13.00.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 00:22:51 -0700 (PDT)
From:   Baidyanath Kundu <kundubaidya99@gmail.com>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Baidyanath Kundu <kundubaidya99@gmail.com>
Subject: [PATCH] Staging: vc04_services: Fix code indent error
Date:   Mon, 13 Jul 2020 12:52:24 +0530
Message-Id: <20200713072224.7648-1-kundubaidya99@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the checkpatch.pl error:

ERROR: code indent should use tabs where possible

Signed-off-by: Baidyanath Kundu <kundubaidya99@gmail.com>
---
 .../staging/vc04_services/vchiq-mmal/mmal-vchiq.c  | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
index a075cd63da7f..86c00b68f099 100644
--- a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
+++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
@@ -294,13 +294,13 @@ static void buffer_to_host_work_cb(struct work_struct *work)
 	/* queue the bulk submission */
 	vchiq_use_service(instance->service_handle);
 	ret = vchiq_bulk_receive(instance->service_handle,
-				 msg_context->u.bulk.buffer->buffer,
-			         /* Actual receive needs to be a multiple
-			          * of 4 bytes
-			          */
-			         (len + 3) & ~3,
-			         msg_context,
-			         VCHIQ_BULK_MODE_CALLBACK);
+				msg_context->u.bulk.buffer->buffer,
+				/* Actual receive needs to be a multiple
+				 * of 4 bytes
+				 */
+				(len + 3) & ~3,
+				msg_context,
+				VCHIQ_BULK_MODE_CALLBACK);
 
 	vchiq_release_service(instance->service_handle);
 
-- 
2.17.1

