Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A3C2C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 01:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1792A2072C
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 01:51:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="zbiGe0xN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387661AbgEWBv5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 21:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387481AbgEWBu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 21:50:59 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A5EC05BD43
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 18:50:59 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id t16so5117360plo.7
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 18:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DT9kV8IQxC/D+uhFJsefv+iJT3TxYB4ReZ7s4ZFOil0=;
        b=zbiGe0xN/5Eo+H2CF5xCbc37d8G9FUD+KwT1btc4sCr0MmxKKhWlYkpMFKsBDe+auM
         9Lo6glgxT0TpCX3WRGG2vn4VE4AX+1pfCRCyrummCo1lCgDdqbkeBEk6ijx9JZHEJeU6
         jRmvQq6kJzvuOmFc9w5apNTgM3Y6aWuEs/rQtJ0OKa8yDTfg0sKs6pnYpShqn12A0A9y
         J6Wc16rnzBpz+0lD/w43ca6v1fqIWEl8Vw2+W7mJDgRZMzxLokmiLxhG9yZLWNMkjrKX
         Hj5+zMmQhwgf39Gi5fHYe6g3ZGmPsA6EMMkh/9rZ+BCgVtl95AzUU9gmqRnnCNoVHzwK
         88yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DT9kV8IQxC/D+uhFJsefv+iJT3TxYB4ReZ7s4ZFOil0=;
        b=E+upsU7Us/IuJDLoVnkW8ecUu6nqidxkvVFWu58Hf9nvQFK1sHVywOm5FtSsE1ChBz
         s+qd/bkn9vem2KbEsjniYiE+zBj4HS13dYTmE8lnCavvskxiC69S3xE+JtKY4L8bcu8i
         hlStd8Ij7SiUSPA4T2YShQYt0xE+VtuHo6A0HXuI2YmO42IDMf34Ha9wwQlW1ElL1LEG
         /Dnh8UM1iTf/Ne0CiDegka6g3t7++Ub/F0WJGHEeXXNoAMg7DhDoreZdzZLU/JwHwTnb
         WnFDluG/xlTXib7m+qKFdnX3LeUp+23ntb1woGtvV+yp8Owh1r87rJlIYsIeR/xK93ms
         rizA==
X-Gm-Message-State: AOAM531C7qiGd1I1BNrVgoKGQh+m+MIIbrH5fm+j9TbU9GdTv4Hw69bZ
        PWDXzfzQEAOCEKS7+u2t+BGEqA==
X-Google-Smtp-Source: ABdhPJwBmDXlE+x5QTHM8T9DaQOh7Fl5EgB2+dvXN52teuRxNlg4WmYuq4kTmwFYa3fjjpSWpHNLKQ==
X-Received: by 2002:a17:90a:344c:: with SMTP id o70mr8104020pjb.23.1590198658974;
        Fri, 22 May 2020 18:50:58 -0700 (PDT)
Received: from x1.lan ([2605:e000:100e:8c61:e0db:da55:b0a4:601])
        by smtp.gmail.com with ESMTPSA id a71sm8255477pje.0.2020.05.22.18.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 18:50:58 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 01/11] block: read-ahead submission should imply no-wait as well
Date:   Fri, 22 May 2020 19:50:39 -0600
Message-Id: <20200523015049.14808-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200523015049.14808-1-axboe@kernel.dk>
References: <20200523015049.14808-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As read-ahead is opportunistic, don't block for request allocation.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/blk_types.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index ccb895f911b1..c296463c15eb 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -374,7 +374,8 @@ enum req_flag_bits {
 #define REQ_INTEGRITY		(1ULL << __REQ_INTEGRITY)
 #define REQ_FUA			(1ULL << __REQ_FUA)
 #define REQ_PREFLUSH		(1ULL << __REQ_PREFLUSH)
-#define REQ_RAHEAD		(1ULL << __REQ_RAHEAD)
+#define REQ_RAHEAD		\
+	((1ULL << __REQ_RAHEAD) | (1ULL << __REQ_NOWAIT))
 #define REQ_BACKGROUND		(1ULL << __REQ_BACKGROUND)
 #define REQ_NOWAIT		(1ULL << __REQ_NOWAIT)
 #define REQ_CGROUP_PUNT		(1ULL << __REQ_CGROUP_PUNT)
-- 
2.26.2

