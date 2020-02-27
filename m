Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC46C54FC4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61C7620578
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582812648;
	bh=S8kkFcnazwWVF8uP0OHba4L9Z36wgeNNzJnd4ccx7ew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2FRYnOIFaNdY2uDRtF162W16rv75D6Cg61VU+7b4jXPqtSYhYvga7O2d+paiBUV2M
	 z0YochpPbnRBa2qXuciySFX3VwYuJmVMWHB/HLh2HCvirUw60HNFllgYD2UAsxthE7
	 DT6dpiISaqGyJWYW3PHHjCK9S52zEOVExobO7ZHc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388587AbgB0OKr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:10:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:48928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388577AbgB0OKn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 09:10:43 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3C4C20578;
        Thu, 27 Feb 2020 14:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582812643;
        bh=S8kkFcnazwWVF8uP0OHba4L9Z36wgeNNzJnd4ccx7ew=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qVWn9CSs9JVe9t59ixbnWEUnMk3c1Z6fippAOqgLpEEsgYdbSqYOl+cdtcQ3nJqNR
         LBoJFl7xdpme2N3x5Kqx3uNBNFi/8B8Mlbrf3BmtLNEYGvt9w7ZBJkB+vidS8XZTMj
         gEDUrL8OriR7i2uKQLYQ+EsvYIotW6/EcWQIjgjE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 5.4 095/135] btrfs: do not check delayed items are empty for single transaction cleanup
Date:   Thu, 27 Feb 2020 14:37:15 +0100
Message-Id: <20200227132243.527366487@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132228.710492098@linuxfoundation.org>
References: <20200227132228.710492098@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josef Bacik <josef@toxicpanda.com>

commit 1e90315149f3fe148e114a5de86f0196d1c21fa5 upstream.

btrfs_assert_delayed_root_empty() will check if the delayed root is
completely empty, but this is a filesystem-wide check.  On cleanup we
may have allowed other transactions to begin, for whatever reason, and
thus the delayed root is not empty.

So remove this check from cleanup_one_transation().  This however can
stay in btrfs_cleanup_transaction(), because it checks only after all of
the transactions have been properly cleaned up, and thus is valid.

CC: stable@vger.kernel.org # 4.4+
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/disk-io.c |    1 -
 1 file changed, 1 deletion(-)

--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4520,7 +4520,6 @@ void btrfs_cleanup_one_transaction(struc
 	wake_up(&fs_info->transaction_wait);
 
 	btrfs_destroy_delayed_inodes(fs_info);
-	btrfs_assert_delayed_root_empty(fs_info);
 
 	btrfs_destroy_marked_extents(fs_info, &cur_trans->dirty_pages,
 				     EXTENT_DIRTY);


