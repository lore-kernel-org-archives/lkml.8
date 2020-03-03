Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA448C3F2D1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 15:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB6F120842
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 15:10:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="MdUVlzkH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729512AbgCCPKc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 10:10:32 -0500
Received: from m15-111.126.com ([220.181.15.111]:48767 "EHLO m15-111.126.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726988AbgCCPKc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 10:10:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=tucUIJDzJdQGxz9VTj
        FcydNy10+WnttpeLoZcEBMltQ=; b=MdUVlzkHdC8380MTa2fYYAkFJsXF+auvL2
        eKSbs8lwCvuTyS4bbkBxbv7oVTrKj664IikyAExAECfT+AwVekXwaWTp4OQmnJON
        2sKVW0+Mj49WdHqMP0SONHd00OgUEVlBdly2gScfHZ3sINP4ClHwkowKj64jgQmb
        kIN75OuQU=
Received: from 192.168.137.250 (unknown [112.10.84.98])
        by smtp1 (Coremail) with SMTP id C8mowACnO+E_c15e55mzBw--.46087S3;
        Tue, 03 Mar 2020 23:09:51 +0800 (CST)
From:   Xianting Tian <xianting_tian@126.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm/filemap.c: clear page error before actual read
Date:   Tue,  3 Mar 2020 10:09:50 -0500
Message-Id: <1583248190-18123-1-git-send-email-xianting_tian@126.com>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID: C8mowACnO+E_c15e55mzBw--.46087S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxZF1rGr4DAw1UAryrCrW7Jwb_yoWrAFWDpr
        ZxK3WDKr4DGrnrCan2q3Z7Ar1rJrsrAay5ZayrW343Zwn8JF1fW34xCFyjg345Gr1FyFWx
        XF45tas8CrnYqaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j9yCXUUUUU=
X-Originating-IP: [112.10.84.98]
X-CM-SenderInfo: h0ld03plqjs3xldqqiyswou0bp/1tbi7QTbpFpD+F-zFQAAsO
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
 mm/filemap.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/filemap.c b/mm/filemap.c
index 1784478..d65428f 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2755,6 +2755,13 @@ static struct page *do_read_cache_page(struct address_space *mapping,
 		}
 
 filler:
+		/*
+		 * A previous I/O error may have been due to temporary
+		 * failures.
+		 * Clear page error before actual read, PG_error will be
+		 * set again if read page fails.
+		 */
+		ClearPageError(page);
 		if (filler)
 			err = filler(data, page);
 		else
-- 
1.8.3.1

