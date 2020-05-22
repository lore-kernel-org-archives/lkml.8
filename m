Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C66A2C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 12:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A80AE206C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 12:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="RPoE0F31"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729922AbgEVMxW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 08:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729828AbgEVMw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 08:52:26 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF266C08C5C2
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 05:52:25 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id k5so12452381lji.11
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 05:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pE6faVejbkAIUEORvfpEBGX8dWE5OEtccf8+g3bpDfA=;
        b=RPoE0F31yzBfOvWe7SLr/WKR/C2Sx4Gh7bwAeclpxq0/Vb+GNjxAJuEDdywAhAV+rG
         LPSwpxjdhaPrO6tPK9kLyU9lN+J2ICMlxxas0V3l5kGBMo3GGtqma7ZKf2e7FtyzTZqS
         KG5R8274XsAkdGpxCT1EQsqp3V4eoAOQ4oqvJ4wtWaqB9Ir9xHzwM7bFrSpATnNTj6er
         1QQiE6gfmsKimMLDlHETHNkpXH6oKGpbXDEkowiisx49AcyncgVvc25A2cOV7mVWKXHV
         79ghSiISaygzuziCXm5Lg5/wF/eQqqmW0HwJzq/V+XbVuTqhqr1DrqhesngodJsRG9EX
         SMCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pE6faVejbkAIUEORvfpEBGX8dWE5OEtccf8+g3bpDfA=;
        b=WfobP79lgay02GqKHdaQ1w3UAXt3JtKGhWFJ+MKX+xjk5NtGY3IaPrnpHyxoxzSEL+
         /hO5Uc0HHoUvaZHJb7Dh7SfrdscXUSxU3DBwGkx9wLGavkt66gIQBMcQ07kiTO61w2ky
         tPrdaqtXUeZggtGoEuMVCSGh5OvUIsYWgsfGmZnzjYOq5kjT9mxoKOMWqm+b1lvso4gM
         5HLOK+/T1yilQuvK00npfH68nDI7flOUPdHv/5ISV+58Wos0QMeRz9zRj0d1df4ney6i
         p5dJcTwgzzY9Qi1/iuTxLY4PoQAd/kAYkmR5xmR7H4ijox7RrjhspmDM5EgEANYgIoJg
         fcMw==
X-Gm-Message-State: AOAM532ZBpay0ZZyl3xpFyBEn7ZC++3tnUl6QjlVASusLq99/pFg1ZCo
        hdoj9SpbliI+d+ODpHRpnPkqKg==
X-Google-Smtp-Source: ABdhPJxgFPaCjAkcKRCcIN9VQB3EgCJQ/VVHg9h7HUrXezHSNTMlbVQq98oVAeqSL+RKdW5J2/HvFQ==
X-Received: by 2002:a05:651c:2ce:: with SMTP id f14mr7217431ljo.87.1590151944358;
        Fri, 22 May 2020 05:52:24 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id t22sm2303766ljk.11.2020.05.22.05.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 05:52:22 -0700 (PDT)
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
X-Google-Original-From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Received: by box.localdomain (Postfix, from userid 1000)
        id 0ABFA10205B; Fri, 22 May 2020 15:52:20 +0300 (+03)
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Will Drewry <wad@chromium.org>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "Kleen, Andi" <andi.kleen@intel.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [RFC 13/16] x86/kvmclock: Share hvclock memory with the host
Date:   Fri, 22 May 2020 15:52:11 +0300
Message-Id: <20200522125214.31348-14-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200522125214.31348-1-kirill.shutemov@linux.intel.com>
References: <20200522125214.31348-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hvclock is shared between the guest and the hypervisor. It has to be
accessible by host.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/kernel/kvmclock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 34b18f6eeb2c..ac6c2abe0d0f 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -253,7 +253,7 @@ static void __init kvmclock_init_mem(void)
 	 * hvclock is shared between the guest and the hypervisor, must
 	 * be mapped decrypted.
 	 */
-	if (sev_active()) {
+	if (sev_active() || kvm_mem_protected()) {
 		r = set_memory_decrypted((unsigned long) hvclock_mem,
 					 1UL << order);
 		if (r) {
-- 
2.26.2

