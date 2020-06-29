Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E961C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:51:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73561206A5
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593467502;
	bh=R2j6V0eZaLlrba2WbCE1v/ST4757gs8/EMzZo0IjirQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jfF5/bfuEb+YdCUaWTqYxwCuWwyXpkBoWCa1zzxh7vFpNet0iaYrMDQO8u5YYLAl2
	 UwZIRbCbEs4wEJ1AZDhBdZ7X+1e7PsqQ7U/56z6ri9cG5KNODCkRLDVamHBaN6P9CD
	 +8o7PI6i1bdVmQqMhlIG4Y0BMfqG2RJXWBXrsNZQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404565AbgF2Vvl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:51:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:56910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726663AbgF2Sfk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:35:40 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA4952479A;
        Mon, 29 Jun 2020 15:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593444105;
        bh=R2j6V0eZaLlrba2WbCE1v/ST4757gs8/EMzZo0IjirQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B1OviV8XQhH3uAJBDH2eMw9RXdFn+G6UwWSUG3wPMJuhb62mebPXPCgUXkA40SUD3
         2bJaN6Uhl1hpdCYwIKErV80N1WIJnNUfzcCg33+n+o2yT344dLGtzXhAS1tlTfpiAu
         OjG5q4TWYr1oWM3+tqYSGp6P9+n254akVMpDEdoU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Igor Mammedov <imammedo@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 5.7 216/265] kvm: lapic: fix broken vcpu hotplug
Date:   Mon, 29 Jun 2020 11:17:29 -0400
Message-Id: <20200629151818.2493727-217-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629151818.2493727-1-sashal@kernel.org>
References: <20200629151818.2493727-1-sashal@kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.7.7-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.7.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.7.7-rc1
X-KernelTest-Deadline: 2020-07-01T15:14+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Igor Mammedov <imammedo@redhat.com>

commit af28dfacbe00d53df5dec2bf50640df33138b1fe upstream.

Guest fails to online hotplugged CPU with error
  smpboot: do_boot_cpu failed(-1) to wakeup CPU#4

It's caused by the fact that kvm_apic_set_state(), which used to call
recalculate_apic_map() unconditionally and pulled hotplugged CPU into
apic map, is updating map conditionally on state changes.  In this case
the APIC map is not considered dirty and the is not updated.

Fix the issue by forcing unconditional update from kvm_apic_set_state(),
like it used to be.

Fixes: 4abaffce4d25a ("KVM: LAPIC: Recalculate apic map in batch")
Cc: stable@vger.kernel.org
Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20200622160830.426022-1-imammedo@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/lapic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 9af25c97612a7..8967e320a9784 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -2512,6 +2512,7 @@ int kvm_apic_set_state(struct kvm_vcpu *vcpu, struct kvm_lapic_state *s)
 	}
 	memcpy(vcpu->arch.apic->regs, s->regs, sizeof(*s));
 
+	apic->vcpu->kvm->arch.apic_map_dirty = true;
 	kvm_recalculate_apic_map(vcpu->kvm);
 	kvm_apic_set_version(vcpu);
 
-- 
2.25.1

