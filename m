Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EDCAC33CB1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 07:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A9A42073D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 07:44:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="VuL5LjlK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbgATHoC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 02:44:02 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35998 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbgATHoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 02:44:01 -0500
Received: by mail-pg1-f195.google.com with SMTP id k3so15129855pgc.3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jan 2020 23:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cgbwx4pPrUton+YWvUC8+XEHkB4TEyRZFBvrMu0o0Xs=;
        b=VuL5LjlKzy5In5eNW/F5iZwG9YFS55bxJ5qNflJfa7xgPiL5jeyn4MVx6HIXtqakdc
         mlWSi8vEjgA+5iEwRXltmyveZnSvqffSizU8pgqORRZe+7ND4OEjm3+oEkOTSUgm/shH
         tDykiKnwoifmqkjgslih0ocm9GPAeGNHcGHQE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cgbwx4pPrUton+YWvUC8+XEHkB4TEyRZFBvrMu0o0Xs=;
        b=We6sEcFtkx0RRyPvWrWTBam2q5n6K38HvHMnWhQn0hqOaSuJuKvA3IRTd9CxKMjuj2
         o3VT9NGw385APKthkjOsd1HYoNNnf5KzJfb3eun2ZxsCJ4qi+Rxb28RX04beAWUp+xoL
         DXPhxL4UF6Xc5b0Se+d8PHrRJTpn0mWybB36QQWDylvp9HxLPzGrrjgO8aG6CxLTspDb
         GNZQjOMQjOw21mIO4rNqc/69Vz15naLLigjLUHA8JOX9+lTbP6Ut15PNyBjImsCra5gT
         f2OyBTY9Qoymy2PYKwDpfzHUtEGjjKDXVcllWqLSyRw3/lkxuMNUqhAnI5Sh9LklPcES
         hMzA==
X-Gm-Message-State: APjAAAUDCyfYczGWdrGLpiXjhSJQVGzzY+LbM3LU5aUqLLgYnDMvngfw
        tGszKWZKNrdYly5LxnF6FvqmnQ==
X-Google-Smtp-Source: APXvYqyZlAaoK52ybK4EBOzspAzOfrFduSZoB1YaLPW36ZGZBdpEQmZVkbWxdL3Re8WEtuUuz3FE4Q==
X-Received: by 2002:aa7:9ec9:: with SMTP id r9mr15945385pfq.85.1579506240797;
        Sun, 19 Jan 2020 23:44:00 -0800 (PST)
Received: from localhost (2001-44b8-1113-6700-4064-d910-a710-f29a.static.ipv6.internode.on.net. [2001:44b8:1113:6700:4064:d910:a710:f29a])
        by smtp.gmail.com with ESMTPSA id w5sm35841490pgb.78.2020.01.19.23.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jan 2020 23:44:00 -0800 (PST)
From:   Daniel Axtens <dja@axtens.net>
To:     kernel-hardening@lists.openwall.com, linux-mm@kvack.org,
        keescook@chromium.org
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        Daniel Axtens <dja@axtens.net>
Subject: [PATCH 3/5] [RFC] staging: rts5208: make len a u16 in rtsx_write_cfg_seq
Date:   Mon, 20 Jan 2020 18:43:42 +1100
Message-Id: <20200120074344.504-4-dja@axtens.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200120074344.504-1-dja@axtens.net>
References: <20200120074344.504-1-dja@axtens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A warning occurs when vzalloc is annotated in a subsequent patch to tell
the compiler that its parameter is an allocation size:

drivers/staging/rts5208/rtsx_chip.c: In function ‘rtsx_write_cfg_seq’:
drivers/staging/rts5208/rtsx_chip.c:1453:7: warning: argument 1 value ‘18446744073709551615’ exceeds maximum object size 9223372036854775807 [-Walloc-size-larger-than=]
  data = vzalloc(array_size(dw_len, 4));
  ~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This occurs because len and dw_len are signed integers and the parameter to
array_size is a size_t. If dw_len is a negative integer, it will become a
very large positive number when cast to size_t. This could cause an
overflow, so array_size(), will return SIZE_MAX _at compile time_. gcc then
notices that this value is too large for an allocation and throws a
warning.

rtsx_write_cfg_seq is only called from write_cfg_byte in rtsx_scsi.c.
There, len is a u16. So make len a u16 in rtsx_write_cfg_seq too. This
means dw_len can never be negative, avoiding the potential overflow and the
warning.

This should not cause a functional change, but was compile tested only.

Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 drivers/staging/rts5208/rtsx_chip.c | 2 +-
 drivers/staging/rts5208/rtsx_chip.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rts5208/rtsx_chip.c b/drivers/staging/rts5208/rtsx_chip.c
index 17c4131f5f62..4a8cbf7362f7 100644
--- a/drivers/staging/rts5208/rtsx_chip.c
+++ b/drivers/staging/rts5208/rtsx_chip.c
@@ -1432,7 +1432,7 @@ int rtsx_read_cfg_dw(struct rtsx_chip *chip, u8 func_no, u16 addr, u32 *val)
 }
 
 int rtsx_write_cfg_seq(struct rtsx_chip *chip, u8 func, u16 addr, u8 *buf,
-		       int len)
+		       u16 len)
 {
 	u32 *data, *mask;
 	u16 offset = addr % 4;
diff --git a/drivers/staging/rts5208/rtsx_chip.h b/drivers/staging/rts5208/rtsx_chip.h
index bac65784d4a1..9b0024557b7e 100644
--- a/drivers/staging/rts5208/rtsx_chip.h
+++ b/drivers/staging/rts5208/rtsx_chip.h
@@ -963,7 +963,7 @@ int rtsx_write_cfg_dw(struct rtsx_chip *chip,
 		      u8 func_no, u16 addr, u32 mask, u32 val);
 int rtsx_read_cfg_dw(struct rtsx_chip *chip, u8 func_no, u16 addr, u32 *val);
 int rtsx_write_cfg_seq(struct rtsx_chip *chip,
-		       u8 func, u16 addr, u8 *buf, int len);
+		       u8 func, u16 addr, u8 *buf, u16 len);
 int rtsx_read_cfg_seq(struct rtsx_chip *chip,
 		      u8 func, u16 addr, u8 *buf, int len);
 int rtsx_write_phy_register(struct rtsx_chip *chip, u8 addr, u16 val);
-- 
2.20.1

