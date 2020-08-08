Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D4C9C433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 00:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA7C92177B
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 00:37:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZbCKesn1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgHHAhv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 20:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbgHHAhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 20:37:51 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F48C061756
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 17:37:51 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id d3so3121701pfh.17
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 17:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=qAWBHy/YDwId+EQliujOzvzt7GbHETyF7ZMnV7H8r4I=;
        b=ZbCKesn1vTPY1aHBijollqglxQcxq5k+YuhetvBKh0GklCvIt4ThY4Rk5dGH5baAd9
         bwda8nPqy9p8Zq4zs2JhLSHt5LBithwKbXS5HtyfG2yGdghjNPUkP98CDX9/Q1rAmhCZ
         q1c4WyB2E+9DTAKUwKSmL+PgduqDo50uVJiULU5t2dPkXaCkcSVxDRBpz5YDO4Q2oCPH
         kYkrjOg2SzYtL58uL4bRhc3Z0Amf+NDPgv5ZfAvxBGMV/MiXOeL8aWfsKGV815Mt0Vjj
         FCIH2gRlXfn+MtVJKxhcrk65rxyNGDkJ3UepUyryM5VSrtZKAGiSB/CM0PjWqUzXWfB3
         wXfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qAWBHy/YDwId+EQliujOzvzt7GbHETyF7ZMnV7H8r4I=;
        b=EkuGADG/7RVm+e+C/jXwx64CvRseReD5md9kBT7sNkooLJIiVr6+Ucjpe+QF+b8OU/
         ZFWlMvYPFsUZU1nAdwHUdLmKUjHx0owQ7g5l/9ztvph3A9MuT+44qkNmBOdP0gtQAEI0
         iwhRLaAANJQbDW++CmcmZMWLS0BfLCTdK+2A3ETTobhBTTrB6rTKl5JrKjCZXxEv4drp
         hpgomukLQSz0RoXEJZo8txpw7JAP4vWL6SXPgT0bH3vUsHNSHfa9+IymzLqcPbWnknzE
         ihaUzAPsH7k2ASwRrtichoYsECuJ1TavnoPUSAARc9VtJgpcEqVs26l/VIAY8dD4Teow
         MnVw==
X-Gm-Message-State: AOAM532ewfj0Dft1PtIXLdYpNCI+PaHfXoxst8uOOfnD/U0fAEfpDD2E
        OPOHA143bPJrVnluchNHJdd8TPJo
X-Google-Smtp-Source: ABdhPJz2ntewJM4SNFgvJLgp2ChRpBaoUTmjHDtlsktdAVNUMdI1n/Z7oy9JwmiOKi4FiLZ1l0AT6kas
X-Received: by 2002:a17:90b:4a0a:: with SMTP id kk10mr15916872pjb.30.1596847070432;
 Fri, 07 Aug 2020 17:37:50 -0700 (PDT)
Date:   Fri,  7 Aug 2020 17:37:46 -0700
In-Reply-To: <20200807012303.3769170-1-cfir@google.com>
Message-Id: <20200808003746.66687-1-cfir@google.com>
Mime-Version: 1.0
References: <20200807012303.3769170-1-cfir@google.com>
X-Mailer: git-send-email 2.28.0.236.gb10cc79966-goog
Subject: [PATCH v2] KVM: SVM: Mark SEV launch secret pages as dirty.
From:   Cfir Cohen <cfir@google.com>
To:     "kvm @ vger . kernel . org" <kvm@vger.kernel.org>,
        Lendacky Thomas <thomas.lendacky@amd.com>,
        Singh Brijesh <brijesh.singh@amd.com>
Cc:     Grimm Jon <Jon.Grimm@amd.com>,
        David Rientjes <rientjes@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Cfir Cohen <cfir@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The LAUNCH_SECRET command performs encryption of the
launch secret memory contents. Mark pinned pages as
dirty, before unpinning them.
This matches the logic in sev_launch_update_data().

Signed-off-by: Cfir Cohen <cfir@google.com>
---
Changelog since v1:
 - Updated commit message.

 arch/x86/kvm/svm/sev.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 5573a97f1520..37c47d26b9f7 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -850,7 +850,7 @@ static int sev_launch_secret(struct kvm *kvm, struct kvm_sev_cmd *argp)
 	struct kvm_sev_launch_secret params;
 	struct page **pages;
 	void *blob, *hdr;
-	unsigned long n;
+	unsigned long n, i;
 	int ret, offset;
 
 	if (!sev_guest(kvm))
@@ -863,6 +863,14 @@ static int sev_launch_secret(struct kvm *kvm, struct kvm_sev_cmd *argp)
 	if (!pages)
 		return -ENOMEM;
 
+	/*
+	 * The LAUNCH_SECRET command will perform in-place encryption of the
+	 * memory content (i.e it will write the same memory region with C=1).
+	 * It's possible that the cache may contain the data with C=0, i.e.,
+	 * unencrypted so invalidate it first.
+	 */
+	sev_clflush_pages(pages, n);
+
 	/*
 	 * The secret must be copied into contiguous memory region, lets verify
 	 * that userspace memory pages are contiguous before we issue command.
@@ -908,6 +916,11 @@ static int sev_launch_secret(struct kvm *kvm, struct kvm_sev_cmd *argp)
 e_free:
 	kfree(data);
 e_unpin_memory:
+	/* content of memory is updated, mark pages dirty */
+	for (i = 0; i < n; i++) {
+		set_page_dirty_lock(pages[i]);
+		mark_page_accessed(pages[i]);
+	}
 	sev_unpin_memory(kvm, pages, n);
 	return ret;
 }
-- 
2.28.0.236.gb10cc79966-goog

