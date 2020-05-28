Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C202C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 20:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C172207D3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 20:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590696895;
	bh=KO7jFfZjKsu09S4znpcAoZqYM7eD7tNncFeM+2E0bgg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wU8IvAjm3/P7nZek0TR5eUYwO6cztcpzJcjPvxnYTb6IzeiukxUejC18SyibYV4rR
	 6QY5cFkNmWIqnrN5hXUF//PH9zVKMdPfDD9Uo2mFb+CqRkGHJWJnxknMTYcWl6Ryl8
	 EZk3uUpBYK1nUt1ts4DS0gHuY37bqeddyBp/HS10=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407078AbgE1UOx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 16:14:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:41924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407024AbgE1UO2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 16:14:28 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ECF97208DB;
        Thu, 28 May 2020 20:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590696867;
        bh=KO7jFfZjKsu09S4znpcAoZqYM7eD7tNncFeM+2E0bgg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m2pwkA4Pw5oT51aPumiJ9+yjnd9Oy0FqSydKhGIeGPVOHp6WgAC0c2A61E7hitogR
         eYCeZfhgdemceBMw06ec4BaB52nQC+N0/d3dkFT/19YzsJu4MbH0P+kC/ZcTrx5onp
         BjOHmy1ADOnx8FlPQcMvzVBb/NJnXzbpVLci9zN8=
From:   Sasha Levin <sashal@kernel.org>
To:     tglx@linutronix.de, luto@kernel.org, ak@linux.intel.com
Cc:     corbet@lwn.net, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        shuah@kernel.org, gregkh@linuxfoundation.org, tony.luck@intel.com,
        chang.seok.bae@intel.com, dave.hansen@linux.intel.com,
        peterz@infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, jarkko.sakkinen@linux.intel.com,
        "H . Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH v13 08/16] x86/speculation/swapgs: Check FSGSBASE in enabling SWAPGS mitigation
Date:   Thu, 28 May 2020 16:13:54 -0400
Message-Id: <20200528201402.1708239-9-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200528201402.1708239-1-sashal@kernel.org>
References: <20200528201402.1708239-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Luck <tony.luck@intel.com>

Before enabling FSGSBASE the kernel could safely assume that the content
of GS base was a user address. Thus any speculative access as the result
of a mispredicted branch controlling the execution of SWAPGS would be to
a user address. So systems with speculation-proof SMAP did not need to
add additional LFENCE instructions to mitigate.

With FSGSBASE enabled a hostile user can set GS base to a kernel address.
So they can make the kernel speculatively access data they wish to leak
via a side channel. This means that SMAP provides no protection.

Add FSGSBASE as an additional condition to enable the fence-based SWAPGS
mitigation.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/cpu/bugs.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index ed54b3b21c39..487603ea51cd 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -450,14 +450,12 @@ static void __init spectre_v1_select_mitigation(void)
 		 * If FSGSBASE is enabled, the user can put a kernel address in
 		 * GS, in which case SMAP provides no protection.
 		 *
-		 * [ NOTE: Don't check for X86_FEATURE_FSGSBASE until the
-		 *	   FSGSBASE enablement patches have been merged. ]
-		 *
 		 * If FSGSBASE is disabled, the user can only put a user space
 		 * address in GS.  That makes an attack harder, but still
 		 * possible if there's no SMAP protection.
 		 */
-		if (!smap_works_speculatively()) {
+		if (boot_cpu_has(X86_FEATURE_FSGSBASE) ||
+		    !smap_works_speculatively()) {
 			/*
 			 * Mitigation can be provided from SWAPGS itself or
 			 * PTI as the CR3 write in the Meltdown mitigation
-- 
2.25.1

