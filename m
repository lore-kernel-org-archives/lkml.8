Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C443EC11D44
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 06:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B12D2465D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 06:23:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KZPJA/xX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbgBTGXa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 01:23:30 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42752 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727513AbgBTGXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 01:23:21 -0500
Received: by mail-pl1-f193.google.com with SMTP id e8so1123786plt.9
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 22:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pK6zifq3Fj1hZPmmtdvS+UBS/FWrDP/7PRY/z1oHHl8=;
        b=KZPJA/xXWgvj7+EDceNGW99DsMGfVsrwZtMNYFEQmEcfbi6t1Ltywm8yF3gRS+KFsW
         YYa/KruX+agIH6tt/eZGI71UjpwjuT3jsuFYNKw+P7dbnGut/vUuytmTV4wCLvbb1OWN
         mFx5qdjyKzEPpPz0IfGRUIg5ongLMg7FFfcz0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pK6zifq3Fj1hZPmmtdvS+UBS/FWrDP/7PRY/z1oHHl8=;
        b=fIAfK9Wun7gi8hl8GRY50FDfj9mKupG+5dn3ICs1aefnYhVheepKpOKhNkcyCOof5i
         dDesHQVE0RVCMPV3f2FNGVzspcWPA6KU5xBvQatUCEEFN2WyBN5DEykVsYkHoLDgvRNl
         bKz1w+aC1/2zs/VMjq7Z+rOMKX5tWPyiHOzbhJplH6Go0PNZppCzfiaGKfjzQQzgH/b5
         XkzjL6A7CalPgj1kaQG2FfFymOOqQc2PN8DlAJyTJ0jqBkESQCHCky2rKDG0cGIEACKf
         1x8Cpw38hVd3iPKgNZkICD+ZVKuVOl5Uo8DKFON+Qq0VFema2W+NlbdBru2Sz3ic1xPk
         O0hA==
X-Gm-Message-State: APjAAAXJLFNBtkyYhfKjMDG9/aekvTeZa1L41FT2xEvgbq+92SSq3vVD
        HuXRS2dGLu1giTLed4t0Rx6jhQ==
X-Google-Smtp-Source: APXvYqx1kik6D0tY4SYKS7j1S0Bqg7hWpfmaq2nth5vTea0tU8wMl9ddGmg2GgyqqThc+95RG3/LrA==
X-Received: by 2002:a17:90a:f316:: with SMTP id ca22mr1759190pjb.59.1582179800527;
        Wed, 19 Feb 2020 22:23:20 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 3sm1760480pfi.13.2020.02.19.22.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 22:23:19 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Kees Cook <keescook@chromium.org>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Subject: [PATCH] x86/xen: Distribute switch variables for initialization
Date:   Wed, 19 Feb 2020 22:23:18 -0800
Message-Id: <20200220062318.69299-1-keescook@chromium.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Variables declared in a switch statement before any case statements
cannot be automatically initialized with compiler instrumentation (as
they are not part of any execution flow). With GCC's proposed automatic
stack variable initialization feature, this triggers a warning (and they
don't get initialized). Clang's automatic stack variable initialization
(via CONFIG_INIT_STACK_ALL=y) doesn't throw a warning, but it also
doesn't initialize such variables[1]. Note that these warnings (or silent
skipping) happen before the dead-store elimination optimization phase,
so even when the automatic initializations are later elided in favor of
direct initializations, the warnings remain.

To avoid these problems, move such variables into the "case" where
they're used or lift them up into the main function body.

arch/x86/xen/enlighten_pv.c: In function ‘xen_write_msr_safe’:
arch/x86/xen/enlighten_pv.c:904:12: warning: statement will never be executed [-Wswitch-unreachable]
  904 |   unsigned which;
      |            ^~~~~

[1] https://bugs.llvm.org/show_bug.cgi?id=44916

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/xen/enlighten_pv.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index 1f756ffffe8b..789dc12b7962 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -896,14 +896,15 @@ static u64 xen_read_msr_safe(unsigned int msr, int *err)
 static int xen_write_msr_safe(unsigned int msr, unsigned low, unsigned high)
 {
 	int ret;
+#ifdef CONFIG_X86_64
+	unsigned which;
+	u64 base;
+#endif
 
 	ret = 0;
 
 	switch (msr) {
 #ifdef CONFIG_X86_64
-		unsigned which;
-		u64 base;
-
 	case MSR_FS_BASE:		which = SEGBASE_FS; goto set;
 	case MSR_KERNEL_GS_BASE:	which = SEGBASE_GS_USER; goto set;
 	case MSR_GS_BASE:		which = SEGBASE_GS_KERNEL; goto set;

