Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75639C55186
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 466AD2168B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587550894;
	bh=f+MIyflL7PoUCPvmXSbksyJDbP3lDfOTiJtP3BLlWqs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tjPzBMqTKi11Qjg08SsMkYizTald9eusirFv9Tzz0WUPcyAb8nP4r5euqAEVCDq5d
	 ZxxbJ8FI9kvPy9BHm4Jk6Q0vXZnLSy4U+k1/kma2LOsH3lt3HiNd46Ta88hcKXoPUl
	 jJdsWI0CtFlHkFdR99PA3tfgd5ca1dfinJmYAoiE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730181AbgDVKVS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:21:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:55072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729971AbgDVKSc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:18:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E17E2076E;
        Wed, 22 Apr 2020 10:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587550712;
        bh=f+MIyflL7PoUCPvmXSbksyJDbP3lDfOTiJtP3BLlWqs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aPSDLGpNzSaWstvYlNFiz8UbjQcNEOpvVgW+O/EuNZ1QdChT4P51Sgfo9uKixX5LM
         0RMFFcRMpwfmTOLl4Lligm3eKvDqSnci3XSEjnaxkavaWcNuOhzWZpq3ckAQWD5t3q
         L02VBClZ/B2ltOQpmAlrNb4I2cB0xjeKyv0FrYhk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 062/118] btrfs: add RCU locks around block group initialization
Date:   Wed, 22 Apr 2020 11:57:03 +0200
Message-Id: <20200422095042.165012684@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200422095031.522502705@linuxfoundation.org>
References: <20200422095031.522502705@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>

[ Upstream commit 29566c9c773456467933ee22bbca1c2b72a3506c ]

The space_info list is normally RCU protected and should be traversed
with rcu_read_lock held. There's a warning

  [29.104756] WARNING: suspicious RCU usage
  [29.105046] 5.6.0-rc4-next-20200305 #1 Not tainted
  [29.105231] -----------------------------
  [29.105401] fs/btrfs/block-group.c:2011 RCU-list traversed in non-reader section!!

pointing out that the locking is missing in btrfs_read_block_groups.
However this is not necessary as the list traversal happens at mount
time when there's no other thread potentially accessing the list.

To fix the warning and for consistency let's add the RCU lock/unlock,
the code won't be affected much as it's doing some lightweight
operations.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/block-group.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 7dcfa7d7632a1..95330f40f998c 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1829,6 +1829,7 @@ int btrfs_read_block_groups(struct btrfs_fs_info *info)
 		}
 	}
 
+	rcu_read_lock();
 	list_for_each_entry_rcu(space_info, &info->space_info, list) {
 		if (!(btrfs_get_alloc_profile(info, space_info->flags) &
 		      (BTRFS_BLOCK_GROUP_RAID10 |
@@ -1849,6 +1850,7 @@ int btrfs_read_block_groups(struct btrfs_fs_info *info)
 				list)
 			inc_block_group_ro(cache, 1);
 	}
+	rcu_read_unlock();
 
 	btrfs_init_global_block_rsv(info);
 	ret = check_chunk_block_group_mappings(info);
-- 
2.20.1



