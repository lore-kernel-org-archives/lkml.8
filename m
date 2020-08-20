Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 134BEC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 13:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C92E2207BB
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 13:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597928740;
	bh=qJmEpL7tQCrTn65OLAj/uvcxZFClayXp+iHkQUQEPGA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OHWhjsI1qAXpUgc2q6+OBXp2rzGJWUKa42bcEXeEzAcBbCWYPB6nMapawYDKhzVBW
	 Un5l8bsrkdeLJM2JNRx3Bonqcmfyi2Tumr08Ba67FPar1qQWx/ms33AnTqIhCSrLWo
	 fpa1HtJCzwqEaJwHGwdtnNAA70BG80YvqP0Tie58=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728553AbgHTNFg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 09:05:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:57676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728930AbgHTJjD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:39:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE5B320724;
        Thu, 20 Aug 2020 09:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597916343;
        bh=qJmEpL7tQCrTn65OLAj/uvcxZFClayXp+iHkQUQEPGA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vrVdno16apbMw9XSeH4jU5Uw4E5kYkik5p8CPMRca0s3jaGg6n4sMslh9e0noH/bN
         g/vjOQdLNoOM3re1NI9pH8TpW8LnGE6HGJAnJZzzf6zZeHmWQ44Ct7OepkFXUuKbo3
         h/s8mmjvV0m6NUD2F4u9tbp9zN062SMrTNMW8Xjo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mikulas Patocka <mpatocka@redhat.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 5.7 066/204] ext2: fix missing percpu_counter_inc
Date:   Thu, 20 Aug 2020 11:19:23 +0200
Message-Id: <20200820091609.561659465@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091606.194320503@linuxfoundation.org>
References: <20200820091606.194320503@linuxfoundation.org>
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
 


