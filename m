Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC44C433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 22:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9877A2250E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 22:58:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730330AbgG1W6X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 18:58:23 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33769 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729991AbgG1W5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 18:57:35 -0400
Received: by mail-qk1-f196.google.com with SMTP id l23so20499672qkk.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 15:57:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yOCraVChxa5ukNCcP2KC3ZnWUN5xoWQnnkAwH57jpBo=;
        b=XOJ83zO01ae8ZPcpJJOpqDOFRGuTsoyEsEl97wMP7PbHdRQGH/xi55U49spYCQ3R3S
         AbC8eYVCkI9SJkvxMutHyjj/qMFcOM7RMgtWR3emDsJsEeAf2eks1VefmD/eKffRxVGF
         UvK4Sr2gwX4qMMIY9UUjIfZlafJcV/dFy7CNZzkqmirGjcWKDqNlinWTYH7GS7kGQgJz
         eqcb/AhUiyI8zfs88ptWMXx+Iv+C2XgS25MbukRrbL3KiVHClkfQ124CM56i7XdipA3+
         F2OgultR4IWg6mO1QZ+h36DKL8aWk8lNUROdmPEIVvCF6MJZN0T2EuruitCVLC2M3yeH
         xscw==
X-Gm-Message-State: AOAM532uoMSWTv4Re4fyjN/TW1PEP2ukbuolEWC2ix88dl1MHf0N+nZC
        jR553YHx8p6B3K+LIXjKkz03B8l7
X-Google-Smtp-Source: ABdhPJzloICB6TqnM4qbtkDuhKGptNqzVFXVSRYbi+anqPiFwqZU/A6xL1tRNBdsl11t6J6jqzEQEQ==
X-Received: by 2002:a37:a6c6:: with SMTP id p189mr20083802qke.386.1595977054058;
        Tue, 28 Jul 2020 15:57:34 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id o187sm88118qkd.112.2020.07.28.15.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 15:57:33 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Kees Cook <keescook@chromium.org>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v3 13/21] x86/kaslr: Drop test for command-line parameters before parsing
Date:   Tue, 28 Jul 2020 18:57:14 -0400
Message-Id: <20200728225722.67457-14-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200727230801.3468620-1-nivedita@alum.mit.edu>
References: <20200727230801.3468620-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This check doesn't save anything. In the case when none of the
parameters are present, each strstr will scan args twice (once to find
the length and then for searching), six scans in total. Just going ahead
and parsing the arguments only requires three scans: strlen, memcpy, and
parsing. This will be the first malloc, so free will actually free up
the memory, so the check doesn't save heap space either.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/x86/boot/compressed/kaslr.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index 7fb699aae74e..7c69fc10a782 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -279,10 +279,6 @@ static void handle_mem_options(void)
 	if (!args)
 		return;
 
-	if (!strstr(args, "memmap=") && !strstr(args, "mem=") &&
-		!strstr(args, "hugepages"))
-		return;
-
 	len = strlen(args);
 	tmp_cmdline = malloc(len + 1);
 	if (!tmp_cmdline)
-- 
2.26.2

