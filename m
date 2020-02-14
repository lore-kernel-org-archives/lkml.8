Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94244C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E0C220637
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581700795;
	bh=6ba7hysJU/gD58jDN/JTv4StRHF+OsBhjNKhN1d0aKc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZHzEJSQ5DkweRKq67QnzZUYNBYACMOwm+oWYWx/2TyZclxbZrrXddQ2tMG1gVkbqg
	 zQgODqLQGLSpaxb9yWufwWxEXCV27DM925SaYiGNf9QnWppBzPPXWfT1nw4rOqiOsY
	 gbfNntRq0NRVIXcDhbWPMn2se3QFIOGE0GnW8Gt4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405074AbgBNRTy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 12:19:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:36544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391597AbgBNQKt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:10:49 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D91B2468D;
        Fri, 14 Feb 2020 16:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581696642;
        bh=6ba7hysJU/gD58jDN/JTv4StRHF+OsBhjNKhN1d0aKc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ew9rkqV4Ef9y2RrGoAFP+r9jEcdSK0Ehay2/NtnaoVcXpALxwR7YnDxjmdwKhTDnu
         Y172aJaEgvEEIVMcdJobypACg+ZNXcsQKbFExdP7XloB7aNoYRW6EC7aTQ86def4RY
         0WeFpghjohgiFbxBrxQINcOrwIetuw7HH5bkvyRs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Xiubo Li <xiubli@redhat.com>, Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Sasha Levin <sashal@kernel.org>, ceph-devel@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 419/459] ceph: check availability of mds cluster on mount after wait timeout
Date:   Fri, 14 Feb 2020 11:01:09 -0500
Message-Id: <20200214160149.11681-419-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214160149.11681-1-sashal@kernel.org>
References: <20200214160149.11681-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiubo Li <xiubli@redhat.com>

[ Upstream commit 97820058fb2831a4b203981fa2566ceaaa396103 ]

If all the MDS daemons are down for some reason, then the first mount
attempt will fail with EIO after the mount request times out.  A mount
attempt will also fail with EIO if all of the MDS's are laggy.

This patch changes the code to return -EHOSTUNREACH in these situations
and adds a pr_info error message to help the admin determine the cause.

URL: https://tracker.ceph.com/issues/4386
Signed-off-by: Xiubo Li <xiubli@redhat.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ceph/mds_client.c | 3 +--
 fs/ceph/super.c      | 5 +++++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index ee02a742fff57..8c1f04c3a684c 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -2552,8 +2552,7 @@ static void __do_request(struct ceph_mds_client *mdsc,
 		if (!(mdsc->fsc->mount_options->flags &
 		      CEPH_MOUNT_OPT_MOUNTWAIT) &&
 		    !ceph_mdsmap_is_cluster_available(mdsc->mdsmap)) {
-			err = -ENOENT;
-			pr_info("probably no mds server is up\n");
+			err = -EHOSTUNREACH;
 			goto finish;
 		}
 	}
diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index b47f43fc2d688..62fc7d46032e8 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -1137,6 +1137,11 @@ static struct dentry *ceph_mount(struct file_system_type *fs_type,
 	return res;
 
 out_splat:
+	if (!ceph_mdsmap_is_cluster_available(fsc->mdsc->mdsmap)) {
+		pr_info("No mds server is up or the cluster is laggy\n");
+		err = -EHOSTUNREACH;
+	}
+
 	ceph_mdsc_close_sessions(fsc->mdsc);
 	deactivate_locked_super(sb);
 	goto out_final;
-- 
2.20.1

