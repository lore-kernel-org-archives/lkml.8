Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E557EC2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 03:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B09E42063A
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 03:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586490985;
	bh=5wLauErA2sXj1hwEOBTS/RNcaB9yDT/S+WliV8V9x+Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=niFbioN4qr2SXBvCy4CqtyZtrlOvblumx21A6pATcAOo3jR1DLXJ4pcCG4gHKQxIz
	 q1bsFe6Z8QiQiUVeqy3r024G7kc+GMWaSLFzCbKODz1lDLov4CEzvZ5vk6DE0K4cME
	 yERH1ExkW5HxvxFeK5pm3kqYiXUxPo9fQKXpLvMY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728882AbgDJD4Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 23:56:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:33808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728614AbgDJDtl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 23:49:41 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C498214D8;
        Fri, 10 Apr 2020 03:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586490581;
        bh=5wLauErA2sXj1hwEOBTS/RNcaB9yDT/S+WliV8V9x+Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lAgnTUGwDfdRl6Pefhu+u1dJ19VG5OEFQuwNfAKBwL9csmK9mHYO0/HcGLteink18
         lOfQnMinLVv70u/kwcxPx1IRYrWiqzdOHb3+OmYw8r/55uVbCb3/7A1A1H/ALKHOFU
         IMxMhFgVuSfQpKCrTSWDmzmuL6RHHylSWDpjVido=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Sasha Levin <sashal@kernel.org>, cluster-devel@redhat.com
Subject: [PATCH AUTOSEL 5.4 27/46] gfs2: Don't demote a glock until its revokes are written
Date:   Thu,  9 Apr 2020 23:48:50 -0400
Message-Id: <20200410034909.8922-27-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200410034909.8922-1-sashal@kernel.org>
References: <20200410034909.8922-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bob Peterson <rpeterso@redhat.com>

[ Upstream commit df5db5f9ee112e76b5202fbc331f990a0fc316d6 ]

Before this patch, run_queue would demote glocks based on whether
there are any more holders. But if the glock has pending revokes that
haven't been written to the media, giving up the glock might end in
file system corruption if the revokes never get written due to
io errors, node crashes and fences, etc. In that case, another node
will replay the metadata blocks associated with the glock, but
because the revoke was never written, it could replay that block
even though the glock had since been granted to another node who
might have made changes.

This patch changes the logic in run_queue so that it never demotes
a glock until its count of pending revokes reaches zero.

Signed-off-by: Bob Peterson <rpeterso@redhat.com>
Reviewed-by: Andreas Gruenbacher <agruenba@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/gfs2/glock.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 0290a22ebccf5..21820a5b388fd 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -639,6 +639,9 @@ __acquires(&gl->gl_lockref.lock)
 			goto out_unlock;
 		if (nonblock)
 			goto out_sched;
+		smp_mb();
+		if (atomic_read(&gl->gl_revokes) != 0)
+			goto out_sched;
 		set_bit(GLF_DEMOTE_IN_PROGRESS, &gl->gl_flags);
 		GLOCK_BUG_ON(gl, gl->gl_demote_state == LM_ST_EXCLUSIVE);
 		gl->gl_target = gl->gl_demote_state;
-- 
2.20.1

