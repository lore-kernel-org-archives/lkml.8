Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B68C2C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7952B2078D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591658190;
	bh=vmoLWAo5KLzzGbl+cpVVg7fwErGmTejbl4EZpzONxoA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0QP0j8H6kXZiSJrNp1dRL873EH2JDlcnSMzvDe0r+n2aXzQqxOOSfWExdfhuORC6O
	 dkkhQ+U9kTvK4rYle1sIw0PTDLfGPz604tlbyn6N2diRxewKgzm7BTWN5DNHE51wWC
	 DwhOecTixOHxfLhqa1QKfI9KrNBGSWLaWFIoeSfk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730243AbgFHXQ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 19:16:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:33534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728902AbgFHXNl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:13:41 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C45F2151B;
        Mon,  8 Jun 2020 23:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591658021;
        bh=vmoLWAo5KLzzGbl+cpVVg7fwErGmTejbl4EZpzONxoA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0wpvdC/w4L1YEwSMIfik8HA7QNpDPBzj5Zc7VssXz4qtZR6FCFhWKSpQ5/cwABZvW
         bqq01F2uzEhh7zDqZ5GE4bm5+QZSeP0XxYOqpa00sAtqaMte8nipR4of/FDbtmI+UQ
         yhqxbn2MOOBwcP8++wHlFuEM+3Z21RbdEJpkQ5ok=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jim Mattson <jmattson@google.com>, Jue Wang <juew@google.com>,
        Peter Shier <pshier@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kvm@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 074/606] KVM: x86: Fix off-by-one error in kvm_vcpu_ioctl_x86_setup_mce
Date:   Mon,  8 Jun 2020 19:03:19 -0400
Message-Id: <20200608231211.3363633-74-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608231211.3363633-1-sashal@kernel.org>
References: <20200608231211.3363633-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jim Mattson <jmattson@google.com>

commit c4e0e4ab4cf3ec2b3f0b628ead108d677644ebd9 upstream.

Bank_num is a one-based count of banks, not a zero-based index. It
overflows the allocated space only when strictly greater than
KVM_MAX_MCE_BANKS.

Fixes: a9e38c3e01ad ("KVM: x86: Catch potential overrun in MCE setup")
Signed-off-by: Jue Wang <juew@google.com>
Signed-off-by: Jim Mattson <jmattson@google.com>
Reviewed-by: Peter Shier <pshier@google.com>
Message-Id: <20200511225616.19557-1-jmattson@google.com>
Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/x86.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 56a21dd7c1a0..7f3371a39ed0 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3739,7 +3739,7 @@ static int kvm_vcpu_ioctl_x86_setup_mce(struct kvm_vcpu *vcpu,
 	unsigned bank_num = mcg_cap & 0xff, bank;
 
 	r = -EINVAL;
-	if (!bank_num || bank_num >= KVM_MAX_MCE_BANKS)
+	if (!bank_num || bank_num > KVM_MAX_MCE_BANKS)
 		goto out;
 	if (mcg_cap & ~(kvm_mce_cap_supported | 0xff | 0xff0000))
 		goto out;
-- 
2.25.1

