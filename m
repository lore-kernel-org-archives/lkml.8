Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C93CC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 20:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 517A220838
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 20:48:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VpDmiy0q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbgFKUsC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 16:48:02 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:38398 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726336AbgFKUsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 16:48:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591908479;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=p27NRDTfOll0al57bRGph1hQUJQAjyEYgeX7mB6CprU=;
        b=VpDmiy0qwCJmJWxe/pmC0wTAnbiBTsV3oK3EA/9tSPCmSpk5EpjAoXHRkA+JXSymloeiQf
        JRdD58f75VtLVdqlAd/NFW3lq/RFgUa6hLqLE0wWurXefvWRo0Gy7FV65YT3RYjNMJqi+P
        2+vc3H5ef603ezO2Z/9sY+j5nhNMIdo=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-311-Fr0zMlrROumlMjdtKf3A2w-1; Thu, 11 Jun 2020 16:47:58 -0400
X-MC-Unique: Fr0zMlrROumlMjdtKf3A2w-1
Received: by mail-qv1-f72.google.com with SMTP id ba13so5279960qvb.15
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 13:47:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=p27NRDTfOll0al57bRGph1hQUJQAjyEYgeX7mB6CprU=;
        b=s0ZgaZ7F9cKeAXKHmxZvyp3DwjeKBywqt+FlRWbfMqNm61TqxrMt0SVhoSBZ5IiJES
         5xnaEUd4YWYDjry2q3Z/c8g1PnmLE6jLFgLF0M6QAULgempqtAxp5iGfnYr5uhBxd4JQ
         TvdT5BUtr4fIXN1Ys+7CqTYXAEn9OMes5NR/resF0NWej2MheYSQy58yyYqBX3sRadjx
         EYF34qngCVhwf/aob0wjNTuEB6uVlkXXHuqOFnU8lFJ4gE4gq1gTmUbI/XnexgwTLvfo
         x/wlxakLx112kHQK6x9/L35QYAyRix+8k08O5E3J6HzQbWZmQtwGJxfdwIqgvk8JUyyk
         Ob2A==
X-Gm-Message-State: AOAM532h+Ia+q4j8QCGJVEn8KQiiS8DcgT2DbzR48gQ/wQ2vlgQh6hMZ
        y4RT/JBd7mC85DthtjMQ49mMpGfPiPhYpskrO8ewaaHGb/grpcis3Xu9dLxhvh7m2WQbFEDV6iS
        jf6CcrpJpHpRx6lza4wIeZXGF
X-Received: by 2002:aed:2744:: with SMTP id n62mr10495255qtd.152.1591908477796;
        Thu, 11 Jun 2020 13:47:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwb5ecoiGDwqaWt75+N8YTq/BcKeMEZOQMbxOw518l6VpcGNKKwiWwW1+InEO4wStt2aFDEoQ==
X-Received: by 2002:aed:2744:: with SMTP id n62mr10495241qtd.152.1591908477583;
        Thu, 11 Jun 2020 13:47:57 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id z4sm3302663qtu.33.2020.06.11.13.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 13:47:56 -0700 (PDT)
From:   trix@redhat.com
To:     paul@paul-moore.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, omosnace@redhat.com, weiyongjun1@huawei.com
Cc:     selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH v2 1/1] selinux: fix another double free
Date:   Thu, 11 Jun 2020 13:47:46 -0700
Message-Id: <20200611204746.6370-2-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20200611204746.6370-1-trix@redhat.com>
References: <20200611204746.6370-1-trix@redhat.com>
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

Fixes a problem was introduced by commit

  selinux: convert cond_list to array

Signed-off-by: Tom Rix <trix@redhat.com>
---
 security/selinux/ss/conditional.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
index da94a1b4bfda..d0d6668709f0 100644
--- a/security/selinux/ss/conditional.c
+++ b/security/selinux/ss/conditional.c
@@ -392,26 +392,21 @@ static int cond_read_node(struct policydb *p, struct cond_node *node, void *fp)
 
 		rc = next_entry(buf, fp, sizeof(u32) * 2);
 		if (rc)
-			goto err;
+			return rc;
 
 		expr->expr_type = le32_to_cpu(buf[0]);
 		expr->bool = le32_to_cpu(buf[1]);
 
 		if (!expr_node_isvalid(p, expr)) {
 			rc = -EINVAL;
-			goto err;
+			return rc;
 		}
 	}
 
 	rc = cond_read_av_list(p, fp, &node->true_list, NULL);
 	if (rc)
-		goto err;
+		return rc;
 	rc = cond_read_av_list(p, fp, &node->false_list, &node->true_list);
-	if (rc)
-		goto err;
-	return 0;
-err:
-	cond_node_destroy(node);
 	return rc;
 }
 
-- 
2.18.1

