Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD9BC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 15:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BCEA2076D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 15:24:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eYVdCt+P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728041AbgGQPYH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 11:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbgGQPXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 11:23:50 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00354C0619D2;
        Fri, 17 Jul 2020 08:23:49 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id o8so15432591wmh.4;
        Fri, 17 Jul 2020 08:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=a7K03vVeTa1oCvndzLpmXZwhlsqxNxhP4bPgxia/KT4=;
        b=eYVdCt+Pt48MD+NU6mravMS4KDlqviK9wTQ3ETXMK18usj5XrG2HcmZ2LcrYx5PVEi
         58VTnllnEEK6UYyHlvhjN9kZ+m2dIcBg+lmdLgZ0Yp0Akm2RUSue9IdUyJ5oqn4+12Sq
         34FqR8/t3qPh79ggPqUOi4PZshFFvJEBxuvvOkXJ1upHsi3tgDoM88Jj18J+ZLy0gRsI
         TFADFyjLLdL0vasv5frRQqYy+9HmpYVsUF5oZnOcyHCn3JeXQy6DduD6uf7JEAhT9w+q
         GrjA4uQ4PXRO8RhZeVQEd7SGfstqJGxgAdoqoU2tnSD8B19LqffutZS8IwbQ5F1IsHUL
         enmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=a7K03vVeTa1oCvndzLpmXZwhlsqxNxhP4bPgxia/KT4=;
        b=I5JyMjzkY9vLM67qeTLtOyp3FJ6+NnsWLISNnKT1uMKLPYHLbs3KngrOH8CNLcb9cl
         Bo8G3sT+hmYZ9a7xN/ZxyIVYUz6/7UA5X6Bxo5fuH6vOc3IldXlXuVNZzsf81oE8k0Lh
         aL/4ytya9Ctto3cK4Sm6G/Ig7/N+PYY27M8KshE2d2OkmsrgNNiTgkai8wT0hNZT4ki0
         ORyu5IUedDPM/+TszOTngZ3PksWjfzTCcnvUhztdDPX3MqxvGCFpSXRIF1QfyW+bpd0y
         W+syVhyhTtbi7wV+TqyM7bqbQFTUSrXo9Eq6DcpYm6tc0MA3Dmodegcv1lPfYrbsx7n9
         cGsg==
X-Gm-Message-State: AOAM533ZxU0F6gHy0wY2jgzEIzHnF79lPoNx7ot9AWUYs984oKrqc7mV
        E7i7sxA/AXrjZzZaHGQQnBbe7s8i
X-Google-Smtp-Source: ABdhPJyz1LpyHbmPrKI/E0YSuYzpNJhQmGtkqM+7O1/Qa4e7Z4xZiIOl8fNgybShuzgI4gu874NxvA==
X-Received: by 2002:a1c:4804:: with SMTP id v4mr9828885wma.139.1594999428301;
        Fri, 17 Jul 2020 08:23:48 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id a22sm13431051wmb.4.2020.07.17.08.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 08:23:47 -0700 (PDT)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>, devicetree@vger.kernel.org,
        Felipe Balbi <balbi@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Sasi Kumar <sasi.kumar@broadcom.com>
Subject: [PATCH 4/7] usb: bdc: Adb shows offline after resuming from S2
Date:   Fri, 17 Jul 2020 11:23:04 -0400
Message-Id: <20200717152307.36705-5-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200717152307.36705-1-alcooperx@gmail.com>
References: <20200717152307.36705-1-alcooperx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Android systems, After temporarily putting device to S2 by
short pressing the power button on the remote, the display turns
off. Then press the power button to turn the display back up. Adb
devices would show the devices is offline. It needs a physical
disconnect of the usb cable or power cycle to bring the device
back online. The device is operational otherwise.

The problem is that during S2 resume, the ADB gadget driver could
not link back with the BDC driver because the endpoint flags were
cleared. The fix is to clear the endpoint flags for the disconnect
case only and not for S2 exit.

Signed-off-by: Al Cooper <alcooperx@gmail.com>
---
 drivers/usb/gadget/udc/bdc/bdc_core.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/gadget/udc/bdc/bdc_core.c b/drivers/usb/gadget/udc/bdc/bdc_core.c
index be833d9e9db2..47bcc9f6afbd 100644
--- a/drivers/usb/gadget/udc/bdc/bdc_core.c
+++ b/drivers/usb/gadget/udc/bdc/bdc_core.c
@@ -292,9 +292,13 @@ static void bdc_mem_init(struct bdc *bdc, bool reinit)
 		/* Initialize SRR to 0 */
 		memset(bdc->srr.sr_bds, 0,
 					NUM_SR_ENTRIES * sizeof(struct bdc_bd));
-		/* clear ep flags to avoid post disconnect stops/deconfigs */
-		for (i = 1; i < bdc->num_eps; ++i)
-			bdc->bdc_ep_array[i]->flags = 0;
+		/*
+		 * clear ep flags to avoid post disconnect stops/deconfigs but
+		 * not during S2 exit
+		 */
+		if (!bdc->gadget.speed)
+			for (i = 1; i < bdc->num_eps; ++i)
+				bdc->bdc_ep_array[i]->flags = 0;
 	} else {
 		/* One time initiaization only */
 		/* Enable status report function pointers */
-- 
2.17.1

