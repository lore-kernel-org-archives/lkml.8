Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07AE9C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 04:20:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE383206DB
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 04:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592194804;
	bh=Y2RvKPnylS/ZWj8tTVA/D7TQVwDwOOA4nHGSoPR4hIA=;
	h=Date:From:To:Cc:Subject:Reply-To:List-ID:From;
	b=wv0zDSTaTR7xJr68dzahFXe6GNtFnWrOhWc1kYOuB1u9SOQ1Kqe2dnNYvDGCpLP5z
	 SCpPVt0olqWVZnL4jVUu+xlkudE6pPyQbdWtHDmjQaqRJ+siAseMey2ANg9mk0zoAW
	 g4hC9JUg6ry7iXI0GqKvufSqfviAAaoa6HvREW2U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbgFOEUD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 00:20:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:58572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725648AbgFOEUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 00:20:02 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F83C2065F;
        Mon, 15 Jun 2020 04:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592194802;
        bh=Y2RvKPnylS/ZWj8tTVA/D7TQVwDwOOA4nHGSoPR4hIA=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=iNXx7kMRmsVbiFZXPIoKnyhtxEiO3QGJcWi22FmQInh/dEEAQpGlUNURZuWmRRlFe
         gqTz2E2gD6tLAgXmbWmx7h+kJqtGfvVewP1H+KF+tODRUc0pkx36xHY0vdJa6tGf0X
         OgvdFrbMw4tLIdOObsEifKBjmwm1yX9gkUVCcrmw=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 464793522F74; Sun, 14 Jun 2020 21:20:02 -0700 (PDT)
Date:   Sun, 14 Jun 2020 21:20:02 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     cai@lca.pw, pbonzini@redhat.com, elver@google.com
Cc:     linux-kernel@vger.kernel.org
Subject: fastpath_t?  __no_kcsan? Both?
Message-ID: <20200615042002.GA14788@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I get the following conflict when rebasing 39a8c47635b0 ("kvm/svm:
Disable KCSAN for svm_vcpu_run()") onto v5.8-rc1:

<<<<<<< 6c410247efb2d3907b508a2448ab9ab1c86d938c
static fastpath_t svm_vcpu_run(struct kvm_vcpu *vcpu)
=======
static __no_kcsan void svm_vcpu_run(struct kvm_vcpu *vcpu)
>>>>>>> kvm/svm: Disable KCSAN for svm_vcpu_run()

The "natural" resolution would be this:

static fastpath_t __no_kcsan void svm_vcpu_run(struct kvm_vcpu *vcpu)

But does that make sense?

I have dropped this commit for the time being.  Please either
let me know the proper resolution or submit a fresh patch,
your choice.

						Thanx, Paul

------------------------------------------------------------------------

commit 39a8c47635b00ebf9a3c52d9ca357fff5a8b36e3
Author: Qian Cai <cai@lca.pw>
Date:   Wed Apr 15 11:37:09 2020 -0400

    kvm/svm: Disable KCSAN for svm_vcpu_run()
    
    For some reasons, running a simple qemu-kvm command with KCSAN will
    reset AMD hosts. It turns out svm_vcpu_run() could not be instrumented.
    This commit therefore disables it for now.
    
     # /usr/libexec/qemu-kvm -name ubuntu-18.04-server-cloudimg -cpu host
            -smp 2 -m 2G -hda ubuntu-18.04-server-cloudimg.qcow2
    
    === console output ===
    Kernel 5.6.0-next-20200408+ on an x86_64
    
    hp-dl385g10-05 login:
    
    <...host reset...>
    
    HPE ProLiant System BIOS A40 v1.20 (03/09/2018)
    (C) Copyright 1982-2018 Hewlett Packard Enterprise Development LP
    Early system initialization, please wait...
    
    Acked-by: Paolo Bonzini <pbonzini@redhat.com>
    Signed-off-by: Qian Cai <cai@lca.pw>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 38f6aee..c6f89e4 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3280,7 +3280,7 @@ static void svm_cancel_injection(struct kvm_vcpu *vcpu)
 
 void __svm_vcpu_run(unsigned long vmcb_pa, unsigned long *regs);
 
-static void svm_vcpu_run(struct kvm_vcpu *vcpu)
+static __no_kcsan void svm_vcpu_run(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 
