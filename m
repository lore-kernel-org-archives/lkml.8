Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30BFDC47247
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 17:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DF922184D
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 17:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589045880;
	bh=NWCdWvrnftahbOeAAAbo3rET17oclfuJbv2R+igmKSw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=L5WiR/DH3cWZ5Xp/CLR3loRYvc2rskP7omHLaGdRrc1Bwb1E7qW271h+bySBnagv/
	 eWF+ThcewxIGzZJWRNd4YdNHD0Nm/NrBktbVuxn8XqGOdVwCsshDSaDugxZRwoxUeF
	 ORqxwXa2jM0F7mkDRSJieFZaXVIb/m1zwQWssqdc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728365AbgEIRhF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 13:37:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:54216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726214AbgEIRhB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 13:37:01 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C2A124954;
        Sat,  9 May 2020 17:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589045821;
        bh=NWCdWvrnftahbOeAAAbo3rET17oclfuJbv2R+igmKSw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EtG/aBpsVsONCM9lpAtkKlSgXnAXoTLU9N/4f3oQTCzsWeGpI9sLYopVqj14/3s99
         xNE5Buf/vU0Ma+yMrFL2yv4oXESyQEM+Glax2InGaYVJBLJu7LgSX0MyW/tGYjb1yf
         wwFjUYSoS7yACbKCYzvQ915k5Sml9gODUDNgZKjc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de,
        luto@kernel.org
Cc:     hpa@zytor.com, dave.hansen@intel.com, tony.luck@intel.com,
        ak@linux.intel.com, ravi.v.shankar@intel.com,
        chang.seok.bae@intel.com, Sasha Levin <sashal@kernel.org>
Subject: [PATCH v11 01/18] x86/ptrace: Prevent ptrace from clearing the FS/GS selector
Date:   Sat,  9 May 2020 13:36:38 -0400
Message-Id: <20200509173655.13977-2-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200509173655.13977-1-sashal@kernel.org>
References: <20200509173655.13977-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Chang S. Bae" <chang.seok.bae@intel.com>

When a ptracer writes a ptracee's FS/GS base with a different value, the
selector is also cleared. While this behavior is incorrect as the selector
should be preserved, most userspace applications did not notice that as
they do not use non-zero segments to begin with.

Instead, with this patch, when a tracee sets the base we will let it do
so without clearing the selector.

The change above means that a tracee that already has a selector set
will fail in an attempt to set the base - the change won't stick and the
value will be instead based on the value of the selector. As with the
above, we haven't found userspace that would be affected by this change.

Suggested-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
[sasha: rewrite commit message]
Signed-off-by: Sasha Levin <sashal@kernel.org>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
---
 arch/x86/kernel/ptrace.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
index f0e1ddbc2fd78..cc56efb75d275 100644
--- a/arch/x86/kernel/ptrace.c
+++ b/arch/x86/kernel/ptrace.c
@@ -380,25 +380,12 @@ static int putreg(struct task_struct *child,
 	case offsetof(struct user_regs_struct,fs_base):
 		if (value >= TASK_SIZE_MAX)
 			return -EIO;
-		/*
-		 * When changing the FS base, use do_arch_prctl_64()
-		 * to set the index to zero and to set the base
-		 * as requested.
-		 *
-		 * NB: This behavior is nonsensical and likely needs to
-		 * change when FSGSBASE support is added.
-		 */
-		if (child->thread.fsbase != value)
-			return do_arch_prctl_64(child, ARCH_SET_FS, value);
+		x86_fsbase_write_task(child, value);
 		return 0;
 	case offsetof(struct user_regs_struct,gs_base):
-		/*
-		 * Exactly the same here as the %fs handling above.
-		 */
 		if (value >= TASK_SIZE_MAX)
 			return -EIO;
-		if (child->thread.gsbase != value)
-			return do_arch_prctl_64(child, ARCH_SET_GS, value);
+		x86_gsbase_write_task(child, value);
 		return 0;
 #endif
 	}
-- 
2.20.1

