Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C9AFC2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 00:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6B5F20757
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 00:13:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qrqLRtG/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgDIAN5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 20:13:57 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:48082 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbgDIAN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 20:13:56 -0400
Received: by mail-pl1-f202.google.com with SMTP id l1so6374828pld.14
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 17:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=fLv9na09IyKKayz49eZdHcsdFlK4tyhNPMNHoFdhlbI=;
        b=qrqLRtG/vh7YOJdZSWwmFAdalPFoXjx5qDNfJVtWeM5M+mE6/t5DTXfYsuLZdMiO1S
         9I9RU6x7tCGNDaYd9afkBBsc7EO7vMhbllAIvJhXgpQN9ss0lq/WduPmOFG8ToYaDiqo
         APBaZJOSZYDUt3vluwQNk1F3rnSwraSXnw9PV2+/ZkbybABsNMKRtM9bRXb8V3Gj1kIQ
         f3xft9UyupjwJTtbn0HE4IoSmpFgE1ybnCbZK6WPM14D0G26ca/sTM1bMMOuwetCvwCO
         odXRGJTj0W1ocmqwmRXDt/4vmxHj+Wzkp2ZkVUQqaVWT1PJdozh7AN9prQ0yUD7wQulv
         lDEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=fLv9na09IyKKayz49eZdHcsdFlK4tyhNPMNHoFdhlbI=;
        b=XOEd5Oq1hAmLa/hfD5cFssyjrTc4KxxjaYUcztDDZFudSkRX/3uSyO12kfAKl1X7xc
         Z7FUGug3fbi4ZEaLhlvRJW2gZXDd2n+9QUW1zwaAWnR436EparucuDJIvHD5wSF8BP52
         B3xwf0xZpgjX2fSS7bhnawtTPUAPZDd0NU6h6a+kAs/8ICY06V+Sf0PGyHyvZQOUY769
         ts+bJOJixs/+27xj1c85hL4GMFf8fOG39R/rMZwoNe3xvfSNo2wo8R/RcpyesxZ0E8ov
         f/W/U3axX6uUeploppdF1UH+nNm2LQO4QsO2LVxn0k0PNLcx0eGCFNnJc4ovZsMioxR2
         RI8w==
X-Gm-Message-State: AGi0PuarFwFHXZ+z9YZv0zWDKMJUs9LKsg8C7UE726bCL8LSE9jYJXZL
        E5jGSF00d0lRK6zng8Cwl1Z7DyKjt20Z
X-Google-Smtp-Source: APiQypLhUmHLIg179sCSfajrpEMugqWUWYc8Ie/Uif71orS/C4kWk8jGyQstyeusn/Wf1WVswTSHr7rbmDqy
X-Received: by 2002:a63:8343:: with SMTP id h64mr9089812pge.73.1586391235833;
 Wed, 08 Apr 2020 17:13:55 -0700 (PDT)
Date:   Wed,  8 Apr 2020 17:13:52 -0700
Message-Id: <20200409001352.225135-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.0.292.g33ef6b2f38-goog
Subject: [PATCH] clang-format: don't indent namespaces
From:   Ian Rogers <irogers@google.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change doesn't affect existing code. Inner namespace indentation
can lead to a lot of indentation in the case of anonymous namespaces and
the like, impeding readability. Of the clang-format builtin styles
LLVM, Google, Chromium and Mozilla use None while WebKit uses Inner.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .clang-format | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.clang-format b/.clang-format
index 6ec5558b516b..2d7754a4b6d8 100644
--- a/.clang-format
+++ b/.clang-format
@@ -482,7 +482,7 @@ KeepEmptyLinesAtTheStartOfBlocks: false
 MacroBlockBegin: ''
 MacroBlockEnd: ''
 MaxEmptyLinesToKeep: 1
-NamespaceIndentation: Inner
+NamespaceIndentation: None
 #ObjCBinPackProtocolList: Auto # Unknown to clang-format-5.0
 ObjCBlockIndentWidth: 8
 ObjCSpaceAfterProperty: true
-- 
2.26.0.292.g33ef6b2f38-goog

