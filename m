Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EECE6C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 00:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B982D206F5
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 00:17:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="wwO3l67s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729223AbgCaAQ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 20:16:59 -0400
Received: from gateway21.websitewelcome.com ([192.185.46.113]:24211 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729019AbgCaAQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 20:16:59 -0400
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway21.websitewelcome.com (Postfix) with ESMTP id E1516400CE90D
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 19:16:57 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id J4aPji2xEAGTXJ4aPj62h2; Mon, 30 Mar 2020 19:16:57 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=6j0N9LbHibVSnYloCANn6lCCp2LfdYmLR5aYJzfpMLI=; b=wwO3l67seXH4CQYrZYqAPWIK5o
        D/g3Xz1dTJfPpDDIUZHGTtDozF5hrSoj+pOlHIooKjQaMzfI8X294ZeKwwFf6Qi2XmqZC2zrJCoOf
        VXgUtkIQD7B9HDWvuVHSMCGOj2K754YA5Vbtc80B7xnL8gSzMOsbx6/jCBICF1TYFx0oKB8Y/qrnL
        +lkAagQgNqUCo8yzuGBk1kY/qIwIlVNYCWhshilbd4Rqm+jD3uyL4dldnPywDz1mu722HS95IOYI0
        mlDc7V/kHl/zjAI0iSWJU9kKGD99owH0frwSaX4gsGiVjZOz6EMmyN9TOcTpuIRQKkr14EQfdJ0zv
        LxYD7TEA==;
Received: from cablelink-189-218-116-241.hosts.intercable.net ([189.218.116.241]:34772 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1jJ4aO-000zm9-FS; Mon, 30 Mar 2020 19:16:56 -0500
Date:   Mon, 30 Mar 2020 19:20:40 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] objtool: check: Fix NULL pointer dereference
Message-ID: <20200331002040.GA11302@embeddedor>
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
X-Source-IP: 189.218.116.241
X-Source-L: No
X-Exim-ID: 1jJ4aO-000zm9-FS
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: cablelink-189-218-116-241.hosts.intercable.net (embeddedor) [189.218.116.241]:34772
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case func is null, there is a null pointer dereference at 2029:

2029                 WARN("%s uses BP as a scratch register",
2030                      func->name);

Fix this by null-checking func.

Addresses-Coverity-ID: 1492002 ("Dereference after null check")
Fixes: c705cecc8431 ("objtool: Track original function across branches")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 tools/objtool/check.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index e3bb76358148..182cc48fa892 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2025,7 +2025,7 @@ static int validate_return(struct symbol *func, struct instruction *insn, struct
 		return 1;
 	}
 
-	if (state->bp_scratch) {
+	if (func && state->bp_scratch) {
 		WARN("%s uses BP as a scratch register",
 		     func->name);
 		return 1;
-- 
2.26.0

