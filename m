Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D16B6C4332B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 12:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2CF6206F9
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 12:57:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ly3490A7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728276AbgCWM5I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 08:57:08 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36389 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728189AbgCWM5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 08:57:08 -0400
Received: by mail-pf1-f194.google.com with SMTP id i13so7465296pfe.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 05:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=aK3DeOPBkAJf49C7Fw8X52i7Vx073H/AsUP+vobEGEY=;
        b=ly3490A72/2ieLkbBI5Mnz+tBc4A71HmZmowVGlOolfoe/jZD2H/R6mbyQWsQiUgTu
         kpZ4ZcWsciDi9I3YlrR0LKSqWW8Gv/mkNMUbu7PZW7D74qyZ8RVIstQhlfH+HptO6NL2
         58F85Id8z1kFzPI9eLxKvVzNenX0rjcD4cPfzcNEmAl5dnrwc7oliFKxWPVmJQ+rw6aJ
         QdDETWJk+hHmmYkTfpb7yUgjIg+6p/2afiWL6Td8D2YI0TuVpHn0FNtsgcI/xXyqtR99
         scEkPd+CM0ZeeeNon4UQFyZcGWDBGXAhkpVoPREqvbJhm0I6YqTCmNT8Rzep93Ry1eR6
         K7Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=aK3DeOPBkAJf49C7Fw8X52i7Vx073H/AsUP+vobEGEY=;
        b=EDmEBK9OwDi/4dLugfhnUrT5Ku5y1rnGfcEmhC7BpKwCZ2asUb7/9UqNxYun9DRnUz
         cg2hkYazqIYvLzTErai95syQFKPRkD25Yjl+QBI6flaiBgKr0XD6S/91FshgxoG869tj
         5Re6khK0Ya4AUHbX98MYdxMc6VkH+i8bHXzv7oDh5YTA6bR7iDaDmealLh9dMSljQaxN
         yxdODKqglo5tuDX4/lzfU87TjM+WkZIUSM31lLM7K0LKeh9goHCO+3LmpZZRE5mqFoIF
         5PBjwyB4O+2R2WGvH6jInQXgxaqtxavfxVn3ySuF2/NQSnoIUyz4IIG0K4vx/7TNbbq+
         8IzA==
X-Gm-Message-State: ANhLgQ15G4v8LECXc7TDT8xT4eqCXYv+ApZd5JSX/CPc+if5Kv6ij81E
        +MwQfokoArAjHCvfds+On+ZIxWZdLGGArw==
X-Google-Smtp-Source: ADFU+vtVvcSV9fZ8DxhITlnIBG2HwGYhdhCBJSkI549QSx1wPIH/ONEDafFOV/AnVQHb/CGFjUTRJA==
X-Received: by 2002:a63:2cce:: with SMTP id s197mr22598743pgs.184.1584968226972;
        Mon, 23 Mar 2020 05:57:06 -0700 (PDT)
Received: from localhost ([161.117.239.120])
        by smtp.gmail.com with ESMTPSA id p7sm12922826pjp.1.2020.03.23.05.57.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Mar 2020 05:57:06 -0700 (PDT)
From:   Qiujun Huang <hqjagain@gmail.com>
To:     tglx@linutronix.de, dan.carpenter@oracle.com,
        gregkh@linuxfoundation.org
Cc:     viro@zeniv.linux.org.uk, deepa.kernel@gmail.com,
        darrick.wong@oracle.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, anenbupt@gmail.com,
        Qiujun Huang <hqjagain@gmail.com>
Subject: [PATCH] minix: Fix NULL dereference in alloc_branch()
Date:   Mon, 23 Mar 2020 20:57:00 +0800
Message-Id: <20200323125700.7512-1-hqjagain@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Need to check the return value of sb_getblk.

Reported-by: syzbot+4a88b2b9dc280f47baf4@syzkaller.appspotmail.com
Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
---
 fs/minix/itree_common.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/minix/itree_common.c b/fs/minix/itree_common.c
index 043c3fdbc8e7..6edb0f11e8a0 100644
--- a/fs/minix/itree_common.c
+++ b/fs/minix/itree_common.c
@@ -85,6 +85,10 @@ static int alloc_branch(struct inode *inode,
 			break;
 		branch[n].key = cpu_to_block(nr);
 		bh = sb_getblk(inode->i_sb, parent);
+		if (!bh) {
+			minix_free_block(inode, block_to_cpu(branch[n].key));
+			break;
+		}
 		lock_buffer(bh);
 		memset(bh->b_data, 0, bh->b_size);
 		branch[n].bh = bh;
-- 
2.17.1

