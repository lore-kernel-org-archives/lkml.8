Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFFDAC55185
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 21:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA0D820736
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 21:16:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RrGLy4OK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgDUVQH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 17:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726151AbgDUVPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 17:15:20 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2342C0610D6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 14:15:19 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id a5so1152013pjh.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 14:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0FYzutaOWwkobDVvluYcuHm9VXwfDfu/lChsJmXCxj8=;
        b=RrGLy4OKZdZcG8ieGRjfJ4zZHn+LjWtKJ9z8GfIKxz2r/6HXOuTE6X4vBBofmQTFV1
         3J1MxMDzRXSUJte11GSbUy++0LWNKDT8dA3sg3TK1qcBNj1PjcyX+hM6avDkOQXZfxF9
         eC4B2EXg5l4CTwe2mz0DPy6bBEaOsUySU0TR4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0FYzutaOWwkobDVvluYcuHm9VXwfDfu/lChsJmXCxj8=;
        b=A6B3lzpidLua4Z054iYHWLYy9kQEFP95xQBdSAt2EpkapfqgZOzdqJQYfAkN/tuj/7
         niZ1ERx5w2k/MpiVv4kvq4o12NKg//pjCVK1o9wte3O7kvOAKWSe/FwaGfKch6PLrt4r
         8qOSbGy83eom+/J/fGfycFnYPQ9BF3sf7wkz6iVM8nI4BBwmYc+/n+SHt+252Fx3sVlO
         sT/6nsJd33S0fDlU2EGHcnsZhssJ0FEScZGGjYTBboMaio1UJ17oRac45adRVYtLb+9S
         BJNu6VlL+OuNYWPsrz07El6MX0ZWODsRi5u8ikZ16wDvZfZp+FlzCDiLYosjCbTorJpX
         gwRg==
X-Gm-Message-State: AGi0PubqVg8ZP+VlnNQmLX9SrJJg2dHKNunhKYD7T9MyRKmoG5NRTjJI
        L66htswstX8kTfCL59uYqlXt6Q==
X-Google-Smtp-Source: APiQypIj7iK+ENNSKb4XQE4AkZpuuv1vhCL8EgK3cFai/GvUv4iH3IENUvbKD1Nzenb8tsIv34YzcQ==
X-Received: by 2002:a17:902:bcc4:: with SMTP id o4mr208635pls.233.1587503719408;
        Tue, 21 Apr 2020 14:15:19 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id c1sm3287880pfo.152.2020.04.21.14.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 14:15:18 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     jason.wessel@windriver.com, daniel.thompson@linaro.org,
        gregkh@linuxfoundation.org
Cc:     kgdb-bugreport@lists.sourceforge.net, mingo@redhat.com,
        hpa@zytor.com, bp@alien8.de, linux-serial@vger.kernel.org,
        agross@kernel.org, tglx@linutronix.de, frowand.list@gmail.com,
        bjorn.andersson@linaro.org, jslaby@suse.com,
        catalin.marinas@arm.com, corbet@lwn.net, will@kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/9] kgdb: Disable WARN_CONSOLE_UNLOCKED for all kgdb
Date:   Tue, 21 Apr 2020 14:14:39 -0700
Message-Id: <20200421141234.v2.1.Ied2b058357152ebcc8bf68edd6f20a11d98d7d4e@changeid>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
In-Reply-To: <20200421211447.193860-1-dianders@chromium.org>
References: <20200421211447.193860-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 81eaadcae81b ("kgdboc: disable the console lock when in
kgdb") we avoided the WARN_CONSOLE_UNLOCKED() yell when we were in
kgdboc.  That still works fine, but it turns out that we get a similar
yell when using other I/O drivers.  One example is the "I/O driver"
for the kgdb test suite (kgdbts).  When I enabled that I again got the
same yells.

Even though "kgdbts" doesn't actually interact with the user over the
console, using it still causes kgdb to print to the consoles.  That
trips the same warning:
  con_is_visible+0x60/0x68
  con_scroll+0x110/0x1b8
  lf+0x4c/0xc8
  vt_console_print+0x1b8/0x348
  vkdb_printf+0x320/0x89c
  kdb_printf+0x68/0x90
  kdb_main_loop+0x190/0x860
  kdb_stub+0x2cc/0x3ec
  kgdb_cpu_enter+0x268/0x744
  kgdb_handle_exception+0x1a4/0x200
  kgdb_compiled_brk_fn+0x34/0x44
  brk_handler+0x7c/0xb8
  do_debug_exception+0x1b4/0x228

Let's increment/decrement the "ignore_console_lock_warning" variable
all the time when we enter the debugger.

This will allow us to later revert commit 81eaadcae81b ("kgdboc:
disable the console lock when in kgdb").

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- ("kgdb: Disable WARN_CONSOLE_UNLOCKED for all kgdb") new for v2.

 kernel/debug/debug_core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
index 2b7c9b67931d..950dc667c823 100644
--- a/kernel/debug/debug_core.c
+++ b/kernel/debug/debug_core.c
@@ -668,6 +668,8 @@ static int kgdb_cpu_enter(struct kgdb_state *ks, struct pt_regs *regs,
 	if (kgdb_skipexception(ks->ex_vector, ks->linux_regs))
 		goto kgdb_restore;
 
+	atomic_inc(&ignore_console_lock_warning);
+
 	/* Call the I/O driver's pre_exception routine */
 	if (dbg_io_ops->pre_exception)
 		dbg_io_ops->pre_exception();
@@ -740,6 +742,8 @@ static int kgdb_cpu_enter(struct kgdb_state *ks, struct pt_regs *regs,
 	if (dbg_io_ops->post_exception)
 		dbg_io_ops->post_exception();
 
+	atomic_dec(&ignore_console_lock_warning);
+
 	if (!kgdb_single_step) {
 		raw_spin_unlock(&dbg_slave_lock);
 		/* Wait till all the CPUs have quit from the debugger. */
-- 
2.26.1.301.g55bc3eb7cb9-goog

