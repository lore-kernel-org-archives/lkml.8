Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A7FC3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 22:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9402C21739
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 22:55:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="QYl5cJcJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgCBWzq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 17:55:46 -0500
Received: from gateway30.websitewelcome.com ([192.185.179.30]:45797 "EHLO
        gateway30.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726700AbgCBWzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 17:55:45 -0500
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id 9F9C127B7F6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Mar 2020 16:45:51 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 8totjnULuAGTX8totjvo6M; Mon, 02 Mar 2020 16:45:51 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=dkyiZbi82sRMXDWl+l7m1bATmLMG/I5NQlKX/71VLXo=; b=QYl5cJcJAyr0ypfhklYr9othGz
        CqDuoPUfzMUUpey6hN5ysSRq+SqaYroLKFmJFcBNG7t73zZp/QauykI4/HeSes8+fIAParqL7aFJB
        WuYvNrAJ6gXswSSiWthEFGeGAYG4DNw9r/5NCY8nL6k0YkaTwu1K70eI6ifZL4C/XdTp1gpGZTmuT
        MrAgrMHAKqRQZ9kqfkFa6kOIru2eefp9n6XzL6PbSpC2k2Ky0UVAOdZY7W8YNC45JmJHJJgDKApDv
        iYS9ewjh1oVSox+M2/0ewjWzOk4mvIWLHwUPBoWwvISunjp0cYgHjX1Ig6IywoSOblhp9z7P6eLtm
        CVG7sunw==;
Received: from [201.166.169.236] (port=28341 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1j8tor-000uFg-I1; Mon, 02 Mar 2020 16:45:49 -0600
Date:   Mon, 2 Mar 2020 16:48:51 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Peter Oberparleiter <oberpar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] gcov: fs: Replace zero-length array with flexible-array
 member
Message-ID: <20200302224851.GA26467@embeddedor>
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
X-Source-IP: 201.166.169.236
X-Source-L: No
X-Exim-ID: 1j8tor-000uFg-I1
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [201.166.169.236]:28341
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 6
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
 kernel/gcov/fs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/gcov/fs.c b/kernel/gcov/fs.c
index cc4ee482d3fb..82babf5aa077 100644
--- a/kernel/gcov/fs.c
+++ b/kernel/gcov/fs.c
@@ -58,7 +58,7 @@ struct gcov_node {
 	struct dentry *dentry;
 	struct dentry **links;
 	int num_loaded;
-	char name[0];
+	char name[];
 };
 
 static const char objtree[] = OBJTREE;
-- 
2.25.0

