Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E78C35641
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B94D24683
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582273615;
	bh=JJMmc5g1eGCmHENbQ2PMQGmXelm8gaob9rFnxvQpAFU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kYNeQD6XFjHKEhLNskMpzrjcsu/zo225dIxUYSLgtB5tM2pKO47/7SLDeJArNPicm
	 QTvLFE4wLJn53s3AhZbI0SBQPiNdcEW49uXzQbbrUB72TvINAZT5vEEJJwkMIGu4Jz
	 BqCboQGAfqs/140bF11ZBlywB31ZabDWB8eYvPag=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388429AbgBUI0x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 03:26:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:34438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731468AbgBUIWp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 03:22:45 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B7F72469A;
        Fri, 21 Feb 2020 08:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582273364;
        bh=JJMmc5g1eGCmHENbQ2PMQGmXelm8gaob9rFnxvQpAFU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mPyu6WXNVU5ndggZvBi4dbAl8tHgGWZx7lSF7a76qNPnRHSQmxBwvJNl9u1cnefp/
         ptpAfnSvSMvJvIZcJj02+nQsPPYO/15ytjwvbk/ZO7oGcDqcpr+C6svdzP+sjl6zP8
         KkZB9MQJBzo9B2hf+1/jR0k5Dv6c1pU2K6BMxfCI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johannes Thumshirn <jth@kernel.org>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 144/191] btrfs: fix possible NULL-pointer dereference in integrity checks
Date:   Fri, 21 Feb 2020 08:41:57 +0100
Message-Id: <20200221072307.905099818@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200221072250.732482588@linuxfoundation.org>
References: <20200221072250.732482588@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johannes Thumshirn <jth@kernel.org>

[ Upstream commit 3dbd351df42109902fbcebf27104149226a4fcd9 ]

A user reports a possible NULL-pointer dereference in
btrfsic_process_superblock(). We are assigning state->fs_info to a local
fs_info variable and afterwards checking for the presence of state.

While we would BUG_ON() a NULL state anyways, we can also just remove
the local fs_info copy, as fs_info is only used once as the first
argument for btrfs_num_copies(). There we can just pass in
state->fs_info as well.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=205003
Signed-off-by: Johannes Thumshirn <jth@kernel.org>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/check-integrity.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/check-integrity.c b/fs/btrfs/check-integrity.c
index 833cf3c35b4df..3b77c8ab5357e 100644
--- a/fs/btrfs/check-integrity.c
+++ b/fs/btrfs/check-integrity.c
@@ -629,7 +629,6 @@ static struct btrfsic_dev_state *btrfsic_dev_state_hashtable_lookup(dev_t dev,
 static int btrfsic_process_superblock(struct btrfsic_state *state,
 				      struct btrfs_fs_devices *fs_devices)
 {
-	struct btrfs_fs_info *fs_info = state->fs_info;
 	struct btrfs_super_block *selected_super;
 	struct list_head *dev_head = &fs_devices->devices;
 	struct btrfs_device *device;
@@ -700,7 +699,7 @@ static int btrfsic_process_superblock(struct btrfsic_state *state,
 			break;
 		}
 
-		num_copies = btrfs_num_copies(fs_info, next_bytenr,
+		num_copies = btrfs_num_copies(state->fs_info, next_bytenr,
 					      state->metablock_size);
 		if (state->print_mask & BTRFSIC_PRINT_MASK_NUM_COPIES)
 			pr_info("num_copies(log_bytenr=%llu) = %d\n",
-- 
2.20.1



