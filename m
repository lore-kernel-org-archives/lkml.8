Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87226C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 22:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E4D620CC7
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 22:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592432535;
	bh=IXfRB1ln79N+EByGvcDZLtyLTc8uIB4owydFsSPvdn4=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=ogjtawup4x+NGtBbtDrvYbn5oAB8E39Bw44bfnRkE0GD77Rl5i0HnIaOfn8NQ7Kps
	 iu/IzmrKgTtLnB17d+BhQBLvSTLBZ6S587M1nJXTW5fBxPsjiqHk7X/SbMyfJODmWj
	 mVzWoNWODy5SOPLvAI/a9SSa5uJ5XdhJMdRN325Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbgFQWWN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 18:22:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:58544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726909AbgFQWWN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 18:22:13 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6DF02083B;
        Wed, 17 Jun 2020 22:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592432533;
        bh=IXfRB1ln79N+EByGvcDZLtyLTc8uIB4owydFsSPvdn4=;
        h=Date:From:To:Cc:Subject:From;
        b=uQ/seVr9NqlnoEZpYrrDnKyihLCV1NpDqkPfISGAoZYQOTULsJr86NzD2lqElXJ7T
         2Zum6blhRm7Y1SwcwF+vGdvbCjkqpQpOnrtSCdSNI5lgm/cCnzT8DhJXg8sI4G9oaN
         UgcFLJ7dfXMXROnRC88wxorAfsDSYFZELCBNot38=
Date:   Wed, 17 Jun 2020 17:27:33 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Coly Li <colyli@suse.de>,
        Kent Overstreet <kent.overstreet@gmail.com>
Cc:     linux-bcache@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH][next] bcache: Use struct_size() in kzalloc()
Message-ID: <20200617222733.GA24156@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make use of the struct_size() helper instead of an open-coded version
in order to avoid any potential type mistakes.

This code was detected with the help of Coccinelle and, audited and
fixed manually.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/md/bcache/writeback.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/md/bcache/writeback.c b/drivers/md/bcache/writeback.c
index 1cf1e5016cb9..c0db3c860179 100644
--- a/drivers/md/bcache/writeback.c
+++ b/drivers/md/bcache/writeback.c
@@ -459,10 +459,8 @@ static void read_dirty(struct cached_dev *dc)
 		for (i = 0; i < nk; i++) {
 			w = keys[i];
 
-			io = kzalloc(sizeof(struct dirty_io) +
-				     sizeof(struct bio_vec) *
-				     DIV_ROUND_UP(KEY_SIZE(&w->key),
-						  PAGE_SECTORS),
+			io = kzalloc(struct_size(io, bio.bi_inline_vecs,
+						DIV_ROUND_UP(KEY_SIZE(&w->key), PAGE_SECTORS)),
 				     GFP_KERNEL);
 			if (!io)
 				goto err;
-- 
2.27.0

