Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F4CC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F6B3206A1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593465397;
	bh=ev3tY2CXJphDAahwpY5uBObKAQpI/8IoFnLN4/nbqUQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Womj0F0mwHagiMW88kojAB7nSLJT/yA2MZ22YETNuy7WID7Xw2tWo+Tnvr0mkwHUI
	 gRWzKa2NjYIbZ8iirk31qLBXctwgb89Pd216/VOPIhHDJpZ3J+ITPmS2tnlasbfif0
	 ag/wuhmEA+KB0648Z/Xj2RltoFi6G0hoNcz3Wgf0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730171AbgF2VQf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:16:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:42396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729937AbgF2SzO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:55:14 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9412225570;
        Mon, 29 Jun 2020 15:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593446135;
        bh=ev3tY2CXJphDAahwpY5uBObKAQpI/8IoFnLN4/nbqUQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CDIFyAmksxkd2ZY7s6th01T3ig1nrq0UdSmIfFaAImM3UUe8xMK43SUfvaCmg9T6p
         i7rQyFw8bmLeGdW5pVASu9lPOJAyKMp5iHPUZxFiDRb4EjquMTLFXBwiM0ZkB6/ovX
         2NEsp6JRiSZ3j6OZmJzknqt6TSgq4tVLDAoO7e3g=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Junxiao Bi <junxiao.bi@oracle.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Changwei Ge <gechangwei@live.cn>, Gang He <ghe@suse.com>,
        Jun Piao <piaojun@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 4.4 124/135] ocfs2: fix value of OCFS2_INVALID_SLOT
Date:   Mon, 29 Jun 2020 11:52:58 -0400
Message-Id: <20200629155309.2495516-125-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629155309.2495516-1-sashal@kernel.org>
References: <20200629155309.2495516-1-sashal@kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.229-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.4.229-rc1
X-KernelTest-Deadline: 2020-07-01T15:53+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Junxiao Bi <junxiao.bi@oracle.com>

commit 9277f8334ffc719fe922d776444d6e4e884dbf30 upstream.

In the ocfs2 disk layout, slot number is 16 bits, but in ocfs2
implementation, slot number is 32 bits.  Usually this will not cause any
issue, because slot number is converted from u16 to u32, but
OCFS2_INVALID_SLOT was defined as -1, when an invalid slot number from
disk was obtained, its value was (u16)-1, and it was converted to u32.
Then the following checking in get_local_system_inode will be always
skipped:

 static struct inode **get_local_system_inode(struct ocfs2_super *osb,
                                               int type,
                                               u32 slot)
 {
 	BUG_ON(slot == OCFS2_INVALID_SLOT);
	...
 }

Link: http://lkml.kernel.org/r/20200616183829.87211-5-junxiao.bi@oracle.com
Signed-off-by: Junxiao Bi <junxiao.bi@oracle.com>
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: Mark Fasheh <mark@fasheh.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Changwei Ge <gechangwei@live.cn>
Cc: Gang He <ghe@suse.com>
Cc: Jun Piao <piaojun@huawei.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ocfs2/ocfs2_fs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ocfs2/ocfs2_fs.h b/fs/ocfs2/ocfs2_fs.h
index 88c1bd3898faf..5617ec167a9d7 100644
--- a/fs/ocfs2/ocfs2_fs.h
+++ b/fs/ocfs2/ocfs2_fs.h
@@ -304,7 +304,7 @@
 #define OCFS2_MAX_SLOTS			255
 
 /* Slot map indicator for an empty slot */
-#define OCFS2_INVALID_SLOT		-1
+#define OCFS2_INVALID_SLOT		((u16)-1)
 
 #define OCFS2_VOL_UUID_LEN		16
 #define OCFS2_MAX_VOL_LABEL_LEN		64
-- 
2.25.1

