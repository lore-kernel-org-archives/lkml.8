Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BEB4C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20CDE20678
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:46:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nfb4fQD1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732804AbgAXLqh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:46:37 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33716 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729095AbgAXLqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:46:36 -0500
Received: by mail-lj1-f195.google.com with SMTP id y6so2195298lji.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jan 2020 03:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F2G1ORi33EQjZONnTNxOFvz/ixSFTtSO2wAQsE2faxE=;
        b=nfb4fQD15j+5/qjRtx4pMNiyZI56Aajq55aOdEvUCguiaHOrzYWDxCICiuXTUzyz+y
         D3jRv28eoV+WsKPXY300w6ZZkURRfuOqK+7nYost2bZsyNV03v0h0lf0FkwWOH7ltx5G
         1FGrMCZe9qfMluIkRd9zFw0RVZaF47aekKsUcQb9qenQ1JTAAOxC9i1vR2MuOq7qVWWq
         dOP7Ix6WPD52I8YVhwCWnjR/n9f6Jkut2Dzace3dlmu4eJUUINc6jZNpISd2ZW4y7Cqt
         Ol6tZ3LVmUyGkiVJePfhbGDhKvAIf7zFDwDv9xDBC7tRnKLzAOGJ6Np7lDyqyfbp+lsk
         cr8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F2G1ORi33EQjZONnTNxOFvz/ixSFTtSO2wAQsE2faxE=;
        b=KKkzqX/rrY6R6JlXFlcG73DmPrjkVgrL5WvSd0umrqaRWtmzALJu3AP2O0w3gyN9of
         eNXvaYJhZD/LMprQBH+EgjtJqCawm5WOviVWEVvDQ2J83s9S4By9F/14ca1nQquCMeTt
         6qJDRIoS/tilQ3ePyu1V3OINPO396daHsS3CpBJkQgEM5MZg0BbHvTjOmZtEDiEcXRvA
         qHGNPiOKe7HNnVhPXgq0Zihki+qIRaeBGv5sV6b8DbX6zdms8F7TVuivaFXEhzPjUoLc
         nRNwDw0fDggwfL9J/UaRxIABcXmCwvTi9QovcrAttjzbv4YfP7lfgJNxsQCEV8CFvla/
         fGiw==
X-Gm-Message-State: APjAAAXjViqUqA1/ftNvUwgys4kfMbTU215Hz5HR1rphv1vpP2beg9Ht
        nF/tvbwOJUSdyQoDWdzvZra3Nw==
X-Google-Smtp-Source: APXvYqzm//t0nGqXj1IjiQlBpurYhxhakJnv3gh/mxGnI3im9FLSe1dHxI7gZyvW5y3SK/gnWNWI6g==
X-Received: by 2002:a2e:7009:: with SMTP id l9mr2008261ljc.96.1579866394478;
        Fri, 24 Jan 2020 03:46:34 -0800 (PST)
Received: from localhost (c-413e70d5.07-21-73746f28.bbcust.telenor.se. [213.112.62.65])
        by smtp.gmail.com with ESMTPSA id i197sm2596473lfi.56.2020.01.24.03.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 03:46:33 -0800 (PST)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] x86: Kconfig: make CMDLINE_OVERRIDE depend on CMDLINE
Date:   Fri, 24 Jan 2020 12:46:15 +0100
Message-Id: <20200124114615.11577-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When trying to boot an allmodconfig kernel that is build with
KCONFIG_ALLCONFIG=$(pwd)/arch/x86/configs/x86_64_defconfig, it doesn't
boot since CONFIG_CMDLINE_OVERRIDE gets enabled. Which forces the user
to pass the full cmdline to CONFIG_CMDLINE="...".

Rework so that CONFIG_CMDLINE_OVERRIDE gets set only if CONFIG_CMDLINE
is set to something except an empty string.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 arch/x86/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index f2dcd9ab6ef6..598b6325a027 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2447,7 +2447,7 @@ config CMDLINE
 
 config CMDLINE_OVERRIDE
 	bool "Built-in command line overrides boot loader arguments"
-	depends on CMDLINE_BOOL
+	depends on CMDLINE_BOOL && CMDLINE != ""
 	---help---
 	  Set this option to 'Y' to have the kernel ignore the boot loader
 	  command line, and use ONLY the built-in command line.
-- 
2.20.1

