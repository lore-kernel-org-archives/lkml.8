Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A435CC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 14:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7891822210
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 14:49:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ab0zaBJz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MKS8n47H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbgIAOtI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 10:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727778AbgIALt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 07:49:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B6D7C061251;
        Tue,  1 Sep 2020 04:48:02 -0700 (PDT)
Date:   Tue, 01 Sep 2020 11:47:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598960878;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M8l0IYkR9lCXARzVcRZa526IrTnP/rBGVKVMQNtfffs=;
        b=ab0zaBJzKo9CmDRi02xrbm+gnkWe8J/+w+saqtYnvnQwfttUPIlNyRvQ5RiMwmEuRd0ejg
        7LlaAfq8MkSzBopGRnqC3pfZ5yIIQnavTJfJBKuejdMHD6+8QjU06Yb4JA+pS9jAK82AXB
        ToxbitAve353b/Xcuy1ZPUYYy/3Lzfi6FkJVE7awXP2hZ0Z/rzFbUQFM4T0KfITA0KB+ER
        HJ6UfvWR7BV/cn8kRU6SQ18CXQn80X/D1pUJBfcov/hkAu/tJcMhmwtbUbDQ1GckZ03xma
        oWwS3SlQ4GECEbfgGgqkwzPcflRtLY/jqHo+XL7T+xcMikYVpOvKrZjnautj4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598960878;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M8l0IYkR9lCXARzVcRZa526IrTnP/rBGVKVMQNtfffs=;
        b=MKS8n47H4Z5BBJb/DfVNo7RJWUc1kvx4xEQnPOoCzFdBod2pGlvAlb48XqfrzKhXSJW+Nt
        2nalC9WCLv2Pu/AA==
From:   "tip-bot2 for Kees Cook" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/build] arm64/build: Use common DISCARDS in linker script
Cc:     Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@kernel.org>,
        Will Deacon <will@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200821194310.3089815-12-keescook@chromium.org>
References: <20200821194310.3089815-12-keescook@chromium.org>
MIME-Version: 1.0
Message-ID: <159896087749.20229.1643947752770611995.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/build branch of tip:

Commit-ID:     2883352bf801d093a04f269800b48bb8aa2515fb
Gitweb:        https://git.kernel.org/tip/2883352bf801d093a04f269800b48bb8aa2515fb
Author:        Kees Cook <keescook@chromium.org>
AuthorDate:    Fri, 21 Aug 2020 12:42:52 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 01 Sep 2020 09:50:36 +02:00

arm64/build: Use common DISCARDS in linker script

Use the common DISCARDS rule for the linker script in an effort to
regularize the linker script to prepare for warning on orphaned
sections. Additionally clean up left-over no-op macros.

Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Will Deacon <will@kernel.org>
Link: https://lore.kernel.org/r/20200821194310.3089815-12-keescook@chromium.org
---
 arch/arm64/kernel/vmlinux.lds.S | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index c2b8426..082e9ef 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -6,6 +6,7 @@
  */
 
 #define RO_EXCEPTION_TABLE_ALIGN	8
+#define RUNTIME_DISCARD_EXIT
 
 #include <asm-generic/vmlinux.lds.h>
 #include <asm/cache.h>
@@ -88,10 +89,8 @@ SECTIONS
 	 * matching the same input section name.  There is no documented
 	 * order of matching.
 	 */
+	DISCARDS
 	/DISCARD/ : {
-		EXIT_CALL
-		*(.discard)
-		*(.discard.*)
 		*(.interp .dynamic)
 		*(.dynsym .dynstr .hash .gnu.hash)
 	}
