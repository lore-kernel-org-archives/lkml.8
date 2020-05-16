Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8553C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 02:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BECEC20756
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 02:17:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WYdOsqAq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727964AbgEPCRx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 22:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726290AbgEPCRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 22:17:52 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF27C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 19:17:49 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id mq1so21556312pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 19:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=0f4+wbqmNuQybJXObVLjzOmL1/TFimYYqW2mJ7P8jvA=;
        b=WYdOsqAqb2S/WxL0Yxbmz9UNEVydVDAHmD4XEuZ1pysS2DBdZrwHJnz2+xLeW48swd
         pQc4iantDggMHqehg4/x9XMeiFUDD4NRgOxSg2U74WgfQ5hQxzKcgD/c2VRMWbPvt0AG
         xs43CAH7WhqMqyA/Wbsy94stDGe9QAtHBilLRpeHW8smkkNkB1dc4LKDaVjtM07PrVru
         R5B5w9oJH4O76H8G/G2ttcQX0+c76Pg384+18VL41QtnQqGmGGEQ0H8GBucyMetTS456
         8ePee1/fW1YpJlRpdi82RQaFRjV73Xij2ldILpKzLPNuu+2tO79wB83pCoZEVdbQuI9d
         AKtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=0f4+wbqmNuQybJXObVLjzOmL1/TFimYYqW2mJ7P8jvA=;
        b=gVkRIVNITbsGkjB/fjFj8rLR2dkcP06qQlojPn9lTL2kDdtQMQixYu6CLE3NtLeP2j
         kpLKgFN0DsOCt8xnzHdAIDNcHLp6undNhK3rmu4O/a/cOwhD5vauPzjznUw0OLsC6VCQ
         I9iNyQbuBhE5nbxHvTPrDnVaTxzItg/mY23KGadWlGO8psYodSxZJBSd4dEbrWqWSu7P
         p72ZXJ+5Cxq4X9dfm99ZEzvD/cuBUSBBLla3O3dDejhn8fwj5/91bLROU3E835c+ffyu
         EJeSX+IztJ8j6EYZM/ApMBSOD+plxcMJB2RfOumjWBxnQCR4RWg2tR8x6heAFVBr80/Z
         GRrA==
X-Gm-Message-State: AOAM5315DyK/kHf0BuqnPhYRHFKVFqOEHWEHbn8MKvSrNO7BfIUQb/aj
        b55MK+FDO7XulNgKK0+8X6l+bmS98T234w==
X-Google-Smtp-Source: ABdhPJyeepV8Yb/Dvt4uWdALUG5pDYOCm1g70MhDrwbuzZwPAforTnJkYuyITdPQYy8OArKILB78NelHkeBolA==
X-Received: by 2002:a17:90a:8c98:: with SMTP id b24mr6832646pjo.226.1589595467480;
 Fri, 15 May 2020 19:17:47 -0700 (PDT)
Date:   Fri, 15 May 2020 19:17:36 -0700
Message-Id: <20200516021736.226222-1-shakeelb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
Subject: [PATCH] net/packet: simply allocations in alloc_one_pg_vec_page
From:   Shakeel Butt <shakeelb@google.com>
To:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the initial allocation for pg_vec buffers are done through
page allocator with __GFP_NORETRY, the first fallbacks is vzalloc and
the second fallback is page allocator without __GFP_NORETRY.

First, there is no need to do vzalloc if the order is 0 and second the
vzalloc internally use GFP_KERNEL for each individual page allocation
and thus there is no need to have any fallback after vzalloc.

Signed-off-by: Shakeel Butt <shakeelb@google.com>
---
 net/packet/af_packet.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 29bd405adbbd..d6f96b9f5b01 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -4243,19 +4243,12 @@ static char *alloc_one_pg_vec_page(unsigned long order)
 	if (buffer)
 		return buffer;
 
-	/* __get_free_pages failed, fall back to vmalloc */
-	buffer = vzalloc(array_size((1 << order), PAGE_SIZE));
-	if (buffer)
-		return buffer;
+	/* __get_free_pages failed, fall back to vmalloc for high order. */
+	if (order)
+		return vzalloc(array_size((1 << order), PAGE_SIZE));
 
-	/* vmalloc failed, lets dig into swap here */
 	gfp_flags &= ~__GFP_NORETRY;
-	buffer = (char *) __get_free_pages(gfp_flags, order);
-	if (buffer)
-		return buffer;
-
-	/* complete and utter failure */
-	return NULL;
+	return (char *)__get_free_pages(gfp_flags, order);
 }
 
 static struct pgv *alloc_pg_vec(struct tpacket_req *req, int order)
-- 
2.26.2.761.g0e0b3e54be-goog

