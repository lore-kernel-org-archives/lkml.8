Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45E4BC35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 23:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 180F0214AF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 23:04:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="DlC/YWxi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727690AbgBEXEZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 18:04:25 -0500
Received: from mail.kmu-office.ch ([178.209.48.109]:58544 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727479AbgBEXEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 18:04:24 -0500
Received: from zyt.lan (unknown [IPv6:2a02:169:3df5::564])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id E61CB5C406B;
        Thu,  6 Feb 2020 00:04:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1580943862;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=DZNuiK7w/00m3I4pnoL0TtavGvcrDZzYn/LYhbpeC6M=;
        b=DlC/YWxi1nm6AhayCHoS4PbhS1UfiJVXuV/UooWr/VCYqzfV8mgqmpUzDw+AtiRIbkgmEb
        89WbQG0Uzi1j7zI9lSm5F1NtrGq4XtdQkvUWVmO+nGs5WxD6U+vvslVCiSlzR6/vOg0HqW
        wV3eU01xQU7yEBLrNNN92VWNmycp23A=
From:   Stefan Agner <stefan@agner.ch>
To:     linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com, Stefan Agner <stefan@agner.ch>
Subject: [PATCH] ARM: kexec: drop invalid assembly argument
Date:   Wed,  5 Feb 2020 23:59:26 +0100
Message-Id: <ab67c7c5a1f96af6d22240e57fc27ba766d4193d.1580943526.git.stefan@agner.ch>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The tst menomic has only a single #<const> argument in Thumb mode. There
is an ARM variant which allows to write #<const> as #<byte>, #<rot>
which probably is where the current syntax comes from.

It seems that binutils does not care about the additional parameter.
Clang however complains in Thumb2 mode:
arch/arm/kernel/relocate_kernel.S:28:12: error: too many operands for
instruction
 tst r3,#1,0
           ^

Drop the unnecessary parameter. This fixes building this file in Thumb2
mode with the Clang integrated assembler.

Link: https://github.com/ClangBuiltLinux/linux/issues/770
Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/kernel/relocate_kernel.S | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/kernel/relocate_kernel.S b/arch/arm/kernel/relocate_kernel.S
index 7eaa2ae7aff5..72a08786e16e 100644
--- a/arch/arm/kernel/relocate_kernel.S
+++ b/arch/arm/kernel/relocate_kernel.S
@@ -25,26 +25,26 @@ ENTRY(relocate_new_kernel)
 	ldr	r3, [r0],#4
 
 	/* Is it a destination page. Put destination address to r4 */
-	tst	r3,#1,0
+	tst	r3,#1
 	beq	1f
 	bic	r4,r3,#1
 	b	0b
 1:
 	/* Is it an indirection page */
-	tst	r3,#2,0
+	tst	r3,#2
 	beq	1f
 	bic	r0,r3,#2
 	b	0b
 1:
 
 	/* are we done ? */
-	tst	r3,#4,0
+	tst	r3,#4
 	beq	1f
 	b	2f
 
 1:
 	/* is it source ? */
-	tst	r3,#8,0
+	tst	r3,#8
 	beq	0b
 	bic r3,r3,#8
 	mov r6,#1024
-- 
2.25.0

