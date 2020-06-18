Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7096BC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 14:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C0E120890
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 14:44:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="TF887Y4c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731033AbgFROob (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 10:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730950AbgFROoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 10:44:07 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8FA6C0613EE
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 07:44:06 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id g12so2514065pll.10
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 07:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=kQSBvSrh7q7DQwM3udW0mgxqiTGah8xT/7K+LzTiHfI=;
        b=TF887Y4cr//mvXhTI5c5VEIRfZElOkM2eJr4igs7tYzM3I8rEROoL5414jXEsJNQ1d
         6jCCrNh5fQhPQ07otOWMKTLuwned62gpZzcQSnGz+AtcAsFIRf8kVJYMZrFYkSHJEstI
         EF+Ln2Q+pUkq3tXurup9X6YD2LWffkOldc8tPFPnSONqddrmM/DgTfaNjc16nR3q5d4t
         hPjBvp3o4ycBlrYr8QUDl2U7jqa+BlqD3TbE19T3/QnC95yw4ECXM/85GcpiBdM2DbqP
         8OM2osLFz5ebGolhbCSR09DpxT7wJ8dhnp+kF1wWM32/wq3hn9RugfvhthZyfIx3RxdO
         JS+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=kQSBvSrh7q7DQwM3udW0mgxqiTGah8xT/7K+LzTiHfI=;
        b=jfB/KC+g1ode39y2vvqSa4qV4Xn8X4RHmKvOWobluTIp/zNczQEQAHbTxnqqfOWaTh
         08lrc97MSEt7GM0EXEuHaD6eiu7kve2A12njVJDGJaNuT1XeB2eaRks496TrAPoUelOS
         d1q6UgAHikDGOWkUVDNwVzwpC+8+f93+PyT+jtBaNP2EwMxRr5lXCtDxMK3kYDBG7QC4
         KR9hrffNC9xTYYiiEnG7PfNf27iBdRTLbhg66jUdi4ajYvU1vFSlWtNH32icbn7yKRVC
         8k8d7c45X1YBHzzGiOFyUOPmcievo4GbuRpgq/W/bWRSUjJG/b8ZroxsulOyFG77fn6f
         3qrQ==
X-Gm-Message-State: AOAM530tW8lkwl4Ycxbce53ZGk6fJj5FZPeuhMI1q6kM4c7uX663XQpA
        ypelNgyPGbyE/AYjjVvppMtYHQ==
X-Google-Smtp-Source: ABdhPJxFiInSxSM7iPuZuYhM5oN9cIihl9Wh6hIowfIxeUrII9w3vL4Xc8G06h5ebNdfyunElMZGlg==
X-Received: by 2002:a17:902:eed1:: with SMTP id h17mr4012771plb.172.1592491446303;
        Thu, 18 Jun 2020 07:44:06 -0700 (PDT)
Received: from x1.localdomain ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id g9sm3127197pfm.151.2020.06.18.07.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 07:44:05 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        Jens Axboe <axboe@kernel.dk>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: [PATCH 05/15] mm: allow read-ahead with IOCB_NOWAIT set
Date:   Thu, 18 Jun 2020 08:43:45 -0600
Message-Id: <20200618144355.17324-6-axboe@kernel.dk>
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

The read-ahead shouldn't block, so allow it to be done even if
IOCB_NOWAIT is set in the kiocb.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 mm/filemap.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index f0ae9a6308cb..3378d4fca883 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2028,8 +2028,6 @@ ssize_t generic_file_buffered_read(struct kiocb *iocb,
 
 		page = find_get_page(mapping, index);
 		if (!page) {
-			if (iocb->ki_flags & IOCB_NOWAIT)
-				goto would_block;
 			page_cache_sync_readahead(mapping,
 					ra, filp,
 					index, last_index - index);
-- 
2.27.0

