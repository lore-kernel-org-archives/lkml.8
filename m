Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0432C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 14:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99A5920714
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 14:05:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="iPfcRd1w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729099AbgBJOFz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 09:05:55 -0500
Received: from mail-wr1-f47.google.com ([209.85.221.47]:41851 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726846AbgBJOFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 09:05:55 -0500
Received: by mail-wr1-f47.google.com with SMTP id c9so7892816wrw.8
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 06:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G/FZSNf3MhvRb/T7INkTCPjfGTsSzpMNGjUKbnmKyY4=;
        b=iPfcRd1w4laOGn59XtBwszGfp96yxLDGITuhhwwE3PjC9cpZvDJU6uLHlBwt1WpswW
         w9b4/x74FlHokCi7P+jw+aNDQFzjaZ39hFxFSjoF12e4ZimHOrXd54zMW8r1SM2ZG8c+
         vjyIo4nf9OKFzI0Bn/+X5QOLF5aam8H7kLxqv9VVFvc+TwEuz7OucBZ2Hq5JhVLy73Ud
         MrDkF6EpPPAzK7mk1MHT15h4lMV2EV4v1sDgfJvVecZWCVkJmCzGmEMY/vzLC9RkuVA9
         94g14l/jptK+nNz71kQKrDsXsSsBeVEWFcE0dCZpnczwfoN7eFdwk/uEnTN9RXJW9C1z
         OYzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G/FZSNf3MhvRb/T7INkTCPjfGTsSzpMNGjUKbnmKyY4=;
        b=teUeBe2rZsFrLsxGeOBZpflDhmhUu2gVnU91UZ3nepDazZGM7SMVzjlqsQb33Tg9tO
         06CRsGKYDC/11VhV4B8njfHrFvk2g04FB0nQTMjLLUQ46iwX0ywPIgsbB4pBIoA48JLc
         9vxc8suUVcaVWGRWElGMQ3eD9RMI8L6rzKmBBEkbcCLMAHwlKeruON3NbQRuEJQ+oYdy
         y5BWOcg05wjFOlv84BNyRekcugMMtJkfcmSVcVFJbALlAGYTNTKK89scLXR9aCZ61qlY
         PqQCKQoipoxDqG0BEP+ttRBGM3moUmLsOgq3WrUqToYPVderJmB9uWFAuxNJWSBnkeHy
         dG6w==
X-Gm-Message-State: APjAAAWLhGY5b960hommkSxfWjsafCPmDmYVTLgUxqMM2LZT2mwVYKO/
        y19mRRYlO2CBnjXyt20gS117Vw==
X-Google-Smtp-Source: APXvYqxAk2+49iT5ulAwFbbjeX3NEhN4U8gky4O0bvN0DFf8z+HPIfNAoXGox+AJBPPi+kYpb9QQKw==
X-Received: by 2002:a5d:474b:: with SMTP id o11mr2250241wrs.255.1581343552430;
        Mon, 10 Feb 2020 06:05:52 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id y20sm646715wmi.25.2020.02.10.06.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 06:05:51 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dmitry Safonov <dima@arista.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH-4.19-stable 2/2] x86/stackframe, x86/ftrace: Add pt_regs frame annotations
Date:   Mon, 10 Feb 2020 14:05:43 +0000
Message-Id: <20200210140543.79641-3-dima@arista.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210140543.79641-1-dima@arista.com>
References: <20200210140543.79641-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

[ Upstream commit ea1ed38dba64b64a245ab8ca1406269d17b99485 ]

When CONFIG_FRAME_POINTER, we should mark pt_regs frames.

Fixes user-visible warning for unwinder (i.e, ftrace's stack tracer):
> WARNING: kernel stack frame pointer at 00000000bceb5183 in Coronavirus:3282 has bad value           (null)
>  unwind stack type:0 next_sp:          (null) mask:0x2 graph_idx:0
>  000000009630aa47: ffffc9000126fdb0 (0xffffc9000126fdb0)
>  0000000020360f53: ffffffff81038e33 (__save_stack_trace+0xcb/0xee)
>  00000000675081f2: 0000000000000000 ...
>  0000000043198fe7: ffffc9000126c000 (0xffffc9000126c000)
>  0000000008a46231: ffffc90001270000 (0xffffc90001270000)
[..]

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
[4.19 backport; added user-visible changelog]
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/x86/kernel/ftrace_32.S | 3 +++
 arch/x86/kernel/ftrace_64.S | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/arch/x86/kernel/ftrace_32.S b/arch/x86/kernel/ftrace_32.S
index 4c8440de3355..83f18e829ac7 100644
--- a/arch/x86/kernel/ftrace_32.S
+++ b/arch/x86/kernel/ftrace_32.S
@@ -9,6 +9,7 @@
 #include <asm/export.h>
 #include <asm/ftrace.h>
 #include <asm/nospec-branch.h>
+#include <asm/frame.h>
 
 #ifdef CC_USING_FENTRY
 # define function_hook	__fentry__
@@ -131,6 +132,8 @@ ENTRY(ftrace_regs_caller)
 	pushl	%ecx
 	pushl	%ebx
 
+	ENCODE_FRAME_POINTER
+
 	movl	12*4(%esp), %eax		/* Load ip (1st parameter) */
 	subl	$MCOUNT_INSN_SIZE, %eax		/* Adjust ip */
 #ifdef CC_USING_FENTRY
diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
index 75f2b36b41a6..24b9abf718e8 100644
--- a/arch/x86/kernel/ftrace_64.S
+++ b/arch/x86/kernel/ftrace_64.S
@@ -9,6 +9,7 @@
 #include <asm/export.h>
 #include <asm/nospec-branch.h>
 #include <asm/unwind_hints.h>
+#include <asm/frame.h>
 
 	.code64
 	.section .entry.text, "ax"
@@ -222,6 +223,8 @@ GLOBAL(ftrace_regs_caller_op_ptr)
 	leaq MCOUNT_REG_SIZE+8*2(%rsp), %rcx
 	movq %rcx, RSP(%rsp)
 
+	ENCODE_FRAME_POINTER
+
 	/* regs go into 4th parameter */
 	leaq (%rsp), %rcx
 
-- 
2.25.0

