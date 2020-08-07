Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94722C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 01:23:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B48B206B5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 01:23:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dbhUZ4Ad"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbgHGBXZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 21:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbgHGBXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 21:23:24 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB751C061575
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 18:23:23 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id e24so428045pfl.13
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 18:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=yC5jYNAZ2LkpJAay2cVTHRBar69NJbTlP8o5uIXB6/g=;
        b=dbhUZ4AdddRmmfM5MZeqGAPEKz9pXzfFnWWvVwOcBdaX6SgkOX4BLQ1qmjaI2Vv/RE
         lI810NuPrU8cba8i0YMXSkn1Ohkr+DXWdTHizneQgoirhCfkZmKKIefeuWQqwM6d5p46
         5ScI/Z3lLN/VuwpppPg52ErsiS6PbguN4Kopt6kIWm0mDIDHjOFb1h27WrIDbRLRHP2v
         z/Nof0CVwzKkv+LKjBfCzacBwcSdazISEWZKgHJuaT4pwK6Fsdwez25g9dP4eiWSO7hC
         qCfmyEflLkUT16wBzHw+kRlqSt1miYrr3Hnn1UbC94AfE7oJaTUr/YGJlqf9blZYhnkg
         PqRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=yC5jYNAZ2LkpJAay2cVTHRBar69NJbTlP8o5uIXB6/g=;
        b=cI0cQyrU1oAYezGsz8lEJd8DRaEd2Fr7IEv/qTLfH3mfdMz/+HTubitvo6JfbpqGu0
         LLUlkQP/0Vy68k8eDa0OeNvuWLkppcTrol3SAUMwiWgkXxpXLCiBWkD229rxKBL0Z1cE
         6yZnM+DahjBNed6gzI6kdOpvkBxQB09N6Dvtfj45UvsRzxvHYwq9kggALr+bnG98b37z
         J20Qd0F+iWcSQov6eZjA0woW/A3HPQfDxPqH+mPVlOcqzTRNVcUeVa/M1/gprAhtsUcX
         gfGXW7g001GNq1WqypfkyaqWmHm+tCXOo4JgTGEpZp5C7M/+BYUXhR0Rh/zRLtbXIlQp
         bX2w==
X-Gm-Message-State: AOAM530YWd8sBHVP8z/twnEC7gGEawRNHkMkqdNaCmPKf7aWHF1Y6ram
        VBJ7h0vU2J+6vj3UWQyMZm5yvbWb
X-Google-Smtp-Source: ABdhPJzX3Q/EZzrTsL+psZOfV6Qe3oGEelBpSTkxN0LrcRBxKGusOhF5mZvdOdGnh5l977FkZGlm/weK
X-Received: by 2002:a17:90a:6343:: with SMTP id v3mr11046672pjs.163.1596763402902;
 Thu, 06 Aug 2020 18:23:22 -0700 (PDT)
Date:   Thu,  6 Aug 2020 18:23:03 -0700
Message-Id: <20200807012303.3769170-1-cfir@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.236.gb10cc79966-goog
Subject: [PATCH] KVM: SVM: Mark SEV launch secret pages as dirty.
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
This matches the logic in sev_launch_update().

Signed-off-by: Cfir Cohen <cfir@google.com>
---
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
2.28.0.163.g6104cc2f0b6-goog

