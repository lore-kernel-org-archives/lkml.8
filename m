Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A547DC3F2CD
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 00:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B02D246A3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 00:01:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oEStjVPt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730383AbgB1ABb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 19:01:31 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35639 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730345AbgB1AB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 19:01:27 -0500
Received: by mail-pg1-f196.google.com with SMTP id 7so529634pgr.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 16:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H9FWlvjeU2XqZhHoJiWspMH4kFGj3K9GjGYd2WRMYmQ=;
        b=oEStjVPt0S31nPacabrXXaqaOo12Uk+r85uXc9Xl7Tu1lXk9HmiONOEKMda7M1yCLl
         DfI6JExzzhDdrzGWYDMCWToyRPzvherlO6BerSNdsLYxiTTSYaVvNUHXPBhmY/g7c40t
         6aZqMcdDUuTRkqEUDTm4BWTIy0OXUsHY+h8Gc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H9FWlvjeU2XqZhHoJiWspMH4kFGj3K9GjGYd2WRMYmQ=;
        b=AmWDaHJzwWjP9C8tML8/S7+HJmAbU8J6F4UiyWvZfeTB3s6N2BeV/S7yEchR0WoxoH
         JeMlhWhiSxwq07wu68Dj3KPsF5EIL/Yv3scmXFS+XuGufusq0s8cNh2nowQ3voAFvVNj
         RUprs7tinQSQ7kUa3eCtpbNBjkZiJfusbxFfkfH6jbWDLYZsfx7sOVbVaIX3wQGd6oF+
         3XPbUy67Y4vMlK7QfvbXki9Ea/oQAk2aQr5DY2VfCMJu7IqfwE9pH4XILyNEEZax1eCb
         cxFENWKElXQue7+OthL+hehmn0hn6ITfra9Cr3SzZKpjukAj9lEfaNMsLpm3oZ+INAxm
         EJXA==
X-Gm-Message-State: APjAAAW7D4QN4VpmkevEQTYiP9FmKROtkZtHxRPLB59+94sKUElvwwLM
        vpfUp0ABXx6uwxpLDnPqJ8fmVQ==
X-Google-Smtp-Source: APXvYqzm3a/ZFJ1l5Nvdz79Gm4AfpVbhjeL86Hhy3RQsCyWjAO+rF4ZDCotN8wJqbSnZ9y96RTh5JA==
X-Received: by 2002:a63:df02:: with SMTP id u2mr1689153pgg.403.1582848086381;
        Thu, 27 Feb 2020 16:01:26 -0800 (PST)
Received: from thgarnie.kir.corp.google.com ([2620:0:1008:1100:6e62:16fa:a60c:1d24])
        by smtp.gmail.com with ESMTPSA id c18sm7314476pgw.17.2020.02.27.16.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 16:01:26 -0800 (PST)
From:   Thomas Garnier <thgarnie@chromium.org>
To:     kernel-hardening@lists.openwall.com
Cc:     kristen@linux.intel.com, keescook@chromium.org,
        Thomas Garnier <thgarnie@chromium.org>,
        Juergen Gross <jgross@suse.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        "VMware, Inc." <pv-drivers@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v11 10/11] x86/paravirt: Adapt assembly for PIE support
Date:   Thu, 27 Feb 2020 16:00:55 -0800
Message-Id: <20200228000105.165012-11-thgarnie@chromium.org>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
In-Reply-To: <20200228000105.165012-1-thgarnie@chromium.org>
References: <20200228000105.165012-1-thgarnie@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If PIE is enabled, switch the paravirt assembly constraints to be
compatible. The %c/i constrains generate smaller code so is kept by
default.

Signed-off-by: Thomas Garnier <thgarnie@chromium.org>
Acked-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/include/asm/paravirt_types.h | 32 +++++++++++++++++++++++----
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 84812964d3dd..82f7ca22e0ae 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -336,9 +336,32 @@ extern struct paravirt_patch_template pv_ops;
 #define PARAVIRT_PATCH(x)					\
 	(offsetof(struct paravirt_patch_template, x) / sizeof(void *))
 
+#ifdef CONFIG_X86_PIE
+#define paravirt_opptr_call "a"
+#define paravirt_opptr_type "p"
+
+/*
+ * Alternative patching requires a maximum of 7 bytes but the relative call is
+ * only 6 bytes. If PIE is enabled, add an additional nop to the call
+ * instruction to ensure patching is possible.
+ *
+ * Without PIE, the call is reg/mem64:
+ * ff 14 25 68 37 02 82    callq  *0xffffffff82023768
+ *
+ * With PIE, it is relative to %rip and take 1-less byte:
+ * ff 15 fa d9 ff 00       callq  *0xffd9fa(%rip) # <pv_ops+0x30>
+ *
+ */
+#define PARAVIRT_CALL_POST  "nop;"
+#else
+#define paravirt_opptr_call "c"
+#define paravirt_opptr_type "i"
+#define PARAVIRT_CALL_POST  ""
+#endif
+
 #define paravirt_type(op)				\
 	[paravirt_typenum] "i" (PARAVIRT_PATCH(op)),	\
-	[paravirt_opptr] "i" (&(pv_ops.op))
+	[paravirt_opptr] paravirt_opptr_type (&(pv_ops.op))
 #define paravirt_clobber(clobber)		\
 	[paravirt_clobber] "i" (clobber)
 
@@ -377,9 +400,10 @@ int paravirt_disable_iospace(void);
  * offset into the paravirt_patch_template structure, and can therefore be
  * freely converted back into a structure offset.
  */
-#define PARAVIRT_CALL					\
-	ANNOTATE_RETPOLINE_SAFE				\
-	"call *%c[paravirt_opptr];"
+#define PARAVIRT_CALL						\
+	ANNOTATE_RETPOLINE_SAFE					\
+	"call *%" paravirt_opptr_call "[paravirt_opptr];"	\
+	PARAVIRT_CALL_POST
 
 /*
  * These macros are intended to wrap calls through one of the paravirt
-- 
2.25.1.481.gfbce0eb801-goog

