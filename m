Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91349C10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 18:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6913C20578
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 18:09:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="buYf55WK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbgCISJJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 14:09:09 -0400
Received: from gateway31.websitewelcome.com ([192.185.143.5]:18642 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726169AbgCISJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 14:09:08 -0400
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id 112A64A81D1
        for <linux-kernel@vger.kernel.org>; Mon,  9 Mar 2020 13:09:08 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id BMpvjWgDWAGTXBMpwjySRv; Mon, 09 Mar 2020 13:09:08 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=VaFeJjrfVfGbP6nC6hR/+viONEvctW389EGllFCxNwA=; b=buYf55WK6wJoaFmjmzJEPQYS0e
        K5qYs4LxuKVnFZ+Gew78N9Lk/o9q9ikGI1lvR+8mJmjrfV6aZ+rELNG2m4Ywf2HaF4P3iNrq3OS1U
        KMd6f1Dg0UPjnWm9WKNkR00+f0RtetxV0Pdw4tdmirNNofrXvJe5lX0M0nLiVRLi0wmevsBeUWDaC
        7rmpd1HdMxHgEvW6EMhzDpqHTXwvlDE+3khTn01oqOTBtJjnq4e72+GsL2bdO/yGVDZR0mKWeXG35
        y13XWAyn616nmACgmDK7UXagQWiOmqWcOocLLr6uVatZlCYCrszASmVqoeM5X2AU27bOsR1XgtKGm
        IveJNKRw==;
Received: from [201.162.240.150] (port=6525 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1jBMpu-004F5Y-70; Mon, 09 Mar 2020 13:09:06 -0500
Date:   Mon, 9 Mar 2020 13:12:18 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH][next] hfs: btree.h: Replace zero-length array with
 flexible-array member
Message-ID: <20200309181218.GA3726@embeddedor>
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
X-Source-IP: 201.162.240.150
X-Source-L: No
X-Exim-ID: 1jBMpu-004F5Y-70
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [201.162.240.150]:6525
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 13
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
 fs/hfs/btree.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/hfs/btree.h b/fs/hfs/btree.h
index dcc2aab1b2c4..4ba45caf5939 100644
--- a/fs/hfs/btree.h
+++ b/fs/hfs/btree.h
@@ -60,7 +60,7 @@ struct hfs_bnode {
 	wait_queue_head_t lock_wq;
 	atomic_t refcnt;
 	unsigned int page_offset;
-	struct page *page[0];
+	struct page *page[];
 };
 
 #define HFS_BNODE_ERROR		0
-- 
2.25.0

