Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F6B8C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 06:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D4982072C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 06:25:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="S48PXV5r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbgEVGZn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 02:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726578AbgEVGZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 02:25:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01ED7C061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 23:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=QwhmqLhc+bv642fUxaOi43N+DIlQspHRNV2gxfTzFoU=; b=S48PXV5rOEPqzORBMrAaEfqt6d
        PqxUwtNVO/40WKGpTkyGtkQ+Lj9S4k+xeB5rdn6cVfd5kH1Jk4H5xwXh0Wdgu/Ivi4EXIlg2jLp33
        402QXoz7zSrgn4jxyl1p0FBp8+0kYKNfo6aG2mCODLu+OVoM/p56MdhKEueTbjTTKABlG84RyxSuH
        YUOM0TchSmM9Br+gVK70GBYn6b+3qIfr7iD2hPEuRpB9TLxnWxMZjeyXT5Yo9QGggSrthxRCtsP9D
        9ARPgcT565wEApcQ7QI5dO9Ve/HAlvV9tyjseoc9/Phum011rmIRlmc31XDFVbLrYWGCFQHMJnnf8
        DTkUD0zQ==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jc17d-00040o-CK; Fri, 22 May 2020 06:25:33 +0000
To:     LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] mm: swapfile: fix /proc/swaps heading and Size/Used/Priority
 alignment
Message-ID: <c0ffb41a-81ac-ddfa-d452-a9229ecc0387@infradead.org>
Date:   Thu, 21 May 2020 23:25:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix the heading and Size/Used/Priority field alignments in
/proc/swaps. If the Size and/or Used value is >= 10000000 (8 bytes),
then the alignment by using tab characters is broken.

This patch maintains the use of tabs for alignment. If spaces
are preferred, we can just use a Field Width specifier for the
bytes and inuse fields. That way those fields don't have to be
a multiple of 8 bytes in width. E.g., with a field width of 12,
both Size and Used would always fit on the first line of an
80-column wide terminal (only Priority would be on the second line).

There are actually 2 problems: heading alignment and field width.
On an xterm, if Used is 7 bytes in length, the tab does nothing, and
the display is like this, with no space/tab between the Used and
Priority fields. (ugh)

Filename				Type		Size	Used	Priority
/dev/sda8                               partition	16779260	2023012-1

To be clear, if one does 'cat /proc/swaps >/tmp/proc.swaps', it does
look different, like so:

Filename				Type		Size	Used	Priority
/dev/sda8                               partition	16779260	2086988	-1

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: linux-mm@kvack.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 mm/swapfile.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

--- linux-next-20200521.orig/mm/swapfile.c
+++ linux-next-20200521/mm/swapfile.c
@@ -2753,20 +2753,24 @@ static int swap_show(struct seq_file *sw
 	struct swap_info_struct *si = v;
 	struct file *file;
 	int len;
+	unsigned int bytes, inuse;
 
 	if (si == SEQ_START_TOKEN) {
-		seq_puts(swap,"Filename\t\t\t\tType\t\tSize\tUsed\tPriority\n");
+		seq_puts(swap,"Filename\t\t\t\tType\t\tSize\t\tUsed\t\tPriority\n");
 		return 0;
 	}
 
+	bytes = si->pages << (PAGE_SHIFT - 10);
+	inuse = si->inuse_pages << (PAGE_SHIFT - 10);
+
 	file = si->swap_file;
 	len = seq_file_path(swap, file, " \t\n\\");
-	seq_printf(swap, "%*s%s\t%u\t%u\t%d\n",
+	seq_printf(swap, "%*s%s\t%u\t%s%u\t%s%d\n",
 			len < 40 ? 40 - len : 1, " ",
 			S_ISBLK(file_inode(file)->i_mode) ?
 				"partition" : "file\t",
-			si->pages << (PAGE_SHIFT - 10),
-			si->inuse_pages << (PAGE_SHIFT - 10),
+			bytes, bytes < 10000000 ? "\t" : "",
+			inuse, inuse < 10000000 ? "\t" : "",
 			si->prio);
 	return 0;
 }


