Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E692FC433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 04:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB8DA22482
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 04:18:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J9kQIHBi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbgGUEST (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 00:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbgGUESS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 00:18:18 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49EB7C061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 21:18:18 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id t6so9688273plo.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 21:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HdrgiDjwQi3OXxJsXUESa6n0z/319Mf+JqDHrOU66kg=;
        b=J9kQIHBiFR2cBCKxhL+j9PrgKpcG/r5Le8QseNCHRtjcterReYFiv7fvrhsU4CcS00
         C357fOgCmIvXpjMyqWX9aLfF2IYPjDTz8jRD7icKJCrsELYfzDqy43kknkJLNIDeIEVW
         WQCG4iOa5n/ZacA/O3S1XnrsihQqfsz9hzsfKmTpv8WWHlIZ3MqgeKtOUECEe2W2TyUN
         hR+l3HUDsNFWs/M9YBUrI1wOGIpfZNoN/q4qAat105HU7y8ZQtOPfbQh3BzkiZL+FMT7
         1GUBAZ0smgg07lgbKHTGCvrEqFBXkEDa//CkdpMhiPkD+VvyDEpu2lk+MxRfXdlCeAGl
         2qKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HdrgiDjwQi3OXxJsXUESa6n0z/319Mf+JqDHrOU66kg=;
        b=pylvDuFNLeYgFQBqcRf2eRTPMfwDlr/tHuaXAsI2GKUKufBzIwP7n+UPvj6jST5VMM
         wFztE3R2+/uxq8yI+GHnSb5o/KkiqtUlFCglE+UR1SVY269oSnyHxsG+2LbuzA/BJfqc
         yXCYB8+Pslff+FDXglcQLqHI+NoRuhpPdR0j6QH3yDBmxl/VnbiN71ksLi979lwTFIEC
         3pFYBxuyO3M8G2Hbx2ZlLWdPWeCsQcH1zVh1SBbK53GTMaAQSCObYuSKCvX9HLvS6fDj
         tMXt61R6RETT1gxy1HM1i5ZRkEmp3e6AXea6MuCcu61M3npGRfniafuPcc6UWg8aRfMY
         pQ5w==
X-Gm-Message-State: AOAM531L+VkhaxeCEfE/Rv66sCKgN1HSYssi0M4HTXJTW2mozYpetvpP
        T8n0Q/6UUupobR8eD+uGQ00=
X-Google-Smtp-Source: ABdhPJyue+HTI0GPUR9dn0lDQER+qd43Q72CqYIHp9HX2nZ8SZRkDJx0a1ktEgktFA2ACThVp6s6CA==
X-Received: by 2002:a17:902:ed02:: with SMTP id b2mr21034822pld.121.1595305097820;
        Mon, 20 Jul 2020 21:18:17 -0700 (PDT)
Received: from localhost.localdomain ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id e28sm18467270pfm.177.2020.07.20.21.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 21:18:17 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     suleiman@google.com, joelaf@google.com,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: [RFC][PATCH 4/4] arm64: do not use dummy vcpu_is_preempted() anymore
Date:   Tue, 21 Jul 2020 13:17:42 +0900
Message-Id: <20200721041742.197354-5-sergey.senozhatsky@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200721041742.197354-1-sergey.senozhatsky@gmail.com>
References: <20200721041742.197354-1-sergey.senozhatsky@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vcpu_is_preempted() now can represent the actual state of
the VCPU, so the scheduler can make better decisions when
it picks the idle CPU to enqueue a task on. I executed a
whole bunch of scheduler tests [0]. One particular test
that shows the importance of vcpu_is_preempted() is AIO
stress-ng test:

x Disabled vcpu_is_preempted()
stress-ng: info:  [100] stressor       bogo ops real time  usr time  sys time   bogo ops/s   bogo ops/s
stress-ng: info:  [100]                           (secs)    (secs)    (secs)   (real time) (usr+sys time)
stress-ng: info:  [100] aio              222927     10.01      0.89     27.61     22262.04      7822.00
stress-ng: info:  [139] aio              217043     10.01      1.00     26.80     21685.46      7807.30
stress-ng: info:  [178] aio              217261     10.01      1.08     26.79     21709.36      7795.51

+ Enabled vcpu_is_preempted()
stress-ng: info:  [100] aio              432750     10.00      1.14     19.03     43264.33     21455.13
stress-ng: info:  [139] aio              426771     10.01      1.09     18.67     42629.13     21597.72
stress-ng: info:  [179] aio              533039     10.00      1.42     20.39     53281.70     24440.12

Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
---
 arch/arm64/include/asm/spinlock.h | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/spinlock.h b/arch/arm64/include/asm/spinlock.h
index 9083d6992603..6a390eeabe82 100644
--- a/arch/arm64/include/asm/spinlock.h
+++ b/arch/arm64/include/asm/spinlock.h
@@ -11,17 +11,20 @@
 /* See include/linux/spinlock.h */
 #define smp_mb__after_spinlock()	smp_mb()
 
-/*
- * Changing this will break osq_lock() thanks to the call inside
- * smp_cond_load_relaxed().
- *
- * See:
- * https://lore.kernel.org/lkml/20200110100612.GC2827@hirez.programming.kicks-ass.net
- */
 #define vcpu_is_preempted vcpu_is_preempted
+
+#ifdef CONFIG_PARAVIRT
+extern bool paravirt_vcpu_is_preempted(int cpu);
+
+static inline bool vcpu_is_preempted(int cpu)
+{
+	return paravirt_vcpu_is_preempted(cpu);
+}
+#else
 static inline bool vcpu_is_preempted(int cpu)
 {
 	return false;
 }
+#endif /* CONFIG_PARAVIRT */
 
 #endif /* __ASM_SPINLOCK_H */
-- 
2.27.0

