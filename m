Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C3FFC2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71ADB20675
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581607996;
	bh=fPB1iHhgeFpUPKsYjqf2vZYkXrit/70jiBZ3Dsfo/pk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=G/D2Fg4YJ4UBATAyJhpoSqBjXDd2+/FXwyvIJv+9mILjyU5h35x9vlNJtsqPY08uI
	 GroBWg7lwb5x05cq5d5IOZpZGH3p6iW8q99vDKPc3nreJ8dvyfdD4Q3jpl7tA5jJaf
	 Qll4JnqsuLRcwKabAW7SGIoaQvfh+oSPD8Tc7tXk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729238AbgBMPdP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:33:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:57840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729630AbgBMP24 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:28:56 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 692692467D;
        Thu, 13 Feb 2020 15:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607736;
        bh=fPB1iHhgeFpUPKsYjqf2vZYkXrit/70jiBZ3Dsfo/pk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RuHVsARH3l9mYKC2OIRNahDJE2/UtzIzEDLVOh1ZOZ58lh/Ie4xn3Qi/dOY2p70+t
         ewHnmi+FnRqZmMKxWh+/qy06ylQAFQ75xg6802c5Gmz3o6/ERk+DQ/oJmypCAMEPpn
         56N4o2CCjPnzR4O1BWU8uxTip9AYEWk6kLSxAkho=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Auger <eric.auger@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Andrew Murray <andrew.murray@arm.com>
Subject: [PATCH 5.5 088/120] KVM: arm64: pmu: Dont increment SW_INCR if PMCR.E is unset
Date:   Thu, 13 Feb 2020 07:21:24 -0800
Message-Id: <20200213151930.882972327@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151901.039700531@linuxfoundation.org>
References: <20200213151901.039700531@linuxfoundation.org>
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


