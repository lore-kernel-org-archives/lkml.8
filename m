Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE6DC54FCC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 17:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BFB92070B
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 17:37:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b12RD4Q+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbgDURh2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 13:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbgDURh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 13:37:27 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2043C0610D5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 10:37:27 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id 18so3262713pfx.6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 10:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n8qVaalIidRR7pGSEV5tyf0PxDkGEOKDNCWi4IECU3E=;
        b=b12RD4Q+/eDpJ8K5uxx3pSY6Me2Hr6dzy4utDsv6A8bko7a9tF6XKrl99Wyd+r4v3o
         1FAauDl8St//AMNITUY9tZsFBfgz4ftqbQ5fB/3kktoonbKWQzk/vXiB1dcZbXwJvuLJ
         zbDi3tQ0Rc6Ux2LTauqIwmKTuwL3s74n3e448+IuMamMvRriWHwJe4zvddNeMa6JE8kc
         +xh4hvApNt+Ua8yeyeEQFSucdlfWVlGCQCBshWSoSJoywVwaM4kiy+MkepoFbfsD3GDU
         j4tyuKol3YM4UXG2E/dS1MwkuMKRwxjnLP/tDidFfAhnLOR/FQDb3VtUQ2OADDBJeJ5q
         LvFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n8qVaalIidRR7pGSEV5tyf0PxDkGEOKDNCWi4IECU3E=;
        b=QX8J5fpalmaXQOJ5VeKGZql65qb1Ehr/OIt1SdLHsXofBE9Stj9o1iuncVTM2x/e2z
         B+Sy/jE6c0zj1nwLlvP0Mubyc4X3Ycxr36leAxeOW7iFWKI2FFaUGGKKt8uXYvD6E02y
         SvsWazx1TTITl/3qvriZiTErrrG8fOb2bDTvCArNREeUqPVFA3UOsGvcSbwlijAPbLuS
         n4PE8QKC7O5McLKC9REf7VqR37Qwk4pJ+N6rvRzg1xMasfuf92BlGx6KV731+3GJxjYC
         S63rSDzycSy4RWO/dqoXPyhNmHw/LM/Gd9xIxSnYqSOyuu14jJOQbWuP6zxJiwoSj9pQ
         WjlA==
X-Gm-Message-State: AGi0PubQW24xsd2m2N07lQ3qpdl45TcmRm9uDpCXKI/MLpk9uakCI9e1
        HsZL8W/JfD789Ed3d58ixEk=
X-Google-Smtp-Source: APiQypJtnl2nLcMt15nfPhna9D5nM3tB9NS63SlG2E8fT8j/LMpRKnWzfOwcDbTwgitenufmufCvGQ==
X-Received: by 2002:aa7:8593:: with SMTP id w19mr22839905pfn.97.1587490646870;
        Tue, 21 Apr 2020 10:37:26 -0700 (PDT)
Received: from debian.net.fpt ([42.119.230.166])
        by smtp.gmail.com with ESMTPSA id h197sm55386pfe.208.2020.04.21.10.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 10:37:26 -0700 (PDT)
From:   Phong Tran <tranmanphong@gmail.com>
To:     mark.rutland@arm.com, steve.capper@arm.com, steven.price@arm.com,
        will@kernel.org, keescook@chromium.org, greg@kroah.com
Cc:     akpm@linux-foundation.org, alexios.zavras@intel.com,
        broonie@kernel.org, kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, Phong Tran <tranmanphong@gmail.com>
Subject: [PATCH v2] arm64: add check_wx_pages debugfs for CHECK_WX
Date:   Wed, 22 Apr 2020 00:35:58 +0700
Message-Id: <20200421173557.10817-1-tranmanphong@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200307093926.27145-1-tranmanphong@gmail.com>
References: <20200307093926.27145-1-tranmanphong@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

follow the suggestion from
https://github.com/KSPP/linux/issues/35

