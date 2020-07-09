Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D88C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 01:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3BD9206F6
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 01:57:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rpT763Zt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbgGIB5r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 21:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgGIB5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 21:57:46 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC23C061A0B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 18:57:46 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id u18so299033pfk.10
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 18:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3EOJ8u6cUBdJpk7YFY5mzmvMLrW3UokFC1yt6TbWqsM=;
        b=rpT763ZtXVtRFJZzC+mYrDD5V0TzXR8UbA3D8mmCaw7nudYZxGAy3M7MZ35tvaf0U4
         QSQKbBP4QqPbDs9WKeGDkwoaTWygs6EPVNIOS1JoHnlyhwEv1YzsknMBahVKtsuZ9eZE
         sEIsGewAi3aLHSDEO20X27Aq7AKOBGTRo81IiQppu7LojOnsJL+N3klBSjZ7NHs3ur7Q
         XQ1CFoRzJOcpOfxcNWEgMTzVtr/yhL00CCVXeYGJJqAfKKXeVTcYF5oGzdEiKw/2PwWE
         ZSK+Ue8OQZ4YbL3AJI0DpasraKyocSXJVT0VYFwitIxbVstapK5yQ5RLHUvgImJ/1Od5
         rOeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3EOJ8u6cUBdJpk7YFY5mzmvMLrW3UokFC1yt6TbWqsM=;
        b=G30aXOPCb5Uk7Jm4rcpfapUAFnomuVCj+zHLyKiV4od0C9Su44tUqRYTMdsK0ghjLL
         Vc4fQYx7ltVJYLJow7AAyBL68waEc56MvezKb+dXY1dOrg8PwdhcRepg083dVs8byjcO
         Dhxz4JTjD3J/HmcAy/6qRPzH/PXaRVaeOjydhRqF02QzSCbfnsF2okF7jMky7iepi3u6
         5x9BY6Cqh0fwnQiApJxvF1pRpFl3fH8+WXM/rJaxHKjFoHxOal++M15Pf/P8B8Kus3ow
         2WvQ8DZQMh1FKGCkVsuLL0Tw+aZI5URvlCbtNPUQh4SbnCWCH6/J8JEtfbjj16L0tiDN
         O9vg==
X-Gm-Message-State: AOAM533eVLTm9UPKab9jMD11OxhG4ox5VIZr/S8t1jnkmVcOFNG4d16M
        7/ocO/5a2sLKbjGcBrSNK7MAIk0NytsoPA==
X-Google-Smtp-Source: ABdhPJyKIq9mzhbS1XC/4twlgmQgDolvS0UpiaIdjgwna4HwalmSi95voBSbTp0Bs0VcDe0k7I3T0g==
X-Received: by 2002:a63:6c1:: with SMTP id 184mr53624374pgg.262.1594259865770;
        Wed, 08 Jul 2020 18:57:45 -0700 (PDT)
Received: from daehojeong1.seo.corp.google.com ([2401:fa00:d:1:a6ae:11ff:fe18:6ce2])
        by smtp.gmail.com with ESMTPSA id i21sm911219pfa.18.2020.07.08.18.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 18:57:45 -0700 (PDT)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Subject: [PATCH] f2fs: ignore when len of range in f2fs_sec_trim_file is zero
Date:   Thu,  9 Jul 2020 10:57:39 +0900
Message-Id: <20200709015739.1653668-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.27.0.383.g050319c2ae-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daeho Jeong <daehojeong@google.com>

When end_addr comes to zero, it'll trigger different behaviour.
To prevent this, we need to ignore the case of that range.len is
zero in the function.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/file.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 368c80f8e2a1..98b0a8dbf669 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3813,15 +3813,14 @@ static int f2fs_sec_trim_file(struct file *filp, unsigned long arg)
 	file_start_write(filp);
 	inode_lock(inode);
 
-	if (f2fs_is_atomic_file(inode) || f2fs_compressed_file(inode)) {
+	if (f2fs_is_atomic_file(inode) || f2fs_compressed_file(inode) ||
+			range.start >= inode->i_size) {
 		ret = -EINVAL;
 		goto err;
 	}
 
-	if (range.start >= inode->i_size) {
-		ret = -EINVAL;
+	if (range.len == 0)
 		goto err;
-	}
 
 	if (inode->i_size - range.start < range.len) {
 		ret = -E2BIG;
-- 
2.27.0.383.g050319c2ae-goog

