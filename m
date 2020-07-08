Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6077C433E3
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 15:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95AE4206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 15:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594222923;
	bh=OSjKg/6RBiNfikDVdz0bV9lHOgaCrjXpLfKCFy11GIc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=n06KtZFKVdZGZL4+Qy5DXoe9cphUFAlLY8XorY9EK719u9AH6hxL/aIC0Bbk2jxMM
	 qNV5qx4PLzBQWBU6yJavT2stZy09A2O+7l/1iaajMa/HrGhIVYZjW3t2TLbY1HM0jS
	 CLTuaXj/WUJ1+8FUMeqlN6x5HH4gYK+5L2pqtUwA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730633AbgGHPmC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 11:42:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:49030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730547AbgGHPlz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 11:41:55 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45BC72080D;
        Wed,  8 Jul 2020 15:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594222914;
        bh=OSjKg/6RBiNfikDVdz0bV9lHOgaCrjXpLfKCFy11GIc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XUrhD8ex3y1eE8Lr0FS+m6oeibdaDzIsYB4VxKeCSxhNGy4d8C3fF04OwOGjimWAJ
         y3W2IezORrOKc/C4Lo2R+LauLUlSwDt08jXrSQvQHDIZ0nUROZaBEzHaF7AuEGwIiM
         5omwdN55/nZ6qsEDkHDhuazESAiL6R18edb4cTlY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Bob Peterson <rpeterso@redhat.com>,
        Sasha Levin <sashal@kernel.org>, cluster-devel@redhat.com
Subject: [PATCH AUTOSEL 5.4 15/16] gfs2: read-only mounts should grab the sd_freeze_gl glock
Date:   Wed,  8 Jul 2020 11:41:34 -0400
Message-Id: <20200708154135.3199907-15-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200708154135.3199907-1-sashal@kernel.org>
References: <20200708154135.3199907-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bob Peterson <rpeterso@redhat.com>

[ Upstream commit b780cc615ba4795a7ef0e93b19424828a5ad456a ]

Before this patch, only read-write mounts would grab the freeze
glock in read-only mode, as part of gfs2_make_fs_rw. So the freeze
glock was never initialized. That meant requests to freeze, which
request the glock in EX, were granted without any state transition.
That meant you could mount a gfs2 file system, which is currently
frozen on a different cluster node, in read-only mode.

This patch makes read-only mounts lock the freeze glock in SH mode,
which will block for file systems that are frozen on another node.

Signed-off-by: Bob Peterson <rpeterso@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/gfs2/ops_fstype.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index c26c864590cc3..e0c55765b06d2 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -1168,7 +1168,17 @@ static int gfs2_fill_super(struct super_block *sb, struct fs_context *fc)
 		goto fail_per_node;
 	}
 
-	if (!sb_rdonly(sb)) {
+	if (sb_rdonly(sb)) {
+		struct gfs2_holder freeze_gh;
+
+		error = gfs2_glock_nq_init(sdp->sd_freeze_gl, LM_ST_SHARED,
+					   GL_EXACT, &freeze_gh);
+		if (error) {
+			fs_err(sdp, "can't make FS RO: %d\n", error);
+			goto fail_per_node;
+		}
+		gfs2_glock_dq_uninit(&freeze_gh);
+	} else {
 		error = gfs2_make_fs_rw(sdp);
 		if (error) {
 			fs_err(sdp, "can't make FS RW: %d\n", error);
-- 
2.25.1

