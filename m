Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90220C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 20:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48D2A2078E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 20:46:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W7CrXqAZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731581AbgFOUp7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 16:45:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58188 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731532AbgFOUp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 16:45:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592253956;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=TJCHkDZhyWuXXWeNe8iaosb9wy02/ddef5wGJbSOb7I=;
        b=W7CrXqAZd3+FKnL5DYdHliT9kTfvJBuE8yu+Ee1EDFT2EweDFNYfgt8IYJ/CeoZiISudoh
        pFylDFlzt2apcSf7c/3vvFxGTRPCqVIRFf2Vxm/N4tVMV4n1vZ23KD6zy9VMKXs4IG86du
        JYHR/Y/orqaM1fkT63qOqILrxvppcoA=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-454-jYK7UMzNPtOvh8bZUOyIFw-1; Mon, 15 Jun 2020 16:45:55 -0400
X-MC-Unique: jYK7UMzNPtOvh8bZUOyIFw-1
Received: by mail-qk1-f197.google.com with SMTP id 16so15200963qka.15
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 13:45:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TJCHkDZhyWuXXWeNe8iaosb9wy02/ddef5wGJbSOb7I=;
        b=pdqCH8R1PW2Qgu2jiYKdSA/A4GGo82j9tO/iilGj5TINQrZbivLypuYUEQoVdAkVVI
         WJCg4j5w6RpXaqcfudyuaJ+Wl7XCokWEEYXX9tNvX7a5baqg+uqxXORh4cFN/0MAzphI
         qNTSf5kyBU5h61uHPiIJF0ZbIvvdkRkotznMqxU1Ee6zGIUdrerQ6nHZ29jWyZ9pUquM
         GEKfL2SJ9pDfcCMUl23wxrq/jj3t35l8O87Dlu627ar6FtPvKCcgwjc0wPQYF0DFOmIR
         e00WyLWyO/pIFII3Azg40/m+12+fXc+xLUtykde3bvkcwWClVFAj5tLKjBS6+duwni/c
         aHiA==
X-Gm-Message-State: AOAM5309dIU2Fd8QTjiODlIBA/64JZCElU7IbiLfQUjVL0SwSZOvAza5
        RJZUO9Ihiri9U4zrRrMIEtRQS82v4ykbdxZbg1SLOmAFDRweUYcCZkkcHMkJRNSQa3IBsVlSz06
        gxKdePfgC7Qj0NXb/+O6mxc9F
X-Received: by 2002:a05:6214:1705:: with SMTP id db5mr26325349qvb.14.1592253954764;
        Mon, 15 Jun 2020 13:45:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyXbo7hbbH7LW9AmslC0JZpfWQroeYx2/3suBFGIqLSIO/NH3DhE72c7GflQe+8P1pIGbWHfw==
X-Received: by 2002:a05:6214:1705:: with SMTP id db5mr26325332qvb.14.1592253954529;
        Mon, 15 Jun 2020 13:45:54 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id s70sm12563576qke.80.2020.06.15.13.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 13:45:53 -0700 (PDT)
From:   trix@redhat.com
To:     paul@paul-moore.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, omosnace@redhat.com, weiyongjun1@huawei.com
Cc:     selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH v3] selinux: fix another double free
Date:   Mon, 15 Jun 2020 13:45:48 -0700
Message-Id: <20200615204548.9230-1-trix@redhat.com>
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
code_read_list handle the freeing the problem node along with all of the
earlier nodes.

Because cond_read_node no longer does any error handling, the goto's
the error case are redundant.  Instead just return the error code.

Fixes: 60abd3181db2 ("selinux: convert cond_list to array")

Signed-off-by: Tom Rix <trix@redhat.com>
---
v3: simplify returns

 security/selinux/ss/conditional.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
index da94a1b4bfda..450bc02f4cd2 100644
--- a/security/selinux/ss/conditional.c
+++ b/security/selinux/ss/conditional.c
@@ -392,27 +392,19 @@ static int cond_read_node(struct policydb *p, struct cond_node *node, void *fp)
 
 		rc = next_entry(buf, fp, sizeof(u32) * 2);
 		if (rc)
-			goto err;
+			return rc;
 
 		expr->expr_type = le32_to_cpu(buf[0]);
 		expr->bool = le32_to_cpu(buf[1]);
 
-		if (!expr_node_isvalid(p, expr)) {
-			rc = -EINVAL;
-			goto err;
-		}
+		if (!expr_node_isvalid(p, expr))
+			return -EINVAL;
 	}
 
 	rc = cond_read_av_list(p, fp, &node->true_list, NULL);
 	if (rc)
-		goto err;
-	rc = cond_read_av_list(p, fp, &node->false_list, &node->true_list);
-	if (rc)
-		goto err;
-	return 0;
-err:
-	cond_node_destroy(node);
-	return rc;
+		return rc;
+	return cond_read_av_list(p, fp, &node->false_list, &node->true_list);
 }
 
 int cond_read_list(struct policydb *p, void *fp)
-- 
2.18.1

