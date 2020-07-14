Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C24D3C433E6
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 18:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A079822282
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 18:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594752936;
	bh=fPe011OLFDAOSHoiDlWJVfsAghT2Lhh8LX4jqLUHjJs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rxQ+0zwVM4eyrIbL2t0ewUemppVzDa9TjMPGCIPNgpZADyvxUONEU+tXm2+Ydhuyo
	 2GyrHzsQsfdNQmtwnjywiJdrDDZGrdeRLg3GZmIZTkkf/Aqa8Uq0VMoO9k13SgKNdz
	 AHOkvPX4Mm0ZmfvPdsagM02fOHsDoLZBAEKqZVOc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730885AbgGNSzf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 14:55:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:53156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730043AbgGNSz1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 14:55:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4CD8822282;
        Tue, 14 Jul 2020 18:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594752926;
        bh=fPe011OLFDAOSHoiDlWJVfsAghT2Lhh8LX4jqLUHjJs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lvvp6rqcyJYdDkWt+mhIVrgWp4NgSOnYfpSE29H7iBuUd8jkoGclcGFjFUQUGnM9q
         +JEY3LqcKV0JZJQqnQ+rZ2X/aJju47oHEwlFebLS2NfByeyNAIfdZus7g42t4ekK7r
         RueTRy0VaVuycy36qvqmCLbl/5dVS0PlDeU//w/4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 026/166] powerpc/kvm/book3s64: Fix kernel crash with nested kvm & DEBUG_VIRTUAL
Date:   Tue, 14 Jul 2020 20:43:11 +0200
Message-Id: <20200714184117.137205413@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200714184115.844176932@linuxfoundation.org>
References: <20200714184115.844176932@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

[ Upstream commit c1ed1754f271f6b7acb1bfdc8cfb62220fbed423 ]

With CONFIG_DEBUG_VIRTUAL=y, __pa() checks for addr value and if it's
less than PAGE_OFFSET it leads to a BUG().

  #define __pa(x)
  ({
  	VIRTUAL_BUG_ON((unsigned long)(x) < PAGE_OFFSET);
  	(unsigned long)(x) & 0x0fffffffffffffffUL;
  })

  kernel BUG at arch/powerpc/kvm/book3s_64_mmu_radix.c:43!
  cpu 0x70: Vector: 700 (Program Check) at [c0000018a2187360]
      pc: c000000000161b30: __kvmhv_copy_tofrom_guest_radix+0x130/0x1f0
      lr: c000000000161d5c: kvmhv_copy_from_guest_radix+0x3c/0x80
  ...
  kvmhv_copy_from_guest_radix+0x3c/0x80
  kvmhv_load_from_eaddr+0x48/0xc0
  kvmppc_ld+0x98/0x1e0
  kvmppc_load_last_inst+0x50/0x90
  kvmppc_hv_emulate_mmio+0x288/0x2b0
  kvmppc_book3s_radix_page_fault+0xd8/0x2b0
  kvmppc_book3s_hv_page_fault+0x37c/0x1050
  kvmppc_vcpu_run_hv+0xbb8/0x1080
  kvmppc_vcpu_run+0x34/0x50
  kvm_arch_vcpu_ioctl_run+0x2fc/0x410
  kvm_vcpu_ioctl+0x2b4/0x8f0
  ksys_ioctl+0xf4/0x150
  sys_ioctl+0x28/0x80
  system_call_exception+0x104/0x1d0
  system_call_common+0xe8/0x214

kvmhv_copy_tofrom_guest_radix() uses a NULL value for to/from to
indicate direction of copy.

Avoid calling __pa() if the value is NULL to avoid the BUG().

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
[mpe: Massage change log a bit to mention CONFIG_DEBUG_VIRTUAL]
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/20200611120159.680284-1-aneesh.kumar@linux.ibm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/kvm/book3s_64_mmu_radix.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s_64_mmu_radix.c b/arch/powerpc/kvm/book3s_64_mmu_radix.c
index d4e532a63f08e..2f27faf24b2cb 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_radix.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_radix.c
@@ -40,7 +40,8 @@ unsigned long __kvmhv_copy_tofrom_guest_radix(int lpid, int pid,
 	/* Can't access quadrants 1 or 2 in non-HV mode, call the HV to do it */
 	if (kvmhv_on_pseries())
 		return plpar_hcall_norets(H_COPY_TOFROM_GUEST, lpid, pid, eaddr,
-					  __pa(to), __pa(from), n);
+					  (to != NULL) ? __pa(to): 0,
+					  (from != NULL) ? __pa(from): 0, n);
 
 	quadrant = 1;
 	if (!pid)
-- 
2.25.1



