Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC10C5518B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 15:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 547582054F
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 15:03:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728201AbgDVPDN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 11:03:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:58128 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726002AbgDVPDI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 11:03:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 66ADEAC90;
        Wed, 22 Apr 2020 15:03:03 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id A2D331E0EB9; Wed, 22 Apr 2020 17:03:03 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 18/23] idr: Convert xas_store() to xas_store_noinit()
Date:   Wed, 22 Apr 2020 17:02:51 +0200
Message-Id: <20200422150256.23473-19-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200422150256.23473-1-jack@suse.cz>
References: <20200422150256.23473-1-jack@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All remaining users of xas_store() store non-NULL entries so xas_store()
and xas_store_noinit() are equivalent. Replace xas_store() with
xas_store_noinit().

Signed-off-by: Jan Kara <jack@suse.cz>
---
 lib/idr.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/idr.c b/lib/idr.c
index 4ee06bc7208a..afd171077901 100644
--- a/lib/idr.c
+++ b/lib/idr.c
@@ -408,7 +408,7 @@ int ida_alloc_range(struct ida *ida, unsigned int min, unsigned int max,
 				goto nospc;
 			if (bit < BITS_PER_XA_VALUE) {
 				tmp |= 1UL << bit;
-				xas_store(&xas, xa_mk_value(tmp));
+				xas_store_noinit(&xas, xa_mk_value(tmp));
 				goto out;
 			}
 		}
@@ -418,7 +418,7 @@ int ida_alloc_range(struct ida *ida, unsigned int min, unsigned int max,
 		if (!bitmap)
 			goto alloc;
 		bitmap->bitmap[0] = tmp;
-		xas_store(&xas, bitmap);
+		xas_store_noinit(&xas, bitmap);
 		if (xas_error(&xas)) {
 			bitmap->bitmap[0] = 0;
 			goto out;
@@ -446,7 +446,7 @@ int ida_alloc_range(struct ida *ida, unsigned int min, unsigned int max,
 				goto alloc;
 			__set_bit(bit, bitmap->bitmap);
 		}
-		xas_store(&xas, bitmap);
+		xas_store_noinit(&xas, bitmap);
 	}
 out:
 	xas_unlock_irqrestore(&xas, flags);
@@ -502,7 +502,7 @@ void ida_free(struct ida *ida, unsigned int id)
 		v &= ~(1UL << bit);
 		if (!v)
 			goto delete;
-		xas_store(&xas, xa_mk_value(v));
+		xas_store_noinit(&xas, xa_mk_value(v));
 	} else {
 		if (!test_bit(bit, bitmap->bitmap))
 			goto err;
-- 
2.16.4

