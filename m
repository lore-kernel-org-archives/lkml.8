Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC15C35242
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 20:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59DB920659
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 20:51:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="XOgfaAVB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728921AbgBKUvY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 15:51:24 -0500
Received: from gateway33.websitewelcome.com ([192.185.145.23]:45830 "EHLO
        gateway33.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727786AbgBKUvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 15:51:23 -0500
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway33.websitewelcome.com (Postfix) with ESMTP id C48C299ABDC
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 14:51:22 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 1cV8jIabPXVkQ1cV8jgvDE; Tue, 11 Feb 2020 14:51:22 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=jrhREslNRp9I3XLIf7+FCkpvJMag3xowhs8nHJz6VDo=; b=XOgfaAVB1vZH+Fel1K2p6eC+T/
        4ML05d0RHpy5WRNdnf33iJCmIezqNFBLDgFr53bZA3eGy2YmlgOXwV//wWRrJVOAUDCsN3+EjBspZ
        dkBPDBAMkjm/xPAIetWrT1XTSq+Poe9SXYha8HageD/LVW90v0wOzIUfwgPH7+lZgmqI/ZVd2v/Dv
        8WmGevfjhOHxYGJ0GL1hKgjjMLzrzDTOmkfhpWn1ENk0/ahaTLdYVvjl7M8Y1JZYfBLRRNkBoAKCf
        12VkkIpuiM92RJEXmLQOD+ie3hQorSTmozqGNRry+o58wWzpOnrDihrTu6vE5Vec8FCsPazaFpk9F
        HJTWEwOw==;
Received: from [200.68.140.36] (port=15013 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1j1cV7-001wuz-5G; Tue, 11 Feb 2020 14:51:21 -0600
Date:   Tue, 11 Feb 2020 14:53:56 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Jiri Pirko <jiri@mellanox.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] lib: objagg: Replace zero-length arrays with flexible-array
 member
Message-ID: <20200211205356.GA23101@embeddedor>
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
X-Source-IP: 200.68.140.36
X-Source-L: No
X-Exim-ID: 1j1cV7-001wuz-5G
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [200.68.140.36]:15013
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 43
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
inadvertenly introduced[3] to the codebase from now on.

This issue was found with the help of Coccinelle.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 lib/objagg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/objagg.c b/lib/objagg.c
index 576be22e86de..668a2c0a88ac 100644
--- a/lib/objagg.c
+++ b/lib/objagg.c
@@ -28,7 +28,7 @@ struct objagg_hints_node {
 	struct objagg_hints_node *parent;
 	unsigned int root_id;
 	struct objagg_obj_stats_info stats_info;
-	unsigned long obj[0];
+	unsigned long obj[];
 };
 
 static struct objagg_hints_node *
@@ -66,7 +66,7 @@ struct objagg_obj {
 				* including nested objects
 				*/
 	struct objagg_obj_stats stats;
-	unsigned long obj[0];
+	unsigned long obj[];
 };
 
 static unsigned int objagg_obj_ref_inc(struct objagg_obj *objagg_obj)
-- 
2.25.0

