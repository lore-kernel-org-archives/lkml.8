Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EAC6C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 23:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 417CC2075F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 23:58:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437968AbgE1X6s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 19:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437857AbgE1X63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 19:58:29 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2546DC08C5C7;
        Thu, 28 May 2020 16:58:29 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jeSPr-00HE7k-Lz; Thu, 28 May 2020 23:58:27 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/2] pstore: switch to copy_from_user()
Date:   Fri, 29 May 2020 00:58:27 +0100
Message-Id: <20200528235827.4105826-2-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200528235827.4105826-1-viro@ZenIV.linux.org.uk>
References: <20200528235752.GU23230@ZenIV.linux.org.uk>
 <20200528235827.4105826-1-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

don't bother trying to do bulk access_ok()

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/pstore/ram_core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/pstore/ram_core.c b/fs/pstore/ram_core.c
index c917c191e78c..aa8e0b65ff1a 100644
--- a/fs/pstore/ram_core.c
+++ b/fs/pstore/ram_core.c
@@ -283,7 +283,7 @@ static int notrace persistent_ram_update_user(struct persistent_ram_zone *prz,
 	const void __user *s, unsigned int start, unsigned int count)
 {
 	struct persistent_ram_buffer *buffer = prz->buffer;
-	int ret = unlikely(__copy_from_user(buffer->data + start, s, count)) ?
+	int ret = unlikely(copy_from_user(buffer->data + start, s, count)) ?
 		-EFAULT : 0;
 	persistent_ram_update_ecc(prz, start, count);
 	return ret;
@@ -348,8 +348,6 @@ int notrace persistent_ram_write_user(struct persistent_ram_zone *prz,
 	int rem, ret = 0, c = count;
 	size_t start;
 
-	if (unlikely(!access_ok(s, count)))
-		return -EFAULT;
 	if (unlikely(c > prz->buffer_size)) {
 		s += c - prz->buffer_size;
 		c = prz->buffer_size;
-- 
2.11.0

