Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E17C47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 20:29:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E2C620661
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 20:29:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jWS2YE5/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729312AbgEEU3X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 16:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728135AbgEEU3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 16:29:23 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C616AC061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 13:29:21 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id b188so3789759qkd.9
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 13:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WwYjE2GWrCctkg5EjStPqPCb7vhBmi7tE/P9TjGv2ws=;
        b=jWS2YE5/k4w9jAJiOHdnPf2vhCEK04lsSUmN/uqo6B6PuxZ9i97vhOmdGUOfVSzWdN
         xv1oBs8lYqPB9/d3YhjguC+h7JIUWFNQhS2YcT4MrENkWgfFBTQfVOePVjatG1Gtzapq
         XbAn3lQQLD1vOeUoyA9KHCPytRYPiL5K7H3tWI6RxBNn9Dc2xT+VwBFKIENzsXJWFbi4
         xkLRUbpHt1O7QCjRxJL+fEt3p8dUFiAahZ9vUjyCmN0woJeSoFmtCE1Y3MWN1qvMGAqX
         zJC50kYZv1JNr5uinJOuv1ZB7HjKRh8hR/94TDfXIiHougFONoTuhK/1fay8zMPd4oTp
         ISlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WwYjE2GWrCctkg5EjStPqPCb7vhBmi7tE/P9TjGv2ws=;
        b=B4fPNo8HsW9c0zJLQ9iGHikKPTxIfhipVTv1bexwZgny8yiyfNldstaO13oBCUNFsT
         3dHjszJiZHpVyaK65JWLCsydsg7Sz1iruAALVMbv+zXBmLd+g2dDzKqsWCVHTm2xkSbz
         MzCwyveSTbYm3ue3e/aNVpp+eKMtMN1lfjCJs2xky/SLsBR8tg0sJ9hW6DtZP19MY8MO
         BPyTRhk3NWnPcFvDmdg8xpD6miam/zrR8Mkrww69zK78Nhbm3NJhum/L1rdcf0vAyo0J
         WZ2QokVvBdE2NKxwH2fp5w6cCzEPC3drCHjMdVeHwnKDYV76LyGGqqIBChG1oWhfHJXh
         UPxw==
X-Gm-Message-State: AGi0PubFuviLPrV9ZexB6cu6Tqm8x3g6IuVPFcgmpZ8RGo035rf9MuYY
        bDmlKoqk2sxexqqI77W2eQk=
X-Google-Smtp-Source: APiQypLBsuL5EJrI4oViXGYALNZSAMkPrqKzEylAsSSsoTTEXj5JA53hZBhQj6y6TLXI2+4DtCIC3Q==
X-Received: by 2002:ae9:c301:: with SMTP id n1mr5351742qkg.300.1588710560838;
        Tue, 05 May 2020 13:29:20 -0700 (PDT)
Received: from betazed.lan1 (cpe-142-255-49-197.nyc.res.rr.com. [142.255.49.197])
        by smtp.gmail.com with ESMTPSA id p22sm2554582qtb.91.2020.05.05.13.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 13:29:20 -0700 (PDT)
From:   Tony Fischetti <tony.fischetti@gmail.com>
To:     tglx@linutronix.de, mingo@redhat.com
Cc:     bp@alien8.de, x86@kernel.org, hpa@zytor.com, bhe@redhat.com,
        dyoung@redhat.com, dave.hansen@linux.intel.com, linux@roeck-us.net,
        keescook@chromium.org, dan.j.williams@intel.com,
        linux-kernel@vger.kernel.org, tony.fischetti@gmail.com
Subject: [PATCH v2] x86/setup: Add boot messages about cmdline builtins
Date:   Tue,  5 May 2020 16:29:11 -0400
Message-Id: <20200505202911.10254-1-tony.fischetti@gmail.com>
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
adds boot messages specifying the intital cmdline, and the final cmdline
after possible manipulation via the kernel config.

Signed-off-by: Tony Fischetti <tony.fischetti@gmail.com>
---
 arch/x86/kernel/setup.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 4b3fa6cd3106..ee90dffcfd79 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -828,7 +828,7 @@ void __init setup_arch(char **cmdline_p)
 	 */
 	__flush_tlb_all();
 #else
-	printk(KERN_INFO "Command line: %s\n", boot_command_line);
+	pr_info("Initial command line: %s\n", boot_command_line);
 	boot_cpu_data.x86_phys_bits = MAX_PHYSMEM_BITS;
 #endif
 
@@ -916,6 +916,7 @@ void __init setup_arch(char **cmdline_p)
 #endif
 
 	strlcpy(command_line, boot_command_line, COMMAND_LINE_SIZE);
+	pr_info("Final command line: %s\n", command_line);
 	*cmdline_p = command_line;
 
 	/*
-- 
2.20.1

