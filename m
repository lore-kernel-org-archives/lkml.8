Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C662C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 03:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC4FA206C0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 03:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586490668;
	bh=/wQ7uviOaOfZa8i5ALz8UvpYl9DPjVpNJlMKnJyGReE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MK7P/n6lh4039du9u3C2N5dkaFIyA4ahakr6rRaW8H7PsRPJWWm75A1/hTff+bGGC
	 yGmB0g9lcI3n2OCHDgPF8sgxBfVEusyc1xkonX6mznSxAJQAXXNXAkm43aigs8YRm9
	 OES88vpiiYh/zWOJ8vM85osGw7TVoQqTkNwYJO2M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729088AbgDJDvH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 23:51:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:35936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728363AbgDJDu5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 23:50:57 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2CDFE212CC;
        Fri, 10 Apr 2020 03:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586490657;
        bh=/wQ7uviOaOfZa8i5ALz8UvpYl9DPjVpNJlMKnJyGReE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JK4MiVEEyxqaqYoofMXegPQy/vvk+IAZZtt3jFDKXDSaFm1/BG5mbpefI2Pjn9LXa
         t+L+e+pzVidYHmKEf9ypwn55anDGjAVB9o+d532n2xCSgflaGkz/H77RsnqDo2sv1y
         lZbTky/gjouQ/yEzaKqEReDeGvIv0Q58Aydf7LNQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Sasha Levin <sashal@kernel.org>, cluster-devel@redhat.com
Subject: [PATCH AUTOSEL 4.14 11/22] gfs2: Don't demote a glock until its revokes are written
Date:   Thu,  9 Apr 2020 23:50:33 -0400
Message-Id: <20200410035044.9698-11-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200410035044.9698-1-sashal@kernel.org>
References: <20200410035044.9698-1-sashal@kernel.org>
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
index aea1ed0aebd0f..1e2ff4b32c79a 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -636,6 +636,9 @@ __acquires(&gl->gl_lockref.lock)
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

