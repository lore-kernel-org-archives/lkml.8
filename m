Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C1DDC2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 12:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 180CB206D5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 12:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586955198;
	bh=pN94x5x7uxtbqoUVG5uTd2WnyY/wPWbDm0ynCsxiyaM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=X7K2/TqOUJzts2gEAbyIPUFO0sPg7lqasR4BUt1Je+lGQaM5PBx/nqQGCrusqz5k2
	 JWM5s7nUL8+7GDkcqAMe6paK+ei9/7nMJBjg/ElO7nHn6zUNGw/87soyFb85NNanp+
	 mROwBhdjwaHoHYVywaBhJ04TZN7Qudh0h7HW0i2Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S370573AbgDOMxQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 08:53:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:33748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2897460AbgDOLma (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 07:42:30 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA5D320768;
        Wed, 15 Apr 2020 11:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586950949;
        bh=pN94x5x7uxtbqoUVG5uTd2WnyY/wPWbDm0ynCsxiyaM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M0zvJlzXljQaCnVeQhp+InaR/N0UBnIeR9rjX6OiVOnPzM4/VXHuW7CRx5veK2ahA
         DeIDobev1Lm1y668SaNAmWWmkaI/KZMk7ZHmgo0J4Kk4S969vqNi8TV8YChUD27PsO
         6i3m/j7mTdInjvMbTg95gSquuB388KkSQ/z6LYX0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Sasha Levin <sashal@kernel.org>, cluster-devel@redhat.com
Subject: [PATCH AUTOSEL 5.5 002/106] gfs2: clear ail1 list when gfs2 withdraws
Date:   Wed, 15 Apr 2020 07:40:42 -0400
Message-Id: <20200415114226.13103-2-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200415114226.13103-1-sashal@kernel.org>
References: <20200415114226.13103-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bob Peterson <rpeterso@redhat.com>

[ Upstream commit 30fe70a85a909a23dcbc2c628ca6655b2c85e7a1 ]

This patch fixes a bug in which function gfs2_log_flush can get into
an infinite loop when a gfs2 file system is withdrawn. The problem
is the infinite loop "for (;;)" in gfs2_log_flush which would never
finish because the io error and subsequent withdraw prevented the
items from being taken off the ail list.

This patch tries to clean up the mess by allowing withdraw situations
to move not-in-flight buffer_heads to the ail2 list, where they will
be dealt with later.

Signed-off-by: Bob Peterson <rpeterso@redhat.com>
Reviewed-by: Andreas Gruenbacher <agruenba@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/gfs2/log.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/fs/gfs2/log.c b/fs/gfs2/log.c
index eb3f2e7b80856..a62e03ebc0ec8 100644
--- a/fs/gfs2/log.c
+++ b/fs/gfs2/log.c
@@ -107,16 +107,22 @@ __acquires(&sdp->sd_ail_lock)
 		gfs2_assert(sdp, bd->bd_tr == tr);
 
 		if (!buffer_busy(bh)) {
-			if (!buffer_uptodate(bh) &&
-			    !test_and_set_bit(SDF_AIL1_IO_ERROR,
+			if (buffer_uptodate(bh)) {
+				list_move(&bd->bd_ail_st_list,
+					  &tr->tr_ail2_list);
+				continue;
+			}
+			if (!test_and_set_bit(SDF_AIL1_IO_ERROR,
 					      &sdp->sd_flags)) {
 				gfs2_io_error_bh(sdp, bh);
 				*withdraw = true;
 			}
-			list_move(&bd->bd_ail_st_list, &tr->tr_ail2_list);
-			continue;
 		}
 
+		if (gfs2_withdrawn(sdp)) {
+			gfs2_remove_from_ail(bd);
+			continue;
+		}
 		if (!buffer_dirty(bh))
 			continue;
 		if (gl == bd->bd_gl)
@@ -866,6 +872,8 @@ void gfs2_log_flush(struct gfs2_sbd *sdp, struct gfs2_glock *gl, u32 flags)
 				if (gfs2_ail1_empty(sdp))
 					break;
 			}
+			if (gfs2_withdrawn(sdp))
+				goto out;
 			atomic_dec(&sdp->sd_log_blks_free); /* Adjust for unreserved buffer */
 			trace_gfs2_log_blocks(sdp, -1);
 			log_write_header(sdp, flags);
@@ -878,6 +886,7 @@ void gfs2_log_flush(struct gfs2_sbd *sdp, struct gfs2_glock *gl, u32 flags)
 			atomic_set(&sdp->sd_freeze_state, SFS_FROZEN);
 	}
 
+out:
 	trace_gfs2_log_flush(sdp, 0, flags);
 	up_write(&sdp->sd_log_flush_lock);
 
-- 
2.20.1

