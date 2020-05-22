Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C119C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 20:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B07220723
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 20:23:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="uBr7svy9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731155AbgEVUXw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 16:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731082AbgEVUX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 16:23:29 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D921CC05BD43
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 13:23:28 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id ci23so5454542pjb.5
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 13:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=39qQrTBLEctUrGanLy/C45/WjdVfQkC7faPzmr+qhpI=;
        b=uBr7svy9tGM1kfB0BhVdX6NmzQX7rjQdOtGeI9ETv3djnnaJou6LDEVAoqvNhiiMVT
         /Y5aMZKUeucWj4+6prged/kK2w3O11+J7ITuX3qF2rDWVpxOGNqwSl0Hy8USWsr9ntfH
         wTY67840FUisgxyeUli0TTVeTuG/PHpzi31HVq2pkUzGI7PT1MsmMlwDsnc/BVD/45NU
         bV0QmFFlKDq2DiZ6DxAELytGXg4aFefVWKQ5tYTu+5vUtoGLWwL0eIHhz4hZAfNx4D3p
         /hFGWFMxUuY/F/k91LWw7i7MJyeaK8gEpjfwnHCZfozr1yisHgoRMD5fqyyZGLgF68/T
         lIWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=39qQrTBLEctUrGanLy/C45/WjdVfQkC7faPzmr+qhpI=;
        b=XSeERkI8uRjboJMXgMMjnQ8514inHO4hlxosqLxBjM42iZM20m+y8T1btl6I8BU7Ru
         sAwVLJD7ljj1joxiSmaRMpZqCINdRI+coPE+0Dd+nwFMkTEVMpNLmXWMq9Xb6dlOV2DI
         MKlx8ovfsP4rfpYdFWVP8GscQyX5IdQryxXF8sZWJutA9Lu1ZQJP6MK0Lt9y8fnn0qlx
         8NvaDt53HJ5Y0spOf/OPE5SiVSW58OiTHDzBGfBS4e+MeoqA74xNThXp6/AfDHT/eVKv
         KDhOtF7cHaigy/o/tlalDJ0jrJ7PWaQTxw1ykMwXQ1KHf8Qqr3G/AZTBGXH6qauKi8gB
         9XIQ==
X-Gm-Message-State: AOAM530TFTeMsjbRh8ln54ITW+zvy1d/r8J2kkGiGsSNqAEAQefpB7pa
        gBdAHY5oBxKmb+DJRC4b/liPYdBkFGU=
X-Google-Smtp-Source: ABdhPJxx2gppjGUSOrpOA5NJuWG9g1kSxTIapFlBHOL94NWzUmJF8nmeuziyDIoMZKnC+btQ+HzhUQ==
X-Received: by 2002:a17:902:d894:: with SMTP id b20mr16375293plz.156.1590179008383;
        Fri, 22 May 2020 13:23:28 -0700 (PDT)
Received: from x1.lan ([2605:e000:100e:8c61:e0db:da55:b0a4:601])
        by smtp.gmail.com with ESMTPSA id e19sm7295561pfn.17.2020.05.22.13.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 13:23:27 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 08/11] xfs: flag files as supporting buffered async reads
Date:   Fri, 22 May 2020 14:23:08 -0600
Message-Id: <20200522202311.10959-9-axboe@kernel.dk>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200522202311.10959-1-axboe@kernel.dk>
References: <20200522202311.10959-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

XFS uses generic_file_read_iter(), which already supports this.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/xfs/xfs_file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 4b8bdecc3863..97f44fbf17f2 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -1080,7 +1080,7 @@ xfs_file_open(
 		return -EFBIG;
 	if (XFS_FORCED_SHUTDOWN(XFS_M(inode->i_sb)))
 		return -EIO;
-	file->f_mode |= FMODE_NOWAIT;
+	file->f_mode |= FMODE_NOWAIT | FMODE_BUF_RASYNC;
 	return 0;
 }
 
-- 
2.26.2

