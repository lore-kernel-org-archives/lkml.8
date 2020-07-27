Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68F98C433E8
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47E7D207FC
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:28:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IfKrJo2o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732727AbgG0O2o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 10:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732411AbgG0O2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 10:28:39 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6FDC061794;
        Mon, 27 Jul 2020 07:28:39 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id w2so9614019pgg.10;
        Mon, 27 Jul 2020 07:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nUFJGvnWyF6qoYfPbdIhfrpvCAwFxFbm++nM0m4j1+A=;
        b=IfKrJo2o03JmvLHa+pQ2r8tvOMDEMmMS9689Tf2c5z77DEloP8Eb99Osg4bcOQndKD
         BV/TOFVYF4CI/SFNAJ3eS04KWPGS17hc4VK6WghPxgZENZrR/+7nMFarP0iNIKRlD5M7
         ksIbJaoAhkqJ/FWyV51biNozuvKJVN8UvT/lbXLrf/cit6S0+8IZSn6HXA2rvBgumxQv
         t3cSnKd9UoeA7TenvxvDRoB7sik8lG+xVVQqwHAVXx5vlmuXx5f/bhPt8HGUQ3F/ZgpV
         eeAR3yk6wDpzW7MtqznGl0yz2Gy8tHJtQDCsB+lmKpDCLJJcMGWL+9KagLTS5j9rCl4A
         ng8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nUFJGvnWyF6qoYfPbdIhfrpvCAwFxFbm++nM0m4j1+A=;
        b=FDpABy/3xCHprFbN+Hf2K5XhvUihlo+u87CwWWMT9aILKNIaoPD9hNMy5A5/ZD3yNx
         BDMIU3hY60z9LbGSUHg1oQWTTckqcyzW9ez3okOxv3ecolu7NdnFlaObFcs8zHQ4n38s
         E7ZvhJNv2za8jTw1aWhfGLrFELTYJjklXqMPThTF9O/955wjK45xPAivG46ju1Wq3MXP
         hFhNVcdg7c71NAmlcfdQvrfj1i0afjLtb8/MtCWFibyGGDnPMia3y30yH1yDesfacDww
         HCCUM5fKZEg8F+aWgIeOoBCWz0WE6Xdk9/hmnZ3xyCA825RV0XP+TqAEn/FoxpBZStTQ
         3Itw==
X-Gm-Message-State: AOAM533ieslQ/teov/x8OUzEHYcRxqO0CPwiIWOxsmPWxekXzrwQHCR3
        rLpweUNzbtPAKLK08uIb6vJ5hHYsG10=
X-Google-Smtp-Source: ABdhPJz+LB2PyulqzjiWfke9EZOICH+YN/+6af4fUve97mH3sDkGRZSBUDavbRtzPrfUL+p3AWQ6yQ==
X-Received: by 2002:a63:d74c:: with SMTP id w12mr14031068pgi.260.1595860118997;
        Mon, 27 Jul 2020 07:28:38 -0700 (PDT)
Received: from carrot.localdomain (i60-35-88-138.s42.a014.ap.plala.or.jp. [60.35.88.138])
        by smtp.gmail.com with ESMTPSA id g18sm15430460pfk.40.2020.07.27.07.28.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Jul 2020 07:28:37 -0700 (PDT)
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-nilfs <linux-nilfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] nilfs2: only call unlock_new_inode() if I_NEW
Date:   Mon, 27 Jul 2020 23:28:29 +0900
Message-Id: <1595860111-3920-2-git-send-email-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1595860111-3920-1-git-send-email-konishi.ryusuke@gmail.com>
References: <1595860111-3920-1-git-send-email-konishi.ryusuke@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

unlock_new_inode() is only meant to be called after a new inode has
already been inserted into the hash table.  But nilfs_new_inode() can
call it even before it has inserted the inode, triggering the WARNING in
unlock_new_inode().  Fix this by only calling unlock_new_inode() if the
inode has the I_NEW flag set, indicating that it's in the table.

Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
---
 fs/nilfs2/inode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/nilfs2/inode.c b/fs/nilfs2/inode.c
index 28009ec54420..3318dd1350b2 100644
--- a/fs/nilfs2/inode.c
+++ b/fs/nilfs2/inode.c
@@ -388,7 +388,8 @@ struct inode *nilfs_new_inode(struct inode *dir, umode_t mode)
 
  failed_after_creation:
 	clear_nlink(inode);
-	unlock_new_inode(inode);
+	if (inode->i_state & I_NEW)
+		unlock_new_inode(inode);
 	iput(inode);  /*
 		       * raw_inode will be deleted through
 		       * nilfs_evict_inode().
-- 
1.8.3.1

