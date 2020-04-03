Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA56C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 15:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 595922073B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 15:33:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sd3J6Bhi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404311AbgDCPdY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 11:33:24 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41044 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728154AbgDCPdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 11:33:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=/wD04Zs0Zu+DHCnPzKAb1MTMrDvxIvKHCbvtzes7Nlg=; b=sd3J6BhipqPEkgeH3vUec5+hY6
        lZe3nQRUBNwd7i8CKYaBRfH9iWfoUhvKNcNeyJW1lXCFO0Vl7XOiJILg5YqVYC4UR6MkM4Pe1ocK8
        t7inLox5cC6ZbAyk+Y/KNTZ8nl/ZhPsle9ypxkEEr/6LFYQy7ZrkdXay0xQ7ZHqgQN7ITJTicWsPL
        f245p73cUomzZsHavbJe9JvVmyuFSa3ZXape7loSS1WEZ/8WOZNw0lJzWt/0h/itkVfdbShhDV3Yb
        fS9wk18ySsvl0VeaA6ReT7f9MDMeuKzorCBeW75H+d5hoJzxhAZou1Em4lcHMBqrU0lmL/Nr+LaOz
        MBdPiPPg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jKOJv-0001kw-Iz; Fri, 03 Apr 2020 15:33:23 +0000
Date:   Fri, 3 Apr 2020 08:33:23 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [RFC] Renaming page_offset() to page_pos()
Message-ID: <20200403153323.GQ21484@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without looking at the source, can you tell me what page_offset() does?

At least one regular contributor thought it meant the pgoff_t of this
page within the file.  It's actually the byte offset of this page into
the file.

We have a perfectly good name for byte offset into the file --
file->f_pos.  So I propose renaming it to page_pos().  To minimise
disruption to other development, I'm going to send Linus a pull request
at the end of the merge window with the results of this coccinelle script:

@@ expression a; @@
-       page_offset(a)
+       page_pos(a)

I've reviewed the output and the only slight weirdness is an extra space
in casts:

                btrfs_warn(BTRFS_I(page->mapping->host)->root->fs_info,
                           "page private not zero on page %llu",
-                          (unsigned long long)page_offset(page));
+                          (unsigned long long) page_pos(page));

Sometimes Coccinelle fixes the surrounding whitespace to be better
than it currently is:

-               ow->bv[i].bv_len = min(page_offset(ow->pages[i]) + PAGE_SIZE,
-                   ow->off + ow->len) -
-                   max(ow->off, page_offset(ow->pages[i]));
+               ow->bv[i].bv_len = min(page_pos(ow->pages[i]) + PAGE_SIZE,
+                                      ow->off + ow->len) -
+                   max(ow->off, page_pos(ow->pages[i]));

(it's still bad, but it's an improvement)

Any objections?  Anyone got a better name than page_pos()?
