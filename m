Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90282C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 17:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74CBD20848
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 17:33:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729637AbgBKRdf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 12:33:35 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38119 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729031AbgBKRdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 12:33:35 -0500
Received: by mail-qt1-f195.google.com with SMTP id c24so8564125qtp.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 09:33:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9hy5VYrSpPRzSWsdE9Qh19BgQ81h4mh453g6SqrdWcw=;
        b=Zf8OUKnxYvxruI9lBGY+hN7khWeBLlD/UIgs5IGOdZh+mrEC0XF2dhrinM158ZrEk0
         VYrtbO6dOe1I8+aueX44F7J7wS7wYJhjJ3s/b3xOfozkt/a8Rrcuahd6z8PotFW4/aaa
         W/S7XKZPVB2LczFV9ilPlwe83xXyHjfGbvzrEmyUsak7n/J5c0PCx6K4R4Afo2w4fdZO
         cLqWF+QwsR8VE4jc4q6KCle3YiD3EM4l9RFErNc55be4X8/MwcTiswkHyRrslbRkK3/S
         UyMQyL0p/qGjzhmwWeE1bEN8JovVjivt2ZtQeWTzasha2SGBsgWxcvEPvijGhyFgqyo9
         W3Qw==
X-Gm-Message-State: APjAAAUGGPJgKLY0fwUFBFsZby5bDhtioZtemTkFSfsakF5gBtMtv+8w
        RtuBFelHrBCHVvz9AKu+sBTKVEvu
X-Google-Smtp-Source: APXvYqxJHC+1IudxQfJW5M/z2mq9D0Zw8EKoXL9uXLCUIK3lAUTAdrK4YvezbbfG0xm+SNwvtoBRLA==
X-Received: by 2002:ac8:3fd7:: with SMTP id v23mr3363918qtk.293.1581442414496;
        Tue, 11 Feb 2020 09:33:34 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id k15sm2269903qkk.103.2020.02.11.09.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 09:33:34 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Michael Matz <matz@suse.de>
Subject: [PATCH v2] x86/boot: Use 32-bit (zero-extended) move for z_output_len
Date:   Tue, 11 Feb 2020 12:33:33 -0500
Message-Id: <20200211173333.1722739-1-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200211161739.GE32279@zn.tnic>
References: <20200211161739.GE32279@zn.tnic>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

z_output_len is the size of the decompressed payload (i.e. vmlinux +
vmlinux.relocs) and is generated as an unsigned 32-bit quantity by
mkpiggy.c.

The current movq $z_output_len, %r9 instruction generates a
sign-extended move to %r9. Using movl $z_output_len, %r9d will instead
zero-extend into %r9, which is appropriate for an unsigned 32-bit
quantity. This is also what we already do for z_input_len, the size of
the compressed payload.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
v2: Improve commit message

 arch/x86/boot/compressed/head_64.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 1f1f6c8139b3..03369246a4ff 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -484,7 +484,7 @@ SYM_FUNC_START_LOCAL_NOALIGN(.Lrelocated)
 	leaq	input_data(%rip), %rdx  /* input_data */
 	movl	$z_input_len, %ecx	/* input_len */
 	movq	%rbp, %r8		/* output target address */
-	movq	$z_output_len, %r9	/* decompressed length, end of relocs */
+	movl	$z_output_len, %r9d	/* decompressed length, end of relocs */
 	call	extract_kernel		/* returns kernel location in %rax */
 	popq	%rsi
 
-- 
2.24.1

