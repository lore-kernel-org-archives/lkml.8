Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B16C54FCB
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 14:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 948A720706
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 14:33:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FT3N2Knt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbgDZOdn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 10:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbgDZOdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 10:33:43 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D9AC061A0F;
        Sun, 26 Apr 2020 07:33:42 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id r14so7477880pfg.2;
        Sun, 26 Apr 2020 07:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=HfHjVgi++7EfIVCntmGsu3iQ24Hd2wLCepiTOzuKJAY=;
        b=FT3N2KntlqZX4SWoQy31VFT1xAhTxmkqJADP5jbdIry4miYnkqAJ1vvXCV9HR0dupc
         g86HFiPrNA9NOhS72GWPXZbn7Xs9HtK/cbFDTGq2BR4Yp8C0tZgzfJ4tvZmYgyBYIB9L
         yAwOgIW568Bv49WtXP7nbid5AUHKLai45k1aN5nyJUbzFHfWSESUnCt/Z8KM+HkzGGHP
         CNCJJW4qkUm6QXYiPz9HlbbXjgI5LS8LWS/Faow1v4OyUR2pO3KTIL505rFm5aUyKhmu
         Au4bjoi2jNLPH2s80vJJ4QrCBTD5VUNIbW3l1s9gx0jrUG1UX/en0/etrYr5k1UTL+nB
         D1rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HfHjVgi++7EfIVCntmGsu3iQ24Hd2wLCepiTOzuKJAY=;
        b=djm9J1+FPW7D1cmCMcjtZ3S3ZioAFOPNIsJjyPiNstiJoX3zb+0Sd3wN/QR01HsmqA
         3fwiPw95PiwsNfa03ZLjTBzq7gQ4IlV4EcErv55/4eF54/w4myk+4jLayGMkp4L9csRs
         YGkjGX/sd3HOUpQfCIngZul0kT+e7CPUpS62spI3yscNGtPNg4SxlF6QPseHvpfE3T4b
         yocwgCsUFcNPNR9HEfIaneMnjdrvGTAekYDa2ek8XMvDqgKhPhu1paJv8aWGrHw0CKTd
         bObxoUzTwYgudWXsjQiy4oRkQj5J/W611doe9yftLNTWUW4p01NOGzvoWcvq+ec/2O52
         GClQ==
X-Gm-Message-State: AGi0PuaP9dbep04L9Kp17Tf/f1TTFb5jEvD1tlUn/4amdW/o2xPiCPru
        7jk6IMmKuBA7jZ9xrs2H0bc=
X-Google-Smtp-Source: APiQypLqMAHWZL71lfSHmPgo7qd4gE7rnNC3md1i+YhL5haoblrAIYmd8Psx2JgKhU0Sp5yOgsaU9Q==
X-Received: by 2002:a62:15d8:: with SMTP id 207mr18423105pfv.140.1587911621942;
        Sun, 26 Apr 2020 07:33:41 -0700 (PDT)
Received: from ubuntu.localdomain ([220.116.27.194])
        by smtp.gmail.com with ESMTPSA id x66sm10065808pfb.173.2020.04.26.07.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2020 07:33:41 -0700 (PDT)
From:   youngjun <her0gyugyu@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, youngjun <her0gyugyu@gmail.com>
Subject: [PATCH] inotify: Fix error return code assignment flow.
Date:   Sun, 26 Apr 2020 07:33:16 -0700
Message-Id: <20200426143316.29877-1-her0gyugyu@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If error code is initialized -EINVAL, there is no need to assign -EINVAL.

Signed-off-by: youngjun <her0gyugyu@gmail.com>
---
 fs/notify/inotify/inotify_user.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
index 81ffc8629fc4..f88bbcc9efeb 100644
--- a/fs/notify/inotify/inotify_user.c
+++ b/fs/notify/inotify/inotify_user.c
@@ -764,20 +764,18 @@ SYSCALL_DEFINE2(inotify_rm_watch, int, fd, __s32, wd)
 	struct fsnotify_group *group;
 	struct inotify_inode_mark *i_mark;
 	struct fd f;
-	int ret = 0;
+	int ret = -EINVAL;
 
 	f = fdget(fd);
 	if (unlikely(!f.file))
 		return -EBADF;
 
 	/* verify that this is indeed an inotify instance */
-	ret = -EINVAL;
 	if (unlikely(f.file->f_op != &inotify_fops))
 		goto out;
 
 	group = f.file->private_data;
 
-	ret = -EINVAL;
 	i_mark = inotify_idr_find(group, wd);
 	if (unlikely(!i_mark))
 		goto out;
-- 
2.17.1

