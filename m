Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2D34C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 16:11:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C215921569
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 16:11:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hf/MOqfv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729224AbgAUQLG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 11:11:06 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45091 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbgAUQLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 11:11:05 -0500
Received: by mail-wr1-f66.google.com with SMTP id j42so3823091wrj.12;
        Tue, 21 Jan 2020 08:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=cEr4BWLn2p/pqLCf/UdrHd/9NDMtfKcezkWAo2kyLx8=;
        b=Hf/MOqfv+5cVe4ENG6tOBbFYEaa3uuETBmTH8Ez1+4Sqyh8fZ0P/sjK/VtDQv+srKR
         1h15GfkXfW28dpL7hmJKoDDidFMjRBBztIPvFkS8T9ORn/lRine2u4Vg2FYz1OTvb+vy
         jBy98yGh1oXOBbEOhajZEIiKsp20RFE284UlKyf9+Pplv2g1T3edsIOz86PGS5eV9JXG
         C1aQLh+6YhCQmZ9DLzTit1uUYMLrVCg9i8Ot0ButQz5N7+PxwNEQ5BvganAcXcO5x3Vi
         7U1f0gyRXJ+icMcIlVynGpo30EWmbJ9UBsFuaID1Tc6pHAwGZ8l1GQOT2sLKF1XZ0IAg
         y4YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=cEr4BWLn2p/pqLCf/UdrHd/9NDMtfKcezkWAo2kyLx8=;
        b=IVCp+nMAWtIyPCu1HmOkZVS749EWMiRjfvwn/VIAO3enjWRiB8f0+sWa1Swn8z4NV6
         BcFAXZrPqDE9/KnSfWHR36NeuZbL6gd3vI9+I/gDsMQm09N68DxNu73Z/Sf6ObvK7WCW
         kfw7T27n9H4W3JfUBLsF2D9fNbZMXIbUSIdWMJbHmcdmDAWJN81NhyNknoRp1ZD0Wsb/
         Wm3DoorDWWvkqZ6kJgZwdugp5BSRaAKNUjNbBn9voa7tMoB3kuYfr5ouTc5fveVn2gzV
         KJ4LrtdF1LZNXk9lwkfuLFSeO5Q92szbKw6fI4mmUOH8IrVMwU0GSkcEZ8LszPKf5OcW
         bWAw==
X-Gm-Message-State: APjAAAVshAH1yNi8Hb15ATYjfLHQiqLJ0QDUQ2XIdnpME1T975/ogfYk
        dxu+YciRhpk3SHrv3lALlsndlluv
X-Google-Smtp-Source: APXvYqwE/Z+q/9o7JJLQM99fbmsXu0/Hhy4yrgNDn1lvUXCMIqIUWWpau4XkB0Ki3Gn/WvkZM1aHSg==
X-Received: by 2002:adf:f5cb:: with SMTP id k11mr6221918wrp.71.1579623063434;
        Tue, 21 Jan 2020 08:11:03 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id p17sm4372742wmk.30.2020.01.21.08.11.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Jan 2020 08:11:02 -0800 (PST)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        bgardon@google.com
Subject: [PATCH] KVM: x86: fix overlap between SPTE_MMIO_MASK and generation
Date:   Tue, 21 Jan 2020 17:11:01 +0100
Message-Id: <1579623061-47141-1-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SPTE_MMIO_MASK overlaps with the bits used to track MMIO
generation number.  A high enough generation number would overwrite the
SPTE_SPECIAL_MASK region and cause the MMIO SPTE to be misinterpreted;
likewise, setting bits 52 and 53 would also cause an incorrect generation
number to be read from the PTE.

Fixes: 6eeb4ef049e7 ("KVM: x86: assign two bits to track SPTE kinds")
Reported-by: Ben Gardon <bgardon@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/mmu.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 57e4dbddba72..e34ca43d9166 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -418,22 +418,25 @@ static inline bool is_access_track_spte(u64 spte)
  * requires a full MMU zap).  The flag is instead explicitly queried when
  * checking for MMIO spte cache hits.
  */
-#define MMIO_SPTE_GEN_MASK		GENMASK_ULL(18, 0)
+#define MMIO_SPTE_GEN_MASK		GENMASK_ULL(17, 0)
 
 #define MMIO_SPTE_GEN_LOW_START		3
 #define MMIO_SPTE_GEN_LOW_END		11
 #define MMIO_SPTE_GEN_LOW_MASK		GENMASK_ULL(MMIO_SPTE_GEN_LOW_END, \
 						    MMIO_SPTE_GEN_LOW_START)
 
-#define MMIO_SPTE_GEN_HIGH_START	52
-#define MMIO_SPTE_GEN_HIGH_END		61
+/* Leave room for SPTE_SPECIAL_MASK.  */
+#define MMIO_SPTE_GEN_HIGH_START	54
+#define MMIO_SPTE_GEN_HIGH_END		62
 #define MMIO_SPTE_GEN_HIGH_MASK		GENMASK_ULL(MMIO_SPTE_GEN_HIGH_END, \
 						    MMIO_SPTE_GEN_HIGH_START)
+
 static u64 generation_mmio_spte_mask(u64 gen)
 {
 	u64 mask;
 
 	WARN_ON(gen & ~MMIO_SPTE_GEN_MASK);
+	BUILD_BUG_ON(MMIO_SPTE_GEN_HIGH_START < PT64_SECOND_AVAIL_BITS_SHIFT);
 
 	mask = (gen << MMIO_SPTE_GEN_LOW_START) & MMIO_SPTE_GEN_LOW_MASK;
 	mask |= (gen << MMIO_SPTE_GEN_HIGH_START) & MMIO_SPTE_GEN_HIGH_MASK;
-- 
1.8.3.1

