Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C49C55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 514A92075A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587550752;
	bh=ha+CAQ7iEhlPF52xa10ZLaHKRCJQ1ZS6XYdgwGYgaWw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uLkZjxOtDUq499rtbZl15mGmRbUosOd4yh3gN2a/8ocoZrIAlFj/7gVPl5i9n95IP
	 1bH471SNOz4ni7uS2iHAIjyCL7DoipNNrkDaACMlGNYLRJ/OCXiuzZ8EvbpqDIHnUH
	 jOd51SCjEPuP3qMHnLMoBbKHda0GAcFcfn9Af3IU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730050AbgDVKTL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:19:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:54602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729919AbgDVKSK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:18:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CE1B2075A;
        Wed, 22 Apr 2020 10:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587550690;
        bh=ha+CAQ7iEhlPF52xa10ZLaHKRCJQ1ZS6XYdgwGYgaWw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DCkjrSXvni1A9F5d+K4eJ792g+miATOzt4tNRGV/CGV5RAOeBShKzy3hrWLfzv+6e
         snAK/LB3XCv6M+SLBLyKk/7JYtnWXlMX8ePTyLF2mPcTduWEwxdjtdPhjmeT3yx54P
         cR544kNxjmI7C+oUpl87vFhRgVl1qGS/gbKW8Ww0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, linuxppc-dev@ozlabs.org,
        David Gibson <david@gibson.dropbear.id.au>,
        Paul Mackerras <paulus@ozlabs.org>,
        Michael Roth <mdroth@linux.vnet.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 054/118] KVM: PPC: Book3S HV: Fix H_CEDE return code for nested guests
Date:   Wed, 22 Apr 2020 11:56:55 +0200
Message-Id: <20200422095040.897701454@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200422095031.522502705@linuxfoundation.org>
References: <20200422095031.522502705@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Roth <mdroth@linux.vnet.ibm.com>

[ Upstream commit 1f50cc1705350a4697923203fedd7d8fb1087fe2 ]

The h_cede_tm kvm-unit-test currently fails when run inside an L1 guest
via the guest/nested hypervisor.

  ./run-tests.sh -v
  ...
  TESTNAME=h_cede_tm TIMEOUT=90s ACCEL= ./powerpc/run powerpc/tm.elf -smp 2,threads=2 -machine cap-htm=on -append "h_cede_tm"
  FAIL h_cede_tm (2 tests, 1 unexpected failures)

While the test relates to transactional memory instructions, the actual
failure is due to the return code of the H_CEDE hypercall, which is
reported as 224 instead of 0. This happens even when no TM instructions
are issued.

224 is the value placed in r3 to execute a hypercall for H_CEDE, and r3
is where the caller expects the return code to be placed upon return.

In the case of guest running under a nested hypervisor, issuing H_CEDE
causes a return from H_ENTER_NESTED. In this case H_CEDE is
specially-handled immediately rather than later in
kvmppc_pseries_do_hcall() as with most other hcalls, but we forget to
set the return code for the caller, hence why kvm-unit-test sees the
224 return code and reports an error.

Guest kernels generally don't check the return value of H_CEDE, so
that likely explains why this hasn't caused issues outside of
kvm-unit-tests so far.

Fix this by setting r3 to 0 after we finish processing the H_CEDE.

RHBZ: 1778556

Fixes: 4bad77799fed ("KVM: PPC: Book3S HV: Handle hypercalls correctly when nested")
Cc: linuxppc-dev@ozlabs.org
Cc: David Gibson <david@gibson.dropbear.id.au>
Cc: Paul Mackerras <paulus@ozlabs.org>
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/kvm/book3s_hv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 36abbe3c346df..e2183fed947d4 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -3623,6 +3623,7 @@ int kvmhv_p9_guest_entry(struct kvm_vcpu *vcpu, u64 time_limit,
 		if (trap == BOOK3S_INTERRUPT_SYSCALL && !vcpu->arch.nested &&
 		    kvmppc_get_gpr(vcpu, 3) == H_CEDE) {
 			kvmppc_nested_cede(vcpu);
+			kvmppc_set_gpr(vcpu, 3, 0);
 			trap = 0;
 		}
 	} else {
-- 
2.20.1



