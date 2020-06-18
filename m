Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EE3AC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDE362224B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592444065;
	bh=+zLQ9jbSByylk5F+uOyvcL0PwIRJajAFhyFm6yZW03w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wTQYVUxWVwJxuLBm/gVqqsw0AsusSUiW4XJgwXx0NHhcJPvRt3hPVQalOB/oly/tj
	 BXldeU1mgRmXH+LRPnkM/dvUXNQWr3nmls5skvqjYobodbVFgvaXSVdMB5fJCLAiBH
	 ozdn/5N1imS1eBYUvHof1dqS1thaxDL3HskG7waw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733031AbgFRBeC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 21:34:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:41854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730864AbgFRBbO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:31:14 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6C382224B;
        Thu, 18 Jun 2020 01:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592443874;
        bh=+zLQ9jbSByylk5F+uOyvcL0PwIRJajAFhyFm6yZW03w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fVrRTy2EF5JTv66C3odJckqIW2FuKTVOe8/mAOQHhkzb7npOT2lEkLeTKhI0yCcnh
         KiA2aoeQU1ni67YZxkc2eAD2lWJ/mfrXy5esOmoaadyJM5ck4SMHB83kGTKnN6V1v6
         tMI+4Wypn0Rz3Za3oTfeL3AuAHTVYCOsqrDLj5s4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Sasha Levin <sashal@kernel.org>, cluster-devel@redhat.com
Subject: [PATCH AUTOSEL 4.4 54/60] gfs2: Allow lock_nolock mount to specify jid=X
Date:   Wed, 17 Jun 2020 21:29:58 -0400
Message-Id: <20200618013004.610532-54-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618013004.610532-1-sashal@kernel.org>
References: <20200618013004.610532-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bob Peterson <rpeterso@redhat.com>

[ Upstream commit ea22eee4e6027d8927099de344f7fff43c507ef9 ]

Before this patch, a simple typo accidentally added \n to the jid=
string for lock_nolock mounts. This made it impossible to mount a
gfs2 file system with a journal other than journal0. Thus:

mount -tgfs2 -o hostdata="jid=1" <device> <mount pt>

Resulted in:
mount: wrong fs type, bad option, bad superblock on <device>

In most cases this is not a problem. However, for debugging and
testing purposes we sometimes want to test the integrity of other
journals. This patch removes the unnecessary \n and thus allows
lock_nolock users to specify an alternate journal.

Signed-off-by: Bob Peterson <rpeterso@redhat.com>
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/gfs2/ops_fstype.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index de7143e2b361..b7b43d00cc6d 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -916,7 +916,7 @@ static int init_per_node(struct gfs2_sbd *sdp, int undo)
 }
 
 static const match_table_t nolock_tokens = {
-	{ Opt_jid, "jid=%d\n", },
+	{ Opt_jid, "jid=%d", },
 	{ Opt_err, NULL },
 };
 
-- 
2.25.1

