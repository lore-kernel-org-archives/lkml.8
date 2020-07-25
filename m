Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3480FC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 09:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F65A206D7
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 09:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595668831;
	bh=H/PBqXpMfj45oCHiCCtuloY39AfWiogOLeB+xj5NnHU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Spq2tlsKv6mnw3bIjZfCi3N2GPGD6A26dbQeoDLJkx1NgJj/RCJOLtIL6y+9UG+ep
	 ixPsqdY0RHtuZ0RDNwPxLUtfxxDdEJ29IFvsagalSDXaG8RjUP0NQ6lByeDMsBbQ5t
	 PtSENk7n7PHdMv9rx+UwiImVKQ+aPeB6uN3tND7k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgGYJUa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 05:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbgGYJU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 05:20:28 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3263C0619D3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 02:20:27 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id lx13so12302684ejb.4
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 02:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mBE0yHQ6AP1t3aJy13cs7YkkrY9GBi/wLxiLfrKO1Fw=;
        b=gIhub0k0ejqGKt27LSqEYiEoMhajFC3Qja8dZdRUVmNS0lnigkcg5qOCHRFqKnDyw6
         cE6QJXk5/vjylby5gaFWUzMzQhqnBc9c+fitIGNe9k++OFkDNQcRz/vEfp9QwJ7bh2Er
         LpBdbunqkWd2GemeINkJMx4PFJJHpOhQAZ4Szb2J2VXz2lU86z74/hddePiodBivhkD8
         XaTSuXV/CrfvNw7YZ/nLxUvTDAl1phmCRZYo0StipG9it2R7/XN38/TFtAl2FMTX+W3l
         JvX3y6bYTT1KxVzLJC6DI+DRXqSz1Rad4o19a2JGvMZvsHYApyS1X/jvnLmOO6uUbfzL
         Lr5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=mBE0yHQ6AP1t3aJy13cs7YkkrY9GBi/wLxiLfrKO1Fw=;
        b=Xqx9BVq+bOyt++x+3Sg/jn3QWUBfMPiI5Y9gXisocsMVxJz9QO6ds3DE08+hhjq5+Y
         Z0bjrbFEHYqxpwkcrgZBPdplnN7J5RO4u0Rj2HyrD6HyBy5TaUA0IUol/m57dqHOAWt4
         toqBdDpAdf4iVccWK/xuy+KsEHa/Ogd/i4Ed9NGPa3lw2rTK5AWafimbYpDXuk6yXJ4Y
         bKNEh7667TdSHzzfqZtYtXZCcOY4kZjciW462orG8h3epV9keXDEIBN3ehvsVkanZL1p
         /3DSAapynifB9HpSKYaZgN2FcotgOvo1W2qLVzkdmTJ690N3rqaFGgrCw/DwIbe60L+M
         zQoA==
X-Gm-Message-State: AOAM532AqbfU5Vh29mPB9gAb7ScrkhGN7+XJHMXA9ynBbOHg+2jSDwPV
        USXGI+30QhU1Eyy2pYzsDvgwXE7P
X-Google-Smtp-Source: ABdhPJzdtbpdi9wEMmlMMuKYKQYawJtKfFP/3kiE2/nr+/NR7bGrLIhvCS5mRvHpWg2fJOfpRryR8w==
X-Received: by 2002:a17:906:a204:: with SMTP id r4mr5645662ejy.552.1595668826316;
        Sat, 25 Jul 2020 02:20:26 -0700 (PDT)
Received: from localhost.localdomain (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id e1sm2549140edn.16.2020.07.25.02.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2020 02:20:25 -0700 (PDT)
From:   Ingo Molnar <mingo@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>
Subject: [PATCH 1/2] entry: Fix CONFIG_SECCOMP assumption
Date:   Sat, 25 Jul 2020 11:19:50 +0200
Message-Id: <20200725091951.744848-2-mingo@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200725091951.744848-1-mingo@kernel.org>
References: <20200725091951.744848-1-mingo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The __secure_computing() callback only exists on CONFIG_SECCOMP=y,
and on architectures that have CONFIG_HAVE_ARCH_SECCOMP_FILTER.

Instead of complicating the #ifdef within the generic entry code,
make the generic entry code depend on the availability of a modern
seccomp framework. This was implicit in the generic code due to
x86 being a modern seccomp-filter architecture.

Also move the Kconfig entry to after its HAVE_ARCH_SECCOMP_FILTER
dependency and fix minor whitespace damage while at it.

Fixes: 142781e108b1: ("entry: Provide generic syscall entry functionality")
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/Kconfig          | 6 ++++--
 kernel/entry/common.c | 2 ++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 852a527f418f..c2b29cfc4796 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -27,8 +27,6 @@ config HAVE_IMA_KEXEC
 config HOTPLUG_SMT
 	bool
 
-config GENERIC_ENTRY
-       bool
 
 config OPROFILE
 	tristate "OProfile system profiling"
@@ -654,6 +652,10 @@ config HAVE_IRQ_EXIT_ON_IRQ_STACK
 	  This spares a stack switch and improves cache usage on softirq
 	  processing.
 
+config GENERIC_ENTRY
+	bool
+	depends on HAVE_ARCH_SECCOMP_FILTER
+
 config PGTABLE_LEVELS
 	int
 	default 2
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 495f5c051b03..49ed8b47773a 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -53,12 +53,14 @@ static long syscall_trace_enter(struct pt_regs *regs, long syscall,
 			return -1L;
 	}
 
+#ifdef CONFIG_SECCOMP
 	/* Do seccomp after ptrace, to catch any tracer changes. */
 	if (ti_work & _TIF_SECCOMP) {
 		ret = __secure_computing(NULL);
 		if (ret == -1L)
 			return ret;
 	}
+#endif
 
 	if (unlikely(ti_work & _TIF_SYSCALL_TRACEPOINT))
 		trace_sys_enter(regs, syscall);
-- 
2.25.1

