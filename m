Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2825C54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 15:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96A4220767
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 15:47:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vCckSVmY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbgDXPrq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 11:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726301AbgDXPrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 11:47:46 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1788C09B046
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 08:47:44 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id w15so10451018ybp.16
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 08:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=oVv3oHwxIfr4RsJUouPNW2RXip7ts7Rm/qpNl5CFftM=;
        b=vCckSVmYqEhUBfuiNhMPfNxAj3Weqd7vBOJ8YENvroGbwb1o28+BjmHu0TZYvyJKjs
         kIsDh4ZLgvnnXxR85JIfeNfaUd/uEN1U3eY3nAGd68C1cEWWbCS/WyeZouZW12TjQBYB
         Jzyjds69PiMAxtiymZ0j3qwv4aowC3SQqwBJrDkNBpKiUXt2ASvR0f31Pzeart2LcfIw
         hs3c9gGhtEkwrSqSUoZaWQnxFIoi3XR2dZTCMr922HKUiS4KQSTAjTDB69mfHTkI0daD
         goWCDDwEv242fCI4tPPPU1kBlxP6fWaLpWJ8k9nYjOtPS59thqPgvVdPrWji6QIPbtrW
         cBfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=oVv3oHwxIfr4RsJUouPNW2RXip7ts7Rm/qpNl5CFftM=;
        b=FcOyhOP5dE5TzEZ5crmKDIvpiGAS9QSHCZkYtamFWMH0QohkfJoqhdW/PjhlkQWUsW
         /w4D9EslAwNTxZcDtnoemi81neasvuM3Qbb1WK6ixQ0bYIto6JUsFFnDH+ONRmyGzNzT
         mzQPgfFW42RmueRIPqQrppMDPARow7djZHIK7pQIIz4vn5+aULgdwPEgq5pmqLvPQFmZ
         0RV7T1Lb2jFC/sDTMfnd2nsnD+ZK/IlecFj6H4teDtVs8kbvNCCb2Cv3oDOVhK/WP7ef
         K6urkJatjCult25nVxuCFW7ZVXBfEQwWAkFkKzAXAMWmQMfDNte3h3Ii5bO18AzIgLWH
         XKQA==
X-Gm-Message-State: AGi0PuYft5jlYqxDo6HKT4/orhxD9z5/07dRiSdolgZ3r4KKAQcyqVaZ
        lIrMH98f3iXHM3pWeGVn3VOwJeE8kA==
X-Google-Smtp-Source: APiQypIu+bAY3rvbZTmH6gM7XgOIMYp0r3KGjFX++a6TN+a96r7kWKfhpQ7M+w87QCShYgNuzRzDliUnmw==
X-Received: by 2002:a25:dd81:: with SMTP id u123mr9210131ybg.109.1587743263914;
 Fri, 24 Apr 2020 08:47:43 -0700 (PDT)
Date:   Fri, 24 Apr 2020 17:47:30 +0200
In-Reply-To: <20200424154730.190041-1-elver@google.com>
Message-Id: <20200424154730.190041-2-elver@google.com>
Mime-Version: 1.0
References: <20200424154730.190041-1-elver@google.com>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
Subject: [PATCH 2/2] objtool, kcsan: Add kcsan_disable_current() and kcsan_enable_current_nowarn()
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     paulmck@kernel.org, dvyukov@google.com, glider@google.com,
        andreyknvl@google.com, will@kernel.org, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both are safe to be called from uaccess contexts.

Signed-off-by: Marco Elver <elver@google.com>
---
 tools/objtool/check.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 70e721002743..a22272c819f3 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -482,6 +482,8 @@ static const char *uaccess_safe_builtin[] = {
 	"kcsan_found_watchpoint",
 	"kcsan_setup_watchpoint",
 	"kcsan_check_scoped_accesses",
+	"kcsan_disable_current",
+	"kcsan_enable_current_nowarn",
 	/* KCSAN/TSAN */
 	"__tsan_func_entry",
 	"__tsan_func_exit",
-- 
2.26.2.303.gf8c07b1a785-goog

