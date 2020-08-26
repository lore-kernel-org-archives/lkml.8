Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D41C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 19:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAF062078A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 19:03:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Qv+6OHYs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JOst60nv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbgHZTDK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 15:03:10 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60952 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbgHZTDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 15:03:01 -0400
Date:   Wed, 26 Aug 2020 19:02:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598468579;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Rh3Fopmqrv0gUWnOzPVmUZGvvt1WTGWCWjoL0FOQD4U=;
        b=Qv+6OHYsJHH6wbJKCgu49hEsDfQL7FKrB04snApdOErKazDkzAl5ca37m/oKw1f7J/PuWf
        NgeY2S/CKwpzYmJCBfMGOoAan6A8pzQxnTIoMX0le39c8RCZKfju2ps8DJy+b7euTtFduc
        PprnFCqruPfKBwfMmDmU8Sb/Fx6vxHgSG0kRSHnO871miozM+hPQO38Jp5DlLI0JvoOD9v
        gyGEadW6obWggVejbjDsTTNAsrgW7Erj2B3efB0BaeIIQJjfZU5G+pjCU8Qm40RiEGGl8a
        tRH+VIonq/9INv6KvwzHhIcCAk+a1uwstH+Nn/2wEpcNCN0VQZ9v45od1ISWBw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598468579;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Rh3Fopmqrv0gUWnOzPVmUZGvvt1WTGWCWjoL0FOQD4U=;
        b=JOst60nvuzm3evgCk42mznWrImnFMaaQaF5JQY1Hig5NjBGT2wZ6RONnl/6TpWPTyXUyaY
        DUNamBiChICIA0BA==
From:   "tip-bot2 for Andy Lutomirski" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fsgsbase] selftests/x86/fsgsbase: Reap a forgotten child
Cc:     Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <e7700a503f30e79ab35a63103938a19893dbeff2.1598461151.git.luto@kernel.org>
References: <e7700a503f30e79ab35a63103938a19893dbeff2.1598461151.git.luto@kernel.org>
MIME-Version: 1.0
Message-ID: <159846857840.389.4609772271418366087.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/fsgsbase branch of tip:

Commit-ID:     ab2dd173330a3f07142e68cd65682205036cd00f
Gitweb:        https://git.kernel.org/tip/ab2dd173330a3f07142e68cd65682205036cd00f
Author:        Andy Lutomirski <luto@kernel.org>
AuthorDate:    Wed, 26 Aug 2020 10:00:45 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 26 Aug 2020 20:54:17 +02:00

selftests/x86/fsgsbase: Reap a forgotten child

The ptrace() test forgot to reap its child.  Reap it.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/e7700a503f30e79ab35a63103938a19893dbeff2.1598461151.git.luto@kernel.org
---
 tools/testing/selftests/x86/fsgsbase.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/x86/fsgsbase.c b/tools/testing/selftests/x86/fsgsbase.c
index 9983195..0056e25 100644
--- a/tools/testing/selftests/x86/fsgsbase.c
+++ b/tools/testing/selftests/x86/fsgsbase.c
@@ -517,6 +517,9 @@ static void test_ptrace_write_gsbase(void)
 
 END:
 	ptrace(PTRACE_CONT, child, NULL, NULL);
+	wait(&status);
+	if (!WIFEXITED(status))
+		printf("[WARN]\tChild didn't exit cleanly.\n");
 }
 
 int main()
