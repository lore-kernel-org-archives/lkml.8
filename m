Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 470A9C52D3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14FC92084E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582811879;
	bh=5vOT5Cbvh9GNxrUOd50DskvivDNUfqGcKhlzkAN2f3Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YIlXhA416KEhMEu5fKkXSuxQpK3kaRIs6FO9GB3b62Hhq6GUBN3PDVDusD+3ZQiOY
	 x7NF9yRr1Pq0TjdcdWEduBFJR3kmdVhniXBYpHOK8DtI8AC614sxX+mBmefD9hWJ1E
	 QvPRsKOxBz01FyQo0YwpXT10rBZpmMTDTrLA2L2Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732374AbgB0N56 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 08:57:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:58938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731910AbgB0N5z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:57:55 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 283EA20578;
        Thu, 27 Feb 2020 13:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582811873;
        bh=5vOT5Cbvh9GNxrUOd50DskvivDNUfqGcKhlzkAN2f3Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TI/03ntGOrrlSww+ugAXP+mvwEVv1q9140Pkj/1IyAev9Omh8qGEiJ232TNbeiLp5
         rtqtnt/CtNt01SI+s42aTFpfz5xOQLfbvDM8VgM8X4ii2UNTRZQXEJh6Z4emFhIK0t
         wks5taxMVfNxhk/sl3bEVtdzd3swnEWaAPnYR86s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, philip@philip-seeger.de,
        Josef Bacik <josef@toxicpanda.com>,
        Anand Jain <anand.jain@oracle.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 134/237] btrfs: device stats, log when stats are zeroed
Date:   Thu, 27 Feb 2020 14:35:48 +0100
Message-Id: <20200227132306.569636106@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132255.285644406@linuxfoundation.org>
References: <20200227132255.285644406@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anand Jain <anand.jain@oracle.com>

[ Upstream commit a69976bc69308aa475d0ba3b8b3efd1d013c0460 ]

We had a report indicating that some read errors aren't reported by the
device stats in the userland. It is important to have the errors
reported in the device stat as user land scripts might depend on it to
take the reasonable corrective actions. But to debug these issue we need
to be really sure that request to reset the device stat did not come
from the userland itself. So log an info message when device error reset
happens.

For example:
 BTRFS info (device sdc): device stats zeroed by btrfs(9223)

Reported-by: philip@philip-seeger.de
Link: https://www.spinics.net/lists/linux-btrfs/msg96528.html
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/volumes.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 358e930df4acd..6d34842912e80 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -7227,6 +7227,8 @@ int btrfs_get_dev_stats(struct btrfs_fs_info *fs_info,
 			else
 				btrfs_dev_stat_reset(dev, i);
 		}
+		btrfs_info(fs_info, "device stats zeroed by %s (%d)",
+			   current->comm, task_pid_nr(current));
 	} else {
 		for (i = 0; i < BTRFS_DEV_STAT_VALUES_MAX; i++)
 			if (stats->nr_items > i)
-- 
2.20.1



