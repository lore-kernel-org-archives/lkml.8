Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9298CC2BA19
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 19:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5419420787
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 19:42:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kTSvaclj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbgDKTmp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 15:42:45 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39589 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbgDKTmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 15:42:44 -0400
Received: by mail-wm1-f67.google.com with SMTP id y24so5975427wma.4
        for <linux-kernel@vger.kernel.org>; Sat, 11 Apr 2020 12:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Iwv88gfngC3+mKBn+a2Sxg57sJmAfdLK0rq5K5qywRA=;
        b=kTSvacljX8WfMC9fgKFd9BqZ16srEoIVnxcM1xKXs+9DCn2U+y5kenxg4pdu1cIYhK
         l4dZmfTabEUFxYYijLccRrI5NONNGTt1Q/Llb5Q+fGJUCKIZJmcITSj4q6xkaAQHbcpr
         TG7JWdaDYXxSzlgi+JskK0mvktpAaCI0eJjAd03sIYztVF6k6FmybfKADhWX6P0ycSUO
         Ww2DcNxNnL3pBKyEAFM+VsWZ71Ucy06yDY5rUGnNqUErFGiq0cMDXZmMUS/39butGQIH
         mazGTeJKhDltYO4bAbbWBZbOIXisR9X8L0FnLL43Ga5gJdz1GG6TtUwo2FnC9ModXfze
         d1IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Iwv88gfngC3+mKBn+a2Sxg57sJmAfdLK0rq5K5qywRA=;
        b=gnsNxkd+zphmRVPRgoiq/cpbGt93HkOfQFQhHazhuccJl9hgIAlTneZPgwrSNEEq5j
         xP9bQWhjzvd5XHz/eWfNs2ZVkUbAW7m2NkGEaIctAa7AhewSMUp+RBrHl1mG0fevE5zl
         mQzsF7IOJe+RlaiJ6c+GxHtzUGenvkZmm2xSptysN0zoiTeL27QZ8U+gWWC4HyuOWTFT
         Tb5M1tGdE3dDYe2IIgDU0OhHZJSIR468Vks2yCRNH6Jf4K/ld/UJn5lvjJY52o1qm7fd
         gJ2gOU6IaGfilG5CWt2KilVmCtX76UHOQ9tQYDjJ5TY9hToQ0K49Sw5ey7Wz0v97EX7o
         rMSQ==
X-Gm-Message-State: AGi0PuZBf+XmrSPiOoNBeNCsUyh6vpsydyOY5ZbZ+bRBgHZK82SesTAD
        x61ffdxR2OyiqlI0pFFNaA8=
X-Google-Smtp-Source: APiQypL0b73v1QwPz38ShgqICbSGYQJxv7JcmrTNJPerG4umMCJ16ibxr5ICX8clyccFcXRv5V26kg==
X-Received: by 2002:a1c:1d92:: with SMTP id d140mr10954413wmd.67.1586634163707;
        Sat, 11 Apr 2020 12:42:43 -0700 (PDT)
Received: from localhost.localdomain ([31.4.236.212])
        by smtp.gmail.com with ESMTPSA id z10sm5954581wrg.69.2020.04.11.12.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2020 12:42:42 -0700 (PDT)
From:   carlosteniswarrior@gmail.com
To:     gregkh@linuxfoundation.org
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        porfavorde <carlosteniswarrior@gmail.com>
Subject: [PATCH] Staging: kernel: user: fixed some coding style issues
Date:   Sat, 11 Apr 2020 21:42:42 +0200
Message-Id: <20200411194242.11336-1-carlosteniswarrior@gmail.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: porfavorde <carlosteniswarrior@gmail.com>

Fixed a coding style issue with a for loop and a trailing whitespace in
the comments

Signed-off-by: Carlos Guerrero Álvarez <carlosteniswarrior@gmail.com>
---
 kernel/user.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/user.c b/kernel/user.c
index 5235d7f49982..4228ec04678d 100644
--- a/kernel/user.c
+++ b/kernel/user.c
@@ -6,7 +6,7 @@
  *
  * We have a per-user structure to keep track of how many
  * processes, files etc the user has claimed, in order to be
- * able to have per-user limits for system resources. 
+ * able to have per-user limits for system resources.
  */
 
 #include <linux/init.h>
@@ -216,7 +216,7 @@ static int __init uid_cache_init(void)
 	uid_cachep = kmem_cache_create("uid_cache", sizeof(struct user_struct),
 			0, SLAB_HWCACHE_ALIGN|SLAB_PANIC, NULL);
 
-	for(n = 0; n < UIDHASH_SZ; ++n)
+	for (n = 0; n < UIDHASH_SZ; ++n)
 		INIT_HLIST_HEAD(uidhash_table + n);
 
 	/* Insert the root user immediately (init already runs as root) */
-- 
2.25.1

