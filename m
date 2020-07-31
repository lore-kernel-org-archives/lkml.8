Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 282EFC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 18:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02F2E22B3F
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 18:23:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rkuLmF18"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387774AbgGaSXg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 14:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730040AbgGaSXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 14:23:36 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C873CC061574
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 11:23:35 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id r4so25838156wrx.9
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 11:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=JrC7qjycRVRdrX0NTlD/R/AKY99Uy/kwyi/myWTpiKg=;
        b=rkuLmF182iw2YqxYnqSjWWhjpbt02vob0rNC0oy3d6jv/dgO0x4P+AeBexG6N4+2Iw
         U6bjClb81TpEyNZkl20Ozo6kPvlOYEU/QMwHC3+Bm5mn4zAY0adQIBFbrTAlEEgvHar4
         qKJ3eun4Uavxz+rkd0bi4BiYSWU8XYs4RzkrjD9AOPboPYPGucw2ampAdhO/WItPFx1B
         Deg3Xj9deUniMl9PxgYhIjhocZ7nMPa0BgqRE0+aKbDChVF9Ba5f1w+OjqQMmpmwV+p8
         DIQIg53JttZDaaHUUTkmXehJPILz0rJkl3KuGYVwmBTqKPxrIfaT8w2iAzFf84iovXlA
         RnPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=JrC7qjycRVRdrX0NTlD/R/AKY99Uy/kwyi/myWTpiKg=;
        b=Ofj7iY1TxxXwvArsqezHXEbNuBe+lwLEArsr6DE/n2PACaUCn+ReBCLHJtO6UhtsTB
         0kA7NEQs43p9tLXJ+DvXECRQi2Xcg9K1TPLdOXCLjLdTJH0OHA1YVq1oqSBUtoAFAQOI
         VJ9vGEzM8kzEYwNSBBoWxQJs0yBgsTlcUXXpNRNOfvbxN4C2VuHpgpvebZS5RMM/rFAH
         dbr4Hc8Jt8GiQEPWKm57o4sKzOePwcYWS4UHQBnqjVZzz6FEEIBdCVwWUm85lnbXANTZ
         9Yp+nL/A9stKXTWJZX2gubPTm3Mjpi923y+M9i5Z5qL6C5HYVTLcdccH9jO0xmqLThag
         /AcQ==
X-Gm-Message-State: AOAM53200pQ+9OHTjecrF0fnw9MDKo/pmLj/eJHgvBCj4Vh5Pwwv7bvu
        wVMGP3WTEgPBy+QpEeuo/5I=
X-Google-Smtp-Source: ABdhPJyJZTfhAEA5m+p9J5f1jm1Pp9Jm9AT8/Dj6usWq2d15BVLYRItc1jMwsQSn45jxFe3gjR3B2w==
X-Received: by 2002:a5d:498f:: with SMTP id r15mr4881418wrq.175.1596219814513;
        Fri, 31 Jul 2020 11:23:34 -0700 (PDT)
Received: from tsnow (IGLD-83-130-60-139.inter.net.il. [83.130.60.139])
        by smtp.gmail.com with ESMTPSA id n5sm13890776wrx.22.2020.07.31.11.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 11:23:33 -0700 (PDT)
Date:   Fri, 31 Jul 2020 21:23:30 +0300
From:   Tomer Samara <xsamarax00@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org
Subject: [PATCH] staging: netlogic: clear alignment style issues
Message-ID: <20200731182330.GA3176@tsnow>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clear checkpatch alignment style issues in xlr_net.c.
    CHECK: Alignment should match open parenthesis

Signed-off-by: Tomer Samara <xsamarax00@gmail.com>
---
 drivers/staging/netlogic/xlr_net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/netlogic/xlr_net.c b/drivers/staging/netlogic/xlr_net.c
index 204fcdfc022f..69ea61faf8fa 100644
--- a/drivers/staging/netlogic/xlr_net.c
+++ b/drivers/staging/netlogic/xlr_net.c
@@ -355,7 +355,7 @@ static void xlr_stats(struct net_device *ndev, struct rtnl_link_stats64 *stats)
 			    stats->rx_missed_errors);
 
 	stats->tx_aborted_errors = xlr_nae_rdreg(priv->base_addr,
-			TX_EXCESSIVE_COLLISION_PACKET_COUNTER);
+						 TX_EXCESSIVE_COLLISION_PACKET_COUNTER);
 	stats->tx_carrier_errors = xlr_nae_rdreg(priv->base_addr,
 						 TX_DROP_FRAME_COUNTER);
 	stats->tx_fifo_errors = xlr_nae_rdreg(priv->base_addr,
-- 
2.25.1

