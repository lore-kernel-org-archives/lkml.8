Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83D30C5ED21
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B2DD20801
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582813180;
	bh=CEK15zH350NN5OGjUUDvfANmkWSEOd13Yrsslg4IfrM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=e+I9kL56rVC8ZdUbRR8Rsro1nfOGivdtzb6R1QgaqTG1Pstj4FrInKR2BV+caHZJv
	 /E3Bd2y8x3JpnjphAIdpqX8TsCLBTN/2+CjaPXI8n2BmAJ2yaW59MhlGeuspVv9foA
	 wreOaE7eH2V/MXVYw4jE/z8Gl4ovLZcbH/xlcSoQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389586AbgB0OTi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:19:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:59480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389941AbgB0OSv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 09:18:51 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5ABE2468F;
        Thu, 27 Feb 2020 14:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582813131;
        bh=CEK15zH350NN5OGjUUDvfANmkWSEOd13Yrsslg4IfrM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OzNKh+J7g0Ril5zxCnZZSJmsvlCzdR9cZmL7plBe4FY9sZ4GAg47lVyWujNKjB0Zo
         uOJUxkSmW42NssbkcOsC4ATfV3YsZyDE+wQ0ZpIjaAxOwWv2BklSXJ7DHEV04H2JbX
         dKAidl8hWOqKWCUy95oXgxFAmTSaONBNZ+OOY4l4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qu Wenruo <wqu@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Filipe Manana <fdmanana@suse.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 5.5 108/150] Btrfs: fix btrfs_wait_ordered_range() so that it waits for all ordered extents
Date:   Thu, 27 Feb 2020 14:37:25 +0100
Message-Id: <20200227132248.738494047@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132232.815448360@linuxfoundation.org>
References: <20200227132232.815448360@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

commit e75fd33b3f744f644061a4f9662bd63f5434f806 upstream.

In btrfs_wait_ordered_range() once we find an ordered extent that has
finished with an error we exit the loop and don't wait for any other
ordered extents that might be still in progress.

All the users of btrfs_wait_ordered_range() expect that there are no more
ordered extents in progress after that function returns. So past fixes
such like the ones from the two following commits:

  ff612ba7849964 ("btrfs: fix panic during relocation after ENOSPC before
                   writeback happens")

  28aeeac1dd3080 ("Btrfs: fix panic when starting bg cache writeout after
                   IO error")

don't work when there are multiple ordered extents in the range.

Fix that by making btrfs_wait_ordered_range() wait for all ordered extents
even after it finds one that had an error.

Link: https://github.com/kdave/btrfs-progs/issues/228#issuecomment-569777554
CC: stable@vger.kernel.org # 4.4+
Reviewed-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/ordered-data.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -686,10 +686,15 @@ int btrfs_wait_ordered_range(struct inod
 		}
 		btrfs_start_ordered_extent(inode, ordered, 1);
 		end = ordered->file_offset;
+		/*
+		 * If the ordered extent had an error save the error but don't
+		 * exit without waiting first for all other ordered extents in
+		 * the range to complete.
+		 */
 		if (test_bit(BTRFS_ORDERED_IOERR, &ordered->flags))
 			ret = -EIO;
 		btrfs_put_ordered_extent(ordered);
-		if (ret || end == 0 || end == start)
+		if (end == 0 || end == start)
 			break;
 		end--;
 	}


