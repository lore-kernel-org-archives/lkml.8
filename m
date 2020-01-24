Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD82C35242
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 14:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22C222077C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 14:26:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q1lgZuCu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388069AbgAXO0G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 09:26:06 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40063 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2392226AbgAXO0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 09:26:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579875962;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BcYl7Hnv7p+sg1oHvBDUntuXOOPjc9pGbSFE7rJ89fY=;
        b=Q1lgZuCu1PRT1C89oBwuDG+EJom1wJCUCIkTGwDBTKiljgEoMC1ibQB7vjI+e6hHtTppyy
        goeU203ZJbSRKPwM1F8kt+Mp0c/9pVwqZVfA4La6Tjg2Vi8Xg1SeIs+VFIuY9/Zn9dW6hG
        O1BIFmgT91vc16PEwaLBiz0XtHOOrRQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-n7u0JYvMN36UujCAySSk7w-1; Fri, 24 Jan 2020 09:26:01 -0500
X-MC-Unique: n7u0JYvMN36UujCAySSk7w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6DCF4477;
        Fri, 24 Jan 2020 14:25:59 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-37.ams2.redhat.com [10.36.116.37])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4492A19C69;
        Fri, 24 Jan 2020 14:25:55 +0000 (UTC)
From:   Eric Auger <eric.auger@redhat.com>
To:     eric.auger.pro@gmail.com, eric.auger@redhat.com, maz@kernel.org,
        linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu
Cc:     andrew.murray@arm.com
Subject: [PATCH 4/4] KVM: arm64: pmu: Only handle supported event counters
Date:   Fri, 24 Jan 2020 15:25:35 +0100
Message-Id: <20200124142535.29386-5-eric.auger@redhat.com>
In-Reply-To: <20200124142535.29386-1-eric.auger@redhat.com>
References: <20200124142535.29386-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let the code never use unsupported event counters. Change
kvm_pmu_handle_pmcr() to only reset supported counters and
kvm_pmu_vcpu_reset() to only sto supported counters.

Other actions are filtered on the supported counters in
kvm/sysregs.c

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 virt/kvm/arm/pmu.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/virt/kvm/arm/pmu.c b/virt/kvm/arm/pmu.c
index 560db6282137..f0d0312c0a55 100644
--- a/virt/kvm/arm/pmu.c
+++ b/virt/kvm/arm/pmu.c
@@ -247,10 +247,11 @@ void kvm_pmu_vcpu_init(struct kvm_vcpu *vcpu)
  */
 void kvm_pmu_vcpu_reset(struct kvm_vcpu *vcpu)
 {
-	int i;
+	unsigned long mask =3D kvm_pmu_valid_counter_mask(vcpu);
 	struct kvm_pmu *pmu =3D &vcpu->arch.pmu;
+	int i;
=20
-	for (i =3D 0; i < ARMV8_PMU_MAX_COUNTERS; i++)
+	for_each_set_bit(i, &mask, 32)
 		kvm_pmu_stop_counter(vcpu, &pmu->pmc[i]);
=20
 	bitmap_zero(vcpu->arch.pmu.chained, ARMV8_PMU_MAX_COUNTER_PAIRS);
@@ -527,10 +528,9 @@ void kvm_pmu_software_increment(struct kvm_vcpu *vcp=
u, u64 val)
  */
 void kvm_pmu_handle_pmcr(struct kvm_vcpu *vcpu, u64 val)
 {
-	u64 mask;
+	unsigned long mask =3D kvm_pmu_valid_counter_mask(vcpu);
 	int i;
=20
-	mask =3D kvm_pmu_valid_counter_mask(vcpu);
 	if (val & ARMV8_PMU_PMCR_E) {
 		kvm_pmu_enable_counter_mask(vcpu,
 		       __vcpu_sys_reg(vcpu, PMCNTENSET_EL0) & mask);
@@ -542,7 +542,7 @@ void kvm_pmu_handle_pmcr(struct kvm_vcpu *vcpu, u64 v=
al)
 		kvm_pmu_set_counter_value(vcpu, ARMV8_PMU_CYCLE_IDX, 0);
=20
 	if (val & ARMV8_PMU_PMCR_P) {
-		for (i =3D 0; i < ARMV8_PMU_CYCLE_IDX; i++)
+		for_each_set_bit(i, &mask, 32)
 			kvm_pmu_set_counter_value(vcpu, i, 0);
 	}
 }
--=20
2.20.1

