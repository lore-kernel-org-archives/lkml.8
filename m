Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A48C2C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 20:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D5BA207F7
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 20:23:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="vqlZYMPw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731098AbgEVUXd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 16:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731076AbgEVUX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 16:23:27 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7717C061A0E
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 13:23:27 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id m7so4827963plt.5
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 13:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4QX6izj81MoWvGB/E4/khaJEguGwrdsEfxjduXmAWvc=;
        b=vqlZYMPww7j3TOIyzxvdW3/q03eVxx/Kt286FLeusp48yDbLJjq0ln6B43V8FbVo3u
         gcdL0IJhfUQanWN/Su6LcPlVskFIZoDE79RbCWvLDvXaYW8oYUjtUGwaSS93SvGaudU0
         Dmja6SkC2nkNK/NZLi3mUHjaKvMiJ/q8BaDYHmBkAv6kq+6dvO1gdhPm3I6e7U2GPx7Z
         Sku/pU0sVdVBRuZriAmdEmXAdP3CLXjBAnqwV47vMFExFJB+158uymcq0+DXz/+vg0wR
         VHJyh2+6hv06m8Qe7Kg6r3uwm07yOeKHHjJ3925Ov3RZPMIzvNUdU2EAIEb5ptM7pC09
         w09g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4QX6izj81MoWvGB/E4/khaJEguGwrdsEfxjduXmAWvc=;
        b=LS1RFMM+t33yna+65ABKIHTyF7s4SVtXj6WZ1QKwjhzG6m1ZT1+E8N+xFEheh9w9Es
         AjY1LCnhqcve3C63mWXE2p3On5Qc6asGimNb9J1Rx7/Fd9zRoBNZUhSHDyWv55i8i79j
         8wwZ2FHLvDeJWoKXX/fbIwxADQ6REMswKammdz7wh6ehGWzoarCsXWAz7Uhu3m1ZQdeY
         /DsJVES2LTv06xscQmeGPYDWrjgUVuYC9O1O2wkn8TTYdDTgGjEAjXAzGOciMvUudBqr
         NQVd5bxG1+ZF8fhLV+AjaTG4v0Rpz/AkbxZ7OwhM8JL64Gp2NfnLH/UIwzagDkI5gvzy
         k3Yg==
X-Gm-Message-State: AOAM5325I+9HDAmsba88YRbBPnLFQjfeTXbjSm4k5IOxoouCvTOScj5z
        ouTXtFy4qipE9G0S7RzdS3S/ow==
X-Google-Smtp-Source: ABdhPJwXSAs80allPBjJsy+8cK/RjOwPK4cXYA3LyZ3dlUNMHIjbWunnLsScPWqcRL/3fjvWEVHJEw==
X-Received: by 2002:a17:902:aa4a:: with SMTP id c10mr8642851plr.0.1590179007178;
        Fri, 22 May 2020 13:23:27 -0700 (PDT)
Received: from x1.lan ([2605:e000:100e:8c61:e0db:da55:b0a4:601])
        by smtp.gmail.com with ESMTPSA id e19sm7295561pfn.17.2020.05.22.13.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 13:23:26 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 07/11] block: flag block devices as supporting IOCB_WAITQ
Date:   Fri, 22 May 2020 14:23:07 -0600
Message-Id: <20200522202311.10959-8-axboe@kernel.dk>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200522202311.10959-1-axboe@kernel.dk>
References: <20200522202311.10959-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/block_dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 86e2a7134513..ec8dccc81b65 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1851,7 +1851,7 @@ static int blkdev_open(struct inode * inode, struct file * filp)
 	 */
 	filp->f_flags |= O_LARGEFILE;
 
-	filp->f_mode |= FMODE_NOWAIT;
+	filp->f_mode |= FMODE_NOWAIT | FMODE_BUF_RASYNC;
 
 	if (filp->f_flags & O_NDELAY)
 		filp->f_mode |= FMODE_NDELAY;
-- 
2.26.2

