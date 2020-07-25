Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D920FC433E3
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 13:53:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B87A620674
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 13:53:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="avbKNi5L";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EobXRciR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbgGYNxk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 09:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726639AbgGYNxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 09:53:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1328FC08C5C0;
        Sat, 25 Jul 2020 06:53:40 -0700 (PDT)
Date:   Sat, 25 Jul 2020 13:53:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595685218;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i7L5Uokminw2hb/ot5HyS/DIJKPw+2NAd2RMYA9W+u0=;
        b=avbKNi5LD7FIeafHqpn/AAejrYmW8v9oK5uhbDi8Pk4qgKLQEo3q8Dxxu2x1DM/NNW5vsg
        AEJBXKcGHTR3DLsGe5SIEJZ4II0tr4dFbvQR8sYtXfK7pW7YBB1oQ4sGEsFP0zpwzYeybz
        238NZubAjyFk3cTJ+eLX+t0qk1Sm2E1KdtVcmnlE22nbt0w5EAQglF2gLBQGBiFmrKvExx
        bkrvaWV0MRzkhGbzNJxCfrG02iDMdpbun/T8AtWoV6ZP+0LBK27RXEeN/Y+4BxNEnNT/qv
        X8cNw5w6wk+k+BlWKrEOuACSFUVotSbqXsZU4d5B3dSFFslYTDAYCCu+zT2pdg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595685218;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i7L5Uokminw2hb/ot5HyS/DIJKPw+2NAd2RMYA9W+u0=;
        b=EobXRciR5eYl+jDPtleNmNlRI3O2xUGSAfF7IwOeOoLqbaTuoAkcrkz3YAYU0mgu4BSgq/
        mr3HUz9Ul6uW/tBg==
From:   "tip-bot2 for Hayato Ohhashi" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/timers] x86/xen/time: Set the X86_FEATURE_TSC_KNOWN_FREQ
 flag in xen_tsc_khz()
Cc:     Hayato Ohhashi <o8@vmm.dev>, Ingo Molnar <mingo@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200721161231.6019-1-o8@vmm.dev>
References: <20200721161231.6019-1-o8@vmm.dev>
MIME-Version: 1.0
Message-ID: <159568521657.4006.636725222719551278.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/timers branch of tip:

Commit-ID:     898ec52d2ba05915aaedcdb21bff2e944c883cb8
Gitweb:        https://git.kernel.org/tip/898ec52d2ba05915aaedcdb21bff2e944c883cb8
Author:        Hayato Ohhashi <o8@vmm.dev>
AuthorDate:    Tue, 21 Jul 2020 16:12:31 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 25 Jul 2020 15:49:41 +02:00

x86/xen/time: Set the X86_FEATURE_TSC_KNOWN_FREQ flag in xen_tsc_khz()

If the TSC frequency is known from the pvclock page,
the TSC frequency does not need to be recalibrated.

We can avoid recalibration by setting X86_FEATURE_TSC_KNOWN_FREQ.

Signed-off-by: Hayato Ohhashi <o8@vmm.dev>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Link: https://lore.kernel.org/r/20200721161231.6019-1-o8@vmm.dev
---
 arch/x86/xen/time.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/xen/time.c b/arch/x86/xen/time.c
index c8897aa..91f5b33 100644
--- a/arch/x86/xen/time.c
+++ b/arch/x86/xen/time.c
@@ -39,6 +39,7 @@ static unsigned long xen_tsc_khz(void)
 	struct pvclock_vcpu_time_info *info =
 		&HYPERVISOR_shared_info->vcpu_info[0].time;
 
+	setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
 	return pvclock_tsc_khz(info);
 }
 
