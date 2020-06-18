Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48ADFC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 14:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E3E920888
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 14:45:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="CmsR4pnk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731089AbgFROpO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 10:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731006AbgFROoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 10:44:25 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA57C061258
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 07:44:17 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id 10so2878997pfx.8
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 07:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=agiR+Byeck2s775I8LSKf8tm0BQVQsWoO+u3QsmIwcE=;
        b=CmsR4pnk1FMjkbrTWikiw1ru36jrxC1tfShgKpQNL5fwTTR48LJzuB0WFeslN0A8R7
         yVhdczhT7rCHZGNSPImdCvg2GFHYjPZq3Lo8LN55YdVfIqbcMnyIHIfCWRTp7nIlWoCP
         8mIA0QOEOodS5hrggItuRz50XlDx1FRg2U51ti0K2K6RLhv04afTVM85LjEQHy1K3put
         aih63C1nllRb0Y93OtUHEJJE5MygBtOKi6TQwE2EGgx2382rGAnQZJ70Af+bxcWW78if
         p90wfGKQkPEoYPs0wXfDt35iVSEZ+5uCYlZohmz4//abZsAjr1a8x2PskDZN8j4J5CQD
         CYxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=agiR+Byeck2s775I8LSKf8tm0BQVQsWoO+u3QsmIwcE=;
        b=CR/edtHUWbMl0MZI30PUODR7z+wwaNBlr0HmblfxHHXMfVNmj74FSDjwqgKF866neS
         hrmabdP88cdj+QIfJ1zjO0UqH70sn07RU8t4XChYwoCL6vR3oWyPp+RR58RqUd+uRjZ6
         ZgFNo+tWgIIu4SDjqEcU/8UJF8RypZo+e1oMSamyAyOGp5z7fn5nNNo/rXqK9y7cBNYY
         W9G7wR2Bharx+0Jk1/DujhutYsGWPIshRUuCy75VoZuXhi3CaTsr8TYwPdMfrq/tKau7
         wI+CGkz/wjvq9toyIfG6e+JWSbXjaX5J5/J8cAKKOjlmXF32gQExUguu7PIuWF0YrPnN
         O/jw==
X-Gm-Message-State: AOAM533PP+QKt4mMvdbeGonvto+EKcUy52TqiT/mEKb5x/xyg5T2n3eD
        6GvtmkrbKoTOMu6plltPSG7xRg==
X-Google-Smtp-Source: ABdhPJyNr3+kHnVN8fM6oIP5PSOO4gsldaD6y/PdYSuuK7cpSwrVAwO5ubxT1Qc0fzuBScSDRUwL4w==
X-Received: by 2002:a65:6558:: with SMTP id a24mr1850398pgw.110.1592491457531;
        Thu, 18 Jun 2020 07:44:17 -0700 (PDT)
Received: from x1.localdomain ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id g9sm3127197pfm.151.2020.06.18.07.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 07:44:17 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        Jens Axboe <axboe@kernel.dk>, Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH 13/15] ext4: flag as supporting buffered async reads
Date:   Thu, 18 Jun 2020 08:43:53 -0600
Message-Id: <20200618144355.17324-14-axboe@kernel.dk>
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

ext4 uses generic_file_read_iter(), which already supports this.

Cc: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/ext4/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 2a01e31a032c..1e827410e9e1 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -839,7 +839,7 @@ static int ext4_file_open(struct inode * inode, struct file * filp)
 			return ret;
 	}
 
-	filp->f_mode |= FMODE_NOWAIT;
+	filp->f_mode |= FMODE_NOWAIT | FMODE_BUF_RASYNC;
 	return dquot_file_open(inode, filp);
 }
 
-- 
2.27.0

