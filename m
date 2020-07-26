Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B89D8C433E4
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 10:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97BB120714
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 10:50:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="y9ZXo8Xk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f2Moh6DJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727917AbgGZKuo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 06:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727875AbgGZKul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 06:50:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9250CC0619D4;
        Sun, 26 Jul 2020 03:50:41 -0700 (PDT)
Date:   Sun, 26 Jul 2020 10:50:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595760637;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zrlK7UBr/R0xhEz/C7qxzeQOeIf5VixvkcPH/ZfTl34=;
        b=y9ZXo8XkN8mJ59ACFWeWBppk333YZYbE3ozSSpZUsgw2coPMmhql0uDZPIdG5QqBxFgl79
        Bv+IldvxA5XCFdvaNb6nOYq3EnwFsVQssoVwkXVjg1yZdz3/0Zp/U5j8D3w1GJAuBkjbtp
        RjgGX38N5Elud7NeF2RmzilZ+EAtengAbqItt0bkTbo87kIPvmKC7r5d8yIAKVx6g83Q4T
        lt8Fl17C1M1mEEgzF417BDX0SiPZ1pn0FuB9jY7dp7eGjV2/VePgQWN7o6h1jEPFEuolMZ
        0q3gW/bO8ZmigaR2ePR8qUauxwaV7I2jsq8+HtLEv2NINoPWstdDU3vSj8Bp0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595760637;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zrlK7UBr/R0xhEz/C7qxzeQOeIf5VixvkcPH/ZfTl34=;
        b=f2Moh6DJQ+A989waBvPKzcF5PR9CsaSIcEMOWD+e7+ITMqYUHx75qLTM9Qyn/KOuyXZOuj
        WfLcvSZm/TS1HhDQ==
From:   "tip-bot2 for Randy Dunlap" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86: cmpxchg_32.h: Delete duplicated word
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200726004124.20618-3-rdunlap@infradead.org>
References: <20200726004124.20618-3-rdunlap@infradead.org>
MIME-Version: 1.0
Message-ID: <159576063699.4006.15255903262427036343.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     8b9fd48eb73ec854c2877735e96c91127cc78a1d
Gitweb:        https://git.kernel.org/tip/8b9fd48eb73ec854c2877735e96c91127cc78a1d
Author:        Randy Dunlap <rdunlap@infradead.org>
AuthorDate:    Sat, 25 Jul 2020 17:41:23 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 26 Jul 2020 12:47:22 +02:00

x86: cmpxchg_32.h: Delete duplicated word

Delete the repeated word "you".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20200726004124.20618-3-rdunlap@infradead.org
---
 arch/x86/include/asm/cmpxchg_32.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/cmpxchg_32.h b/arch/x86/include/asm/cmpxchg_32.h
index 1a2eafc..0a7fe03 100644
--- a/arch/x86/include/asm/cmpxchg_32.h
+++ b/arch/x86/include/asm/cmpxchg_32.h
@@ -3,7 +3,7 @@
 #define _ASM_X86_CMPXCHG_32_H
 
 /*
- * Note: if you use set64_bit(), __cmpxchg64(), or their variants, you
+ * Note: if you use set64_bit(), __cmpxchg64(), or their variants,
  *       you need to test for the feature in boot_cpu_data.
  */
 
