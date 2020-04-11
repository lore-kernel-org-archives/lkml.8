Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21696C2BA2B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 12:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E09172084D
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 12:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586607681;
	bh=Or4Wyj8G7lBylczIfcUvXgxxcqlhFGadGh2+Le/CxVg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oDDmcRfzFtWTp0u5Ix5tM6xFi07ovIM30ZSO8J86bLBvTbLgRBZGIZZU0FDqAN1cl
	 xIFaPZG2cpjsEnv9eDeItynCerziKCmL+2pOzL5xHfNl4Gn8A9PT3N5mwZs6p8bPqc
	 4Gh8x8PZ/ZceSA81o6NqMcnh1fQ1b9T9di1YGEL0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728911AbgDKMVT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 08:21:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:57402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729141AbgDKMVN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 08:21:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D346D20644;
        Sat, 11 Apr 2020 12:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586607673;
        bh=Or4Wyj8G7lBylczIfcUvXgxxcqlhFGadGh2+Le/CxVg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SQXZJcJrbNhEJikXNzhwI3rOp6ocVJW6jPhyJMjpY2ybMRN6ePHWwJ3iIfOIfnpp6
         7g5RF4MGhFsgoCr2F5njEIs5aUwFOQnTSR6ay1ilCrbCv5i13VnHpiOtKYtLtj2NN0
         vU06vwfW+dTIBvYJg+Ect5521tovY1B8fYjmyVjw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+f317896aae32eb281a58@syzkaller.appspotmail.com,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Hou Tao <houtao1@huawei.com>,
        Richard Weinberger <richard@nod.at>
Subject: [PATCH 5.6 29/38] ubi: fastmap: Free unused fastmap anchor peb during detach
Date:   Sat, 11 Apr 2020 14:10:06 +0200
Message-Id: <20200411115502.888317353@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200411115459.324496182@linuxfoundation.org>
References: <20200411115459.324496182@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hou Tao <houtao1@huawei.com>

commit c16f39d14a7e0ec59881fbdb22ae494907534384 upstream.

When CONFIG_MTD_UBI_FASTMAP is enabled, fm_anchor will be assigned
a free PEB during ubi_wl_init() or ubi_update_fastmap(). However
if fastmap is not used or disabled on the MTD device, ubi_wl_entry
related with the PEB will not be freed during detach.

So Fix it by freeing the unused fastmap anchor during detach.

Fixes: f9c34bb52997 ("ubi: Fix producing anchor PEBs")
Reported-by: syzbot+f317896aae32eb281a58@syzkaller.appspotmail.com
Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Hou Tao <houtao1@huawei.com>
Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/ubi/fastmap-wl.c |   15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

--- a/drivers/mtd/ubi/fastmap-wl.c
+++ b/drivers/mtd/ubi/fastmap-wl.c
@@ -39,6 +39,13 @@ static struct ubi_wl_entry *find_anchor_
 	return victim;
 }
 
+static inline void return_unused_peb(struct ubi_device *ubi,
+				     struct ubi_wl_entry *e)
+{
+	wl_tree_add(e, &ubi->free);
+	ubi->free_count++;
+}
+
 /**
  * return_unused_pool_pebs - returns unused PEB to the free tree.
  * @ubi: UBI device description object
@@ -52,8 +59,7 @@ static void return_unused_pool_pebs(stru
 
 	for (i = pool->used; i < pool->size; i++) {
 		e = ubi->lookuptbl[pool->pebs[i]];
-		wl_tree_add(e, &ubi->free);
-		ubi->free_count++;
+		return_unused_peb(ubi, e);
 	}
 }
 
@@ -361,6 +367,11 @@ static void ubi_fastmap_close(struct ubi
 	return_unused_pool_pebs(ubi, &ubi->fm_pool);
 	return_unused_pool_pebs(ubi, &ubi->fm_wl_pool);
 
+	if (ubi->fm_anchor) {
+		return_unused_peb(ubi, ubi->fm_anchor);
+		ubi->fm_anchor = NULL;
+	}
+
 	if (ubi->fm) {
 		for (i = 0; i < ubi->fm->used_blocks; i++)
 			kfree(ubi->fm->e[i]);


