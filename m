Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71BC4C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 17:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43955206C1
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 17:19:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DJxTsMo9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730760AbgGVRT5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 13:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726717AbgGVRT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 13:19:56 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2496EC0619DC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 10:19:56 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id f139so2715111wmf.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 10:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=U9D+0Ct1EtIB5tMzgMoQL7ukxnL4Apd61YzkKS86VhM=;
        b=DJxTsMo9lMr3Kx1STp3oPnKHS4WatHi1vqKHjfXy0eJid1QxPl78X1Og4P97cYb6yS
         MzuB0zji7KW4nucHZo2iilJMfS6nMNdvwocoA69xIhtVWWjYejtkTtxLeUAIvT757+Nf
         HMb0AwX4k8F9m3HEQE1arOxAhtTGX4a6L/ZXAdpcjDQHclSF7yBbOesJMyL3md8OY9my
         w/lFX/dkk/6hb4chP1quW4Tc2RP5AlIqwQqds8zfOT1Lgq/r3W9U6btzxEUNnBdL+u8v
         5EBMcBv4gG5GIgsmguayN5ZhTKW0el+vM0pxOMsfQLSVmYY4eDoLRwCG2fZBw4RHCXC2
         EQqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=U9D+0Ct1EtIB5tMzgMoQL7ukxnL4Apd61YzkKS86VhM=;
        b=aYtQKkjuoKANceONhF6Rbpngqy6IWKWnIUq8OW6smHm4h6m99QrvRVjP0+3dg0z/xq
         qZrINM4M2nERFzIvK8DF6dRTHaPinbOw3aRV1kIdXQeqsunGrYTZ5iOuQAR2c+pzSiIr
         0w3WQ6TflJxnxicS0O6Jx0i7ZlgqvraQy0wVgej9Z1WtPT4mIQ9el4zIlcHitQoPKZD6
         PRSl6xMMDpUnoIXh96LqkMIEd8VFwWjQU4uOUHHYmmvLRdvyyTy5zWfJv1wLiCz17Plp
         KBYXW9ZU3XhIzwKJn9YBJTn/IkdNtSCUCpLQarc1AbmmuADEpSnu6WTADMdjf6OLKPVi
         HPKA==
X-Gm-Message-State: AOAM530CUJIrjq5OPNFUU0ZU6LNyczmEjpr71O2G9lATlJCSCraX6cK+
        PSovR/QlUD75liukpEPQ1agDOGkq2B8=
X-Google-Smtp-Source: ABdhPJyLmldvk3KZr3KWQewC+IuIqH/xcyEwEqpjjw81ai9FHwrzinO3m7Z03bdk0T6SMxkpogj+TA==
X-Received: by 2002:a7b:c408:: with SMTP id k8mr643545wmi.152.1595438394879;
        Wed, 22 Jul 2020 10:19:54 -0700 (PDT)
Received: from PKL-UANJUM-LT.pkl.mentorg.com ([103.150.154.211])
        by smtp.gmail.com with ESMTPSA id c10sm632640wro.84.2020.07.22.10.19.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Jul 2020 10:19:54 -0700 (PDT)
Date:   Wed, 22 Jul 2020 22:19:50 +0500
From:   Muhammad Usama Anjum <musamaanjum@gmail.com>
To:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: octeon: Indent with tabs instead of spaces
Message-ID: <20200722171950.GA6176@PKL-UANJUM-LT.pkl.mentorg.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove a coding style error. It makes code more readable.

Signed-off-by: Muhammad Usama Anjum <musamaanjum@gmail.com>
---
 drivers/staging/octeon/ethernet-defines.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/octeon/ethernet-defines.h b/drivers/staging/octeon/ethernet-defines.h
index ef9e767b0e2e..40f91c78e462 100644
--- a/drivers/staging/octeon/ethernet-defines.h
+++ b/drivers/staging/octeon/ethernet-defines.h
@@ -27,14 +27,14 @@
 #define REUSE_SKBUFFS_WITHOUT_FREE  1
 #endif
 
-#define USE_ASYNC_IOBDMA            (CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE > 0)
+#define USE_ASYNC_IOBDMA		(CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE > 0)
 
 /* Maximum number of SKBs to try to free per xmit packet. */
-#define MAX_OUT_QUEUE_DEPTH 1000
+#define MAX_OUT_QUEUE_DEPTH		1000
 
 #define FAU_TOTAL_TX_TO_CLEAN (CVMX_FAU_REG_END - sizeof(u32))
 #define FAU_NUM_PACKET_BUFFERS_TO_FREE (FAU_TOTAL_TX_TO_CLEAN - sizeof(u32))
 
-#define TOTAL_NUMBER_OF_PORTS       (CVMX_PIP_NUM_INPUT_PORTS + 1)
+#define TOTAL_NUMBER_OF_PORTS		(CVMX_PIP_NUM_INPUT_PORTS + 1)
 
 #endif /* __ETHERNET_DEFINES_H__ */
-- 
2.17.1

