Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3261BC3F2D2
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 11:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05E042166E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 11:30:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hhgdW1px"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbgCBLaO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 06:30:14 -0500
Received: from mail-wr1-f74.google.com ([209.85.221.74]:35449 "EHLO
        mail-wr1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbgCBLaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 06:30:13 -0500
Received: by mail-wr1-f74.google.com with SMTP id w18so5695617wro.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 03:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=q1I2RKn1Spku5PepO4sKWFq3j0yL+8kFK015J9Szlg0=;
        b=hhgdW1pxLD06YKoTAOyhOOfXmdrhQnocpCiNC+sZVWf00u78Xx5+jw9fXqhlHPJxTn
         E9gFz33mmj1u5d6T5L1Sp2+9DpLDtMQikp8DHBLfUrCqdleO9BCK7MFWRA4DLEmPaoor
         H/dRouNteRsBjBlFqXUtaC9NSGBtor2Qvv30TJGlsY6jBvWIrRtsErxRZ+hPIr56a9QT
         qzKKaZW21q1Jouw40dFeCb4N9tHpvl7KVnz78uu9/eb5WmOLnIYdRkmtN5RYB6pamNxW
         xK9qmo2rmGBoNZll9bJakQX+q6jt360fWardBNyQT4Z4SGUDb388Kt2s7CgE5lGnDFwc
         xb4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=q1I2RKn1Spku5PepO4sKWFq3j0yL+8kFK015J9Szlg0=;
        b=WY092JK21FHs7Ho3hG5wp+sejiKM/xob6+kPDmCxftNVUI9Sz1DJFQZfYvsP/IYzp4
         ZbfmW/fsZdEG3jx/4p2CF3jv+INJWNns/A9xrfat7UqFaywiAUTTCkP5CZxDKVG9LlKv
         GdsnHQ6JyZZUur7LOCLGFdlFRxe+4Lm+AIJx52g504EPqhHQDoJ5g+3vtSUru3DZFjCW
         QYnFtfTxdR3Z/maNly6w4QSUfEzKD7ZvT/5Qpl+7EVou/mJs60jF85LYouauz2YPlzEb
         txclDi9YEyn7HqPEZ3t8xDyikATQUn3HNgBqIJxdYbunk+pIyGmFMvjZGMlOdoe8m56z
         BSUw==
X-Gm-Message-State: APjAAAVkyT0XGpUIptHSA+qQsEs5Tg+hAQDnXF0PnJcTttn0QwLf5XF6
        9kjKNcGg9bsJK5gb7AZ4taykOzw4dg==
X-Google-Smtp-Source: APXvYqzpDynIsY8fG28WGbWTomC5tcCOPYkZH/xJbbk/HHjiU7jyCTRfq/ZhpTijXyjDMUmAWsPVpE8eWQ==
X-Received: by 2002:adf:fa50:: with SMTP id y16mr19928038wrr.79.1583148610099;
 Mon, 02 Mar 2020 03:30:10 -0800 (PST)
Date:   Mon,  2 Mar 2020 12:29:39 +0100
Message-Id: <20200302112939.8068-1-jannh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH] threads: Update PID limit comment according to futex UAPI change
From:   Jann Horn <jannh@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The futex UAPI changed back in commit 76b81e2b0e22 ("[PATCH] lightweight
robust futexes updates 2"), which landed in v2.6.17: FUTEX_TID_MASK is now
0x3fffffff instead of 0x1fffffff. Update the corresponding comment in
include/linux/threads.h.

Signed-off-by: Jann Horn <jannh@google.com>
---
 include/linux/threads.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/threads.h b/include/linux/threads.h
index 3086dba525e20..18d5a74bcc3dd 100644
--- a/include/linux/threads.h
+++ b/include/linux/threads.h
@@ -29,7 +29,7 @@
 
 /*
  * A maximum of 4 million PIDs should be enough for a while.
- * [NOTE: PID/TIDs are limited to 2^29 ~= 500+ million, see futex.h.]
+ * [NOTE: PID/TIDs are limited to 2^30 ~= 1 billion, see FUTEX_TID_MASK.]
  */
 #define PID_MAX_LIMIT (CONFIG_BASE_SMALL ? PAGE_SIZE * 8 : \
 	(sizeof(long) > 4 ? 4 * 1024 * 1024 : PID_MAX_DEFAULT))
-- 
2.25.0.265.gbab2e86ba0-goog

