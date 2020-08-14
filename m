Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 412D4C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 17:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 194552078D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 17:28:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y52gb1Nw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728674AbgHNR2D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 13:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728652AbgHNR2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 13:28:01 -0400
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF003C061385
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 10:28:00 -0700 (PDT)
Received: by mail-wm1-x34a.google.com with SMTP id t26so3543973wmn.4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 10:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=cI4OCXXdcluQ8udPJIeOucRKN//yXw3Lt8Ci7TJhPtY=;
        b=Y52gb1NwOVdnYMzy39zbAEp0AxmkVGEVl5sO8IimEphuNBa46b8UdemRzumD9FchzS
         rLzWvPrLf42ZtByLKUZis23wh0vVNMMWKrmlakNZyhUgxwGLHQ0j7isTtCP9kLxQKWsI
         iUFHlaLQj2CWOSPtoa5N5MfbvCuPuWY0/G+z68tmu4jVOhA/kpF87tRprJwHotDxzFz9
         nqRDRlOuGfGhohyK3x1wtrLh2l4uFHxbCmb66Caf4wskc7tBCh5B6IOlwI85JRIgEyl+
         zl6s/FZ3gp+Dd30wvZV7Ozi551d8uKRsOiyk8ZKZ4fUY6Ax+Vu47Yqdb97WW5es7FCqk
         3r7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=cI4OCXXdcluQ8udPJIeOucRKN//yXw3Lt8Ci7TJhPtY=;
        b=I8S0yBdSAdTa7P4B6F0PM8UGGSrPyGOVunKt6c3pG6IrVPov0LAh9aayJTEJH7MLsh
         xhYoxZUgb/i6TDFR5694oKji2ePO28h0HBdiDRAzxjA6hNUVqp7dLsY9jvA+gxWwCAQD
         iusGYzJw4mj9kM0CNZZyuiaLBiZAuEo8XQrDlkNeuAmCw1e/dVyhuwhVz4hM0EGTd5pX
         0ogq/s54tx/YTES7BNU8s3b4cEYfZp/vsGmtsA8wUe2Uagp5/GHcSYRlrfDW5hwf2A+O
         BMA+8J7XhDzb08XOPoyaHcW7eH44yECW8ducQ4QxaF/Ts0XRgM521minooRyQ9r7USd1
         +oPA==
X-Gm-Message-State: AOAM532Kh2qJRYXWRfSu29MsPJCYTmKDheysL/OzhwRVVpD29aE703wp
        p+PurYimd/YBoaoZeCDAEbdd3eLA472mVbOL
X-Google-Smtp-Source: ABdhPJwOZsvPwGKa5m7TqARujAwtgW8ZF1arqYgXqkG6x3udD3qrrXjjRug8FIoPmVcf0uINBQGYw7oWCR4/Amlh
X-Received: by 2002:a7b:c4d3:: with SMTP id g19mr3322924wmk.29.1597426079500;
 Fri, 14 Aug 2020 10:27:59 -0700 (PDT)
Date:   Fri, 14 Aug 2020 19:26:57 +0200
In-Reply-To: <cover.1597425745.git.andreyknvl@google.com>
Message-Id: <ea36f46b5223a67d6333acbcc79ba07380608010.1597425745.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1597425745.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
Subject: [PATCH 15/35] kasan: rename print_shadow_for_address to print_memory_metadata
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        kasan-dev@googlegroups.com
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a preparatory commit for the upcoming addition of a new hardware
tag-based (MTE-based) KASAN mode.

Hardware tag-based KASAN won't be using shadow memory, but will reuse
this function. Rename "shadow" to implementation-neutral "metadata".

No functional changes.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/report.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index ada3cfb43764..8ad1ced1607d 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -255,7 +255,7 @@ static int shadow_pointer_offset(const void *row, const void *shadow)
 		(shadow - row) / SHADOW_BYTES_PER_BLOCK + 1;
 }
 
-static void print_shadow_for_address(const void *addr)
+static void print_memory_metadata(const void *addr)
 {
 	int i;
 	const void *shadow = kasan_mem_to_shadow(addr);
@@ -316,7 +316,7 @@ void kasan_report_invalid_free(void *object, unsigned long ip)
 	pr_err("\n");
 	print_address_description(object, tag);
 	pr_err("\n");
-	print_shadow_for_address(object);
+	print_memory_metadata(object);
 	end_report(&flags);
 }
 
@@ -352,7 +352,7 @@ static void __kasan_report(unsigned long addr, size_t size, bool is_write,
 	if (addr_has_metadata(untagged_addr)) {
 		print_address_description(untagged_addr, get_tag(tagged_addr));
 		pr_err("\n");
-		print_shadow_for_address(info.first_bad_addr);
+		print_memory_metadata(info.first_bad_addr);
 	} else {
 		dump_stack();
 	}
-- 
2.28.0.220.ged08abb693-goog

