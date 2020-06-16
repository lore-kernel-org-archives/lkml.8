Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C37EC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 14:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F99C20786
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 14:23:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oVRLq48u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728931AbgFPOXi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 10:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbgFPOXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 10:23:33 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4159C061573
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 07:23:32 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id t9so1545129ioj.13
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 07:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BBGVqxqh3i+zDg1UYEi18GrICwpH/7qq/yRRJB/ldwA=;
        b=oVRLq48ubMx2g6U1E1F3L2qpu59eu7CFvzflNS+ii1eG6U9+LIZgrfyEwwd+Gu1q7H
         tp0ejZcUZ1BgeukhdPNO0FnBnzOVQRwvYQGA6qmu7WDEnh4CKhuNkaY6rCQo+t99xqiN
         uhleXuL2Q0BhoqwPwADvyGfoMjgc9VQQ+Z0glL7dylKzLgzihEOhf/ZWIomY0Fa9cNcy
         nxeFo5myouGNW7M6Yreti5y4gsBuQhWvsus2uEW+5vvmkNDx59D3CDmSEldl6DUaB3YL
         doDCcpA14SJxRM+9zNWBbzo1Pc1pnRGi9g57XYhD/Enb3rPOQYKceifwGhxmqitScxlO
         skYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BBGVqxqh3i+zDg1UYEi18GrICwpH/7qq/yRRJB/ldwA=;
        b=tk2MCESXVjSIYZBooMqgimWdMapfw4At+cE8dkS1KcQJ40lwqleJ+cOe+6BmNgQcZG
         M+z8P1BCxEEO0laJ1/AzyB5emlKlmhsgBfkOxtR5qbtsi+c5Blp3k57/BI5gGf5V2HiB
         oAX99muBizbQmeS8T7IA24hHEQFj+GzxT6pH/5xYiIj1FJnnsjsLoPiE9Wjv4A6/+cm/
         BHpzG9Jphv7aPsT7tmRjRETbmFvZm/unfNP5LfBesKFMTJsQzSiTiTx9y1jiBhz5F287
         P+kCAFu9JiqQ+pcyVBlV7tCTnnvcMclofcpZ29g0iG2+Dd82VKGpNBAdUWTR3MlEfqeM
         pmsw==
X-Gm-Message-State: AOAM533fViZJyjgukcEP3h8x/bxGwZPobY3nSEDy4ufcm7B/RGDM5GBI
        RREzxnwXQky5XD0sK4jqkCC6gru3fw==
X-Google-Smtp-Source: ABdhPJxgAKlha6UCW7CjPxsi1+smk/dtZvHJ1rg2jZ6VI//FtweS8feWf9TedJ8m27ryuUmXw4zsAQ==
X-Received: by 2002:a5e:940b:: with SMTP id q11mr3371201ioj.76.1592317410583;
        Tue, 16 Jun 2020 07:23:30 -0700 (PDT)
Received: from localhost.localdomain (174-084-153-250.res.spectrum.com. [174.84.153.250])
        by smtp.gmail.com with ESMTPSA id w78sm10049881ilk.14.2020.06.16.07.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 07:23:30 -0700 (PDT)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH 2/2] x86/x32: Convert x32_rt_sigreturn to native syscall
Date:   Tue, 16 Jun 2020 10:23:15 -0400
Message-Id: <20200616142315.375918-3-brgerst@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200616142315.375918-1-brgerst@gmail.com>
References: <20200616142315.375918-1-brgerst@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

x32_rt_sigreturn doesn't need to be a compat syscall because there aren't two
versions.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/entry/syscalls/syscall_64.tbl            | 2 +-
 arch/x86/kernel/signal.c                          | 2 +-
 tools/perf/arch/x86/entry/syscalls/syscall_64.tbl | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 78847b32e137..5fb63ac69971 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -368,7 +368,7 @@
 # is defined.
 #
 512	x32	rt_sigaction		compat_sys_rt_sigaction
-513	x32	rt_sigreturn		compat_sys_x32_rt_sigreturn
+513	x32	rt_sigreturn		sys_x32_rt_sigreturn
 514	x32	ioctl			compat_sys_ioctl
 515	x32	readv			compat_sys_readv
 516	x32	writev			compat_sys_writev
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 399f97abee02..8a3d1cd4ea70 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -856,7 +856,7 @@ void signal_fault(struct pt_regs *regs, void __user *frame, char *where)
 }
 
 #ifdef CONFIG_X86_X32_ABI
-COMPAT_SYSCALL_DEFINE0(x32_rt_sigreturn)
+SYSCALL_DEFINE0(x32_rt_sigreturn)
 {
 	struct pt_regs *regs = current_pt_regs();
 	struct rt_sigframe_x32 __user *frame;
diff --git a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
index 37b844f839bc..36a3c8a913da 100644
--- a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
@@ -367,7 +367,7 @@
 # is defined.
 #
 512	x32	rt_sigaction		compat_sys_rt_sigaction
-513	x32	rt_sigreturn		compat_sys_x32_rt_sigreturn
+513	x32	rt_sigreturn		sys_x32_rt_sigreturn
 514	x32	ioctl			compat_sys_ioctl
 515	x32	readv			compat_sys_readv
 516	x32	writev			compat_sys_writev
-- 
2.26.2

