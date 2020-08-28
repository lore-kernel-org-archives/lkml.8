Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33914C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 05:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0936C208CA
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 05:46:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IiWHNQkH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbgH1Fqo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 01:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbgH1Fqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 01:46:43 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F61C061264
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 22:46:43 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id g1so4935632pgm.9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 22:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/jRfQwvLhAtFfxvtMX4zIhuTmuddEpLVIB/VUrkOJiQ=;
        b=IiWHNQkHgZPC0TsBfmFV2AS+Df0EPWPq6l47PKXDOYEfMkf89n+tcSrf6Dj9FuDoFq
         JjdC38OKwhAsfOQIwPVwJOvagoda+tNnCAN5VuRWLsZPkZWEWLxMEqRzdR2yO9eKq7oR
         9gWXu/qcEJaAEKtf9zISVDK6RY4FI9nQcmnC/AgVjxpxB264y6iCcaAui7dkWVTyqC3Y
         t2dajbRqBYWXntoYCMVsge2zwfs4fv/yQpRIWX9YSjgNA2VmvrFRheART4BjT3RwakMq
         QW2H09atY0cjCGswRLUM59GgsM8eoOX1SHjFt/9iK3DkwSh3dWQNov9v+Oh6ZE9VL9k2
         4jxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/jRfQwvLhAtFfxvtMX4zIhuTmuddEpLVIB/VUrkOJiQ=;
        b=Mu7UBz14LEBP/nvgebNfqPnepUypM3dxJHTzeg/49sAbrMNAG9Z/3AMsTU0GjR4DQU
         V+eFKUt7clHCP+PF1WOHa2dWEehF6xmij7NGwC98CkhjeketXBwMCHdn7wb1X5JUJnZh
         zbV9z9S93y+Zt10N/rBGv4JXmNbPqsl2bRhrJ5XDNyqGduKwCYlUcurgF18lCJ5DT6CT
         fRBVKmqgWVOVtn+p7xGJQgwJUYWS35IPbqfgI5DdjezhMyU6HXdyZe6roUd3iAlUqio6
         uorUUIbHFh+9/0HkiU05PHDz+/PqnkYxL0Ae2L7AkOmqAJSElIsi5t7mFdaGQ06aKrOv
         gF/A==
X-Gm-Message-State: AOAM533V+vlTGLlgzUdgryuc+2n6uQoEW6GCzcTs/yQD8nNy+O2dATre
        wUOw/R+/tq7JJ15mz6KAXfTvvU0FVZg=
X-Google-Smtp-Source: ABdhPJzHmHCjGjAmzLG98CQoExTJ+LGEMlsgo0GmZdOidFv3bBky3ImCeVk9HYn548RcP9GGG2Wubw==
X-Received: by 2002:a63:1848:: with SMTP id 8mr16953pgy.347.1598593602391;
        Thu, 27 Aug 2020 22:46:42 -0700 (PDT)
Received: from daehojeong1.seo.corp.google.com ([2401:fa00:d:1:a6ae:11ff:fe18:6ce2])
        by smtp.gmail.com with ESMTPSA id y126sm47252pfy.138.2020.08.27.22.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 22:46:41 -0700 (PDT)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Subject: [PATCH] f2fs: prevent compressed file from being disabled after releasing cblocks
Date:   Fri, 28 Aug 2020 14:46:29 +0900
Message-Id: <20200828054629.583577-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daeho Jeong <daehojeong@google.com>

After releasing cblocks, the compressed file can be accidentally
disabled in compression mode, since it has zero cblocks. As we are
using IMMUTABLE flag to present released cblocks state, we can add
IMMUTABLE state check when considering the compressed file disabling.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/f2fs.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 02811ce15059..14d30740ba03 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3936,6 +3936,8 @@ static inline u64 f2fs_disable_compressed_file(struct inode *inode)
 	if (!f2fs_compressed_file(inode))
 		return 0;
 	if (S_ISREG(inode->i_mode)) {
+		if (IS_IMMUTABLE(inode))
+			return 1;
 		if (get_dirty_pages(inode))
 			return 1;
 		if (fi->i_compr_blocks)
-- 
2.28.0.402.g5ffc5be6b7-goog

