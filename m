Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2037EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 19:30:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09AE72065D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 19:30:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FQ3NX3uo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aJZIrF/H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbgGHT37 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 15:29:59 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53214 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbgGHT35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 15:29:57 -0400
Message-Id: <20200708192934.191497962@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594236595;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=/nv6nHzdsyg94XWmVtMVQp/C0kZO0fIGgRkzjMjCxgM=;
        b=FQ3NX3uop0fQ6cRE/oxT9FDRqLNLe36vgY72etGnzDWTYYZuduK3Al5w19HG2D/3TQYN59
        wutPaqwvRvK/GppXAyvsNegJLpjL9YeYlfR8szLb0C1zBnARBnfw86P+h6npj/An5WTOTA
        4r0tpboKPnm2e8ZQ7On19Fg0qf5ZAq8jq2fO7A5Oa0Y2U3vkEBopCFh3sLF2XEMI/rVERD
        Vc8in9xesEC1IWEWndI5vCqYiRP0AQIkprxuBZI+np3hZk+2soIAsi4k9MNLdX8zTVnM1Q
        cPtBfNRpTlCVGBMWPwM+r/j4y656RcVq6J/MUG019Wv8vxyk77ZL5q3CSeJXxQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594236595;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=/nv6nHzdsyg94XWmVtMVQp/C0kZO0fIGgRkzjMjCxgM=;
        b=aJZIrF/Hz07SquSNCsWLxarHJgA5rREMlcfOEaVHWMIpEAUApomFX0+hhtYiRYqvh53CLP
        DliejEphflG3eiCg==
Date:   Wed, 08 Jul 2020 21:28:06 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org
Subject: [patch 2/3] x86/entry: Mark check_user_regs() noinstr
References: <20200708192804.911958542@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's called from the non-instrumentable section.

Fixes: c9c26150e61d ("x86/entry: Assert that syscalls are on the right stack")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/entry/common.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -46,7 +46,7 @@
 #include <trace/events/syscalls.h>
 
 /* Check that the stack and regs on entry from user mode are sane. */
-static void check_user_regs(struct pt_regs *regs)
+static noinstr void check_user_regs(struct pt_regs *regs)
 {
 	if (IS_ENABLED(CONFIG_DEBUG_ENTRY)) {
 		/*

