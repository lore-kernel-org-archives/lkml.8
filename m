Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 293E5C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 21:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECE3E215A4
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 21:39:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbgIGVjx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 17:39:53 -0400
Received: from mail-qv1-f67.google.com ([209.85.219.67]:36823 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727980AbgIGVjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 17:39:23 -0400
Received: by mail-qv1-f67.google.com with SMTP id f11so6889302qvw.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 14:39:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XcYODoRB7GwFN/wo/UINuMw6V985LjmxUwFyI7ezfaU=;
        b=To10/V8JZTxLSSiv6UD3BJdltbe7nyV2g3bEjeydff1pKYGZkLyNxSRdQ0YPQWrWR/
         cXQPQ7Y4pqM2xKsDt7j/HqSmev+MJFaNcphuphew2SqsUZ9fSnt8ieFEYikr+P29oIZQ
         3vAUak/3mLoKR8xpm9UCCSqDQBCP2qpxGMInsGz7PUqqfWd8la4GzWQuXCmoYKO9X0S1
         ICGGYLQF0DYVs8P3JOv251dDpV7sAMF7930bAexfsv/03jnhnINy45mWNwzfNa5Mz8Yf
         LXpQbFLj2KR9fZbN5HmPRObcd8e/UnnlppM1UPoxea1NAYyp9PMvOo3ZgsW3+K1dRJHL
         zGsw==
X-Gm-Message-State: AOAM531b31SSJTvmBCZjMARrZHVDFJ2O55wqBRScovUYFynzgFcEEX4H
        PYKBcgLPjbWSkmmuuJnzfPE=
X-Google-Smtp-Source: ABdhPJxIynsXWJsrajiCbAAWv1XYMnFrJysLQ7/0GWPCQB+acyKnYayy/BZu7TW+2L0sAq0WqCorvQ==
X-Received: by 2002:a05:6214:1928:: with SMTP id es8mr21122797qvb.197.1599514760676;
        Mon, 07 Sep 2020 14:39:20 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id 201sm12078228qkf.103.2020.09.07.14.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2020 14:39:20 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     x86@kernel.org
Cc:     Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] x86/fpu: Allow multiple bits in clearcpuid= parameter
Date:   Mon,  7 Sep 2020 17:39:19 -0400
Message-Id: <20200907213919.2423441-1-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit

  0c2a3913d6f5 ("x86/fpu: Parse clearcpuid= as early XSAVE argument")

changed clearcpuid parsing from __setup() to cmdline_find_option().
While the __setup() function would have been called for each clearcpuid=
parameter on the command line, cmdline_find_option() will only return
the last one, so the change effectively made it impossible to disable
more than one bit.

Allow a comma-separated list of bit numbers as the argument for
clearcpuid to allow multiple bits to be disabled again. Log the bits
being disabled for informational purposes.

Also fix the check on the return value of cmdline_find_option(). It
returns -1 when the option is not found, so testing as a boolean is
incorrect.

Fixes: 0c2a3913d6f5 ("x86/fpu: Parse clearcpuid= as early XSAVE argument")
Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 .../admin-guide/kernel-parameters.txt         |  2 +-
 arch/x86/kernel/fpu/init.c                    | 29 ++++++++++++++-----
 2 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index a1068742a6df..ffe864390c5a 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -577,7 +577,7 @@
 			loops can be debugged more effectively on production
 			systems.
 
-	clearcpuid=BITNUM [X86]
+	clearcpuid=BITNUM[,BITNUM...] [X86]
 			Disable CPUID feature X for the kernel. See
 			arch/x86/include/asm/cpufeatures.h for the valid bit
 			numbers. Note the Linux specific bits are not necessarily
diff --git a/arch/x86/kernel/fpu/init.c b/arch/x86/kernel/fpu/init.c
index 61ddc3a5e5c2..7b2d0f54b023 100644
--- a/arch/x86/kernel/fpu/init.c
+++ b/arch/x86/kernel/fpu/init.c
@@ -243,9 +243,9 @@ static void __init fpu__init_system_ctx_switch(void)
  */
 static void __init fpu__init_parse_early_param(void)
 {
-	char arg[32];
+	char arg[128];
 	char *argptr = arg;
-	int bit;
+	int arglen, res, bit;
 
 #ifdef CONFIG_X86_32
 	if (cmdline_find_option_bool(boot_command_line, "no387"))
@@ -268,12 +268,25 @@ static void __init fpu__init_parse_early_param(void)
 	if (cmdline_find_option_bool(boot_command_line, "noxsaves"))
 		setup_clear_cpu_cap(X86_FEATURE_XSAVES);
 
-	if (cmdline_find_option(boot_command_line, "clearcpuid", arg,
-				sizeof(arg)) &&
-	    get_option(&argptr, &bit) &&
-	    bit >= 0 &&
-	    bit < NCAPINTS * 32)
-		setup_clear_cpu_cap(bit);
+	arglen = cmdline_find_option(boot_command_line, "clearcpuid", arg, sizeof(arg));
+	if (arglen <= 0)
+		return;
+
+	pr_info("Clearing CPUID bits:");
+	do {
+		res = get_option(&argptr, &bit);
+		if (res == 0 || res == 3)
+			break;
+		/* If the argument was too long, the last bit may be cut off */
+		if (res == 1 && arglen >= sizeof(arg))
+			break;
+
+		if (bit >= 0 && bit < NCAPINTS * 32) {
+			pr_cont(" " X86_CAP_FMT, x86_cap_flag(bit));
+			setup_clear_cpu_cap(bit);
+		}
+	} while (res == 2);
+	pr_cont("\n");
 }
 
 /*
-- 
2.26.2

