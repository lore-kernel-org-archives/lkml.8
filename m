Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ED95C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E265B2085B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581341508;
	bh=3RpGryatGBCq6S5c0B9vkCb178y4CrEyAAo+c/YCQ+s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CrpV0cPvOmGAP+gXaM64uOVxjetLnOc3mRDHXOZ1HBbPdEvwWX6yTSVN+aZg99iup
	 QZMoFmQF+91mNtKIFJDlNd6/vxPMwytg1Kv5A6Vn/LMa51jL7nBvbUc4r++0gm7D0W
	 R88RkUWS8nUUPlIVw4aXiYiEOdXd8hqYi/EUeZ8A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731377AbgBJNbr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 08:31:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:54184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728192AbgBJMf6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:35:58 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C72C120863;
        Mon, 10 Feb 2020 12:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338157;
        bh=3RpGryatGBCq6S5c0B9vkCb178y4CrEyAAo+c/YCQ+s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E03FGZHbYgXMiiBBufuTIw0SnYEFZlRf7wQvuNBZByuKSbg73/kmgsSFGk/hX6xqs
         5EDCl52cQTQ95XwC3b5javU+5cUyLJe6dgjDPUkmtYb/ttFr9QOGY2cVJizkA8uxSt
         9wn+248xTq53iGviIKFif2d392jOZZKTSPiQbsQM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nick Finco <nifi@google.com>,
        Marios Pomonis <pomonis@google.com>,
        Andrew Honig <ahonig@google.com>,
        Jim Mattson <jmattson@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.19 126/195] KVM: x86: Protect DR-based index computations from Spectre-v1/L1TF attacks
Date:   Mon, 10 Feb 2020 04:33:04 -0800
Message-Id: <20200210122317.689295109@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122305.731206734@linuxfoundation.org>
References: <20200210122305.731206734@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marios Pomonis <pomonis@google.com>

commit ea740059ecb37807ba47b84b33d1447435a8d868 upstream.

This fixes a Spectre-v1/L1TF vulnerability in __kvm_set_dr() and
kvm_get_dr().
Both kvm_get_dr() and kvm_set_dr() (a wrapper of __kvm_set_dr()) are
exported symbols so KVM should tream them conservatively from a security
perspective.

Fixes: 020df0794f57 ("KVM: move DR register access handling into generic code")

Signed-off-by: Nick Finco <nifi@google.com>
Signed-off-by: Marios Pomonis <pomonis@google.com>
Reviewed-by: Andrew Honig <ahonig@google.com>
Cc: stable@vger.kernel.org
Reviewed-by: Jim Mattson <jmattson@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/x86.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -961,9 +961,11 @@ static u64 kvm_dr6_fixed(struct kvm_vcpu
 
 static int __kvm_set_dr(struct kvm_vcpu *vcpu, int dr, unsigned long val)
 {
+	size_t size = ARRAY_SIZE(vcpu->arch.db);
+
 	switch (dr) {
 	case 0 ... 3:
-		vcpu->arch.db[dr] = val;
+		vcpu->arch.db[array_index_nospec(dr, size)] = val;
 		if (!(vcpu->guest_debug & KVM_GUESTDBG_USE_HW_BP))
 			vcpu->arch.eff_db[dr] = val;
 		break;
@@ -1000,9 +1002,11 @@ EXPORT_SYMBOL_GPL(kvm_set_dr);
 
 int kvm_get_dr(struct kvm_vcpu *vcpu, int dr, unsigned long *val)
 {
+	size_t size = ARRAY_SIZE(vcpu->arch.db);
+
 	switch (dr) {
 	case 0 ... 3:
-		*val = vcpu->arch.db[dr];
+		*val = vcpu->arch.db[array_index_nospec(dr, size)];
 		break;
 	case 4:
 		/* fall through */


