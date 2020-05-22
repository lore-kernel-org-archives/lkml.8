Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C20F9C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 14:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DEDF221FF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 14:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590159126;
	bh=NMEBRsZuFeSwo6hyj6E/8Y3EaRKS6l+MKMDuJjdmF6c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1mtyZm+VYEy3scyD2U+AVyH54nRecjsmhydcl7z58tMJC3abY5/BJB+CY09SUa4ZF
	 NgVdoDS//yHRt4Sj4Td5O34MpWdP/QZNov4Frz7mCtPal/+b0s7a++dHfhbBYvmAun
	 /1MQATgUz6DFRVxM5IrWEUB8kUFd+E/oXmPKeQHs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731190AbgEVOwF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 10:52:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:53956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731120AbgEVOvv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 10:51:51 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D25BE2145D;
        Fri, 22 May 2020 14:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590159111;
        bh=NMEBRsZuFeSwo6hyj6E/8Y3EaRKS6l+MKMDuJjdmF6c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yMQyMVsqQ5ES2OPbgudMkdQbSBbUCKj77S6SpChfca1fhcYO3vuHT8N7AiEHicKSo
         /gvgOCyInymcX+m2xk/Ok6NDZDBGjzq7jYzkGZBGZdVYtKClk1zpSzfTPp0RdVSZ+2
         WvlVqIijFM6gnYiYv0xvxXAz6FasBEfvjoM6Jvlc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Bob Peterson <rpeterso@redhat.com>,
        Sasha Levin <sashal@kernel.org>, cluster-devel@redhat.com
Subject: [PATCH AUTOSEL 4.14 08/13] Revert "gfs2: Don't demote a glock until its revokes are written"
Date:   Fri, 22 May 2020 10:51:37 -0400
Message-Id: <20200522145142.435086-8-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200522145142.435086-1-sashal@kernel.org>
References: <20200522145142.435086-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bob Peterson <rpeterso@redhat.com>

[ Upstream commit b14c94908b1b884276a6608dea3d0b1b510338b7 ]

This reverts commit df5db5f9ee112e76b5202fbc331f990a0fc316d6.

This patch fixes a regression: patch df5db5f9ee112 allowed function
run_queue() to bypass its call to do_xmote() if revokes were queued for
the glock. That's wrong because its call to do_xmote() is what is
responsible for calling the go_sync() glops functions to sync both
the ail list and any revokes queued for it. By bypassing the call,
gfs2 could get into a stand-off where the glock could not be demoted
until its revokes are written back, but the revokes would not be
written back because do_xmote() was never called.

It "sort of" works, however, because there are other mechanisms like
the log flush daemon (logd) that can sync the ail items and revokes,
if it deems it necessary. The problem is: without file system pressure,
it might never deem it necessary.

Signed-off-by: Bob Peterson <rpeterso@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/gfs2/glock.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 1e2ff4b32c79..aea1ed0aebd0 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -636,9 +636,6 @@ __acquires(&gl->gl_lockref.lock)
 			goto out_unlock;
 		if (nonblock)
 			goto out_sched;
-		smp_mb();
-		if (atomic_read(&gl->gl_revokes) != 0)
-			goto out_sched;
 		set_bit(GLF_DEMOTE_IN_PROGRESS, &gl->gl_flags);
 		GLOCK_BUG_ON(gl, gl->gl_demote_state == LM_ST_EXCLUSIVE);
 		gl->gl_target = gl->gl_demote_state;
-- 
2.25.1

