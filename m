Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C5F1C83007
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4778221835
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588098814;
	bh=WCHXzWwqAstatUoruqMOdtVKrthmhw+tUuchZIXN6P8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QDEtPBfUwYya4kBMFDRIIDcqhYIfofcXfm5IIREakuBvmrPCxAcZBMxJP5lYZALaM
	 6N1ij1rOQJNlkcgVn6YKdIUrK7YjUJmf25FGA7/bRvaRGu1VJoZmKmlBqOPao9LFN+
	 2VoxGlhguZQkvRpat18f3ZElNevJNfynCmBAMqFc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729949AbgD1Sd3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 14:33:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:49834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728933AbgD1SdZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 14:33:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C9C8D21835;
        Tue, 28 Apr 2020 18:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588098805;
        bh=WCHXzWwqAstatUoruqMOdtVKrthmhw+tUuchZIXN6P8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OqKo5NX4zU8nK30XVJVUsvVPs4AoGqe/4IOnop7vSGTUKCd/9YDRcy7by/aTYKH4Q
         lvgdK7jKKd1qQT8kO6XlGUrkgeEJVIFpPYlFmGC7w3mO8QuxFKbVYhDV1Nmxzozd1c
         GOrXMkZjIQvmAHo90Fq6RQ0WFFpOD3ek/6mHLAKI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Uros Bizjak <ubizjak@gmail.com>
Subject: [PATCH 5.6 114/167] KVM: VMX: Enable machine check support for 32bit targets
Date:   Tue, 28 Apr 2020 20:24:50 +0200
Message-Id: <20200428182239.628317549@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200428182225.451225420@linuxfoundation.org>
References: <20200428182225.451225420@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Uros Bizjak <ubizjak@gmail.com>

commit fb56baae5ea509e63c2a068d66a4d8ea91969fca upstream.

There is no reason to limit the use of do_machine_check
to 64bit targets. MCE handling works for both target familes.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: stable@vger.kernel.org
Fixes: a0861c02a981 ("KVM: Add VT-x machine check support")
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Message-Id: <20200414071414.45636-1-ubizjak@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/vmx/vmx.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -4571,7 +4571,7 @@ static int handle_rmode_exception(struct
  */
 static void kvm_machine_check(void)
 {
-#if defined(CONFIG_X86_MCE) && defined(CONFIG_X86_64)
+#if defined(CONFIG_X86_MCE)
 	struct pt_regs regs = {
 		.cs = 3, /* Fake ring 3 no matter what the guest ran on */
 		.flags = X86_EFLAGS_IF,


