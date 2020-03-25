Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC7FDC54FD0
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 16:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C1A32073E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 16:42:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SraYyH3S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbgCYQmQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 12:42:16 -0400
Received: from mail-wm1-f74.google.com ([209.85.128.74]:41341 "EHLO
        mail-wm1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727236AbgCYQmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 12:42:15 -0400
Received: by mail-wm1-f74.google.com with SMTP id f207so1096326wme.6
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 09:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=PkTGLT0FCPWQdDVWIHBabhnbaBwpL2cH8uoEASC76jo=;
        b=SraYyH3SUMcFSGgTxuL+wlgBPSqb+9boUl7WWj4NDNPCkgi00kSg42V+BnlZPXlE9v
         h7wfRdSPHKPouIacPDCUxyudLjvzk74i8Ag+UvMfgM2bAtlX21c6BUrWKqhvnuAzxIXZ
         Wogc26vS/AwzFyl1qfAuPMxSy5ZCQL9UlN6KqIZI44Vs706w9c9VCAEdD2Gi3f3JUEAU
         HgTFHoyP+11WfCx9cjkxw0H72s2HnA+WLur8qoULj3g9++rLTDSRpnoG+oVOj+N1yvlF
         4V+jTfttW/56cIHyFW75PHQ5UfMtoPM9bIEtvahIgQVg3XADgAbP7UqoRXEIYlkPBj9h
         QHTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=PkTGLT0FCPWQdDVWIHBabhnbaBwpL2cH8uoEASC76jo=;
        b=AF9TQWtZ3kvAnO6ZurCPxGkXVDNvEOXI7CaVlrrqNriin5zQ6szv5liZQBrPqnj2W0
         UqrOLs4P4xWlzey6gogZkj3DY+kBEto6u3GXhCVhuePTnxfORZ7ouuww+fgWhgBseOU9
         CRjYsUoZii2b2ZhNojHiMI/SRf5Gdw5K6A5brHRdo3tBjARc9AxrfMC9ur94ap340Mnd
         C9yW88uy+QZlhSiQjMdzlydhua7unNOw4svkeb2Po7guiwi0FB9gx3usX0ZT0KWNw+Xe
         jO11tawVGTiWEz1kRU7mCbGCPKd76LXgJYh7tLcV+eqK8fu48Iz3lzVc+tK0pm9mWa1e
         atGA==
X-Gm-Message-State: ANhLgQ1CZVWZd98k6wpIZ31hb6KafKDx8cB+fv5BcJCdvaHRmLnLfJKM
        KHmok+h/wFKRwG5Rv7ocPReV33Lotw==
X-Google-Smtp-Source: ADFU+vvvixIpSe0AgIOoiUdy38/4kVolA1RYlk4RoyWHnrxzpPd0TqbET8DKvRqVTz1UDj5tCK1hrWHEIQ==
X-Received: by 2002:adf:9b96:: with SMTP id d22mr4630726wrc.249.1585154532828;
 Wed, 25 Mar 2020 09:42:12 -0700 (PDT)
Date:   Wed, 25 Mar 2020 17:41:57 +0100
In-Reply-To: <20200325164158.195303-1-elver@google.com>
Message-Id: <20200325164158.195303-2-elver@google.com>
Mime-Version: 1.0
References: <20200325164158.195303-1-elver@google.com>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
Subject: [PATCH 2/3] objtool, kcsan: Add explicit check functions to uaccess whitelist
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     paulmck@kernel.org, dvyukov@google.com, glider@google.com,
        andreyknvl@google.com, cai@lca.pw, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add explicitly invoked KCSAN check functions to objtool uaccess
whitelist. This is needed, to permit calling into
kcsan_check_scoped_accesses() from the fast-path, which in turn calls
__kcsan_check_access().  __kcsan_check_access() is the generic variant
of the already whitelisted specializations __tsan_{read,write}N.

Signed-off-by: Marco Elver <elver@google.com>
---
 tools/objtool/check.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index b6da413bcbd6..b6a573d56f2e 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -468,8 +468,10 @@ static const char *uaccess_safe_builtin[] = {
 	"__asan_report_store8_noabort",
 	"__asan_report_store16_noabort",
 	/* KCSAN */
+	"__kcsan_check_access",
 	"kcsan_found_watchpoint",
 	"kcsan_setup_watchpoint",
+	"kcsan_check_scoped_accesses",
 	/* KCSAN/TSAN */
 	"__tsan_func_entry",
 	"__tsan_func_exit",
-- 
2.25.1.696.g5e7596f4ac-goog

