Return-Path: <SRS0=BhYR=34=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 546B1C35242
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 18:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33F5E20661
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 18:31:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728343AbgBHSbg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Feb 2020 13:31:36 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34812 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727972AbgBHS3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Feb 2020 13:29:50 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1j0UrP-0003jw-4s; Sat, 08 Feb 2020 18:29:43 +0000
Received: from ben by deadeye with local (Exim 4.93)
        (envelope-from <ben@decadent.org.uk>)
        id 1j0UrM-000CWj-Nh; Sat, 08 Feb 2020 18:29:40 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Maximilian Heyne" <mheyne@amazon.de>,
        "Paul Durrant" <pdurrant@amazon.co.uk>,
        "David Woodhouse" <dwmw@amazon.de>, "Jens Axboe" <axboe@kernel.dk>,
        "Roger Pau =?UTF-8?Q?Monn=C3=A9?=" <roger.pau@citrix.com>,
        "SeongJae Park" <sjpark@amazon.de>
Date:   Sat, 08 Feb 2020 18:21:15 +0000
Message-ID: <lsq.1581185941.410810345@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 136/148] xen/blkback: Avoid unmapping unmapped grant
 pages
In-Reply-To: <lsq.1581185939.857586636@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.82-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: SeongJae Park <sjpark@amazon.de>

commit f9bd84a8a845d82f9b5a081a7ae68c98a11d2e84 upstream.

For each I/O request, blkback first maps the foreign pages for the
request to its local pages.  If an allocation of a local page for the
mapping fails, it should unmap every mapping already made for the
request.

However, blkback's handling mechanism for the allocation failure does
not mark the remaining foreign pages as unmapped.  Therefore, the unmap
function merely tries to unmap every valid grant page for the request,
including the pages not mapped due to the allocation failure.  On a
system that fails the allocation frequently, this problem leads to
following kernel crash.

  [  372.012538] BUG: unable to handle kernel NULL pointer dereference at 0000000000000001
  [  372.012546] IP: [<ffffffff814071ac>] gnttab_unmap_refs.part.7+0x1c/0x40
  [  372.012557] PGD 16f3e9067 PUD 16426e067 PMD 0
  [  372.012562] Oops: 0002 [#1] SMP
  [  372.012566] Modules linked in: act_police sch_ingress cls_u32
  ...
  [  372.012746] Call Trace:
  [  372.012752]  [<ffffffff81407204>] gnttab_unmap_refs+0x34/0x40
  [  372.012759]  [<ffffffffa0335ae3>] xen_blkbk_unmap+0x83/0x150 [xen_blkback]
  ...
  [  372.012802]  [<ffffffffa0336c50>] dispatch_rw_block_io+0x970/0x980 [xen_blkback]
  ...
  Decompressing Linux... Parsing ELF... done.
  Booting the kernel.
  [    0.000000] Initializing cgroup subsys cpuset

This commit fixes this problem by marking the grant pages of the given
request that didn't mapped due to the allocation failure as invalid.

Fixes: c6cc142dac52 ("xen-blkback: use balloon pages for all mappings")

Reviewed-by: David Woodhouse <dwmw@amazon.de>
Reviewed-by: Maximilian Heyne <mheyne@amazon.de>
Reviewed-by: Paul Durrant <pdurrant@amazon.co.uk>
Reviewed-by: Roger Pau Monné <roger.pau@citrix.com>
Signed-off-by: SeongJae Park <sjpark@amazon.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/block/xen-blkback/blkback.c | 2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/block/xen-blkback/blkback.c
+++ b/drivers/block/xen-blkback/blkback.c
@@ -825,6 +825,8 @@ next:
 out_of_memory:
 	pr_alert(DRV_PFX "%s: out of memory\n", __func__);
 	put_free_pages(blkif, pages_to_gnt, segs_to_map);
+	for (i = last_map; i < num; i++)
+		pages[i]->handle = BLKBACK_INVALID_HANDLE;
 	return -ENOMEM;
 }
 

