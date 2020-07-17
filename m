Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AFABC433EB
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 14:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 000652070E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 14:51:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1f5yPvRb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ketaDGn4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbgGQOvo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 10:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbgGQOvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 10:51:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD95C0619D4;
        Fri, 17 Jul 2020 07:51:12 -0700 (PDT)
Date:   Fri, 17 Jul 2020 14:51:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594997470;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sCV66bIWbj9bW/e9Rm/WFb+wjxpmEEgN/5RGLVTClm0=;
        b=1f5yPvRb55wGM8RifZ8GNwkDXCdztVx5RqF8j/K+T+S+o1eyAFG+hPFxDtyA7MlIZkiqYz
        ELLGmhFyp9FQUFYUDqkvP6gcZB8hmwGPutdxjQAgTI6a9OT41ZW7QPQ9uFOMe4Y54uvjKw
        bbuu55099KRzyA5BDHfBXOi0kv4fDFLUbcg7h9rMW/va7rPrJzw4HghXAK9oUI6UQCXO3v
        STr702bQkF5BvXNXClDv8YnDgy+5PSoSs8FzEv51UdKal8HLRksMDjfZgNOkeuwc4SHXVF
        Tzrr0Ysz7IHr17b16b97E6KNDaKjPknEKRbom/Dna3y4+6k9esZh90Dm73KNJg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594997470;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sCV66bIWbj9bW/e9Rm/WFb+wjxpmEEgN/5RGLVTClm0=;
        b=ketaDGn4H9IPsa8VxEIMY3VqRcjOrJg8i+E6rUgDZX13LgQAjBC/Jecd+VQ0elEdpEP7N7
        viIhIRyGCEpowcCg==
From:   "tip-bot2 for steve.wahl@hpe.com" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/platform] x86/platform/uv: Remove vestigial mention of UV1
 platform from bios header
Cc:     Steve Wahl <steve.wahl@hpe.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200713212955.435951508@hpe.com>
References: <20200713212955.435951508@hpe.com>
MIME-Version: 1.0
Message-ID: <159499746948.4006.1353014005142720587.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam: Yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/platform branch of tip:

Commit-ID:     5d662537510e09512e842b41352f8ad0427c1fe9
Gitweb:        https://git.kernel.org/tip/5d662537510e09512e842b41352f8ad0427c1fe9
Author:        steve.wahl@hpe.com <steve.wahl@hpe.com>
AuthorDate:    Mon, 13 Jul 2020 16:30:02 -05:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 17 Jul 2020 16:47:46 +02:00

x86/platform/uv: Remove vestigial mention of UV1 platform from bios header

Remove UV1 reference as UV1 is not longer supported by HPE.

Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20200713212955.435951508@hpe.com

---
 arch/x86/include/asm/uv/bios.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/uv/bios.h b/arch/x86/include/asm/uv/bios.h
index 2fcc3ac..70050d0 100644
--- a/arch/x86/include/asm/uv/bios.h
+++ b/arch/x86/include/asm/uv/bios.h
@@ -72,7 +72,7 @@ struct uv_gam_range_entry {
 };
 
 #define	UV_SYSTAB_SIG			"UVST"
-#define	UV_SYSTAB_VERSION_1		1	/* UV1/2/3 BIOS version */
+#define	UV_SYSTAB_VERSION_1		1	/* UV2/3 BIOS version */
 #define	UV_SYSTAB_VERSION_UV4		0x400	/* UV4 BIOS base version */
 #define	UV_SYSTAB_VERSION_UV4_1		0x401	/* + gpa_shift */
 #define	UV_SYSTAB_VERSION_UV4_2		0x402	/* + TYPE_NVRAM/WINDOW/MBOX */
