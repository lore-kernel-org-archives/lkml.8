Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B0B5C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:45:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F28AF20BED
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598975131;
	bh=6AVvTKUZefUGBfLQWA2niBSjSCOXjC6YCl26Eoyy9L8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MnC+HGyW/YkGs6lUYLOtT9ky/4mzCh8M4p0v5+2jk96bkMKQiDR/OOvGVuaQ6Hx5u
	 9wB7EvY4fL1Tq3sqXPIKMDLZaw97XqBB3J32KhW2Lle/2w65fQXeisBbZiGj0xDP4h
	 1A8q34ue3umTb5MBquz8LFwKDKRc60nnYODvwH/w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731869AbgIAPp3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 11:45:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:55710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731577AbgIAPmh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:42:37 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BCF14206EF;
        Tue,  1 Sep 2020 15:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598974957;
        bh=6AVvTKUZefUGBfLQWA2niBSjSCOXjC6YCl26Eoyy9L8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qxLw5rc2pyLm1B5awBP1RJOXnEeRetBYIM+jreyR0UNHTwwv0+kYiuDl4RWS3wnOe
         MKUUbCLLWSG1zcMMWO10o5vODkGgGb4NUPZB7OkCowhI7a8MufYpOuxAY4w8YK6Ig1
         oBsvBezkW0WYDgpTb2dAC/8iogM9w1v48Mrq3rRo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lukas Czerner <lczerner@redhat.com>,
        Jan Kara <jack@suse.cz>, Theodore Tso <tytso@mit.edu>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 115/255] ext4: handle error of ext4_setup_system_zone() on remount
Date:   Tue,  1 Sep 2020 17:09:31 +0200
Message-Id: <20200901151006.237645078@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901151000.800754757@linuxfoundation.org>
References: <20200901151000.800754757@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Kara <jack@suse.cz>

[ Upstream commit d176b1f62f242ab259ff665a26fbac69db1aecba ]

ext4_setup_system_zone() can fail. Handle the failure in ext4_remount().

Reviewed-by: Lukas Czerner <lczerner@redhat.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20200728130437.7804-2-jack@suse.cz
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/super.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 85849e5b31b28..54d1c09329e55 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5716,7 +5716,10 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
 		ext4_register_li_request(sb, first_not_zeroed);
 	}
 
-	ext4_setup_system_zone(sb);
+	err = ext4_setup_system_zone(sb);
+	if (err)
+		goto restore_opts;
+
 	if (sbi->s_journal == NULL && !(old_sb_flags & SB_RDONLY)) {
 		err = ext4_commit_super(sb, 1);
 		if (err)
-- 
2.25.1



