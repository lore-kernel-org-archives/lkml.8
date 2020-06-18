Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 673DAC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4356E214DB
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592447077;
	bh=LBoXItQw4tPU5HDPVa0DFO5XKBJKjDaRBmpW4AdW098=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kgSOx09GJa7uV2zohcsj66sQhd5z9P4BKuLZM5caPw1KOuaJewL9yCMpWKYqOfjnV
	 22mqNtoFhkaXqnyFnRJe25MFsd1jwYMRR7DSybf4DvxwEeeLCqXD175/qd2Js1stdY
	 jbUBIYREaukKlgVH4Vyah4LL65A6/MUUerdOcSKE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729367AbgFRBRj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 21:17:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:44806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729409AbgFRBO5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:14:57 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 426852193E;
        Thu, 18 Jun 2020 01:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592442897;
        bh=LBoXItQw4tPU5HDPVa0DFO5XKBJKjDaRBmpW4AdW098=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S6mLUYXGBMMDm67Fp38WaqxFL4vbbA08fYcW22+ufUdlMTF4GuifGilrBdpsoFlhx
         gTN6beHGyGE69g8e5ptpp0ycmVDSq6/MhX1Du+69lFX9wojTXgHVK6ZZzTp6WSFQ/k
         5zpU7P2miaA2HlgzMOXYcDCn+IXUX61Ujh2rblSI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Sasha Levin <sashal@kernel.org>, cluster-devel@redhat.com
Subject: [PATCH AUTOSEL 5.7 318/388] gfs2: Allow lock_nolock mount to specify jid=X
Date:   Wed, 17 Jun 2020 21:06:55 -0400
Message-Id: <20200618010805.600873-318-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618010805.600873-1-sashal@kernel.org>
References: <20200618010805.600873-1-sashal@kernel.org>
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
index e2b69ffcc6a8..094f5fe7c009 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -880,7 +880,7 @@ static int init_per_node(struct gfs2_sbd *sdp, int undo)
 }
 
 static const match_table_t nolock_tokens = {
-	{ Opt_jid, "jid=%d\n", },
+	{ Opt_jid, "jid=%d", },
 	{ Opt_err, NULL },
 };
 
-- 
2.25.1

