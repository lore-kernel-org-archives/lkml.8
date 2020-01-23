Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB1EC2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 16:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21E5B21734
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 16:23:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="p3qDpTJn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727523AbgAWQXp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 11:23:45 -0500
Received: from gateway34.websitewelcome.com ([192.185.148.140]:17810 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726605AbgAWQXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 11:23:45 -0500
X-Greylist: delayed 1473 seconds by postgrey-1.27 at vger.kernel.org; Thu, 23 Jan 2020 11:23:45 EST
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway34.websitewelcome.com (Postfix) with ESMTP id C9E89E5658
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 09:59:11 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id uesxiuFDa8a1puesxiARFZ; Thu, 23 Jan 2020 09:59:11 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=oP2QJvbUq8Jm9J2za3HLAy5fshYGIjNaVrWjjbn3HQw=; b=p3qDpTJnvChXZ9NJusKIyrLob7
        nraX5XpdxgJZqszfFNjJVh97NsbHb822++kTrZRp6Wrih3C4h7xy/HnpsPerec7l1pVJRJ8bsHOjE
        m4t/EAnixNxWz+qkMVelDIiv1McuRlmtyY6x55SVY5rZTV6XyrfpRMsVummhF8oPu9XGWBvKsfgt0
        Sw9FPlYWL/FJDpty70a6CqNEl4rOxeqw55lCBY11nyHXDfAFUBsJOHwlAUSKF30iBIEQ4UnBPNg/6
        BcPDR9JlKnWCYwF7Y1GVhXcg+WZSVVDD2Pt0AhQfNR4o6cxT8ipzjYtvU3W6rhROuQrob2oLhg6gm
        tj72qVqQ==;
Received: from [189.152.234.38] (port=58026 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1iuesw-001riw-CF; Thu, 23 Jan 2020 09:59:10 -0600
Date:   Thu, 23 Jan 2020 10:01:15 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <adech.fo@gmail.com>
Cc:     kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] lib/test_kasan.c: Fix memory leak in
 kmalloc_oob_krealloc_more()
Message-ID: <20200123160115.GA4202@embeddedor>
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
X-Source-IP: 189.152.234.38
X-Source-L: No
X-Exim-ID: 1iuesw-001riw-CF
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.152.234.38]:58026
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 7
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case memory resources for _ptr2_ were allocated, release them
before return.

Notice that in case _ptr1_ happens to be NULL, krealloc() behaves
exactly like kmalloc().

Addresses-Coverity-ID: 1490594 ("Resource leak")
Fixes: 3f15801cdc23 ("lib: add kasan test module")
Cc: stable@vger.kernel.org
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 lib/test_kasan.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/test_kasan.c b/lib/test_kasan.c
index 328d33beae36..3872d250ed2c 100644
--- a/lib/test_kasan.c
+++ b/lib/test_kasan.c
@@ -158,6 +158,7 @@ static noinline void __init kmalloc_oob_krealloc_more(void)
 	if (!ptr1 || !ptr2) {
 		pr_err("Allocation failed\n");
 		kfree(ptr1);
+		kfree(ptr2);
 		return;
 	}
 
-- 
2.25.0

