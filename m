Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A7D5C43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 09:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCCCF21D92
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 09:47:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tOXsTOXS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8EjZXSM4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725827AbgIKJrj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 05:47:39 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45924 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgIKJrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 05:47:37 -0400
Date:   Fri, 11 Sep 2020 09:47:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599817655;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oTZalsZXjUqJZx49YZ1BHYFN6O49FTtm+F6xL4dmM9A=;
        b=tOXsTOXS4oXwERYtEVbI18z+kKyidcfl6OjYPdhv6cy6+7UiodyDNbYHcSQkMg+hXQDCBX
        7jOxtmvVQoxyU/N+9pQV7VxQmLEsNP1z4M9U2aS/A++maa3T/Y/R8gxwDWbXt+NlpHSEB/
        MHy6DzL8EyEK1hxk2J03bCaTed40WkCbmAckkWjuzQhvPZjOuDvRe3I8xZjU98rr75Hpi2
        dU4oxjF0uESQNo76UhGhp+MQoMrCxzKEIAl38pAk+pWjKJ9yLsFw/gZ5tedoIw5Jsa2cAu
        lfd32fnS6Qc+KM36pDVyInoj7IHaghLSmXenRFvx5mmcPvlfaEtk1ME5pWQ8QQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599817655;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oTZalsZXjUqJZx49YZ1BHYFN6O49FTtm+F6xL4dmM9A=;
        b=8EjZXSM4u4zID4rkQJz4BguDisYMUdXkH2oL8Tu7IMzIQCkWmGy6jgTTPCO6BcGEZRDDqb
        m+DQzVcKnBbt4rBA==
From:   "tip-bot2 for Tony W Wang-oc" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu/centaur: Add Centaur family >=7 CPUs
 initialization support
Cc:     "Tony W Wang-oc" <TonyWWang-oc@zhaoxin.com>,
        Borislav Petkov <bp@suse.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1599562666-31351-3-git-send-email-TonyWWang-oc@zhaoxin.com>
References: <1599562666-31351-3-git-send-email-TonyWWang-oc@zhaoxin.com>
MIME-Version: 1.0
Message-ID: <159981765454.4289.4295139362994948061.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     33b4711df4c1b3aec7c267c60fc24abccfadd40c
Gitweb:        https://git.kernel.org/tip/33b4711df4c1b3aec7c267c60fc24abccfadd40c
Author:        Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
AuthorDate:    Tue, 08 Sep 2020 18:57:46 +08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 11 Sep 2020 10:53:19 +02:00

x86/cpu/centaur: Add Centaur family >=7 CPUs initialization support

Add Centaur family >=7 CPUs specific initialization support.

Signed-off-by: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/1599562666-31351-3-git-send-email-TonyWWang-oc@zhaoxin.com
---
 arch/x86/kernel/cpu/centaur.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/centaur.c b/arch/x86/kernel/cpu/centaur.c
index 5f81158..345f7d9 100644
--- a/arch/x86/kernel/cpu/centaur.c
+++ b/arch/x86/kernel/cpu/centaur.c
@@ -65,6 +65,9 @@ static void init_c3(struct cpuinfo_x86 *c)
 		c->x86_cache_alignment = c->x86_clflush_size * 2;
 		set_cpu_cap(c, X86_FEATURE_REP_GOOD);
 	}
+
+	if (c->x86 >= 7)
+		set_cpu_cap(c, X86_FEATURE_REP_GOOD);
 }
 
 enum {
@@ -95,7 +98,8 @@ static void early_init_centaur(struct cpuinfo_x86 *c)
 	if (c->x86 == 5)
 		set_cpu_cap(c, X86_FEATURE_CENTAUR_MCR);
 #endif
-	if (c->x86 == 6 && c->x86_model >= 0xf)
+	if ((c->x86 == 6 && c->x86_model >= 0xf) ||
+	    (c->x86 >= 7))
 		set_cpu_cap(c, X86_FEATURE_CONSTANT_TSC);
 
 #ifdef CONFIG_X86_64
@@ -204,7 +208,7 @@ static void init_centaur(struct cpuinfo_x86 *c)
 		sprintf(c->x86_model_id, "WinChip %s", name);
 	}
 #endif
-	if (c->x86 == 6)
+	if (c->x86 == 6 || c->x86 >= 7)
 		init_c3(c);
 #ifdef CONFIG_X86_64
 	set_cpu_cap(c, X86_FEATURE_LFENCE_RDTSC);
