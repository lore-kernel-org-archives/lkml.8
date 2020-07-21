Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1BB9C433EC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 14:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AED1620717
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 14:44:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LXNkh5E3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729813AbgGUOoD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 10:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbgGUOoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 10:44:01 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B62C061794;
        Tue, 21 Jul 2020 07:44:01 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id q5so21461496wru.6;
        Tue, 21 Jul 2020 07:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SDSJ6E6TyEjHyBsZi4uqpY8XOPxYP4sG84LLuvagPCE=;
        b=LXNkh5E373uukeAG5HTm4hVe/3CIMyTSPNosbt4uZyKOWpSkcIi47dMSNW4x2QyhNj
         oKPvQ/Yt+xETCl98ceCROauXnRAiXk61fkusYxT1H7caPFb10HLO2f1L1ft3GXZJapeD
         FpuNkhaC4m7Fa6Q+wEqy+XDWuVzqW7t7hxo/XY1n1BySqM0D/OuqojY1R/cL8zmeHSzQ
         pjYkV8rGbF8ijkSUIoK5IaCMzZJGilpmmlVQs9vWU2CyGzc4xpkhbAJzdxC4bT2OMvEJ
         wej6HXbzZEtWJI7d2Kb7FxanzlEuVMvVd2QA5RdcNVmPkO1TUCIwfENJge5ZTeFzk/U+
         FaFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SDSJ6E6TyEjHyBsZi4uqpY8XOPxYP4sG84LLuvagPCE=;
        b=e4cf7yTTrHnLRD1cRPPd29u3RxYoTz+4cz3LmIIdCrIlf7Y8yrfjp20QnmCbefTepZ
         ajEc1+v9PEbYrSh78tC7H8PNQmo7EhiTHiP7vKqxHsA/3unZQVNhQoHhqfUSvYmgRjbX
         gaHGjQFBQ676wYOXtHCfoDlKpIEXsHbA7psGaDTqjO0wt6d+/eNOHkI73afXYuDfU8S0
         SItIKbmgzjDnCZ/y3oDz5x42H+2oxe8qlOrPJFkDcwWdSAs7fuk8dCPm4WDSOree6Exg
         cTT+8aHfMyEDZWllZL6qts4xquvrmjuwVvLhRDo3jErABs8zyx0539aIVujrxtdtsoDc
         9hFA==
X-Gm-Message-State: AOAM531OClGH82pmVVgpc4hCf/59KM7ywkDqsx0QFl8u7ohWEp6quJu0
        tHfkdHQqZxaCbemlaCC1V5ebGGh3
X-Google-Smtp-Source: ABdhPJxLflxKVX4ZbEq70tqbZQAsMbzjsGhVX2zwjUEKaxUf0RoKUkc3pbcANasoTbPWI3btN/OVog==
X-Received: by 2002:a05:6000:1cf:: with SMTP id t15mr28987303wrx.180.1595342639503;
        Tue, 21 Jul 2020 07:43:59 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id y6sm38043116wrr.74.2020.07.21.07.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 07:43:58 -0700 (PDT)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>, devicetree@vger.kernel.org,
        Felipe Balbi <balbi@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Sasi Kumar <sasi.kumar@broadcom.com>
Subject: [PATCH v2 5/7] usb: bdc: driver runs out of buffer descriptors on large ADB transfers
Date:   Tue, 21 Jul 2020 10:43:24 -0400
Message-Id: <20200721144326.7976-6-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200721144326.7976-1-alcooperx@gmail.com>
References: <20200721144326.7976-1-alcooperx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Version v1.0.40 of the Android host ADB software increased maximum
transfer sizes from 256K to 1M. Since the STB ADB gadget driver
requests only 16K at a time, the BDC driver ran out of buffer
descriptors (BDs) if the queuing happens faster than the incoming
16K transfers. This issue is fixed by doubling the number of BDs
that can be queued so that the entire 1M request can be queued
without running out of buffers.

Signed-off-by: Al Cooper <alcooperx@gmail.com>
---
 drivers/usb/gadget/udc/bdc/bdc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/bdc/bdc.h b/drivers/usb/gadget/udc/bdc/bdc.h
index 6e1e881dc51e..ac75e25c3b6a 100644
--- a/drivers/usb/gadget/udc/bdc/bdc.h
+++ b/drivers/usb/gadget/udc/bdc/bdc.h
@@ -44,7 +44,7 @@
 #define NUM_SR_ENTRIES	64
 
 /* Num of bds per table */
-#define NUM_BDS_PER_TABLE	32
+#define NUM_BDS_PER_TABLE	64
 
 /* Num of tables in bd list for control,bulk and Int ep */
 #define NUM_TABLES	2
-- 
2.17.1

