Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE21C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 451FD20733
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581339389;
	bh=evifrWkT2Z0Yki/6O4b+V1Z5s99CuQPgLJk5Bx1nAzk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UBlNWcOfskQR7FmQD0x14vij9mSS0sc3rln35IhsEd5a2+RymMC/+Wp2PL7lV7Uxj
	 TBMpFG+BgLY6u72LQMu3gXNT4cb6ahgeWkcUT3nY4mv34VGpam8YBaxs9AQ5eyLD65
	 r2mzGJmzblYu6EYyw2MsH7pKOqtQpRFg5sJhF9t0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730158AbgBJM42 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 07:56:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:44366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730041AbgBJMlj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:41:39 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1CA30208C4;
        Mon, 10 Feb 2020 12:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338499;
        bh=evifrWkT2Z0Yki/6O4b+V1Z5s99CuQPgLJk5Bx1nAzk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1JNi4r0DEwTmq2K2Du2+xe7E7BsbYTrErmNjIcC7Bs8U5LUeUHZPcrfBllVuMeNY3
         Es6ipVY1Q/+gv4cwTgamq0OfW+pMRupPf+HSSl0kbTf1CJSlFNSkue+zaiIa2WHNdV
         Ra94IaKoTWe8faL4KmKo6GPEwJhh/PUoPNg8dilg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 5.5 251/367] KVM: VMX: Add non-canonical check on writes to RTIT address MSRs
Date:   Mon, 10 Feb 2020 04:32:44 -0800
Message-Id: <20200210122447.361284302@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122423.695146547@linuxfoundation.org>
References: <20200210122423.695146547@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Christopherson <sean.j.christopherson@intel.com>

commit fe6ed369fca98e99df55c932b85782a5687526b5 upstream.

Reject writes to RTIT address MSRs if the data being written is a
non-canonical address as the MSRs are subject to canonical checks, e.g.
KVM will trigger an unchecked #GP when loading the values to hardware
during pt_guest_enter().

Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/vmx/vmx.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -2146,6 +2146,8 @@ static int vmx_set_msr(struct kvm_vcpu *
 			(index >= 2 * intel_pt_validate_cap(vmx->pt_desc.caps,
 					PT_CAP_num_address_ranges)))
 			return 1;
+		if (is_noncanonical_address(data, vcpu))
+			return 1;
 		if (index % 2)
 			vmx->pt_desc.guest.addr_b[index / 2] = data;
 		else


