Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57FCBC3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 22:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E4BC2073D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 22:55:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kdy1Oy0u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbgCEWza (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 17:55:30 -0500
Received: from mail-yw1-f73.google.com ([209.85.161.73]:45473 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbgCEWza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 17:55:30 -0500
Received: by mail-yw1-f73.google.com with SMTP id q187so640815ywg.12
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 14:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=jeiv1jAncPDzHne66XaZP4GiBWG3GQA5weKZvN0zA0o=;
        b=kdy1Oy0uXJCE1+kO+LPetei9qACt9fs8O8C1RBjAJdyUQJPprRNSx53fHdHIQZ105Y
         BqCF5Ivg0kH2LJK1+zaBBzM8qhBQNWa0fesL0vjjN7wf32shwLVaW/d5kcFYoYhRDgp3
         Pdhgl2yKEiEkDP7stUh50ZkYS4LZC2AnHe+yof/+OMsK8mL3E3CyISsD7DnqMsONAujm
         y1zwq0fpSxjAa7RaB1h8Sn7WUsqJPQdKB5YLFmgvm8VyQV06rA2mLDZm1KPsU68QxGYd
         g5ji7YntvkqphMkC6Qa5LqTh634OZ9WEjv4uJAiFTMtK2smmZNUz82QUkEktdWS2lhKH
         yilQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=jeiv1jAncPDzHne66XaZP4GiBWG3GQA5weKZvN0zA0o=;
        b=dJv3CtZWxKd4HXcpfUusDW+UZz6LOEm5f1BgpPRtB8PVDGJp+WqY/C8rdQNBVqLwaL
         fV+4A82VCnz6f7o6u18vxy+t1nkgL4FbJ6OluDECTQWfzgHY5tFeImIY6f798Q7/8yrt
         /RpndcskhwWGiWlo/GQZzczXFWaNgS4zk1skve5g9FuSS0IIL9D0cpZZnv4mIFQ+h5VC
         KSU26MscOwoWPm185o0wvkuulmmHHcC1EpK4PqZoXSR2uDACR9E2LxFEXGcGsKPnZB76
         NsPMrCHMU7ayBgD6NKih1QsR8tAV3ydjRIUGsKOfGy9hpWP2Nquq5D7qEyCe5/mfevuX
         53nA==
X-Gm-Message-State: ANhLgQ0Tsne/mQwDCyyztGoBmWmsVg8uLwTY+RhJILeYOPDDtbfDMIsx
        +f488HddUeK1pVWl5cczIL3Pr4uS4g==
X-Google-Smtp-Source: ADFU+vu60Lus6uSHEBfNkUZ3xXtpeBay92XILAjLAfjHZcYKS3QoOxm4vMm0F5mcnLfkx2moENdu8HsuUg==
X-Received: by 2002:a81:47c3:: with SMTP id u186mr915204ywa.40.1583448929500;
 Thu, 05 Mar 2020 14:55:29 -0800 (PST)
Date:   Thu,  5 Mar 2020 23:54:43 +0100
Message-Id: <20200305225443.64426-1-jannh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH] x86/entry/64: Fix unwind hint for rewind_stack_do_exit
From:   Jann Horn <jannh@google.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The leaq instruction in rewind_stack_do_exit moves the stack pointer
directly below the pt_regs at the top of the task stack before calling
do_exit(). Tell the unwinder to expect pt_regs.

Signed-off-by: Jann Horn <jannh@google.com>
---
 arch/x86/entry/entry_64.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index f2bb91e87877..2393c803fd8c 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1739,7 +1739,7 @@ SYM_CODE_START(rewind_stack_do_exit)
 
 	movq	PER_CPU_VAR(cpu_current_top_of_stack), %rax
 	leaq	-PTREGS_SIZE(%rax), %rsp
-	UNWIND_HINT_FUNC sp_offset=PTREGS_SIZE
+	UNWIND_HINT_REGS
 
 	call	do_exit
 SYM_CODE_END(rewind_stack_do_exit)

base-commit: 9f65ed5fe41ce08ed1cb1f6a950f9ec694c142ad
-- 
2.25.0.265.gbab2e86ba0-goog

