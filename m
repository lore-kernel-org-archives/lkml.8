Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35383C433E7
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 15:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14D04207EA
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 15:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598888013;
	bh=YgEmgGLPuUW4I8j1gag94hXTFYWL8ZL/iKMTK9WHkEY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BtiFbKC3c1tHzyN7+aSnJSHwRygSOkyIS1sewg7Mev+KFaUi3dxd8b8fGJ7x8zoKt
	 hkFL8OlBdBp1ama32BXR3wayi8c/3LPU7dUdFkODwKX2aSfsRoFhX85nAYS78xbhbn
	 x+9BQiktcjSxHhF0eZlUEQ8vPhfqFEZ+BnDh+kc0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728988AbgHaPbr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 11:31:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:42420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728379AbgHaPba (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 11:31:30 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A53D22158C;
        Mon, 31 Aug 2020 15:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598887890;
        bh=YgEmgGLPuUW4I8j1gag94hXTFYWL8ZL/iKMTK9WHkEY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b+fEF0GDY3P+SRxemFOYZq4gzsgNziv05X0VnmnqxNUOkkFD6CRLaxVrQl+W9NXva
         YB+dpcYTURw6/OqLWZEb3HbAW93s+4AeXMQvLkkanwxT6zd5rGsQY5PaMisLuFrMEH
         UaQHaJumqPWyquSjK2WJ7xrOuEv1ymtFh7ovWh+k=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Sasha Levin <sashal@kernel.org>, ceph-devel@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 08/11] ceph: don't allow setlease on cephfs
Date:   Mon, 31 Aug 2020 11:31:14 -0400
Message-Id: <20200831153117.1024537-8-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200831153117.1024537-1-sashal@kernel.org>
References: <20200831153117.1024537-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff Layton <jlayton@kernel.org>

[ Upstream commit 496ceaf12432b3d136dcdec48424312e71359ea7 ]

Leases don't currently work correctly on kcephfs, as they are not broken
when caps are revoked. They could eventually be implemented similarly to
how we did them in libcephfs, but for now don't allow them.

[ idryomov: no need for simple_nosetlease() in ceph_dir_fops and
  ceph_snapdir_fops ]

Signed-off-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ceph/file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index faca455bd3c69..4ce2752c8b71c 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -1819,6 +1819,7 @@ const struct file_operations ceph_file_fops = {
 	.mmap = ceph_mmap,
 	.fsync = ceph_fsync,
 	.lock = ceph_lock,
+	.setlease = simple_nosetlease,
 	.flock = ceph_flock,
 	.splice_read = generic_file_splice_read,
 	.splice_write = iter_file_splice_write,
-- 
2.25.1

