Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB8FC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 19:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A83920787
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 19:22:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="uRHMeG7h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388289AbgEXTWd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 15:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388238AbgEXTW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 15:22:27 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 571D5C08C5C0
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 12:22:26 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id t8so5532901pju.3
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 12:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mDbeWlveWyEr17EututM6ewZlLrenoq+wrG4TB+c+O8=;
        b=uRHMeG7h0qyUWA7vuWqk7MVYR+0HFA9+hLVEVjHnDq9/bGqeemt5utvzvZZgUdnrIy
         U+lba7Qp6iQLZ4c8z3yex1xsl7NBK51bH9ntOiA1bzrAsnflM9kzXN7kNcJ7N0emlteQ
         f6PTLXDnlvMvkO0+xbsF0n3KM+R3esV6iaI/VrxgFuKg6m/QCwh29NieyfZ0bGIkLBzC
         N0tz472lFi/FcUthEq7qQBwQ8YXqMbnsRrwlnS1p3BAEfpEt6RqH5JLCBFEKqy0ijFcH
         WD0e0R9E3NAVkMWZKPvQJyEy1N1km2FpSHT2g5nK9H0/Uh1ImNoyNvY6xNut1BwqV9ew
         Tb8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mDbeWlveWyEr17EututM6ewZlLrenoq+wrG4TB+c+O8=;
        b=dLsZ1Y2ogZp7iZYflNTvn7K8dtbRXdqaB+jsozUlGxutkNj7t+7Q/TwnLM5MDTViVG
         ppD1xwdpWPDtAZZUbGRsZ0zK/Eqc4fU1v5i7lBiv395SmyQ1Wv4oFiXfUrzY/6usiYGD
         wgQuTakepGdE1/9HO/uPwthoEx3DJ3M8TujqrcY1bIks2CmSQJf8K4yKixaW7MvQsB1S
         C+Lqe6VCWJIZwExDevXrs9dfzx1dNS3owLp7tmMaCedkJfj+ZkiOs+6D5NWhb5y2PWGY
         4isTKYHG702oWlh3BXzaroNKYGyuX9fODsCHLyNg9/E7wye7u2qPkhbXbBG0A/JQwd2N
         G1IA==
X-Gm-Message-State: AOAM5309Dfx23fploa8WBoabibZXJvIdw20gcmQR4qaMaH7bugcNqv4u
        Jq3f5/5DANXrGKtHBHUw46GWhvm8RzTTaw==
X-Google-Smtp-Source: ABdhPJx5oK/myeVn3bRCetPZQwQdNS3kfvzT2VTrfAxdR1BbKcm7G7xwvH5T6Twt2b9anXcaIgaOgg==
X-Received: by 2002:a17:90a:fd85:: with SMTP id cx5mr16698146pjb.146.1590348145904;
        Sun, 24 May 2020 12:22:25 -0700 (PDT)
Received: from x1.lan ([2605:e000:100e:8c61:c871:e701:52fa:2107])
        by smtp.gmail.com with ESMTPSA id t21sm10312426pgu.39.2020.05.24.12.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2020 12:22:25 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 10/12] btrfs: flag files as supporting buffered async reads
Date:   Sun, 24 May 2020 13:22:04 -0600
Message-Id: <20200524192206.4093-11-axboe@kernel.dk>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200524192206.4093-1-axboe@kernel.dk>
References: <20200524192206.4093-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

btrfs uses generic_file_read_iter(), which already supports this.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/btrfs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 719e68ab552c..c933b6a1b4a8 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -3480,7 +3480,7 @@ static loff_t btrfs_file_llseek(struct file *file, loff_t offset, int whence)
 
 static int btrfs_file_open(struct inode *inode, struct file *filp)
 {
-	filp->f_mode |= FMODE_NOWAIT;
+	filp->f_mode |= FMODE_NOWAIT | FMODE_BUF_RASYNC;
 	return generic_file_open(inode, filp);
 }
 
-- 
2.26.2

