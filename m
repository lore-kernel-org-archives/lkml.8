Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A290CC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F69922D07
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597915578;
	bh=yftGnr7TyooLqUgV7TUEcQ9nkwaYA4xThnSHYjZ/N6k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TpMcbVyPdy+Q1eg0SSrmA6DN8STjh6aSrY98fPRaxTEYiUzk3VsDD4VmH8KDrUMYx
	 06XC33xYYbWhDxxT1mVe1k83z5cFHVTTEdvIEU2/senzKPoEbjPLtuvZbzCtLUbH+K
	 lU+j6Xqse/boTB5fmyKGKlPPeB/lWD+2/twl3eQc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbgHTJ0I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 05:26:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:33272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726795AbgHTJZB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:25:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 212F322CB1;
        Thu, 20 Aug 2020 09:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597915500;
        bh=yftGnr7TyooLqUgV7TUEcQ9nkwaYA4xThnSHYjZ/N6k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=grWl6KE5tcNErUGDrk0OKbeisU+xUyqlOD+N/Sb1c3Hp0UqsATh76TEmAU4k2S0Of
         +ds9dGGgwmJvjrMRPesDHuEf+VYfGtSXTcuwO8AFSuYuNjO/pEjJoCW5CxfI6OBwGP
         2S8Ggf9/cTgD93tCCYEAJ9BI/f+9CuQVFBj/n1mM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        Qu Wenruo <wqu@suse.com>, David Sterba <dsterba@suse.com>
Subject: [PATCH 5.8 028/232] btrfs: avoid possible signal interruption of btrfs_drop_snapshot() on relocation tree
Date:   Thu, 20 Aug 2020 11:17:59 +0200
Message-Id: <20200820091614.116316607@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091612.692383444@linuxfoundation.org>
References: <20200820091612.692383444@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qu Wenruo <wqu@suse.com>

commit f3e3d9cc35252a70a2fd698762c9687718268ec6 upstream.

[BUG]
There is a bug report about bad signal timing could lead to read-only
fs during balance:

  BTRFS info (device xvdb): balance: start -d -m -s
  BTRFS info (device xvdb): relocating block group 73001861120 flags metadata
  BTRFS info (device xvdb): found 12236 extents, stage: move data extents
  BTRFS info (device xvdb): relocating block group 71928119296 flags data
  BTRFS info (device xvdb): found 3 extents, stage: move data extents
  BTRFS info (device xvdb): found 3 extents, stage: update data pointers
  BTRFS info (device xvdb): relocating block group 60922265600 flags metadata
  BTRFS: error (device xvdb) in btrfs_drop_snapshot:5505: errno=-4 unknown
  BTRFS info (device xvdb): forced readonly
  BTRFS info (device xvdb): balance: ended with status: -4

[CAUSE]
The direct cause is the -EINTR from the following call chain when a
fatal signal is pending:

 relocate_block_group()
 |- clean_dirty_subvols()
    |- btrfs_drop_snapshot()
       |- btrfs_start_transaction()
          |- btrfs_delayed_refs_rsv_refill()
             |- btrfs_reserve_metadata_bytes()
                |- __reserve_metadata_bytes()
                   |- wait_reserve_ticket()
                      |- prepare_to_wait_event();
                      |- ticket->error = -EINTR;

Normally this behavior is fine for most btrfs_start_transaction()
callers, as they need to catch any other error, same for the signal, and
exit ASAP.

However for balance, especially for the clean_dirty_subvols() case, we're
already doing cleanup works, getting -EINTR from btrfs_drop_snapshot()
could cause a lot of unexpected problems.

>From the mentioned forced read-only report, to later balance error due
to half dropped reloc trees.

[FIX]
Fix this problem by using btrfs_join_transaction() if
btrfs_drop_snapshot() is called from relocation context.

Since btrfs_join_transaction() won't get interrupted by signal, we can
continue the cleanup.

CC: stable@vger.kernel.org # 5.4+
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>3
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/extent-tree.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -5298,7 +5298,14 @@ int btrfs_drop_snapshot(struct btrfs_roo
 		goto out;
 	}
 
-	trans = btrfs_start_transaction(tree_root, 0);
+	/*
+	 * Use join to avoid potential EINTR from transaction start. See
+	 * wait_reserve_ticket and the whole reservation callchain.
+	 */
+	if (for_reloc)
+		trans = btrfs_join_transaction(tree_root);
+	else
+		trans = btrfs_start_transaction(tree_root, 0);
 	if (IS_ERR(trans)) {
 		err = PTR_ERR(trans);
 		goto out_free;


