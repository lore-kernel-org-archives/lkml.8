Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23DA1C4332E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 17:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED4B020781
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 17:34:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iyOebHzv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbgCTReJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 13:34:09 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43849 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbgCTReI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 13:34:08 -0400
Received: by mail-lj1-f194.google.com with SMTP id u15so7029722lji.10
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 10:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=of48erB0S8cHeslTdzECLL0UR5qKqtxYepkriqnz45s=;
        b=iyOebHzva1NGNHGpqdCghDoH/dfwvxHleVANO6ewDmxSnY2X1xXz/vCAQiQ1LBCswx
         NbmnNapPbzh7QzdNPNBfJ2o3N3cXi7QLzBDF80dW7s4lfEbyz6OiDJkCWsOLasaBrXep
         eGPiHvbsmuITMkJDr9uRLy9Jb/w0+lufqGBTWMC/cDodkdSGU+k7ebakOHP2bzKe6vCv
         q8Rwp8QAKfCWnkh7Ry+UDUCwXVsuAv+oCK27KoD2K3+XVjWPH2BaImUS6h4y7YSr9b8+
         yxSJie5c8zBudGonz6RdZsr1DNm5I9S5fCdaw2B3F3Fkwhn66CavGkfS7yC5hoXbEBIt
         f4bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=of48erB0S8cHeslTdzECLL0UR5qKqtxYepkriqnz45s=;
        b=WuKu/dzcwu55U0tuEfLdMIMEQPd7d23LIimaoqMT17WEdp2sV3K1DygdN61KGWM5Z0
         BDd9EA8A0OfFLiJ/zvPzm4lzNkJJnz3QF0B4kINXAa0GmmQpBBWEfYjFKicQMQa6mTtv
         aR5vaPYIhcBMZ8u1piAxZRZyYJIokBwZkVtuVwPueyDt3OIlGjJhRZY0/wu8TUgr60xe
         /somZ6jG4e6tJl9g1OUmHBOQvOcQpgbdS+A6N7E6+ezbUJZwLDtcYHroGZwQ5G7MjQpq
         NSsIiwEymL/VT0Br/3j24lt5+vLoj1mW8eHaJdA67fLjfefXsKC+cE8Ptz9L8eVcCO5H
         cu9A==
X-Gm-Message-State: ANhLgQ3j/DNYVlgZ7m3hboQ223ocXIa5831X0/Z1obGWLMxTKjzy+58l
        QBxblwmoaNwapSXFq9+dzUEyJmSb
X-Google-Smtp-Source: ADFU+vtDzPH9ZgT/w73DsnlnfyslYS9eCf56nWJqC/bXo01479mNv2Jg3uh+5x48fZ5RmKoOCeV/bA==
X-Received: by 2002:a2e:6e13:: with SMTP id j19mr5785456ljc.253.1584725646438;
        Fri, 20 Mar 2020 10:34:06 -0700 (PDT)
Received: from localhost.localdomain (188.146.97.196.nat.umts.dynamic.t-mobile.pl. [188.146.97.196])
        by smtp.gmail.com with ESMTPSA id 24sm279334ljv.105.2020.03.20.10.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 10:34:05 -0700 (PDT)
From:   mateusznosek0@gmail.com
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Mateusz Nosek <mateusznosek0@gmail.com>, akpm@linux-foundation.org
Subject: [PATCH] mm/dmapool.c: micro-optimisation remove unnecessary branch
Date:   Fri, 20 Mar 2020 18:33:17 +0100
Message-Id: <20200320173317.26408-1-mateusznosek0@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mateusz Nosek <mateusznosek0@gmail.com>

Previously there was a check if 'size' is aligned to 'align' and if not
then it was aligned. This check was expensive as both branch and division
are expensive instructions in most architectures.
'ALIGN' function on already aligned value will not change it, and as it is
cheaper than branch + division it can be executed all the time and
branch can be removed.

Signed-off-by: Mateusz Nosek <mateusznosek0@gmail.com>
---
 mm/dmapool.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/mm/dmapool.c b/mm/dmapool.c
index fe5d33060415..f9fb9bbd733e 100644
--- a/mm/dmapool.c
+++ b/mm/dmapool.c
@@ -144,9 +144,7 @@ struct dma_pool *dma_pool_create(const char *name, struct device *dev,
 	else if (size < 4)
 		size = 4;
 
-	if ((size % align) != 0)
-		size = ALIGN(size, align);
-
+	size = ALIGN(size, align);
 	allocation = max_t(size_t, size, PAGE_SIZE);
 
 	if (!boundary)
-- 
2.17.1

