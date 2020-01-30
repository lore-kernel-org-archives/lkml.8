Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6071C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 22:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95C672082E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 22:17:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g2xzrJoi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbgA3WRF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 17:17:05 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:36414 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbgA3WRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 17:17:05 -0500
Received: by mail-oi1-f196.google.com with SMTP id c16so5288492oic.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 14:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o2uSlVLV9EbkO/HgivpguZY4Kg4CkB9MRxWN1lA/tSo=;
        b=g2xzrJoiSyHK3RD1gjqQgclQjUD5x/CkTeGTcObgoSVH46AFK6QpO4L2P1m93arDHZ
         FsYylJpQG7lsjfmCm+9NP5oS04RiBhPL88J17dU3Wtr4ZgF2lgPJcPqW8dvLYXwKqNGc
         0eFSnAsaowjYWGXFfyVJYKj2YLpd7+df/H5fIRaRypwM7+zV/WgROF4TJZbpfxWZatf+
         V2R02x8W/qMw63GtIt08m/6CQS0HwpPZp3+hUIDWe+U4lWvrfXLbNgXu+nFBzHdvPCfv
         IBu7RZGWsWoqxwBEZzkofjuYUg6qRrmOMd6RVZLvQ8rYtWVjl0ZdTX5QXxiMJDqGCzBl
         21Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o2uSlVLV9EbkO/HgivpguZY4Kg4CkB9MRxWN1lA/tSo=;
        b=QAcRX6ZU11nv74AJdaw7H69CosixcRth+YDBmQL0CNXjw8Fngs1i3l8YROZCKt8/Nf
         EdVawqACy8nrexp/RZ+FKuxqga1GrIGf+Eb6d4U8uwZwRd+Dj8PAckW7bnOHIyPxVfSu
         /EsMbZjLWEPoI4TfGUEepnR/sGPzN7dajDfdjdpeyqr5uXWJ+gEbX7+Fu0Y7Ias3bZzH
         mTkISGw8QH/DTVpgZEbQw/BfdjU8br7J3+k36tw3Mc9vmQBg041U6tby8AxmHQnWQ+FP
         pTxcpN8VbvMmVLax8B+53uNFvVmzAcMnAczamRz6HAlW1U3C4tBYHhvwuh/VBf8IUTob
         DB5Q==
X-Gm-Message-State: APjAAAUvlMsoIYPK/IGy1/63U0bQkLrCbIkwF5SuAnRNe3puRi8nuIGL
        tc9IdzYYrfJj0y5cFu+CuYk=
X-Google-Smtp-Source: APXvYqwxny4qGVIVs/8QP5N1gLK6yQfp5csX1BKsnf5xKAC1tLv2sib+WbZeZCDhVVx/ww0aMP+JeA==
X-Received: by 2002:aca:cf12:: with SMTP id f18mr4392210oig.81.1580422623045;
        Thu, 30 Jan 2020 14:17:03 -0800 (PST)
Received: from localhost.localdomain ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id n7sm2063157oij.14.2020.01.30.14.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 14:17:02 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] printk: Convert a use of sprintf to snprintf in console_unlock
Date:   Thu, 30 Jan 2020 15:16:44 -0700
Message-Id: <20200130221644.2273-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_PRINTK is disabled (e.g. when building allnoconfig), clang
warns:

../kernel/printk/printk.c:2416:10: warning: 'sprintf' will always
overflow; destination buffer has size 0, but format string expands to at
least 33 [-Wfortify-source]
                        len = sprintf(text,
                              ^
1 warning generated.

It is not wrong; text has a zero size when CONFIG_PRINTK is disabled
because LOG_LINE_MAX and PREFIX_MAX are both zero. Change to snprintf so
that this case is explicitly handled without any risk of overflow.

Link: https://github.com/ClangBuiltLinux/linux/issues/846
Link: https://github.com/llvm/llvm-project/commit/6d485ff455ea2b37fef9e06e426dae6c1241b231
Link: https://lore.kernel.org/lkml/20200130051711.GF115889@google.com/
Suggested-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 kernel/printk/printk.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index fada22dc4ab6..a44094727a5c 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2413,9 +2413,9 @@ void console_unlock(void)
 		printk_safe_enter_irqsave(flags);
 		raw_spin_lock(&logbuf_lock);
 		if (console_seq < log_first_seq) {
-			len = sprintf(text,
-				      "** %llu printk messages dropped **\n",
-				      log_first_seq - console_seq);
+			len = snprintf(text, sizeof(text),
+				       "** %llu printk messages dropped **\n",
+				       log_first_seq - console_seq);
 
 			/* messages are gone, move to first one */
 			console_seq = log_first_seq;
-- 
2.25.0

