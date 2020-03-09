Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF811C10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 15:54:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA585208C3
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 15:54:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="Rvl9bUmz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbgCIPyO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 11:54:14 -0400
Received: from gateway33.websitewelcome.com ([192.185.145.9]:37146 "EHLO
        gateway33.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726758AbgCIPyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 11:54:13 -0400
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway33.websitewelcome.com (Postfix) with ESMTP id 0477B114CE
        for <linux-kernel@vger.kernel.org>; Mon,  9 Mar 2020 10:54:13 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id BKjMjTcbYAGTXBKjMjvPxB; Mon, 09 Mar 2020 10:54:13 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=+BaSL/NXH+vKbe1CVWfTOyE0XFeJdExgkXsHwEW8bZA=; b=Rvl9bUmzCsVQ3LxP1VqzX3BCk1
        6h2vTBkMtniXzllZDDb3PQ7uaU2W8Z45i8ii3SBRxiPvbiXn0C/DMXvazcyNzeyyGW3vCNmD3N14E
        Ukyu9Jsz1lW9aXxhsN1Xe1l5Hxg+EIOhZc99ZnFJkCyv2hUFX2Jcp5tg2li3THZe9E9v3D7zYhID9
        9Il3xJ5qJ7Iq9RMx6/3c0alGj9kiTcJJ0acMzTvyD7W6Okr97kJDf4u76sY4+ewapl5MwKPMBxAAT
        RGpj/duv1MFvplmfVWBk+h7quQxOgJI/QRoKUPHkaiWKXfyZhcmoy9SpsKZxLVwQNwduc7vcTIiZ7
        WcYgO0/Q==;
Received: from [201.162.240.150] (port=24477 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1jBKjK-0030kr-LK; Mon, 09 Mar 2020 10:54:11 -0500
Date:   Mon, 9 Mar 2020 10:57:22 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Christine Caulfield <ccaulfie@redhat.com>,
        David Teigland <teigland@redhat.com>
Cc:     cluster-devel@redhat.com, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH][next] dlm: user: Replace zero-length array with
 flexible-array member
Message-ID: <20200309155722.GA32023@embeddedor>
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
X-Exim-ID: 1jBKjK-0030kr-LK
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [201.162.240.150]:24477
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 16
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
 fs/dlm/user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/dlm/user.c b/fs/dlm/user.c
index 5264bac75115..e5cefa90b1ce 100644
--- a/fs/dlm/user.c
+++ b/fs/dlm/user.c
@@ -46,7 +46,7 @@ struct dlm_lock_params32 {
 	__u32 bastaddr;
 	__u32 lksb;
 	char lvb[DLM_USER_LVB_LEN];
-	char name[0];
+	char name[];
 };
 
 struct dlm_write_request32 {
-- 
2.25.0

