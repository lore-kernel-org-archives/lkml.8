Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BA74C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 03:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26F4720644
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 03:22:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cVuZRDYs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbgFODWX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jun 2020 23:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728034AbgFODWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 23:22:23 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33951C061A0E;
        Sun, 14 Jun 2020 20:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=WsF94qVVL3zbAw5XLTLmD0BKXAsD4rIRKIfvjwWdoZc=; b=cVuZRDYsYTZnjFwLT/9HNauGZJ
        YiIK5bEvH2swlOTiY82gp41LRsMwpOnc9tyRKD8rwSWFvzFR9M8i+ynMBjw5c+4E9C6sfBGOfREBO
        MUNJdBCg9uMgKSmprqVHBxYTes9vKK92jkxMjLd/s90facgTOrWMSyDDDfJaji5NUMBNhvt5xUuy3
        /ht4q+LgiNDO9UxR61GUSVktj3jleMPtgT8RImeHrglH4c4pz8P2BfSmrpoI0QbioDGA7/lgKvmdv
        3kPMzqOsk4Jv9u7iG8mFyv42Dg5xcZS2B6HYlhKqwkCo1K/IuDqkVqi4lyvcgxHbhaKPAM+dIw+zf
        0JDed3ww==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jkfhU-0000Ap-S8; Mon, 15 Jun 2020 03:22:20 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Michel Lespinasse <walken@google.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] Documentation: fix filesystems/locking.rst malformed table
 warnings
Message-ID: <12c2afd1-2dcf-2ea0-02aa-bc2759729c77@infradead.org>
Date:   Sun, 14 Jun 2020 20:22:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix Sphinx malformed table warnings in filesystems/locking.rst:

lnx-58-rc1/Documentation/filesystems/locking.rst:443: WARNING: Malformed table.
Text in column margin in table line 8.

lnx-58-rc1/Documentation/filesystems/locking.rst:620: WARNING: Malformed table.
Text in column margin in table line 2.

Fixes: ec23eb54fbc7 ("docs: fs: convert docs without extension to ReST")
Fixes: c1e8d7c6a7a6 ("mmap locking API: convert mmap_sem comments")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: Michel Lespinasse <walken@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 Documentation/filesystems/locking.rst |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- lnx-58-rc1.orig/Documentation/filesystems/locking.rst
+++ lnx-58-rc1/Documentation/filesystems/locking.rst
@@ -433,15 +433,15 @@ prototypes::
 
 locking rules:
 
-==========		=============	=================	=========
+======================	=============	=================	=========
 ops			inode->i_lock	blocked_lock_lock	may block
-==========		=============	=================	=========
+======================	=============	=================	=========
 lm_notify:		yes		yes			no
 lm_grant:		no		no			no
 lm_break:		yes		no			no
 lm_change		yes		no			no
 lm_breaker_owns_lease:	no		no			no
-==========		=============	=================	=========
+======================	=============	=================	=========
 
 buffer_head
 ===========
@@ -616,9 +616,9 @@ prototypes::
 
 locking rules:
 
-=============	========	===========================
+=============	=========	===========================
 ops		mmap_lock	PageLocked(page)
-=============	========	===========================
+=============	=========	===========================
 open:		yes
 close:		yes
 fault:		yes		can return with page locked
@@ -626,7 +626,7 @@ map_pages:	yes
 page_mkwrite:	yes		can return with page locked
 pfn_mkwrite:	yes
 access:		yes
-=============	========	===========================
+=============	=========	===========================
 
 ->fault() is called when a previously not present pte is about
 to be faulted in. The filesystem must find and return the page associated

