Return-Path: <SRS0=2gEN=4S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20734C3F2D1
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 13:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4ED120880
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 13:55:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tRZ0UaJg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbgCANz4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Mar 2020 08:55:56 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36582 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbgCANz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 08:55:56 -0500
Received: by mail-pf1-f196.google.com with SMTP id i13so4225807pfe.3
        for <linux-kernel@vger.kernel.org>; Sun, 01 Mar 2020 05:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=x0UYkUSt3rVBawINrnvEmbepT92w96nJbbovelwdwQA=;
        b=tRZ0UaJgy0zArOcNxbGmRydFRY1HEpcfhB8qLu3XUTLqhMo3sjaBoXZWSqhNEqH8kA
         Frtij0htg9fSYejaX1ttD6E9nLgINTY5xaEHLGzJYX7te+rL77M46JVl0pxk87Sxm9DV
         zm4VcwNbIHwQj0T9YyHUEC2YN6t8OesJNoZ5/iMIj6OAByOjUa3Jc6GY5qP/yo9kOdl+
         sygeQFxiHxPR7G9/XVMjSSV4pbwAKYXSRBHz1DwOeAciSHVQ4Q0HKEGYb8O9zq3h33lv
         MtbE5BhQqDdrZ08lD0wDZAcSc/sdc3QNTF8YyR9/v9PGfDLCU/8AaquNzS5UV4EgjlCA
         7GRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=x0UYkUSt3rVBawINrnvEmbepT92w96nJbbovelwdwQA=;
        b=b133wiEruuNPAp+pTHj6rVZ8duk4RJAxDj8YS39eKDBWWvoRSK/iSAu6zd6LTC9tWN
         awqWhRx1UGMJDg3MAcQJ7Bg7B6T6RFIKFImRNhQ+kSEuYi97JUDS1lzHdSepZ4u8uJci
         T7Kl/ssYEwrKJkdRHggWCubCX4I8kE7b2GD7QRDTOb9HuD512ZesGosb1+HgWqlRXbnQ
         xLXOLIbsGPUm3b5ydDWOMTJTyDP7IllyMGpQf3I8vFUoFj6glQTOzE3CLqgwXCzZAgPP
         pDvM2AlKi+ICzpw2aVCuO0hvIVOWSAvW3bpLwJ9QutCXhOCAVm1WaoRqk0QZp1azTMFF
         +ysw==
X-Gm-Message-State: APjAAAU4ofM5Fq2JCtX1TLokaMO7G53W5eJYt2klgvUqHotlMiXwGTg6
        uipgdbmKv3c+zgex8Z8UB7IT9hn6
X-Google-Smtp-Source: APXvYqyZewdIXqzDS3+ZVh/xuz4KhtfAmVtoOQkELhTkFeoqEnTtHTjPVFrm/Xf2EQ5hzN/Myelxpg==
X-Received: by 2002:aa7:86c2:: with SMTP id h2mr13526218pfo.45.1583070955250;
        Sun, 01 Mar 2020 05:55:55 -0800 (PST)
Received: from localhost.localdomain ([124.123.105.39])
        by smtp.googlemail.com with ESMTPSA id 76sm17623658pfx.97.2020.03.01.05.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2020 05:55:54 -0800 (PST)
From:   Somala Swaraj <somalaswaraj@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org,
        Somala Swaraj <somalaswaraj@gmail.com>
Subject: [PATCH] ipc : mqueue.c :Fixed a brace coding style issue
Date:   Sun,  1 Mar 2020 19:25:30 +0530
Message-Id: <20200301135530.18340-1-somalaswaraj@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

    Fixed a coding style issue.

    Signed-off-by: somala swaraj <somalaswaraj@gmail.com>
---
 ipc/mqueue.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index 49a05ba3000d..dc8307bf2d74 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -239,11 +239,10 @@ static inline void msg_tree_erase(struct posix_msg_tree_node *leaf,
 		info->msg_tree_rightmost = rb_prev(node);
 
 	rb_erase(node, &info->msg_tree);
-	if (info->node_cache) {
+	if (info->node_cache)
 		kfree(leaf);
-	} else {
+	else
 		info->node_cache = leaf;
-	}
 }
 
 static inline struct msg_msg *msg_get(struct mqueue_inode_info *info)
-- 
2.17.1

