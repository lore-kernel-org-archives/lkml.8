Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05EE1C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C946D2467A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581338439;
	bh=a1x5KIPiysAsw/dzQhhYLOgGzN8IKYmOGr5d7X+Auh8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OXTNP1qufNrHKeelEWnmwFCIIGsSk+ooD9zC93g3Ny/zgN3C38z2Pc238aR5nu+KI
	 onTPryfHDV8gphVl6IUn0mi+d8T7hhW5j0JQvEaRjxG7RgCLmEAKfrBNvvEp0V1GAw
	 ehjkMIwDeSs0cYoTZIajW6VEgxEzEnGZTDHcXei0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729770AbgBJMki (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 07:40:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:33716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729128AbgBJMiX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:38:23 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B233520842;
        Mon, 10 Feb 2020 12:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338302;
        bh=a1x5KIPiysAsw/dzQhhYLOgGzN8IKYmOGr5d7X+Auh8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XMPmYzCvS6MmdSthZDJnSxqHV8Ci8ZC8OQayMSikQcJ+HWrCpynVIsOBZOTKL5v5j
         w2S7EAoeYyDII6dKyvC0RV9enJr4AdnRgoXV9x03Nepi53LvixY+6Yq/07bOcr2kdS
         /BV/QOjf2eyRygZR7OH+9CLoXmmarqlTmOwlT22U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 5.4 214/309] x86/kvm: Be careful not to clear KVM_VCPU_FLUSH_TLB bit
Date:   Mon, 10 Feb 2020 04:32:50 -0800
Message-Id: <20200210122427.098533996@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122406.106356946@linuxfoundation.org>
References: <20200210122406.106356946@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Boris Ostrovsky <boris.ostrovsky@oracle.com>

commit 8c6de56a42e0c657955e12b882a81ef07d1d073e upstream.

kvm_steal_time_set_preempted() may accidentally clear KVM_VCPU_FLUSH_TLB
bit if it is called more than once while VCPU is preempted.

This is part of CVE-2019-3016.

(This bug was also independently discovered by Jim Mattson
<jmattson@google.com>)

Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Reviewed-by: Joao Martins <joao.m.martins@oracle.com>
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/x86.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3499,6 +3499,9 @@ static void kvm_steal_time_set_preempted
 	if (!(vcpu->arch.st.msr_val & KVM_MSR_ENABLED))
 		return;
 
+	if (vcpu->arch.st.steal.preempted)
+		return;
+
 	vcpu->arch.st.steal.preempted = KVM_VCPU_PREEMPTED;
 
 	kvm_write_guest_offset_cached(vcpu->kvm, &vcpu->arch.st.stime,


