Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD3AC38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 18:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C86820575
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 18:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588877873;
	bh=mzjCxewRj9P2nva9AGQCzVblWiicOrzlTnaX6AyDD8k=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=0w8K0pg70/7kLdeX9H0eyawUWB/py5sT/aIX7aFnFgbgz4VXbiHWSTOp5rpPfwwTI
	 xZ8qRs1PKX9oRhJDn3qqAWIDbOUZIbpKBsrdd4h+Mhhbz+jngRIVdXGCVCIhs1BaWa
	 eUJjLWvxi5zYXAUp7VzAtCPE2wqmvWZO4Ofn6v1Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728518AbgEGS5w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 14:57:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:59178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726926AbgEGS5u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 14:57:50 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EAA9820575;
        Thu,  7 May 2020 18:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588877870;
        bh=mzjCxewRj9P2nva9AGQCzVblWiicOrzlTnaX6AyDD8k=;
        h=Date:From:To:Cc:Subject:From;
        b=J1oCEdjxhnYVugeeMwUbT4+O0jX0WrjBTQ8YcTl/+gDSvokcEgA72t9lJ+g/wDxdg
         43Ply6JSMo2/bUCpngLE2KYS6G8hqsjPq70xqLs1z5yzESFL7liVOWoDgEbwEMrk7k
         AAIcLS1WXPZnKBuGhmIELfedZeyK+Aog6EXjRR7I=
Date:   Thu, 7 May 2020 14:02:16 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ipv6: Replace zero-length array with flexible-array
Message-ID: <20200507190216.GA15407@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
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

sizeof(flexible-array-member) triggers a warning because flexible array
members have incomplete type[1]. There are some instances of code in
which the sizeof operator is being incorrectly/erroneously applied to
zero-length arrays and the result is zero. Such instances may be hiding
some bugs. So, this work (flexible-array member conversions) will also
help to get completely rid of those sorts of issues.

This issue was found with the help of Coccinelle.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 include/net/if_inet6.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/if_inet6.h b/include/net/if_inet6.h
index a01981d7108f..514dd6e423b1 100644
--- a/include/net/if_inet6.h
+++ b/include/net/if_inet6.h
@@ -78,7 +78,7 @@ struct inet6_ifaddr {
 struct ip6_sf_socklist {
 	unsigned int		sl_max;
 	unsigned int		sl_count;
-	struct in6_addr		sl_addr[0];
+	struct in6_addr		sl_addr[];
 };
 
 #define IP6_SFLSIZE(count)	(sizeof(struct ip6_sf_socklist) + \

