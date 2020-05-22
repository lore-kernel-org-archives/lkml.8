Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA4C0C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 14:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F44D2067B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 14:55:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RH3hJubU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731364AbgEVOzW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 10:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730797AbgEVOzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 10:55:17 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B79C061A0E
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 07:55:17 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id y17so2052830wrn.11
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 07:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z2JTvHuqFiAH+e0uHvAv7QUdItZgp1++hBsH29TGAGE=;
        b=RH3hJubUWGtSNW24GhTx6ufaJ6TRraOrbbB6edaZ1SxjVy3F3fER9ye7M9DV2/koq2
         WolLZoTDKPlKaRDouJvsUsCVShp5GvsPjxVf/vBlD/kFDBl2QP/5obzIUP+C/DliXKFe
         vWBbx3oaBCHHqGyG00lPrlsfgZua0ucfU7gneN0OBBm88TXXdm3WRzT32ng9qk+9ZzFh
         UvzEk05phTl5Vurl2f8gX/swSGoyVuEc8AtTZnZIAfWIo53XvjMUP16u91mtv7nQ5Dsd
         C/dtaKrFdXg8UuWpnXiR/uEA3LADGd0mTIdfzp1TkIHIRHLFSVWLPTxxG9wU5PP1z82f
         I9EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z2JTvHuqFiAH+e0uHvAv7QUdItZgp1++hBsH29TGAGE=;
        b=fWLXLCyYEOox8KisfBOwWGyPKCOpA5r43dFuEVPjRSLMxqOLE1lBOZUFm9Uxq9I7PO
         AboCivmhZwsoICOGzdJnKqygfJhAbh3EtLpVilc6BYj2GAHuUEc0NEeZ/JaUgnocoWlV
         zcy9YXIaiPzSJjyTtWF665nlHxJkfwezzh6YmyPS1DMrtkTiQGW+vLf82oCJTVT3z4xf
         ymRvMqPTEmM91QM2+rbTir1Cqq8be/LwoiRzXAAdC3g/U2zTAXa5WotAxSkuqfuUeQiT
         zO9W0xoit/WNoF2yvS+e7dyZKba1YJAZytpdyZVs+geWhwcM7gdY9TMkvMDQoj9SSozH
         DIqQ==
X-Gm-Message-State: AOAM531H/I3M6XYc01ieub1ff3ZjmHlFmQTKWfBZkUauhaKO4nKxoaoX
        k/COzbfZFSZ1jSHhlJPxTjVTOg==
X-Google-Smtp-Source: ABdhPJzVBNmBWWvQ9nOtr1g+uNGIt9/otWbCh5kkWpEi6Kn9nuax/sD2PRXbA3VTqgPQqIPvlzBrKA==
X-Received: by 2002:adf:eb08:: with SMTP id s8mr3721175wrn.361.1590159315732;
        Fri, 22 May 2020 07:55:15 -0700 (PDT)
Received: from wychelm.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id i21sm9746911wml.5.2020.05.22.07.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 07:55:15 -0700 (PDT)
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     sumit.garg@linaro.org, jason.wessel@windriver.com,
        dianders@chromium.org
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        patches@linaro.org, pmladek@suse.com, sergey.senozhatsky@gmail.com,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Subject: [RFC PATCH 1/2] debug: Convert dbg_slave_lock to an atomic
Date:   Fri, 22 May 2020 15:55:09 +0100
Message-Id: <20200522145510.2109799-2-daniel.thompson@linaro.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200522145510.2109799-1-daniel.thompson@linaro.org>
References: <20200522145510.2109799-1-daniel.thompson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the debug core takes and releases dbg_slave_lock, knowing it to
be uncontended, as a means to set and clear a flag that it uses to herd
the other cores in to or out of a holding pen.

Let's convert this to a regular atomic instead. This change is worthwhile
simply for the subtle increase in clarity in a very tangled bit of code.
It is also useful because it removes a raw_spin_lock() from within the
debug trap, which will make it easier to introduce spin lock debugging
code for the debug trap handler.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 kernel/debug/debug_core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
index 2b7c9b67931d..8f43171ddeac 100644
--- a/kernel/debug/debug_core.c
+++ b/kernel/debug/debug_core.c
@@ -121,12 +121,12 @@ static struct kgdb_bkpt		kgdb_break[KGDB_MAX_BREAKPOINTS] = {
 atomic_t			kgdb_active = ATOMIC_INIT(-1);
 EXPORT_SYMBOL_GPL(kgdb_active);
 static DEFINE_RAW_SPINLOCK(dbg_master_lock);
-static DEFINE_RAW_SPINLOCK(dbg_slave_lock);
 
 /*
  * We use NR_CPUs not PERCPU, in case kgdb is used to debug early
  * bootup code (which might not have percpu set up yet):
  */
+static atomic_t			slaves_must_spin;
 static atomic_t			masters_in_kgdb;
 static atomic_t			slaves_in_kgdb;
 static atomic_t			kgdb_break_tasklet_var;
@@ -615,7 +615,7 @@ static int kgdb_cpu_enter(struct kgdb_state *ks, struct pt_regs *regs,
 			dump_stack();
 			kgdb_info[cpu].exception_state &= ~DCPU_WANT_BT;
 		} else if (kgdb_info[cpu].exception_state & DCPU_IS_SLAVE) {
-			if (!raw_spin_is_locked(&dbg_slave_lock))
+			if (!atomic_read(&slaves_must_spin))
 				goto return_normal;
 		} else {
 return_normal:
@@ -677,7 +677,7 @@ static int kgdb_cpu_enter(struct kgdb_state *ks, struct pt_regs *regs,
 	 * CPU in a spin state while the debugger is active
 	 */
 	if (!kgdb_single_step)
-		raw_spin_lock(&dbg_slave_lock);
+		atomic_set(&slaves_must_spin, 1);
 
 #ifdef CONFIG_SMP
 	/* If send_ready set, slaves are already waiting */
@@ -741,7 +741,7 @@ static int kgdb_cpu_enter(struct kgdb_state *ks, struct pt_regs *regs,
 		dbg_io_ops->post_exception();
 
 	if (!kgdb_single_step) {
-		raw_spin_unlock(&dbg_slave_lock);
+		atomic_set(&slaves_must_spin, 0);
 		/* Wait till all the CPUs have quit from the debugger. */
 		while (kgdb_do_roundup && atomic_read(&slaves_in_kgdb))
 			cpu_relax();
-- 
2.25.4