Signed-off-by: Phong Tran <tranmanphong@gmail.com>
---
Change since v1:
- Update the Kconfig help text
- Don't check the return value of debugfs_create_file()
- Tested on QEMU aarch64
root@qemuarm64:~# zcat /proc/config.gz | grep PTDUMP
CONFIG_GENERIC_PTDUMP=y
CONFIG_PTDUMP_CORE=y
CONFIG_PTDUMP_DEBUGFS=y
root@qemuarm64:~# uname -a
Linux qemuarm64 5.7.0-rc2-00001-g20ddb383c313 #3 SMP PREEMPT Tue Apr 21 23:18:56 +07 2020 aarch64 GNU/Linux
root@qemuarm64:~# echo 1 > /sys/kernel/debug/check_wx_pages
[   63.261868] Checked W+X mappings: passed, no W+X pages found
---
 arch/arm64/Kconfig.debug        |  5 ++++-
 arch/arm64/include/asm/ptdump.h |  2 ++
 arch/arm64/mm/dump.c            |  1 +
 arch/arm64/mm/ptdump_debugfs.c  | 18 ++++++++++++++++++
 4 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig.debug b/arch/arm64/Kconfig.debug
index a1efa246c9ed..cd82c9d3664a 100644
--- a/arch/arm64/Kconfig.debug
+++ b/arch/arm64/Kconfig.debug
@@ -48,7 +48,10 @@ config DEBUG_WX
 	  of other unfixed kernel bugs easier.
 
 	  There is no runtime or memory usage effect of this option
-	  once the kernel has booted up - it's a one time check.
+	  once the kernel has booted up - it's a one time check at
+	  boot, and can also be triggered at runtime by echo "1" to
+	  "check_wx_pages". The "check_wx_pages" is available only with
+	  CONFIG_PTDUMP_DEBUGFS is enabled.
 
 	  If in doubt, say "Y".
 
diff --git a/arch/arm64/include/asm/ptdump.h b/arch/arm64/include/asm/ptdump.h
index 38187f74e089..c90a6ec6f59b 100644
--- a/arch/arm64/include/asm/ptdump.h
+++ b/arch/arm64/include/asm/ptdump.h
@@ -24,9 +24,11 @@ struct ptdump_info {
 void ptdump_walk(struct seq_file *s, struct ptdump_info *info);
 #ifdef CONFIG_PTDUMP_DEBUGFS
 void ptdump_debugfs_register(struct ptdump_info *info, const char *name);
+void ptdump_check_wx_init(void);
 #else
 static inline void ptdump_debugfs_register(struct ptdump_info *info,
 					   const char *name) { }
+static inline void ptdump_check_wx_init(void) { }
 #endif
 void ptdump_check_wx(void);
 #endif /* CONFIG_PTDUMP_CORE */
diff --git a/arch/arm64/mm/dump.c b/arch/arm64/mm/dump.c
index 860c00ec8bd3..60c99a047763 100644
--- a/arch/arm64/mm/dump.c
+++ b/arch/arm64/mm/dump.c
@@ -378,6 +378,7 @@ static int ptdump_init(void)
 #endif
 	ptdump_initialize();
 	ptdump_debugfs_register(&kernel_ptdump_info, "kernel_page_tables");
+	ptdump_check_wx_init();
 	return 0;
 }
 device_initcall(ptdump_init);
diff --git a/arch/arm64/mm/ptdump_debugfs.c b/arch/arm64/mm/ptdump_debugfs.c
index d29d722ec3ec..6b0aa16cb17b 100644
--- a/arch/arm64/mm/ptdump_debugfs.c
+++ b/arch/arm64/mm/ptdump_debugfs.c
@@ -20,3 +20,21 @@ void ptdump_debugfs_register(struct ptdump_info *info, const char *name)
 {
 	debugfs_create_file(name, 0400, NULL, info, &ptdump_fops);
 }
+
+static int check_wx_debugfs_set(void *data, u64 val)
+{
+	if (val != 1ULL)
+		return -EINVAL;
+
+	ptdump_check_wx();
+
+	return 0;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(check_wx_fops, NULL, check_wx_debugfs_set, "%llu\n");
+
+void ptdump_check_wx_init(void)
+{
+	debugfs_create_file("check_wx_pages", 0200, NULL,
+			NULL, &check_wx_fops) ? 0 : -ENOMEM;
+}
-- 
2.20.1

