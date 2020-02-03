Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A916C35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 23:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00B8620732
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 23:09:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PaZqVy3m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbgBCXJ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 18:09:29 -0500
Received: from mail-pg1-f201.google.com ([209.85.215.201]:41242 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726924AbgBCXJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 18:09:18 -0500
Received: by mail-pg1-f201.google.com with SMTP id r30so10431463pgm.8
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 15:09:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=xl3tRCmUg9jAOtg3vbIi0aqmSxX/oTR7vaT6w//vy0o=;
        b=PaZqVy3m4rRoeYHHiMgnmO1X9LwxYioJlrNTA2svqHK3hggJWYYvBA2MEeaFhf2KVy
         5M+xCl2G5eH8vcm3GcKXUqyewxqVrV4gi93BhUegaQhtPnPRZIiXZfDiNxnYm+B9HfCu
         2yh7HmUwERA28LMmG7wDFzUkMRuNZzrK8OlMHR/CLeqCm7hlvE2/yrMuFGYDDeb9VanP
         xVJ1Ts5xwFXU4agYgO2nocbjenLFEsEurFlcz/MWzFplIWT6QJz1VSv3m0NowHglNymJ
         9phvS4l+TLdRDuMXHoEKuuniTmtfIkweuh5zbgHAey03inGXaQsSSTXC1adRs1670O1i
         W/PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xl3tRCmUg9jAOtg3vbIi0aqmSxX/oTR7vaT6w//vy0o=;
        b=tbPXPTWMdMyKSH36oy7HdWt14Co8w6BGryG4+a9D1XeaUG1FJO0GSDHqAxn8PhQ99s
         TukM/R5xoyj+pPKzrtZaNndZTGMF8rxOJsOlUK5XkDGb9Au7q38bouReyQUKt8MCD/nO
         wRhKI4Qc03tPunxH0X2YjYZzsqlc/jO7xqEE5o3bv5cZWpSt9HpD7v3Bb5bADMnXSQUX
         rMzgpWd2hJl57Kis6zglPX4vHM6HDFQL3eQJq10WCVwZWG8mnqJKpQ1vVYhKluGsQncm
         XFI1OfRYIz9QR6njZC7//e18Bo/LSjWXqFD/W7N22UHBB3Zse7FpKqpO4YhaCevWfh0F
         bMWA==
X-Gm-Message-State: APjAAAU2+N8Ey3LdmzaH0FN0SqLDqkz3xs51EUVW6ZTV2WvuA8MClXad
        gMKqXDSMgf9hr1nBHaQItcg1KCmbXBg5S7MlFmnKVtNYOg9gDBMPnn8jqmvNprU3Bh+VRgWCwbJ
        63c8A/1ZvCa9wgrNxYjZ9UYjtbhSYrmk8muJIxrheQUKicc/dM0QUqiA3Jfda6+AEiRCLPEWm
X-Google-Smtp-Source: APXvYqyWlUjXcJEzuDtebyMcW/5VXbpWItEPNtkEANzEhxDbZ/L228ZficS0209NBH9onSObxOq8XT0lzWXX
X-Received: by 2002:a63:2a06:: with SMTP id q6mr26394796pgq.92.1580771358048;
 Mon, 03 Feb 2020 15:09:18 -0800 (PST)
Date:   Mon,  3 Feb 2020 15:09:10 -0800
In-Reply-To: <20200203230911.39755-1-bgardon@google.com>
Message-Id: <20200203230911.39755-2-bgardon@google.com>
Mime-Version: 1.0
References: <20200203230911.39755-1-bgardon@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH 2/3] kvm: mmu: Separate generating and setting mmio ptes
From:   Ben Gardon <bgardon@google.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Peter Shier <pshier@google.com>,
        Oliver Upton <oupton@google.com>,
        Ben Gardon <bgardon@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Separate the functions for generating MMIO page table entries from the
function that inserts them into the paging structure. This refactoring
will facilitate changes to the MMU sychronization model to use atomic
compare / exchanges (which are not guaranteed to succeed) instead of a
monolithic MMU lock.

No functional change expected.

Tested by running kvm-unit-tests on an Intel Haswell machine. This
commit introduced no new failures.

This commit can be viewed in Gerrit at:
	https://linux-review.googlesource.com/c/virt/kvm/kvm/+/2359

Signed-off-by: Ben Gardon <bgardon@google.com>
Reviewed-by: Oliver Upton <oupton@google.com>
Reviewed-by: Peter Shier <pshier@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index a9c593dec49bf..b81010d0edae1 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -451,9 +451,9 @@ static u64 get_mmio_spte_generation(u64 spte)
 	return gen;
 }
 
-static void mark_mmio_spte(struct kvm_vcpu *vcpu, u64 *sptep, u64 gfn,
-			   unsigned int access)
+static u64 make_mmio_spte(struct kvm_vcpu *vcpu, u64 gfn, unsigned int access)
 {
+
 	u64 gen = kvm_vcpu_memslots(vcpu)->generation & MMIO_SPTE_GEN_MASK;
 	u64 mask = generation_mmio_spte_mask(gen);
 	u64 gpa = gfn << PAGE_SHIFT;
@@ -464,6 +464,17 @@ static void mark_mmio_spte(struct kvm_vcpu *vcpu, u64 *sptep, u64 gfn,
 	mask |= (gpa & shadow_nonpresent_or_rsvd_mask)
 		<< shadow_nonpresent_or_rsvd_mask_len;
 
+	return mask;
+}
+
+static void mark_mmio_spte(struct kvm_vcpu *vcpu, u64 *sptep, u64 gfn,
+			   unsigned int access)
+{
+	u64 mask = make_mmio_spte(vcpu, gfn, access);
+	unsigned int gen = get_mmio_spte_generation(mask);
+
+	access = mask & ACC_ALL;
+
 	trace_mark_mmio_spte(sptep, gfn, access, gen);
 	mmu_spte_set(sptep, mask);
 }
-- 
2.25.0.341.g760bfbb309-goog

