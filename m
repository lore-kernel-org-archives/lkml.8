Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB4CC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 15:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4701020759
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 15:51:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TdHRlrTj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbgEWPvV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 May 2020 11:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbgEWPvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 11:51:20 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4EBDC061A0E
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 08:51:20 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id t16so5624795plo.7
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 08:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7zKzu+Bb4gMdTdtJjSG+Yx9639VPFJZPb465isIw9HI=;
        b=TdHRlrTj0WDx2T14AhFodKEPUGkyAChranEYIkea66F2ZU1N9bCFADsqaS5h6JQn8C
         /iUrM2G6dx++rGWbKOWZg8gC6GixOP7qsLKnoJwc1aWgaon5eAMM8YP0Q+u4jdEUx4vi
         H8ugSYQjHL/mq+uJyHDcFmrM8ouI7E4PwigBtnnTBGGZoStsbBnAmfqQWV+uIdVLjGLg
         RO8SsJtHMLTs/SudVL4t8L4Ww20I/gOIMi4cHO8cfALPzqp+bFtt/arQOb/T3Sinsq8I
         ohuLWyVQjuNNchL0Z4ejQs0hW6tifBDFfvTTphFUA7pECUEMo5aKQWmEhbwAY2mk5crO
         1XSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7zKzu+Bb4gMdTdtJjSG+Yx9639VPFJZPb465isIw9HI=;
        b=OqKrYVIi5X3g/hh9+aGjLg9rSGyt30qkoWwerMa/qd3QWzKgPKIvsdM/gQ9lXDUBit
         iT7JcFQHJy08IyQX4XgMsMACYEaMYN7zj8X7eQk7v1u75BabCCeaFqglcSTaaJ+8nEL3
         0o630qM/RMKxKR9mmLMIrv9HX7t6bF4tukzoeYYFzfaFdhKmjh4ZJAhNknSA0jY3a9A9
         zVMBBjOmDSA4aY6QXY+jakxdPNt1uAEwkuWBBmy3wsz2Hs+kvT7nFPJVf9cn9JPOob/N
         ff3ARCoO506tN3sDzxNoKVgpDKs0pnbQHYFtPLhfCu/ThY+eb4ryza0/aaihqWXrc5/8
         xoRg==
X-Gm-Message-State: AOAM5329hpJy2okGGvCPRZmmVSkxSL8b3Sa5qgTNHVbJyvyc2BmHwfhF
        OyRoetjg6wqKmruYi8d8DU8=
X-Google-Smtp-Source: ABdhPJwpp8IdAAgVrObF/bUyS6wnWsrDrgBMT2y5+XIQW8pIkk4BpvrXBAW2h2nnhEJhIaZPtRIYvQ==
X-Received: by 2002:a17:90b:358e:: with SMTP id mm14mr11139555pjb.175.1590249080516;
        Sat, 23 May 2020 08:51:20 -0700 (PDT)
Received: from Smcdef-MBP.lan ([103.136.220.68])
        by smtp.gmail.com with ESMTPSA id d9sm4653760pfn.72.2020.05.23.08.51.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 May 2020 08:51:20 -0700 (PDT)
From:   Kaitao Cheng <pilgrimtao@gmail.com>
To:     axboe@kernel.dk
Cc:     damien.lemoal@wdc.com, bvanassche@acm.org, ming.lei@redhat.com,
        martin.petersen@oracle.com, satyat@google.com,
        chaitanya.kulkarni@wdc.com, houtao1@huawei.com,
        asml.silence@gmail.com, ajay.joshi@wdc.com,
        linux-kernel@vger.kernel.org, songmuchun@bytedance.com,
        Kaitao Cheng <pilgrimtao@gmail.com>
Subject: [PATCH] linux/blkdev.h: Use ilog2() directly in blksize_bits()
Date:   Sat, 23 May 2020 23:50:48 +0800
Message-Id: <20200523155048.29369-1-pilgrimtao@gmail.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

blksize_bits() can be achieved through ilog2(), and ilog2() is
more efficient.

Signed-off-by: Kaitao Cheng <pilgrimtao@gmail.com>
---
 include/linux/blkdev.h | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 2b33166b9daf..cce96abac4d4 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1505,12 +1505,7 @@ static inline int blk_rq_aligned(struct request_queue *q, unsigned long addr,
 /* assumes size > 256 */
 static inline unsigned int blksize_bits(unsigned int size)
 {
-	unsigned int bits = 8;
-	do {
-		bits++;
-		size >>= 1;
-	} while (size > 256);
-	return bits;
+	return ilog2(size);
 }
 
 static inline unsigned int block_size(struct block_device *bdev)
-- 
2.20.1

