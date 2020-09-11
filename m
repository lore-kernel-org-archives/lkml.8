Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9DD5C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 09:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41A7B22224
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 09:47:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Zkm/Pv7K";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Su8t3uId"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725834AbgIKJrk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 05:47:40 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45932 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgIKJri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 05:47:38 -0400
Date:   Fri, 11 Sep 2020 09:47:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599817655;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EoOdcw0nRDi+MO1u6dQUcRv24XIvpeGDZkOA9fR5tSg=;
        b=Zkm/Pv7K3NZgA/mzcCzSptQgIZxeCbUCO3x+s61foLQnL2zdichA+c/Oqrq9Tm/SeOgTTy
        3hfP2xdnjG/Y6dEdv1da0vntB/035npBIeTsb2gCEdEdpKFlJuChfBov9+4kwfIJTlmTDq
        Zo4Sov9ubvXST69WMFQRanf3QNNywpleUpCD9PC1W7qDUhk+5jcdEkMSFw/SU8V+sca7SS
        2RSN7ZxuQwDZ4KguE5NCz6NK49AibMYTQrsEJBv1Hy/6XE/sP+ojUQNgEwy4gcNPwfdxlh
        aa+V6sc5FVyBFZoBo8mBCeEtRAy95/JrLMe1Q24e8901m6uL5txMNkOod6Urzg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599817655;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EoOdcw0nRDi+MO1u6dQUcRv24XIvpeGDZkOA9fR5tSg=;
        b=Su8t3uIdds1He1ADkhS23APFTDR3PPldafIKlU9dq8oqM25Pw880zVMa+oEqSD75MTflie
        GPnKYNyROLrJJ2Ag==
From:   "tip-bot2 for Tony W Wang-oc" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu/centaur: Replace two-condition switch-case
 with an if statement
Cc:     "Tony W Wang-oc" <TonyWWang-oc@zhaoxin.com>,
        Borislav Petkov <bp@suse.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1599562666-31351-2-git-send-email-TonyWWang-oc@zhaoxin.com>
References: <1599562666-31351-2-git-send-email-TonyWWang-oc@zhaoxin.com>
MIME-Version: 1.0
Message-ID: <159981765495.4289.653078167108642899.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     8687bdc04128b2bd16faaae11db10128ad0da7b8
Gitweb:        https://git.kernel.org/tip/8687bdc04128b2bd16faaae11db10128ad0da7b8
Author:        Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
AuthorDate:    Tue, 08 Sep 2020 18:57:45 +08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 11 Sep 2020 10:50:01 +02:00

x86/cpu/centaur: Replace two-condition switch-case with an if statement

Use a normal if statements instead of a two-condition switch-case.

 [ bp: Massage commit message. ]

Signed-off-by: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/1599562666-31351-2-git-send-email-TonyWWang-oc@zhaoxin.com
---
 arch/x86/kernel/cpu/centaur.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/cpu/centaur.c b/arch/x86/kernel/cpu/centaur.c
index c5cf336..5f81158 100644
--- a/arch/x86/kernel/cpu/centaur.c
+++ b/arch/x86/kernel/cpu/centaur.c
@@ -90,18 +90,14 @@ enum {
 
 static void early_init_centaur(struct cpuinfo_x86 *c)
 {
-	switch (c->x86) {
 #ifdef CONFIG_X86_32
-	case 5:
-		/* Emulate MTRRs using Centaur's MCR. */
+	/* Emulate MTRRs using Centaur's MCR. */
+	if (c->x86 == 5)
 		set_cpu_cap(c, X86_FEATURE_CENTAUR_MCR);
-		break;
 #endif
-	case 6:
-		if (c->x86_model >= 0xf)
-			set_cpu_cap(c, X86_FEATURE_CONSTANT_TSC);
-		break;
-	}
+	if (c->x86 == 6 && c->x86_model >= 0xf)
+		set_cpu_cap(c, X86_FEATURE_CONSTANT_TSC);
+
 #ifdef CONFIG_X86_64
 	set_cpu_cap(c, X86_FEATURE_SYSENTER32);
 #endif
@@ -145,9 +141,8 @@ static void init_centaur(struct cpuinfo_x86 *c)
 			set_cpu_cap(c, X86_FEATURE_ARCH_PERFMON);
 	}
 
-	switch (c->x86) {
 #ifdef CONFIG_X86_32
-	case 5:
+	if (c->x86 == 5) {
 		switch (c->x86_model) {
 		case 4:
 			name = "C6";
@@ -207,12 +202,10 @@ static void init_centaur(struct cpuinfo_x86 *c)
 			c->x86_cache_size = (cc>>24)+(dd>>24);
 		}
 		sprintf(c->x86_model_id, "WinChip %s", name);
-		break;
+	}
 #endif
-	case 6:
+	if (c->x86 == 6)
 		init_c3(c);
-		break;
-	}
 #ifdef CONFIG_X86_64
 	set_cpu_cap(c, X86_FEATURE_LFENCE_RDTSC);
 #endif
