Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1505EC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 15:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE029206C3
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 15:41:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730341AbgFHPlj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 11:41:39 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39529 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729580AbgFHPli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 11:41:38 -0400
Received: by mail-lj1-f196.google.com with SMTP id a9so17521906ljn.6
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 08:41:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cHWA4ojiiDEn5KL63INPPyDAtucasDF2S7FDQVE+qDM=;
        b=hzcCh22/oIZH2lPoXwU/Bq7Tliy//QWFMNfLrZy/9WCnFLO/n+ZIh0laLe1/mLmOT/
         yqRZA9YKt7QGSRVsIbV1y6m3dZccqjXZTlozabQbty1EUkH+bBggP7E08biyPR6k5MLm
         doUKeS1CfZojxX79+ya5KP0XIgL89GpAf4DNWD3Xj/gXbFMhNqElPZ6uTLtnShPXOB2N
         6qDuan6FayV5Zd2m7c3Dahu36v4/atSIN8C4Bp1TqB/101xgFWETvKa3UhNhCprPhj7Z
         BZVM1oey22phi1VlYh9OfXCAO118n8oNbycjkC8k4deHD2KGRxHvRKmH8nG9sC6z9aku
         CocA==
X-Gm-Message-State: AOAM533yuDToNKwan+Nnu5wgRRjB8U6uJJps2VfTlcoQt1KAdcvL+K39
        /B6GNc5zW8zIN4JuAmGDy2I=
X-Google-Smtp-Source: ABdhPJxcCGObw86L0+s5Xo2L0LL0YIVqvz7Ew0Npvfx0IF/mCW9rPeOPpxnN7fLbQW2rEI0i/duE+A==
X-Received: by 2002:a2e:6c07:: with SMTP id h7mr12138763ljc.125.1591630895189;
        Mon, 08 Jun 2020 08:41:35 -0700 (PDT)
Received: from localhost.localdomain ([213.87.137.116])
        by smtp.googlemail.com with ESMTPSA id m3sm2497480ljb.38.2020.06.08.08.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 08:41:34 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Denis Efremov <efremov@linux.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] f2fs: use kfree() instead of kvfree() to free superblock data
Date:   Mon,  8 Jun 2020 18:41:23 +0300
Message-Id: <20200608154123.235198-1-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200605181533.73113-1-efremov@linux.com>
References: <20200605181533.73113-1-efremov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use kfree() instead of kvfree() to free super in read_raw_super_block()
because the memory is allocated with kzalloc() in the function.
Use kfree() instead of kvfree() to free sbi in f2fs_fill_super() and
f2fs_put_super() because the memory is allocated with kzalloc().

Fixes: 5222595d093e ("f2fs: use kvmalloc, if kmalloc is failed")
Signed-off-by: Denis Efremov <efremov@linux.com>
---
Changes in v2:
 - Single patch instead of two separate patches
 - kvfree fixed in f2fs_put_super

 fs/f2fs/super.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 8a9955902d84..94bfc140bef9 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1257,7 +1257,7 @@ static void f2fs_put_super(struct super_block *sb)
 #ifdef CONFIG_UNICODE
 	utf8_unload(sbi->s_encoding);
 #endif
-	kvfree(sbi);
+	kfree(sbi);
 }
 
 int f2fs_sync_fs(struct super_block *sb, int sync)
@@ -3130,7 +3130,7 @@ static int read_raw_super_block(struct f2fs_sb_info *sbi,
 
 	/* No valid superblock */
 	if (!*raw_super)
-		kvfree(super);
+		kfree(super);
 	else
 		err = 0;
 
@@ -3812,7 +3812,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 free_sbi:
 	if (sbi->s_chksum_driver)
 		crypto_free_shash(sbi->s_chksum_driver);
-	kvfree(sbi);
+	kfree(sbi);
 
 	/* give only one another chance */
 	if (retry_cnt > 0 && skip_recovery) {
-- 
2.26.2

