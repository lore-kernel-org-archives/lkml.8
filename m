Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE1E2C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:32:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A819A2074D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:32:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbgIDPc3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 11:32:29 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:52106 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726235AbgIDPcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 11:32:13 -0400
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-380-XT_p-ukTPPqlZ0ruMbG8kw-1; Fri, 04 Sep 2020 11:32:10 -0400
X-MC-Unique: XT_p-ukTPPqlZ0ruMbG8kw-1
Received: by mail-ed1-f71.google.com with SMTP id c25so2831169edx.11
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 08:32:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xU8TftOeC0Fuep7MfzZLrg+PX+L/jbLYfVc8Z+rENd8=;
        b=s/qvEHq2FcJNXqtB+nht6P0EiW4PkFK59eilmEzgcKySch5Wf63e4DWKnr8qd1OqLk
         YmeNREbNi0Xh9j2geMBqvihuAwjwRqwm7m5aOOH8/f71Zb7xpGdbFg6DFVzLXU6TQmSr
         /nb58JkYwIlh/2sCsrNseFb+0/TaN/1H7dVqmM5XEw2u9YXjMcZt9gt4Glzn9dZyOB68
         iIeTh4cRswN5IBmqQ4/DCeX34nSpJTJgZ8pvRbbhN64qfHewYvMp+DhQFig0yeKEdk0A
         wJdfAl4EelOX+cOm1av3SgCci1Bj0bV6/CnFQa0xKimhdZWcBHUeEcmA3mfzp7WJnYVW
         qy6Q==
X-Gm-Message-State: AOAM531pq1NJEGcx4AHDqs04H9VEBFZW8uGc9piPO4+7ufUK1asFkXSQ
        vPqoKNTXBehFs5Smj9wb9CPym803R6zCfOt+NYaEdKKecH1rYb/VVjVinlIR1RJi2qW1hogZJdr
        He0WdDW7uSWOsUONGdW3wGiZq
X-Received: by 2002:a50:fd10:: with SMTP id i16mr9531800eds.54.1599233528482;
        Fri, 04 Sep 2020 08:32:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwsycBr1KCw/lYaAr2tRyQPj/ln19zy1cJXxbs4+k4FtK2YYjPxfhbpDd8McR6GeZx6zFnV1w==
X-Received: by 2002:a50:fd10:: with SMTP id i16mr9531772eds.54.1599233528278;
        Fri, 04 Sep 2020 08:32:08 -0700 (PDT)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id x21sm6418833ejy.97.2020.09.04.08.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 08:32:07 -0700 (PDT)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, mbenes@suse.cz,
        raphael.gault@arm.com, benh@kernel.crashing.org,
        Julien Thierry <jthierry@redhat.com>
Subject: [PATCH v3 03/10] objtool: Move macros describing structures to arch-dependent code
Date:   Fri,  4 Sep 2020 16:30:21 +0100
Message-Id: <20200904153028.32676-4-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200904153028.32676-1-jthierry@redhat.com>
References: <20200904153028.32676-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some macros are defined to describe the size and layout of structures
exception_table_entry, jump_entry and alt_instr. These values can vary
from one architecture to another.

Have the values be defined by arch specific code.

Suggested-by: Raphael Gault <raphael.gault@arm.com>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/objtool/arch/x86/include/arch_special.h | 20 +++++++++++++++++++
 tools/objtool/special.c                       | 16 +--------------
 2 files changed, 21 insertions(+), 15 deletions(-)
 create mode 100644 tools/objtool/arch/x86/include/arch_special.h

diff --git a/tools/objtool/arch/x86/include/arch_special.h b/tools/objtool/arch/x86/include/arch_special.h
new file mode 100644
index 000000000000..d818b2bffa02
--- /dev/null
+++ b/tools/objtool/arch/x86/include/arch_special.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef _X86_ARCH_SPECIAL_H
+#define _X86_ARCH_SPECIAL_H
+
+#define EX_ENTRY_SIZE		12
+#define EX_ORIG_OFFSET		0
+#define EX_NEW_OFFSET		4
+
+#define JUMP_ENTRY_SIZE		16
+#define JUMP_ORIG_OFFSET	0
+#define JUMP_NEW_OFFSET		4
+
+#define ALT_ENTRY_SIZE		13
+#define ALT_ORIG_OFFSET		0
+#define ALT_NEW_OFFSET		4
+#define ALT_FEATURE_OFFSET	8
+#define ALT_ORIG_LEN_OFFSET	10
+#define ALT_NEW_LEN_OFFSET	11
+
+#endif /* _X86_ARCH_SPECIAL_H */
diff --git a/tools/objtool/special.c b/tools/objtool/special.c
index e893f1e48e44..b04f395de5de 100644
--- a/tools/objtool/special.c
+++ b/tools/objtool/special.c
@@ -14,21 +14,7 @@
 #include "builtin.h"
 #include "special.h"
 #include "warn.h"
-
-#define EX_ENTRY_SIZE		12
-#define EX_ORIG_OFFSET		0
-#define EX_NEW_OFFSET		4
-
-#define JUMP_ENTRY_SIZE		16
-#define JUMP_ORIG_OFFSET	0
-#define JUMP_NEW_OFFSET		4
-
-#define ALT_ENTRY_SIZE		13
-#define ALT_ORIG_OFFSET		0
-#define ALT_NEW_OFFSET		4
-#define ALT_FEATURE_OFFSET	8
-#define ALT_ORIG_LEN_OFFSET	10
-#define ALT_NEW_LEN_OFFSET	11
+#include "arch_special.h"
 
 #define X86_FEATURE_POPCNT (4*32+23)
 #define X86_FEATURE_SMAP   (9*32+20)
-- 
2.21.3

