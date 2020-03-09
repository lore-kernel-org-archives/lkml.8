Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1143DC10F25
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 20:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9EB020873
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 20:17:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="WkouEh14"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbgCIURK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 16:17:10 -0400
Received: from gateway31.websitewelcome.com ([192.185.144.28]:46929 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726106AbgCIURK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 16:17:10 -0400
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id 076D426FC8
        for <linux-kernel@vger.kernel.org>; Mon,  9 Mar 2020 15:17:10 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id BOppjUfDbvBMdBOpqjO9uu; Mon, 09 Mar 2020 15:17:10 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ulbAlsTZmPkWr06VQww9fMcwzBjA45yLahK8oOBRTqA=; b=WkouEh146JrjLOdxwg8CkJw2/I
        JooWwxJJLkWEq7tFIjtFtBn9tjCLMejsqmxno22TB+EKguj6lt/Xq89zpcSeGjTwtAgKDmEKwMaUn
        1oaNdNH4VBX00sv1HZdcXHttB8PAw5FmOuUFgDl63DXHEEz7zxinIOqBxaPFDAXvhoRUqBWYD8Cxq
        iI7/7U+cLFXaHW+cA4hwZ6LcFNkERE1oGnUpjSsl68VOJ2NY7gvVsHABTZO3PxYT+5Dhn5ghliYLK
        RNd0CxdwVU5V6AxzhEN9gqNcRkTHm4H6fcj5gOysDTfS9ZjSiZaz1iLoapG7uCzBn7SlnitPrIZDI
        jjLk9OQw==;
Received: from [201.162.168.201] (port=27171 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1jBOpl-000x4o-N4; Mon, 09 Mar 2020 15:17:08 -0500
Date:   Mon, 9 Mar 2020 15:20:16 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>
Cc:     ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH][next] ocfs2: dlm: Replace zero-length array with
 flexible-array member
Message-ID: <20200309202016.GA8210@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.162.168.201
X-Source-L: No
X-Exim-ID: 1jBOpl-000x4o-N4
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [201.162.168.201]:27171
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 10
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current codebase makes use of the zero-length array language
extension to the C90 standard, but the preferred mechanism to declare
variable-length types such as these ones is a flexible array member[1][2],
introduced in C99:

struct foo {
        int stuff;
        struct boo array[];
};

By making use of the mechanism above, we will get a compiler warning
in case the flexible array does not occur last in the structure, which
will help us prevent some kind of undefined behavior bugs from being
inadvertently introduced[3] to the codebase from now on.

Also, notice that, dynamic memory allocations won't be affected by
this change:

"Flexible array members have incomplete type, and so the sizeof operator
may not be applied. As a quirk of the original implementation of
zero-length arrays, sizeof evaluates to zero."[1]

This issue was found with the help of Coccinelle.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 fs/ocfs2/dlm/dlmcommon.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/ocfs2/dlm/dlmcommon.h b/fs/ocfs2/dlm/dlmcommon.h
index 0463dce65bb2..c8a444622faa 100644
--- a/fs/ocfs2/dlm/dlmcommon.h
+++ b/fs/ocfs2/dlm/dlmcommon.h
@@ -564,7 +564,7 @@ struct dlm_migratable_lockres
 	// 48 bytes
 	u8 lvb[DLM_LVB_LEN];
 	// 112 bytes
-	struct dlm_migratable_lock ml[0];  // 16 bytes each, begins at byte 112
+	struct dlm_migratable_lock ml[];  // 16 bytes each, begins at byte 112
 };
 #define DLM_MIG_LOCKRES_MAX_LEN  \
 	(sizeof(struct dlm_migratable_lockres) + \
@@ -601,7 +601,7 @@ struct dlm_convert_lock
 
 	u8 name[O2NM_MAX_NAME_LEN];
 
-	s8 lvb[0];
+	s8 lvb[];
 };
 #define DLM_CONVERT_LOCK_MAX_LEN  (sizeof(struct dlm_convert_lock)+DLM_LVB_LEN)
 
@@ -616,7 +616,7 @@ struct dlm_unlock_lock
 
 	u8 name[O2NM_MAX_NAME_LEN];
 
-	s8 lvb[0];
+	s8 lvb[];
 };
 #define DLM_UNLOCK_LOCK_MAX_LEN  (sizeof(struct dlm_unlock_lock)+DLM_LVB_LEN)
 
@@ -632,7 +632,7 @@ struct dlm_proxy_ast
 
 	u8 name[O2NM_MAX_NAME_LEN];
 
-	s8 lvb[0];
+	s8 lvb[];
 };
 #define DLM_PROXY_AST_MAX_LEN  (sizeof(struct dlm_proxy_ast)+DLM_LVB_LEN)
 
-- 
2.25.0

