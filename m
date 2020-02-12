Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26CDBC2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 08:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F332C206ED
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 08:58:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="cQJb69Ao"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbgBLI6V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 03:58:21 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39628 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728426AbgBLI6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 03:58:20 -0500
Received: by mail-wm1-f68.google.com with SMTP id c84so1217948wme.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 00:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fkFsc1crcpbc03spvRPFRPP4kpxoZKtSmQVBSZfnJ9k=;
        b=cQJb69AoyqeV1p6/MS1Jy9Dqe22aZYg1tyXPQO8VceDdhkKoDJlhvnVPokJ2YEC5/C
         i2/j4RsPnRL7w6Vlw3cvRaJAgZAU/1gLlxHE0oF21UDyHg5QkrzAMcBFMjZcvKqttW+i
         O/ty/I/hruNwM0XNk3DTVO9RrPuNEfvri3KWUkGNhBlV9UBxcnqq66KgRTmDU2oa5fxa
         9sQVP0BGLp+muvLtMCbLdL6c1y2IH/HbBY9P/B2+SgMJEPVeKLR4rVUAiQJMqejerlHV
         b3gyaF2rLcsmeBIpIqoamWmbuOML8BcPUygYlmea9FtfZ/T4nGZTDXEu8lvY4XXpB1lt
         UMWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=fkFsc1crcpbc03spvRPFRPP4kpxoZKtSmQVBSZfnJ9k=;
        b=WRjNwPO37/p7y8iMFGkSNBa9lYlfX/jFzk2T4db+gCr6SmoMWjxc4xPe/2IRMqUbBn
         DsFwWhbpcCoyRJ0176hGqvvQIdCIzCTaDMM53I26H183u0zfGJ6ttG57vt9pZseJC8ZZ
         AgWXuZF2+VbDGGXETZQVeY1yC1NVTEAX4rOKKOgWSBdbzr61C9XBoNEhiKerU/ZOl6Zm
         iCmALAMYpKL8o1DPMqDXYXfkTjyRLzWDLk/cdxyQx7glUVsLk+OoDIxySuMYjxYH0kkv
         tAMWmWw8T6K6LgXqGG6Rnp7BFGfrGQOt/NRGqO+bCSGKBS9F32lSmWYArS4IPQ1HRxtk
         /6Vw==
X-Gm-Message-State: APjAAAXNONwuX+JG1ebPzZ2V+SP+m8cRiRe/vPnQWxca+RNpahqeUhpl
        A9BP9NHyrl+56Sq+3riHaSZZb2xf9MwKxw==
X-Google-Smtp-Source: APXvYqzMa/RlkRRpugzOMDwltW4H+IByonuT+YrDdTTa26NBsw7W66vFu0YIKgx/w+PunEPgh/3kyQ==
X-Received: by 2002:a7b:c38c:: with SMTP id s12mr11211734wmj.96.1581497897989;
        Wed, 12 Feb 2020 00:58:17 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id b11sm8864825wrx.89.2020.02.12.00.58.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Feb 2020 00:58:17 -0800 (PST)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com, arnd@arndb.de
Cc:     Stefan Asserhall <stefan.asserhall@xilinx.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Will Deacon <will@kernel.org>
Subject: [PATCH 05/10] microblaze: Define microblaze barrier
Date:   Wed, 12 Feb 2020 09:58:02 +0100
Message-Id: <be707feb95d65b44435a0d9de946192f1fef30c6.1581497860.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1581497860.git.michal.simek@xilinx.com>
References: <cover.1581497860.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Asserhall <stefan.asserhall@xilinx.com>

Define microblaze barrier.

Signed-off-by: Stefan Asserhall <stefan.asserhall@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/microblaze/include/asm/Kbuild    |  1 -
 arch/microblaze/include/asm/barrier.h | 13 +++++++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)
 create mode 100644 arch/microblaze/include/asm/barrier.h

diff --git a/arch/microblaze/include/asm/Kbuild b/arch/microblaze/include/asm/Kbuild
index a11407112e9a..abb33619299b 100644
--- a/arch/microblaze/include/asm/Kbuild
+++ b/arch/microblaze/include/asm/Kbuild
@@ -1,6 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 generated-y += syscall_table.h
-generic-y += barrier.h
 generic-y += bitops.h
 generic-y += bug.h
 generic-y += bugs.h
diff --git a/arch/microblaze/include/asm/barrier.h b/arch/microblaze/include/asm/barrier.h
new file mode 100644
index 000000000000..70b0a017781b
--- /dev/null
+++ b/arch/microblaze/include/asm/barrier.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2015 - 2020 Xilinx, Inc. All rights reserved.
+ */
+
+#ifndef _ASM_MICROBLAZE_BARRIER_H
+#define _ASM_MICROBLAZE_BARRIER_H
+
+#define mb()	__asm__ __volatile__ ("mbar 1" : : : "memory")
+
+#include <asm-generic/barrier.h>
+
+#endif /* _ASM_MICROBLAZE_BARRIER_H */
-- 
2.25.0

