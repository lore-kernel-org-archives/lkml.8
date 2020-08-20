Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD90BC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9561F2173E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597915700;
	bh=qJmEpL7tQCrTn65OLAj/uvcxZFClayXp+iHkQUQEPGA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yZWs9fXZr2AFwhLEfIc67S0c7YjUNyl+GWqBtC30ToXKLZpElLhyTdQ+hEKlKRiFX
	 Ptzs0YIb0kGeDAiR1P5Bu8s2ZS0tt8JNlccG36ZA2+gn7SyuOgp9/knZcJHb9VTRXl
	 O4r2Q57JPtAXh40tdejdcVEL/mJdBpzyv6TVqSi4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbgHTJ2O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 05:28:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:34832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727936AbgHTJ04 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:26:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1367322D2C;
        Thu, 20 Aug 2020 09:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597915615;
        bh=qJmEpL7tQCrTn65OLAj/uvcxZFClayXp+iHkQUQEPGA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SElX8l4P0ygjJRsOue7LR99wPuglwvyOqANe5RQ2mV/l3gpwqc8CmeXCmAqGLpAEi
         1X6TXyRgu4g8qMQc/n3rcLiYB6P8Q+Yze6Z76JkkZaAVedAchi+dVKVDzWaGZlno1m
         srJYnuL/C0ihMRe0GyvdkBos6vjlwtgfg2l77W7Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mikulas Patocka <mpatocka@redhat.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 5.8 076/232] ext2: fix missing percpu_counter_inc
Date:   Thu, 20 Aug 2020 11:18:47 +0200
Message-Id: <20200820091616.491366598@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091612.692383444@linuxfoundation.org>
References: <20200820091612.692383444@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mikulas Patocka <mpatocka@redhat.com>

commit bc2fbaa4d3808aef82dd1064a8e61c16549fe956 upstream.

sbi->s_freeinodes_counter is only decreased by the ext2 code, it is never
increased. This patch fixes it.

Note that sbi->s_freeinodes_counter is only used in the algorithm that
tries to find the group for new allocations, so this bug is not easily
visible (the only visibility is that the group finding algorithm selects
inoptinal result).

Link: https://lore.kernel.org/r/alpine.LRH.2.02.2004201538300.19436@file01.intranet.prod.int.rdu2.redhat.com
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext2/ialloc.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/fs/ext2/ialloc.c
+++ b/fs/ext2/ialloc.c
@@ -80,6 +80,7 @@ static void ext2_release_inode(struct su
 	if (dir)
 		le16_add_cpu(&desc->bg_used_dirs_count, -1);
 	spin_unlock(sb_bgl_lock(EXT2_SB(sb), group));
+	percpu_counter_inc(&EXT2_SB(sb)->s_freeinodes_counter);
 	if (dir)
 		percpu_counter_dec(&EXT2_SB(sb)->s_dirs_counter);
 	mark_buffer_dirty(bh);
@@ -528,7 +529,7 @@ got:
 		goto fail;
 	}
 
-	percpu_counter_add(&sbi->s_freeinodes_counter, -1);
+	percpu_counter_dec(&sbi->s_freeinodes_counter);
 	if (S_ISDIR(mode))
 		percpu_counter_inc(&sbi->s_dirs_counter);
 


