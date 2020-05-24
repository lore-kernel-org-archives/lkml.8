Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B78C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 14:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F33BB2075F
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 14:16:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fSRPewXd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729539AbgEXOQw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 10:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728875AbgEXOQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 10:16:51 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A07FC061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 07:16:51 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id a13so6509246pls.8
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 07:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=26jwUiaIAUz/6Ev2v00cLqCLqvfA+MXZ7k72pWkEh7w=;
        b=fSRPewXdlPPA79anRBoQagUoauQuk0oEIoAFldBDDWxj9ppsNZhrGt4Kw1zfU6txIK
         BWSRdFabH5UrP4zYH/le1rDqlkOqzDtAlu9e9OPzAIzJhsZJr9+XuwHRiglLK0kW85tS
         ixKmIZjOZgMPLfeWrLLanGgwO6LCYxrUqm+dPoWuc8uLb0rk5xlseT5TvfZotayTfnQI
         TnBaakyN0r1OQqP//XnOEuRJjVwVomMv21idc2Is9PrmvDmxcQdN2VOE8DxNLogTjyl3
         O034XnUmwdQwb8ULfcAXelQxVDiRspZzFha+ZdX0d3Jo9EgKzaj2TdkBN6anMRvRdmpt
         ATaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=26jwUiaIAUz/6Ev2v00cLqCLqvfA+MXZ7k72pWkEh7w=;
        b=k40JivTQOcvUFCQIkYP931WheDmgJmCaSQ94Fr7gnVWnUcXnKDpG5U7ok0HBCkt5H1
         n9dbSOkjmkuevnQFg8T6Lqd7Dh11yU4wY0+1idCb9akIWDLvi8fc2BJlgLiH2UibNzWs
         g0SsebPUdgYNZmV2ln3JyAq68Y3Fp9iu05AlEPccI7xJVSyIXTK/TTjnyFOxayaumLCo
         l/uQxH6244nuAIfJSj/m6v9mfeuhuKrPED91l7Epgw2N5lL44wyYrI5HzCz6k1VTQCfr
         ooJCc+zNTvqf0DNIkhuVlVOyyd8c7P+dQZCQPzFq1n4p1DRY9njWmT7ane61JQHG0P3S
         6Lbw==
X-Gm-Message-State: AOAM533aE3jvcZ/+Uj3FpM6ssX2inlT08Kq/G3oBwwD2Gi1EQ7Du0xg4
        i1PF0TisHBFuEruIoeQ2+nmhuJFHrJg=
X-Google-Smtp-Source: ABdhPJwWDDga1OeykkpZqriQTyzukeDkLEGmB4gXxJkQk/egtV1RPxEgi5wAvAFlIcCNN3jiHbOO5Q==
X-Received: by 2002:a17:90a:c83:: with SMTP id v3mr15855131pja.136.1590329810629;
        Sun, 24 May 2020 07:16:50 -0700 (PDT)
Received: from roro-Lenovo-Y520-15IKBN ([175.197.19.249])
        by smtp.gmail.com with ESMTPSA id o27sm9891768pgd.18.2020.05.24.07.16.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 24 May 2020 07:16:49 -0700 (PDT)
From:   daeroro <skseofh@gmail.com>
X-Google-Original-From: daeroro <skseofh@naver.com>
Date:   Sun, 24 May 2020 23:16:40 +0900
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm/memblock:Do not retry a range that has already been
 checked
Message-ID: <20200524141640.GA10017@roro-Lenovo-Y520-15IKBN>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The range that has already been checked
don't have to be checked in a second attempt.

Signed-off-by: daeroro <skseofh@naver.com>
---
 mm/memblock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index 39aceafc57f6..6f72fae415ee 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1489,7 +1489,7 @@ static void * __init memblock_alloc_internal(
 
 	/* retry allocation without lower limit */
 	if (!alloc && min_addr)
-		alloc = memblock_alloc_range_nid(size, align, 0, max_addr, nid,
+		alloc = memblock_alloc_range_nid(size, align, 0, min_addr, nid,
 						exact_nid);
 
 	if (!alloc)
-- 
2.17.1

