Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLACK,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45AD8C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 07:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B50C206F1
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 07:14:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbgFQHOX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 03:14:23 -0400
Received: from 107-174-27-60-host.colocrossing.com ([107.174.27.60]:43456 "EHLO
        ozlabs.ru" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1725846AbgFQHOX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 03:14:23 -0400
X-Greylist: delayed 573 seconds by postgrey-1.27 at vger.kernel.org; Wed, 17 Jun 2020 03:14:23 EDT
Received: from fstn1-p1.ozlabs.ibm.com (localhost [IPv6:::1])
        by ozlabs.ru (Postfix) with ESMTP id 82849AE8000E;
        Wed, 17 Jun 2020 03:02:25 -0400 (EDT)
From:   Alexey Kardashevskiy <aik@ozlabs.ru>
To:     linux-kernel@vger.kernel.org
Cc:     Alexey Kardashevskiy <aik@ozlabs.ru>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: [PATCH kernel] tty/vt: Do not warn when huge selection requested
Date:   Wed, 17 Jun 2020 17:04:44 +1000
Message-Id: <20200617070444.116704-1-aik@ozlabs.ru>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The tty TIOCL_SETSEL ioctl allocates a memory buffer big enough for text
selection area. The maximum allowed console size is
VC_RESIZE_MAXCOL * VC_RESIZE_MAXROW == 32767*32767 == ~1GB and typical
MAX_ORDER is set to allow allocations lot less than than (circa 16MB).

So it is quite possible to trigger huge allocation (and syzkaller just
did that) which is going to fail (which is fine) with a backtrace in
mm/page_alloc.c at WARN_ON_ONCE(!(gfp_mask & __GFP_NOWARN)) and
this may trigger panic (if panic_on_warn is enabled) and
leak kernel addresses to dmesg.

This passes __GFP_NOWARN to kmalloc_array to avoid unnecessary user-
triggered WARN_ON. Note that the error is not ignored and
the warning is still printed.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---

Hit this on ppc64 with 64K pages and MAX_ORDER=9 which (2**8)<<16 = 16MB.

---
 drivers/tty/vt/selection.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/vt/selection.c b/drivers/tty/vt/selection.c
index 31bb3647a99c..8e74654c1b27 100644
--- a/drivers/tty/vt/selection.c
+++ b/drivers/tty/vt/selection.c
@@ -193,7 +193,7 @@ static int vc_selection_store_chars(struct vc_data *vc, bool unicode)
 	/* Allocate a new buffer before freeing the old one ... */
 	/* chars can take up to 4 bytes with unicode */
 	bp = kmalloc_array((vc_sel.end - vc_sel.start) / 2 + 1, unicode ? 4 : 1,
-			   GFP_KERNEL);
+			   GFP_KERNEL | __GFP_NOWARN);
 	if (!bp) {
 		printk(KERN_WARNING "selection: kmalloc() failed\n");
 		clear_selection();
-- 
2.17.1

