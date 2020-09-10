Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CCF0C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FBA520C09
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:34:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AbIhSCPR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MJftior1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730435AbgIJJeb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 05:34:31 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38812 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730434AbgIJJXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 05:23:21 -0400
Date:   Thu, 10 Sep 2020 09:22:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599729748;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9ari3lIczztYXW1/eaJraFBBVNKB4nf4bETwAR0kfLE=;
        b=AbIhSCPRlCkewjyvSMZb4YLJWeacfWMcEWaFcgF/yG5iiJaQZdHR4JU8NShi/rQfDGsFZ0
        XX2FpUSnRM3noNAcsG0K/yRkQOpyLQuPpELxWyK3/a3nBfDD9ROCOw5myik+wDyRie3Ckn
        Pg97Hlc0YkMJF9IkTPDXkKuCGWiF++6H+ZVYcnuj/qXhUdzQ2d3B5nBqppLaZpR0TyZ6eu
        hL5L8hB5MAR4Wx/fO65tK9W1yZqQuYgjHqiP7HLBTNWJm/4hLN9wZD9WlIxuxEyP3z+MGG
        SyqoHzC2AtzNjC6+sI/0ZDIx5TVFs4SWmoK8U6v/jglA20COa/JSVhWjT1qDGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599729748;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9ari3lIczztYXW1/eaJraFBBVNKB4nf4bETwAR0kfLE=;
        b=MJftior1AZU3DJLnK6WSL3K3C4acDnKVx7j5Z+rsG7d9r5EBZszI/f3z2e2PGpy9mrZ9rA
        AK03uOtDspTtQcDA==
From:   "tip-bot2 for Joerg Roedel" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/seves] x86/boot/compressed/64: Disable red-zone usage
Cc:     Joerg Roedel <jroedel@suse.de>, Borislav Petkov <bp@suse.de>,
        Kees Cook <keescook@chromium.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200907131613.12703-13-joro@8bytes.org>
References: <20200907131613.12703-13-joro@8bytes.org>
MIME-Version: 1.0
Message-ID: <159972974769.20229.1011179749041704677.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/seves branch of tip:

Commit-ID:     6ba0efa46047936afa81460489cfd24bc95dd863
Gitweb:        https://git.kernel.org/tip/6ba0efa46047936afa81460489cfd24bc95dd863
Author:        Joerg Roedel <jroedel@suse.de>
AuthorDate:    Mon, 07 Sep 2020 15:15:13 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 07 Sep 2020 19:45:25 +02:00

x86/boot/compressed/64: Disable red-zone usage

The x86-64 ABI defines a red-zone on the stack:

  The 128-byte area beyond the location pointed to by %rsp is considered
  to be reserved and shall not be modified by signal or interrupt
  handlers. Therefore, functions may use this area for temporary data
  that is not needed across function calls. In particular, leaf
  functions may use this area for their entire stack frame, rather than
  adjusting the stack pointer in the prologue and epilogue. This area is
  known as the red zone.

This is not compatible with exception handling, because the IRET frame
written by the hardware at the stack pointer and the functions to handle
the exception will overwrite the temporary variables of the interrupted
function, causing undefined behavior. So disable red-zones for the
pre-decompression boot code.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Link: https://lkml.kernel.org/r/20200907131613.12703-13-joro@8bytes.org
---
 arch/x86/boot/compressed/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 3962f59..5343079 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -32,7 +32,7 @@ KBUILD_CFLAGS := -m$(BITS) -O2
 KBUILD_CFLAGS += -fno-strict-aliasing $(call cc-option, -fPIE, -fPIC)
 KBUILD_CFLAGS += -DDISABLE_BRANCH_PROFILING
 cflags-$(CONFIG_X86_32) := -march=i386
-cflags-$(CONFIG_X86_64) := -mcmodel=small
+cflags-$(CONFIG_X86_64) := -mcmodel=small -mno-red-zone
 KBUILD_CFLAGS += $(cflags-y)
 KBUILD_CFLAGS += -mno-mmx -mno-sse
 KBUILD_CFLAGS += -ffreestanding
