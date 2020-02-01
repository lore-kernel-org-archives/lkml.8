Return-Path: <SRS0=DSTS=3V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5D9EC33C9E
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 07:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D34720679
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 07:13:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LT4tkcJp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbgBAHND (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Feb 2020 02:13:03 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35462 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbgBAHND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Feb 2020 02:13:03 -0500
Received: by mail-pl1-f195.google.com with SMTP id g6so3718913plt.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jan 2020 23:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=b6qV3aMBeymGzLwDJRcGDsmyIzVeO9ybJtBlK6sW1Ak=;
        b=LT4tkcJpdMfNNjkKcPBf926I0IBovmA+IhxmnwugQweMj1ahP8yxKDCC0CsQKJGij0
         igofp9nDM5c+Fn0g8DZdNLQM5eq50jT+e4/s+p4idkcY63MEs+WAKZt2AiA2IKCwE6Fv
         xohhNaF7g0WmJzrJTqMiRV+dXbVCp1NdIiEpQMdvQb26urB95RgaHIrs38IdkjR3krgF
         BBxbTRjigrhqN9LAtdsbGAj6CdWfMGbvytuUvm/4Kop3y5ZhAcjHEotq8c5adp1/6+wn
         QXeUoEejdU78JxX8dT5ELHqqDj0U7XO/TIGdHxUo5VOuFNhUYW5w498FVRdrsZqCm0hK
         tQwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=b6qV3aMBeymGzLwDJRcGDsmyIzVeO9ybJtBlK6sW1Ak=;
        b=ckbipmaWB2Sy6k6hI/3U3sIse5Szz4iUhYJTvo184dP41DVdhgKpfo9s+/5nh6Numc
         qX8SZ0c6Eik0LReUk56gBioW6Z0/nPzu2pq3TKEpFym50Be0Z9Lc2tnu+HfPpsL3X/Yi
         ytMFT4g+cAXqFLVBDxI8VE/oy17sp9TWNwQRB283lfCMTmVwcPLVUHrXgBwgrdHMGIc0
         wScWQ6wrD/SFZViqGN32sx2gbLuck+TziCFAgwE+fDFSOrakGeUl8lLQjCtJwKzeFIPc
         UQcMLr1JCQLJdK7QEuCMxMuO00bSlhCLMt7VA66UZTeOke0Hgn9pcyfAhPtrGOY7HouA
         pKQg==
X-Gm-Message-State: APjAAAUqektNeMnK272TojxwZEFwtZ9KaJr3Et2ljqjTk4s1yxKwYAfd
        C68L33783bOcvcFulXdLlJziDkkp89Y=
X-Google-Smtp-Source: APXvYqxLCiRBJbjBml5c58INureWC7xjjuyGVcl0t7NyWRtu1s7zl67uZjrpKH5H5cTKUr2aUmVxLw==
X-Received: by 2002:a17:902:8bc1:: with SMTP id r1mr10192161plo.279.1580541182756;
        Fri, 31 Jan 2020 23:13:02 -0800 (PST)
Received: from localhost ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id k5sm12372180pju.29.2020.01.31.23.13.01
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 31 Jan 2020 23:13:02 -0800 (PST)
From:   qiwuchen55@gmail.com
To:     mark@fasheh.com, jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
        trivial@kernel.org
Cc:     ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org,
        chenqiwu <chenqiwu@xiaomi.com>
Subject: [PATCH] ocfs2: remove trivial nowait check for buffered read/write
Date:   Sat,  1 Feb 2020 15:12:58 +0800
Message-Id: <1580541178-7853-1-git-send-email-qiwuchen55@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: chenqiwu <chenqiwu@xiaomi.com>

Remove trivial nowait check for buffered read/write, since
buffered read is checked in generic_file_read_iter()->
generic_file_buffered_read(), buffered write is checked in
generic_write_checks().

Signed-off-by: chenqiwu <chenqiwu@xiaomi.com>
---
 fs/ocfs2/file.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
index 9876db5..6a5e3b0 100644
--- a/fs/ocfs2/file.c
+++ b/fs/ocfs2/file.c
@@ -2298,9 +2298,6 @@ static ssize_t ocfs2_file_write_iter(struct kiocb *iocb,
 		file->f_path.dentry->d_name.name,
 		(unsigned int)from->nr_segs);	/* GRRRRR */
 
-	if (!direct_io && nowait)
-		return -EOPNOTSUPP;
-
 	if (count == 0)
 		return 0;
 
@@ -2453,9 +2450,6 @@ static ssize_t ocfs2_file_read_iter(struct kiocb *iocb,
 		goto bail;
 	}
 
-	if (!direct_io && nowait)
-		return -EOPNOTSUPP;
-
 	/*
 	 * buffered reads protect themselves in ->readpage().  O_DIRECT reads
 	 * need locks to protect pending reads from racing with truncate.
-- 
1.9.1

