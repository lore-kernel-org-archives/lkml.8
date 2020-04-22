Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98311C55185
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 15:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 735F120738
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 15:06:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbgDVPGI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 11:06:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:58098 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728039AbgDVPDH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 11:03:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4EC34AD0E;
        Wed, 22 Apr 2020 15:03:03 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 6F65D1E0E82; Wed, 22 Apr 2020 17:03:03 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 06/23] xarray: Explicitely set XA_FREE_MARK in __xa_cmpxchg()
Date:   Wed, 22 Apr 2020 17:02:39 +0200
Message-Id: <20200422150256.23473-7-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200422150256.23473-1-jack@suse.cz>
References: <20200422150256.23473-1-jack@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__xa_cmpxchg() relies on xas_store() to set XA_FREE_MARK when storing
NULL into xarray that has free tracking enabled. Make the setting of
XA_FREE_MARK explicit similarly as its clearing currently is.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 lib/xarray.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/lib/xarray.c b/lib/xarray.c
index 96be029412b2..a372c59e3914 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -1479,8 +1479,12 @@ void *__xa_cmpxchg(struct xarray *xa, unsigned long index,
 		curr = xas_load(&xas);
 		if (curr == old) {
 			xas_store(&xas, entry);
-			if (xa_track_free(xa) && entry && !curr)
-				xas_clear_mark(&xas, XA_FREE_MARK);
+			if (xa_track_free(xa)) {
+				if (entry && !curr)
+					xas_clear_mark(&xas, XA_FREE_MARK);
+				else if (!entry && curr)
+					xas_set_mark(&xas, XA_FREE_MARK);
+			}
 		}
 	} while (__xas_nomem(&xas, gfp));
 
-- 
2.16.4

