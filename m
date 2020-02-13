Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ED46C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:27:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F05BA20661
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581607636;
	bh=6jiThO6KwAUUZpDdP6OoahcnF7wU3KAVmYKEa7AhWX4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vUcBOYO9MIBZp0UjHeXGq/lrP9zQVug3bgNHqqvXcplh/JTluF59gyHSoy8YKH8ke
	 NfnpbOvVkg/6CPDW+r7g/LjZrwtgKRgNZUIv3g3BjtuoWJutzO0ZjA/FWjot9b6UUm
	 l4+yi3WSJ1iKnaQnlrj9wmWiOEUL0rbJlG+zftQ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729335AbgBMP1P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:27:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:40532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387424AbgBMPZR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:25:17 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67D1F246B5;
        Thu, 13 Feb 2020 15:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607516;
        bh=6jiThO6KwAUUZpDdP6OoahcnF7wU3KAVmYKEa7AhWX4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bMAR/8UwmibOc30kXCaxCm76btxO5+6ZmiU9yIcQw6E2PnH/FAzhEn14gzJ0oxZno
         GX5fZmoguO76+bqOpqip5GCbfF3XWmaKbVz+Hj8b+PDMCw/VqJoolXFDdzWpG5ba6i
         jBKM9EuFg4gZZewHiC2GwEqU5+G4DjJjRBj6oQpA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nick Finco <nifi@google.com>,
        Marios Pomonis <pomonis@google.com>,
        Andrew Honig <ahonig@google.com>,
        Jim Mattson <jmattson@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.14 080/173] KVM: x86: Protect DR-based index computations from Spectre-v1/L1TF attacks
Date:   Thu, 13 Feb 2020 07:19:43 -0800
Message-Id: <20200213151953.652740374@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151931.677980430@linuxfoundation.org>
References: <20200213151931.677980430@linuxfoundation.org>
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
@@ -924,9 +924,11 @@ static u64 kvm_dr6_fixed(struct kvm_vcpu
 
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
@@ -963,9 +965,11 @@ EXPORT_SYMBOL_GPL(kvm_set_dr);
 
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


