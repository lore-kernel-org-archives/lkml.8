Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A38E6C3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 22:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AF9F208C3
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 22:42:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="sYfDK+07"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbgCBWmG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 17:42:06 -0500
Received: from gateway33.websitewelcome.com ([192.185.145.24]:40471 "EHLO
        gateway33.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726755AbgCBWmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 17:42:05 -0500
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway33.websitewelcome.com (Postfix) with ESMTP id 413F31F4371
        for <linux-kernel@vger.kernel.org>; Mon,  2 Mar 2020 16:42:01 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 8tlBjOjLvXVkQ8tlBjizBJ; Mon, 02 Mar 2020 16:42:01 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=+FgTF4phqPQ4ev03UWJ01rP2KoU5/XHfnR9gkSeBOIY=; b=sYfDK+070JjWhlFJJ9K6P3u3Nx
        jQ6q1CnoMZwikhHwcFTg/Cr/z1QvHKDPBgnE7I9k+X6yEu8UFrFaVqrhh1OJosylY6DEqW6fllWru
        lQFRbc3t79PRdrR/KRoZGUcwt/kdPk9gzUYZqDYKo5K2fHigNuNAzDnpUgGPsqo8jnmr66bJ2HkAq
        N0ED36f27/Smi+sKuWnzF25dI0fOLPAiM0IF/FpK5OAMCyIs2ZAk63eD8Jqfso9ZRzuLGjNe5uh+W
        y5vZwHfU1SeksgkJPNpl10+MsmaN1f44r8f+3z6fufuwTd634z8bZr/5S2JCEOvkSGt//eAp8tEz0
        qaecbRXQ==;
Received: from [201.166.169.236] (port=1308 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1j8tl9-000sUo-A4; Mon, 02 Mar 2020 16:41:59 -0600
Date:   Mon, 2 Mar 2020 16:45:01 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Peter Oberparleiter <oberpar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] gcov: gcc_3_4: Replace zero-length array with flexible-array
 member
Message-ID: <20200302224501.GA14175@embeddedor>
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
X-Exim-ID: 1j8tl9-000sUo-A4
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [201.166.169.236]:1308
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
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
 kernel/gcov/gcc_3_4.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/gcov/gcc_3_4.c b/kernel/gcov/gcc_3_4.c
index 801ee4b0b969..acb83558e5df 100644
--- a/kernel/gcov/gcc_3_4.c
+++ b/kernel/gcov/gcc_3_4.c
@@ -38,7 +38,7 @@ static struct gcov_info *gcov_info_head;
 struct gcov_fn_info {
 	unsigned int ident;
 	unsigned int checksum;
-	unsigned int n_ctrs[0];
+	unsigned int n_ctrs[];
 };
 
 /**
@@ -78,7 +78,7 @@ struct gcov_info {
 	unsigned int			n_functions;
 	const struct gcov_fn_info	*functions;
 	unsigned int			ctr_mask;
-	struct gcov_ctr_info		counts[0];
+	struct gcov_ctr_info		counts[];
 };
 
 /**
@@ -352,7 +352,7 @@ struct gcov_iterator {
 	unsigned int count;
 
 	int num_types;
-	struct type_info type_info[0];
+	struct type_info type_info[];
 };
 
 static struct gcov_fn_info *get_func(struct gcov_iterator *iter)
-- 
2.25.0

