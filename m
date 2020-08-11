Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9DDCC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 21:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 804AA20771
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 21:02:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgHKVCB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 17:02:01 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46535 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726503AbgHKVCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 17:02:00 -0400
Received: by mail-lj1-f195.google.com with SMTP id h19so15068390ljg.13
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 14:01:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/rLVEXEg2UmvMufjSAF7U0pAi6vIHw1hc4UHchgW5EU=;
        b=XGzYmzjFM6+i2pdCz5OrDAXN5gu+cPHw1pI7MnAcz8fhHwUqwoFoGPQ3RwGAsEZ3/2
         HHBbRXxCSpCxKPiIZ+oAf+fbQT4JTZnhET7nVwa2UNdKbPOcL7y3wrU8hlU8SwMiVyrF
         oGqdrb/BGEnKOKABbRIG9DZ+TWznj+1+eQcNKxqf77x6Eq7Ng5D0+OSg4UHxrstX+uX0
         ex6PBhPu4XTY2XrEGYFeyiF3li2lalbXQc91qVmGxflsdkwSHn57wuc+5w/z94CpBwFM
         BZZv9oSOwFnJIUc9iGB3/Mzrsz3lMHr7hwS5AAec3HrOXEpdVlpysKtVFvs6o2F7605i
         nE6Q==
X-Gm-Message-State: AOAM531iWO5UMSir7nWp6tRHcztlxVdYuIgEThz7u0A5unqx4zyt+DHR
        DlPPyKvQe8LlwBHZR+B/P14=
X-Google-Smtp-Source: ABdhPJxNt4Y58LNPRSHZhxIIteWTiyzlrXqElWX0V/P2mYMjZJP1Sqj/8C0a14QJFu1lNfEUBSE6vQ==
X-Received: by 2002:a05:651c:1122:: with SMTP id e2mr3709126ljo.36.1597179717627;
        Tue, 11 Aug 2020 14:01:57 -0700 (PDT)
Received: from localhost.localdomain (broadband-37-110-38-130.ip.moscow.rt.ru. [37.110.38.130])
        by smtp.googlemail.com with ESMTPSA id b1sm10265823ljp.78.2020.08.11.14.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 14:01:57 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Denis Efremov <efremov@linux.com>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>
Subject: [RFC PATCH] coccinelle: misc: add uninitialized_var.cocci script
Date:   Wed, 12 Aug 2020 00:01:27 +0300
Message-Id: <20200811210127.11889-1-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 63a0895d960a ("compiler: Remove uninitialized_var() macro") and
commit 4b19bec97c88 ("docs: deprecated.rst: Add uninitialized_var()")
removed uninitialized_var() and deprecated it.

The purpose of this script is to prevent new occurrences of open-coded
variants of uninitialized_var().

Cc: Kees Cook <keescook@chromium.org>
Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
Signed-off-by: Denis Efremov <efremov@linux.com>
---
List of warnings:
./lib/glob.c:48:31-39: WARNING: this kind of initialization is deprecated
./tools/testing/selftests/vm/userfaultfd.c:349:15-22: WARNING: this kind of initialization is deprecated
./drivers/block/drbd/drbd_vli.h:330:5-9: WARNING: this kind of initialization is deprecated
./drivers/char/hw_random/intel-rng.c:333:15-18: WARNING: this kind of initialization is deprecated
./drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:316:7-10: WARNING: this kind of initialization is deprecated
./arch/x86/include/asm/paravirt_types.h:455:15-20: WARNING: this kind of initialization is deprecated
./arch/x86/include/asm/paravirt_types.h:455:30-35: WARNING: this kind of initialization is deprecated
./arch/x86/include/asm/paravirt_types.h:455:45-50: WARNING: this kind of initialization is deprecated
./arch/x86/include/asm/paravirt_types.h:475:15-20: WARNING: this kind of initialization is deprecated
./arch/x86/include/asm/paravirt_types.h:475:30-35: WARNING: this kind of initialization is deprecated
./arch/x86/include/asm/paravirt_types.h:476:2-7: WARNING: this kind of initialization isdeprecated
./arch/x86/include/asm/paravirt_types.h:476:17-22: WARNING: this kind of initialization is deprecated
./arch/x86/include/asm/paravirt_types.h:476:32-37: WARNING: this kind of initialization is deprecated

 .../coccinelle/misc/uninitialized_var.cocci   | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 scripts/coccinelle/misc/uninitialized_var.cocci

diff --git a/scripts/coccinelle/misc/uninitialized_var.cocci b/scripts/coccinelle/misc/uninitialized_var.cocci
new file mode 100644
index 000000000000..e4787bc6ab9c
--- /dev/null
+++ b/scripts/coccinelle/misc/uninitialized_var.cocci
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0-only
+///
+/// uninitialized_var() and its open-coded variations are
+/// deprecated. For details, see:
+/// Documentation/process/deprecated.rst
+///
+// Confidence: High
+// Copyright: (C) 2020 Denis Efremov ISPRAS
+// Options: --no-includes --include-headers
+//
+
+virtual context
+virtual report
+virtual org
+
+@r@
+identifier var;
+type T;
+position p;
+@@
+
+(
+* T var@p = var;
+|
+* T var@p = *(&(var));
+//|
+// TODO: Actually, I'm not sure about this pattern.
+// Looks like it's used in wireless drivers to determine
+// whether data belongs to the driver or not.
+// Here are all matches:
+// https://elixir.bootlin.com/linux/latest/source/net/mac802154/util.c#L14
+// https://elixir.bootlin.com/linux/latest/source/drivers/staging/wlan-ng/cfg80211.c#L48
+// https://elixir.bootlin.com/linux/latest/source/drivers/net/wireless/intersil/orinoco/cfg.c#L21
+// https://elixir.bootlin.com/linux/latest/source/net/mac80211/util.c#L37
+// https://elixir.bootlin.com/linux/latest/source/drivers/net/wireless/rndis_wlan.c#L544
+// * T *var@p = &var;
+)
+
+@script:python depends on report@
+p << r.p;
+@@
+
+coccilib.report.print_report(p[0],
+  "WARNING: this kind of initialization is deprecated")
+
+@script:python depends on org@
+p << r.p;
+@@
+
+coccilib.org.print_todo(p[0],
+  "WARNING: this kind of initialization is deprecated")
-- 
2.26.2

