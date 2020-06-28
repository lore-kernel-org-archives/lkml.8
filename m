Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E501C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 23:25:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35FBA206C0
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 23:25:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="udIuqj7R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbgF1XZu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 19:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbgF1XZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 19:25:48 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CBFEC03E979
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 16:25:48 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id r12so14706972wrj.13
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 16:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7WTi4TUq7voaRdDxu7BvpLKt/UshizP8z9Yd6bSgaC4=;
        b=udIuqj7RD3bvJ1fJBU9iUsF9YYUPq+58gszIe3Ze3/ihamcZySrMgHRINu/PS6MWgB
         E2SaUgwj1oGURKBSIUyTlNvUcWnk5ZnbyvUM2VqEN3rTABkBnffYc52PVWdm5GXxQG5e
         KmC8R1Kvpy7WXZLmVn/tilRQyqmGxCpicFnGU+oYBaG6pbQxc6opTJC8KzbsOBm8xXFH
         1IDRW20PNat82LzTdcAvowh8fPg4QFS4RM+mKmNzYWYTxGi4UpGB/jg/YxnLVzgh32Aw
         ac9mdIept3nrrpAPjHApg4fy1ELvUYoXzN/KshrfS9pbwRZ9repAyy9fj7cIaxbJCPZn
         vRRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7WTi4TUq7voaRdDxu7BvpLKt/UshizP8z9Yd6bSgaC4=;
        b=KKJ0g8RtsCGhCx670MMEIAhEMFJvuGs8ugFuJ8AMtNYGpb4Z+J8tPj3aTLJXlDEZsj
         BfK29fg47x0tsDliyE3cFSth1O5nRmnvQcuvLcOhbAlSFuJP9TTotdkJjdDvb111wePm
         MqBGe47+E9cQBG21R3F37wrcD4xkJD/6cvlytc3cs9mJ7TI/RIM4wv2axGNlMZhVWqLM
         n9ATDtGQ+cMjOxkET/byciHMN8HLmvEeC586C8+IU8TqAtGfHTYhDdUWc0y5rDshNSxy
         74mz/YLr7oEq+LK1oOkhSTRf1/BMfGQFfeniqCwOBlxKbe+eDan7rhC2tmSzUP8AJoMR
         3zYg==
X-Gm-Message-State: AOAM532Rz3AABC6E1kIvMPbhAmIzerimLJ9Tl+GMK4rlfQhZ6XnpbnBl
        J0Ane5e9MIJ0OX7O9oo8OnLq8aRee1kaLg==
X-Google-Smtp-Source: ABdhPJxBKTFttn5aIKqbTDiSInztCWcyyoiKgGClDSiwSd6jpFQ928V25iOcZDNxhATKzCKQ8pToFQ==
X-Received: by 2002:adf:f388:: with SMTP id m8mr14922466wro.338.1593386746514;
        Sun, 28 Jun 2020 16:25:46 -0700 (PDT)
Received: from localhost.localdomain ([2a02:587:d870:1c00:d905:af8f:383:7f91])
        by smtp.gmail.com with ESMTPSA id n8sm43396497wrj.44.2020.06.28.16.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2020 16:25:46 -0700 (PDT)
From:   Emmanouil Maroudas <emmanouil.maroudas@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Emmanouil Maroudas <emmanouil.maroudas@gmail.com>
Subject: [PATCH 1/2] perf stat: use proper macro for time conversions
Date:   Mon, 29 Jun 2020 02:25:20 +0300
Message-Id: <20200628232521.22686-2-emmanouil.maroudas@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200628232521.22686-1-emmanouil.maroudas@gmail.com>
References: <20200628232521.22686-1-emmanouil.maroudas@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

    The values of interval and timeout are in msecs as documented in the
    -I and --timeout options.

    Use MSEC_PER_SEC instead USEC_PER_MSEC to convert to struct timespec.
    Both macros have the same value 1000L (see tools/include/linux/time64.h).

    No functional change intended.

Signed-off-by: Emmanouil Maroudas <emmanouil.maroudas@gmail.com>
---
 tools/perf/builtin-stat.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 9be020e0098a..6aa866e2d512 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -613,11 +613,11 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 	bool second_pass = false;
 
 	if (interval) {
-		ts.tv_sec  = interval / USEC_PER_MSEC;
-		ts.tv_nsec = (interval % USEC_PER_MSEC) * NSEC_PER_MSEC;
+		ts.tv_sec  = interval / MSEC_PER_SEC;
+		ts.tv_nsec = (interval % MSEC_PER_SEC) * NSEC_PER_MSEC;
 	} else if (timeout) {
-		ts.tv_sec  = timeout / USEC_PER_MSEC;
-		ts.tv_nsec = (timeout % USEC_PER_MSEC) * NSEC_PER_MSEC;
+		ts.tv_sec  = timeout / MSEC_PER_SEC;
+		ts.tv_nsec = (timeout % MSEC_PER_SEC) * NSEC_PER_MSEC;
 	} else {
 		ts.tv_sec  = 1;
 		ts.tv_nsec = 0;
-- 
2.17.1

