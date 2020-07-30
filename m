Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E6EBC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 10:34:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 796402075F
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 10:34:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jwFK2Uoa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ihc2Fyuc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729009AbgG3Ker (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 06:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbgG3Keq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 06:34:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 292D3C061794;
        Thu, 30 Jul 2020 03:34:46 -0700 (PDT)
Date:   Thu, 30 Jul 2020 10:34:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596105284;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hu8K0lEmTpVCuDSPeCbbvbJVVrXge13M0xm2T41HKKM=;
        b=jwFK2UoaHNwl+c8ZfFIcX9uXFSWTZ77gw9Lna9tyS7NekiC6KsOWi0IV2UKYaXfBwhhi7X
        5VKrJchsxaf/2+NGchh28zVF2n7HsqiE7rxm3ZIYkf1YupOngn4C5frsVh2kumurhleIVy
        BUz14LIzSYIBge0RbJxfuzUGnacEU80nWly5BiR292q6lQVnc+nhQW0thHJEDiqi2JqC/+
        AA1PMPITDiFKq6ud0rzD1LoB/dvkJS5dMsUcvCQSw8LnsuVSu4zCoUm2ylnUdos1aBmn4U
        swJ+/F5rkKecJEYo3sQnilO0/PGZ+AydpWhQAoIFNrjmx/LaakYqzDjroytd6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596105284;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hu8K0lEmTpVCuDSPeCbbvbJVVrXge13M0xm2T41HKKM=;
        b=ihc2FyucQ1Ypbr/v0/RGzH9FPwfKqlQ1upNiTYAReiEyZ88lQGq8Lgjg6rInmc/+6Fbbwd
        bERiJGPYcRPZDBDQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/kvm: Use __xfer_to_guest_mode_work_pending() in
 kvm_run_vcpu()
Cc:     Qian Cai <cai@lca.pw>, Thomas Gleixner <tglx@linutronix.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <87bljxa2sa.fsf@nanos.tec.linutronix.de>
References: <87bljxa2sa.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Message-ID: <159610528353.4006.8299813904303562704.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam: Yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     f3020b8891b890b48d9e1a83241e3cce518427c1
Gitweb:        https://git.kernel.org/tip/f3020b8891b890b48d9e1a83241e3cce518427c1
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 30 Jul 2020 09:19:01 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 30 Jul 2020 12:31:47 +02:00

x86/kvm: Use __xfer_to_guest_mode_work_pending() in kvm_run_vcpu()

The comments explicitely explain that the work flags check and handling in
kvm_run_vcpu() is done with preemption and interrupts enabled as KVM
invokes the check again right before entering guest mode with interrupts
disabled which guarantees that the work flags are observed and handled
before VMENTER.

Nevertheless the flag pending check in kvm_run_vcpu() uses the helper
variant which requires interrupts to be disabled triggering an instant
lockdep splat. This was caught in testing before and then not fixed up in
the patch before applying. :(

Use the relaxed and intentionally racy __xfer_to_guest_mode_work_pending()
instead.

Fixes: 72c3c0fe54a3 ("x86/kvm: Use generic xfer to guest work function")
Reported-by: Qian Cai <cai@lca.pw> writes:
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/87bljxa2sa.fsf@nanos.tec.linutronix.de


---
 arch/x86/kvm/x86.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 82d4a9e..5325972 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8682,7 +8682,7 @@ static int vcpu_run(struct kvm_vcpu *vcpu)
 			break;
 		}
 
-		if (xfer_to_guest_mode_work_pending()) {
+		if (__xfer_to_guest_mode_work_pending()) {
 			srcu_read_unlock(&kvm->srcu, vcpu->srcu_idx);
 			r = xfer_to_guest_mode_handle_work(vcpu);
 			if (r)
