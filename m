Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B37C2D0A7
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 20:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C539A20658
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 20:33:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="ufRzOZtY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729329AbgICUdk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 16:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729544AbgICUcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 16:32:55 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F9AFC061A02
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 13:31:39 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id p138so4011171yba.12
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 13:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=3q7TZ5J5xqKWdUS4X8SiQHdlDi3K3u69bSPkIoNlqR8=;
        b=ufRzOZtYYauSzvxZUBKz1JVbuUwKqmAJdSrdtsdAtyClxzQSdbUMjMfIMupNHjnLGB
         WO4ZqGFWI4GoHdfXhHBAF+P/jv072mNJPl0sQzhOhWjmxcDeq8t/wGGp/8OanND4USfj
         LhikjLiJG9jAk0+cvkHoOwClvc4d+s/6mEvmHU+7r2wfgvpCQERcCjQH7zsDH2517Ogk
         GD3ZV/LG3aSx/OdpXy0Szz6VTm1uw47NfsFGVYKWXK4IlQH2y+9jyGDbrxKpkAqRVQ6l
         TgM50rxrgjBcqFMaRVrmvkVprT/6WaCjwoJLbBtb5rXpbpl2VQ2HuV9qu5Jf7aVs2fRs
         o+ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=3q7TZ5J5xqKWdUS4X8SiQHdlDi3K3u69bSPkIoNlqR8=;
        b=VwvkF6T8uCVTB66gMRRKSQTszMDc5HSGxpr+cTB2+wZuqCH8h0rYAmLL1BSQF7zmS4
         lflTItewuSZ2UfZ9EreK37cLz4nHIA/5OVYZZGlKc9bgaVUdQPYfV7J3xJQqEATsOZ4A
         YG1ltXMbLg9qeBjt8MOFNGL+dH0ScvxhuywRBNCSfKYcQ7q7d9HBYWBiKbXllCfIMRyz
         saZdiMWZLhFdTa6Vt3pZF31XKFeJrBb52/nyQJM3vtWkuuqiyzQi7goCOQ4DqB3tklv0
         nkan6dHBKKWxtPQu1Ig3xkeKyXf6ci8udbJ6iP8BFOV1nIOLrP0qHmQQlj208W52fSPZ
         GBEw==
X-Gm-Message-State: AOAM530OtMI5zQ5Soo03szhibMtmG+7hjlI6hpyyYN527zwzewmPENcU
        aSiLx2mRCJzstqgBKCeGCTJHdrX1DNWJIVsmuXo=
X-Google-Smtp-Source: ABdhPJzSHh4NCUcdQaWfXuHL4xXV+3Gzu7YAUpxYnKR7xzXHL7k1OIFuYPArBmNIqbbqiPyK+SQbqhBjAf2rbEmrgrI=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a25:6555:: with SMTP id
 z82mr6003281ybb.472.1599165098726; Thu, 03 Sep 2020 13:31:38 -0700 (PDT)
Date:   Thu,  3 Sep 2020 13:30:46 -0700
In-Reply-To: <20200903203053.3411268-1-samitolvanen@google.com>
Message-Id: <20200903203053.3411268-22-samitolvanen@google.com>
Mime-Version: 1.0
References: <20200624203200.78870-1-samitolvanen@google.com> <20200903203053.3411268-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
Subject: [PATCH v2 21/28] drivers/misc/lkdtm: disable LTO for rodata.o
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        x86@kernel.org, Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Disable LTO for rodata.o to allow objcopy to be used to
manipulate sections.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Acked-by: Kees Cook <keescook@chromium.org>
---
 drivers/misc/lkdtm/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/lkdtm/Makefile b/drivers/misc/lkdtm/Makefile
index c70b3822013f..dd4c936d4d73 100644
--- a/drivers/misc/lkdtm/Makefile
+++ b/drivers/misc/lkdtm/Makefile
@@ -13,6 +13,7 @@ lkdtm-$(CONFIG_LKDTM)		+= cfi.o
 
 KASAN_SANITIZE_stackleak.o	:= n
 KCOV_INSTRUMENT_rodata.o	:= n
+CFLAGS_REMOVE_rodata.o		+= $(CC_FLAGS_LTO)
 
 OBJCOPYFLAGS :=
 OBJCOPYFLAGS_rodata_objcopy.o	:= \
-- 
2.28.0.402.g5ffc5be6b7-goog

