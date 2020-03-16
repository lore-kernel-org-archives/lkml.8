Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25063C10DCE
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 03:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDD2320409
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 03:02:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GJP4e9ib"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729559AbgCPDCY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 23:02:24 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38341 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729384AbgCPDCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 23:02:24 -0400
Received: by mail-pf1-f196.google.com with SMTP id z5so9111737pfn.5
        for <linux-kernel@vger.kernel.org>; Sun, 15 Mar 2020 20:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=PwYq+A1nBUiHCamHP77xjqJcKLDZlCT05cW3CB3WdrU=;
        b=GJP4e9ibvDaiUCeFZmTsWbbCaZixvjDfN5VAd4upMaukROlyyWrodnB18XnnD5h0Wd
         WjBVh/PUI0m1/UGm3XnE0VUUg+2zROSJcelavaqY2B2BzT3MxT2hiykXvbdvE5PAQzER
         tE+02pJ+3kQ2NuIiGI+FmRsP9+cFbyzDLDmksFYiPkkYe9HULELQ5Rlok7AzFBZf3fCc
         bfQQlNW9LoVWQRWt8+MODdgPz5Y9wcHu0HQNznfz1P+mR7Al80DRa7lQxQOXnIJVMd7J
         vImuHsul8Ctxc2h8dGX1Z05SjVkPeenys7AVgyCEa/TuPs3VfCBaWGuCLbjqVVgP4AGI
         R6rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=PwYq+A1nBUiHCamHP77xjqJcKLDZlCT05cW3CB3WdrU=;
        b=W92wg4fmEsLl2moiqu4YEaqkItorXu6cTyLKrm1h0NEPSR9ZD7mFcWHlh0Q9CXaiJS
         KgKOA8BmbhD6L7nvQbaZ/pRMeSdhbyi8txBWrUK25He4TGlR0HmW3LEOFu+m0trkgFkD
         1E8oph75CUISZhjfSfEpFEqKd3aUN+QZcu5PUMpOm3L8ZM3KgT75i3UGCZlspYzkUx9q
         s7bEMewYE2Yrb6xY11qKsYl/uJIp1N8OPlSH56vMod1vFbMzKcaw08hZM5jkppO70CQh
         v09d/wGUT33C+0+PAiNWLF9g4LlikDOv+17xEe4Umu7jIQ5aR1QaMH+SEddsQaBcOiUh
         mwaA==
X-Gm-Message-State: ANhLgQ3g+CmJK5cJ+3IpGSDtaN0Vx6JgifII6jVAok7XKR7FYTWnjRvE
        V/hXodzc5uoJbe7y7zwLZNQ=
X-Google-Smtp-Source: ADFU+vvvCRZptt1keOCzp7s/mqcH3SI0afsBof8SrJtqjVyGlgfk6YIsz1XSM0sKKKH3u90e8jvyqw==
X-Received: by 2002:aa7:8f36:: with SMTP id y22mr25918957pfr.162.1584327741784;
        Sun, 15 Mar 2020 20:02:21 -0700 (PDT)
Received: from VM_0_35_centos.localdomain ([150.109.62.251])
        by smtp.gmail.com with ESMTPSA id e26sm56422pfj.61.2020.03.15.20.02.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Mar 2020 20:02:21 -0700 (PDT)
From:   Qiujun Huang <hqjagain@gmail.com>
To:     willy@infradead.org, gregkh@linuxfoundation.org
Cc:     tglx@linutronix.de, rfontana@redhat.com, armijn@tjaldur.nl,
        linux-kernel@vger.kernel.org, Qiujun Huang <hqjagain@gmail.com>
Subject: [PATCH] radix-tree: update the description for radix_tree_find_next_bit
Date:   Mon, 16 Mar 2020 11:02:16 +0800
Message-Id: <1584327736-11492-1-git-send-email-hqjagain@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function changed at some point, but the description was not
updated.

Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
---
 lib/radix-tree.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/lib/radix-tree.c b/lib/radix-tree.c
index c8fa1d2..3791378 100644
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
1.8.3.1

