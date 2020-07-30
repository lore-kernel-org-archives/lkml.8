Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00205C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 09:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D55B220809
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 09:47:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FGVqSSUX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729470AbgG3JrS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 05:47:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35734 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727044AbgG3JrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 05:47:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596102423;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xU8TftOeC0Fuep7MfzZLrg+PX+L/jbLYfVc8Z+rENd8=;
        b=FGVqSSUXOnaoXZkb8C5GoVwxRjamzNmTOcEG0dzvTq8Rmj8SNQb1q7UR4r4ZlGO/QTYRfq
        tegVqmomI3cALNRrQeksX4eK2+m2bvTub/z7CXQNrfA/fOHTOApl/pUuGIflSYk/JLtUGb
        GDrP77TU4UFPFAEp22Xos+lDsOpBeHg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-436-ilxiemabPymlk7ofbpsWgA-1; Thu, 30 Jul 2020 05:47:01 -0400
X-MC-Unique: ilxiemabPymlk7ofbpsWgA-1
Received: by mail-wm1-f70.google.com with SMTP id u14so1222352wml.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 02:47:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xU8TftOeC0Fuep7MfzZLrg+PX+L/jbLYfVc8Z+rENd8=;
        b=ec9Uq4AjdE/KaWeP4w5Jb8aSB8W0JhxAjFcWBPnNlH3HsEmbJnlcddglMSkgWvlAEE
         gM2a20Ea/7VhMQ/KB82e13UXw1iJPg2mZBlaH+a2ZhMC3ywXkM+CCejfXKh8kECYIGHF
         myXI6GiDzezyEKS+vfYgBBQjKXL309zJqhKjdtYWKKzj+coFHRUHk8NQOvlF0DPeFtbh
         cFAdUZ7DbnmOPEZsmo8wevGCsNA8tYpH53Unc7GQKMSjoxBdCS8j1nW3tlYWns6nlMdX
         Du91ZjHIlgjFweiuY0aS6CHpj/bio0VVQOQ/YGqWqgEgXPZQ9MO2S4LEmrbhhSAD96iM
         q+vQ==
X-Gm-Message-State: AOAM530FuEeBB9/O2aZ9EVqhaHPisnR3yusRSg2wGk8ElhUbfYM4/N5t
        sBHa9VBS9ReGNnDtZCQBUdZl4TpHjzlR85X783rxGyEjvqP51jUOkyQ40F1v8a6ITdLTpbmZnlV
        fjRS/j9KPml7kq5hoseHPQ0Tz
X-Received: by 2002:adf:ab46:: with SMTP id r6mr2004031wrc.260.1596102419834;
        Thu, 30 Jul 2020 02:46:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwdHbyeNnJIRUYYo5/dU7riJI6VVzynOunLMio/TEU1suwAh6H/6QIg80xmBhS6SAo9UacQJw==
X-Received: by 2002:adf:ab46:: with SMTP id r6mr2004022wrc.260.1596102419685;
        Thu, 30 Jul 2020 02:46:59 -0700 (PDT)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id j6sm9009645wro.25.2020.07.30.02.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 02:46:59 -0700 (PDT)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, mbenes@suse.cz,
        raphael.gault@arm.com, benh@kernel.crashing.org,
        Julien Thierry <jthierry@redhat.com>
Subject: [PATCH v2 3/9] objtool: Move macros describing structures to arch-dependent code
Date:   Thu, 30 Jul 2020 10:46:46 +0100
Message-Id: <20200730094652.28297-4-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200730094652.28297-1-jthierry@redhat.com>
References: <20200730094652.28297-1-jthierry@redhat.com>
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

