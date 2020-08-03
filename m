Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BED7C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:38:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D1B9204EC
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596458316;
	bh=N9pC0y8ia7HAFIP+qsQdo12QqCgv5yaYu1BWaAETZIE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=L/TqdXrwQenPpQCem94dMP+1lEK9vZpkjh3nsWQ9/XJyxHbCpLkS5rNBQjt6jtm8K
	 ma1FqXYqFWKk3hDZAywm5S287TZnnAwItIA55QWse1498ax3LYLKa8JCBhF1Asjcep
	 9pxLBdcK0Nh4CE1hVJWnG4csFih4sV/fZxsICD/s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729006AbgHCMe1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 08:34:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:34184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729528AbgHCMeH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 08:34:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A629204EC;
        Mon,  3 Aug 2020 12:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596458046;
        bh=N9pC0y8ia7HAFIP+qsQdo12QqCgv5yaYu1BWaAETZIE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VBkEkNAM1C0dCe0mg/bnCkopg/XjKlAxEvnoYpJRMZs/lVC/9ISs9VaqDOA8czmIF
         +RPKM5FCzIbOjqUTjrgzDV+K5m3SKQbOIJ74iqk0rvd5pkb6dn9zg2qmopM+Poe2aM
         0p8Sx08aXABp9vMb94xbfZ3P2tGUIwwT5ZWSU9yM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 08/51] x86/kvm: Be careful not to clear KVM_VCPU_FLUSH_TLB bit
Date:   Mon,  3 Aug 2020 14:19:53 +0200
Message-Id: <20200803121849.869521189@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200803121849.488233135@linuxfoundation.org>
References: <20200803121849.488233135@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 8c6de56a42e0c657955e12b882a81ef07d1d073e ]

kvm_steal_time_set_preempted() may accidentally clear KVM_VCPU_FLUSH_TLB
bit if it is called more than once while VCPU is preempted.

This is part of CVE-2019-3016.

(This bug was also independently discovered by Jim Mattson
<jmattson@google.com>)

Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Reviewed-by: Joao Martins <joao.m.martins@oracle.com>
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/x86.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 09f47c837c258..3aed03942d7d4 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3075,6 +3075,9 @@ static void kvm_steal_time_set_preempted(struct kvm_vcpu *vcpu)
 	if (!(vcpu->arch.st.msr_val & KVM_MSR_ENABLED))
 		return;
 
+	if (vcpu->arch.st.steal.preempted)
+		return;
+
 	vcpu->arch.st.steal.preempted = 1;
 
 	kvm_write_guest_offset_cached(vcpu->kvm, &vcpu->arch.st.stime,
-- 
2.25.1



