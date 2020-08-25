Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF2AEC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 14:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B448F2072D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 14:36:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="UxJfVoSQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgHYOgI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 10:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbgHYOfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 10:35:51 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB726C061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 07:35:51 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id a14so15021654ybm.13
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 07:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=k54hAuV/R48nxWYsw6Z5KxJrA9oI9B0nXG5/JiFy5us=;
        b=UxJfVoSQ6M50tQ6tL3OjiBKFoj5dbR9m2teUe/DbOwuHyLkEOQBaiPEO8CHG4hmfyP
         fw9VamB60nxGGIPKTO6+9jrJQcpAq81zZNXrencHIPpiOkuEYiio5PV1kaj6/fEsGnrP
         EQGDUtUH03q6+8yY3OyG5DLCqmKVWa1y2zU6+CDTewQn4qSZwkLYJu8AUVWf7yuyGhdR
         4yCbkQnCsSUROFh3TnbORkNAiqkboGYpkUzEoeaaVJL5iv9JMtD68ivIFKowik+pknw5
         b5KJZz6IAx5/2KDTkHz8DXuSbyhZPQS/6bwr0ms8euZHox0FwCSUhaTEFjOx230aDma3
         lOMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=k54hAuV/R48nxWYsw6Z5KxJrA9oI9B0nXG5/JiFy5us=;
        b=pZXeOhkNmlZfPGiX6Wv1M9xSq8yK8tXmsYwDX3NvSH9GnE1Op7v1n0Nj6dH+Y5S2jX
         YPrIO5kHyCOM1kZ/6SCl6K99mMeTWcpWIEcjgSMDFryNQEByW1p2cDjZ4ieg/SzFUgKi
         gzhEXeSedV3kGMNL12KCKd/FdK0JhEqIts4yn/TeOYyPgH1ghcCOVhTOlvTWFr+vYHad
         2ONZLSLSGxXMDZut0LaQbV1UJ6tqBFy9RpHbws9MdWjggTdKkrhvE/r6lpHzTf5G2RcP
         +cuah4j1QNYZUFS6osKInfXotDg8xecPuyX/UMj6F7XLDiIpmks6EATiLiLyh13q5/4N
         xs3w==
X-Gm-Message-State: AOAM532s/qZhEAFj9ZylEtdI6euzpr/IPXp44BvXblliwguMM4GzygXy
        X7/droLRduqdNkjo3NFUlnISglG276fKyeaQSQY=
X-Google-Smtp-Source: ABdhPJxV4FKG8uHtaQph860dD9ew7juRufCD1tdUO7icppNv8/UvfInW+cK167h5B1JTota55ag5L0+hLTjQqbTbI4M=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:4d25])
 (user=ndesaulniers job=sendgmr) by 2002:a25:38c5:: with SMTP id
 f188mr14594662yba.132.1598366150820; Tue, 25 Aug 2020 07:35:50 -0700 (PDT)
Date:   Tue, 25 Aug 2020 07:35:40 -0700
Message-Id: <20200825143540.2948637-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
Subject: [PATCH] MAINTAINERS: add LLVM maintainers
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nominate Nathan and myself to be point of contact for clang/LLVM related
support, after a poll at the LLVM BoF at Linux Plumbers Conf 2020.

While corporate sponsorship is beneficial, its important to not entrust
the keys to the nukes with any one entity. Should Nathan and I find
ourselves at the same employer, I would gladly step down.

Cc: clang-built-linux@googlegroups.com
Cc: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 33aab0c88118..0cbb24753153 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4249,6 +4249,8 @@ S:	Maintained
 F:	.clang-format
 
 CLANG/LLVM BUILD SUPPORT
+M:	Nathan Chancellor <natechancellor@gmail.com>
+M:	Nick Desaulniers <ndesaulniers@google.com>
 L:	clang-built-linux@googlegroups.com
 S:	Supported
 W:	https://clangbuiltlinux.github.io/
-- 
2.28.0.297.g1956fa8f8d-goog

