Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0EDEC2BB86
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 23:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87AF721974
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 23:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586646368;
	bh=pA1Sie9405Wws5fvI/KK2PQq77BoD4aOeYZELaLtP+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Y3a0gwJmuQrca2BNGW/mwk1eR8WuuyxwQVukbjuVQgEdB3OmWz36Go3GSNa0LDcPj
	 PJeR2vLxsHGvKsbWbhA2mZ/B9tbqemTxiOGJBBnCBjqz8zY8k4rJFOSOqHEktHTE/Z
	 UrtbWGhIHnR0jXNGITdEadbXvQz0h8Of8+hz4wf8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbgDKXGG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 19:06:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:41040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728247AbgDKXGF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 19:06:05 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0122520787;
        Sat, 11 Apr 2020 23:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586646365;
        bh=pA1Sie9405Wws5fvI/KK2PQq77BoD4aOeYZELaLtP+k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vmf9Bof/nS6WfGPjhj+kQ6JM0lAMqOpHKtjHD2CzBWMWQmjWOvTqlrFntKrnxfznw
         qL53gzbQx3ga27ok1zYcBlyzZLLpLP1ZmkviYk4wCMRfmo85btueOVAdkxYN0zVgna
         lF+37DkaoNLLrUqGcGqeNew9pDPPoJiKpExzaOf0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Laurent Dufour <ldufour@linux.ibm.com>,
        Bharata B Rao <bharata@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Ram Pai <linuxram@us.ibm.com>,
        Fabiano Rosas <farosas@linux.ibm.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Sasha Levin <sashal@kernel.org>, kvm-ppc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 5.6 109/149] KVM: PPC: Book3S HV: H_SVM_INIT_START must call UV_RETURN
Date:   Sat, 11 Apr 2020 19:03:06 -0400
Message-Id: <20200411230347.22371-109-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200411230347.22371-1-sashal@kernel.org>
References: <20200411230347.22371-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Laurent Dufour <ldufour@linux.ibm.com>

[ Upstream commit 377f02d487b5f74a2411fa01316ba4aff1819629 ]

When the call to UV_REGISTER_MEM_SLOT is failing, for instance because
there is not enough free secured memory, the Hypervisor (HV) has to call
UV_RETURN to report the error to the Ultravisor (UV). Then the UV will call
H_SVM_INIT_ABORT to abort the securing phase and go back to the calling VM.

If the kvm->arch.secure_guest is not set, in the return path rfid is called
but there is no valid context to get back to the SVM since the Hcall has
been routed by the Ultravisor.

Move the setting of kvm->arch.secure_guest earlier in
kvmppc_h_svm_init_start() so in the return path, UV_RETURN will be called
instead of rfid.

Cc: Bharata B Rao <bharata@linux.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>
Reviewed-by: Ram Pai <linuxram@us.ibm.com>
Tested-by: Fabiano Rosas <farosas@linux.ibm.com>
Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/kvm/book3s_hv_uvmem.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s_hv_uvmem.c b/arch/powerpc/kvm/book3s_hv_uvmem.c
index 79b1202b1c628..68dff151315cb 100644
--- a/arch/powerpc/kvm/book3s_hv_uvmem.c
+++ b/arch/powerpc/kvm/book3s_hv_uvmem.c
@@ -209,6 +209,8 @@ unsigned long kvmppc_h_svm_init_start(struct kvm *kvm)
 	int ret = H_SUCCESS;
 	int srcu_idx;
 
+	kvm->arch.secure_guest = KVMPPC_SECURE_INIT_START;
+
 	if (!kvmppc_uvmem_bitmap)
 		return H_UNSUPPORTED;
 
@@ -233,7 +235,6 @@ unsigned long kvmppc_h_svm_init_start(struct kvm *kvm)
 			goto out;
 		}
 	}
-	kvm->arch.secure_guest |= KVMPPC_SECURE_INIT_START;
 out:
 	srcu_read_unlock(&kvm->srcu, srcu_idx);
 	return ret;
-- 
2.20.1

