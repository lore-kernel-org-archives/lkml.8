Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 654FBC3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 15:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B56D2146E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 15:14:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="g4G7EghD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbgCBPOV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 10:14:21 -0500
Received: from m15-113.126.com ([220.181.15.113]:47910 "EHLO m15-113.126.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726451AbgCBPOV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 10:14:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=hbtuA6sJCGwZmeCm5d
        VANr4qYyH1rkLKX1gUP6zj/ZE=; b=g4G7EghDT40FCio/gpHJxKjigaPPGy2SPR
        NrhT6bdIRNw6RZvRao7UPkcscl7lb4vRVfRLanCKSWqs8PB6GTgHxiK5xsBQtzjj
        GyZvk4nvAq4xR55tHFW92tQJ8aWkBBx01VuQM6kOm1VLiD/dHxBJEKSNrN9epCxr
        HLWgrgQKA=
Received: from 192.168.137.250 (unknown [112.10.84.98])
        by smtp3 (Coremail) with SMTP id DcmowACXJcLBIl1e0wO_Bw--.47949S3;
        Mon, 02 Mar 2020 23:14:10 +0800 (CST)
From:   Xianting Tian <xianting_tian@126.com>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH] mm/filemap.c: clear page error before actual read
Date:   Mon,  2 Mar 2020 10:14:09 -0500
Message-Id: <1583162049-17623-1-git-send-email-xianting_tian@126.com>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID: DcmowACXJcLBIl1e0wO_Bw--.47949S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxWF1DKFWkWF43JF13AF13Jwb_yoW5WFykpr
        ZxJ3WxKr4DGFnIkF4vy3Z7Cr1rGr4vyay5Way8W3srZwn8GFn3u34SkayDWrW3Jr1FyF42
        qrsYqas8CrZYqaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jSE__UUUUU=
X-Originating-IP: [112.10.84.98]
X-CM-SenderInfo: h0ld03plqjs3xldqqiyswou0bp/1tbi7QDapFpD+Fix5QABs-
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mount failure issue happens under the circumstances:
Application totally forked 38 threads to mount 38 cramfs images in docker,
but several mounts failed with high probability.
Mount failed due to the checking result of the page(read from the superblock
of loop dev) is not uptodate after wait_on_page_locked(page) returned in
function cramfs_read:
wait_on_page_locked(page);
if (!PageUptodate(page)) {
	...
}

The reason of the checking result of the page not uptodate:
systemd-udevd read the loopX dev before mount, because the status of loopX
is Lo_unbound at this time, so loop_make_request directly trigger the calling
of io_end handler end_buffer_async_read, which called SetPageError(page). So It
caused the page can't be set to uptodate in function end_buffer_saync_read:
if(page_uptodate && !PageError(page)) {
	SetPageUptodate(page);
}
Then mount operation is performed, it used the same page which is just used by
systemd-udevd above, Because this page is not uptodate, it will launch a actual
read via submit_bh, then wait on this page by calling wait_on_page_locked(page).
When the I/O of the page done, io_end handler end_buffer_async_read is called,
because no one cleared the page error(during the whole read path), which is caused
by systemd-udevd, so this page is still in "PageError" staus, which is can't
be set to uptodate in function end_buffer_async_read, then caused mount failure.

But sometimes mount succeed even through systemd-udeved read loop dev just before,
The reason is systemd-udevd launched other loopX read just between step 3.1 and 3.2,
the steps as below:
1, loopX dev default status is Lo_unbound;
2, systemd-udved read loopX dev (page is set to PageError);
3, mount operation
   1) set loopX status to Lo_bound;
   ==>systemd-udevd read loopX dev<==
   2) read loopX dev(page has no error)
   3) mount succeed
As the loopX dev status is set to Lo_bound after step 3.1, so the other loopX dev read
by systemd-udevd will go through the whole I/O stack, part of the call trace as below:
   SYS_read
      vfs_read
          do_sync_read
              blkdev_aio_read
                 generic_file_aio_read
                     do_generic_file_read
                         ClearPageError(page);mapping->a_ops->readpage(filp, page)
here, mapping->a_ops_readpage() is blkdev_readpage.
We can see the ClearPageError(page) is called, then the read in step 3.2 succeed.

The fix is to add ClearPageError just before the actual read of other read path.

Signed-off-by: Xianting Tian <xianting_tian@126.com>
---
 mm/filemap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/filemap.c b/mm/filemap.c
index 1784478..c2cf0fd 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2755,6 +2755,7 @@ static struct page *do_read_cache_page(struct address_space *mapping,
 		}
 
 filler:
+		ClearPageError(page);
 		if (filler)
 			err = filler(data, page);
 		else
-- 
1.8.3.1

