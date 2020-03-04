Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8954C3F2CD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 06:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8055320870
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 06:08:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XVR8p2SB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725852AbgCDGHj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 01:07:39 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:55119 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbgCDGHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 01:07:39 -0500
Received: by mail-pj1-f67.google.com with SMTP id dw13so429265pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 22:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=vttavIy9rw/iv9joksuD3LqxV224U+XKvXc8V3d/N6U=;
        b=XVR8p2SBDhhSSScyNLYQ+of0Yg0As+tZwm9aaXtfcCbmMlupp49cHGRcxMkOkG37ry
         4B9BRfR6Hp/83Dc7qDdjQFPIlhuTsqnP42FicUfHf+FEaWABzlfcf0LG0wlR7pSPKsOT
         OBPwl7X7HeYN3wt0flfKXkQsIHsBBgYtt+s2p9pgTG4kenFdBi/7D+kxjN8qX1CF6VMK
         29j4llKIE++A6k2fp4zqGSZSLhHIrp7b3+wwC8l98WoSWh0jr+8KPimgJk+F3YdJe3Xb
         k35yXzYKC9WLkKG+1LPHaPq9X8ej/ReuXy582SfOrc9FD4qRfsLD7nP4bCw0f0/3VoWt
         m23A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vttavIy9rw/iv9joksuD3LqxV224U+XKvXc8V3d/N6U=;
        b=EMlyXG4u6PKLibzi7g8cbq8KjL+n+rwD5wOdmUfjxw014oewoivwvLaTzKklHG+KGE
         niDSOXVPY+akL1eMYf6hEevkqLXyERL2aeOZBdRV2GZyMfEtQ4T+f0tnHY0RYp1U/rAx
         O+f5fR6AU2NVjmtBWUSZPlaNlGCWemuejk5any0rEXuXbuefSHd0qZ4hKU3q5IR+l2Iw
         Ok7QpPUAuYwbmQIT8v4+QKTnLB3LT1jnECSE5XPSjNxdB2Ndv+XSVDFCg6FitlWIIhQy
         M5NR0VqZPsN5cJPmiAfcuCdg33qVCwXWbwcyCDP4bHaJbuOsZoK7159TA0r0vYOryt9d
         Lm/w==
X-Gm-Message-State: ANhLgQ2VEVIV0radOoIdfbPFOdO+kheLxIH1VIKR87esDcyVz6WGeOhw
        TRj6SOeWUSDVrfnHNStr27k=
X-Google-Smtp-Source: ADFU+vuJPShupU8xR/My+s0kwa3YVp9JtDHjI4vdwozPg35taoxGh++zeTC+/e6EtzxrD5jfQug7pQ==
X-Received: by 2002:a17:90a:8042:: with SMTP id e2mr1532217pjw.16.1583302058594;
        Tue, 03 Mar 2020 22:07:38 -0800 (PST)
Received: from VM_0_35_centos.localdomain ([150.109.62.251])
        by smtp.gmail.com with ESMTPSA id m18sm25400051pgd.39.2020.03.03.22.07.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Mar 2020 22:07:38 -0800 (PST)
From:   Qiujun Huang <hqjagain@gmail.com>
To:     anton@tuxera.com
Cc:     linux-ntfs-dev@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Qiujun Huang <hqjagain@gmail.com>
Subject: [PATCH] fs/ntfs: remove not used variable 'base_ni'
Date:   Wed,  4 Mar 2020 14:07:34 +0800
Message-Id: <1583302054-2615-1-git-send-email-hqjagain@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is not used, so can be removed.

Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
---
 fs/ntfs/file.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
index f42967b..e5aab26 100644
--- a/fs/ntfs/file.c
+++ b/fs/ntfs/file.c
@@ -323,7 +323,7 @@ static ssize_t ntfs_prepare_file_for_write(struct kiocb *iocb,
 	unsigned long flags;
 	struct file *file = iocb->ki_filp;
 	struct inode *vi = file_inode(file);
-	ntfs_inode *base_ni, *ni = NTFS_I(vi);
+	ntfs_inode *ni = NTFS_I(vi);
 	ntfs_volume *vol = ni->vol;
 
 	ntfs_debug("Entering for i_ino 0x%lx, attribute type 0x%x, pos "
@@ -365,9 +365,6 @@ static ssize_t ntfs_prepare_file_for_write(struct kiocb *iocb,
 		err = -EOPNOTSUPP;
 		goto out;
 	}
-	base_ni = ni;
-	if (NInoAttr(ni))
-		base_ni = ni->ext.base_ntfs_ino;
 	err = file_remove_privs(file);
 	if (unlikely(err))
 		goto out;
-- 
1.8.3.1

