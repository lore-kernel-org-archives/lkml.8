Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 438E1C433E5
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 20:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 272E62074B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 20:11:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728684AbgGQULy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 16:11:54 -0400
Received: from mailex.mailcore.me ([94.136.40.146]:38962 "EHLO
        mailex.mailcore.me" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbgGQULy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 16:11:54 -0400
X-Greylist: delayed 940 seconds by postgrey-1.27 at vger.kernel.org; Fri, 17 Jul 2020 16:11:53 EDT
Received: from 82-69-79-175.dsl.in-addr.zen.co.uk ([82.69.79.175] helo=phoenix.fritz.box)
        by smtp03.mailcore.me with esmtpa (Exim 4.92.3)
        (envelope-from <phillip@squashfs.org.uk>)
        id 1jwWSo-0006Yi-Bg; Fri, 17 Jul 2020 20:56:10 +0100
From:   Phillip Lougher <phillip@squashfs.org.uk>
To:     linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, pliard@google.com, hch@lst.de,
        adrien+dev@schischi.me, groeck@chromium.org, drosen@google.com,
        Phillip Lougher <phillip@squashfs.org.uk>,
        Bernd Amend <bernd.amend@gmail.com>
Subject: [PATCH] squashfs: fix length field overlap check in metadata reading
Date:   Fri, 17 Jul 2020 20:55:36 +0100
Message-Id: <20200717195536.16069-1-phillip@squashfs.org.uk>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailcore-Auth: 439913985
X-Mailcore-Domain: 1686784
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a regression introduced by the "migrate from ll_rw_block usage
to BIO" patch.

Squashfs packs structures on byte boundaries, and due to that
the length field (of the metadata block) may not be fully in
the current block.  The new code rewrote and introduced a faulty
check for that edge case.

Reported-by: Bernd Amend <bernd.amend@gmail.com>
Signed-off-by: Phillip Lougher <phillip@squashfs.org.uk>
---
 fs/squashfs/block.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/squashfs/block.c b/fs/squashfs/block.c
index 64f61330564a..76bb1c846845 100644
--- a/fs/squashfs/block.c
+++ b/fs/squashfs/block.c
@@ -175,7 +175,7 @@ int squashfs_read_data(struct super_block *sb, u64 index, int length,
 		/* Extract the length of the metadata block */
 		data = page_address(bvec->bv_page) + bvec->bv_offset;
 		length = data[offset];
-		if (offset <= bvec->bv_len - 1) {
+		if (offset < bvec->bv_len - 1) {
 			length |= data[offset + 1] << 8;
 		} else {
 			if (WARN_ON_ONCE(!bio_next_segment(bio, &iter_all))) {
-- 
2.20.1

