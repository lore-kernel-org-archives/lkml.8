Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A012C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 17:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 719262074D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 17:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598288816;
	bh=pDSFRSTQwnciu5Fe9o6G+gZ7lzOqtlB0ZrjDnXzhTZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rymnGz4rlnG1CCBFa3CtY3eSthAkkpEBP5kFEi1vuID6Qpl7vWAs5pg5BrIdi+c06
	 wYijf4eDyKQV18VvlaF1v46msYWzigV6LnD54Ug74xpcnzbjJbYbKydqy8111SSeMe
	 njrK8I7u7dDJtrZusJSFo7l8B4qlISOkgnQ5io3U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726972AbgHXRGy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 13:06:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:41056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728442AbgHXQia (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 12:38:30 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD17922D6F;
        Mon, 24 Aug 2020 16:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598287080;
        bh=pDSFRSTQwnciu5Fe9o6G+gZ7lzOqtlB0ZrjDnXzhTZM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UGBYzxhvKE6YyY4gRKBUDPbdBgRwong+SZXY1XdqFTNQlp/Y3aoPsmCjnCIXjuc55
         fNAcL2o133vX56+WeQZOF+XtLALU3A7Em8Im2lJ1wOpv5SymnpQ9Dk1JYRVdFDkbcJ
         WyDBbipBUlqQefmAkPIosVmOog0W1k19bnob/1Ss=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>, Lukas Czerner <lczerner@redhat.com>,
        Theodore Ts'o <tytso@mit.edu>, Sasha Levin <sashal@kernel.org>,
        linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 07/38] ext4: handle error of ext4_setup_system_zone() on remount
Date:   Mon, 24 Aug 2020 12:37:19 -0400
Message-Id: <20200824163751.606577-7-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200824163751.606577-1-sashal@kernel.org>
References: <20200824163751.606577-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index 92a6741c4bdd9..e8923013accc0 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5563,7 +5563,10 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
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

