Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C96C5C2D0EC
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 19:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91F752072A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 19:00:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbgDGTAl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 15:00:41 -0400
Received: from smtp07.smtpout.orange.fr ([80.12.242.129]:23062 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbgDGTAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 15:00:41 -0400
Received: from localhost.localdomain ([93.22.37.82])
        by mwinf5d42 with ME
        id Pv0c2200b1mLNr903v0dWk; Tue, 07 Apr 2020 21:00:38 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 07 Apr 2020 21:00:38 +0200
X-ME-IP: 93.22.37.82
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     apw@canonical.com, joe@perches.com
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] checkpatch: Fix a typo in the regex for $allocFunctions
Date:   Tue,  7 Apr 2020 21:00:29 +0200
Message-Id: <20200407190029.892-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here, we look for function such as 'netdev_alloc_skb_ip_align', so a '_'
is missing in the regex.

To make sure:
   grep -r --include=*.c skbip_a * | wc   ==>   0 results
   grep -r --include=*.c skb_ip_a * | wc  ==> 112 results

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 scripts/checkpatch.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 529c892722b9..c392ab8ea12e 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -479,7 +479,7 @@ our $allocFunctions = qr{(?x:
 		(?:kv|k|v)[czm]alloc(?:_node|_array)? |
 		kstrdup(?:_const)? |
 		kmemdup(?:_nul)?) |
-	(?:\w+)?alloc_skb(?:ip_align)? |
+	(?:\w+)?alloc_skb(?:_ip_align)? |
 				# dev_alloc_skb/netdev_alloc_skb, et al
 	dma_alloc_coherent
 )};
-- 
2.20.1

