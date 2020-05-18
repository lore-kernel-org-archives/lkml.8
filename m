Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,TVD_SUBJ_WIPE_DEBT,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB9EC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5099320671
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:10:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rgY0C0Tx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729335AbgERSKu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 14:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729609AbgERSKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 14:10:46 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 385B5C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 11:10:46 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id d7so2521647ote.6
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 11:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dZxD1YrOrHOLHOKBWQNSGC/hDMCUT9Jgny3VoBoayC0=;
        b=rgY0C0TxLfXX74YNZwA4VgzP454UWEwbM/tZyy31ob24Ee4XFMN6Rix6QE4ltW0OWG
         Qj5mgRkU05rz5D51ZtpCGQ8e3sUS+clBEam1iTRP1a0f7n8RBN0bhA4sMPbqDxzBeytU
         tF2BDnPUfBtEW/21kSTdpTKgLh7wQzoZnC88kqbxQFxBdsI2AYVtzXvD9is6D/p4pDsx
         nXP0GAYQgVWbIo5TF6UF0PkiicakjgzzTeWX4iRZr3BddcvO1GGf9Z98OmUpKQG5F0Bk
         HI12SyWjxRsNmL5wMqUMLsUSNHtlvtqiCUEikkFfJXtVxvNI6nj1GCjS4vTtmKTGvgK5
         6hiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dZxD1YrOrHOLHOKBWQNSGC/hDMCUT9Jgny3VoBoayC0=;
        b=KIQewwOmm0cUlzIGRr3JCRrGPVYjZcAWK9LW9cLpJiujZziAZGMY+4XrmeaLJC4nnf
         Ti/2pOwUPUrTkYddUxVzr3ZtARPzta/sCZSAC2QbcGHukWuudi8UFhuvyrwQlOe0e+9/
         oKdjqhC/v+7dZCxRcoiD8d3tz6drBYY5IBTPFa0WBUO4baWc4kz1/LmxatOlQpTykd/u
         r+HCXjVagtILRn3USWsujWRdAHq82RcbVym2LBzOnPsttRJ4idS+Mk0B+bR37tUh+jzc
         v5cGAEJ3vtQgp+4g9WFgY+tfOgc2sq8Tplv6JRd9+2Fh9ujnr8pPZFFmEfbrFXMJ4NB/
         t5BQ==
X-Gm-Message-State: AOAM530I1ZT8jy6zZrmNpbqeTEcTi4FfVZ1eIYmfC6aIZ6wfg4bLAm/Y
        FEyo8S4qCkLzlm2mtneQqZLeJmNS
X-Google-Smtp-Source: ABdhPJyaAm9aVKpeNqS9nc9LMsHNSDoAZXomzsHfqr9mAnU1CS9TL17kMcTO/zK8nuEcBt5aPPiiCQ==
X-Received: by 2002:a9d:a4c:: with SMTP id 70mr13974434otg.334.1589825445493;
        Mon, 18 May 2020 11:10:45 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id t22sm3217760oij.2.2020.05.18.11.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 11:10:45 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>,
        kbuild test robot <lkp@intel.com>
