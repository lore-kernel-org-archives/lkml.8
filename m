Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9750C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 19:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BC6620787
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 19:22:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="gxGduZqo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388090AbgEXTWR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 15:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387851AbgEXTWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 15:22:16 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73091C08C5C1
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 12:22:14 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id fs4so711725pjb.5
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 12:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DT9kV8IQxC/D+uhFJsefv+iJT3TxYB4ReZ7s4ZFOil0=;
        b=gxGduZqosF0z63K53o9awU20QA6ufSZ5TTqRe+tv3AOsZ2QlQ979YXr+1dskXq52Jk
         HS3I9zTGgZsmogN4rJCO292dN+jQ4Bh81nqndOGDqgUTCuNwtxtCzXuJPlAMKQRJ58uA
         DuMNOBDX6nN/HrDjMdSSysjmoxpz5chCYgMsvnmdpOOufOk2jA7gdSzJR/TzXpAMz7Lj
         M0TIw38/7f79f2cKH+xUDuzBnClVTmIWWKOLweF65hex28srdE77jZIapgVeALrqEfAA
         ocGg0o8OhrW4mbtznbLks7cKK3H/ZDmHlmgcJ/0qYgXMDuB9nDi7913IThDZ9hVUMz+H
         0p2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DT9kV8IQxC/D+uhFJsefv+iJT3TxYB4ReZ7s4ZFOil0=;
        b=iX7jLH+vJ+UH8klcmfJs90V6utUvknhiCjqiVQi/iePLdIspgEAKZ/K3EBQXcGO38r
         7PazJ+Z3E9E6oND16O0Wf6/29VQ4/NVU9xrR0pnO7AVy5JUj/KAhiQITq+LsB4eI2v0l
         xwcwhFoem66peDjVJHwA7HUgFuy9CJeJyQK6MaJ03ZQY4lrUkHhgHe0mtZ126sGR/7NV
         T+oTz4SDE2izv8xPzW7JKlPaVXUvR9M7vh5jBIH+lmp1XZ3QHIleGPDtYytgi87M3LBN
         MbaMIHCb7yxgyyBAKTYRCmPxlaN9JpeYovXvtCbcp0Eawn4fu02Sn+Ygyg9bgc17952U
         lWog==
X-Gm-Message-State: AOAM530DA0uel28EdiT0MYhBNBdFv3zoprskjzerGfB2dA2zDc0CzEDu
        it3k6ylXPd15qFTtBLNFZeMcFg==
X-Google-Smtp-Source: ABdhPJyWrtKyXRFlA4SwqdiGTTumD68oCqrgZnBOzPkJTTFSdRxzhdggPB+vLC5MAtEqdrvZvv1y/Q==
X-Received: by 2002:a17:90a:648c:: with SMTP id h12mr17363317pjj.229.1590348133979;
        Sun, 24 May 2020 12:22:13 -0700 (PDT)
Received: from x1.lan ([2605:e000:100e:8c61:c871:e701:52fa:2107])
        by smtp.gmail.com with ESMTPSA id t21sm10312426pgu.39.2020.05.24.12.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2020 12:22:13 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 01/12] block: read-ahead submission should imply no-wait as well
Date:   Sun, 24 May 2020 13:21:55 -0600
Message-Id: <20200524192206.4093-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200524192206.4093-1-axboe@kernel.dk>
References: <20200524192206.4093-1-axboe@kernel.dk>
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

