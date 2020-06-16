Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54ED2C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 07:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D9CB20810
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 07:10:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbgFPHKp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 03:10:45 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6331 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726091AbgFPHKo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 03:10:44 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id AC51B34C361747865690;
        Tue, 16 Jun 2020 15:10:38 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Tue, 16 Jun 2020
 15:10:31 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <richard@nod.at>, <yi.zhang@huawei.com>, <liu.song11@zte.com.cn>
Subject: [PATCH RFC 0/5] ubifs: Prevent memory oob accessing while dumping node
Date:   Tue, 16 Jun 2020 15:11:41 +0800
Message-ID: <20200616071146.2607061-1-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We use function ubifs_dump_node() to dump bad node caused by some
reasons (Such as bit flipping caused by hardware error, writing bypass
ubifs or unknown bugs in ubifs). The node content can not be trusted
anymore, so we should prevent memory out-of-bounds accessing while
dumping node in following situations:

1. bad node_len: Dumping data according to 'ch->len' which may exceed
   the size of memory allocated for node.
2. bad node content: Some kinds of node can record additional data, eg.
   index node and orphan node, make sure the size of additional data
   not beyond the node length.
3. node_type changes: Read data according to type A, but expected type
   B, before that, node is allocated according to type B's size. Length
   of type A node is greater than type B node.

Commit acc5af3efa303d5f3 ("ubifs: Fix out-of-bounds memory access caused
by abnormal value of node_len") handles situation 1 for data node only,
it would be better if we can solve problems in above situations for all
kinds of nodes.

Patch 1 adds a new parameter 'node_len'(size of memory which is allocated
for the node) in function ubifs_dump_node(), safe dumping length of the
node should be: minimum(ch->len, c->ranges[node_type].max_len, node_len).
Besides, c->ranges[node_type].min_len can not greater than safe dumping
length, which may caused by node_type changes(situation 3).

Patch 2 reverts commit acc5af3efa303d5f ("ubifs: Fix out-of-bounds memory
access caused by abnormal value of node_len") to prepare for patch 3.

Patch 3 replaces modified function ubifs_dump_node() in all node dumping
places except for ubifs_dump_sleb().

Patch 4 removes unused function ubifs_dump_sleb(),

Patch 5 allows ubifs_dump_node() to dump all branches of the index node.

Some tests after patchset applied:
https://bugzilla.kernel.org/show_bug.cgi?id=208203

Zhihao Cheng (5):
  ubifs: Limit dumping length by size of memory which is allocated for
    the node
  Revert "ubifs: Fix out-of-bounds memory access caused by abnormal
    value of node_len"
  ubifs: Pass node length in all node dumping callers
  ubifs: ubifs_dump_sleb: Remove unused function
  ubifs: ubifs_dump_node: Dump all branches of the index node

 fs/ubifs/commit.c   |   4 +-
 fs/ubifs/debug.c    | 111 ++++++++++++++++++++++++++------------------
 fs/ubifs/debug.h    |   5 +-
 fs/ubifs/file.c     |   2 +-
 fs/ubifs/io.c       |  37 +++++----------
 fs/ubifs/journal.c  |   3 +-
 fs/ubifs/master.c   |   4 +-
 fs/ubifs/orphan.c   |   6 ++-
 fs/ubifs/recovery.c |   6 +--
 fs/ubifs/replay.c   |   4 +-
 fs/ubifs/sb.c       |   2 +-
 fs/ubifs/scan.c     |   4 +-
 fs/ubifs/super.c    |   2 +-
 fs/ubifs/tnc.c      |   8 ++--
 fs/ubifs/tnc_misc.c |   4 +-
 fs/ubifs/ubifs.h    |   4 +-
 16 files changed, 108 insertions(+), 98 deletions(-)

-- 
2.25.4

