Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B4FC43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 15:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB1C32078B
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 15:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KeajrNlz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbgC0P3Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 11:29:24 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:56331 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727927AbgC0P3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 11:29:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585322961;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G7/+bLFXtT6ev3ED5VLu2ChKS4wBGYCBXGKeOZ0dsd4=;
        b=KeajrNlzYzda0reQpgol71YH961UxAJwQjDKiFDzCFmDil7SyVl4/0L+BsqLbMCnEOzebH
        8AnBDsF/6Y7TT2fajAkAqLzg9WcRWMQUjmC5ch56LybhbCwNRXcE0EABSzKRodvY1r5Ka1
        +KkPOl4m3AOLup42QO8hBAfFdVU/ZJc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-FvmT8F_DOmqP3_YfDfynkw-1; Fri, 27 Mar 2020 11:29:19 -0400
X-MC-Unique: FvmT8F_DOmqP3_YfDfynkw-1
Received: by mail-wr1-f69.google.com with SMTP id t25so2353668wrb.16
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 08:29:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G7/+bLFXtT6ev3ED5VLu2ChKS4wBGYCBXGKeOZ0dsd4=;
        b=GKN0iaq8OnQAGGfXfda8i63U08VNTacNT2d6BxBuCQSZboMsIafXpKU2rD9uVylW6l
         hMvRqwZX1QZaFPYDdvkW7spJf9UonPVDA1/eytXUigZiHw4ik4n5bRz5p7oaMF5oFyp1
         cCumLm2fh+UBnIM6O327h1dhkLhezN82rYcGqU38ZlTzO+HAQJ+X5MFPQKnwJqiu5+9m
         a7Drz50b1BMcDymbyD24lmy8ueq15UdLlmZRl1iUZZ/aLLEEcSfepRziMfMBmnVK7Be7
         JKJhZng7npn2nlZRe9smdR1NYoht5V0KkIDJnFnnVf2ywhvUvf078PUO3CcLL/Lspqp8
         D8xg==
X-Gm-Message-State: ANhLgQ2cA3K4lD6HFhZtFSdLgFeu7FSaFNdSQbCU8UXot2cjUbq3128i
        qVXIjj1JaJRzij1J6vBOXUXpYDieory3rg5HiYC8llYAhciihyxJadzudbSXuq6azI9U3j/XozU
        s29L6/9o/rJREqZvtNy8A1I0m
X-Received: by 2002:a5d:694a:: with SMTP id r10mr15032706wrw.234.1585322957780;
        Fri, 27 Mar 2020 08:29:17 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtCxnjhhtxmNPlgeBv8cRqrq7KSI7kRgrDVsu+Q1MNtzJcO4J/xN2ffVVr0PRRVkhExZlO57w==
X-Received: by 2002:a5d:694a:: with SMTP id r10mr15032695wrw.234.1585322957598;
        Fri, 27 Mar 2020 08:29:17 -0700 (PDT)
Received: from redfedo.redhat.com ([2a01:cb14:58d:8400:ecf6:58e2:9c06:a308])
        by smtp.gmail.com with ESMTPSA id i8sm8906856wrb.41.2020.03.27.08.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 08:29:16 -0700 (PDT)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, raphael.gault@arm.com,
        Julien Thierry <jthierry@redhat.com>
Subject: [PATCH v2 09/10] objtool: Split generic and arch specific CFI definitions
Date:   Fri, 27 Mar 2020 15:28:46 +0000
Message-Id: <20200327152847.15294-10-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200327152847.15294-1-jthierry@redhat.com>
References: <20200327152847.15294-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some CFI definitions used by generic objtool code have no reason to vary
from one architecture to another. Move those definition to generic code
and keep a separate per arch header to provide architecture specific CFI
definitions.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/objtool/Makefile                    |  3 ++-
 tools/objtool/arch/x86/include/cfi_regs.h | 25 +++++++++++++++++++++++
 tools/objtool/cfi.h                       | 21 ++-----------------
 3 files changed, 29 insertions(+), 20 deletions(-)
 create mode 100644 tools/objtool/arch/x86/include/cfi_regs.h

diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
index 519af6ec4eee..11b7dc5d18fe 100644
--- a/tools/objtool/Makefile
+++ b/tools/objtool/Makefile
@@ -29,7 +29,8 @@ all: $(OBJTOOL)
 
 INCLUDES := -I$(srctree)/tools/include \
 	    -I$(srctree)/tools/arch/$(HOSTARCH)/include/uapi \
-	    -I$(srctree)/tools/arch/$(SRCARCH)/include
+	    -I$(srctree)/tools/arch/$(SRCARCH)/include	\
+	    -I$(srctree)/tools/objtool/arch/$(SRCARCH)/include
 WARNINGS := $(EXTRA_WARNINGS) -Wno-switch-default -Wno-switch-enum -Wno-packed
 CFLAGS   := -Werror $(WARNINGS) $(KBUILD_HOSTCFLAGS) -g $(INCLUDES) $(LIBELF_FLAGS)
 LDFLAGS  += $(LIBELF_LIBS) $(LIBSUBCMD) $(KBUILD_HOSTLDFLAGS)
diff --git a/tools/objtool/arch/x86/include/cfi_regs.h b/tools/objtool/arch/x86/include/cfi_regs.h
new file mode 100644
index 000000000000..79bc517efba8
--- /dev/null
+++ b/tools/objtool/arch/x86/include/cfi_regs.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef _OBJTOOL_CFI_REGS_H
+#define _OBJTOOL_CFI_REGS_H
+
+#define CFI_AX			0
+#define CFI_DX			1
+#define CFI_CX			2
+#define CFI_BX			3
+#define CFI_SI			4
+#define CFI_DI			5
+#define CFI_BP			6
+#define CFI_SP			7
+#define CFI_R8			8
+#define CFI_R9			9
+#define CFI_R10			10
+#define CFI_R11			11
+#define CFI_R12			12
+#define CFI_R13			13
+#define CFI_R14			14
+#define CFI_R15			15
+#define CFI_RA			16
+#define CFI_NUM_REGS		17
+
+#endif /* _OBJTOOL_CFI_REGS_H */
diff --git a/tools/objtool/cfi.h b/tools/objtool/cfi.h
index 4427bf8ed686..1a3e7b807994 100644
--- a/tools/objtool/cfi.h
+++ b/tools/objtool/cfi.h
@@ -6,30 +6,13 @@
 #ifndef _OBJTOOL_CFI_H
 #define _OBJTOOL_CFI_H
 
+#include "cfi_regs.h"
+
 #define CFI_UNDEFINED		-1
 #define CFI_CFA			-2
 #define CFI_SP_INDIRECT		-3
 #define CFI_BP_INDIRECT		-4
 
-#define CFI_AX			0
-#define CFI_DX			1
-#define CFI_CX			2
-#define CFI_BX			3
-#define CFI_SI			4
-#define CFI_DI			5
-#define CFI_BP			6
-#define CFI_SP			7
-#define CFI_R8			8
-#define CFI_R9			9
-#define CFI_R10			10
-#define CFI_R11			11
-#define CFI_R12			12
-#define CFI_R13			13
-#define CFI_R14			14
-#define CFI_R15			15
-#define CFI_RA			16
-#define CFI_NUM_REGS		17
-
 struct cfi_reg {
 	int base;
 	int offset;
-- 
2.21.1

