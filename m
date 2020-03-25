Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 495CEC54FD0
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 08:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E50F20714
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 08:42:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VzDFICY0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727554AbgCYIma (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 04:42:30 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:21017 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727493AbgCYIm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 04:42:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585125745;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G7/+bLFXtT6ev3ED5VLu2ChKS4wBGYCBXGKeOZ0dsd4=;
        b=VzDFICY0cVN9duvRB9LAsErxwc5GTPPSfNCHOewUr01NkGP01f6qASn/4v/rPllSJgk0v8
        FVdoz9XXdVXIs+3s0bSLoi3JQdVs+kRLragkkZuyMjwjXv+jm7/SNeUs+7v1gf9hmXnHwz
        azz9Sds1tXwwA5yfzXZ/2qcfAIXoTeE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-Fr1GzrUDO3GGBou986RCNg-1; Wed, 25 Mar 2020 04:42:24 -0400
X-MC-Unique: Fr1GzrUDO3GGBou986RCNg-1
Received: by mail-wm1-f69.google.com with SMTP id p18so601020wmk.9
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 01:42:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G7/+bLFXtT6ev3ED5VLu2ChKS4wBGYCBXGKeOZ0dsd4=;
        b=p3jyp18mFTZIgVTV5ocpH5KdEeSa1Oxdh8vLT304Yd2SMyFKR2RH+F/gxJBhgncoCl
         iCaT4xrL32phfwy8E5amGqhRE3NdvdvPm85AH3M7WxCPqo7S2w3R7XXyMA5DkOhhYLJF
         Ae67xIxnTUYTULpTZ+WKa7sXHkEquC7B1ZR1XY0uasC3w6lPd+ENZot4XvAgyVT/4l4z
         kw70qE6IiGweFMYg4L4AZQOy0A6d9F7emzZbBjgE7Vs5ijo4j/nTwTlpUy6FeqOuqBt3
         e0qZunNeD0e/j6VMVtDkkhInSy7K8JSbwKc289cEGAZDZ6QuQxATGfrhe5a3u4Ba8fBC
         Xv9w==
X-Gm-Message-State: ANhLgQ3XNt6AiEDzVMdPm5JoiuaPs+b7F2EvID1VsEWDABD9000t3Hy5
        J9S+oAjLpk/3U3rzsNEZrBTDCGdh8NNiPRpnF27GLsNUKDgt8L6wfGfgAHCvKAbfjDxX5qx2gqR
        5Bkt+2ifIjxzOdjdj9XSNMCsd
X-Received: by 2002:a05:600c:20a:: with SMTP id 10mr2375141wmi.135.1585125742495;
        Wed, 25 Mar 2020 01:42:22 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtVxx31FwZ8MQUGpxo9ek7HhwUArJgOrGlEdxFBryGP+8MN0MNubO8lFlbH6LRAUlKJegVUBQ==
X-Received: by 2002:a05:600c:20a:: with SMTP id 10mr2375123wmi.135.1585125742272;
        Wed, 25 Mar 2020 01:42:22 -0700 (PDT)
Received: from redfedo.redhat.com ([2a01:cb14:58d:8400:ecf6:58e2:9c06:a308])
        by smtp.gmail.com with ESMTPSA id f12sm8055323wmf.24.2020.03.25.01.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 01:42:21 -0700 (PDT)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, raphael.gault@arm.com,
        Julien Thierry <jthierry@redhat.com>
Subject: [PATCH 09/10] objtool: Split generic and arch specific CFI definitions
Date:   Wed, 25 Mar 2020 08:42:02 +0000
Message-Id: <20200325084203.17005-10-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200325084203.17005-1-jthierry@redhat.com>
References: <20200325084203.17005-1-jthierry@redhat.com>
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

