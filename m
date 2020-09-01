Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87DE0C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 09:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C5D12083B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 09:48:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbgIAJs1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 05:48:27 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33678 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbgIAJsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 05:48:25 -0400
Received: by mail-lf1-f66.google.com with SMTP id x77so416157lfa.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 02:48:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ku+nugNWPyX7lpg+XSale+yrTsQfcGRDRnrna/DM1Vk=;
        b=DsXjn1uvxH9PpC0dUAzej87HYI7v0BAvEKUugMYNxkIGnc6QfdACxGgjDCw4oa+zPB
         aPl/uvfxlKTx+x/NRgNe1X2eihMszr27R9GgGJjydneTmvoIVmdVdV4DQI/vThWWBoRy
         8zxmzH1IgYx9uz1uxWPvc33RrEm1qhG2srVlEE52J468ylFhcianKnSQUo/wpLw0dCnr
         r126v4x5QrlLCryxYcKRqXWISG3O051kGiy3RHRPlR+tZzGHncBEBfP6xQE+TKg7/tYV
         B8AQUy4ShMebt7nLMqZiW1fJ8PGujKvompTwBodXVJNIdEs4LfE2wsm9fAlOLHvht0cK
         fllg==
X-Gm-Message-State: AOAM531LTV0Tgf57bdrKaL+wpv/YO8HEx7UQmmQZ+Npap0TKE/Y4Nyyz
        OD0Ix7D8x8BbCa1mA1+A3O8=
X-Google-Smtp-Source: ABdhPJxORnVoHKDBQINhMqqDGxK2HyT1fEJslhujG33SEMzNwFMobbT5ISXUG16TB33H5AS6Rx6jRg==
X-Received: by 2002:a05:6512:1142:: with SMTP id m2mr188097lfg.22.1598953703443;
        Tue, 01 Sep 2020 02:48:23 -0700 (PDT)
Received: from localhost.localdomain (broadband-37-110-38-130.ip.moscow.rt.ru. [37.110.38.130])
        by smtp.googlemail.com with ESMTPSA id q20sm166278ljj.42.2020.09.01.02.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 02:48:22 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     julia.lawall@inria.fr
Cc:     Denis Efremov <efremov@linux.com>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>
Subject: [PATCH v3] coccinelle: misc: add uninitialized_var.cocci script
Date:   Tue,  1 Sep 2020 12:48:12 +0300
Message-Id: <20200901094812.428896-1-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200811210127.11889-1-efremov@linux.com>
References: <20200811210127.11889-1-efremov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

uninitialized_var() macro was removed from the sources [1] and
other warning-silencing tricks were deprecated [2]. The purpose of this
cocci script is to prevent new occurrences of uninitialized_var()
open-coded variants.

[1] commit 63a0895d960a ("compiler: Remove uninitialized_var() macro")
[2] commit 4b19bec97c88 ("docs: deprecated.rst: Add uninitialized_var()")

Cc: Kees Cook <keescook@chromium.org>
Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
Signed-off-by: Denis Efremov <efremov@linux.com>
---
Changes in v2:
 - Documentation cited in the script's description
 - kernel.org link added to the diagnostics messages
 - "T *var = &var;" pattern removed
 - "var =@p var", "var =@p *(&(var))" patterns added
Changes in v3:
 - commit's description changed

 .../coccinelle/misc/uninitialized_var.cocci   | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 scripts/coccinelle/misc/uninitialized_var.cocci

diff --git a/scripts/coccinelle/misc/uninitialized_var.cocci b/scripts/coccinelle/misc/uninitialized_var.cocci
new file mode 100644
index 000000000000..8fa845cefe11
--- /dev/null
+++ b/scripts/coccinelle/misc/uninitialized_var.cocci
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0-only
+///
+/// Please, don't reintroduce uninitialized_var().
+/// From Documentation/process/deprecated.rst:
+///  For any compiler warnings about uninitialized variables, just add
+///  an initializer. Using warning-silencing tricks is dangerous as it
+///  papers over real bugs (or can in the future), and suppresses unrelated
+///  compiler warnings (e.g. "unused variable"). If the compiler thinks it
+///  is uninitialized, either simply initialize the variable or make compiler
+///  changes. Keep in mind that in most cases, if an initialization is
+///  obviously redundant, the compiler's dead-store elimination pass will make
+///  sure there are no needless variable writes.
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
+* T var =@p var;
+|
+* T var =@p *(&(var));
+|
+* var =@p var
+|
+* var =@p *(&(var))
+)
+
+@script:python depends on report@
+p << r.p;
+@@
+
+coccilib.report.print_report(p[0],
+  "WARNING this kind of initialization is deprecated (https://www.kernel.org/doc/html/latest/process/deprecated.html#uninitialized-var)")
+
+@script:python depends on org@
+p << r.p;
+@@
+
+coccilib.org.print_todo(p[0],
+  "WARNING this kind of initialization is deprecated (https://www.kernel.org/doc/html/latest/process/deprecated.html#uninitialized-var)")
-- 
2.26.2

