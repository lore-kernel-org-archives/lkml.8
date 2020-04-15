Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3BE3C2BB55
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 15:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D32A720767
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 15:37:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="WRxp2lhf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1414777AbgDOPh2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 11:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1414766AbgDOPhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 11:37:23 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B641C061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 08:37:23 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id y3so17629986qky.8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 08:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EeFIVTegln/F+8Ij5JttngNbXaEaGERsEIMec13qZzg=;
        b=WRxp2lhfPadNKlqzoLQV8hxug+VjD1ar3yARtG3bgGXwaV60vtGjZu8bYj/o37CTnb
         zB9cQxs1a26yeWJxcq0kShTttFpZdGdVWGFu2b2NWqZtAUSvKXrdWq1e61oPN65WnmPv
         0wOyIFtOQ+sdg9DpVuH+Y9bIzb1WyusCnIKviWgXUBuPrlUD4FkuIJ8ilAH4pOlXDPs5
         RDFFcI86GJlJlgy1CIJS+sVrjplPRCBwz5CS0669dIORCcYAqaa0aS8nLJF1HkEVDFn8
         jLh4wehfQ/a5bDFy1BtqaBNoIWddIDLPYeSBKvL4Dl5RZV/c/WlhfsftBxtC7yrquuNs
         FE3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EeFIVTegln/F+8Ij5JttngNbXaEaGERsEIMec13qZzg=;
        b=ASafoGU7V7uzUOoV2cD4kXc2qUPTXBV/1q8f2h1CNcOyG6e9yLosLwroS8yBXDhG9u
         DnG5qMej6Rc4+ziOmqCZrj3JweQogBth1g2vG2vYv4kJuzA2JYI/+Pa/p8Ga0JR1ymdt
         FpRaA5ctRpwiNhjTmb3EYgVXUrEgWnu4j42OQYaa4Sf7XiG0KNn99zL+CRJ2JCyDMC28
         cSWo+BHtsE3naPZO7xgfde0nMxXA9g+yAFNojLsJ0bSKGHOOLWvy3PKPEqzg+1GZrSew
         OMTDYxZFJigIX9ohYCCNSroPs1hs1gPyaFBje1B4kMQaZjaVvXFg0DqlxJG3WxtCABcX
         nXiw==
X-Gm-Message-State: AGi0PuZSzfbQtJytIogad2JZbj92kndtE0oeco7dZtXga9mPch2cvByV
        Fi6/rpkrUGrt4omq8D5ltbx3Lg==
X-Google-Smtp-Source: APiQypJ7MP0hT7vNZTsu3/X7j7aM4EOHAvvziUhebjXuHKDZ0gVy14WJy7E9ieTiHCGKFcrHes4q2w==
X-Received: by 2002:a37:9dd6:: with SMTP id g205mr8286950qke.9.1586965042621;
        Wed, 15 Apr 2020 08:37:22 -0700 (PDT)
Received: from ovpn-113-148.phx2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id i20sm12549999qkl.135.2020.04.15.08.37.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Apr 2020 08:37:21 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     paulmck@kernel.org, pbonzini@redhat.com
Cc:     elver@google.com, sean.j.christopherson@intel.com,
        kasan-dev@googlegroups.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH -next] kvm/svm: disable KCSAN for svm_vcpu_run()
Date:   Wed, 15 Apr 2020 11:37:09 -0400
Message-Id: <20200415153709.1559-1-cai@lca.pw>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For some reasons, running a simple qemu-kvm command with KCSAN will
reset AMD hosts. It turns out svm_vcpu_run() could not be instrumented.
Disable it for now.

 # /usr/libexec/qemu-kvm -name ubuntu-18.04-server-cloudimg -cpu host
	-smp 2 -m 2G -hda ubuntu-18.04-server-cloudimg.qcow2

=== console output ===
Kernel 5.6.0-next-20200408+ on an x86_64

hp-dl385g10-05 login:

<...host reset...>

HPE ProLiant System BIOS A40 v1.20 (03/09/2018)
(C) Copyright 1982-2018 Hewlett Packard Enterprise Development LP
Early system initialization, please wait...

Signed-off-by: Qian Cai <cai@lca.pw>
---
 arch/x86/kvm/svm/svm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 2be5bbae3a40..1fdb300e9337 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3278,7 +3278,7 @@ static void svm_cancel_injection(struct kvm_vcpu *vcpu)
 
 bool __svm_vcpu_run(unsigned long vmcb_pa, unsigned long *regs);
 
-static void svm_vcpu_run(struct kvm_vcpu *vcpu)
+static __no_kcsan void svm_vcpu_run(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 
-- 
2.21.0 (Apple Git-122.2)

