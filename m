Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD0FDC433E4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE0B32078B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597925918;
	bh=BeTxvoNRylsDfFhemtURzi9T/+hctY95SiKy9lsY9ig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JRyEgrblleFIr1XDF2uIz8nO5Y46zqZf9Pwx3z02tIvHxIw2EyEpR7lgjwY0PKOon
	 VnQameBliunZgl0TbS9a/zZIDMNKrvUnldOWiEC4DhxMWTt0niNFLSd0qhkvB3tbIy
	 nlLhNuchCNsflTgGpgZjv6S54L61/qrBVtQ3aw54=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730641AbgHTMSh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 08:18:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:39770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728929AbgHTJ41 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:56:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7CEFA20885;
        Thu, 20 Aug 2020 09:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597917387;
        bh=BeTxvoNRylsDfFhemtURzi9T/+hctY95SiKy9lsY9ig=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sAaCu+4A1KjpbidGyMUKZLIGaRfs+dLKoEEMQfQtKswzAmqlE+Af7cGdioG83k1hg
         uKpVjCaZhBJg3prZG34jm9Q3lm+mvXHf74Hw0JOAGDIrpaD6jPC/ELzAv+0L5ms+sA
         weBaLvyoX6ISoYxe5+kYGa3Biz+KofG1eqP+TULE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Gong Chen <gongchen4@huawei.com>,
        Sheng Yong <shengyong1@huawei.com>,
        Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 014/212] f2fs: check if file namelen exceeds max value
Date:   Thu, 20 Aug 2020 11:19:47 +0200
Message-Id: <20200820091603.051946798@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091602.251285210@linuxfoundation.org>
References: <20200820091602.251285210@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sheng Yong <shengyong1@huawei.com>

[ Upstream commit 720db068634c91553a8e1d9a0fcd8c7050e06d2b ]

Dentry bitmap is not enough to detect incorrect dentries. So this patch
also checks the namelen value of a dentry.

Signed-off-by: Gong Chen <gongchen4@huawei.com>
Signed-off-by: Sheng Yong <shengyong1@huawei.com>
Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/dir.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 79d138756acb5..9a11b48e55ca2 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -845,7 +845,8 @@ bool f2fs_fill_dentries(struct dir_context *ctx, struct f2fs_dentry_ptr *d,
 
 		/* check memory boundary before moving forward */
 		bit_pos += GET_DENTRY_SLOTS(le16_to_cpu(de->name_len));
-		if (unlikely(bit_pos > d->max)) {
+		if (unlikely(bit_pos > d->max ||
+				le16_to_cpu(de->name_len) > F2FS_NAME_LEN)) {
 			f2fs_msg(F2FS_I_SB(d->inode)->sb, KERN_WARNING,
 				"%s: corrupted namelen=%d, run fsck to fix.",
 				__func__, le16_to_cpu(de->name_len));
-- 
2.25.1



