Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09316C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 12:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCEB020776
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 12:57:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mCQEDB2I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732378AbgFSM5m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 08:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728081AbgFSM5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 08:57:40 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08624C06174E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 05:57:40 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id x6so9564617wrm.13
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 05:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RwAV9yH6vfR+prDFBL6WEfKTnzoBXbYA0ML8+0Kfwxo=;
        b=mCQEDB2IfnkbKVH0+/0A4vvTAfYGtg3TLlJQsESccOQnZvtEa7x/hX3wGcphkAYN6Q
         zopXMKm2Ouzqup+z9XuziRnVf3Iy9cvvVFMDeK+NHu7CW0N1/KHyZE/ctaVhJDcpsMGZ
         sgxkJNzMJJnpr4lxrks81cUUKjhdV7m5lLzDjVMSb40XCnBv82cIG3LKEIuTRMxqxQ9L
         uOrxHq6O1W2tGFNz0Hjoi4/rJ6HOk9y/Cn3BSjhXhuBEyK9MpiUZ2VRanr6SJ80j7dA1
         iTeLAIlSyvpYzctO7Ji6GP/VcIBZxSC/05SbVdWTL2I/JFOo8vU//l0/MPQjwh/VrzPp
         0doQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RwAV9yH6vfR+prDFBL6WEfKTnzoBXbYA0ML8+0Kfwxo=;
        b=b7PFvUePyAH2dJ6w+8zSiic4hF6sjRtKVnBkOES4Lp391zCMtA+dKOAF31NwuI2AEI
         Kz74vEihD/7U/NTfGOfJKd4cB5/w4773XWozibeDqkqXA58GkQ0BEBOGBHEkVV7x/zHv
         fzej7ovDYsdfPiojyFh5nYegqKy8CKNZ/SBuLx3mFreeSD2d2fq/uyqOSf6+Fa4LyLK2
         quiKgdj/UVXnHi1E28iKeZky4Qy72g2ighYusGIiPF6yLGA5atwntUxc8E1iqUbN0PfJ
         Y7A+3Kw5mPq1lgmtLcNKG528zLu0U61T0j9/xMHLhXH3VjdqolxSRuoEDfhsCnqmiq3e
         +Q7A==
X-Gm-Message-State: AOAM531j9fT0sPqaZ6y7fUkdpBKo6OiieDfZcEnfi+NSrDkDATjW8SBq
        +AYpZUExpPTQyk0gUdYDgAk=
X-Google-Smtp-Source: ABdhPJwrozszNgMUjyjq9RSdtfWWZDNZDL0Ceo5VosIuCyo5G5BdQSMRobL8/6HEGn8+RHxKniLk8g==
X-Received: by 2002:adf:e4cc:: with SMTP id v12mr3798409wrm.183.1592571458728;
        Fri, 19 Jun 2020 05:57:38 -0700 (PDT)
Received: from localhost.localdomain ([46.114.105.49])
        by smtp.gmail.com with ESMTPSA id 63sm8008328wra.86.2020.06.19.05.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 05:57:38 -0700 (PDT)
From:   Sedat Dilek <sedat.dilek@gmail.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>, Will Deacon <will@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Cc:     Sedat Dilek <sedat.dilek@gmail.com>
Subject: [PATCH] kcsan: Improve small stylistic detail in compiler-clang.h
Date:   Fri, 19 Jun 2020 14:57:21 +0200
Message-Id: <20200619125721.15946-1-sedat.dilek@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 5cbaefe9743bf14c9d3106db0cc19f8cb0a3ca22
("kcsan: Improve various small stylistic details")

...forgot to improve a stylistic detail that was already done at
another place in compiler-clang.h file.

Fixes: 5cbaefe9743b ("kcsan: Improve various small stylistic details")
Signed-off-by: Sedat Dilek <sedat.dilek@gmail.com>
---
 include/linux/compiler-clang.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
index ee37256ec8bd..c47141b185fe 100644
--- a/include/linux/compiler-clang.h
+++ b/include/linux/compiler-clang.h
@@ -25,7 +25,7 @@
 #endif
 
 #if __has_feature(thread_sanitizer)
-/* emulate gcc's __SANITIZE_THREAD__ flag */
+/* Emulate GCC's __SANITIZE_THREAD__ flag */
 #define __SANITIZE_THREAD__
 #define __no_sanitize_thread \
 		__attribute__((no_sanitize("thread")))
-- 
2.27.0

