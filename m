Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7719DC54E7E
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 23:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DE9A21582
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 23:46:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729022AbgEIXqa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 19:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728797AbgEIXqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 19:46:02 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F34C05BD09;
        Sat,  9 May 2020 16:46:01 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jXZAO-004iSd-GE; Sat, 09 May 2020 23:46:00 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>
Subject: [PATCH 19/20] hfi1: get rid of pointless access_ok()
Date:   Sun, 10 May 2020 00:45:56 +0100
Message-Id: <20200509234557.1124086-19-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200509234557.1124086-1-viro@ZenIV.linux.org.uk>
References: <20200509234124.GM23230@ZenIV.linux.org.uk>
 <20200509234557.1124086-1-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

pin_user_pages_fast() doesn't need that from its caller.
NB: only reachable from ->ioctl(), and only under USER_DS

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/infiniband/hw/hfi1/user_exp_rcv.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/user_exp_rcv.c b/drivers/infiniband/hw/hfi1/user_exp_rcv.c
index 4da03f823474..f81ca20f4b69 100644
--- a/drivers/infiniband/hw/hfi1/user_exp_rcv.c
+++ b/drivers/infiniband/hw/hfi1/user_exp_rcv.c
@@ -206,13 +206,6 @@ static int pin_rcv_pages(struct hfi1_filedata *fd, struct tid_user_buf *tidbuf)
 		return -EINVAL;
 	}
 
-	/* Verify that access is OK for the user buffer */
-	if (!access_ok((void __user *)vaddr,
-		       npages * PAGE_SIZE)) {
-		dd_dev_err(dd, "Fail vaddr %p, %u pages, !access_ok\n",
-			   (void *)vaddr, npages);
-		return -EFAULT;
-	}
 	/* Allocate the array of struct page pointers needed for pinning */
 	pages = kcalloc(npages, sizeof(*pages), GFP_KERNEL);
 	if (!pages)
-- 
2.11.0

