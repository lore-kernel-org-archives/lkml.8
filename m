Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFAD8C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 03:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA93820716
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 03:34:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uRdD8KLt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbgHRDe3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 23:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbgHRDeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 23:34:19 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10551C061344;
        Mon, 17 Aug 2020 20:34:19 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id y10so7002157plr.11;
        Mon, 17 Aug 2020 20:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t5NIMSla2q4H4CYrgEoypiSInrv82zNsRbmwKfnLv98=;
        b=uRdD8KLtueArRi5YgefMeJDNmk3262hrEcmU4d2F6wq++v7Ma9rUefUixF2COxCtLc
         td5Rwz0puO391VwBccL0iLXviBugIL3u84rPg8rn+K+h4YofYGJhIsC8G6APa8gVgzX5
         2APhZ1DyLJRboh/HWU4dTWnJYXK0nLTNC8tH9fSFizTp9Ip7QLOgDFv0zUDT46SeFoAc
         yQStkqIILuLhbKNuf8KDIetfzrKboLdpW02QzOvqhM0RvSPIi0r7Wmlh/Nq4Q+AJ0A6q
         Tfg69C3isdqL8HsOzA8eHcZZF6FPHrfmwUviJRUc1g0N2OtBxFLf7tCrbRwIxKg42dX/
         ZzJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t5NIMSla2q4H4CYrgEoypiSInrv82zNsRbmwKfnLv98=;
        b=JIZirNFWDNdYyY/srWP/jddhfF28drnY0IBBMa790y6U/Zdg8XAn3Wl8hiCh5KYU1w
         5r+P8BNdpTCMmEbPcl1O0x2auLN7rrBMlcFX76dg52/nHF73PfM/MpUWLTWXiVxoUeKi
         Y3cMS8aLktm6hezIB8YIAJXW/sfEs2DOTkIVvV58kiejmr9O8OSjvIwN8YP1W3G2KyU1
         t3Jp4/CjQPLN+HHIQUNpL7VkWv9oATJ7m6uxaSIsT3OYUtybNXPXhxQ9G7CbaSxi9Ba1
         X/Boezno7uIyoyy/Df1Bqq23M7lHqiECUye9+A6qwrdrE67YagZw2c1x+1i4KZ8056jM
         FVkA==
X-Gm-Message-State: AOAM533D9ebrMnbOMNTKbtdI2gMANWgFMkaTQ0ir62xbzEnH7KK8kJTA
        +AdX6t64ndLLcjntHGDQL+M=
X-Google-Smtp-Source: ABdhPJy6d0Cu933mn+84pD243uhmVtbLS27aP0ei6qwpVknrf2wE9OmynUNrAFXe9REc+s5VjsOUuA==
X-Received: by 2002:a17:90a:4214:: with SMTP id o20mr4177105pjg.232.1597721658610;
        Mon, 17 Aug 2020 20:34:18 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (193-116-193-175.tpgi.com.au. [193.116.193.175])
        by smtp.gmail.com with ESMTPSA id b18sm19823352pgj.12.2020.08.17.20.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 20:34:18 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Nicholas Piggin <npiggin@gmail.com>, Jens Axboe <axboe@kernel.dk>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Subject: [RFC PATCH 2/2] powerpc/64s/radix: Fix mm_cpumask trimming race vs kthread_use_mm
