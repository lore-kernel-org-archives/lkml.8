Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E1C1C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E38820658
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599595040;
	bh=0vtMZTzu1NrMLLIC1iLpFv/vqWhtJrj/0g35C6ArFy0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LH6bjpNJoPY7XyVkujj8wgRS5Jk0psONh5tVdOhnrKEckDf+rZ++ibs3TdOy3NC6o
	 nOhcFL7giSBY2GcsFdkoqX8ZkRXMwX3CcXfaMRKvKoi7mwFMYUsLYEONT1keqlE+4v
	 PUGdBQ4yVX+ez7skN41ouyDfs0Gr06Ytdh+6/pl8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731941AbgIHT5O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:57:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:58866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730395AbgIHPfu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:35:50 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E23D224DF;
        Tue,  8 Sep 2020 15:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599579304;
        bh=0vtMZTzu1NrMLLIC1iLpFv/vqWhtJrj/0g35C6ArFy0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f2eGpcpywsmwLob4ix25t5dDnw3RX9f/39gmGVU/BMi/hsU7ol0rUUBQlWXCbsp8J
         KALpvP4bFJY6xA5W1HAcxuvZsXhPya5BtC5MpNVk3rx89TBCAQ8JIdmXm1SdAtZMwD
         awxu+BPOElm9p1LsJyvOzDo6jdGNjJYaP96kEBk4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 022/186] ceph: dont allow setlease on cephfs
Date:   Tue,  8 Sep 2020 17:22:44 +0200
Message-Id: <20200908152242.732686168@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908152241.646390211@linuxfoundation.org>
References: <20200908152241.646390211@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index d51c3f2fdca02..327649883ec7c 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -2507,6 +2507,7 @@ const struct file_operations ceph_file_fops = {
 	.mmap = ceph_mmap,
 	.fsync = ceph_fsync,
 	.lock = ceph_lock,
+	.setlease = simple_nosetlease,
 	.flock = ceph_flock,
 	.splice_read = generic_file_splice_read,
 	.splice_write = iter_file_splice_write,
-- 
2.25.1



