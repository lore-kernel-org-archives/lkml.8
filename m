Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5CDDC282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 22:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B37412082E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 22:01:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbgAJWBU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 17:01:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:51492 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727164AbgAJWBU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 17:01:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id DC557B2FC;
        Fri, 10 Jan 2020 22:01:16 +0000 (UTC)
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH] lib/rbtree: avoid pointless rb_node alignment
Date:   Fri, 10 Jan 2020 13:54:29 -0800
Message-Id: <20200110215429.30360-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that Linux no longer supports the CRIS architecture,
we can drop this fishy alignment. Apparently this was
need to prevent misalignments in struct address_space.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 include/linux/rbtree.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/rbtree.h b/include/linux/rbtree.h
index 1fd61a9af45c..7e4b14b485f7 100644
--- a/include/linux/rbtree.h
+++ b/include/linux/rbtree.h
@@ -25,8 +25,7 @@ struct rb_node {
 	unsigned long  __rb_parent_color;
 	struct rb_node *rb_right;
 	struct rb_node *rb_left;
-} __attribute__((aligned(sizeof(long))));
-    /* The alignment might seem pointless, but allegedly CRIS needs it */
+};
 
 struct rb_root {
 	struct rb_node *rb_node;
-- 
2.16.4

