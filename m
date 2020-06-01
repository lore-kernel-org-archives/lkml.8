Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D472C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E0B0206C3
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591037267;
	bh=Wf9/1WeOqSaAptubgs0TD76hXWpfBaHk8chnXJyMlV8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Vu3CSoULKhwFhGKi1fypNlypn+vaC1290VjPe+CX16ZvDRRJWiAHXc6t09+MXGY5o
	 9Zp5ikAP1AGIxqrja4z4wHXA8ES/zv0HO2SP9wbSkOXNFuZ0RbRbcf3ihbI+eCkM1a
	 qwooQVImww0SY7xZ1UkBk6Lan2fRqIKcBA0vkOZE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730668AbgFASIG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 14:08:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:53528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730605AbgFASHh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 14:07:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0FFFE206E2;
        Mon,  1 Jun 2020 18:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591034856;
        bh=Wf9/1WeOqSaAptubgs0TD76hXWpfBaHk8chnXJyMlV8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rdzj7LgFcHU9VXB5jLZpnnd/ebIt/fdaaCAFCM7u3EgxcM44I6DVMnkGZiN82/Moo
         MSnOhYSdB3INWaUm0ktFzlupimduRFxhUN9TntYj6qlxJVJYE0Cbr31F0RaLKcK519
         oyp+DTrTES31YQoxjas+s+DKghXu7NJYsezDBm/k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andreas Gruenbacher <agruenba@redhat.com>,
        Bob Peterson <rpeterso@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 043/142] gfs2: Grab glock reference sooner in gfs2_add_revoke
Date:   Mon,  1 Jun 2020 19:53:21 +0200
Message-Id: <20200601174042.382023156@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200601174037.904070960@linuxfoundation.org>
References: <20200601174037.904070960@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andreas Gruenbacher <agruenba@redhat.com>

[ Upstream commit f4e2f5e1a527ce58fc9f85145b03704779a3123e ]

This patch rearranges gfs2_add_revoke so that the extra glock
reference is added earlier on in the function to avoid races in which
the glock is freed before the new reference is taken.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Signed-off-by: Bob Peterson <rpeterso@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/gfs2/log.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/gfs2/log.c b/fs/gfs2/log.c
index 47bc27d4169e..110e5c4db819 100644
--- a/fs/gfs2/log.c
+++ b/fs/gfs2/log.c
@@ -598,13 +598,13 @@ void gfs2_add_revoke(struct gfs2_sbd *sdp, struct gfs2_bufdata *bd)
 	struct buffer_head *bh = bd->bd_bh;
 	struct gfs2_glock *gl = bd->bd_gl;
 
+	sdp->sd_log_num_revoke++;
+	if (atomic_inc_return(&gl->gl_revokes) == 1)
+		gfs2_glock_hold(gl);
 	bh->b_private = NULL;
 	bd->bd_blkno = bh->b_blocknr;
 	gfs2_remove_from_ail(bd); /* drops ref on bh */
 	bd->bd_bh = NULL;
-	sdp->sd_log_num_revoke++;
-	if (atomic_inc_return(&gl->gl_revokes) == 1)
-		gfs2_glock_hold(gl);
 	set_bit(GLF_LFLUSH, &gl->gl_flags);
 	list_add(&bd->bd_list, &sdp->sd_log_revokes);
 }
-- 
2.25.1



