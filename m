Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9658DC43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 16:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27FE52075A
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 16:22:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QFTneFpy";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="GbvfZJAF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbgIJQVv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 12:21:51 -0400
Received: from a27-11.smtp-out.us-west-2.amazonses.com ([54.240.27.11]:58478
        "EHLO a27-11.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725831AbgIJQN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 12:13:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1599754436;
        h=From:To:Cc:Subject:Date:Message-Id;
        bh=mfpmQP80PtHnWd2BFFKkwpK1n3jwJkNh0tPKNAoYuSE=;
        b=QFTneFpy2xXHMRcsUh3XE8v7c/z9BOhNwasggw67vnpGVpt7z6eqEKeuJ2uDs7Om
        dJBq5SI1kkwBUduACU/zYcIGMafZ1hXCZPkkNmeiOgn9rV99Y8IRpLn4EnKnPdbxESQ
        /m2yuc03JfaSRiq4f9GhDT+uccZlPKSa6sB2mZog=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1599754436;
        h=From:To:Cc:Subject:Date:Message-Id:Feedback-ID;
        bh=mfpmQP80PtHnWd2BFFKkwpK1n3jwJkNh0tPKNAoYuSE=;
        b=GbvfZJAFnNV8oAax6V4NofgXSy+qF7bQ5ZGHKwMIVzSxJvEVT0JlrNXfIenAALxX
        V0l9aMeRcVtudeitLSV+E28UI2U88fYgQdV4PnRQfhmyn7sWqs3vW/bwI1baF1+0cdD
        crb0k/zuq2r/B6TERMN48zKLfTOLI8fp/+M+kUw8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EDDB6C433FE
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=pintu@codeaurora.org
From:   Pintu Kumar <pintu@codeaurora.org>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, iamjoonsoo.kim@lge.com,
        rientjes@google.com, penberg@kernel.org, cl@linux.com
Cc:     pintu.ping@gmail.com, Pintu Kumar <pintu@codeaurora.org>
Subject: [PATCH] mm/slab.h: Fix duplicate include file kmemleak.h
Date:   Thu, 10 Sep 2020 16:13:56 +0000
Message-ID: <0101017478cb7fb9-897233cb-0f59-44fa-827d-3e9a62893e47-000000@us-west-2.amazonses.com>
X-Mailer: git-send-email 2.7.4
X-SES-Outgoing: 2020.09.10-54.240.27.11
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As I was browsing through this code, I found that linux/kmemleak.h
was declared twice.

When I run ./scripts/checkincludes.pl it reported the same:
mm/slab.h: linux/kmemleak.h is included more than once.

Thus removing the last included header.

Signed-off-by: Pintu Kumar <pintu@codeaurora.org>
---
 mm/slab.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/slab.h b/mm/slab.h
index 6cc323f..95e5cc1 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -46,7 +46,6 @@ struct kmem_cache {
 #include <linux/kmemleak.h>
 #include <linux/random.h>
 #include <linux/sched/mm.h>
-#include <linux/kmemleak.h>
 
 /*
  * State of the slab allocator.
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

