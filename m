Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29BEFC2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 041B1221F7
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:33:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="skdOKwAS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394374AbgDPOdB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 10:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2392930AbgDPOPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 10:15:35 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2AF4C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 07:15:33 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id t14so4976620wrw.12
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 07:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IYcapwzeMColCF8KnFlRv/qYBOctw6ROjcF5rd7fgio=;
        b=skdOKwASxEhOBn/g9PS2yum98pRbMAknK2ZKr2JtqEq2fTE8ugdFQrsXWU9oocuplS
         Kny5AgKCFODjHpa46G+3Yzx4ZTfGbsX9iMt50sV2bZI+Hc7WhGcyCh1GyeleltgHqTrN
         UBsruV86e5tSwzhFTl9rjQ6TwmOPcXQzU4mSmrnZ4oI6K8nZIJrkAZUBylgzI9xFFLq+
         /y0ZIAOU06lwvJk8NxOt4rScjvZhJPtnsscK9CCUaAerQpAB8BhXAYAJlKC+SI3WXvT6
         zovOipXfnBziDrFUCtILkwFvgzXeF+5EHc1MbDxQib4PyrulNcKeqrCH19i+acowXBrp
         FcJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IYcapwzeMColCF8KnFlRv/qYBOctw6ROjcF5rd7fgio=;
        b=lxxhX40go6pwjC8eAOv3jETCL5zfHGAX8vMc/TUlqBE57+gIAVOjQYuVvPkuayXf2+
         oaBFOrtU4FZ9CqFkzRRywxbeZP9ED8tVizXGLjKcVdIW5vfulf/ETwABoDYQkC6QZH7L
         9flvHrz/M5Jfp6jvsI1O7yB1KI23vXi2iGhVYuB7fTkTodwroXdB4VnKsIquhCwTNdqj
         qHzgtxRed3w9NkmtQWAzGYf34EvMJBKOSczTTo9WFcik4mI6lsW0EDVpRnoA4oLeZP8b
         DhzMAab65PlFrm5hV6+dXzrt7mSE0EZtoOGXFRDZmCqo3xw5dgUWO3k5Q9xTwSVxudI7
         bq7A==
X-Gm-Message-State: AGi0PuYrod+Wkxi9FGSD+J2UiVKz2FQv7gTcj4ASRBMBIrXsxfHPr41t
        kfxqRIwv5F/9XoS3h9exZ6yvnlfPIrw+1g==
X-Google-Smtp-Source: APiQypI9EAMVTw3SYNLWgnKoBzZb+9kZtTOBd42AD/pdBfPsITkaamEbEFiZZfoPuh99rOBzEWm6Ag==
X-Received: by 2002:a05:6000:10c2:: with SMTP id b2mr19061344wrx.118.1587046532585;
        Thu, 16 Apr 2020 07:15:32 -0700 (PDT)
Received: from localhost.localdomain (229.pool85-52-230.static.orange.es. [85.52.230.229])
        by smtp.gmail.com with ESMTPSA id a80sm3758702wme.37.2020.04.16.07.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 07:15:32 -0700 (PDT)
From:   Carlos Guerrero Alvarez <carlosteniswarrior@gmail.com>
To:     tytso@mit.edu
Cc:     adilger.kernel@dilger.ca, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Carlos=20Guerrero=20=C3=81lvarez?= 
        <carlosteniswarrior@gmail.com>
Subject: [PATCH] EXT4: acl: Fix a style issue
Date:   Thu, 16 Apr 2020 16:14:56 +0200
Message-Id: <20200416141456.1089-1-carlosteniswarrior@gmail.com>
X-Mailer: git-send-email 2.25.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Carlos Guerrero Álvarez <carlosteniswarrior@gmail.com>

Fixed an if statement where braces were not needed.

Signed-off-by: Carlos Guerrero Álvarez <carlosteniswarrior@gmail.com>
---
 fs/ext4/acl.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ext4/acl.c b/fs/ext4/acl.c
index 8c7bbf3e566d..b3eba92f38f5 100644
--- a/fs/ext4/acl.c
+++ b/fs/ext4/acl.c
@@ -215,9 +215,8 @@ __ext4_set_acl(handle_t *handle, struct inode *inode, int type,
 				      value, size, xattr_flags);
 
 	kfree(value);
-	if (!error) {
+	if (!error)
 		set_cached_acl(inode, type, acl);
-	}
 
 	return error;
 }
-- 
2.25.2

