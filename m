Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C672C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 09:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C33C207EA
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 09:04:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SdTflJSr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="32sDY8bv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729849AbgIDJEt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 05:04:49 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59728 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728588AbgIDJEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 05:04:48 -0400
Date:   Fri, 04 Sep 2020 09:04:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599210286;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3pXhkGE/5YJ/Y/c1n9+hliktj5eiIH9x3Kz+uL2J5Dg=;
        b=SdTflJSr/USF0WFd7zpzgpkBsW4wizFldlirmwjwv4L1gNQ3YNy8eRUdqw1cWxDDgAoDVs
        xiYwgpGJm+/io8a1HaegYPxfEu6MO3Dp0AgsneJSQ4A6FSgFt2rpAzDr4S8DOOWUaLTwT7
        LFqHYpRhlm+U7GbdqRInaO26QbOrxIVlxC/0bKVO59Gul1vlD6ppwJJ9yTFAdVeqcwoOc8
        9XiZETRqSuHKCY75gxBOWkO93Q5FgLkoQnf28DHoO+gXmdIVyEy1bn1yWeo81UVAGFbo6/
        oQ/3So6zKWdxA+lYrnWMIcyE+jHJ/l2MxKxAyumZM7hnQyT713fqKbjWGb6hdA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599210286;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3pXhkGE/5YJ/Y/c1n9+hliktj5eiIH9x3Kz+uL2J5Dg=;
        b=32sDY8bvnYXnTuhsM+CVl+qV80Q454fIaRV6PtrcjZN80/lDGwcXKeSD271TT5iEgalKz4
        Jq4V3l24CzxNzIDA==
From:   "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/entry/64: Do not include inst.h in calling.h
Cc:     Uros Bizjak <ubizjak@gmail.com>, Borislav Petkov <bp@suse.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200827171735.93825-1-ubizjak@gmail.com>
References: <20200827171735.93825-1-ubizjak@gmail.com>
MIME-Version: 1.0
Message-ID: <159921028558.20229.1866185910671534802.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     eb3621798bcdd34ba480109bac357ba6a784d3e2
Gitweb:        https://git.kernel.org/tip/eb3621798bcdd34ba480109bac357ba6a784d3e2
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Thu, 27 Aug 2020 19:17:35 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 04 Sep 2020 10:59:21 +02:00

x86/entry/64: Do not include inst.h in calling.h

inst.h was included in calling.h solely to instantiate the RDPID macro.
The usage of RDPID was removed in

  6a3ea3e68b8a ("x86/entry/64: Do not use RDPID in paranoid entry to accomodate KVM")

so remove the include.

Fixes: 6a3ea3e68b8a ("x86/entry/64: Do not use RDPID in paranoid entry to accomodate KVM")
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200827171735.93825-1-ubizjak@gmail.com
---
 arch/x86/entry/calling.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index ae9b0d4..07a9331 100644
--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -6,7 +6,6 @@
 #include <asm/percpu.h>
 #include <asm/asm-offsets.h>
 #include <asm/processor-flags.h>
-#include <asm/inst.h>
 
 /*
 
