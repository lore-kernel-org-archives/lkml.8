Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D80C33CB6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 16:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C72E82072B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 16:54:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U38fXrW2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729123AbgAQQyA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 11:54:00 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:34055 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729049AbgAQQx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 11:53:59 -0500
Received: by mail-io1-f66.google.com with SMTP id z193so26721268iof.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 08:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nyGJWsyTKkrgy7HZPA+UXNCoDltHdQbF47bF/H777tA=;
        b=U38fXrW2OxaXp4sqTsmCr4POevsntbUi7GOoCjDmm6E2Eq8+gMvI5hv6kKT2VIHhfL
         FrG5j3Xvg01cDie2KSjwgDxmYzEYXO/L/gqboMLJYQL2Za8zv5AxYxN0XpyIh6t8Oiz1
         4ysCZDtqNui0yNjenG2zObc4paijp5zwOGr3b8KU1ysGyp3+cd22OAjT3MyzvRkgH20V
         8Us7MJ61BeuTsVGHZLn43PfJAFN5w096D0daUoROwzyDF+LP4JZ4fSXOs8sGE2Y3ZX7v
         s6uNeAa3X210wej7yLVvttw1txsGSpnDmhtsUELDq8WJH3Z1jStthNAHduDsl1I0kpoE
         hMYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nyGJWsyTKkrgy7HZPA+UXNCoDltHdQbF47bF/H777tA=;
        b=t+XDIj+xoUybUSc+T+3Zj+N8fbvGV3sZVHgzUCfsxaPhEiijCg3RXjVZncJkXlKS4D
         7TnpQCcVxNxrmZZLfnAdBctUA7mG/GSccV0+5lacnQ2vhxeSwP+yPA/7lqgKT69/HqB1
         H9M3tPIWJaQz5jobck+o1fRBlOfPTkacxlyqFPEuuwvheukPnsE4cImFk3NNLpw1eOHX
         xloj9ZnTTJYC6QKnmVu5djOhZ0/BkGsH4VTyNAaahZr90A693j/8LdL1ozNXQeybc878
         jrEH7EzXB8nD6UI7mlhF++CYy7uXRGTN6dByy5sOaFTdN3K8NwTAnDNQTuvKU9VgC7lY
         n9ag==
X-Gm-Message-State: APjAAAXZBxrR1qNsw/P5/GXhMLROePiyTUGAle1p4DT+BIWDEBp9DReB
        cUXf/lAuFbCIKggq2j8MUSPVatF2Ufw=
X-Google-Smtp-Source: APXvYqzcThZp+w7bcJSuEY6nvNEKKKQwjY3iu6iKJqwym9wa4/Nlt5pRDhUAXs4Xuv2n3kLUB8BpZw==
X-Received: by 2002:a6b:fc02:: with SMTP id r2mr20538419ioh.183.1579280038463;
        Fri, 17 Jan 2020 08:53:58 -0800 (PST)
Received: from alago.cortijodelrio.net (CableLink-189-219-74-147.Hosts.InterCable.net. [189.219.74.147])
        by smtp.googlemail.com with ESMTPSA id f16sm8120662ilq.16.2020.01.17.08.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 08:53:57 -0800 (PST)
From:   =?UTF-8?q?Daniel=20D=C3=ADaz?= <daniel.diaz@linaro.org>
To:     shuah@kernel.org
Cc:     =?UTF-8?q?Daniel=20D=C3=ADaz?= <daniel.diaz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/3] selftests/x86: Build with LDFLAGS and LDLIBS
Date:   Fri, 17 Jan 2020 10:53:26 -0600
Message-Id: <20200117165330.17015-1-daniel.diaz@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During cross-compilation, it was discovered that LDFLAGS and
LDLIBS were not being used while building binaries, leading
to defaults which were not necessarily correct.

OpenEmbedded reported this kind of problem:
  ERROR: QA Issue: No GNU_HASH in the ELF binary [...], didn't pass LDFLAGS?

Signed-off-by: Daniel Díaz <daniel.diaz@linaro.org>
---
 tools/testing/selftests/x86/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
index 5d49bfec1e9a..f8360454eafd 100644
--- a/tools/testing/selftests/x86/Makefile
+++ b/tools/testing/selftests/x86/Makefile
@@ -71,10 +71,10 @@ all_64: $(BINARIES_64)
 EXTRA_CLEAN := $(BINARIES_32) $(BINARIES_64)
 
 $(BINARIES_32): $(OUTPUT)/%_32: %.c
-	$(CC) -m32 -o $@ $(CFLAGS) $(EXTRA_CFLAGS) $^ -lrt -ldl -lm
+	$(CC) -m32 -o $@ $(CFLAGS) $(EXTRA_CFLAGS) $(LDFLAGS) $^ $(LDLIBS) -lrt -ldl -lm
 
 $(BINARIES_64): $(OUTPUT)/%_64: %.c
-	$(CC) -m64 -o $@ $(CFLAGS) $(EXTRA_CFLAGS) $^ -lrt -ldl
+	$(CC) -m64 -o $@ $(CFLAGS) $(EXTRA_CFLAGS) $(LDFLAGS) $^ $(LDLIBS) -lrt -ldl
 
 # x86_64 users should be encouraged to install 32-bit libraries
 ifeq ($(CAN_BUILD_I386)$(CAN_BUILD_X86_64),01)
-- 
2.20.1

