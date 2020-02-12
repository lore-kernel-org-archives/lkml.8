Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 876F0C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 08:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C4B3206ED
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 08:58:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="pvAOFnQm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728855AbgBLI6a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 03:58:30 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45864 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728816AbgBLI62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 03:58:28 -0500
Received: by mail-wr1-f65.google.com with SMTP id g3so1170358wrs.12
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 00:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PaNb/Wp11IhwyKZtaeQKdn01ArSCATdD8YJx8G+8pWE=;
        b=pvAOFnQmyb0XpA+3rrFTqQcXgWZcZCpPzPU33FovZQy6p03SaD2vv8L9o14UdUxpV4
         lRnvQWA8AhmVTmy+NXcIyx+3RCBFVt6T52mgROqI4g7nEo7B28nJJ110uTTtCENtgFUU
         MHfpS/MJ3RQtT+12WCGlJII+jr1NL8Zf7S3JhzWhUCKPzhIUKHF6ZBH9+rMTQASlDrKr
         nOGpUIWJYfO8faoOhN1iAJVDyc7QhTXdVDgaSzgG9kA8jBoyGWc4cTkOdbIohA5LTqbJ
         NoHHgIL5VwYGSa+tx0onKADDLFh9xu3UA1RyVj9ngAQUODL/Vy4dXJ3VDcncqarJLsZ8
         iITw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=PaNb/Wp11IhwyKZtaeQKdn01ArSCATdD8YJx8G+8pWE=;
        b=REDt6nvNneneDPIrDEwi8zom4o7M/Tl1n98zyqWqjMNZiq0PaLlvK1bhSOWlq8oIxw
         fCQA+AY9kBB/lzdvbEqYmOgdK68uva2wMd8oyXpr7i2SdbCf5T4kC5Felpm2V6PNYub4
         Gu7Dy2c+yWJh9q22F9MeMCVIhO7r7H3QhPDAFuGCf5YZDnBy9a24NaL8E1Z8HdNToRXL
         I3kTFQHi/GbMDcat7rdD59wgfjOgjXpLYBYcMIYVZC6E89vQ5l18Wt0eg1QK9+UsSg6y
         vm7MzFXwbHVsWWY5sqsZMGWnOyTJCp7WBXZtbTKXK1RWNUfq0r4zw/BfYRx9YydRdjy4
         kJyA==
X-Gm-Message-State: APjAAAUTC+lBqWabaCgLJxmaP7wHvr4T9siNPrEjspkvDG+jOv6hf51d
        17s9QvDryRItds4OL+x8EO3yVBsk6numJA==
X-Google-Smtp-Source: APXvYqzKiH9zifcTTIKwEkQwuhqhZwzylYLpbie9d/XFWY0VwbhKL+YdrSFnArDcgBvpusTZBora6w==
X-Received: by 2002:a5d:4bd0:: with SMTP id l16mr5409699wrt.271.1581497906135;
        Wed, 12 Feb 2020 00:58:26 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id n13sm7498001wmd.21.2020.02.12.00.58.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Feb 2020 00:58:25 -0800 (PST)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com, arnd@arndb.de
Cc:     Stefan Asserhall <stefan.asserhall@xilinx.com>
Subject: [PATCH 10/10] microblaze: Use asm generic cmpxchg.h for !SMP case
Date:   Wed, 12 Feb 2020 09:58:07 +0100
Message-Id: <4d8c08bc549fc663eba0237a4ccd5e1e0e1bc01c.1581497860.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1581497860.git.michal.simek@xilinx.com>
References: <cover.1581497860.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The whole implementation is done in asm-generic/cmpxchg.h file and there is
no reason to duplicate it.
Also do not include asm-generic/cmpxchg-local.h because it is already
included from asm-generic/cmpxchg.h

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Reviewed-by: Stefan Asserhall <stefan.asserhall@xilinx.com>
---

 arch/microblaze/include/asm/cmpxchg.h | 40 ++-------------------------
 1 file changed, 3 insertions(+), 37 deletions(-)

diff --git a/arch/microblaze/include/asm/cmpxchg.h b/arch/microblaze/include/asm/cmpxchg.h
index 596300c74509..3523b51aab36 100644
--- a/arch/microblaze/include/asm/cmpxchg.h
+++ b/arch/microblaze/include/asm/cmpxchg.h
@@ -2,42 +2,8 @@
 #ifndef _ASM_MICROBLAZE_CMPXCHG_H
 #define _ASM_MICROBLAZE_CMPXCHG_H
 
-#include <linux/irqflags.h>
-
-void __bad_xchg(volatile void *ptr, int size);
-
-static inline unsigned long __xchg(unsigned long x, volatile void *ptr,
-								int size)
-{
-	unsigned long ret;
-	unsigned long flags;
-
-	switch (size) {
-	case 1:
-		local_irq_save(flags);
-		ret = *(volatile unsigned char *)ptr;
-		*(volatile unsigned char *)ptr = x;
-		local_irq_restore(flags);
-		break;
-
-	case 4:
-		local_irq_save(flags);
-		ret = *(volatile unsigned long *)ptr;
-		*(volatile unsigned long *)ptr = x;
-		local_irq_restore(flags);
-		break;
-	default:
-		__bad_xchg(ptr, size), ret = 0;
-		break;
-	}
-
-	return ret;
-}
-
-#define xchg(ptr, x) \
-	((__typeof__(*(ptr))) __xchg((unsigned long)(x), (ptr), sizeof(*(ptr))))
-
-#include <asm-generic/cmpxchg.h>
-#include <asm-generic/cmpxchg-local.h>
+#ifndef CONFIG_SMP
+# include <asm-generic/cmpxchg.h>
+#endif
 
 #endif /* _ASM_MICROBLAZE_CMPXCHG_H */
-- 
2.25.0

