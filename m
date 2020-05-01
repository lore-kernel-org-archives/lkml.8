Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02086C47257
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 01:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D22FC20873
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 01:53:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OD86UNg7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbgEABxR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 21:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727114AbgEABxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 21:53:16 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B90C035494
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 18:53:16 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id t12so6219551edw.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 18:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=j9Kda2ZMzERIfmoRsalDd4Qs7A9RvCefihNSzH/my34=;
        b=OD86UNg78ivHDmdcvDqv2BI4SX/8T8Rl+eFOo4cj6J9tw4UBjxoYDgcJVRoe/s3ZNE
         REWAULHQz46aNm3X73Kous/fi2h25vtE16oQjf+Dmj7RnV/BVAMs9iRHQZcwXAusHtqq
         2WnRMTICOfsOQM4T486+Sc5qmmSqZD4mMOoq3XqKevPEC6aharuMDZ2W4s7VF2ckhmya
         4QByGdyGSUYnXHOkfzTk6DkJK6aiSryPa9LAt/J1qxZgZBHjAYVUWznK70EYzKOy/SFH
         EM2mZOl6O9IdDXsMnUeiNYW4KADz5EwkpY23HBg/g2gHuFUe+Ss67d8RDwNMPTllz1ib
         b2dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=j9Kda2ZMzERIfmoRsalDd4Qs7A9RvCefihNSzH/my34=;
        b=ZjikZ+EiN1Z2PsYTl9REZcRAs1F1RyBIA4cgJ1aw4kEBP8/Qo/Qw+rh3m+bcSB4V3q
         q7kUhh3bmX1n87WKhonkO+Hsl3JdzgIlRKlhItsbOhtEDA1vB5l7jeBTwgoq9WsuRH/+
         ZodYfcsEXEsyzuBq10lWieYVJ1UaMS4XfovHclMoYcDUoXr6sC8BnUdDUrZEU4kcQ33Q
         k82D60sGXY3NmFzJUsV81MehyvenstXDO6zZjl6hG5Xb0FTBCSgKXSnbykDKM12iaZ0+
         M5JoLtM/gRpHzZ+S583Bzmo2jzTwv8/sGxktYz4DHOCUcy1lnA7mA5qfsmi6ztzU2IRK
         HaVw==
X-Gm-Message-State: AGi0Pubu4z0qKANRFqXgLqFhHkR/0Gt6+MMTOPx05hOpbsiRgvne5JVw
        vj0qXMLbwqV7pYn7IElazkY=
X-Google-Smtp-Source: APiQypISfC9xoj/GtBzBklPyzxul23IZsdu7YUppY2oWHs6suogoxtNDpwtr/QjuP/+4F4OUbYX3MQ==
X-Received: by 2002:a05:6402:22d5:: with SMTP id dm21mr1585390edb.275.1588297994845;
        Thu, 30 Apr 2020 18:53:14 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id ss26sm171284ejb.70.2020.04.30.18.53.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Apr 2020 18:53:14 -0700 (PDT)
From:   Wei Yang <richard.weiyang@gmail.com>
To:     akpm@linux-foundation.org, ying.huang@intel.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH 1/3] mm/swapfile.c: classify SWAP_MAP_XXX to make it more readable
Date:   Fri,  1 May 2020 01:52:57 +0000
Message-Id: <20200501015259.32237-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

swap_info_struct->swap_map[] encodes some flag and count. And to
do some condition check, it also introduces some special values.

Currently those macros are defined with some magic order, which makes
audience hard to understand the exact meaning.

This patch split those macros into three categories:

    flag
    special value for first swap_map
    special value for continued swap_map

May this help audiences a little.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
---
 include/linux/swap.h | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 1e99f7ac1d7e..ec507c67529b 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -183,12 +183,17 @@ enum {
 #define SWAP_CLUSTER_MAX 32UL
 #define COMPACT_CLUSTER_MAX SWAP_CLUSTER_MAX
 
-#define SWAP_MAP_MAX	0x3e	/* Max duplication count, in first swap_map */
-#define SWAP_MAP_BAD	0x3f	/* Note pageblock is bad, in first swap_map */
+/* Bit flag in swap_map */
 #define SWAP_HAS_CACHE	0x40	/* Flag page is cached, in first swap_map */
-#define SWAP_CONT_MAX	0x7f	/* Max count, in each swap_map continuation */
-#define COUNT_CONTINUED	0x80	/* See swap_map continuation for full count */
-#define SWAP_MAP_SHMEM	0xbf	/* Owned by shmem/tmpfs, in first swap_map */
+#define COUNT_CONTINUED	0x80	/* Flag swap_map continuation for full count */
+
+/* Special Value in first swap_map */
+#define SWAP_MAP_MAX	0x3e	/* Max count */
+#define SWAP_MAP_BAD	0x3f	/* Note page is bad */
+#define SWAP_MAP_SHMEM	0xbf	/* Owned by shmem/tmpfs */
+
+/* Special Value in each swap_map continuation */
+#define SWAP_CONT_MAX	0x7f	/* Max count */
 
 /*
  * We use this to track usage of a cluster. A cluster is a block of swap disk
-- 
2.23.0

