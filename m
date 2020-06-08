Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6A6DC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 12:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75EDB2074B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 12:22:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SW8D7gsA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729731AbgFHMWD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 08:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729628AbgFHMWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 08:22:02 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E27C08C5C2;
        Mon,  8 Jun 2020 05:22:01 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id 10so2604717pfx.8;
        Mon, 08 Jun 2020 05:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=HDxho5qgH/ZNs1hwouSLFAzSS6Ya6IXAFD99ObdyT2U=;
        b=SW8D7gsAlHDtxyd8A/lLyC0s9kXr1vPCLo4wGsWfQOgnAw2y0SomQpam6DVE20cx4G
         pGClR37CIUCmo0HVoo1Aupipewj1E4JYe7uPjhf3wf6fgT9ugod8M3qShjyNg665Aqxl
         xbwTktjbLIN5qbaoyRF4G5HfXrfDfVa19TZWErDO2pWWY8CY4AyUBlfePgjUH0HYOpji
         hzcxlbSeQsmcZjRZ86qZAqeowtgrZYtWX8nHpl7AiN34tIeYpWfCFOu5tWbqWMGASZhK
         dBPuJoDmiANdj2K/F4d4Rk/x4Scw5qBUEm9MyRdXwiLQnZejrRv80JPIjlZuslxF1k5o
         AVWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HDxho5qgH/ZNs1hwouSLFAzSS6Ya6IXAFD99ObdyT2U=;
        b=U3DGD5XKqkBXWPEawHTkrMnCDPLs4+mGvJVjYeQ4LXBu0rVWbzL5xa+E3oIiACIq28
         fPdbaSlBAZJjNmIXrjUZ9IotjbS0XBfacm3Hoi1rAWSXg29zR/TNJBICMQCQWf5yGVk8
         23ZKEbyiwpQ/Dbq0WqEk8GCoMORFgMuUK3V6mZ5mHDHeZ0pV0CkNlOSilIr1k/dwOgkJ
         tvkCtd+Fb9+R11UbRwusQRbrt1fbX6p+PXFQyg2qD6f2JMM8kYmPMUWXF/AT+M4+W/tI
         52sCErAdVXejTr8w/ZxaL2AWCDV4CoKDxTsq2vfhG0H559qA6LSH4FwEmWeqPn3ZMUVy
         PUCw==
X-Gm-Message-State: AOAM5300tPL9dJvt99mQxHC2ZcJmK+k0L6TpIcgDasrznkZS3z/mPPKn
        BPCuYRSrF+tSP7PcRgxrQBoKWNrg
X-Google-Smtp-Source: ABdhPJwMhWCzEK/UeGQzspWpga1Pqrnmfx1UaWD/aQi3RYJ9+jsb3BBeRs5aBHPb3r/reQoTC/L+5Q==
X-Received: by 2002:a62:36c5:: with SMTP id d188mr3677066pfa.120.1591618920957;
        Mon, 08 Jun 2020 05:22:00 -0700 (PDT)
Received: from localhost.localdomain ([45.135.186.34])
        by smtp.gmail.com with ESMTPSA id g29sm6975584pfr.47.2020.06.08.05.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 05:22:00 -0700 (PDT)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     ohad@wizery.com, bjorn.andersson@linaro.org
Cc:     baolin.wang7@gmail.com, baohua@kernel.org,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hwspinlock: sirf: Remove the redundant 'of_match_ptr'
Date:   Mon,  8 Jun 2020 20:20:28 +0800
Message-Id: <250d35cb489c3c4c066f7ce256d27f36712a1979.1591618255.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the the redundant 'of_match_ptr' macro to fix below warning
when the CONFIG_OF is not selected.

All warnings:
drivers/hwspinlock/sirf_hwspinlock.c:87:34: warning: unused variable
'sirf_hwpinlock_ids' [-Wunused-const-variable]

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
---
 drivers/hwspinlock/sirf_hwspinlock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwspinlock/sirf_hwspinlock.c b/drivers/hwspinlock/sirf_hwspinlock.c
index 823d3c4f621e..a3f77120bad7 100644
--- a/drivers/hwspinlock/sirf_hwspinlock.c
+++ b/drivers/hwspinlock/sirf_hwspinlock.c
@@ -94,7 +94,7 @@ static struct platform_driver sirf_hwspinlock_driver = {
 	.probe = sirf_hwspinlock_probe,
 	.driver = {
 		.name = "atlas7_hwspinlock",
-		.of_match_table = of_match_ptr(sirf_hwpinlock_ids),
+		.of_match_table = sirf_hwpinlock_ids,
 	},
 };
 
-- 
2.17.1

