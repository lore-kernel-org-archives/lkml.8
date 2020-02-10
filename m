Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84473C352A5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E1B72051A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581338982;
	bh=gZjRPmNca0NHA9D6FXoRdzdcoMOP0o5FB1DbHMFVvHY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pNu6X552V8rYXO4FTU1D+ksepYkHe1IZ8HDM9EtUF0tOCJy40y8Hla29tJhSw3MMO
	 YtJhHXQLek8laUBMiLJkYKPxLqQOLDH1AB3pGlqlVWrV6Unc4Olwm+UmD8skPaLICs
	 cve9ww1JHCMKXSzy7EQ86BDaOFFLTJnRYhSVhWgo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730488AbgBJMpB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 07:45:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:41618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729148AbgBJMks (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:40:48 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABEE120842;
        Mon, 10 Feb 2020 12:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338447;
        bh=gZjRPmNca0NHA9D6FXoRdzdcoMOP0o5FB1DbHMFVvHY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=trpqj4iGvxexztGIVGUiYjp5nGdXw29aTFBO4tKp4SiKP0VrlccN9fta9dj3nVn/O
         Z0xY1pI5+U5QJgu+sbpYPqEo2l6fCGtMv3zrDXE3mBNua3H5ELguHCVe7fnYS6Bw1q
         i5/Uutcbk65ptpsSgajNQEmsvsTUz+Eu/8bLPvXo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Benjamin Coddington <bcodding@redhat.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>
Subject: [PATCH 5.5 190/367] NFS: Directory page cache pages need to be locked when read
Date:   Mon, 10 Feb 2020 04:31:43 -0800
Message-Id: <20200210122442.153060068@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122423.695146547@linuxfoundation.org>
References: <20200210122423.695146547@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Trond Myklebust <trondmy@gmail.com>

commit 114de38225d9b300f027e2aec9afbb6e0def154b upstream.

When a NFS directory page cache page is removed from the page cache,
its contents are freed through a call to nfs_readdir_clear_array().
To prevent the removal of the page cache entry until after we've
finished reading it, we must take the page lock.

Fixes: 11de3b11e08c ("NFS: Fix a memory leak in nfs_readdir")
Cc: stable@vger.kernel.org # v2.6.37+
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Reviewed-by: Benjamin Coddington <bcodding@redhat.com>
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/nfs/dir.c |   30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -702,8 +702,6 @@ int nfs_readdir_filler(void *data, struc
 static
 void cache_page_release(nfs_readdir_descriptor_t *desc)
 {
-	if (!desc->page->mapping)
-		nfs_readdir_clear_array(desc->page);
 	put_page(desc->page);
 	desc->page = NULL;
 }
@@ -717,19 +715,28 @@ struct page *get_cache_page(nfs_readdir_
 
 /*
  * Returns 0 if desc->dir_cookie was found on page desc->page_index
+ * and locks the page to prevent removal from the page cache.
  */
 static
-int find_cache_page(nfs_readdir_descriptor_t *desc)
+int find_and_lock_cache_page(nfs_readdir_descriptor_t *desc)
 {
 	int res;
 
 	desc->page = get_cache_page(desc);
 	if (IS_ERR(desc->page))
 		return PTR_ERR(desc->page);
-
-	res = nfs_readdir_search_array(desc);
+	res = lock_page_killable(desc->page);
 	if (res != 0)
-		cache_page_release(desc);
+		goto error;
+	res = -EAGAIN;
+	if (desc->page->mapping != NULL) {
+		res = nfs_readdir_search_array(desc);
+		if (res == 0)
+			return 0;
+	}
+	unlock_page(desc->page);
+error:
+	cache_page_release(desc);
 	return res;
 }
 
@@ -744,7 +751,7 @@ int readdir_search_pagecache(nfs_readdir
 		desc->last_cookie = 0;
 	}
 	do {
-		res = find_cache_page(desc);
+		res = find_and_lock_cache_page(desc);
 	} while (res == -EAGAIN);
 	return res;
 }
@@ -783,7 +790,6 @@ int nfs_do_filldir(nfs_readdir_descripto
 		desc->eof = true;
 
 	kunmap(desc->page);
-	cache_page_release(desc);
 	dfprintk(DIRCACHE, "NFS: nfs_do_filldir() filling ended @ cookie %Lu; returning = %d\n",
 			(unsigned long long)*desc->dir_cookie, res);
 	return res;
@@ -829,13 +835,13 @@ int uncached_readdir(nfs_readdir_descrip
 
 	status = nfs_do_filldir(desc);
 
+ out_release:
+	nfs_readdir_clear_array(desc->page);
+	cache_page_release(desc);
  out:
 	dfprintk(DIRCACHE, "NFS: %s: returns %d\n",
 			__func__, status);
 	return status;
- out_release:
-	cache_page_release(desc);
-	goto out;
 }
 
 /* The file offset position represents the dirent entry number.  A
@@ -900,6 +906,8 @@ static int nfs_readdir(struct file *file
 			break;
 
 		res = nfs_do_filldir(desc);
+		unlock_page(desc->page);
+		cache_page_release(desc);
 		if (res < 0)
 			break;
 	} while (!desc->eof);


