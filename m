Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E2FC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 11:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 287F620771
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 11:42:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c3oazDIn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbgHNLmA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 07:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728205AbgHNLkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 07:40:18 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3913C06134E
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 04:40:11 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id p20so8089238wrf.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 04:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9Db0/XegKOvDRgZ77poJrd7OK4ys0Vj7FE0VspABfIc=;
        b=c3oazDInGW7hjrBIsl+zkAlUf5XdaIpPfFz3xERqVymAskbwi16DPAktyD53jA3b66
         /VOUQgRQ6z4vBQOCkHrfsvmGX69PCEy7jMg5cYGTAN/BKeMSg1aFyX6u1JgYhY/wofRP
         AjLQ2/OgQciCs1lQvFlym5gCyLc5UElaSt+nCxIIt0GrxXFIHEO19882b+DHL24RcpNs
         PlLlaG8OWAcbN1yTgVP4CABv2rSyGGMMwqzTawWPQTJwLSIGKGm+asMO19fjIT2BXKjP
         eaWwSPDyMvcL9trE/s3Hp9dQl/io/SIae6+GP2aGpowdN/RiSUqjTfZ4re4x9uCX+ZVq
         wnEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9Db0/XegKOvDRgZ77poJrd7OK4ys0Vj7FE0VspABfIc=;
        b=WObvw/vQayRja9JAozXdZdrJ/iVLcVWrdKvYeYphZiQFoO6IQ4auHk0nWKe12zRoR6
         x97FxE2luEk+Kr1rPxjuYsOTfjvebpUMeELkqwjOVTrHgRX5KMSeCYmlZGQLmCyHWaVk
         +K7Y93FFpKmjFQ4HsVClG3qk3yv4YtwIukSV2Ei9S3nwNrLK59NHqzxGc5vh2J96Ecgk
         5qfWfKO26VJtONRhpGwMFNh5L+AJuLvELp3wR5MtmBPJ9sPaQpi7o4/hcVcJNzgRfM6d
         W8txBhKWe4cghiKWmz+SpgIwXN5ybKvpCrzuEFg0xP5uq+3s1GY7/df9v+rCq+CyKvGQ
         wklA==
X-Gm-Message-State: AOAM530kyl5ddWUU6J66LQytfh4IgcwBySkLx5v7euKcOSB8qIahxaIR
        c2/7coFOFxtnqLq9BQxEvCMi1g==
X-Google-Smtp-Source: ABdhPJy2TwazZiHw6gMHYPOVlPScYRlKeMGm2BnOOf+FwnWaIAiGUOP2+xsysshx48ue6Viw0BB5gA==
X-Received: by 2002:adf:ea0c:: with SMTP id q12mr2302330wrm.382.1597405210454;
        Fri, 14 Aug 2020 04:40:10 -0700 (PDT)
Received: from dell.default ([95.149.164.62])
        by smtp.gmail.com with ESMTPSA id 32sm16409129wrh.18.2020.08.14.04.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 04:40:09 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 19/30] net: fddi: skfp: fplustm: Remove seemingly unused variable 'ID_sccs'
Date:   Fri, 14 Aug 2020 12:39:22 +0100
Message-Id: <20200814113933.1903438-20-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200814113933.1903438-1-lee.jones@linaro.org>
References: <20200814113933.1903438-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This variable is present in many source files and has not been used
anywhere (at least internally) since it was introduced.

Fixes the following W=1 kernel build warning(s):

 drivers/net/fddi/skfp/fplustm.c:25:19: warning: ‘ID_sccs’ defined but not used [-Wunused-const-variable=]

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@st.com>
Cc: netdev@vger.kernel.org
Cc: linux-stm32@st-md-mailman.stormreply.com
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/net/fddi/skfp/fplustm.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/fddi/skfp/fplustm.c b/drivers/net/fddi/skfp/fplustm.c
index 02966d141948f..4cbb145c74abb 100644
--- a/drivers/net/fddi/skfp/fplustm.c
+++ b/drivers/net/fddi/skfp/fplustm.c
@@ -21,10 +21,6 @@
 #include <linux/bitrev.h>
 #include <linux/etherdevice.h>
 
-#ifndef	lint
-static const char ID_sccs[] = "@(#)fplustm.c	1.32 99/02/23 (C) SK " ;
-#endif
-
 #ifndef UNUSED
 #ifdef  lint
 #define UNUSED(x)	(x) = (x)
-- 
2.25.1

