Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61EDEC55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 04:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BE5F20747
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 04:20:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kMjikzVS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbgDVEUX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 00:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726396AbgDVEUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 00:20:21 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E70D3C03C1A6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 21:20:19 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id w29so710004qtv.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 21:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XnH6BrDmhXlAdeKuTpUlpSv/CS2wslOnKyHrHk5a0zA=;
        b=kMjikzVSD/yu0brMROKAPgW3dENVWmOGnpIYuvLigU84LJWzO4j/oDZ/jGYMJqWJ51
         zcSnZVjEqTbB6aTTaDKNBTHvRHUVXU4uoH/p4l1eVyE430bCPumpTofug9jpscFBRKrK
         z6nGgp50U+Re7szhKGcAh5WJO0Hk9Ei80vdn8duXOpVQnGmbwhOlp8a5ruGT/OgFd/LJ
         CfH/cwH7KpDdNxOWnk5TM+8RHZO7ySL0YFobNPhcYfwXSshfn7SJKgnCzSDAlg3tJv7K
         soPRF9d7Em8nX8XGSEW2lPhB8zaLqwFQE+wQ4917aks5czcZ6TwxTmBNDW6XC5XVGxEm
         CAPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XnH6BrDmhXlAdeKuTpUlpSv/CS2wslOnKyHrHk5a0zA=;
        b=GXiUuuvuxV/CvEXtezIkBsDijrmvl1OWxg1RJiVvjngkm8/HIuhAx+neGhBtrCjI2A
         qhsDcE3QwCcU8ZEgLJn2pVYS5GwiEUgpyTiwFc2zl6nKxAGW7MIl7QVNTglsx8aaRcdf
         mR9vxCAFHFG8kTolOegQYnyTLwEaxCeI+KzxuKxJrTwgbEKiOS81bIWt0F5GmUaHQRCf
         aLzeIL6Ndrt/I1SRW/XGindYFXmnqbyGmmcxgwaF3NuqKTxNp17iAFIAufdj2xa/ZPhf
         Y5tFmucCbDjW93Ix6upDePxh6s5OkC/avvWv8kmh16vLDopOj2ggMsfasad4gK9+YZfW
         xrhg==
X-Gm-Message-State: AGi0Pub0HuXakuNtxvcaKOVFbCq/et3a8W4kaN9m1NK2BtLadqwU6gfD
        /PHlgMLOwjZ/QMuTYRjmTY4=
X-Google-Smtp-Source: APiQypLFSU3o+KKNT7tttI4BhEISgyVOptX3wnzTf6hSF9Tj+5FcwR7cnng5H1tNlrsiBnlAd1xJ6Q==
X-Received: by 2002:ac8:7183:: with SMTP id w3mr24003037qto.307.1587529218999;
        Tue, 21 Apr 2020 21:20:18 -0700 (PDT)
Received: from betazed.lan1 (cpe-142-255-49-197.nyc.res.rr.com. [142.255.49.197])
        by smtp.gmail.com with ESMTPSA id s14sm3328036qts.70.2020.04.21.21.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 21:20:18 -0700 (PDT)
From:   Tony Fischetti <tony.fischetti@gmail.com>
To:     tglx@linutronix.de, mingo@redhat.com
Cc:     bp@alien8.de, x86@kernel.org, hpa@zytor.com, bhe@redhat.com,
        dyoung@redhat.com, dave.hansen@linux.intel.com, linux@roeck-us.net,
        keescook@chromium.org, dan.j.williams@intel.com,
        linux-kernel@vger.kernel.org, tony.fischetti@gmail.com
Subject: [PATCH] x86/setup: Add boot messages about cmdline builtins
Date:   Wed, 22 Apr 2020 00:20:07 -0400
Message-Id: <20200422042007.4836-1-tony.fischetti@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While the ability to override or append to the boot command line has
been added, the boot messages contain no information as to whether the
cmdline was manipulated by the build-time options. This patch, for x86,
adds boot messages specifying whether the cmdline was manipulated and
waits for the potential changes to take place before printing the final
boot command line.

Signed-off-by: Tony Fischetti <tony.fischetti@gmail.com>
---
 arch/x86/kernel/setup.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 4b3fa6cd3106..28d77f01fd0d 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -828,7 +828,6 @@ void __init setup_arch(char **cmdline_p)
 	 */
 	__flush_tlb_all();
 #else
-	printk(KERN_INFO "Command line: %s\n", boot_command_line);
 	boot_cpu_data.x86_phys_bits = MAX_PHYSMEM_BITS;
 #endif
 
@@ -904,10 +903,12 @@ void __init setup_arch(char **cmdline_p)
 
 #ifdef CONFIG_CMDLINE_BOOL
 #ifdef CONFIG_CMDLINE_OVERRIDE
+	pr_info("Overriding command line with builtin\n");
 	strlcpy(boot_command_line, builtin_cmdline, COMMAND_LINE_SIZE);
 #else
 	if (builtin_cmdline[0]) {
 		/* append boot loader cmdline to builtin */
+		pr_info("Appending command line to builtin\n");
 		strlcat(builtin_cmdline, " ", COMMAND_LINE_SIZE);
 		strlcat(builtin_cmdline, boot_command_line, COMMAND_LINE_SIZE);
 		strlcpy(boot_command_line, builtin_cmdline, COMMAND_LINE_SIZE);
@@ -916,6 +917,7 @@ void __init setup_arch(char **cmdline_p)
 #endif
 
 	strlcpy(command_line, boot_command_line, COMMAND_LINE_SIZE);
+	pr_info("Command line: %s\n", command_line);
 	*cmdline_p = command_line;
 
 	/*
-- 
2.20.1

