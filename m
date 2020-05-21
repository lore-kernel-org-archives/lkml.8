Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5846C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 11:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B426A207D3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 11:10:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LW0ey+ZE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729152AbgEULKP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 07:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729140AbgEULKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 07:10:11 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B1FC061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 04:10:11 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id m9so6732406qvl.18
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 04:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=YxAJO5zjAlDcESQjL2hotUlRyCYCv27YW58n87FzjMM=;
        b=LW0ey+ZEx7FduX4sBz7baHzBYGpMZsn5JeJwzMtQhMV+XjHJ0Efqu7NxADlITAIkPn
         XaKxPuta51yyd8aBik84u07fl2BBySt71rvhGhGRM3H00RanGAWeDaAd7O0b8BRdmZtK
         SSW5la3QtjUcQUUnYWP+GsxinITkagGwEBF3VlIickOly6XSD9ai8dAATRL6Vji336RW
         cETsdGhLswccP3cuT6Ty7kOBDmN4VfzD1N5hvj2j6XkB7aS4ZgglDWdjyuKaoB+Gzflr
         0y6rYj1fMXnIxcyoVnrm+1MwVajBlntqYDZgYR5otqdA5j4sn48X8PspZ7Vg3icUCy25
         5xRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=YxAJO5zjAlDcESQjL2hotUlRyCYCv27YW58n87FzjMM=;
        b=lxYVTW0jq0VQFNNgsUjvmgsffPPxPC1GVD9LzO70qycW3dmmJXiNpZr83XsBW+dt3S
         xVrvqAHT4BON+6+HJV5rAoE+019o9WkZ5T/H8cxbyMgaTJFq3QdIZxjjDSG8k1Q+lQrH
         cNZfQgwAURXVY8OeEMX0hNJAYpjclUQC63DuU3m7Jb47UKxofMB/FmiI6IGwPBr7y9wR
         ZVIPPCkKwGeJkB49xbr/9fLt/XPxokIAVXX0V3nbgYgl6aWaViWwuUCDgbDY0qSmSQV4
         5gwcu4LB+51IdlAIRJHX4Dl7IqbYKsEe/5KKZJiMa3LwO5zSFwykJstVFLCWMmwCUFED
         uvSA==
X-Gm-Message-State: AOAM5332z2/jVMgszHcC4FEYd2epeUy7+fCZ0fEw+hH+eO3V4XekQDuh
        RVxymlTW67FnvY1BQ5WZFJt5daZdlA==
X-Google-Smtp-Source: ABdhPJxHai02gu+Q19LpR3p5CxCFsXg62PXlsdd3yKCkcdH/zdxGgFe6e635DdGsxSSbrY92+BDk47Cqlw==
X-Received: by 2002:a0c:8d0d:: with SMTP id r13mr9507280qvb.53.1590059410838;
 Thu, 21 May 2020 04:10:10 -0700 (PDT)
Date:   Thu, 21 May 2020 13:08:52 +0200
In-Reply-To: <20200521110854.114437-1-elver@google.com>
Message-Id: <20200521110854.114437-10-elver@google.com>
Mime-Version: 1.0
References: <20200521110854.114437-1-elver@google.com>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
Subject: [PATCH -tip v2 09/11] data_race: Avoid nested statement expression
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     paulmck@kernel.org, dvyukov@google.com, glider@google.com,
        andreyknvl@google.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@kernel.org,
        peterz@infradead.org, will@kernel.org,
        clang-built-linux@googlegroups.com, bp@alien8.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It appears that compilers have trouble with nested statements
expressions, as such make the data_race() macro be only a single
statement expression. This will help us avoid potential problems in
future as its usage increases.

Link: https://lkml.kernel.org/r/20200520221712.GA21166@zn.tnic
Signed-off-by: Marco Elver <elver@google.com>
---
v2:
* Add patch to series in response to above linked discussion.
---
 include/linux/compiler.h | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 7444f026eead..1f9bd9f35368 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -211,12 +211,11 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
  */
 #define data_race(expr)							\
 ({									\
+	__unqual_scalar_typeof(({ expr; })) __v;			\
 	__kcsan_disable_current();					\
-	({								\
-		__unqual_scalar_typeof(({ expr; })) __v = ({ expr; });	\
-		__kcsan_enable_current();				\
-		__v;							\
-	});								\
+	__v = ({ expr; });						\
+	__kcsan_enable_current();					\
+	__v;								\
 })
 
 /*
-- 
2.26.2.761.g0e0b3e54be-goog

