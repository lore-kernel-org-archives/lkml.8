Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE460C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 17:29:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 890A5207DA
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 17:29:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ku0irwum"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728842AbgHNR3b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 13:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728761AbgHNR2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 13:28:40 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73AF3C061386
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 10:28:40 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id 195so6503204qke.14
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 10:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=q24QkMKZO6T4dOo8z/uPgVahsCI2M3nldwxAJ8Cpi0Y=;
        b=ku0irwumRN6Ip49VSreq9f2tsq3r4WWyUSZtTgT8ZfbqcamgfahfJv6gpuKCz5H6gy
         Q2EQk2cVD2v4NT1Ndg/ERBlP8Mgblb3K+/EoQ0OaVHn92co8FyMN4gM6NFFNb/tcKxjn
         Chs+FedkWOcYI+GgaEaP+culABQRUNCY66Cfnp7MkT41IEgPXFAcRnWVRitd5Cf27eWM
         fzIiG7nA/mXCk86tQkqB4dpoZomH7hfjiyqs6xYKrhnfdK1btBGZGw0MSLjRiPEUI+UR
         CJ9Sj6V3KiwOY8URNLAZ4vHQO2revQtUcwm4pEV1kgvvn62rjIw734f9oWX9GBeblCSl
         lpzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=q24QkMKZO6T4dOo8z/uPgVahsCI2M3nldwxAJ8Cpi0Y=;
        b=qg8nfWY8loWWLWRLaXywjV38bsgSo81I84DDK2JRXpXoQ5xIC5W2sErkkgjN9/juNu
         H4x8SVoiA/V2hPpMi8m7VJG8BKUAOrsZranGjzLvEYvPw+Bx6lUav8VbNUVuHa8ZxgDO
         8ATcUl5noOCM1Nv5WkYkplCdilUoyKAGBFXAvxTX8ExR34g03y16h2wAStQBvKhjnrjw
         NtBUvveCxKDG+UvMgZvp+2iTVEd3IVp8vhhY5SCrkgUlGgJ+m1uh/Q7Kfm+YKJdNceoY
         24/+HC/HY9BL9DJHF/AsWQWM1O3ubRYFw1/Dwqi+cVcksUT5spcKBTjKMme9hBGrb4FC
         tJzg==
X-Gm-Message-State: AOAM530oB4aM4I/FmWDLnJ7csTE1PZJkeoLDMm+vIgw7y91a4Ku63Wfk
        887eg9a2vthFGqOjvYDwQIvARiy7PG84GWLZ
X-Google-Smtp-Source: ABdhPJw4HoEDexHBBMUv3XZU8fBSAnmUvYtM/53KDfmikkTGWUkMCsOZ+SysTqaaaZvlv5gyrbE1cTAASfH+tBvs
X-Received: by 2002:a0c:b895:: with SMTP id y21mr3726762qvf.87.1597426119355;
 Fri, 14 Aug 2020 10:28:39 -0700 (PDT)
Date:   Fri, 14 Aug 2020 19:27:14 +0200
In-Reply-To: <cover.1597425745.git.andreyknvl@google.com>
Message-Id: <4691d6019ef00c11007787f5190841b47ba576c4.1597425745.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1597425745.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
Subject: [PATCH 32/35] kasan, arm64: print report from tag fault handler
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

Add error reporting for hardware tag-based KASAN. When CONFIG_KASAN_HW_TAGS
is enabled, print KASAN report from the arm64 tag fault handler.

SAS bits aren't set in ESR for all faults reported in EL1, so it's
impossible to find out the size of the access the caused the fault.
Adapt KASAN reporting code to handle this case.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 arch/arm64/mm/fault.c |  9 +++++++++
 mm/kasan/report.c     | 11 ++++++++---
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index c62c8ba85c0e..cf00b3942564 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -14,6 +14,7 @@
 #include <linux/mm.h>
 #include <linux/hardirq.h>
 #include <linux/init.h>
+#include <linux/kasan.h>
 #include <linux/kprobes.h>
 #include <linux/uaccess.h>
 #include <linux/page-flags.h>
@@ -314,11 +315,19 @@ static void report_tag_fault(unsigned long addr, unsigned int esr,
 {
 	bool is_write = ((esr & ESR_ELx_WNR) >> ESR_ELx_WNR_SHIFT) != 0;
 
+#ifdef CONFIG_KASAN_HW_TAGS
+	/*
+	 * SAS bits aren't set for all faults reported in EL1, so we can't
+	 * find out access size.
+	 */
+	kasan_report(addr, 0, is_write, regs->pc);
+#else
 	pr_alert("Memory Tagging Extension Fault in %pS\n", (void *)regs->pc);
 	pr_alert("  %s at address %lx\n", is_write ? "Write" : "Read", addr);
 	pr_alert("  Pointer tag: [%02x], memory tag: [%02x]\n",
 			mte_get_ptr_tag(addr),
 			mte_get_mem_tag((void *)addr));
+#endif
 }
 
 static void __do_kernel_fault(unsigned long addr, unsigned int esr,
diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index c904edab33b8..34ef81736d73 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -65,9 +65,14 @@ static void print_error_description(struct kasan_access_info *info)
 {
 	pr_err("BUG: KASAN: %s in %pS\n",
 		get_bug_type(info), (void *)info->ip);
-	pr_err("%s of size %zu at addr %px by task %s/%d\n",
-		info->is_write ? "Write" : "Read", info->access_size,
-		info->access_addr, current->comm, task_pid_nr(current));
+	if (info->access_size)
+		pr_err("%s of size %zu at addr %px by task %s/%d\n",
+			info->is_write ? "Write" : "Read", info->access_size,
+			info->access_addr, current->comm, task_pid_nr(current));
+	else
+		pr_err("%s at addr %px by task %s/%d\n",
+			info->is_write ? "Write" : "Read",
+			info->access_addr, current->comm, task_pid_nr(current));
 }
 
 static DEFINE_SPINLOCK(report_lock);
-- 
2.28.0.220.ged08abb693-goog

