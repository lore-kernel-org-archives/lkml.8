Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66838C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 06:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A4302075F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 06:19:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ADmgTQXd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728727AbgHYGTU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 02:19:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54905 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726015AbgHYGTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 02:19:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598336355;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=psiDVQpppxm+kCrD3RikguJd8ywmUxETau29dCApZ1s=;
        b=ADmgTQXd7j6mg3zhXm4sYMCXcNHT9orhQWRAeIN2KoiyqRA3ugyHu1LfS25QM9UGBcRqQl
        C1F6BYE9vJhFstmxID7fzmQx4dCrIzDnTYWeKvF/v0ZoTKacX2HoLg26fVv8vu3lduiIp3
        r1YlJBsMjsEEXVW+Kc8v2uGxjbd7qXE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-49-7N7HSzwhOpqsJFE6gdyLzw-1; Tue, 25 Aug 2020 02:19:12 -0400
X-MC-Unique: 7N7HSzwhOpqsJFE6gdyLzw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A6D551007467;
        Tue, 25 Aug 2020 06:19:11 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-33.bne.redhat.com [10.64.54.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E0528100AE5B;
        Tue, 25 Aug 2020 06:19:09 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     linux-kernel@vger.kernel.org, maz@kernel.org,
        suzuki.poulose@arm.com
Subject: [PATCH 2/2] arm64/kvm: Drop checking target CPU type on initializing module
Date:   Tue, 25 Aug 2020 16:18:56 +1000
Message-Id: <20200825061856.25382-2-gshan@redhat.com>
In-Reply-To: <20200825061856.25382-1-gshan@redhat.com>
References: <20200825061856.25382-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The target CPU type is validated when KVM module is initialized.
However, we always have a valid target CPU type since commit
<bca556ac468a> ("arm64/kvm: Add generic v8 KVM target").

So it's unnecessary to validate the target CPU type at that time
and this just drops it.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 arch/arm64/kvm/arm.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 691d21e4c717..faf4bc208a4a 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1561,11 +1561,6 @@ static int init_hyp_mode(void)
 	return err;
 }
 
-static void check_kvm_target_cpu(void *ret)
-{
-	*(int *)ret = kvm_target_cpu();
-}
-
 struct kvm_vcpu *kvm_mpidr_to_vcpu(struct kvm *kvm, unsigned long mpidr)
 {
 	struct kvm_vcpu *vcpu;
@@ -1625,7 +1620,6 @@ void kvm_arch_irq_bypass_start(struct irq_bypass_consumer *cons)
 int kvm_arch_init(void *opaque)
 {
 	int err;
-	int ret, cpu;
 	bool in_hyp_mode;
 
 	if (!is_hyp_mode_available()) {
@@ -1640,14 +1634,6 @@ int kvm_arch_init(void *opaque)
 		return -ENODEV;
 	}
 
-	for_each_online_cpu(cpu) {
-		smp_call_function_single(cpu, check_kvm_target_cpu, &ret, 1);
-		if (ret < 0) {
-			kvm_err("Error, CPU %d not supported!\n", cpu);
-			return -ENODEV;
-		}
-	}
-
 	err = init_common_resources();
 	if (err)
 		return err;
-- 
2.23.0

