Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 850C4C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 15:58:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BA8B206A4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 15:58:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pdo5vN7K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728757AbgFKP6k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 11:58:40 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:26698 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728258AbgFKP6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 11:58:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591891119;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=w+ltTGgilIWFB1kDQPEZ/eaSLvQzZ8qt2YQ/v22wotc=;
        b=Pdo5vN7KggTCFGTPfEli5Wvw2FsA3+EFSB+uYST5u2W6JEFt2ePu34FZ0PmACdBuIzqtmc
        s+0JkailRX1fg04K1FElvJswBlfyi+XBP+fUzgFsPx89FIL74WZsdcZmV1xQhaPEs9JDgj
        WvnfB8qdjB6QhuuHYYImenXEb62JYX8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-463-AIKW23e6PaOBAm--svtBUw-1; Thu, 11 Jun 2020 11:58:37 -0400
X-MC-Unique: AIKW23e6PaOBAm--svtBUw-1
Received: by mail-qv1-f71.google.com with SMTP id x16so4691002qvp.19
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 08:58:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=w+ltTGgilIWFB1kDQPEZ/eaSLvQzZ8qt2YQ/v22wotc=;
        b=Y585cWJtF+Pk5yh9y6eUgB3Yi3VycvXMMLJX9ojk4n2uUwxzrT9OdmdE7mLh1+H6I7
         aLtxUkcYslsWjaRWKg9Y3irbVrr69HUQWBQt4ch/cMAZsQrL7jlnKJkY+AIREhxw1B1n
         +bxZon8qG1je1q5oQO+TJQr9gfaMSZV5vvkyybOQNJTrVGUySqt8RX1uoOr9HsKukRBM
         snDtxLepal/IikBAUV5fIucCYImgYINV6uVBmNbYMzpNYZda9A+MDZ5hX22EUqCs8b3g
         /ZTUUKkQxWOpi6V0J02TmFlE7zuiZGAnqYtX1+RRT2bIEONCpLkHXstKhZabp3Pet7wT
         YhjQ==
X-Gm-Message-State: AOAM531+CAGHJAa+P1BKr2Dh11Yx+MxKXJlvV7oEc+NjK6kz49w37SDk
        ryJLNpHS7nYV9P9eyqVEsCyoBvxz2ZthEFI8Y8zLdxYx17lmDNBywjnvThjGWF9P6ITu+q4m7No
        0SJcmj7PGqUzKpTflGBycClxv
X-Received: by 2002:a05:620a:21d3:: with SMTP id h19mr8714749qka.375.1591891116489;
        Thu, 11 Jun 2020 08:58:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzHPj8jU9GZgzfn0ZyMBnQzNm18FKM1jLhw2T20/zWTSphsfmMdFNVJsWRU9XsOmqJ3dOqmdQ==
X-Received: by 2002:a05:620a:21d3:: with SMTP id h19mr8714732qka.375.1591891116294;
        Thu, 11 Jun 2020 08:58:36 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id k34sm826332qtf.35.2020.06.11.08.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 08:58:35 -0700 (PDT)
From:   trix@redhat.com
To:     paul@paul-moore.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, omosnace@redhat.com, weiyongjun1@huawei.com
Cc:     selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] selinux: fix another double free
Date:   Thu, 11 Jun 2020 08:58:30 -0700
Message-Id: <20200611155830.8941-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Clang static analysis reports this double free error

security/selinux/ss/conditional.c:139:2: warning: Attempt to free released memory [unix.Malloc]
        kfree(node->expr.nodes);
        ^~~~~~~~~~~~~~~~~~~~~~~

When cond_read_node fails, it calls cond_node_destroy which frees the
node but does not poison the entry in the node list.  So when it
returns to its caller cond_read_list, cond_read_list deletes the
partial list.  The latest entry in the list will be deleted twice.

So instead of freeing the node in cond_read_node, let list freeing in
code_read_list handle the freeing the problem node along with all of the the
earlier nodes.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 security/selinux/ss/conditional.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
index da94a1b4bfda..ffb31af22f4f 100644
--- a/security/selinux/ss/conditional.c
+++ b/security/selinux/ss/conditional.c
@@ -411,7 +411,6 @@ static int cond_read_node(struct policydb *p, struct cond_node *node, void *fp)
 		goto err;
 	return 0;
 err:
-	cond_node_destroy(node);
 	return rc;
 }
 
-- 
2.18.1

