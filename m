Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BE1DC3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 10:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40FBA20732
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 10:48:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="FLwMrJsD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729252AbgCDKsi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 05:48:38 -0500
Received: from m15-113.126.com ([220.181.15.113]:50240 "EHLO m15-113.126.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726137AbgCDKsh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 05:48:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=IeCdyAGFwXp3ZJWoz2
        7XzqKXoULD6qM3z6NhawmdYlI=; b=FLwMrJsDJPv6HNAMsaGYL/PvWgyW9o9yHK
        q6HXkdW7AM1QvSpze8XFkN/SeWjbG/ha9btTU56lE+M8PInQu6ULLwfn3eq822dk
        SrDWA4Xs8tW1x/7nTQS0J5+PPhE+3YyYJI01BS7C3e3bbWs+6NOra1lDgTAZ/hKQ
        zcoZxa7tE=
Received: from 192.168.137.251 (unknown [112.10.84.98])
        by smtp3 (Coremail) with SMTP id DcmowAC3EAc8h19e2h4DCA--.2331S3;
        Wed, 04 Mar 2020 18:47:26 +0800 (CST)
From:   Xianting Tian <xianting_tian@126.com>
To:     akpm@linux-foundation.org, willy@infradead.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm/filemap.c: clear page error before actual read
Date:   Wed,  4 Mar 2020 05:47:24 -0500
Message-Id: <1583318844-22971-1-git-send-email-xianting_tian@126.com>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID: DcmowAC3EAc8h19e2h4DCA--.2331S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxZF1rGr4DAw1UAryrCrW7Jwb_yoWrAFWDpr
        ZxK3WDKr4DGrnrCan2q3Z7Ar1rGrnrAay5ZayrW343Zwn8XF1fW34xCFyjg345Gr1FyFWx
        Xr4FqF98Cr9YqaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jTc_-UUUUU=
X-Originating-IP: [112.10.84.98]
X-CM-SenderInfo: h0ld03plqjs3xldqqiyswou0bp/1tbi3B7cpFpD+S1DOAAAsM
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mount failure issue happens under the scenario:
Application forked dozens of threads to mount the same number of
cramfs images separately in docker, but several mounts failed
with high probability. Mount failed due to the checking result of
the page(read from the superblock of loop dev) is not uptodate
after wait_on_page_locked(page) returned in function cramfs_read:
   wait_on_page_locked(page);
   if (!PageUptodate(page)) {
      ...
   }

The reason of the checking result of the page not uptodate:
systemd-udevd read the loopX dev before mount, because the status
of loopX is Lo_unbound at this time, so loop_make_request directly
trigger the calling of io_end handler end_buffer_async_read, which
called SetPageError(page). So It caused the page can't be set to
uptodate in function end_buffer_async_read:
   if(page_uptodate && !PageError(page)) {
      SetPageUptodate(page);
   }
Then mount operation is performed, it used the same page which is
just accessed by systemd-udevd above, Because this page is not
uptodate, it will launch a actual read via submit_bh, then wait on
this page by calling wait_on_page_locked(page). When the I/O of
the page done, io_end handler end_buffer_async_read is called,
because no one cleared the page error(during the whole read path of
mount), which is caused by systemd-udevd reading, so this page is
still in "PageError" status, which can't be set to uptodate in
function end_buffer_async_read, then caused mount failure.

But sometimes mount succeed even through systemd-udeved read loopX
dev just before, The reason is systemd-udevd launched other loopX
read just between step 3.1 and 3.2, the steps as below:
1, loopX dev default status is Lo_unbound;
2, systemd-udved read loopX dev (page is set to PageError);
3, mount operation
   1) set loopX status to Lo_bound;
   ==>systemd-udevd read loopX dev<==
   2) read loopX dev(page has no error)
   3) mount succeed
As the loopX dev status is set to Lo_bound after step 3.1, so the
other loopX dev read by systemd-udevd will go through the whole
I/O stack, part of the call trace as below:
   SYS_read
      vfs_read
          do_sync_read
              blkdev_aio_read
                 generic_file_aio_read
                     do_generic_file_read:
                        ClearPageError(page);
                        mapping->a_ops->readpage(filp, page);
here, mapping->a_ops->readpage() is blkdev_readpage.
In latest kernel, some function name changed, the call trace as
below:
   blkdev_read_iter
      generic_file_read_iter
         generic_file_buffered_read:
            /*
             * A previous I/O error may have been due to temporary
             * failures, eg. mutipath errors.
             * Pg_error will be set again if readpage fails.
             */
            ClearPageError(page);
            /* Start the actual read. The read will unlock the page*/
            error=mapping->a_ops->readpage(flip, page);
We can see ClearPageError(page) is called before the actual read,
then the read in step 3.2 succeed.

This patch is to add the calling of ClearPageError just before the
actual read of read path of cramfs mount.
Without the patch, the call trace as below when performing cramfs
mount:
   do_mount
      cramfs_read
         cramfs_blkdev_read
            read_cache_page
               do_read_cache_page:
                  filler(data, page);
                  or
                  mapping->a_ops->readpage(data, page);
With the patch, the call trace as below when performing mount:
   do_mount
      cramfs_read
         cramfs_blkdev_read
            read_cache_page:
               do_read_cache_page:
                  ClearPageError(page); <== new add
                  filler(data, page);
                  or
                  mapping->a_ops->readpage(data, page);

With the patch, mount operation trigger the calling of
ClearPageError(page) before the actual read, the page has no error
if no additional page error happen when I/O done.

Signed-off-by: Xianting Tian <xianting_tian@126.com>
---
 mm/filemap.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mm/filemap.c b/mm/filemap.c
index 1784478..77c370d 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2823,6 +2823,14 @@ static struct page *do_read_cache_page(struct address_space *mapping,
 		unlock_page(page);
 		goto out;
 	}
+
+	/*
+	 * A previous I/O error may have been due to temporary
+	 * failures.
+	 * Clear page error before actual read, PG_error will be
+	 * set again if read page fails.
+	 */
+	ClearPageError(page);
 	goto filler;
 
 out:
-- 
1.8.3.1

