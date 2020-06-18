Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81AFDC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 14:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 608A520888
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 14:44:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ynTJluJ6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731047AbgFROoi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 10:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730981AbgFROoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 10:44:16 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E62C061370
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 07:44:13 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id s10so3023732pgm.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 07:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=lmn4EHxlosWk2LKyZRbh3uHZDbpZvbZJJ5zRlTFAsKo=;
        b=ynTJluJ6Q99yEvMTa6y10W+u5+Z89pdb0A+GuJkEPIQuhyxpm60zb8aV1UgTzM49Cg
         7mYXB2z8mtKRwGfC7oa8zmXN0NeqZcMk0nfEZAsWCQC7qS69O7EfAy7bvV4ntFSDUnKd
         s1HYlH3UUvMSO05JqooeCBbZY0ZRIjrWWqeXC7QjivnX5Jt0UXn8Nku5Kkav004uevwG
         8PUXkLfmKjS6G8DCuicClsmZmNXcIm7PbrbS7/OqZObQQHmkmS+ttktTCCcqchSw4mb3
         huoY15kQX2Ms3nHgl6XAnHvSp6STkjvZO6hPs2x+GSzE549wVTux9mlLhmmuwEge7kyC
         Whmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=lmn4EHxlosWk2LKyZRbh3uHZDbpZvbZJJ5zRlTFAsKo=;
        b=cAOqcWOdtsJGqbf1+O3X0dNZPvDMi48PR0ZNvBEIMXeVG6ZzzigjM8LGH9sVV+vt5b
         rINDz0tFFVRdan/obHn9mqqyTTOht9zmSuIrveo8zXUWz4KY+YcUC1vYH60ULdgbUMGV
         GIpuXkeUPC+70tUT632YxRemQzVFmifzvfl7Nag+c+0yiMrj05ngLxoJMNobtYG5DibH
         +/XM9PCT+D7JDj+EIysZIOvA/DpAWkHxP6kOPlizHAaer3BzCaAxXjLxLKfpme3L8qpW
         NxQRCs/Z3bhWgvirUmBfDqf+JI/cRpZBNOq5jyi6aoRHbUKmUfvVompCY5nm3itBbMwB
         w+ew==
X-Gm-Message-State: AOAM532dZKKdNta20nMgX+MjRWhfbzuwxNRIpOA9lBKxHEKiYjA5foi0
        EtefiIOC+FE80nX0p/rF8RQrDQ==
X-Google-Smtp-Source: ABdhPJzBNjEb2EomZLOu+f8/v3tw76mKzCcpM8kJeYEd8Lb2xxqO66ZxbvFvynHQ19qXPAAGDtGMUA==
X-Received: by 2002:a63:1e60:: with SMTP id p32mr3518283pgm.172.1592491452832;
        Thu, 18 Jun 2020 07:44:12 -0700 (PDT)
Received: from x1.localdomain ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id g9sm3127197pfm.151.2020.06.18.07.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 07:44:12 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 10/15] block: flag block devices as supporting IOCB_WAITQ
Date:   Thu, 18 Jun 2020 08:43:50 -0600
Message-Id: <20200618144355.17324-11-axboe@kernel.dk>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200618144355.17324-1-axboe@kernel.dk>
References: <20200618144355.17324-1-axboe@kernel.dk>
Reply-To: "[PATCHSET v7 0/15]"@vger.kernel.org, Add@vger.kernel.org,
          support@vger.kernel.org, for@vger.kernel.org,
          async@vger.kernel.org, buffered@vger.kernel.org,
          reads@vger.kernel.org
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
index 47860e589388..54720c90dad0 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1850,7 +1850,7 @@ static int blkdev_open(struct inode * inode, struct file * filp)
 	 */
 	filp->f_flags |= O_LARGEFILE;
 
-	filp->f_mode |= FMODE_NOWAIT;
+	filp->f_mode |= FMODE_NOWAIT | FMODE_BUF_RASYNC;
 
 	if (filp->f_flags & O_NDELAY)
 		filp->f_mode |= FMODE_NDELAY;
-- 
2.27.0

