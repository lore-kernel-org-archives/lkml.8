Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05A5CC33C9E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7D8F20673
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578737740;
	bh=Ghd8K6VPRoWQjIndb3Yakrwxh4d7h/MYFhx9oZL8UIs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eyypBkTwL0mbV0LS9a4PYlK5rAqgfp7UF8tLlUbMw+w6MYkJScBXRPsmM9oK5Fa9a
	 i9HeEkn9IoCE3ObtzbQb4Kb5WF4TkbIZNx0yCXJaEkd4Avk3AE3UW0Ekteprxp/DuE
	 YaXZvfEyQYF99iWSQWpmrzovTcqNBNeWdJDwhI/I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729836AbgAKKPj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 05:15:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:57332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729868AbgAKKPf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 05:15:35 -0500
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F41B20673;
        Sat, 11 Jan 2020 10:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578737735;
        bh=Ghd8K6VPRoWQjIndb3Yakrwxh4d7h/MYFhx9oZL8UIs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lBY1/eA4w1Ok6b9Vi9kk27Ug9OCKqtySeXSHPg6SIkDGhygX1HR6yx46ZyM83/yZF
         F+m3h5QCdDPcafoLWqDxQAb/eq2cIoANdo5gYL95cUnOjXNtsWxwnKos0EsqWeKvPV
         82H3uO/F2Gx9n9gyLNM5fIO31I6jCY+EX/nTsIYc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 34/84] btrfs: Fix error messages in qgroup_rescan_init
Date:   Sat, 11 Jan 2020 10:50:11 +0100
Message-Id: <20200111094859.126448426@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200111094845.328046411@linuxfoundation.org>
References: <20200111094845.328046411@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nikolay Borisov <nborisov@suse.com>

[ Upstream commit 37d02592f11bb76e4ab1dcaa5b8a2a0715403207 ]

The branch of qgroup_rescan_init which is executed from the mount
path prints wrong errors messages. The textual print out in case
BTRFS_QGROUP_STATUS_FLAG_RESCAN/BTRFS_QGROUP_STATUS_FLAG_ON are not
set are transposed. Fix it by exchanging their place.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/qgroup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index cdd6d5021000..7916f711daf5 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -2862,12 +2862,12 @@ qgroup_rescan_init(struct btrfs_fs_info *fs_info, u64 progress_objectid,
 		if (!(fs_info->qgroup_flags &
 		      BTRFS_QGROUP_STATUS_FLAG_RESCAN)) {
 			btrfs_warn(fs_info,
-			"qgroup rescan init failed, qgroup is not enabled");
+			"qgroup rescan init failed, qgroup rescan is not queued");
 			ret = -EINVAL;
 		} else if (!(fs_info->qgroup_flags &
 			     BTRFS_QGROUP_STATUS_FLAG_ON)) {
 			btrfs_warn(fs_info,
-			"qgroup rescan init failed, qgroup rescan is not queued");
+			"qgroup rescan init failed, qgroup is not enabled");
 			ret = -EINVAL;
 		}
 
-- 
2.20.1



