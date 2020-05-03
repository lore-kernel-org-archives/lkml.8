Return-Path: <SRS0=5Fkd=6R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FACFC28CBC
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 19:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10528206E9
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 19:50:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729034AbgECTue convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 May 2020 15:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728956AbgECTud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 May 2020 15:50:33 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80126C061A0E;
        Sun,  3 May 2020 12:50:33 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jVKdC-0008ER-Gq; Sun, 03 May 2020 21:50:30 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id DF50B1C0051;
        Sun,  3 May 2020 21:50:29 +0200 (CEST)
Date:   Sun, 03 May 2020 19:50:29 -0000
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/tlb/uv: Add a forward declaration for struct flush_tlb_info
Cc:     Borislav Petkov <bp@suse.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200503103107.3419-1-bp@alien8.de>
References: <20200503103107.3419-1-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <158853542978.8414.4215113723973557504.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     bd1de2a7aace4d1d312fb1be264b8fafdb706208
Gitweb:        https://git.kernel.org/tip/bd1de2a7aace4d1d312fb1be264b8fafdb706208
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Sun, 03 May 2020 12:27:29 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Sun, 03 May 2020 21:43:47 +02:00

x86/tlb/uv: Add a forward declaration for struct flush_tlb_info

... to fix these build warnings:

  In file included from ./arch/x86/include/asm/uv/uv_hub.h:22,
                   from drivers/misc/sgi-gru/grukdump.c:16:
  ./arch/x86/include/asm/uv/uv.h:39:21: warning: ‘struct flush_tlb_info’ declared \
     inside parameter list will not be visible outside of this definition or declaration
     39 |        const struct flush_tlb_info *info);
        |                     ^~~~~~~~~~~~~~
  In file included from ./arch/x86/include/asm/uv/uv_hub.h:22,
                   from drivers/misc/sgi-gru/grutlbpurge.c:28:
  ./arch/x86/include/asm/uv/uv.h:39:21: warning: ‘struct flush_tlb_info’ declared \
    inside parameter list will not be visible outside of this definition or declaration
     39 |        const struct flush_tlb_info *info);
        |                     ^~~~~~~~~~~~~~

  ...

after

  bfe3d8f6313d ("x86/tlb: Restrict access to tlbstate")

restricted access to tlbstate.

Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200503103107.3419-1-bp@alien8.de
---
 arch/x86/include/asm/uv/uv.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/uv/uv.h b/arch/x86/include/asm/uv/uv.h
index 45ea95c..91e088a 100644
--- a/arch/x86/include/asm/uv/uv.h
+++ b/arch/x86/include/asm/uv/uv.h
@@ -8,6 +8,7 @@ enum uv_system_type {UV_NONE, UV_LEGACY_APIC, UV_X2APIC, UV_NON_UNIQUE_APIC};
 
 struct cpumask;
 struct mm_struct;
+struct flush_tlb_info;
 
 #ifdef CONFIG_X86_UV
 #include <linux/efi.h>
