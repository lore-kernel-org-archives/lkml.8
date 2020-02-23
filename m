Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7090CC35671
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 02:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39BBF22464
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 02:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582424633;
	bh=99EtiNtJdAvPT2as60AJ2VmPObSheEPp0q5rtgVAgns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JZC+TiNLxvSwFIhE5kliey1OTf/6UJRd2XCbh8EKj6SxjSkRU0yurTuRSOFiy4DaE
	 NVwIjOab28/OMj0cYV0jXwR23GIf0gPTNbVANcarIdhGPm65otIaWe8g/wgxlkadKV
	 OGdnQnxIurpZ84iO5ok4iAFdpp79ShcZj1SWy5P0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728844AbgBWCXu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 21:23:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:53422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728780AbgBWCXp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 21:23:45 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42C3124670;
        Sun, 23 Feb 2020 02:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582424625;
        bh=99EtiNtJdAvPT2as60AJ2VmPObSheEPp0q5rtgVAgns=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FsLF2fFePkndfvhHhCTdww8Olpm5/+yJkblEz45b/pC+RWYMiBYVJNt/DxPkZmU6j
         wQN9Hxp7UWzBhcUU3ZS6meDFZ8xaOUJkWl+0gTo/tLGvzOjjA5D72X9yK0yrsnkA0H
         GOoTaXm8cROKS6N/4AdGglxbHGlQ/7ysYqtEaGHk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jeff Moyer <jmoyer@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Jan Kara <jack@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-nvdimm@lists.01.org
Subject: [PATCH AUTOSEL 4.19 04/25] dax: pass NOWAIT flag to iomap_apply
Date:   Sat, 22 Feb 2020 21:23:18 -0500
Message-Id: <20200223022339.1885-4-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200223022339.1885-1-sashal@kernel.org>
References: <20200223022339.1885-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff Moyer <jmoyer@redhat.com>

[ Upstream commit 96222d53842dfe54869ec4e1b9d4856daf9105a2 ]

fstests generic/471 reports a failure when run with MOUNT_OPTIONS="-o
dax".  The reason is that the initial pwrite to an empty file with the
RWF_NOWAIT flag set does not return -EAGAIN.  It turns out that
dax_iomap_rw doesn't pass that flag through to iomap_apply.

With this patch applied, generic/471 passes for me.

Signed-off-by: Jeff Moyer <jmoyer@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/x49r1z86e1d.fsf@segfault.boston.devel.redhat.com
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/dax.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/dax.c b/fs/dax.c
index f0d932fa39c20..d09701aa6f2f4 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1301,6 +1301,9 @@ dax_iomap_rw(struct kiocb *iocb, struct iov_iter *iter,
 		lockdep_assert_held(&inode->i_rwsem);
 	}
 
+	if (iocb->ki_flags & IOCB_NOWAIT)
+		flags |= IOMAP_NOWAIT;
+
 	while (iov_iter_count(iter)) {
 		ret = iomap_apply(inode, pos, iov_iter_count(iter), flags, ops,
 				iter, dax_iomap_actor);
-- 
2.20.1

