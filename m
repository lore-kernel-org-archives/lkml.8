Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ADE1C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 23:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BA3F20717
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 23:37:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PT6BqZ6w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728620AbgGQXhd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 19:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbgGQXhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 19:37:32 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41EEFC0619D2;
        Fri, 17 Jul 2020 16:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Cc:To:Subject:From:Sender:Reply-To:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=Lsov2SASAuhjCO4jqEzip+ptJj6UaMBIGXq3ZYZ7r/g=; b=PT6BqZ6w6lTqw6TorsvKre0VNW
        ejwXPkvOBxMRZeOIrDhbnqnBm/C8w5kqqMULxWZ7vFs4vjDXUqzchCePkzHwRAAl5f3QMhiFUF2cY
        T2AJrOjeRWZWV6ohVuGWm2SExrS46b72p3/ED129Uh5bA0CFzSorRPRLVK+N9mW0jxVNR+SJ1eFkE
        roU0xg4tF1qKLWlTr3Ug7tS0kBJLw/94XbYan+1JdcDVj3Rxk+F3BfS2XuBUcYmNAcgBtnrZGXJpM
        MGjOGkJSRBISmX15vZ7BA/eBiN8w8ffJiIfsQKqtozQghtO1R8l47Lxye6lNJuXuJuTlS4kXYcL0p
        urU8iCFg==;
Received: from [2601:1c0:6280:3f0::19c2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jwZuz-0006ah-0J; Fri, 17 Jul 2020 23:37:29 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] rhashtable: drop duplicated word in <linux/rhashtable.h>
To:     LKML <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc:     Thomas Graf <tgraf@suug.ch>,
        Herbert Xu <herbert@gondor.apana.org.au>
Message-ID: <392beaa8-f240-70b5-b04d-3be910ef68a3@infradead.org>
Date:   Fri, 17 Jul 2020 16:37:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Drop the doubled word "be" in a comment.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Thomas Graf <tgraf@suug.ch>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: netdev@vger.kernel.org
---
 include/linux/rhashtable.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200714.orig/include/linux/rhashtable.h
+++ linux-next-20200714/include/linux/rhashtable.h
@@ -33,7 +33,7 @@
  * of two or more hash tables when the rhashtable is being resized.
  * The end of the chain is marked with a special nulls marks which has
  * the least significant bit set but otherwise stores the address of
- * the hash bucket.  This allows us to be be sure we've found the end
+ * the hash bucket.  This allows us to be sure we've found the end
  * of the right list.
  * The value stored in the hash bucket has BIT(0) used as a lock bit.
  * This bit must be atomically set before any changes are made to

