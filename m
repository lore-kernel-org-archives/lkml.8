Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41EC4C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07D1E20661
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581608693;
	bh=fPB1iHhgeFpUPKsYjqf2vZYkXrit/70jiBZ3Dsfo/pk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ViHPWSVjj1kmbfDcibIdYZY4RmMShXFWc2jJrm8tR90L0uL7z2yUrF/YDw/HLQ/AQ
	 fDsFW0TJmZ4IOe6VQURz2sBQ3uGiRnajl7Mp2BqQdrDXbo/hzJ2aQxOXyZt6kE9bvh
	 Yq/4RUgB9QnRF9Qf7BGh4GKj9Ur6psHZzm/OLacE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729509AbgBMPow (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:44:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:51528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729454AbgBMP1g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:27:36 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 317F824670;
        Thu, 13 Feb 2020 15:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607656;
        bh=fPB1iHhgeFpUPKsYjqf2vZYkXrit/70jiBZ3Dsfo/pk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qah9WawN3PjLgiBRd5baoykMmNsh7wPzslr0jcH8H1c8M2DJWK6B2S5KT2R0yqmha
         tZhOksklqxdy9Nhf+QaLu40t2RQp7bXT2rAIbqog4IvtjPyb91kyraU9P+HFZKMJwa
         6gEZF5uJsjrGDvQZlHh5moLU7mZd4WPbx1VySYho=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Auger <eric.auger@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Andrew Murray <andrew.murray@arm.com>
Subject: [PATCH 5.4 71/96] KVM: arm64: pmu: Dont increment SW_INCR if PMCR.E is unset
Date:   Thu, 13 Feb 2020 07:21:18 -0800
Message-Id: <20200213151906.126388921@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151839.156309910@linuxfoundation.org>
References: <20200213151839.156309910@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Auger <eric.auger@redhat.com>

commit 3837407c1aa1101ed5e214c7d6041e7a23335c6e upstream.

The specification says PMSWINC increments PMEVCNTR<n>_EL1 by 1
if PMEVCNTR<n>_EL0 is enabled and configured to count SW_INCR.

For PMEVCNTR<n>_EL0 to be enabled, we need both PMCNTENSET to
be set for the corresponding event counter but we also need
the PMCR.E bit to be set.

Fixes: 7a0adc7064b8 ("arm64: KVM: Add access handler for PMSWINC register")
Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Andrew Murray <andrew.murray@arm.com>
Acked-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20200124142535.29386-2-eric.auger@redhat.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 virt/kvm/arm/pmu.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/virt/kvm/arm/pmu.c
+++ b/virt/kvm/arm/pmu.c
@@ -486,6 +486,9 @@ void kvm_pmu_software_increment(struct k
 	if (val == 0)
 		return;
 
+	if (!(__vcpu_sys_reg(vcpu, PMCR_EL0) & ARMV8_PMU_PMCR_E))
+		return;
+
 	enable = __vcpu_sys_reg(vcpu, PMCNTENSET_EL0);
 	for (i = 0; i < ARMV8_PMU_CYCLE_IDX; i++) {
 		if (!(val & BIT(i)))


