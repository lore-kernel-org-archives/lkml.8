Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B1F3C433EB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 17:08:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23D12206F5
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 17:08:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="awyK+/J/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732032AbgGVRIL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 13:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728780AbgGVRIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 13:08:09 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D496AC0619DC;
        Wed, 22 Jul 2020 10:08:08 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id o8so2572559wmh.4;
        Wed, 22 Jul 2020 10:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FfMzlhpuKdKcXMybci9PDGAk8L1HINtrLq53dONpTi0=;
        b=awyK+/J/ZexeObtbQq75to+n6QIeYQKQ3PxYSN/lmajMIq7ooFFNwAT6nGL2CYXltT
         6hHY6AVFjNeMmjvC7yjdPgL5ihqpiM6efKREqhfeXHs1Wky5eYh0dplUQcW77PFigqB6
         LLxBfsGz3Oz91lQnOS6Q4JdrponW1Jw+IW5fj13wix/qQLVwN5w91FuWzzW45iqme7yr
         7u3/W+22phY408cPcjmQtKDD6bNqZq7CGz6VlShJtPB3chONRdCBn5WXrpY6dld9IIB6
         i4kY0J8PHHvx8zqQ1X8bb3L7x40aA/ptg8CSnsXxDzvY2151G8PWT1y83IKMOpH15W4A
         Aw0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FfMzlhpuKdKcXMybci9PDGAk8L1HINtrLq53dONpTi0=;
        b=bVywbfqq4e5h1BNu0po0kxK100VJ6npk/2zdr991Xs6C/Mdhhj7ZB8143NeB+BCjde
         onk6k9wqiByNpI9eD4EQkaGS86vEVSF6d3HQh0Bta2tVg3vY1VT/CUTimLzH/NlmmfoF
         m6OYggl4LqAGw/xjc59ly0LqBt2siP5miDWMcUqCdzhca6sUR6T/UFVWO8kyHe3woTuF
         kuzrq8S6xisj510QeqL1eNmh2kKyM77kHmsrgdd/WG3DU9AQyiHu1+NuDu+qQbasGttO
         QGkGU1LcMM2Lfvr9I7t9EWsHTz30BbBtgCjwe7sV9eRKuIjPRIhL5QF/60x/thjEuO5J
         nlfA==
X-Gm-Message-State: AOAM531FD59Bz/WB9UYIw/+MRQ4hXPeAJKhJBETXzmO+pjYyugvLiQyh
        nhHn91PiwPFY3dc1BxPShzEin/xu
X-Google-Smtp-Source: ABdhPJznzR6Kt1wjtl/5EjwZA6R5ysPgwL70usJqg6/MvUhLYuKe2pAFNbHQwNvt/03EtPOPAOkqOA==
X-Received: by 2002:a1c:7402:: with SMTP id p2mr528060wmc.117.1595437687275;
        Wed, 22 Jul 2020 10:08:07 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id 133sm392960wme.5.2020.07.22.10.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 10:08:06 -0700 (PDT)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>, devicetree@vger.kernel.org,
        Felipe Balbi <balbi@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Sasi Kumar <sasi.kumar@broadcom.com>
Subject: [PATCH v3 4/7] usb: bdc: Adb shows offline after resuming from S2
Date:   Wed, 22 Jul 2020 13:07:43 -0400
Message-Id: <20200722170746.5222-5-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200722170746.5222-1-alcooperx@gmail.com>
References: <20200722170746.5222-1-alcooperx@gmail.com>
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
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/usb/gadget/udc/bdc/bdc_core.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/gadget/udc/bdc/bdc_core.c b/drivers/usb/gadget/udc/bdc/bdc_core.c
index b70b438efff4..2c2f7aef7ba7 100644
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

