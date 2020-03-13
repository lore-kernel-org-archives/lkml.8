Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6AA0C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 18:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CFA020650
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 18:49:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MxRXc6Q5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbgCMStT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 14:49:19 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35117 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726475AbgCMStS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 14:49:18 -0400
Received: by mail-pg1-f196.google.com with SMTP id 7so5497069pgr.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 11:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TIeI33CnP5QKpGnSsdiCsIF7t+lJnBbahrkQscJS5rM=;
        b=MxRXc6Q5qEBOKxx981TK60HddE0pLJrWcX3X1iyZ58ji4eAMN/2C/jDtrm38DtPic7
         WTKdLEZgTrOhmpEhA1fBVgjmoGAky3/ysR9xMFQruBvj7SFURkKw/XRkelOb7dD23QHw
         +IfRERm4I/yexOg3WXfAYAvgHl/u3DuuHv5XJTXYySAvwhJMRcBT1b+2EssY874b3F85
         gnb5gNxeaa8KDOyoldEDumt6PjiOB9xh5cHWXy5Rp3nmWXLqOc1ZspCuY/5bZbf2FGnC
         /J/VfA7gOL8lP2BlJw/bN+8TwmQeccm99qkZXO4WHW/5LvsY4yfjK37hxkx/8WeqgMSU
         8ucw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TIeI33CnP5QKpGnSsdiCsIF7t+lJnBbahrkQscJS5rM=;
        b=b9ZdPIPeYo6oD+TgncqtcsQ2kuF7QuSW6/N6a7QwGeX1D/IgNoQH1HEeujXzc4qIwI
         2dv895XJpHDWkd0AAv9KvICJHzicave/BOCFGbsrTx6R62Y5xF3EklcQwQ3F1wuFWTis
         xZuncWWVPR6Y7qBDBIqhAQuTAcbLoss6hZrNkIMNxcLI+MAG9NUopdHJNtfM4Yas5vk8
         PBTRpoLLrWNDxLbu2tMFlk99oeQ6PxZCeCk69Aoxk17kU+IWRenxNFhFyP1hjFgQaB/8
         BrrsYvdfqUcit/a9Gppx7nc1oj5QHL7MVRW596wKM/Vt9qvHjhobHACoBA/xxLUFvwJY
         fGvw==
X-Gm-Message-State: ANhLgQ3hCS1zhVLwxq2Xs283q+zfcyJ6KhUG/1+4kuO6S68uD43+BdJy
        Y917yppj319Bdk2E+rVOZ3jzxd6p5ow=
X-Google-Smtp-Source: ADFU+vvkOBrXjaB1l0WGIs83+bRdppESvA4cma/FwjlJ3BoPQTY3nqd4/+q+/CvZF6CijnsrogG1PA==
X-Received: by 2002:a63:d144:: with SMTP id c4mr4258643pgj.261.1584125357061;
        Fri, 13 Mar 2020 11:49:17 -0700 (PDT)
Received: from localhost ([161.117.239.120])
        by smtp.gmail.com with ESMTPSA id b3sm12727908pjq.38.2020.03.13.11.49.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Mar 2020 11:49:16 -0700 (PDT)
From:   Qiujun Huang <hqjagain@gmail.com>
To:     willy@infradead.org
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Qiujun Huang <hqjagain@gmail.com>
Subject: [PATCH 1/2] radix-tree: fix kernel-doc for radix_tree_find_next_bit
Date:   Sat, 14 Mar 2020 02:49:08 +0800
Message-Id: <20200313184909.4560-2-hqjagain@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200313184909.4560-1-hqjagain@gmail.com>
References: <20200313184909.4560-1-hqjagain@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function changed at some point, but the kernel-doc was
not updated.

Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
---
 lib/radix-tree.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/lib/radix-tree.c b/lib/radix-tree.c
index c8fa1d274530..379137875e25 100644
--- a/lib/radix-tree.c
+++ b/lib/radix-tree.c
@@ -178,12 +178,11 @@ static inline void all_tag_set(struct radix_tree_node *node, unsigned int tag)
  * radix_tree_find_next_bit - find the next set bit in a memory region
  *
  * @addr: The address to base the search on
- * @size: The bitmap size in bits
+ * @tag: The tag index (< RADIX_TREE_MAX_TAGS)
  * @offset: The bitnumber to start searching at
  *
  * Unrollable variant of find_next_bit() for constant size arrays.
- * Tail bits starting from size to roundup(size, BITS_PER_LONG) must be zero.
- * Returns next bit offset, or size if nothing found.
+ * Returns next bit offset, or RADIX_TREE_MAP_SIZE if nothing found.
  */
 static __always_inline unsigned long
 radix_tree_find_next_bit(struct radix_tree_node *node, unsigned int tag,
-- 
2.17.1

