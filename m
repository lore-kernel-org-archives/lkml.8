Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BDA9C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 01:18:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5351E2074A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 01:18:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YGdQ0TMT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbgHZBSj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 21:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbgHZBSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 21:18:38 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066F3C061574;
        Tue, 25 Aug 2020 18:18:37 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id 31so192986pgy.13;
        Tue, 25 Aug 2020 18:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0Rspx/dCRtgy23dvgpsPYPBe6qdr1VVjOb1peeTgm9w=;
        b=YGdQ0TMT9MrHliaGMxXmSaeSv3VzvmjWh0k0cZ6s21Sa6AR0NebM9s/tq5SrY2Ss76
         Kiv4kQNUvlGt5x/sE+tAqha0xw1lhSJRHon/OBINVE/C4EVT0GzAzNg2nP6mbSpDl1xN
         W3oPrv8pnLQ5h7f3F7Ayg6Ji9fEtfXR70bhtiQF3qbBckfagdGoyrsI4LqcwgLCv5CiD
         p5Pf7tBdzOC/55K/ywigtzVsWDYf4Vepp8ouH6938TsfynafQ5etH+pXfzV+WDfx9JHI
         p0O8VUP0gzqj+8OC0c/dBM7sHEhwZOM0oFPfpdHWCznafdrAkV/RFJjOlQdGHSCz64KZ
         uRHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0Rspx/dCRtgy23dvgpsPYPBe6qdr1VVjOb1peeTgm9w=;
        b=C7+ywMhgvNoagSmum+cvJ9xj7QU+d7Zko/LEnG9ZWIfur+sNG0KBk0bOIWvOwF1Iiu
         BRSBC2Kr6dxhEl5wCVG/10kISOlXJAc+hWjtQ+q3sz5UtmEe5YFCno0aaxl/XROFXv5F
         6X4Cqf1B9Wh2QALcLrXiEVWm9fs9CduTa60DWZt3rwWnuU4kZRZLRoZjnjpcPNc0vffd
         YUv3IOdEoumrXyuvLRAxZ5aJMGAfvUurIFn3tsHqDzm71VX9SKwHJhV//hkLew486b3e
         wJfelnlPgl+QkYilwuURMHdQAmwlLxZwNPxfYEm8hoXCjU4ZoCsm9WBnos5t2ZdU8Wc+
         gEcg==
X-Gm-Message-State: AOAM531PojZz7hkK8AmlaS2exN1ggPUs/R7Yd/rGU3VgEKsVRgG/lYAJ
        FCZKiR8wiP/xqqDQ2XFhSA8=
X-Google-Smtp-Source: ABdhPJx05cG0JDxZAI643LmdBVS8V6W9lCvJTakSA3Dlr0Y30WzuY+N5jxDEEfYKMTmO0h7DATDgyg==
X-Received: by 2002:a63:f44b:: with SMTP id p11mr8442011pgk.324.1598404716798;
        Tue, 25 Aug 2020 18:18:36 -0700 (PDT)
Received: from dc803.localdomain (FL1-111-169-205-196.hyg.mesh.ad.jp. [111.169.205.196])
        by smtp.gmail.com with ESMTPSA id a66sm502945pfa.176.2020.08.25.18.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 18:18:36 -0700 (PDT)
From:   Tetsuhiro Kohada <kohada.t2@gmail.com>
To:     kohada.t2@gmail.com
Cc:     kohada.tetsuhiro@dc.mitsubishielectric.co.jp,
        mori.takahiro@ab.mitsubishielectric.co.jp,
        motai.hirotaka@aj.mitsubishielectric.co.jp,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] exfat: fix pointer error checking
Date:   Wed, 26 Aug 2020 10:18:29 +0900
Message-Id: <20200826011830.14646-1-kohada.t2@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix missing result check of exfat_build_inode().
And use PTR_ERR_OR_ZERO instead of PTR_ERR.

Signed-off-by: Tetsuhiro Kohada <kohada.t2@gmail.com>
---
 fs/exfat/namei.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index 2aff6605fecc..0b12033e1577 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -578,7 +578,8 @@ static int exfat_create(struct inode *dir, struct dentry *dentry, umode_t mode,
 
 	i_pos = exfat_make_i_pos(&info);
 	inode = exfat_build_inode(sb, &info, i_pos);
-	if (IS_ERR(inode))
+	err = PTR_ERR_OR_ZERO(inode);
+	if (err)
 		goto unlock;
 
 	inode_inc_iversion(inode);
@@ -745,10 +746,9 @@ static struct dentry *exfat_lookup(struct inode *dir, struct dentry *dentry,
 
 	i_pos = exfat_make_i_pos(&info);
 	inode = exfat_build_inode(sb, &info, i_pos);
-	if (IS_ERR(inode)) {
-		err = PTR_ERR(inode);
+	err = PTR_ERR_OR_ZERO(inode);
+	if (err)
 		goto unlock;
-	}
 
 	i_mode = inode->i_mode;
 	alias = d_find_alias(inode);
@@ -890,10 +890,9 @@ static int exfat_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 
 	i_pos = exfat_make_i_pos(&info);
 	inode = exfat_build_inode(sb, &info, i_pos);
-	if (IS_ERR(inode)) {
-		err = PTR_ERR(inode);
+	err = PTR_ERR_OR_ZERO(inode);
+	if (err)
 		goto unlock;
-	}
 
 	inode_inc_iversion(inode);
 	inode->i_mtime = inode->i_atime = inode->i_ctime =
-- 
2.25.1

