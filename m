Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD0AC3F2CD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 09:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64C5D21775
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 09:34:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="fpjHsJmn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbgCCJeg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 04:34:36 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:33470 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbgCCJee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 04:34:34 -0500
Received: by mail-pj1-f68.google.com with SMTP id m7so1024356pjs.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 01:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZvzoObnBVzlXL6MM7KZpnEWysdUu+lTn+skS3IgavUM=;
        b=fpjHsJmnfVmUfPGfvrMJIa6ugplGKPICLu4RJXOHo7RaSJTcXOU6xdvU/x1V9fDRST
         BJLsJpki/oC/f9dRHAMFZA1xF6eP0xXFokNg4O757ciUtd0hYZ8+7NIy+yJ+FLifOqUU
         eCCJlsMz12M376owQxkzYeJqfKI8RhXnu0HqmwLoxZD2g/GTBqK5W9/+mOFZC+rwuAVm
         mGhtNDIOu4GbdAzVB0pFGppcf8X2uPNu3otLH7wcodCYJAdZdc19t/aS4szxPfzW34Gr
         CVi0ft0UB/9+hTiN+o1VrOOTPt0MjJQ2FiZ1/k7xRMDkZv/6V0iZG9a6ScYlSKmm3idf
         UjnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZvzoObnBVzlXL6MM7KZpnEWysdUu+lTn+skS3IgavUM=;
        b=U6Wnis1AMMmNPSkdfb/PtCHRm0HPo9pLU/B7l2TyeQSFocMxyf8k+EApdwssky3MgB
         NlEtkyCWcqxGzAGCDJ8ROZ8d3NEJMWKHfhvLz7h4EMjkbI1VrtYV0goALCcRk5PgP7Wj
         nReW398t2uwd2Sy9VmjKNHrJNWIIHiaP7jirrIWDSGxovzRX67CFfHlDqJFyP97nsydR
         Ror7KFndWrBu8Fe0B4UPW49EsgzB4z5Mante4Ul2vFdom40aJYOPdxinv++t7Q+8SYa7
         iK3b7DZIdZceKUqMgzdK2Vb9rN7XzFf8gCRribmlUJpFO/p3ZsuNGb/WDUwG2rCOIOHe
         J7xA==
X-Gm-Message-State: ANhLgQ3ELbvEqVxTbnhL8jNhHKEkAuBmBNa1lf36hH9jM4SrqkPtuQw4
        X32v2pwxlwKQueDwsxLEyJzdhw==
X-Google-Smtp-Source: ADFU+vuHS1eBdaLNvluWEEmf97yC/t9L3b5bxpdp0cpSTw/h3n9o9CnJqe7dhb9ZXXuC4PkHvw9ArQ==
X-Received: by 2002:a17:902:8f91:: with SMTP id z17mr3422269plo.234.1583228073577;
        Tue, 03 Mar 2020 01:34:33 -0800 (PST)
Received: from hsinchu02.internal.sifive.com (220-132-236-182.HINET-IP.hinet.net. [220.132.236.182])
        by smtp.gmail.com with ESMTPSA id s5sm1494745pfh.47.2020.03.03.01.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 01:34:33 -0800 (PST)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     green.hu@gmail.com, greentime@kernel.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Greentime Hu <greentime.hu@sifive.com>
Subject: [PATCH 2/2] riscv: fix the IPI missing issue in nommu mode
Date:   Tue,  3 Mar 2020 17:34:18 +0800
Message-Id: <20200303093418.9180-2-greentime.hu@sifive.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200303093418.9180-1-greentime.hu@sifive.com>
References: <20200303093418.9180-1-greentime.hu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the IPI(inner processor interrupt) missing issue. It
failed because it used hartid_mask to iterate for_each_cpu(), however the
cpu_mask and hartid_mask may not be always the same. It will never send the
IPI to hartid 4 because it will be skipped in for_each_cpu loop in my case.

We can reproduce this case in Qemu sifive_u machine by this command.
qemu-system-riscv64 -nographic -smp 5 -m 1G -M sifive_u -kernel \
arch/riscv/boot/loader

It will hang in csd_lock_wait(csd) because the csd_unlock(csd) is not
called. It is not called because hartid 4 doesn't receive the IPI to
release this lock. The caller hart doesn't send the IPI to hartid 4 is
because of hartid 4 is skipped in for_each_cpu(). It will be skipped is
because "(cpu) < nr_cpu_ids" is not true. The hartid is 4 and nr_cpu_ids
is 4. Therefore it should use cpumask in for_each_cpu() instead of
hartid_mask.

        /* Send a message to all CPUs in the map */
        arch_send_call_function_ipi_mask(cfd->cpumask_ipi);

        if (wait) {
                for_each_cpu(cpu, cfd->cpumask) {
                        call_single_data_t *csd;
			csd = per_cpu_ptr(cfd->csd, cpu);
                        csd_lock_wait(csd);
                }
        }

        for ((cpu) = -1;                                \
                (cpu) = cpumask_next((cpu), (mask)),    \
                (cpu) < nr_cpu_ids;)

It could boot to login console after this patch applied.

Fixes: b2d36b5668f6 ("riscv: provide native clint access for M-mode")
Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
---
 arch/riscv/include/asm/clint.h | 8 ++++----
 arch/riscv/kernel/smp.c        | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/include/asm/clint.h b/arch/riscv/include/asm/clint.h
index 6eaa2eedd694..a279b17a6aad 100644
--- a/arch/riscv/include/asm/clint.h
+++ b/arch/riscv/include/asm/clint.h
@@ -15,12 +15,12 @@ static inline void clint_send_ipi_single(unsigned long hartid)
 	writel(1, clint_ipi_base + hartid);
 }
 
-static inline void clint_send_ipi_mask(const struct cpumask *hartid_mask)
+static inline void clint_send_ipi_mask(const struct cpumask *mask)
 {
-	int hartid;
+	int cpu;
 
-	for_each_cpu(hartid, hartid_mask)
-		clint_send_ipi_single(hartid);
+	for_each_cpu(cpu, mask)
+		clint_send_ipi_single(cpuid_to_hartid_map(cpu));
 }
 
 static inline void clint_clear_ipi(unsigned long hartid)
diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
index eb878abcaaf8..e0a6293093f1 100644
--- a/arch/riscv/kernel/smp.c
+++ b/arch/riscv/kernel/smp.c
@@ -96,7 +96,7 @@ static void send_ipi_mask(const struct cpumask *mask, enum ipi_message_type op)
 	if (IS_ENABLED(CONFIG_RISCV_SBI))
 		sbi_send_ipi(cpumask_bits(&hartid_mask));
 	else
-		clint_send_ipi_mask(&hartid_mask);
+		clint_send_ipi_mask(mask);
 }
 
 static void send_ipi_single(int cpu, enum ipi_message_type op)
-- 
2.25.1

