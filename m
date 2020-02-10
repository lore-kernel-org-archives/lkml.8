Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2819C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD1B120714
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581339394;
	bh=DBS3bWP9jhdTH7Nb0QLsjiWl/ZCdHHkWV1jvth3YAVs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=n8sNDdnRr5oKTAac0zw7NoQwtTHIG8PoDS8EQ4zD6BrxrwWKJ5JjpuoWhYEtb57i5
	 0zF6xRCnzq5MK6Mf8z4gFqVnHFPevFC3DV/HolQ/74G1JyGJNUccRLFZNYqs06mk53
	 19Y/Wv8AmhMnLAelfcC6C1+D/zrlXKtI7hM542VQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730166AbgBJM4e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 07:56:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:44294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730034AbgBJMli (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:41:38 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97AB120838;
        Mon, 10 Feb 2020 12:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338497;
        bh=DBS3bWP9jhdTH7Nb0QLsjiWl/ZCdHHkWV1jvth3YAVs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oLoBzsoYWnI1MopHhsJoKcxwHeYJgPc3oQ8gXkDzZypcsypAC5NCxswad/+H8yxhi
         Pw0E4GQFlna5G7bR+JGg2LyQSo/vyQGUYi7aykEKhkd0J6K06lzl7nOdF2qOnz/IsM
         BFMtAR6iN0bYloIcjYbNznxc3ITmGBl9jh8fr53A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 5.5 287/367] ext2: Adjust indentation in ext2_fill_super
Date:   Mon, 10 Feb 2020 04:33:20 -0800
Message-Id: <20200210122450.381187294@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122423.695146547@linuxfoundation.org>
References: <20200210122423.695146547@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>

commit d9e9866803f7b6c3fdd35d345e97fb0b2908bbbc upstream.

Clang warns:

../fs/ext2/super.c:1076:3: warning: misleading indentation; statement is
not part of the previous 'if' [-Wmisleading-indentation]
        sbi->s_groups_count = ((le32_to_cpu(es->s_blocks_count) -
        ^
../fs/ext2/super.c:1074:2: note: previous statement is here
        if (EXT2_BLOCKS_PER_GROUP(sb) == 0)
        ^
1 warning generated.

This warning occurs because there is a space before the tab on this
line. Remove it so that the indentation is consistent with the Linux
kernel coding style and clang no longer warns.

Fixes: 41f04d852e35 ("[PATCH] ext2: fix mounts at 16T")
Link: https://github.com/ClangBuiltLinux/linux/issues/827
Link: https://lore.kernel.org/r/20191218031930.31393-1-natechancellor@gmail.com
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext2/super.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/fs/ext2/super.c
+++ b/fs/ext2/super.c
@@ -1073,9 +1073,9 @@ static int ext2_fill_super(struct super_
 
 	if (EXT2_BLOCKS_PER_GROUP(sb) == 0)
 		goto cantfind_ext2;
- 	sbi->s_groups_count = ((le32_to_cpu(es->s_blocks_count) -
- 				le32_to_cpu(es->s_first_data_block) - 1)
- 					/ EXT2_BLOCKS_PER_GROUP(sb)) + 1;
+	sbi->s_groups_count = ((le32_to_cpu(es->s_blocks_count) -
+				le32_to_cpu(es->s_first_data_block) - 1)
+					/ EXT2_BLOCKS_PER_GROUP(sb)) + 1;
 	db_count = (sbi->s_groups_count + EXT2_DESC_PER_BLOCK(sb) - 1) /
 		   EXT2_DESC_PER_BLOCK(sb);
 	sbi->s_group_desc = kmalloc_array (db_count,