Subject: [PATCH] input: i8042: Remove special PowerPC handling
Date:   Mon, 18 May 2020 11:10:43 -0700
Message-Id: <20200518181043.3363953-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.27.0.rc0
In-Reply-To: <87a7254bxd.fsf@mpe.ellerman.id.au>
References: <87a7254bxd.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This causes a build error with CONFIG_WALNUT because kb_cs and kb_data
were removed in commit 917f0af9e5a9 ("powerpc: Remove arch/ppc and
include/asm-ppc").

ld.lld: error: undefined symbol: kb_cs
> referenced by i8042-ppcio.h:28 (drivers/input/serio/i8042-ppcio.h:28)
> input/serio/i8042.o:(__i8042_command) in archive drivers/built-in.a
> referenced by i8042-ppcio.h:28 (drivers/input/serio/i8042-ppcio.h:28)
> input/serio/i8042.o:(__i8042_command) in archive drivers/built-in.a
> referenced by i8042-ppcio.h:28 (drivers/input/serio/i8042-ppcio.h:28)
> input/serio/i8042.o:(__i8042_command) in archive drivers/built-in.a

ld.lld: error: undefined symbol: kb_data
> referenced by i8042.c:309 (drivers/input/serio/i8042.c:309)
> input/serio/i8042.o:(__i8042_command) in archive drivers/built-in.a
> referenced by i8042-ppcio.h:33 (drivers/input/serio/i8042-ppcio.h:33)
> input/serio/i8042.o:(__i8042_command) in archive drivers/built-in.a
> referenced by i8042.c:319 (drivers/input/serio/i8042.c:319)
> input/serio/i8042.o:(__i8042_command) in archive drivers/built-in.a
> referenced 15 more times

Presumably since nobody has noticed this for the last 12 years, there is
not anyone actually trying to use this driver so we can just remove this
special walnut code and use the generic header so it builds for all
configurations.

Fixes: 917f0af9e5a9 ("powerpc: Remove arch/ppc and include/asm-ppc")
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/input/serio/i8042-ppcio.h | 57 -------------------------------
 drivers/input/serio/i8042.h       |  2 --
 2 files changed, 59 deletions(-)
 delete mode 100644 drivers/input/serio/i8042-ppcio.h

diff --git a/drivers/input/serio/i8042-ppcio.h b/drivers/input/serio/i8042-ppcio.h
deleted file mode 100644
index 391f94d9e47d..000000000000
--- a/drivers/input/serio/i8042-ppcio.h
+++ /dev/null
@@ -1,57 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-#ifndef _I8042_PPCIO_H
-#define _I8042_PPCIO_H
-
-
-#if defined(CONFIG_WALNUT)
-
-#define I8042_KBD_IRQ 25
-#define I8042_AUX_IRQ 26
-
-#define I8042_KBD_PHYS_DESC "walnutps2/serio0"
-#define I8042_AUX_PHYS_DESC "walnutps2/serio1"
-#define I8042_MUX_PHYS_DESC "walnutps2/serio%d"
-
-extern void *kb_cs;
-extern void *kb_data;
-
-#define I8042_COMMAND_REG (*(int *)kb_cs)
-#define I8042_DATA_REG (*(int *)kb_data)
-
-static inline int i8042_read_data(void)
-{
-	return readb(kb_data);
-}
-
-static inline int i8042_read_status(void)
-{
-	return readb(kb_cs);
-}
-
-static inline void i8042_write_data(int val)
-{
-	writeb(val, kb_data);
-}
-
-static inline void i8042_write_command(int val)
-{
-	writeb(val, kb_cs);
-}
-
-static inline int i8042_platform_init(void)
-{
-	i8042_reset = I8042_RESET_ALWAYS;
-	return 0;
-}
-
-static inline void i8042_platform_exit(void)
-{
-}
-
-#else
-
-#include "i8042-io.h"
-
-#endif
-
-#endif /* _I8042_PPCIO_H */
diff --git a/drivers/input/serio/i8042.h b/drivers/input/serio/i8042.h
index 38dc27ad3c18..eb376700dfff 100644
--- a/drivers/input/serio/i8042.h
+++ b/drivers/input/serio/i8042.h
@@ -17,8 +17,6 @@
 #include "i8042-ip22io.h"
 #elif defined(CONFIG_SNI_RM)
 #include "i8042-snirm.h"
-#elif defined(CONFIG_PPC)
-#include "i8042-ppcio.h"
 #elif defined(CONFIG_SPARC)
 #include "i8042-sparcio.h"
 #elif defined(CONFIG_X86) || defined(CONFIG_IA64)

base-commit: 72bc15d0018ebfbc9c389539d636e2e9a9002b3b
-- 
2.27.0.rc0

