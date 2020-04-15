Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3413EC2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 13:11:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 023B720737
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 13:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586956289;
	bh=z2JrKhRoKKS+q6sD+25g7H8YHyXTUOaWkucZGm0Hnhg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CJQkZVsq9qar/xTAQgJdSnzR79oCNnWjDmhf/lNHGIlUFehGQm4fqwD3ARvmrkiAr
	 XPpeMIszP4pwxb+hh7HWWveVViuId+j5SR27IaTPqAx3AS+pecP3+0TO6EJaXIDcHx
	 /FCJIzyXZvnnqtqoMn+VMSxxG144hhYcLhZ27iq8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506094AbgDONL0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 09:11:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:55008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2897069AbgDOLfj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 07:35:39 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06D84214AF;
        Wed, 15 Apr 2020 11:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586950538;
        bh=z2JrKhRoKKS+q6sD+25g7H8YHyXTUOaWkucZGm0Hnhg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ARV1J8j9WhAIFeB+TZVMJz0tozcxA0hewsYEVEfPk+J3m7JQ/mpz1CX2QhhKn1555
         ySh4beyq0w0XOoMLLBHwoDTkuqlUT5YydEftn22CvjH4c13eccj0RFN9hrc9WKPHS8
         yY5wKS38ToXzgQzW3M+QG70SBKOqDa2WoXb6Ji8M=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sahitya Tummala <stummala@codeaurora.org>,
        Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH AUTOSEL 5.6 046/129] f2fs: Add a new CP flag to help fsck fix resize SPO issues
Date:   Wed, 15 Apr 2020 07:33:21 -0400
Message-Id: <20200415113445.11881-46-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200415113445.11881-1-sashal@kernel.org>
References: <20200415113445.11881-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sahitya Tummala <stummala@codeaurora.org>

[ Upstream commit c84ef3c5e65ccf99a7a91a4d731ebb5d6331a178 ]

Add and set a new CP flag CP_RESIZEFS_FLAG during
online resize FS to help fsck fix the metadata mismatch
that may happen due to SPO during resize, where SB
got updated but CP data couldn't be written yet.

fsck errors -
Info: CKPT version = 6ed7bccb
        Wrong user_block_count(2233856)
[f2fs_do_mount:3365] Checkpoint is polluted

Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/checkpoint.c    | 8 ++++++--
 include/linux/f2fs_fs.h | 1 +
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 9c88fb3d255a2..79aaf06004f65 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1301,10 +1301,14 @@ static void update_ckpt_flags(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	else
 		__clear_ckpt_flags(ckpt, CP_ORPHAN_PRESENT_FLAG);
 
-	if (is_sbi_flag_set(sbi, SBI_NEED_FSCK) ||
-		is_sbi_flag_set(sbi, SBI_IS_RESIZEFS))
+	if (is_sbi_flag_set(sbi, SBI_NEED_FSCK))
 		__set_ckpt_flags(ckpt, CP_FSCK_FLAG);
 
+	if (is_sbi_flag_set(sbi, SBI_IS_RESIZEFS))
+		__set_ckpt_flags(ckpt, CP_RESIZEFS_FLAG);
+	else
+		__clear_ckpt_flags(ckpt, CP_RESIZEFS_FLAG);
+
 	if (is_sbi_flag_set(sbi, SBI_CP_DISABLED))
 		__set_ckpt_flags(ckpt, CP_DISABLED_FLAG);
 	else
diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index ac3f4888b3dfa..3c383ddd92ddd 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -125,6 +125,7 @@ struct f2fs_super_block {
 /*
  * For checkpoint
  */
+#define CP_RESIZEFS_FLAG		0x00004000
 #define CP_DISABLED_QUICK_FLAG		0x00002000
 #define CP_DISABLED_FLAG		0x00001000
 #define CP_QUOTA_NEED_FSCK_FLAG		0x00000800
-- 
2.20.1