Date:   Tue, 18 Aug 2020 13:34:05 +1000
Message-Id: <20200818033405.170457-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200818033405.170457-1-npiggin@gmail.com>
References: <20200818033405.170457-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 0cef77c7798a7 ("powerpc/64s/radix: flush remote CPUs out of
single-threaded mm_cpumask") added a mechanism to trim the mm_cpumask of
a process under certain conditions. One of the assumptions is that
mm_users would not be incremented via a reference outside the process
context with mmget_not_zero() then go on to kthread_use_mm() via that
reference.

That invariant was broken by io_uring code (see previous sparc64 fix),
but I'll point Fixes: to the original powerpc commit because we are
changing that assumption going forward, so this will make backports
match up.

Fix this by no longer relying on that assumption, but by having each CPU
check the mm is not being used, and clearing their own bit from the mask
if it's okay. This relies on commit 38cf307c1f20 ("mm: fix
kthread_use_mm() vs TLB invalidate") to disable irqs over the mm switch.

Fixes: 0cef77c7798a7 ("powerpc/64s/radix: flush remote CPUs out of single-threaded mm_cpumask")
not-yet-Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/tlb.h       | 13 -------------
 arch/powerpc/mm/book3s64/radix_tlb.c | 23 ++++++++++++++++-------
 2 files changed, 16 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/include/asm/tlb.h b/arch/powerpc/include/asm/tlb.h
index fbc6f3002f23..d97f061fecac 100644
--- a/arch/powerpc/include/asm/tlb.h
+++ b/arch/powerpc/include/asm/tlb.h
@@ -66,19 +66,6 @@ static inline int mm_is_thread_local(struct mm_struct *mm)
 		return false;
 	return cpumask_test_cpu(smp_processor_id(), mm_cpumask(mm));
 }
-static inline void mm_reset_thread_local(struct mm_struct *mm)
-{
-	WARN_ON(atomic_read(&mm->context.copros) > 0);
-	/*
-	 * It's possible for mm_access to take a reference on mm_users to
-	 * access the remote mm from another thread, but it's not allowed
-	 * to set mm_cpumask, so mm_users may be > 1 here.
-	 */
-	WARN_ON(current->mm != mm);
-	atomic_set(&mm->context.active_cpus, 1);
-	cpumask_clear(mm_cpumask(mm));
-	cpumask_set_cpu(smp_processor_id(), mm_cpumask(mm));
-}
 #else /* CONFIG_PPC_BOOK3S_64 */
 static inline int mm_is_thread_local(struct mm_struct *mm)
 {
diff --git a/arch/powerpc/mm/book3s64/radix_tlb.c b/arch/powerpc/mm/book3s64/radix_tlb.c
index 0d233763441f..a421a0e3f930 100644
--- a/arch/powerpc/mm/book3s64/radix_tlb.c
+++ b/arch/powerpc/mm/book3s64/radix_tlb.c
@@ -645,19 +645,29 @@ static void do_exit_flush_lazy_tlb(void *arg)
 	struct mm_struct *mm = arg;
 	unsigned long pid = mm->context.id;
 
+	/*
+	 * A kthread could have done a mmget_not_zero() after the flushing CPU
+	 * checked mm_users == 1, and be in the process of kthread_use_mm when
+	 * interrupted here. In that case, current->mm will be set to mm,
+	 * because kthread_use_mm() setting ->mm and switching to the mm is
+	 * done with interrupts off.
+	 */
 	if (current->mm == mm)
-		return; /* Local CPU */
+		goto out_flush;
 
 	if (current->active_mm == mm) {
-		/*
-		 * Must be a kernel thread because sender is single-threaded.
-		 */
-		BUG_ON(current->mm);
+		WARN_ON_ONCE(current->mm != NULL);
+		/* Is a kernel thread and is using mm as the lazy tlb */
 		mmgrab(&init_mm);
-		switch_mm(mm, &init_mm, current);
 		current->active_mm = &init_mm;
+		switch_mm_irqs_off(mm, &init_mm, current);
 		mmdrop(mm);
 	}
+
+	atomic_dec(&mm->context.active_cpus);
+	cpumask_clear_cpu(smp_processor_id(), mm_cpumask(mm));
+
+out_flush:
 	_tlbiel_pid(pid, RIC_FLUSH_ALL);
 }
 
@@ -672,7 +682,6 @@ static void exit_flush_lazy_tlbs(struct mm_struct *mm)
 	 */
 	smp_call_function_many(mm_cpumask(mm), do_exit_flush_lazy_tlb,
 				(void *)mm, 1);
-	mm_reset_thread_local(mm);
 }
 
 void radix__flush_tlb_mm(struct mm_struct *mm)
-- 
2.23.0

