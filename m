Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03535C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 23:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C885720757
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 23:28:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B0EmNRpP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbgDIX26 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 19:28:58 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:37976 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726726AbgDIX25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 19:28:57 -0400
Received: by mail-pj1-f66.google.com with SMTP id t40so129903pjb.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 16:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j6nOAWhXcgV50dfI2kOZff7IGheVzW2uE0Ud7W3fojM=;
        b=B0EmNRpPG3qUZ3ki1VFuqMMc+PMOwSxu3W+99zScDTZqHZppWGVrXFypjNErcBcb7d
         8su+rPppfd83ZmBiUPytOLnl4gEM7gf33O3I8Ox05Jc8EA3H3wCkqZ0HPDXom1Q4thVt
         pRDSrZyUBqUTZ9sj4BnDE9pQO98BL1sBxGVaKQtHSUFFOIBQ0lcWLJvYjaNZrfq0q5O6
         2BRBR3aKkqsYP9A0vqHGPHwx5TI2udc0xKgTFmNUMIvvB28/T85dkLmsEZGmM83SZPFC
         zrGpQpiU+eYkjZ2k0+JOJQBWmrAqUaPcdCQ1lt7JzgrhfsFK5O3nQgRI9MEFtwWrlMfl
         O/Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j6nOAWhXcgV50dfI2kOZff7IGheVzW2uE0Ud7W3fojM=;
        b=G8qx6V02RdEwZOcpxkG6CD7JNPRjQ6Y9dRCPQV0Co5dNzp1jiU3ozsAmbr/sH6dzTy
         boOPgLLWniBPEJRtsG3cW/1qOWf8yWGt9jlVoYiPgZgzeMmAfiQikjQ0lieyaKUyxgbi
         fd1N5RyocUcJuM2K4ziwuiTAbUVrW1XMr6gO6kTchfU03q+1SWdjpMiwVh2t7BBNdE/t
         viLDeLDyAv4vb0Nz5DpyolusnO3NZELTUq8SjClczz4worljvjChj4injxqOb/4tjA5M
         Kf+0Wi3Nn+XdW8CQS4tAenIJS+JoZcbZMzBnCfMgJGlretJjzNUmSg+DmXkiY4ORzXi8
         1HoQ==
X-Gm-Message-State: AGi0PuaY/yXStvQS/4GsrYYaQrUQNnumn1w5vQZKb8O5jeS/Brh22BFy
        DQRwmSsRMWQyhnIpKMr9TSE=
X-Google-Smtp-Source: APiQypJkOAJgzdjrZ5GN/MIDJIBjwRM9IlRGCSU88exDh+QlIZEQ6V2hqaTExMrzbHebhtP4DehuRw==
X-Received: by 2002:a17:90b:3585:: with SMTP id mm5mr2132232pjb.168.1586474936962;
        Thu, 09 Apr 2020 16:28:56 -0700 (PDT)
Received: from jiancai.svl.corp.google.com ([2620:15c:2ce:0:b7ed:16a3:9dc0:21bb])
        by smtp.googlemail.com with ESMTPSA id e14sm238783pjg.0.2020.04.09.16.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 16:28:56 -0700 (PDT)
From:   Jian Cai <caij2003@gmail.com>
Cc:     caij2003@gmail.com, ndesaulniers@google.com, manojgupta@google.com,
        Peter.Smith@arm.com, stefan@agner.ch, samitolvanen@google.com,
        ilie.halip@gmail.com, jiancai@google.com,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Doug Anderson <armlinux@m.disordat.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        David Howells <dhowells@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: [PATCH] ARM: do not assemble iwmmxt.S with LLVM toolchain
Date:   Thu,  9 Apr 2020 16:27:26 -0700
Message-Id: <20200409232728.231527-1-caij2003@gmail.com>
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

iwmmxt.S contains XScale instructions LLVM ARM backend does not support.
Skip this file if LLVM integrated assemmbler or LLD is used to build ARM
kernel.

Signed-off-by: Jian Cai <caij2003@gmail.com>
---
 arch/arm/Kconfig | 2 +-
 init/Kconfig     | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 66a04f6f4775..39de8fc64a73 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -804,7 +804,7 @@ source "arch/arm/mm/Kconfig"
 
 config IWMMXT
 	bool "Enable iWMMXt support"
-	depends on CPU_XSCALE || CPU_XSC3 || CPU_MOHAWK || CPU_PJ4 || CPU_PJ4B
+	depends on !AS_IS_CLANG && !LD_IS_LLD && (CPU_XSCALE || CPU_XSC3 || CPU_MOHAWK || CPU_PJ4 || CPU_PJ4B)
 	default y if PXA27x || PXA3xx || ARCH_MMP || CPU_PJ4 || CPU_PJ4B
 	help
 	  Enable support for iWMMXt context switching at run time if
diff --git a/init/Kconfig b/init/Kconfig
index 1c12059e0f7e..b0ab3271e900 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -19,6 +19,12 @@ config GCC_VERSION
 config CC_IS_CLANG
 	def_bool $(success,$(CC) --version | head -n 1 | grep -q clang)
 
+config AS_IS_CLANG
+	def_bool $(success,$(AS) --version | head -n 1 | grep -q clang)
+
+config LD_IS_LLD
+	def_bool $(success,$(LD) --version | head -n 1 | grep -q LLD)
+
 config CLANG_VERSION
 	int
 	default $(shell,$(srctree)/scripts/clang-version.sh $(CC))
-- 
2.26.0.110.g2183baf09c-goog

