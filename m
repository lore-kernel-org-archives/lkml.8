Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF406C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 17:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2A6220746
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 17:27:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728619AbgEFR16 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 13:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727872AbgEFR15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 13:27:57 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64761C061A0F;
        Wed,  6 May 2020 10:27:57 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jWNpo-0000SB-Ei; Wed, 06 May 2020 19:27:52 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id EAE0C1C0092;
        Wed,  6 May 2020 19:27:51 +0200 (CEST)
Date:   Wed, 06 May 2020 17:27:51 -0000
From:   "tip-bot2 for Kim Phillips" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu/amd: Make erratum #1054 a legacy erratum
Cc:     Andrew Cooper <andrew.cooper3@citrix.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Borislav Petkov <bp@suse.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200417143356.26054-1-kim.phillips@amd.com>
References: <20200417143356.26054-1-kim.phillips@amd.com>
MIME-Version: 1.0
Message-ID: <158878607182.8414.16785943595732058442.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     3e2c1fd2022ccce96b6a05a6ab519d65769ee320
Gitweb:        https://git.kernel.org/tip/3e2c1fd2022ccce96b6a05a6ab519d65769ee320
Author:        Kim Phillips <kim.phillips@amd.com>
AuthorDate:    Fri, 17 Apr 2020 09:33:56 -05:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 06 May 2020 19:18:24 +02:00

x86/cpu/amd: Make erratum #1054 a legacy erratum

Commit

  21b5ee59ef18 ("x86/cpu/amd: Enable the fixed Instructions Retired
		 counter IRPERF")

mistakenly added erratum #1054 as an OS Visible Workaround (OSVW) ID 0.
Erratum #1054 is not OSVW ID 0 [1], so make it a legacy erratum.

There would never have been a false positive on older hardware that
has OSVW bit 0 set, since the IRPERF feature was not available.

However, save a couple of RDMSR executions per thread, on modern
system configurations that correctly set non-zero values in their
OSVW_ID_Length MSRs.

[1] Revision Guide for AMD Family 17h Models 00h-0Fh Processors. The
revision guide is available from the bugzilla link below.

Fixes: 21b5ee59ef18 ("x86/cpu/amd: Enable the fixed Instructions Retired counter IRPERF")
Reported-by: Andrew Cooper <andrew.cooper3@citrix.com>
Signed-off-by: Kim Phillips <kim.phillips@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200417143356.26054-1-kim.phillips@amd.com
Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
---
 arch/x86/kernel/cpu/amd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 547ad7b..6437381 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -1142,7 +1142,7 @@ static const int amd_erratum_383[] =
 
 /* #1054: Instructions Retired Performance Counter May Be Inaccurate */
 static const int amd_erratum_1054[] =
-	AMD_OSVW_ERRATUM(0, AMD_MODEL_RANGE(0x17, 0, 0, 0x2f, 0xf));
+	AMD_LEGACY_ERRATUM(AMD_MODEL_RANGE(0x17, 0, 0, 0x2f, 0xf));
 
 
 static bool cpu_has_amd_erratum(struct cpuinfo_x86 *cpu, const int *erratum)
