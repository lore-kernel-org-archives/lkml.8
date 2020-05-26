Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B17EC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27A4F207CB
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:52:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="V4vZlEEo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389889AbgEZTwT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 15:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389443AbgEZTvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 15:51:36 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A537AC03E97C
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 12:51:36 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id i17so610288pli.13
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 12:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7SUIxRwptQ6YWj2W/l7Dp7FzKmS+sjQ+qLVh2r/v7CQ=;
        b=V4vZlEEoKDqieT7hflzw5LCDI+LKcZUvo3Ldv1B6nIJyQFjQVObJEjYJvLZcOXvigJ
         XFaZZNKcVEjx92yoP/mrgXgpnR0CotgPlUTXVNVfzoKp9JzK30dNsQEmJb3wosGrLUxB
         U8RsYVcKqFttW2FE5KGyEAXW3lYLtI/Up6eRarLnAsqMbQv1c3x5NKGKDbBaB/ydFz6t
         7nJ6/vrORT3XMoHvYvJSZPS6MwjnIf9/choDZ58RJSYg3LkxqDzYmJhgdB5KpzqaEp1D
         jz+Rq1oQarSSrrXlfv6K57XzM5S6Jo9ouSoj57WYGLAnQKn8EBEWyWXJUyXm1pphBhbm
         UMOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7SUIxRwptQ6YWj2W/l7Dp7FzKmS+sjQ+qLVh2r/v7CQ=;
        b=b1+MQMHwYNEzUgaBAoqSFBLbUjnPtXNvM4b0uqz+K8YS2LSCTJj0cZZNzZmatzo6Db
         cRNpiCkWnc54ocoQrR5N7bxJ1a6uDQyawisfEh5lPmGeSnV3j0Z2kHgGjY1x1NBIr6xQ
         mhjADyH6MI1tTZ6xVSDD/oe9pMYXAZTKPhDXmp+OV5cnd+CKmvF4WiACXfGzYnjNVdQI
         IJLhjOXDpMQ9IU3bkiX7ZE/5brqXj5UkdtCY9iaMW++cNArIE/YptgVumPymcSeRiPe2
         y/OqdSEfPbJtwriCFnYyWF4tlU7Q5t/IRHkXIKS8Eq27ftRUyfHEnJfGMXBtUdeTrDQp
         AuKQ==
X-Gm-Message-State: AOAM532p2FwWQeDSblCOGf7UD6G2BAWPMuEwxek9RzBNrv+zS9Vq7fXd
        mMevtVdkhnc9BGf5HXfxLSA6Rw==
X-Google-Smtp-Source: ABdhPJzyYUJtjkoA0PGX2KjnNxmXZglyIl+UX6NMsOMleygDwAvXOfiUub9ZxxKR/u6SZWeIJxQwQA==
X-Received: by 2002:a17:902:bc42:: with SMTP id t2mr2580008plz.233.1590522696165;
        Tue, 26 May 2020 12:51:36 -0700 (PDT)
Received: from x1.lan ([2605:e000:100e:8c61:94bb:59d2:caf6:70e1])
        by smtp.gmail.com with ESMTPSA id c184sm313943pfc.57.2020.05.26.12.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 12:51:35 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 07/12] ext4: flag as supporting buffered async reads
Date:   Tue, 26 May 2020 13:51:18 -0600
Message-Id: <20200526195123.29053-8-axboe@kernel.dk>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200526195123.29053-1-axboe@kernel.dk>
References: <20200526195123.29053-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/ext4/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 0d624250a62b..9f7d9bf427b4 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -826,7 +826,7 @@ static int ext4_file_open(struct inode * inode, struct file * filp)
 			return ret;
 	}
 
-	filp->f_mode |= FMODE_NOWAIT;
+	filp->f_mode |= FMODE_NOWAIT | FMODE_BUF_RASYNC;
 	return dquot_file_open(inode, filp);
 }
 
-- 
2.26.2

