Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 115E2C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 09:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C73122077D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 09:31:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TVgfueVR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731850AbgDAJbW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 05:31:22 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40448 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbgDAJbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 05:31:22 -0400
Received: by mail-pf1-f195.google.com with SMTP id c20so9289338pfi.7;
        Wed, 01 Apr 2020 02:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=gMAKGvyt80CsKl5Gzp5LRaS8afON70sj+HuALy1T8rg=;
        b=TVgfueVRlPbXETJpldsNh5pMcGNHmDNQLimKsQg2p1Yre2IUNgWQKigI2EkqXz5Qds
         POyU8aEc8ldR1RoP0kUXHoG/WtDaIMDXFHWVeFBdRqvlVOtIg5mDaHzyxRFRZNfTVvQr
         eMvZokwee/UAi/oCDYMQQIo9MGFrR5LX1nuuvzdy7Fs2DvQ0hjrd1I5Tj7x1aBLCWUh+
         e7FhbZ5oWBe3hUHuRzhyrrx2/dp/WrRL/gOPUj+u5bSahoHEOrGfBkQJ11Y+5CdS+yl+
         +Brg3LW5l4TTPuJOP6NOGyHeOBP/4VXC0MMTpbrFpH4QXbqbRt13AwqgGv945VWuXtiI
         wbSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gMAKGvyt80CsKl5Gzp5LRaS8afON70sj+HuALy1T8rg=;
        b=NxAiizYpPWswiZMTs/7Ck8LbC4lZ19M1OeA9kiJiWfBS+E/OWOgWplC5SEeeXgSk3d
         egxct2fjjIhN2DeSv7LMI7rPzI/4AT/eYMnAe+5iDEIYBIsSYX2xYVdQ5kKyKFupjquo
         yH7t9lTatGSpEzOETSMcuZKlFAtKZucesLAW+nsJpUFQEPm8J/lATFz6yP0MMSDnpQ/P
         dJI2oMpFttOzsSH6XT0PumBOQCM7GAv+SZd+6vl+0X4Ah6h33YXRUT2D91clGxXYCAGY
         M2CQ7p3dwu0UMdCpWU3hoGFIvqj+c535+7s2E6DapaUE+DQd7ROGT/ATJi8U7pQZgNVi
         JYYg==
X-Gm-Message-State: ANhLgQ37mx0X247tepmF9STsmZb/sRZzfMrBhmgqDc5Kmo9jlLLniuls
        w3feGLMahOwQvoe/M73YbcC4L8q2
X-Google-Smtp-Source: ADFU+vtKITRvwWWsjicQ0rfmm9lw3FXKeK4Ip9aOyFDsOH77UranS4ajGhDB6UOSlxVAdMHEQJzalQ==
X-Received: by 2002:a65:5905:: with SMTP id f5mr20537481pgu.87.1585733481158;
        Wed, 01 Apr 2020 02:31:21 -0700 (PDT)
Received: from india11.lab ([205.234.21.5])
        by smtp.gmail.com with ESMTPSA id q123sm1209116pfb.54.2020.04.01.02.31.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 01 Apr 2020 02:31:20 -0700 (PDT)
From:   Chakra Divi <chakragithub@gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     chakragithub@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] fuse:rely on fuse_perm for exec when no mode bits set
Date:   Wed,  1 Apr 2020 09:31:14 +0000
Message-Id: <1585733475-5222-1-git-send-email-chakragithub@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In current code, for exec we are checking mode bits
for x bit set even though the fuse_perm_getattr returns
success. Changes in this patch avoids mode bit explicit
check, leaves the exec checking to fuse file system
in uspace.

Signed-off-by: Chakra Divi <chakragithub@gmail.com>
---
 fs/fuse/dir.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index de1e2fde..7b44c4e 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1196,12 +1196,7 @@ static int fuse_permission(struct inode *inode, int mask)
 		err = fuse_access(inode, mask);
 	} else if ((mask & MAY_EXEC) && S_ISREG(inode->i_mode)) {
 		if (!(inode->i_mode & S_IXUGO)) {
-			if (refreshed)
-				return -EACCES;
-
 			err = fuse_perm_getattr(inode, mask);
-			if (!err && !(inode->i_mode & S_IXUGO))
-				return -EACCES;
 		}
 	}
 	return err;
-- 
2.7.4

