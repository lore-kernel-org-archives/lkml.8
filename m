Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ADD6C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 08:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70F232073E
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 08:05:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BuuC+9cV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QZc1N9HV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728751AbgGAIFa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 04:05:30 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36284 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728645AbgGAIEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 04:04:54 -0400
Date:   Wed, 01 Jul 2020 08:04:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1593590691;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IvMAvsvlOHXgIaP9uXRm4GizD/b8qi+pyRXSRNr1ifw=;
        b=BuuC+9cVaJUDz+bA/n3jYi0FrVzY4I69SarTQ626MqpznD2z6IZSIl92CLJw45lX/+4xAo
        yF92yRdN9IFUfsA0c3npmIA2HuHdKd9bT0Ty4cQE/NQsIKrh1ewFsG2T1JFGW+FscskWKi
        tfHxxHnHny4/t00OsCdhRhJNMQ5MqHulRsbuwJ+r7EaFBwcmsON9zTx5EmkVkAjQIVq4HR
        EfJamwrYg7EiwdB3pe4r9QzJEMo69+eVunA28gWJz6l31YE2lh6i9mZsZ2Qs88sAokzJGE
        lokAOyObY6jc0a64IMx9K9I1h/22njceqF0xQDwNRxpHg+ba7YlOfX/pMCUvLg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1593590691;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IvMAvsvlOHXgIaP9uXRm4GizD/b8qi+pyRXSRNr1ifw=;
        b=QZc1N9HVDh7AbIIjn4sQZpo2XK6g9OzF+fpwQ1H7vjzxhSIVVOXiaJinENO4nHjT5Erewq
        RZi7N6+KfU3CG6Cg==
From:   "tip-bot2 for Andy Lutomirski" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] selftests/x86/syscall_nt: Add more flag combinations
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <12924e2fe2c5826568b7fc9436d85ca7f5eb1743.1593191971.git.luto@kernel.org>
References: <12924e2fe2c5826568b7fc9436d85ca7f5eb1743.1593191971.git.luto@kernel.org>
MIME-Version: 1.0
Message-ID: <159359069113.4006.10361236382568138234.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     e4ef7de160c6b12639c4fc49bcacb25b860ac76d
Gitweb:        https://git.kernel.org/tip/e4ef7de160c6b12639c4fc49bcacb25b860ac76d
Author:        Andy Lutomirski <luto@kernel.org>
AuthorDate:    Fri, 26 Jun 2020 10:21:14 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 01 Jul 2020 10:00:26 +02:00

selftests/x86/syscall_nt: Add more flag combinations

Add EFLAGS.AC to the mix.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/12924e2fe2c5826568b7fc9436d85ca7f5eb1743.1593191971.git.luto@kernel.org

---
 tools/testing/selftests/x86/syscall_nt.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/testing/selftests/x86/syscall_nt.c b/tools/testing/selftests/x86/syscall_nt.c
index 02309a1..f060534 100644
--- a/tools/testing/selftests/x86/syscall_nt.c
+++ b/tools/testing/selftests/x86/syscall_nt.c
@@ -73,6 +73,12 @@ int main(void)
 	printf("[RUN]\tSet NT and issue a syscall\n");
 	do_it(X86_EFLAGS_NT);
 
+	printf("[RUN]\tSet AC and issue a syscall\n");
+	do_it(X86_EFLAGS_AC);
+
+	printf("[RUN]\tSet NT|AC and issue a syscall\n");
+	do_it(X86_EFLAGS_NT | X86_EFLAGS_AC);
+
 	/*
 	 * Now try it again with TF set -- TF forces returns via IRET in all
 	 * cases except non-ptregs-using 64-bit full fast path syscalls.
@@ -80,8 +86,17 @@ int main(void)
 
 	sethandler(SIGTRAP, sigtrap, 0);
 
+	printf("[RUN]\tSet TF and issue a syscall\n");
+	do_it(X86_EFLAGS_TF);
+
 	printf("[RUN]\tSet NT|TF and issue a syscall\n");
 	do_it(X86_EFLAGS_NT | X86_EFLAGS_TF);
 
+	printf("[RUN]\tSet AC|TF and issue a syscall\n");
+	do_it(X86_EFLAGS_AC | X86_EFLAGS_TF);
+
+	printf("[RUN]\tSet NT|AC|TF and issue a syscall\n");
+	do_it(X86_EFLAGS_NT | X86_EFLAGS_AC | X86_EFLAGS_TF);
+
 	return nerrs == 0 ? 0 : 1;
 }
