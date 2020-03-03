Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14ECEC3F2CD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 08:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9E462072A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 08:12:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbgCCIMV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 03:12:21 -0500
Received: from smtp.h3c.com ([60.191.123.50]:46505 "EHLO h3cspam02-ex.h3c.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727552AbgCCIMV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 03:12:21 -0500
X-Greylist: delayed 2910 seconds by postgrey-1.27 at vger.kernel.org; Tue, 03 Mar 2020 03:12:20 EST
Received: from h3cspam02-ex.h3c.com (localhost [127.0.0.2] (may be forged))
        by h3cspam02-ex.h3c.com with ESMTP id 0237NmGj082844
        for <linux-kernel@vger.kernel.org>; Tue, 3 Mar 2020 15:23:48 +0800 (GMT-8)
        (envelope-from tian.xianting@h3c.com)
Received: from DAG2EX10-IDC.srv.huawei-3com.com ([10.8.0.73])
        by h3cspam02-ex.h3c.com with ESMTPS id 0237N2TO081943
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 3 Mar 2020 15:23:02 +0800 (GMT-8)
        (envelope-from tian.xianting@h3c.com)
Received: from DAG2EX10-IDC.srv.huawei-3com.com (10.8.0.73) by
 DAG2EX10-IDC.srv.huawei-3com.com (10.8.0.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 3 Mar 2020 15:23:04 +0800
Received: from BJHUB02-EX.srv.huawei-3com.com (10.63.20.170) by
 DAG2EX10-IDC.srv.huawei-3com.com (10.8.0.73) with Microsoft SMTP Server
 (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.1.1713.5
 via Frontend Transport; Tue, 3 Mar 2020 15:23:04 +0800
Received: from localhost.localdomain (10.99.212.201) by rndsmtp.h3c.com
 (10.63.20.175) with Microsoft SMTP Server id 14.3.408.0; Tue, 3 Mar 2020
 15:22:57 +0800
From:   Xianting Tian <tian.xianting@h3c.com>
To:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
CC:     <yubin@h3c.com>, Xianting Tian <tian.xianting@h3c.com>
Subject: [PATCH] mm/filemap.c: clear page error before actual read
Date:   Tue, 3 Mar 2020 15:18:56 +0800
Message-ID: <20200303071856.46182-1-tian.xianting@h3c.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.99.212.201]
Content-Transfer-Encoding: 8BIT
X-DNSRBL: 
X-MAIL: h3cspam02-ex.h3c.com 0237N2TO081943
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mount failure issue happens under the scenario:
Application totally forked dozens of threads to mount the same
number of cramfs images separately in docker, but several mounts
failed with high probability.
Mount failed due to the checking result of the page
(read from the superblock of loop dev) is not uptodate after
wait_on_page_locked(page) returned in function cramfs_read:
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
this page by calling wait_on_page_locked(page). When the I/O of the
page done, io_end handler end_buffer_async_read is called, because
no one cleared the page error(during the whole read path of mount),
which is caused by systemd-udevd, so this page is still in "PageError"
status, which is can't be set to uptodate in function
end_buffer_async_read, then caused mount failure.

But sometimes mount succeed even through systemd-udeved read loop
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
other loopX dev read by systemd-udevd will go through the whole I/O
stack, part of the call trace as below:
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
             * failures, eg. multipath errors.
             * PG_error will be set again if readpage fails.
             */
            ClearPageError(page);
            /* Start the actual read.The read will unlock the page*/
            error = mapping->a_ops->readpage(filp, page);

We can see ClearPageError(page) is called before the actual read,
then the read in step 3.2 succeed, page has no error.

The patch is to add the calling of ClearPageError just before the
actual read of mount read path. Without the patch, the call trace
as below when performing mount:
  Do_mount
     ramfs_read
       cramfs_blkdev_read
          read_mapping_page
             read_cache_page
                 do_read_cache_page:
                    filler(data, page);
                    or mapping->a_ops->readpage(data, page);
With the patch, the call trace as below when performing mount:
  Do_mount
     cramfs_read
        cramfs_blkdev_read
           read_mapping_page
              read_cache_page
                 do_read_cache_page:
                    ClearPageError(page); <==new add
                    filler(data, page);
                    or mapping->a_ops->readpage(data, page);

With the patch, mount operation trigger the calling of
ClearPageError(page) before the actual read, the page has no
error if no additional page error happen when I/O done.

Signed-off-by: Xianting Tian <tian.xianting@h3c.com>
---
 mm/filemap.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/filemap.c b/mm/filemap.c
index 178447827..d65428f26 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2755,6 +2755,13 @@ static struct page *do_read_cache_page(struct address_space *mapping,
                }

 filler:
+               /*
+                * A previous I/O error may have been due to temporary
+                * failures.
+                * Clear page error before actual read, PG_error will be
+                * set again if read page fails.
+                */
+               ClearPageError(page);
                if (filler)
                        err = filler(data, page);
                else
--
2.17.1

-------------------------------------------------------------------------------------------------------------------------------------
本邮件及其附件含有新华三集团的保密信息，仅限于发送给上面地址中列出
的个人或群组。禁止任何其他人以任何形式使用（包括但不限于全部或部分地泄露、复制、
或散发）本邮件中的信息。如果您错收了本邮件，请您立即电话或邮件通知发件人并删除本
邮件！
This e-mail and its attachments contain confidential information from New H3C, which is
intended only for the person or entity whose address is listed above. Any use of the
information contained herein in any way (including, but not limited to, total or partial
disclosure, reproduction, or dissemination) by persons other than the intended
recipient(s) is prohibited. If you receive this e-mail in error, please notify the sender
by phone or email immediately and delete it!
