Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90869C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 16:02:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62F6A217D8
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 16:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587052943;
	bh=JVBQ4mJiai4SFGqM9hpLiYzHjPgT+kxE4i+UwDn0DQY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Fg7fxSQhlW14k2zGhT1QsSYMJ7WLo5E7sRI4sRcdmTTNYdkvi6q4hVuuXej7IcL0Z
	 mJPDb8YQLclajUfHwKtsyCYlKEx1VjoGTMDfc+ApodaVpxqAbVIPg090HW2EYSEIJS
	 4mex5KFjg8OtYgCAqCXObT6j9mnGG0G65fDBG7o0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410709AbgDPQCW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 12:02:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:35036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2895308AbgDPN0s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:26:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 914DA217D8;
        Thu, 16 Apr 2020 13:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587043608;
        bh=JVBQ4mJiai4SFGqM9hpLiYzHjPgT+kxE4i+UwDn0DQY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fRgvZBD+SZMr8T9OcR7ZFwH47w0Iq1vHVKOSYOSwo+y7LlqGncXSQkq3s/wkyh8gw
         eSOmyw4OPXsdMxm3nWbJ0F9S+6PB2czQoV99gQG1kd/s8hEkrO4UfoiFs3RaOQgTcr
         W7fBp8B6qqb5l+Vro+NqgambpRf20tLqxO79wJUs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 026/146] gfs2: Dont demote a glock until its revokes are written
Date:   Thu, 16 Apr 2020 15:22:47 +0200
Message-Id: <20200416131246.024198134@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131242.353444678@linuxfoundation.org>
References: <20200416131242.353444678@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index ccdd8c821abd7..f8a5eef3d014b 100644
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



