Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6379C34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 20:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B64BD21D56
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 20:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582056198;
	bh=Q1xkFydBbWJIb3KftKavEfiznyZtcB2ryykPOajvrnI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jgFQh8n09n9UEqCL1jnbF4JMtzaBClQyNnjfbfcHA9Ars+evx9tPOTR0IwHBLaIOt
	 9zaQ7wP8x0igLtLsxClKqyJ3460TB76ch0HPcQB77I35b5d1U5GE8eqjYB6l7eS+yE
	 v43jNRMkODw5Iac7kK5cDN1WXOoXKU6d3zyFfnW0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729100AbgBRUDR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 15:03:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:44340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728871AbgBRUDN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 15:03:13 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B1222467A;
        Tue, 18 Feb 2020 20:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582056193;
        bh=Q1xkFydBbWJIb3KftKavEfiznyZtcB2ryykPOajvrnI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hNai7Qpx22A42h409DPmcrMOZe2wizxuDr4ispbEUyUs7/VmwKsuMNgy6kRWLNpQq
         NPypwz6PGrGcbY89SnXjFuY0mCE5aB/6NXLUV+8GIVyWdZb5Z/fNHMFXY73gymkY1a
         bnBaPaI8SGhpyC9qod9Xsy7XX/4lK77NjCfw8uPE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Oliver Upton <oupton@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 5.5 69/80] KVM: x86: Mask off reserved bit from #DB exception payload
Date:   Tue, 18 Feb 2020 20:55:30 +0100
Message-Id: <20200218190438.532451378@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200218190432.043414522@linuxfoundation.org>
References: <20200218190432.043414522@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oliver Upton <oupton@google.com>

commit 307f1cfa269657c63cfe2c932386fcc24684d9dd upstream.

KVM defines the #DB payload as compatible with the 'pending debug
exceptions' field under VMX, not DR6. Mask off bit 12 when applying the
payload to DR6, as it is reserved on DR6 but not the 'pending debug
exceptions' field.

Fixes: f10c729ff965 ("kvm: vmx: Defer setting of DR6 until #DB delivery")
Signed-off-by: Oliver Upton <oupton@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/x86.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -437,6 +437,14 @@ void kvm_deliver_exception_payload(struc
 		 * for #DB exceptions under VMX.
 		 */
 		vcpu->arch.dr6 ^= payload & DR6_RTM;
+
+		/*
+		 * The #DB payload is defined as compatible with the 'pending
+		 * debug exceptions' field under VMX, not DR6. While bit 12 is
+		 * defined in the 'pending debug exceptions' field (enabled
+		 * breakpoint), it is reserved and must be zero in DR6.
+		 */
+		vcpu->arch.dr6 &= ~BIT(12);
 		break;
 	case PF_VECTOR:
 		vcpu->arch.cr2 = payload;


