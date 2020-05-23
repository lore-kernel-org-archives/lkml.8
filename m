Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE0B8C433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 01:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE3DF2072C
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 01:51:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="HnYcrZsd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387641AbgEWBvp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 21:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387526AbgEWBvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 21:51:05 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F0A1C05BD43
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 18:51:04 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id b190so6002369pfg.6
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 18:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+VWs0Nj9WGghWnCOq/fSx5SIRlxQxiE9MXDVdkqYQzM=;
        b=HnYcrZsdOxNRPX01BAnp52Y7QAzXP3CsE9SKw6fM2ImM1eIgaLTppeiQWVnE4+11m3
         OejnkqB4kn5KbmRxULadm7opO6Kb+xsQiehV88PQ/0Zt5ygcKMubjp3qUbnsmu8xw1dO
         tUNho/mPqi5E13I6F+oLG00gGtZLIc3imnV22yFOYC9TXgLmfk5T2dygoCfZ7JOJGVAv
         KlhOHI1SnxOsFUv768fRTyN/geFG4DgbMjHnx9M9CqPJYXXVONngEu0cBOr13pfQx7vS
         rJQvZvesC+TDpqUL8Xn8iJylJnj4S66DggYzHPxNJvyUc4XmLS+1qrQd1F9klkosbR5/
         JpMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+VWs0Nj9WGghWnCOq/fSx5SIRlxQxiE9MXDVdkqYQzM=;
        b=PJ7wpUN2c662YLgIzW6/L+P9aXwRjS42VEYQ0Vx/ryany2zq9Sg4M3rdxc5wyHbAIR
         nRrodK0AgRpqm1zwuXgTmi+5JDsdvo1Y6vRlnbgxuqK5hvv6wRlEsbhnl4WVxG9Df2yd
         Cmc9pyRP5PaxOxtvGU6t0CKtARR51TFpjMLwjSg7wtsQcrJQJUKFNUTAUgdDK9rybes9
         /QbWsAgA8uWQcnz0Dmgg/I/wPuB3Dt+gbyLzPDfh9uUs1RtdJ6UiYacJ4x2pVXfV3K1F
         ov5pVw0UG7cQVr+SB1KDUOmQx92r/QJO+IYpEnbtg1CVSn1DgDCzrs3tBsb91Ud3seUH
         ceaQ==
X-Gm-Message-State: AOAM532fTKUMuZrCNcIkrPRiXa56F/CSkmvduMyn6whRlz6UlWsk7ldq
        VcMRh/rmkMpOta5VNji5gMgwEQ==
X-Google-Smtp-Source: ABdhPJwDt7vAik+XV1ClU0sHBzKsLdX3gET9tONikOf+AYZa2mXQmQJNwaXlM2gsfrr+iZBKtp8bmw==
X-Received: by 2002:aa7:855a:: with SMTP id y26mr6530839pfn.281.1590198663998;
        Fri, 22 May 2020 18:51:03 -0700 (PDT)
Received: from x1.lan ([2605:e000:100e:8c61:e0db:da55:b0a4:601])
        by smtp.gmail.com with ESMTPSA id a71sm8255477pje.0.2020.05.22.18.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 18:51:03 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 05/11] fs: add FMODE_BUF_RASYNC
Date:   Fri, 22 May 2020 19:50:43 -0600
Message-Id: <20200523015049.14808-6-axboe@kernel.dk>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200523015049.14808-1-axboe@kernel.dk>
References: <20200523015049.14808-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If set, this indicates that the file system supports IOCB_WAITQ for
buffered reads.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/fs.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 82b989695ab9..0ef5f5973b1c 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -175,6 +175,9 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
 /* File does not contribute to nr_files count */
 #define FMODE_NOACCOUNT		((__force fmode_t)0x20000000)
 
+/* File supports async buffered reads */
+#define FMODE_BUF_RASYNC	((__force fmode_t)0x40000000)
+
 /*
  * Flag for rw_copy_check_uvector and compat_rw_copy_check_uvector
  * that indicates that they should check the contents of the iovec are
-- 
2.26.2

