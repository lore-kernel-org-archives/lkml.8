Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF86C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 14:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A85820899
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 14:48:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DoVlnDUG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730247AbgGBOsV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 10:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730039AbgGBOq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 10:46:58 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D56EDC08C5DD
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 07:46:57 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id o2so28287735wmh.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 07:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=28X3U4dJc3uramg6kDHLLVs+7HIKsy1aJX4qqakHpps=;
        b=DoVlnDUG55Z4Fzv9+d1V8Ieq224Bfdh8KlYCNDYO1eP2cAbL9Nih/BvbtIkArPTCgY
         9VJgpbG9xQ71lm4ghblIel7Ajs+qU1OqUnTyaCshoagZiUE2MzvozTLZotuvn5FmGeP+
         YOdVX4MTT9x5O+qveBt4kpo/oJKwWt+EU5xKr0VvewkyHWF9badOtmf1EYeDEQ4jvDpf
         nXl4J32zR7BlkJVzhTaX8z1hR7v+7RgJuKlrcj9CO/hdrTRAw0GKFQCyJ0gIVKfjAL0A
         RI8wMjBewSNCZsWaWT3urJ4JA12qcvR3+GSQ+TyQyAid8K8Az19vtresRc7nwlXYT8ZC
         1QKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=28X3U4dJc3uramg6kDHLLVs+7HIKsy1aJX4qqakHpps=;
        b=hQ7bwJIj4IcctgEOzQj8UFQnI9vh+QaW7pRGiUBknC9ig9mNu2Layvok6wx/Ycq2gy
         vOmTmnnJ+Htsmk0JsSC5RMUxUeMqpIsvX3R2perxpGYDf2lvctDAf/Wg4j08FvCAaUcm
         u4w4OoAlnayM/D4GeYdbee8GuFrTmjau6GzmEoaHvfQ6lCo5PRnWGN/WusVLPdEDYzSh
         GyzE+s3V3t0uTc7PU2lGBCp9qwmV9MyOhdByuVPHqSeMi4htIHHcjAA42AjYCZotiewG
         2SRhrmUlX/1Ewji0+5CUJP7ttgiRUhOP2kXAMoysUsj2iUlp6k2GMFQVTzBOIx6Y0/PE
         ozbw==
X-Gm-Message-State: AOAM533aIByP/C8CZYyKtyIGV0Xz99cRt/6vCi3zcMygLukODxgcw7so
        FnoR1YCzZZMz8JMoFgSbW5dGpA==
X-Google-Smtp-Source: ABdhPJyhJBjWN4in2TNPlqyGbZpG7D4RdUGXcarVJruUemj20CkpM1cwqnzu9QOonoxh49cCQh2bmA==
X-Received: by 2002:a7b:c3d0:: with SMTP id t16mr34760561wmj.117.1593701216646;
        Thu, 02 Jul 2020 07:46:56 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id g14sm7002737wrw.83.2020.07.02.07.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 07:46:56 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Thibaut VARENE <varenet@parisc-linux.org>
Subject: [PATCH 20/30] usb: host: ohci-at91: Demote kerneldoc headers down to basic comment blocks
Date:   Thu,  2 Jul 2020 15:46:15 +0100
Message-Id: <20200702144625.2533530-21-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200702144625.2533530-1-lee.jones@linaro.org>
References: <20200702144625.2533530-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neither usb_hcd_at91_probe() nor usb_hcd_at91_remove()'s function
headers reach the standards required of a kerneldoc entry.  Only
one attempt at describing an argument was made, as it is not
correct (we're removing that too to save confusion).

Fixes the following kernel build warning(s):

 drivers/usb/host/ohci-at91.c:166: warning: Function parameter or member 'driver' not described in 'usb_hcd_at91_probe'
 drivers/usb/host/ohci-at91.c:166: warning: Function parameter or member 'pdev' not described in 'usb_hcd_at91_probe'
 drivers/usb/host/ohci-at91.c:259: warning: Function parameter or member 'hcd' not described in 'usb_hcd_at91_remove'
 drivers/usb/host/ohci-at91.c:259: warning: Function parameter or member 'pdev' not described in 'usb_hcd_at91_remove'
 drivers/usb/host/ohci-at91.c:259: warning: Excess function parameter 'dev' description in 'usb_hcd_at91_remove'

Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
Cc: Thibaut VARENE <varenet@parisc-linux.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/usb/host/ohci-at91.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/host/ohci-at91.c b/drivers/usb/host/ohci-at91.c
index b635c6a1b1a91..0487a4b0501ec 100644
--- a/drivers/usb/host/ohci-at91.c
+++ b/drivers/usb/host/ohci-at91.c
@@ -153,7 +153,7 @@ static struct regmap *at91_dt_syscon_sfr(void)
 /* always called with process context; sleeping is OK */
 
 
-/**
+/*
  * usb_hcd_at91_probe - initialize AT91-based HCDs
  * Context: !in_interrupt()
  *
@@ -244,9 +244,8 @@ static int usb_hcd_at91_probe(const struct hc_driver *driver,
 
 /* may be called with controller, bus, and devices active */
 
-/**
+/*
  * usb_hcd_at91_remove - shutdown processing for AT91-based HCDs
- * @dev: USB Host Controller being removed
  * Context: !in_interrupt()
  *
  * Reverses the effect of usb_hcd_at91_probe(), first invoking
-- 
2.25.1

