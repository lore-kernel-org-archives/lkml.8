Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE4EC433E3
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 10:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7451A20767
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 10:13:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EFAI8hiR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ayEWGy4c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbgGYKNp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 06:13:45 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43650 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbgGYKNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 06:13:43 -0400
Date:   Sat, 25 Jul 2020 10:13:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595672021;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=20DnNp5cze1/ylzfbRoAtBpyfJOVVlM56wdmug10pm8=;
        b=EFAI8hiRkOYEU/pIsKJ8HXv1zmytq23TOrQBZAFxPuPDX97qP0RLKdXuvALRlQVCmCJ6Pq
        aOcqdF33ZxmK7iFxPJcgjNJEpOCqCkMUzVbLCUX02i7AVv72sWE+R4+Yi0sOwojCECpMX/
        dPc2YzVfIc9CP5JgBqpE+lRja1g60l3mEPi4bJx1wGdJGLbP98uXdWqTMVR8S3d1oMXo7y
        RcP0fkpp6tnGcB3pesqs8Nb2sjU3RVpzF0LFG6hjQrydQ12eCoGqz+f0gBRSyMMwco96rA
        vwlzk6MTAunvQLrX07SzkMzP5zERBVz3SVNryAx+RzDRJxJgXM6sCsV92fxeZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595672021;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=20DnNp5cze1/ylzfbRoAtBpyfJOVVlM56wdmug10pm8=;
        b=ayEWGy4cfMCxXjviVo8hvCHlifgU+aIXU0K1KdJFz2OU2x/H4RNNHpG+/zkX2nuomUBH1h
        6tsKJpc2j/3oB7CQ==
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/ioapic: Remove unused "IOAPIC_AUTO" define
Cc:     Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200724114418.629021-2-mingo@kernel.org>
References: <20200724114418.629021-2-mingo@kernel.org>
MIME-Version: 1.0
Message-ID: <159567202093.4006.10042539580438472603.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     8cd591aeb1d650f79a49d8704c35a78bf18f5de9
Gitweb:        https://git.kernel.org/tip/8cd591aeb1d650f79a49d8704c35a78bf18f5de9
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Fri, 24 Jul 2020 13:44:16 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 25 Jul 2020 12:00:56 +02:00

x86/ioapic: Remove unused "IOAPIC_AUTO" define

Last use was removed more than 5 years ago, in:

   5ad274d41c1b: ("x86/irq: Remove unused old IOAPIC irqdomain interfaces")

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20200724114418.629021-2-mingo@kernel.org
---
 arch/x86/include/asm/io_apic.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/include/asm/io_apic.h b/arch/x86/include/asm/io_apic.h
index fd20a23..a1a26f6 100644
--- a/arch/x86/include/asm/io_apic.h
+++ b/arch/x86/include/asm/io_apic.h
@@ -99,7 +99,6 @@ struct IR_IO_APIC_route_entry {
 struct irq_alloc_info;
 struct ioapic_domain_cfg;
 
-#define IOAPIC_AUTO			-1
 #define IOAPIC_EDGE			0
 #define IOAPIC_LEVEL			1
 
