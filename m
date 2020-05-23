Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05ED5C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 18:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF84C20735
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 18:58:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="bB83Tj0B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729038AbgEWS6N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 May 2020 14:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728875AbgEWS6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 14:58:10 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EFC6C061A0E
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 11:58:10 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id k7so6441393pjs.5
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 11:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4QX6izj81MoWvGB/E4/khaJEguGwrdsEfxjduXmAWvc=;
        b=bB83Tj0BajwuSjWkcK8ehgNRsKT4dlqQdsgUPSjJiJ2iXaFPJSy+fQuN42JRHiuPAF
         Ds+TSO9sTx+8fbiOAVgtOWX6Sz5lYix1bG9WAh/F71WpAmuz6k6RoGgcULfHqhCzSSGy
         czJK+XJrC+LZTYdNLs5WA1tyopGAN51nNSKpEc4rmPTh+HjK5AUz5guhgngWLdElEoFp
         Y/U216s5zcrGi7OrgxVS0H1boXsUkpjkDmicuLJP4gJCppIK3k1wT0URrgfknJrl22Hn
         CRM8C/QHbp+xO5nT35RB17ABqdwxlpAFz/I5f7IJcf47ml75nwLzUmNlUz5/4oEh0drP
         Oicg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4QX6izj81MoWvGB/E4/khaJEguGwrdsEfxjduXmAWvc=;
        b=hQ4yYNCNmq1Ymt/dkW6B3Sam1XVj7t/LX/RlXg4JpyFcNsHm8/xxJc8TxhAr9HNydz
         G7eEld7tkCCtDOhiOIHpvYaIGbvE/slRa3sNwIntiY+0m75O1bs4JiAh9x/dfzC5iEnX
         eIiUfOpqA/U4x99ftoKL09qEmPRpTgRMOtnU+3FYMT3r0cGBzO3AA7xK3pnlg+dgFDC9
         UssiDX2c08q4ipkHb6P8mKJzLAEx4lmNh131HbQI0zpoQ7axNVbE+vl5Opqsmt8eiaJ0
         ccnCaszzPF5EovLUIAew44vPAZsmN1wDky4cSvo35mLN8a/uAmeqxhMht1goW857vTRg
         ZrXg==
X-Gm-Message-State: AOAM531HzAszTlPyR3eLINpP0wglRwZtNlfMGPiuNqI3Fraikn45pKhD
        1F+llmPjMWErXQ2YsVzNQ9aw7w==
X-Google-Smtp-Source: ABdhPJxtwoGUVtGeMjBKBqTDc5pH659x6OQMxIcezhl06qMF9UwN+jLw7DQKIdSMErnJ/wvDE2IMpw==
X-Received: by 2002:a17:902:422:: with SMTP id 31mr21310761ple.310.1590260289753;
        Sat, 23 May 2020 11:58:09 -0700 (PDT)
Received: from x1.lan ([2605:e000:100e:8c61:c94:a67a:9209:cf5f])
        by smtp.gmail.com with ESMTPSA id 25sm9297319pjk.50.2020.05.23.11.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2020 11:58:09 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 08/12] block: flag block devices as supporting IOCB_WAITQ
Date:   Sat, 23 May 2020 12:57:51 -0600
Message-Id: <20200523185755.8494-9-axboe@kernel.dk>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200523185755.8494-1-axboe@kernel.dk>
References: <20200523185755.8494-1-axboe@kernel.dk>
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

