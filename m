Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 089FCC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 20:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D79742074B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 20:15:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="S8TmZlwJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730827AbgFJUPg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 16:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730569AbgFJUNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 16:13:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0502AC008639;
        Wed, 10 Jun 2020 13:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=g1BN8ZEjBZSGzNik3H7y+eWzpa3p549rVRPP5tfDWW4=; b=S8TmZlwJGr4i53ZlyGiAARSx3B
        o/PTdqvC3Swsl/OTVTcOgVe3eSV6K/0lN7UW/J5JPqo+tAU8viOyJPIKIOu1hsqEeVXLnXrnUi2Vs
        YLJKG7xytHER10sJZqEc+TF9ikz4FxfiSvF3JS43qvLHLPlZ3caBAP88T39Gt9/lotHFCNCRWbwRZ
        yP+Q39vBRcNTIIwZfQUSvkyouf7jnoCZ/u2TFOE5fymJM/9gqbluTgEgio3WiJrQI6OqXs/LuecAX
        0oxXAbq9/a4ROH7pvpiQXLA3D209RsVrkiXL78R/X4E7CwcOcy1t67dxdH3a88p/G+B9aWnTMXHsf
        cCP91qEA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jj76a-0003XI-TB; Wed, 10 Jun 2020 20:13:48 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 40/51] mm: Avoid splitting THPs
Date:   Wed, 10 Jun 2020 13:13:34 -0700
Message-Id: <20200610201345.13273-41-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200610201345.13273-1-willy@infradead.org>
References: <20200610201345.13273-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

If the filesystem supports THPs, then do not split them before
removing them from the page cache; remove them as a unit.
---
 mm/vmscan.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 17934e03b3aa..0db62c1001f7 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1277,9 +1277,9 @@ static unsigned int shrink_page_list(struct list_head *page_list,
 				/* Adding to swap updated mapping */
 				mapping = page_mapping(page);
 			}
-		} else if (unlikely(PageTransHuge(page))) {
-			/* Split file THP */
-			if (split_huge_page_to_list(page, page_list))
+		} else if (PageTransHuge(page)) {
+			if ((!mapping || !mapping_thp_support(mapping)) &&
+			    split_huge_page_to_list(page, page_list))
 				goto keep_locked;
 		}
 
-- 
2.26.2

