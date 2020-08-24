Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D69DDC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 02:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD517206BE
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 02:27:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OFMl3Uth"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbgHXC1u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Aug 2020 22:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726737AbgHXC1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 22:27:48 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C463AC061573
        for <linux-kernel@vger.kernel.org>; Sun, 23 Aug 2020 19:27:48 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id d22so4044790pfn.5
        for <linux-kernel@vger.kernel.org>; Sun, 23 Aug 2020 19:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3L3z0BK/0uzC9bSt47v3W+rJZ7YzTzBC3wZRD43cnA4=;
        b=OFMl3Uthl4B0LUygzKyBFNvaulTy/jC3i1c4+bTDhS+JfVlE1Ot+7iTaSa7A0cYIgC
         ngIdFA0oW+svhPsqZrzb30umSCe5MWJMkhJS4yjbld3ED9HzFpX1nGlrsvbiR4B+wJXx
         eCNugCTCDvK3W4/59qg2vF7rS4nqF08H7WjKS9KinevEvXDrvdy8PVTPpEna0Ldlyw+x
         e8YuQQkrobDgmC03rbF1/IA6tX7xWkZz1iclvw+skdbzzyQB0rZNTxDIUWPK4+1ST4dy
         tuablQUHXJWoNUOGsPFkT3AfZx74sJ4A8Va7o3gzQd0mDKx3UGK8jbzUic764wd8LV89
         UesQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3L3z0BK/0uzC9bSt47v3W+rJZ7YzTzBC3wZRD43cnA4=;
        b=bS9lXR33Zo/EdhC7snkI1YP0Z9hGtutg30pRy/iK1QPZpg6U31QA2aEL/gsI56sV4d
         n7XJOYJR8XFqHYqRqV6kenAsjTUP7xyEk8SSkSemWA5YduDD9MjyW5nuiYf3W6s+qFD4
         jD8TtwcWEpdmxNfrBjDQ/5vHy9n0jtDTyv3Q2Vk66HjbEU2D44qHJaBJgN9LNc1gOuYu
         naQYM7PIb3scixKqO7k9/BxMPwNQlDnG6x2l38fHQPXtZk+kkrwrT5eQMkmN3EYBQOAr
         Nq+ipzISV8XGwut1lJcw0CJR/vxqxmmC5d2Cj/erNgB+P0pkMpOsipoLOI067BWPhrcq
         xwKQ==
X-Gm-Message-State: AOAM530nFIaud54SZ0Xvb3dmOtHbiUx+36w/BtXl820NKIgiIEAE+9Xb
        naNwuzIWvKB+mMNvq2JbCGY=
X-Google-Smtp-Source: ABdhPJyb9yhrzs/jrFLLEvgIMxZj0ZMSN8gXD4KQBV3v3y6+nmtMh7UY7CMcC9THd5nxMtDyrs57Cg==
X-Received: by 2002:a63:b24b:: with SMTP id t11mr2123373pgo.233.1598236068198;
        Sun, 23 Aug 2020 19:27:48 -0700 (PDT)
Received: from thinkpad.teksavvy.com (104.36.148.139.aurocloud.com. [104.36.148.139])
        by smtp.gmail.com with ESMTPSA id g15sm9413260pfh.70.2020.08.23.19.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2020 19:27:47 -0700 (PDT)
From:   Rustam Kovhaev <rkovhaev@gmail.com>
To:     anton@tuxera.com, linux-ntfs-dev@lists.sourceforge.net
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        Rustam Kovhaev <rkovhaev@gmail.com>
Subject: [PATCH] ntfs: add check for mft record size in superblock
Date:   Sun, 23 Aug 2020 19:28:04 -0700
Message-Id: <20200824022804.226242-1-rkovhaev@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

number of bytes allocated for mft record should be equal to the mft
record size stored in ntfs superblock
as reported by syzbot, userspace might trigger out-of-bounds read by
dereferencing ctx->attr in ntfs_attr_find()

Reported-and-tested-by: syzbot+aed06913f36eff9b544e@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=aed06913f36eff9b544e
Signed-off-by: Rustam Kovhaev <rkovhaev@gmail.com>
Acked-by: Anton Altaparmakov <anton@tuxera.com>
---
 fs/ntfs/inode.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
index 9bb9f0952b18..caf563981532 100644
--- a/fs/ntfs/inode.c
+++ b/fs/ntfs/inode.c
@@ -1810,6 +1810,12 @@ int ntfs_read_inode_mount(struct inode *vi)
 		brelse(bh);
 	}
 
+	if (le32_to_cpu(m->bytes_allocated) != vol->mft_record_size) {
+		ntfs_error(sb, "Incorrect mft record size %u in superblock, should be %u.",
+				le32_to_cpu(m->bytes_allocated), vol->mft_record_size);
+		goto err_out;
+	}
+
 	/* Apply the mst fixups. */
 	if (post_read_mst_fixup((NTFS_RECORD*)m, vol->mft_record_size)) {
 		/* FIXME: Try to use the $MFTMirr now. */
-- 
2.28.0

