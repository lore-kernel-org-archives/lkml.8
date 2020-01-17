Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA639C33CAF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 01:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8931F20748
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 01:17:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pMzXKC/H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387910AbgAQBR0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 20:17:26 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35396 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387565AbgAQBR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 20:17:26 -0500
Received: by mail-ed1-f67.google.com with SMTP id f8so20741952edv.2;
        Thu, 16 Jan 2020 17:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fxuQNdhUIKCW/RVBHdhXEt9LGg/38SDYbVWcfsz1CNw=;
        b=pMzXKC/HuXEOwWLI+FUq4Bw7PdFNk4oMMNUmi1a0l/l2pUaJ5RUbGG94w+Pu1cMpd7
         FDrLcrRqWxDWgiLevnO/ILSSxnQQSx4MNxNG9Ezz3QSA+Yc0EyBFjkUg/18mkyA9NGtx
         rSmLxH54ILzwuD04/iotzkSFjodmcej2oGdknXITFz7fTlQUKe9196TyujvuJpEhbp3a
         8cU1oLQyuzPPNi3Np904voLAdHdxsBhQoPAF8yNNofuQlF150ivmXf6gxpktiwY3GDWD
         toaN/w+oDa50cbEMX41DTPzbeoTtBaNYD0KyXiXDgD16iYQWQ3bmNYGBAFC6qbzvaq1G
         F/+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fxuQNdhUIKCW/RVBHdhXEt9LGg/38SDYbVWcfsz1CNw=;
        b=Qf3eLeclTm+S/VkCfN84/lWlw4TE3N+9KXdI09yST6t7xtuG9V0/kcVyZh1pCz9AaJ
         446us0sfCLMse+9BzqwyBz4I6stD5cNl1C1oajTRg5+N/ORTfTsgm9xqNLjzzi1syeQc
         c7rhAADk0FUlG1ND3xv2E8q0Umb4vJvEjAKK07B65M3B9AIfNYHenL7haeD3pCwE75Pr
         cmr1vbM+zPufpen27LJLiCNTH1jFEo2RPKCsIPBCqlpMXrgFrv6r0PpI5iv500Z0uoPy
         BZwQ5fMlbReN5WeRdHdyZw81YVtM6NvGOe8+c8DamEfKopmpzJyFJLoAFxOxKVGXf+VW
         SXFQ==
X-Gm-Message-State: APjAAAUyTpnMDoi+U1POwpacPRChOixmMcVA2URfvbzQUpOK5gDnVHuF
        Nv8Jc1YxMWwVRbbBvBprjVeLcDdy
X-Google-Smtp-Source: APXvYqxUZaSgBaiItsgPCnZzH7pdGOGqVP7fJkjIbrObr2b6LmOz/8V4ccKlKhdArxBCl3QcIlY3SQ==
X-Received: by 2002:a05:6402:1596:: with SMTP id c22mr1253877edv.268.1579223844366;
        Thu, 16 Jan 2020 17:17:24 -0800 (PST)
Received: from localhost.localdomain ([109.126.145.157])
        by smtp.gmail.com with ESMTPSA id m6sm821124ejb.51.2020.01.16.17.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 17:17:23 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fs: optimise kiocb_set_rw_flags()
Date:   Fri, 17 Jan 2020 04:16:41 +0300
Message-Id: <7d493d4872b75fc59556a63ee62c43b30c661ff9.1579223790.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kiocb_set_rw_flags() generates a poor code with several memory writes
and a lot of jumps. Help compilers to optimise it.

Tested with gcc 9.2 on x64-86, and as a result, it its output now is a
plain code without jumps accumulating in a register before a memory
write.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 include/linux/fs.h | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 98e0349adb52..c3db8c80aed4 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3402,22 +3402,27 @@ static inline int iocb_flags(struct file *file)
 
 static inline int kiocb_set_rw_flags(struct kiocb *ki, rwf_t flags)
 {
+	int kiocb_flags = 0;
+
 	if (unlikely(flags & ~RWF_SUPPORTED))
 		return -EOPNOTSUPP;
 
 	if (flags & RWF_NOWAIT) {
 		if (!(ki->ki_filp->f_mode & FMODE_NOWAIT))
 			return -EOPNOTSUPP;
-		ki->ki_flags |= IOCB_NOWAIT;
+		kiocb_flags |= IOCB_NOWAIT;
 	}
 	if (flags & RWF_HIPRI)
-		ki->ki_flags |= IOCB_HIPRI;
+		kiocb_flags |= IOCB_HIPRI;
 	if (flags & RWF_DSYNC)
-		ki->ki_flags |= IOCB_DSYNC;
+		kiocb_flags |= IOCB_DSYNC;
 	if (flags & RWF_SYNC)
-		ki->ki_flags |= (IOCB_DSYNC | IOCB_SYNC);
+		kiocb_flags |= (IOCB_DSYNC | IOCB_SYNC);
 	if (flags & RWF_APPEND)
-		ki->ki_flags |= IOCB_APPEND;
+		kiocb_flags |= IOCB_APPEND;
+
+	if (kiocb_flags)
+		ki->ki_flags |= kiocb_flags;
 	return 0;
 }
 
-- 
2.24.0

